--[[
LSP Configuration
------------------------------
Complete LSP setup including lsp-progress and nvim-java
--]]

return {
  {
    'linrongbin16/lsp-progress.nvim',
    config = function()
      require('lsp-progress').setup()
    end,
  },

  -- nvim-java - Java 开发支持（懒加载）
  {
    'nvim-java/nvim-java',
    ft = 'java',
    config = function()
      -- 关闭不必要的扩展，减少下载
      require('java').setup {
        lombok = { enable = false },
        java_test = { enable = false },
        java_debug_adapter = { enable = false },
        spring_boot_tools = { enable = false },
        -- JDK installation
        jdk = {
          auto_install = false,
        },
        root_markers = {
          'pom.xml',
          'build.gradle',
          'build.gradle.kts',
          '.git',
          '.gitignore',
          'Formatter.xml',
        },
      }
      vim.lsp.enable 'jdtls'

      -- 配置 Java 格式化使用项目的 Formatter.xml
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('java-format', { clear = true }),
        pattern = '*.java',
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == 'jdtls' then
            -- 查找项目根目录
            local markers = { 'pom.xml', 'build.gradle', 'build.gradle.kts', '.git', 'Formatter.xml' }
            local root_path = vim.fs.find(markers, { upward = true, limit = 1 })[1]
            local root_dir = root_path and vim.fs.dirname(root_path) or vim.fn.getcwd()
            local formatter_path = root_dir .. '/Formatter.xml'

            -- 检查 Formatter.xml 是否存在
            if vim.uv.fs_stat(formatter_path) then
              print('Using formatter: ' .. formatter_path)
              client.notify('workspace/didChangeConfiguration', {
                settings = {
                  java = {
                    format = {
                      enabled = true,
                      settings = {
                        url = formatter_path,
                      },
                    },
                  },
                },
              })
            end
          end
        end,
      })
    end,
  },
}
