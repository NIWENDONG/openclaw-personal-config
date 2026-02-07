#!/bin/bash
# OpenClaw 一键启动脚本
# 用法: ./start-openclaw.sh

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 配置
OPENCLAW_DIR="$HOME/project/openclaw/openclaw"
PORT="${OPENCLAW_PORT:-18789}"
VERBOSE="${OPENCLAW_VERBOSE:-true}"

echo -e "${BLUE}🦞 OpenClaw 启动脚本${NC}"
echo "================================"

# 1. 检查 Node.js
echo -n "检查 Node.js... "
if ! command -v node &> /dev/null; then
    echo -e "${RED}✗${NC}"
    echo -e "${RED}错误: 未找到 Node.js，请先安装 Node.js${NC}"
    exit 1
fi
NODE_VERSION=$(node -v)
echo -e "${GREEN}✓${NC} ($NODE_VERSION)"

# 2. 检查 OpenClaw 目录
echo -n "检查 OpenClaw 目录... "
if [ ! -d "$OPENCLAW_DIR" ]; then
    echo -e "${RED}✗${NC}"
    echo -e "${RED}错误: 未找到 OpenClaw 目录: $OPENCLAW_DIR${NC}"
    exit 1
fi
echo -e "${GREEN}✓${NC}"

# 3. 检查是否已经在运行
echo -n "检查运行状态... "
if pgrep -f "openclaw.*gateway" > /dev/null; then
    echo -e "${YELLOW}⚠${NC}"
    echo -e "${YELLOW}警告: OpenClaw 已经在运行${NC}"
    echo ""
    echo "进程列表:"
    ps aux | grep -E "openclaw.*gateway" | grep -v grep
    echo ""
    read -p "是否停止现有进程并重新启动? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "停止现有进程..."
        pkill -f "openclaw.*gateway" || true
        sleep 2
    else
        echo "退出。"
        exit 0
    fi
fi
echo -e "${GREEN}✓${NC}"

# 4. 进入项目目录
cd "$OPENCLAW_DIR"

# 5. 检查依赖
echo -n "检查依赖... "
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}⚠${NC}"
    echo "首次运行，安装依赖..."
    pnpm install
else
    echo -e "${GREEN}✓${NC}"
fi

# 6. 检查构建
echo -n "检查构建... "
if [ ! -d "dist" ]; then
    echo -e "${YELLOW}⚠${NC}"
    echo "首次运行，构建项目..."
    pnpm build
else
    echo -e "${GREEN}✓${NC}"
fi

# 7. 启动 OpenClaw
echo ""
echo -e "${GREEN}🚀 启动 OpenClaw Gateway...${NC}"
echo "端口: $PORT"
echo "详细日志: $VERBOSE"
echo ""
echo -e "${YELLOW}按 Ctrl+C 停止${NC}"
echo "================================"
echo ""

# 构建启动命令
START_CMD="node dist/index.js gateway --port $PORT"
if [ "$VERBOSE" = "true" ]; then
    START_CMD="$START_CMD --verbose"
fi

# 启动
exec $START_CMD
