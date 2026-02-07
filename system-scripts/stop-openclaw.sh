#!/bin/bash
# OpenClaw 停止脚本
# 用法: ./stop-openclaw.sh

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🛑 停止 OpenClaw${NC}"
echo "================================"

# 查找 OpenClaw 进程
PIDS=$(pgrep -f "openclaw.*gateway" || true)

if [ -z "$PIDS" ]; then
    echo -e "${YELLOW}⚠ 没有找到运行中的 OpenClaw 进程${NC}"
    exit 0
fi

echo "找到以下进程:"
ps aux | grep -E "openclaw.*gateway" | grep -v grep
echo ""

# 停止进程
echo "停止进程..."
pkill -f "openclaw.*gateway"

sleep 2

# 检查是否停止成功
if pgrep -f "openclaw.*gateway" > /dev/null; then
    echo -e "${RED}✗ 进程仍在运行，尝试强制停止...${NC}"
    pkill -9 -f "openclaw.*gateway"
    sleep 1
fi

if ! pgrep -f "openclaw.*gateway" > /dev/null; then
    echo -e "${GREEN}✓ OpenClaw 已停止${NC}"
else
    echo -e "${RED}✗ 停止失败${NC}"
    exit 1
fi
