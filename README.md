# VSCode Markdown 配置安装包

一键在新机器上还原你的 VSCode Markdown 写作环境。

## 包含内容

### 扩展（3 个）
| 扩展 | 用途 |
|------|------|
| Markdown Preview Enhanced | 增强预览、代码执行、图表渲染、幻灯片导出 |
| MPE with Litvis | 可视化叙事 / 数据驱动的文档 |
| Draw.io Integration | 在 Markdown 中嵌入可编辑流程图 |

### 设置（3 项）
| 设置项 | 值 | 作用 |
|--------|-----|------|
| `markdown-preview-enhanced.d2Theme` | `302` | D2 图表渲染主题 |
| `markdown-preview-enhanced.codeBlockTheme` | `twilight.css` | 代码块语法高亮（暗色） |
| `hediet.vscode-drawio.resizeImages` | `null` | Draw.io 图片缩放 |

## 安装方法

### macOS / Linux
```bash
chmod +x install.sh
./install.sh
```

### Windows
右键 `install.ps1` → 「使用 PowerShell 运行」，或在终端中：
```powershell
.\install.ps1
```

### 手动安装
如果脚本不可用，也可以手动操作：
1. 在 VSCode 扩展商店搜索安装上述 3 个扩展
2. Cmd+Shift+P → `Preferences: Open User Settings (JSON)` → 粘贴 `markdown-settings.json` 中的内容

## 验证
打开任意 `.md` 文件，右键 → `Markdown Preview Enhanced: Open Preview` 即可看到效果。
