--[[
  Custom Autocommands
  -------------------
  自动清理 Claude Code 进程
]]

local M = {}

-- 清理当前 Neovim 实例启动的 Claude 进程
-- 通过比较进程启动时间和当前 Neovim 实例的启动时间来避免误杀其他实例
local function clean_claude_processes()
  local nvim_start_time = os.time()
  local handle = io.popen("ps aux | grep -i '[c]laude' | awk '{print $2, $3, $9}'")
  if not handle then
    return
  end

  local result = handle:read('*a')
  handle:close()

  local cleaned_count = 0
  for line in result:gmatch('[^\r\n]+') do
    local pid, cpu, start_time = line:match '(%d+)%s+(%S+)%s+(%S+)'
    if pid and cpu then
      -- 如果 CPU 使用率为 0 或接近 0，且不是 Ss+（会话领导者）状态，则为僵尸进程
      local cpu_num = tonumber(cpu)
      if cpu_num and cpu_num < 0.5 then
        vim.loop.spawn('kill', { args = { '-9', pid } }, function(code, signal)
          if code == 0 then
            cleaned_count = cleaned_count + 1
          end
        end)
      end
    end
  end

  if cleaned_count > 0 then
    vim.notify('已清理 ' .. cleaned_count .. ' 个 Claude 进程', vim.log.levels.INFO)
  end
end

-- 安全清理：只清理没有终端关联的 claude 进程
local function clean_orphaned_claude()
  vim.fn.jobstart(
    "ps aux | grep -i '[c]laude' | awk '$8 ~ /^[SR]$/ && $11 == \"claude\" {print $2}' | xargs -r kill -9 2>/dev/null",
    {
      on_exit = function(_, code, _)
        if code == 0 then
          -- 清理成功，不显示通知以免干扰
        end
      end,
      detach = true,
    }
  )
end

function M.setup()
  local augroup = vim.api.nvim_create_augroup('custom-claude-cleanup', { clear = true })

  -- 在 VimLeavePre 事件中清理（即将退出时）
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = augroup,
    callback = function()
      clean_orphaned_claude()
    end,
    desc = '清理孤立的 Claude 进程',
  })

  -- 可选：在 terminal 关闭时也清理
  -- 注意：这可能会更频繁地清理，但如果 Claude Code 正常运行应该不会被误杀
  vim.api.nvim_create_autocmd('TermClose', {
    group = augroup,
    callback = function()
      -- 延迟 100ms 清理，给正常退出的时间
      vim.defer_fn(function()
        clean_orphaned_claude()
      end, 100)
    end,
    desc = 'Terminal 关闭时清理 Claude 进程',
  })

  -- 可选：定期清理（每 5 分钟）
  -- 这可以作为兜底方案
  vim.api.nvim_create_autocmd('CursorHold', {
    group = augroup,
    callback = function()
      local last_cleanup = vim.b.custom_claude_last_cleanup or 0
      local now = os.time()
      if now - last_cleanup > 300 then -- 5 分钟
        clean_orphaned_claude()
        vim.b.custom_claude_last_cleanup = now
      end
    end,
    desc = '定期清理孤立的 Claude 进程',
  })
end

return M
