--[[
Colorscheme Configuration
------------------------
Multiple theme support with easy switching
Current theme: catppuccin
--]]

-- Theme configuration
local theme = {
  name = 'catppuccin', -- Current theme: catppuccin, dracula, tokyonight
  transparent = true, -- Enable transparent background
  italic = true, -- Enable italic comments and keywords
}

return {
  -- Dracula theme
  {
    'Mofiqul/dracula.nvim',
    enabled = theme.name == 'dracula',
    lazy = false,
    priority = 1000,
    opts = {
      transparent_bg = theme.transparent,
      lualine_bg_color = '#44475a',
      italic_comment = theme.italic,
      overrides = {
        Normal = { bg = theme.transparent and 'NONE' or nil },
        NormalFloat = { bg = theme.transparent and 'NONE' or nil },
        SignColumn = { bg = theme.transparent and 'NONE' or nil },
        TelescopeNormal = { bg = theme.transparent and 'NONE' or nil },
        TelescopeBorder = { fg = '#bd93f9' },
        IndentBlanklineChar = { fg = '#44475a' },
      },
    },
    config = function(_, opts)
      require('dracula').setup(opts)
      if theme.name == 'dracula' then
        vim.cmd.colorscheme 'dracula'
      end
    end,
  },

  -- Catppuccin theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = theme.name == 'catppuccin',
    priority = 1000,
    opts = {
      transparent_background = theme.transparent,
      term_colors = true,
      integrations = {
        telescope = true,
        mason = true,
        which_key = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
      },
      styles = {
        comments = { style = theme.italic and 'italic' or 'NONE' },
        keywords = { style = theme.italic and 'italic' or 'NONE' },
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      if theme.name == 'catppuccin' then
        vim.cmd.colorscheme 'catppuccin'
      end
    end,
  },

  -- Tokyo Night theme
  {
    'folke/tokyonight.nvim',
    enabled = theme.name == 'tokyonight',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'night',
      transparent = theme.transparent,
      terminal_colors = true,
      styles = {
        comments = { italic = theme.italic },
        keywords = { italic = theme.italic },
        sidebars = theme.transparent and 'transparent' or nil,
        floats = theme.transparent and 'transparent' or nil,
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      if theme.name == 'tokyonight' then
        vim.cmd.colorscheme 'tokyonight'
      end
    end,
  },
}
