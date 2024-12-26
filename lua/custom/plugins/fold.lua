--[[
Folding Configuration
--------------------
This plugin provides advanced folding capabilities using nvim-ufo.
Uses treesitter as the main provider for better performance and stability.

Keybindings:
- zR : Open all folds
- zM : Close all folds
- za : Toggle fold under cursor
- zc : Close fold under cursor
- zo : Open fold under cursor
--]]

return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-treesitter/nvim-treesitter",
  },
  event = "BufRead",
  opts = {
    -- Using treesitter as main provider
    provider_selector = function(bufnr, filetype, buftype)
      return { 'treesitter', 'indent' }
    end,
    -- Enable fold column
    fold_virt_text_handler = nil,
    -- Close newly opened folds while jumping
    close_fold_kinds = {},
  },
  config = function(_, opts)
    -- Fold settings
    vim.o.foldcolumn = '1'      -- Show fold column
    vim.o.foldlevel = 99        -- High value to open all folds by default
    vim.o.foldlevelstart = 99   -- Start with all folds open
    vim.o.foldenable = true     -- Enable folding

    -- Initialize UFO
    require('ufo').setup(opts)

    -- Keymaps
    local keymap = vim.keymap.set
    local ufo = require('ufo')

    -- Global fold controls
    keymap('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
    keymap('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })

    -- Peek inside fold without opening it
    keymap('n', 'zK', function()
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = 'Peek fold or show hover' })
  end,
}
