# Custom Plugins

自定义插件配置目录，所有插件配置文件放在这里。

## 组织方式

lazy.nvim 通过 `{ import = 'custom.plugins' }` 自动加载此目录下的所有 `.lua` 文件。每个文件对应一类功能或一个插件，无需手动在 `init.lua` 中 require。

## 目录结构

| 文件 | 功能 |
|------|------|
| `plugins.lua` | 核心插件（AI、LSP 增强、Git 工具等） |
| `colorscheme.lua` | 主题配置，支持 6 款主题切换 |
| `lsp.lua` | LSP 附加功能（诊断、代码操作） |
| `telescope.lua` | 模糊搜索配置 |
| `file-tree.lua` | Neo-tree 文件管理器 |
| `markdown.lua` | Markdown 支持 |
| `which-key.lua` | 快捷键提示配置 |
| `comment.lua` | 注释增强 |
| `movement.lua` | 移动增强（Flash、Smear Cursor） |
| `terminal.lua` | 终端集成 |
| `fold.lua` | 代码折叠配置 |
| `outline.lua` | 符号大纲 |
| `opencode.lua` | OpenCode 集成 |
| `indentlines.lua` | 缩进线 |
| `search-plane.lua` | 搜索增强 |

## 添加新插件

在目录下创建新的 `.lua` 文件，遵循以下格式：

```lua
return {
  {
    'author/plugin-name',
    event = 'VeryLazy',  -- 懒加载触发条件
    dependencies = {},   -- 依赖项
    opts = {},           -- 插件选项
    config = function()  -- 配置函数
      -- 你的配置代码
    end,
  },
}
```

文件名将决定加载顺序（按字母顺序）。建议按功能命名，如 `git-*.lua`、`lsp-*.lua`。
