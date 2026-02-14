<div align="center">
  <h1 style="margin-top: 10px;">Neovim Configuration</h1>

  <h2>基于 Kickstart.nvim 的现代化 Neovim 配置</h2>

  <div align="center">
    <a href="https://neovim.io/"><img alt="Neovim" src="https://img.shields.io/badge/Neovim-0.9+-blue.svg"/></a>
    <a href="https://github.com/folke/lazy.nvim"><img alt="lazy.nvim" src="https://img.shields.io/badge/Plugin%20Manager-lazy.nvim-green"/></a>
    <a href="https://github.com/LazyVim/LazyVim"><img alt="Based on" src="https://img.shields.io/badge/Based-Kickstart.nvim-purple"/></a>
  </div>

  <p>
    <a href="#功能特性">功能特性</a>
    | <a href="#快速开始">快速开始</a>
    | <a href="#快捷键">快捷键</a>
    | <a href="#主题切换">主题切换</a>
    | <a href="#架构说明">架构说明</a>
  </p>
</div>

---

## 最新更新

- **[2026/02]** 重构 Claude Code 配置，独立为单独文件
- **[2026/01]** 新增 Claude Code 集成，支持多 AI Provider 切换
- **[2026/01]** 新增 Fzf-lua 模糊搜索，增强中文文件名支持
- **[2026/01]** 新增 Cyberdream 主题支持
- **[2026/01]** 优化 Gruvbox 主题配置

---

## 为什么选择这个配置？

这是一个专为现代开发工作流设计的 Neovim 配置，平衡了功能与简洁性。

- **AI 深度集成** - Claude Code 原生支持，多 Provider 自由切换
- **现代化插件生态** - 基于 lazy.nvim，插件按需加载，启动快速
- **开箱即用的 LSP** - 内置多种语言支持，通过 Mason 自动安装
- **多主题支持** - 6 款精美主题一键切换
- **双文件管理器** - Neo-tree + Mini.files 双重体验
- **Git 深度集成** - Diffview、LazyGit、gitsigns 一应俱全

---

## 快速开始

### 前置要求

- Neovim 0.9+
- Nerd Font（用于显示图标）
- Git

### 安装步骤

```bash
# 1. 克隆仓库到 Neovim 配置目录
git clone https://github.com/yourusername/nvim-config ~/.config/nvim

# 2. 启动 Neovim，lazy.nvim 会自动安装插件
nvim

# 3. 安装完成后重启 Neovim
```

> **提示**: 如需自定义配置目录，可在启动时指定 `NVIM_APPNAME` 环境变量。

---

## 功能演示

### AI 对话集成

Claude Code 直接在 Neovim 中运行，支持多个 AI Provider 切换：

```
<C-,>     - 切换 AI Provider（11 个可选）
<leader>a - AI/Claude 功能菜单
<leader>ar - Resume Claude 会话
<leader>as - 发送选中内容到 Claude
```

### 文件搜索

 Telescope + Fzf-lua 双引擎支持：

```
<leader>ff - Telescope 查找文件
<leader>fg - Telescope 全文搜索
<leader>fb - Fzf-lua 快速文件搜索
```

### Git 操作

```
<leader>gg - LazyGit 交互式操作
<leader>gd - Diffview 查看差异
<leader>gs - Gitsigns 状态显示
```

---

## 快捷键

### Leader Keys

| 前缀 | 功能 |
|------|------|
| `<leader>a` | AI / Claude |
| `<leader>b` | Buffer 管理 |
| `<leader>d` | 调试 |
| `<leader>f` | 文件查找 |
| `<leader>g` | Git |
| `<leader>l` | LSP |
| `<leader>s` | 搜索 |
| `<leader>t` | 诊断 |
| `<leader>P` | 插件管理 |

### 核心快捷键（不含分组）

| 快捷键 | 功能 |
|--------|------|
| `K` | LSP 悬浮文档 |
| `gd` | 跳转定义 |
| `gr` | 查找引用 |
| `H` / `L` | 行首 / 行尾 |
| `<C-j>` / `<C-k>` | 上下移动 5 行 |

### 窗口导航

| 快捷键 | 功能 |
|--------|------|
| `<C-h>` | 切换到左侧窗口 |
| `<C-l>` | 切换到右侧窗口 |
| `<C-w>hjkl` | 标准窗口导航 |

---

## 主题切换

编辑 `lua/custom/plugins/colorscheme.lua` 修改主题：

```lua
local theme = {
  name = 'gruvbox',  -- 可选: cyberdream, catppuccin, dracula, tokyonight, solarized, gruvbox
  transparent = false,  -- 透明背景
  italic = true,        -- 斜体注释
}
```

### 支持的主题

| 主题 | 特点 |
|------|------|
| **Gruvbox** | 经典复古风格，暖色调 |
| **Catppuccin** | 柔和的 Mocha 风格 |
| **TokyoNight** | 流行的深色主题 |
| **Dracula** | 经典的紫调主题 |
| **CyberDream** | 赛博朋克未来感 |
| **Solarized** | 护眼低对比度 |

---

## 架构说明

### 配置结构

```
nvim/
├── init.lua                    # 主入口，加载顺序控制
├── lua/
│   ├── kickstart/              # Kickstart 基础配置层
│   │   ├── init.lua
│   │   └── plugins/            # 基础插件
│   ├── custom/                 # 自定义配置层
│   │   ├── basic.lua           # 基础编辑器设置
│   │   ├── keybindings.lua     # 快捷键映射
│   │   ├── autocmds.lua        # 自动命令
│   │   ├── dashboard.lua       # 启动页配置
│   │   └── plugins/            # 自定义插件配置
│   │       ├── plugins.lua     # 核心插件
│   │       ├── claudecode.lua  # AI 集成配置
│   │       ├── colorscheme.lua # 主题配置
│   │       ├── lsp.lua         # LSP 扩展
│   │       ├── telescope.lua   # 模糊搜索
│   │       ├── file-tree.lua   # 文件管理器
│   │       ├── markdown.lua    # Markdown 支持
│   │       └── ...
│   └── ide/
│       └── vscode.lua          # VSCode Neovim 扩展适配
└── .stylua.toml               # Lua 代码格式化配置
```

### 插件加载机制

lazy.nvim 配置中通过 `{ import = 'custom.plugins' }` 自动加载 `lua/custom/plugins/` 目录下的所有 `.lua` 文件。新增插件只需在该目录创建文件即可。

### 插件配置模板

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

---

## 核心插件

| 类别 | 插件 |
|------|------|
| 插件管理 | lazy.nvim |
| LSP 生态 | nvim-lspconfig, mason, lspsaga |
| 文件搜索 | telescope.nvim, fzf-lua |
| 文件管理 | neo-tree.nvim, mini.files |
| 语法高亮 | nvim-treesitter |
| 代码补全 | nvim-cmp, LuaSnip |
| 代码美化 | conform.nvim (格式化) |
| Git | gitsigns, diffview, lazygit |
| AI | claudecode.nvim |
| 主题 | gruvbox, catppuccin, tokyonight 等 |
| 实用工具 | snacks.nvim, which-key, noice |

---

## 语言支持

通过 Mason 自动安装的 LSP 服务器：

- Lua (lua_ls)
- Python (pyright)
- Rust (rust_analyzer)
- Go (gopls)
- TypeScript/JavaScript (ts_ls)
- HTML/CSS (html, cssls)
- JSON (jsonls)
- YAML
- Docker
- Markdown

---

## 自定义开发

### 添加新插件

在 `lua/custom/plugins/` 目录下创建新的 `.lua` 文件，遵循插件配置模板。

### 修改快捷键

编辑 `lua/custom/keybindings.lua` 或在对应插件配置文件中添加。

### 调试模式

```bash
# 启动 Neovim 并查看详细日志
NVIM_LOG_LEVEL=debug nvim

# 检查健康状态
:checkhealth
```

---

## 常见问题

**Q: 启动很慢怎么办？**
A: 运行 `:Lazy` 查看插件加载时间，禁用不必要的插件。

**Q: 主题不生效？**
A: 确保在 `colorscheme.lua` 中正确设置了 `theme.name`，并重启 Neovim。

**Q: LSP 不工作？**
A: 运行 `:Mason` 检查 LSP 是否安装，运行 `:LspInfo` 查看连接状态。

---

## 参考资源

- [Neovim 官方文档](https://neovim.io/doc/)
- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [lazy.nvim 文档](https://github.com/folke/lazy.nvim)
- [Neovim LSP 配置指南](https://neovim.io/doc/user/lsp.html)

---

## 贡献者

感谢以下开发者对本项目的贡献：

- [@elrond-g](https://github.com/elrond-g) - 修复 tree-sitter 配置路径

## 致谢

- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - 基础配置框架
- [LazyVim](https://github.com/LazyVim/LazyVim) - 插件生态参考
- [Neovim Community](https://github.com/neovim) - 伟大的编辑器

---

<div align="center">
  <p>
    <strong>Built with ❤️ by elliotxx</strong><br>
    <sub>现代化的 Neovim 开发环境</sub>
  </p>
</div>
