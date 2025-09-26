--[[
Lsp Configuration
--------------------
Setup for linrongbin16/lsp-progress.nvim
--]]

return {
  {
    'linrongbin16/lsp-progress.nvim',
    config = function()
      require('lsp-progress').setup()
    end,
  },
}
