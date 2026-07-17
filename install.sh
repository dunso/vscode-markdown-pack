#!/bin/bash
# ============================================================
#  VSCode Markdown 配置一键安装脚本
#  适用于 macOS / Linux
# ============================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   VSCode Markdown 配置安装工具          ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
echo ""

# ---- 检查 code 命令 ----
if ! command -v code &> /dev/null; then
    echo -e "${RED}[错误] 未找到 'code' 命令。${NC}"
    echo "请先在 VSCode 中安装命令行工具："
    echo "  打开 VSCode → Cmd+Shift+P → 输入 'shell command' →"
    echo "  选择 'Install 'code' command in PATH'"
    exit 1
fi
echo -e "${GREEN}[✓]${NC} 检测到 code 命令"

# ---- Step 1: 安装扩展 ----
echo ""
echo "━━━ 第 1 步：安装 Markdown 扩展 ━━━"

EXTENSIONS=(
    "shd101wyy.markdown-preview-enhanced"
    "gicentre.markdown-preview-enhanced-with-litvis"
    "hediet.vscode-drawio"
)

for ext in "${EXTENSIONS[@]}"; do
    echo -n "  安装 $ext ... "
    if code --install-extension "$ext" --force &>/dev/null; then
        echo -e "${GREEN}完成${NC}"
    else
        echo -e "${YELLOW}跳过（可能已安装或网络问题）${NC}"
    fi
done

# ---- Step 2: 安装 style.less 自定义样式 ----
echo ""
echo "━━━ 第 2 步：安装 Markdown 预览样式 ━━━"

MUME_DIR="$HOME/.local/state/mume"
mkdir -p "$MUME_DIR"

# 同时兼容旧版 MPE 路径 (~/.mume/)
LEGACY_MUME_DIR="$HOME/.mume"
mkdir -p "$LEGACY_MUME_DIR"

if [ -f "$SCRIPT_DIR/style.less" ]; then
    cp "$SCRIPT_DIR/style.less" "$MUME_DIR/style.less"
    cp "$SCRIPT_DIR/style.less" "$LEGACY_MUME_DIR/style.less"
    echo -e "${GREEN}[✓]${NC} style.less → $MUME_DIR/style.less"
    echo -e "${GREEN}[✓]${NC} style.less → $LEGACY_MUME_DIR/style.less (兼容旧版)"
else
    echo -e "${YELLOW}[!]${NC} 未找到 style.less，跳过"
fi

# ---- Step 3: 写入设置 ----
echo ""
echo "━━━ 第 3 步：写入 Markdown 设置 ━━━"

# 用 Python 合并 JSON，避免 jq 依赖
/usr/bin/python3 "$SCRIPT_DIR/merge_settings.py"

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  安装完成！                            ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
echo ""
echo "已安装的扩展："
echo "  • Markdown Preview Enhanced — 增强预览"
echo "  • Markdown Preview Enhanced with Litvis — 可视化叙事"
echo "  • Draw.io Integration — 图表集成"
echo ""
echo "已部署的样式："
echo "  • style.less → ~/.local/state/mume/style.less"
echo ""
echo "已应用的设置："
echo "  • D2 图表主题 → 302"
echo "  • 代码块主题 → twilight.css"
echo ""
echo -e "${YELLOW}提示：重新打开一个 .md 文件即可看到效果。${NC}"
echo ""
