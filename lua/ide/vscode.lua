--[[
VSCode-specific Configuration
---------------------------
Configuration when running Neovim inside VSCode.
Includes:
- Basic settings that work well in VSCode
- VSCode-specific keymaps
- No plugin dependencies
--]]

local M = {}

M.setup = function()
  -- Basic settings
  require('custom.basic').setup()
  require('custom.keybindings').setup()

  -- Add VSCode specific commands
  -- vim.keymap.set('n', '<leader>e', '<Cmd>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>', { desc = 'Toggle file explorer' })
  -- vim.keymap.set('n', '<leader>f', '<Cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>', { desc = 'Quick open' })
  vim.keymap.set('n', '<leader>p', '<Cmd>call VSCodeNotify("workbench.action.openRecent")<CR>', { desc = 'Switch project' })
end

return M
