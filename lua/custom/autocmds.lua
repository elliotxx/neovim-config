--[[
  Custom Autocommands
  -------------------
  自动清理终端进程和 Claude Code/MCP 服务器
]]

local M = {}

-- 终止 Neovim 终端中启动的所有子进程
local function kill_all_terminal_jobs()
  -- 获取所有终端缓冲区并终止其作业
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
      local job_pid = vim.b[buf].terminal_job_pid
      if job_pid then
        -- 使用 kill 命令终止进程组
        vim.fn.jobstart('kill -9 -' .. job_pid, { detach = true })
      end
    end
  end
end

-- 清理 Claude Code 相关进程（更精确的匹配）
local function clean_claude_processes()
  -- 匹配 claude 或 claude-code 进程，排除 grep 自身
  vim.fn.jobstart(
    "ps aux | grep -E '[c]laude(-code)?' | awk '{print $2}' | xargs -r kill -9 2>/dev/null",
    { detach = true }
  )
end

-- 清理 MCP 服务器进程
local function clean_mcp_processes()
  -- 匹配常见的 MCP 服务器进程名
  vim.fn.jobstart(
    "ps aux | grep -E '[m]cp-[a-z]+' | awk '{print $2}' | xargs -r kill -9 2>/dev/null",
    { detach = true }
  )
end

-- 清理所有已知的终端启动的后台进程
local function cleanup_all_background_processes()
  -- 先用 pkill 模糊匹配清理大部分 MCP 相关进程
  local fuzzy_patterns = {
    'chrome-devtools-mcp',
    'playwright-mcp',
    'context7-mcp',
    'unsplash-mcp',
    'postgres-mcp',
    'minimax-coding-plan-mcp',
    'utoo-proxy',
    'fastmcp',
  }

  for _, pattern in ipairs(fuzzy_patterns) do
    vim.fn.jobstart(
      string.format("pkill -9 -f '%s' 2>/dev/null", pattern),
      { detach = true }
    )
  end

  -- 再用精确模式清理漏网之鱼
  local exact_patterns = {
    '[c]laude(-code)?',
    '[m]cp-[a-z]+',
    '[s]kylarkmcpserver',
    '[a]ntcodemcp',
    '[c]hange-framework-mcp',
    -- npm/npx 启动的 MCP
    'npm.*[e]xec.*[m]cp',
    'npx.*[m]cp',
    -- uv 启动的 MCP
    'uv.*[m]cp',
    'uvx.*[m]cp',
    -- Node 启动的 MCP（通过 npx 缓存）
    'node.*npx.*[m]cp',
  }

  for _, pattern in ipairs(exact_patterns) do
    vim.fn.jobstart(
      string.format("ps aux | grep '%s' | awk '{print $2}' | xargs -r kill -9 2>/dev/null", pattern),
      { detach = true }
    )
  end
end

function M.setup()
  local augroup = vim.api.nvim_create_augroup('custom-process-cleanup', { clear = true })

  -- 在 VimLeavePre 事件中清理所有终端作业和后台进程
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = augroup,
    callback = function()
      -- 先终止所有终端作业
      kill_all_terminal_jobs()
      -- 再清理已知的后台进程
      cleanup_all_background_processes()
    end,
    desc = '退出时清理所有终端进程和后台进程',
  })

  -- 在每个终端缓冲区关闭时清理
  vim.api.nvim_create_autocmd('TermClose', {
    group = augroup,
    callback = function(event)
      local job_pid = vim.b[event.buf].terminal_job_pid
      if job_pid then
        vim.defer_fn(function()
          pcall(vim.fn.jobstart, 'kill -9 -' .. job_pid, { detach = true })
        end, 50)
      end
    end,
    desc = '终端关闭时清理对应进程',
  })
end

return M
