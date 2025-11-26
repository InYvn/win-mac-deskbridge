#!/bin/bash

# ==========================================
# 🌉 Win-Mac DeskBridge 一键配置脚本
# 作者: AGI-FBHC Lab
# 描述: 自动安装 DeskFlow/BlackHole，生成键位映射配置，引导权限设置。
# ==========================================

# 定义颜色，让输出更好看
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE}    🌉 Win-Mac DeskBridge Setup v1.0     ${NC}"
echo -e "${BLUE}=========================================${NC}"

# --- 1. 检查并安装 Homebrew ---
echo -e "\n${YELLOW}[1/5] 检查环境...${NC}"
if ! command -v brew &> /dev/null; then
    echo -e "${RED}未检测到 Homebrew。${NC}"
    echo "请先安装 Homebrew: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
else
    echo -e "${GREEN}Homebrew 已安装。${NC}"
fi

# --- 2. 安装 DeskFlow 和 BlackHole ---
echo -e "\n${YELLOW}[2/5] 安装核心组件...${NC}"

# 安装 DeskFlow
if brew list deskflow &> /dev/null; then
    echo -e "DeskFlow 已安装，跳过。"
else
    echo "正在安装 DeskFlow..."
    brew tap deskflow/homebrew-tap
    brew install deskflow
fi

# 安装 BlackHole (音频驱动)
if brew list blackhole-2ch &> /dev/null; then
    echo -e "BlackHole 已安装，跳过。"
else
    echo "正在安装 BlackHole 2ch..."
    brew install blackhole-2ch
    echo -e "${GREEN}音频驱动安装完成（可能需要重启后生效）。${NC}"
fi

# --- 3. 自动修复应用权限 (xattr) ---
echo -e "\n${YELLOW}[3/5] 修复 DeskFlow 签名权限...${NC}"
APP_PATH="/Applications/DeskFlow.app"
if [ -d "$APP_PATH" ]; then
    sudo xattr -cr "$APP_PATH"
    echo -e "${GREEN}已移除隔离属性，防止'应用已损坏'报错。${NC}"
else
    echo -e "${RED}警告: 未找到 $APP_PATH，请确认安装路径。${NC}"
fi

# --- 4. 生成完美配置文件 (.conf) ---
# 这是最爽的一步：直接生成带键位映射的配置，免去 GUI 手动配置的痛苦
echo -e "\n${YELLOW}[4/5] 生成智能配置文件...${NC}"
CONFIG_DIR="$HOME/Library/Deskflow"
CONFIG_FILE="$CONFIG_DIR/deskflow.conf"

mkdir -p "$CONFIG_DIR"

# 获取当前用户名作为主机名
MAC_HOSTNAME=$(scutil --get LocalHostName)
WIN_HOSTNAME="win-client" # 默认 Windows 名字

echo "正在生成配置文件到: $CONFIG_FILE"

cat > "$CONFIG_FILE" <<EOF
section: screens
	$MAC_HOSTNAME:
		# Mac 作为服务端
	$WIN_HOSTNAME:
		# Windows 作为客户端
		# 键位映射魔法：把 Win 的 Ctrl 变成 Command (Super)，把 Win 的 Win键 变成 Ctrl
		ctrl = super
		super = ctrl
end

section: aliases
end

section: links
	$MAC_HOSTNAME:
		# Windows 在 Mac 的右边 (如果不合适请手动改为 left)
		right = $WIN_HOSTNAME
	$WIN_HOSTNAME:
		left = $MAC_HOSTNAME
end

section: options
	relativeMouseMoves = false
	screenSaverSync = false
	win32KeepForeground = false
	clipboardSharing = true
	switchCorners = none 
	switchCornerSize = 0
end
EOF

echo -e "${GREEN}配置文件已生成！${NC}"
echo -e "默认设置：Mac 为主控，Windows 名为 '${YELLOW}$WIN_HOSTNAME${NC}'，位于 Mac 右侧。"
echo -e "已应用键位映射：${BLUE}Ctrl -> Command, Win -> Ctrl${NC}"

# --- 5. 引导权限设置 ---
echo -e "\n${YELLOW}[5/5] 引导系统权限设置...${NC}"
echo -e "${RED}注意：由于 macOS 安全限制，脚本无法自动勾选权限。${NC}"
echo -e "即将打开系统设置，请手动开启 DeskFlow 的 ${YELLOW}[辅助功能]${NC} 和 ${YELLOW}[输入监控]${NC} 权限。"

read -p "按回车键打开系统设置..."

# 打开“隐私与安全性”面板
open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"

echo -e "\n${GREEN}=== ✅ 配置脚本执行完毕 ===${NC}"
echo -e "下一步操作："
echo -e "1. 在弹出的设置窗口中，允许 DeskFlow 控制电脑。"
echo -e "2. 打开 DeskFlow 软件。"
echo -e "3. 点击菜单栏 'File' -> 'Save Configuration As' -> 选择刚才生成的 $CONFIG_FILE (可选)"
echo -e "   或者直接在界面上把 Screen Name 改为 ${YELLOW}$MAC_HOSTNAME${NC} 即可。"
echo -e "4. 在 Windows 端 DeskFlow 输入 Screen Name: ${YELLOW}$WIN_HOSTNAME${NC}"