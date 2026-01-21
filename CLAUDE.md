# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是基于 Kickstart.nvim 的 Neovim 配置，使用 Lua 编写。插件管理器为 lazy.nvim。

## 常用命令

### 格式化
```bash
stylua --config-path .stylua.toml .
```

### 查看配置入口
主入口文件是 `init.lua`，配置加载顺序为：
1. `custom/basic.lua` - 基础编辑器设置
2. `custom/keybindings.lua` - 快捷键映射
3. 插件系统初始化
4. 自动导入 `lua/custom/plugins/` 下的所有配置文件

### 主题切换
编辑 `lua/custom/plugins/colorscheme.lua`，修改 `theme.name` 可选值：
- `catppuccin` (当前默认)
- `tokyonight`
- `dracula`

## 架构说明

### 分层模式
- `lua/kickstart/` - Kickstart 提供的基础配置层
- `lua/custom/` - 自定义配置层，覆盖并扩展基础配置
- `lua/ide/vscode.lua` - VSCode Neovim 扩展的特殊配置

### 插件自动导入
lazy.nvim 配置中通过 `{ import = 'custom.plugins' }` 自动加载 `lua/custom/plugins/` 目录下的所有 `.lua` 文件。新增插件配置只需在该目录创建文件即可。

### 插件配置结构
```lua
return {
  {
    'author/plugin-name',
    event = 'VeryLazy',  -- 懒加载触发条件
    dependencies = {},
    opts = {},
    config = function() end,
  },
}
```

## 快捷键

### Leader Keys
- `<leader>` = 空格
- `<localleader>` = 逗号

### 核心动作（不含 which-key 分组）
- `K` - LSP 悬浮文档
- `gd` - 跳转定义
- `gr` - 查找引用
- `H` / `L` - 行首/行尾
- `<C-j>` / `<C-k>` - 上下移动 5 行

### Which-Key 分组前缀
- `<leader>a` - AI (Claude Code)
- `<leader>b` - Buffer 管理
- `<leader>d` - 调试
- `<leader>f` - 文件查找
- `<leader>g` - Git
- `<leader>l` - LSP
- `<leader>s` - 搜索
- `<leader>t` - 诊断/代码检查
- `<leader>P` - 插件管理

## LSP 配置
通过 Mason 管理安装，LSPconfig 配置客户端。主 LSP 配置在 `init.lua` 中，额外功能通过 `custom/plugins/lsp.lua` 扩展。

## Git 集成
使用 LazyGit 和 Diffview 双工具，Diffview 使用当前配色主题的高亮。
