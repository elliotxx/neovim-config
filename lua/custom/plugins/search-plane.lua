--[[
Spectre Configuration
--------------------
Search and replace panel for Neovim
--]]

return {
  -- Spectre for project-wide find and replace
  {
    'windwp/nvim-spectre',
    event = 'BufRead',
    config = function()
      require('spectre').setup {
        color_devicons = true,
        highlight = {
          ui = 'String',
          search = 'DiffChange',
          replace = 'DiffDelete',
        },
        mapping = {
          -- Use these keymaps in spectre panel
          ['toggle_line'] = {
            map = 'dd',
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = 'toggle current item',
          },
          ['enter_file'] = {
            map = '<cr>',
            cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
            desc = 'goto current file',
          },
          ['send_to_qf'] = {
            map = '<leader>q',
            cmd = "<cmd>lua require('spectre').toggle()<CR>",
            desc = 'toggle spectre',
          },
          ['replace_cmd'] = {
            map = '<leader>c',
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = 'input replace command',
          },
          ['show_option_menu'] = {
            map = '<leader>o',
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = 'show options',
          },
          ['run_current_replace'] = {
            map = '<leader>rc',
            cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
            desc = 'replace current line',
          },
          ['run_replace'] = {
            map = '<leader>R',
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = 'replace all',
          },
        },
        find_engine = {
          -- rg is map with finder_cmd
          ['rg'] = {
            cmd = 'rg',
            -- default args
            args = {
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
            },
            options = {
              ['ignore-case'] = {
                value = '--ignore-case',
                icon = '[I]',
                desc = 'ignore case',
              },
              ['hidden'] = {
                value = '--hidden',
                desc = 'hidden file',
                icon = '[H]',
              },
            },
          },
        },
        replace_engine = {
          ['sed'] = {
            cmd = 'sed',
            args = nil,
            options = {
              ['ignore-case'] = {
                value = 'i',
                icon = '[I]',
                desc = 'ignore case',
              },
            },
          },
        },
        default = {
          find = {
            cmd = 'rg',
            options = { 'ignore-case' },
          },
          replace = {
            cmd = 'sed',
          },
        },
      }

      -- -- Add keymaps for opening Spectre
      -- vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
      --   desc = "Toggle Spectre"
      -- })
      -- vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
      --   desc = "Search current word"
      -- })
      -- vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
      --   desc = "Search current word"
      -- })
      -- vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
      --   desc = "Search on current file"
      -- })
    end,
  },
}
