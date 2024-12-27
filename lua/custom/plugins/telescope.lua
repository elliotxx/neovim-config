--[[
Telescope Configuration
---------------------
Fuzzy finder plugin configuration
--]]

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'ahmedkhalf/project.nvim',
  },
  cmd = 'Telescope',
  opts = {
    theme = 'dropdown',
    defaults = {
      -- UI elements
      prompt_prefix = '🔍 ',
      selection_caret = '❯ ',
      winblend = 10,
    },

    pickers = {
      find_files = {
        hidden = false, -- Show hidden files in find_files
        no_ignore = false, -- Show .gitignore files in find_files
        previewer = false,
        layout_config = {
          height = 0.4,
          prompt_position = 'top',
          preview_width = 0.6,
        },
      },
      live_grep = {
        additional_args = function()
          return { '--hidden' } -- Show hidden files in live_grep
        end,
        previewer = true,
        layout_config = {
          horizontal = {
            preview_width = 0.6,
          },
        },
      },
    },

    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
      projects = {
        hidden_files = false,
        theme = 'dropdown',
      },
    },
  },
  config = function(_, opts)
    local telescope = require 'telescope'
    telescope.setup(opts)

    -- Load extensions
    telescope.load_extension 'fzf'
    telescope.load_extension 'projects'

    -- Setup project.nvim
    require('project_nvim').setup {
      detection_methods = { 'pattern', 'lsp' },
      patterns = { '.git', 'package.json', 'Cargo.toml', 'go.mod' },
      show_hidden = false,
    }
  end,
}
