--[[
Indent Lines Configuration
------------------------
Show indent guides using indent-blankline.nvim
--]]

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {},
  config = function()
    require('ibl').setup()
    vim.opt.list = false
  end,
}
