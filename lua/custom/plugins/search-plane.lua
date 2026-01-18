--[[
Spectre Configuration
--------------------
Search and replace panel for Neovim
--]]

return {
  -- Spectre for project-wide find and replace
  {
    'windwp/nvim-spectre',
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
    end,
  },
}
