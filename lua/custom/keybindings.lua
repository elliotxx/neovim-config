--[[
Keybindings Configuration
------------------------
Custom key mappings for Neovim
--]]

local M = {}

M.setup = function()
  -- Leader keys
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ','

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- Basic operations
  keymap('n', '<D-s>', ':w<CR>', { desc = 'Save file' })
  keymap('n', '|', ':vsplit<CR>', { desc = 'Vertical split' })
  keymap('n', '-', ':split<CR>', { desc = 'Horizontal split' })
  keymap('n', 'Y', ':lua require("custom.utils").copy_path_with_line()<CR>', { desc = 'Copy file path with line' })

  -- Window navigation in iTerm2
  keymap('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
  keymap('n', '<C-j>', '5j', { desc = 'Move down 5 lines' })
  keymap('n', '<C-k>', '5k', { desc = 'Move up 5 lines' })
  keymap('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

  -- Visual mode navigation
  keymap('v', '<C-j>', '5j', { desc = 'Move down 5 lines' })
  keymap('v', '<C-k>', '5k', { desc = 'Move up 5 lines' })

  -- Line navigation
  keymap('n', 'H', '^', { desc = 'Go to start of line' })
  keymap('n', 'L', '$', { desc = 'Go to end of line' })

  -- Better paste in visual mode
  keymap('v', 'p', '"_dP', { desc = 'Paste without yanking' })

  -- LSP keybindings (requires lspsaga and telescope)
  keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { desc = 'Show hover documentation' })
  keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', { desc = 'Go to definition' })
  keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = 'Go to declaration' })
  keymap('n', 'gr', '<cmd>Lspsaga finder ref<CR>', { desc = 'Find references' })
  keymap('n', 'gI', '<cmd>Lspsaga finder imp<CR>', { desc = 'Find implementations' })
  keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = 'Show signature help' })
end

return M
