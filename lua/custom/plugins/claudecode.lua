--[[
Claude Code Plugin Configuration
------------------------------
Integration with Claude Code CLI for AI-assisted coding
--]]

return {
  -- https://github.com/coder/claudecode.nvim
  -- Claude Code integration for Neovim
  {
    'coder/claudecode.nvim',
    dependencies = {
      'folke/snacks.nvim',
    },
    keys = function()
      local claude_providers = vim.env.HOME .. '/.cc-switch/provider-configs'
      local providers = {
        { key = 'c1', name = 'MiniMax-M2.1 (矽塔AG)', file = 'AG_MiniMax-M2.1.json' },
        { key = 'c2', name = 'Kimi-K2.5 (矽塔AG)', file = 'AG_Kimi-K2.5.json' },
        { key = 'c3', name = 'DeepSeek-V3.2 (矽塔)', file = 'Antchat_ST_DeepSeek-V3.2.json' },
        { key = 'c4', name = 'GLM-5 (矽塔)', file = 'Antchat_ST_GLM-5_GLM-5.json' },
        { key = 'c5', name = 'MiniMax-M2.1 (矽塔)', file = 'Antchat_ST_MiniMax-M2.1.json' },
        { key = 'c6', name = 'Kimi-K2.5 (灵汐)', file = 'Antchat_LX_Kimi-K2.5.json' },
        { key = 'c7', name = 'GLM-4.7 (灵汐)', file = 'Antchat_LX_GLM-4.7_GLM-4.7.json' },
        { key = 'c8', name = 'MiniMax-M2.1 (灵汐)', file = 'Antchat_LX_MiniMax-M2.1.json' },
        { key = 'c9', name = 'DeepSeek-V3.2 (灵汐)', file = 'Antchat_LX_DeepSeek-V3.2.json' },
        { key = 'c10', name = 'MiniMax 2.5 (MiniMax)', file = 'Minimax_MiniMax-M2.5.json' },
        { key = 'c11', name = 'glm-4.7 (智谱)', file = 'ZhipuGLM_glm-4.7.json' },
      }
      local keys = {}

      -- Provider 切换快捷键
      for _, p in ipairs(providers) do
        table.insert(keys, {
          '<leader>' .. p.key,
          '<cmd>ClaudeCode --settings ' .. claude_providers .. '/' .. p.file .. ' --dangerously-skip-permissions<cr>',
          desc = 'Claude: ' .. p.name,
          mode = { 'n', 'x' },
        })
      end

      -- 保留 Control + 逗号作为默认 provider 切换
      table.insert(keys, { '<C-,>', '<cmd>ClaudeCode --dangerously-skip-permissions<cr>', desc = 'Claude Code (默认)', mode = { 'n', 'x' } })

      -- 辅助功能
      table.insert(keys, { '<leader>a', nil, desc = 'AI/Claude' })
      table.insert(keys, { '<leader>ar', '<cmd>ClaudeCode --resume --dangerously-skip-permissions<cr>', desc = 'Resume Claude' })
      table.insert(keys, { '<leader>aC', '<cmd>ClaudeCode --continue --dangerously-skip-permissions<cr>', desc = 'Continue Claude' })
      table.insert(keys, { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add buffer' })
      table.insert(keys, { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send selection' })
      table.insert(keys, {
        '<leader>as',
        '<cmd>ClaudeCodeTreeAdd<cr>',
        desc = 'Add file',
        ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
      })
      -- Diff management
      table.insert(keys, { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' })
      table.insert(keys, { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' })

      return keys
    end,
    opts = {
      terminal = {
        ---@module "snacks"
        ---@type snacks.win.Config|{}
        snacks_win_opts = {
          position = 'float',
          width = 0.9,
          height = 0.9,
          keys = {
            claude_hide = {
              '<C-,>',
              function(self)
                self:hide()
              end,
              mode = 't',
              desc = 'Hide',
            },
          },
        },
      },
      -- 添加跳过权限检查的参数
      cli_args = '--dangerously-skip-permissions',
    },
  },
}

