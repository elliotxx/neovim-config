--[[
Comment Configuration
--------------------
Setup for numToStr/Comment.nvim
--]]

return {
  -- Comment.nvim
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('Comment').setup {
        -- Enable comment features
        active = true,
        -- Add a space between comment and the line
        padding = true,
        -- Keep cursor at the same position after commenting
        sticky = true,
        -- Ignore empty lines
        ignore = '^$',
        -- Basic mappings in NORMAL/VISUAL mode
        mappings = {
          -- Operator-pending mapping
          -- Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
          basic = true,
          -- Extra mapping
          -- Includes `gco`, `gcO`, `gcA`
          extra = true,
        },
        -- Line and block comment toggle mapping
        toggler = {
          -- Line-comment toggle
          line = 'gcc',
          -- Block-comment toggle
          block = 'gbc',
        },
        -- Line and block comment operator-mode mapping
        opleader = {
          -- Line-comment opfunc mapping
          line = 'gc',
          -- Block-comment opfunc mapping
          block = 'gb',
        },
        -- Extra mappings
        extra = {
          -- Add comment on the line above
          above = 'gcO',
          -- Add comment on the line below
          below = 'gco',
          -- Add comment at the end of line
          eol = 'gcA',
        },
        -- Pre-hook, called before commenting the line
        pre_hook = function(...)
          local ts_comment = require('ts_context_commentstring.integrations.comment_nvim')
          return ts_comment.create_pre_hook()(...)
        end,
        -- Post-hook, called after commenting is done
        post_hook = nil,
      }
    end,
  },
}
