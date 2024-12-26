--[[
Telescope Configuration
---------------------
Fuzzy finder plugin configuration
--]]

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "ahmedkhalf/project.nvim",
  },
  cmd = "Telescope",
  opts = {
    theme = "dropdown",
    defaults = {
      -- UI elements
      prompt_prefix = "🔍 ",
      selection_caret = "❯ ",
      winblend = 10,
    },

    pickers = {
      find_files = {
        hidden = true,  -- Show hidden files in find_files
        no_ignore = true,  -- Show .gitignore files in find_files
        previewer = false,
        layout_config = {
          height = 0.4,
          prompt_position = "top",
          preview_width = 0.6,
        },
      },
      live_grep = {
        additional_args = function()
          return { "--hidden" }  -- Show hidden files in live_grep
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
        case_mode = "smart_case",
      },
      projects = {
        hidden_files = true,
        theme = "dropdown",
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)

    -- Load extensions
    telescope.load_extension("fzf")
    telescope.load_extension("projects")

    -- Set keymaps
    local builtin = require("telescope.builtin")
    local keymap = vim.keymap.set

    -- File pickers
    keymap("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    keymap("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
    keymap("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    
    -- Git pickers
    keymap("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
    keymap("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
    
    -- LSP pickers
    keymap("n", "<leader>fr", builtin.lsp_references, { desc = "Find references" })
    keymap("n", "<leader>fd", builtin.lsp_definitions, { desc = "Find definitions" })
    keymap("n", "<leader>fi", builtin.lsp_implementations, { desc = "Find implementations" })

    -- Setup project.nvim
    require("project_nvim").setup {
      detection_methods = { "pattern", "lsp" },
      patterns = { ".git", "package.json", "Cargo.toml", "go.mod" },
      show_hidden = true,
    }
  end,
}
