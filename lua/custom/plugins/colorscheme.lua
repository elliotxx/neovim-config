--[[
Colorscheme Configuration
------------------------
Multiple theme support with easy switching
--]]

-- Theme configuration
local theme = {
  name = 'gruvbox', -- Current theme: cyberdream, catppuccin, dracula, tokyonight, solarized, gruvbox
}

return {
  -- Solarized theme
  {
    'maxmx03/solarized.nvim',
    enabled = theme.name == 'solarized',
    lazy = false,
    priority = 1000,
    ---@type solarized.config
    opts = {
      transparent = { enabled = false },
    },
    config = function()
      require('solarized').setup(opts)
      if theme.name == 'solarized' then
        vim.o.background = 'light'
        vim.cmd.colorscheme 'solarized'
      end
    end,
  },

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

  -- Cyberdream theme
  {
    'scottmckendry/cyberdream.nvim',
    enabled = theme.name == 'cyberdream',
    lazy = false,
    priority = 1000,
    -- opts = {
    -- },
    config = function(_, opts)
      require('cyberdream').setup(opts)
      if theme.name == 'cyberdream' then
        vim.cmd.colorscheme 'cyberdream'
      end
    end,
  },

  -- Gruvbox theme
  {
    'ellisonleao/gruvbox.nvim',
    enabled = theme.name == 'gruvbox',
    lazy = false,
    priority = 1000,
    opts = {
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      transparent = false,
      contrast = 'hard',
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      alt_separator = false,
      required_plugin = false,
    },
    config = function(_, opts)
      require('gruvbox').setup(opts)
      if theme.name == 'gruvbox' then
        vim.o.background = 'dark'
        vim.cmd.colorscheme 'gruvbox'
      end
    end,
  },
}
