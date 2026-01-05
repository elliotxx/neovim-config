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
    end,
  },
}
