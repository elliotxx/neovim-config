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

  -- folke/flash.nvim
  -- flash.nvim lets you navigate your code with search labels, enhanced character motions, and Treesitter integration.
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'o', 'x' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
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

  -- https://github.com/Exafunction/codeium.vim
  -- Free, ultrafast Copilot alternative for Vim and Neovim
  {
    'Exafunction/codeium.vim',
    commit = '289eb72',
    event = 'BufEnter',
    config = function()
      -- C-y will accept the suggestion completion of codeium.
      vim.keymap.set('i', '<C-;>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true })
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
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },

  -- https://github.com/OXY2DEV/markview.nvim
  -- ☄️ Highly customisable markdown(latex & inline html) previewer for Neovim
  {
    'OXY2DEV/markview.nvim',
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway

    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
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
      require('fzf-lua').setup {}
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
}
