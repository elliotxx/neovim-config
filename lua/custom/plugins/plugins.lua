--[[
Additional Plugins Configuration
------------------------------
Collection of plugins for enhanced Neovim experience
--]]

return {

  -- glepnir/lspsaga.nvim
  -- Improves the Neovim built-in LSP experience.
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {}
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },

  -- ThePrimeagen/refactoring.nvim
  -- Support for various common refactoring operations
  {
    'ThePrimeagen/refactoring.nvim',
    event = 'VeryLazy',
    config = function()
      require('refactoring').setup {
        prompt_func_return_type = {
          go = true,
          java = false,

          cpp = false,
          c = false,
          h = false,
          hpp = false,
          cxx = false,
        },
        prompt_func_param_type = {
          go = true,
          java = false,

          cpp = false,
          c = false,
          h = false,
          hpp = false,
          cxx = false,
        },
        printf_statements = {},
        print_var_statements = {},
      }
    end,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
  },

  -- stevearc/dressing.nvim
  -- Neovim plugin to improve the default vim.ui interfaces
  { 'stevearc/dressing.nvim' },

  -- text-case.nvim
  -- Enter `ga` to jump to which-key
  {
    'johmsalas/text-case.nvim',
    config = function()
      require('textcase').setup {}
    end,
  },

  -- folke/todo-comments.nvim
  -- todo-comments is a lua plugin for Neovim 0.5 to highlight and search for todo comments like TODO, HACK, BUG in your code base.
  {
    'folke/todo-comments.nvim',
    opts = {},
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
  },

  -- A simple word switch plugin with neovim
  -- Keymappings:
  -- The default mapping is gs to switch the word.
  { 'tandy1229/wordswitch.nvim' },

  -- https://github.com/echasnovski/mini.nvim
  -- Library of 35+ independent Lua modules improving overall
  -- Neovim (version 0.7 and higher) experience with minimal effort.
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      -- Show notifications
      -- require('mini.notify').setup {}
      -- Extend and create a/i textobjects
      require('mini.ai').setup {}

      -- Navigate and manipulate file system
      -- Keymappings:
      -- Toggle = '<leader>E'
      require('mini.files').setup {
        -- General options
        options = {
          -- Whether to use for editing directories
          use_as_default_explorer = false,
        },
        -- Customization of explorer windows
        windows = {
          -- Whether to show preview of file/directory under cursor
          preview = true,
          -- Width of preview window
          width_preview = 40,
        },
      }

      -- Move any selection in any direction
      -- Keymappings:
      -- -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      -- left = '<M-h>',
      -- right = '<M-l>',
      -- down = '<M-j>',
      -- up = '<M-k>',
      require('mini.move').setup {}

      -- Split and join arguments
      -- Keymappings:
      -- toggle = 'gS', -- Split if arguments are on single line, join
      -- otherwise.
      require('mini.splitjoin').setup {}

      -- Fast and feature-rich surround actions
      require('mini.surround').setup {
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          add = 'qa', -- Add surrounding in Normal and Visual modes
          delete = 'qd', -- Delete surrounding
          find = 'qf', -- Find surrounding (to the right)
          find_left = 'qF', -- Find surrounding (to the left)
          highlight = 'qh', -- Highlight surrounding
          replace = 'qr', -- Replace surrounding
          update_n_lines = 'qn', -- Update `n_lines`

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },
      }

      -- Setup statusline
      require('mini.statusline').setup {
        -- Use icons if Nerd Font is available
        use_icons = vim.g.have_nerd_font,
        -- Set content for statusline sections
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
            local git = MiniStatusline.section_git { trunc_width = 75 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local filename = MiniStatusline.section_filename { trunc_width = 140 }
            local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
            local location = MiniStatusline.section_location { trunc_width = 75 }

            return MiniStatusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl, strings = { location } },
            }
          end,
        },
        -- Set statusline for inactive windows
        set_vim_settings = true,
      }
    end,
  },

  -- Cursor smear effect
  {
    'sphamba/smear-cursor.nvim',
    event = 'VeryLazy', -- Load when needed
    opts = {
      -- Default options are good for most users
      cursor_smear = {
        enable = true,
        rate = 50, -- Lower value = faster update
        threshold = 0.1, -- Minimum movement threshold
      },
    },
  },

  -- https://github.com/folke/snacks.nvim
  -- 🍿 A collection of small QoL plugins for Neovim
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = require('custom.dashboard').config,
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = {
        enabled = true,
        -- 左侧配置：移除 sign 组件以避免灯泡显示在行号左侧
        left = { 'mark' },
        -- 右侧配置：默认，包含 fold 和 git signs
        -- right = { 'fold', 'git' },
      },
      words = { enabled = true },
    },
  },

  -- https://github.com/ibhagwan/fzf-lua
  -- Improved fzf.vim written in lua
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- calling `setup` is optional for customization
      require('fzf-lua').setup {
        -- 处理中文文件名的配置
        files = {
          cmd = 'fd --type f --hidden --follow --exclude .git --exclude node_modules --color=always',
          multipart = true,
        },
        git = {
          status = {
            cmd = 'git -c core.quotepath=false status --short --untracked-files=all',
            previewer = 'builtin',
          },
        },
        -- 确保 fzf 命令使用正确的编码
        fzf_opts = {
          ['--ansi'] = '',
          ['--unicode'] = '',
        },
        -- 处理文件名中的特殊字符
        file_icons = true,
        git_icons = true,
      }
    end,
  },

  -- https://github.com/elliotxx/copypath.nvim
  -- Copy path with line number, supporting both local paths and repository URLs.
  {
    'elliotxx/copypath.nvim',
    opts = {
      default_mappings = true, -- Set to false to disable default mappings
      mapping = 'Y', -- Default mapping to trigger copy
      notify = true, -- Show notification when path is copied
    },
  },

  -- https://github.com/yetone/avante.nvim (已注释)
  -- Use your Neovim like using Cursor AI IDE!
  -- {
  --   'yetone/avante.nvim',
  --   event = 'VeryLazy',
  --   lazy = false,
  --   version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
  --   opts = {
  --     provider = 'openai',
  --     openai = {
  --       -- endpoint = 'https://api.deepseek.com/',
  --       -- model = 'deepseek-chat',
  --       endpoint = 'https://api.siliconflow.cn/',
  --       model = 'deepseek-ai/DeepSeek-R1-Distill-Qwen-14B',
  --       temperature = 0,
  --       max_tokens = 4096,
  --     },
  --     behaviour = {
  --       auto_suggestions = false, -- Experimental stage
  --       auto_set_highlight_group = true,
  --       auto_set_keymaps = true,
  --       auto_apply_diff_after_generation = false,
  --       support_paste_from_clipboard = true,
  --       minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = 'make',
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     'stevearc/dressing.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'MunifTanjim/nui.nvim',
  --     --- The below dependencies are optional,
  --     'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
  --     'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
  --     'zbirenbaum/copilot.lua', -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       'HakonHarnes/img-clip.nvim',
  --       event = 'VeryLazy',
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       'OXY2DEV/markview.nvim',
  --       enabled = true,
  --       lazy = false,
  --       ft = { 'markdown', 'norg', 'rmd', 'org', 'vimwiki', 'Avante' },
  --       opts = {
  --         filetypes = { 'markdown', 'norg', 'rmd', 'org', 'vimwiki', 'Avante' },
  --         buf_ignore = {},
  --         max_length = 99999,
  --       },
  --     },
  --   },
  -- },

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
        { key = 'c4', name = 'GLM-4.7 (矽塔)', file = 'Antchat_ST_GLM-4.7_GLM-4.7.json' },
        { key = 'c5', name = 'MiniMax-M2.1 (矽塔)', file = 'Antchat_ST_MiniMax-M2.1.json' },
        { key = 'c6', name = 'Kimi-K2.5 (灵汐)', file = 'Antchat_LX_Kimi-K2.5.json' },
        { key = 'c7', name = 'GLM-4.7 (灵汐)', file = 'Antchat_LX_GLM-4.7_GLM-4.7.json' },
        { key = 'c8', name = 'MiniMax-M2.1 (灵汐)', file = 'Antchat_LX_MiniMax-M2.1.json' },
        { key = 'c9', name = 'DeepSeek-V3.2 (灵汐)', file = 'Antchat_LX_DeepSeek-V3.2.json' },
        { key = 'c10', name = 'MiniMax 2.1 (MiniMax)', file = 'Minimax_MiniMax-M2.1.json' },
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

  -- https://github.com/folke/noice.nvim
  -- 💥 Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
    },
  },

  -- https://github.com/kdheepak/lazygit.nvim
  -- LazyGit integration for Neovim
  {
    'kdheepak/lazygit.nvim',
    cmd = 'LazyGit',
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- https://github.com/sindrets/diffview.nvim
  -- Diffview plugin for Neovim
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('diffview').setup {
        view = {
          merge_tool = {
            layout = 'diff3_mixed',
            disable_diagnostics = true,
          },
        },
        file_panel = {
          win_config = {
            position = 'left',
            width = 35,
          },
        },
      }
    end,
  },
}
