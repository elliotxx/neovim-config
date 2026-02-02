-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  -- Neovim plugin to manage the file system and other tree like structures.
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    commands = {
      -- Reference: https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/370#discussioncomment-6679447
      copy_selector = function(state)
        -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
        -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local results = {
          filepath,
          modify(filepath, ':.'),
          modify(filepath, ':~'),
          filename,
          modify(filename, ':r'),
          modify(filename, ':e'),
        }

        vim.ui.select({
          '1. Absolute path: ' .. results[1],
          '2. Path relative to CWD: ' .. results[2],
          '3. Path relative to HOME: ' .. results[3],
          '4. Filename: ' .. results[4],
          '5. Filename without extension: ' .. results[5],
          '6. Extension of the filename: ' .. results[6],
        }, { prompt = 'Choose to copy to clipboard:' }, function(choice)
          local i = tonumber(choice:sub(1, 1))
          local result = results[i]
          vim.fn.setreg('+', result)
          vim.notify('Copied: ' .. result)
        end)
      end,
      image_wezterm = function(state)
        local node = state.tree:get_node()
        if node.type == 'file' then
          require('image_preview').PreviewImage(node.path)
        end
      end,
    },
    filesystem = {
      -- 不自动折叠已打开的目录
      close_if_opened = false,
      -- 不折叠任何目录
      default_folded = false,
      -- 禁用状态恢复，防止折叠状态被恢复
      restore_state = false,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        never_show = {
          '.DS_Store',
          'thumbs.db',
        },
        hide_by_name = {
          '__pycache__',
          '.git',
          '.DS_Store',
          'node_modules',
        },
      },
      follow_current_file = {
        -- This will find and focus the file in the active buffer every time
        -- the current file is changed while the tree is open.
        enabled = true,
        leave_dirs_open = true, -- 保持目录展开状态
      },
      scan_mode = 'shallow', -- 浅层扫描，减少不必要的重新渲染
      bind_to_cwd = true, -- 绑定到当前工作目录
      window = {
        mappings = {
          ['Y'] = 'copy_selector',
          ['<tab>'] = 'open',
          ['o'] = 'open',
          ['O'] = 'show_help',
          ['P'] = { 'toggle_preview', config = { use_float = false, use_image_nvim = true } },
          ['<leader>p'] = 'image_wezterm', -- " or another map
        },
      },
    },
  },
}
