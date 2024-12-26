--[[
Basic Neovim Configuration
-------------------------
Core Neovim settings without any plugin dependencies.
Includes settings for:
- Editor behavior (indentation, wrapping)
- Visual aids (cursor line/column)
- File handling
- Folding
--]]

local M = {}

M.setup = function()
    -- Editor Settings
    vim.opt.shiftwidth = 4      -- the number of spaces inserted for each indentation
    vim.opt.tabstop = 4         -- insert 4 spaces for a tab
    vim.opt.wrap = true         -- wrap lines
    vim.opt.expandtab = true    -- replace tab with spaces
    vim.opt.textwidth = 80      -- line wrap width
    vim.opt.autoread = true     -- auto reload files changed outside of vim
    
    -- Visual Aids
    vim.opt.cursorline = true   -- highlight current line
    vim.opt.number = true       -- show line numbers
end

return M
