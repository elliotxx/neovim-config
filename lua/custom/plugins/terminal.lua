--[[
Terminal Plugin Configuration
---------------------------
This plugin provides an integrated terminal experience in Neovim.

Keybindings:
- <C-\>      : Toggle terminal window
- <M-1>      : Open horizontal terminal (30% height)
- <M-2>      : Open vertical terminal (40% width)
- <M-3>      : Open floating terminal
- jk         : Exit terminal mode (in terminal)

Features:
- Multiple terminal instances
- Floating/horizontal/vertical layouts
- Persistent terminal sessions
- Automatic scrolling
- Custom shell support

Usage:
1. Toggle terminal: Press <C-\> in any mode
2. Multiple layouts:
   - Use <M-1> for horizontal split
   - Use <M-2> for vertical split
   - Use <M-3> for floating window
3. In terminal mode:
   - Use 'jk' to switch to normal mode
   - Use <C-\> to hide terminal
4. Terminal will auto-scroll and persist size
--]]

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Set terminal size
      size = function(term)
        if term.direction == "horizontal" then
          return 0.3 * vim.o.lines -- Horizontal terminal height 30%
        elseif term.direction == "vertical" then
          return 0.4 * vim.o.columns -- Vertical terminal width 40%
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      persist_size = false,
      -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
      direction = "float",
      close_on_exit = true, -- close the terminal window when the process exits
      auto_scroll = true, -- automatically scroll to the bottom on terminal output
      shell = nil, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        border = "curved",
        -- width = <value>,
        -- height = <value>,
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      winbar = {
        enabled = false,
      },
      -- Add executables on the config.lua
      -- { cmd, keymap, description, direction, size }
      -- lvim.builtin.terminal.execs = {...} to overwrite
      -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
      execs = {
        { nil, "<M-1>", "Horizontal Terminal", "horizontal", 0.3 },
        { nil, "<M-2>", "Vertical Terminal", "vertical", 0.4 },
        { nil, "<M-3>", "Float Terminal", "float", nil },
      },

      -- Terminal appearance settings
      shade_terminals = true,
    })

    -- Use <C-`> to open horizontal terminal
    local opts = { noremap = true, silent = true }
    vim.keymap.set({ "n", "t" }, "<C-`>", function()
      local term = require("toggleterm.terminal").Terminal
      local horizontal = term:new({
        direction = "horizontal",
        size = 0.3,
      })
      horizontal:toggle()
    end, opts)

    -- Use jk to exit terminal mode
    --   :tnoremap jk <C-\><C-n>
    -- You can see :help terminal
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  end,
}
