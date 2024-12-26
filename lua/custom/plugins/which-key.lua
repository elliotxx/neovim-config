return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    plugins = {
      marks = true,
      presets = {
        operators = true, -- adds help for operators like d, y, ...
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    win = {
      border = 'single',
      position = 'bottom',
      margin = { 1, 0, 1, 0 },
      padding = { 1, 2, 1, 2 },
      winblend = 0,
    },
  },
  config = function()
    local wk = require 'which-key'

    -- Visual mode mappings with new spec format
    wk.add {
      mode = { 'v' },
      { '<leader>/', '<Plug>(comment_toggle_linewise_visual)', desc = 'Comment toggle' },
      { '<leader>R', group = 'Refactor' },
      { '<leader>RF', "<Esc><cmd>lua require('refactoring').refactor('Extract Function To File')<CR>", desc = 'Extract Function To File' },
      { '<leader>Rf', "<Esc><cmd>lua require('refactoring').refactor('Extract Function')<CR>", desc = 'Extract Function' },
      { '<leader>Ri', "<Esc><cmd>lua require('refactoring').refactor('Inline Variable')<CR>", desc = 'Inline Variable' },
      { '<leader>Rr', "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", desc = 'Refactor Prompt' },
      { '<leader>Rv', "<Esc><cmd>lua require('refactoring').refactor('Extract Variable')<CR>", desc = 'Extract Variable' },
    }

    -- Normal mode mappings with new spec format
    wk.add {
      mode = { 'n' },
      { '<leader>;', '<cmd>lua Snacks.dashboard()<CR>', desc = 'Dashboard' },
      { '<leader>w', '<cmd>w!<CR>', desc = 'Save' },
      { '<leader>q', '<cmd>confirm q<CR>', desc = 'Quit' },
      { '<leader>/', '<Plug>(comment_toggle_linewise_current)', desc = 'Comment toggle' },
      { '<leader>x', '<cmd>BufferKill<CR>', desc = 'Close Buffer' },
      { '<leader>f', '<cmd>FzfLua files<CR>', desc = 'Find File' },
      { '<leader>h', '<cmd>nohlsearch<CR>', desc = 'No Highlight' },
      { '<leader>o', '<cmd>SymbolsOutline<cr>', desc = 'SymbolsOutline' },
      { '<leader>p', '<cmd>Telescope projects<cr>', desc = 'Projects' },
      { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'Explorer' },
      { '<leader>E', '<cmd>lua MiniFiles.open()<CR>', desc = 'MiniFiles Explorer' },

      { '<leader>b', group = 'Buffers' },
      { '<leader>bf', '<cmd>FzfLua buffers<cr>', desc = 'Find buffers' },
      { '<leader>bj', '<cmd>BufferLineCycleNext<cr>', desc = 'Next' },
      { '<leader>bk', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous' },
      { '<leader>be', '<cmd>BufferLinePickClose<cr>', desc = 'Pick which buffer to close' },
      { '<leader>bh', '<cmd>BufferLineCloseLeft<cr>', desc = 'Close all to the left' },
      { '<leader>ba', '<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>', desc = 'Close all buffers' },
      { '<leader>bl', '<cmd>BufferLineCloseRight<cr>', desc = 'Close all to the right' },
      { '<leader>bD', '<cmd>BufferLineSortByDirectory<cr>', desc = 'Sort by directory' },
      { '<leader>bL', '<cmd>BufferLineSortByExtension<cr>', desc = 'Sort by language' },

      { '<leader>d', group = 'Debug' },
      { '<leader>dt', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = 'Toggle Breakpoint' },
      { '<leader>db', "<cmd>lua require'dap'.step_back()<cr>", desc = 'Step Back' },
      { '<leader>dc', "<cmd>lua require'dap'.continue()<cr>", desc = 'Continue' },
      { '<leader>dC', "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = 'Run To Cursor' },
      { '<leader>dd', "<cmd>lua require'dap'.disconnect()<cr>", desc = 'Disconnect' },
      { '<leader>dg', "<cmd>lua require'dap'.session()<cr>", desc = 'Get Session' },
      { '<leader>di', "<cmd>lua require'dap'.step_into()<cr>", desc = 'Step Into' },
      { '<leader>do', "<cmd>lua require'dap'.step_over()<cr>", desc = 'Step Over' },
      { '<leader>du', "<cmd>lua require'dap'.step_out()<cr>", desc = 'Step Out' },
      { '<leader>dp', "<cmd>lua require'dap'.pause()<cr>", desc = 'Pause' },
      { '<leader>dr', "<cmd>lua require'dap'.repl.toggle()<cr>", desc = 'Toggle Repl' },
      { '<leader>ds', "<cmd>lua require'dap'.continue()<cr>", desc = 'Start' },
      { '<leader>dq', "<cmd>lua require'dap'.close()<cr>", desc = 'Quit' },
      { '<leader>dU', "<cmd>lua require'dapui'.toggle()<cr>", desc = 'Toggle UI' },

      { '<leader>P', group = 'Plugins' },
      { '<leader>Pi', '<cmd>Lazy install<cr>', desc = 'Install' },
      { '<leader>Ps', '<cmd>Lazy sync<cr>', desc = 'Sync' },
      { '<leader>PS', '<cmd>Lazy clear<cr>', desc = 'Status' },
      { '<leader>Pc', '<cmd>Lazy clean<cr>', desc = 'Clean' },
      { '<leader>Pu', '<cmd>Lazy update<cr>', desc = 'Update' },
      { '<leader>Pp', '<cmd>Lazy profile<cr>', desc = 'Profile' },
      { '<leader>Pl', '<cmd>Lazy log<cr>', desc = 'Log' },
      { '<leader>Pd', '<cmd>Lazy debug<cr>', desc = 'Debug' },

      { '<leader>g', group = 'Git' },
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
      { '<leader>gh', '<cmd>DiffviewFileHistory<cr>', desc = 'Project Git History' },
      { '<leader>gf', '<cmd>FzfLua git_status<cr>', desc = 'Find changed file' },
      { '<leader>gF', '<cmd>DiffviewFileHistory %<cr>', desc = 'File Git History' },
      { '<leader>gj', "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", desc = 'Next Hunk' },
      { '<leader>gk', "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", desc = 'Prev Hunk' },
      { '<leader>gl', "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = 'Blame' },
      { '<leader>gp', "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = 'Preview Hunk' },
      { '<leader>gr', "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = 'Reset Hunk' },
      { '<leader>gR', "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = 'Reset Buffer' },
      { '<leader>gs', "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = 'Stage Hunk' },
      { '<leader>gu', "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = 'Undo Stage Hunk' },
      { '<leader>gb', '<cmd>FzfLua git_branches<cr>', desc = 'Checkout branch' },
      { '<leader>gc', '<cmd>FzfLua git_commits<cr>', desc = 'Checkout commit' },
      { '<leader>gC', '<cmd>FzfLua git_bcommits<cr>', desc = 'Checkout commit(for current file)' },
      { '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>', desc = 'Git Diff' },

      { '<leader>l', group = 'LSP' },
      { '<leader>la', '<cmd>Lspsaga code_action<cr>', desc = 'Code Action' },
      { '<leader>lc', '<cmd>Lspsaga incoming_calls<cr>', desc = 'Call hierarchy' },
      { '<leader>ld', '<cmd>Lspsaga goto_definition<cr>', desc = 'Goto Definition' },
      { '<leader>lp', '<cmd>Lspsaga peek_definition<cr>', desc = 'Peek Definition' },
      { '<leader>lP', '<cmd>Lspsaga peek_type_definition<cr>', desc = 'Peek Type Definition' },
      { '<leader>lf', '<cmd>Lspsaga finder tyd+ref+imp+def<cr>', desc = 'Find references and implementation' },
      { '<leader>lF', '<cmd>lua vim.lsp.buf.format()<cr>', desc = 'Format' },
      { '<leader>lr', '<cmd>Lspsaga rename<cr>', desc = 'Rename' },
      { '<leader>li', '<cmd>LspInfo<cr>', desc = 'Info' },
      { '<leader>lI', '<cmd>Mason<cr>', desc = 'Mason Info' },
      { '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', desc = 'CodeLens Action' },
      { '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<cr>', desc = 'Quickfix' },
      { '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Document Symbols' },
      { '<leader>lS', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'Workspace Symbols' },
      { '<leader>le', '<cmd>Telescope quickfix<cr>', desc = 'Telescope Quickfix' },
      { '<leader>lR', '<cmd>LspRestart<cr>', desc = 'Lsp Restart' },

      { '<leader>s', group = 'Search' },
      { '<leader>sb', '<cmd>FzfLua git_branches<cr>', desc = 'Checkout branch' },
      { '<leader>sc', '<cmd>FzfLua colorschemes<cr>', desc = 'Colorschemes' },
      { '<leader>sC', '<cmd>FzfLua commands<cr>', desc = 'Commands' },
      { '<leader>sf', '<cmd>FzfLua files<cr>', desc = 'Find File' },
      { '<leader>sh', '<cmd>History<cr>', desc = 'History' },
      { '<leader>sH', '<cmd>Helptags<cr>', desc = 'Help tags' },
      { '<leader>sm', '<cmd>Marks<cr>', desc = 'Marks' },
      { '<leader>sr', '<cmd>FzfLua oldfiles<cr>', desc = 'Open Recent File' },
      { '<leader>sR', '<cmd>FzfLua registers<cr>', desc = 'Registers' },
      { '<leader>sg', '<cmd>FzfLua live_grep<cr>', desc = 'Live Grep' },
      { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = 'Keymaps' },

      { '<leader>t', group = 'Diagnostics' },
      { '<leader>tt', '<cmd>Lspsaga show_buf_diagnostics<cr>', desc = 'trouble' },
      { '<leader>tp', '<cmd>Lspsaga show_workspace_diagnostics<cr>', desc = 'project' },
      { '<leader>tf', '<cmd>Lspsaga show_buf_diagnostics<cr>', desc = 'document' },
      { '<leader>tq', '<cmd>TroubleToggle quickfix<cr>', desc = 'quickfix' },
      { '<leader>tl', '<cmd>TroubleToggle loclist<cr>', desc = 'loclist' },
      { '<leader>tj', '<cmd>lua vim.diagnostic.goto_next()<cr>', desc = 'Next Diagnostic' },
      { '<leader>tk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', desc = 'Prev Diagnostic' },

      { '<leader>r', group = 'Replace' },
      { '<leader>rf', "<cmd>lua require('spectre').open_file_search()<CR>", desc = 'Replace File' },
      { '<leader>rp', "<cmd>lua require('spectre').open()<CR>", desc = 'Replace Project' },
      { '<leader>rs', "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", desc = 'Search' },

      { '<leader>u', group = 'Utils' },
    }
  end,
}
