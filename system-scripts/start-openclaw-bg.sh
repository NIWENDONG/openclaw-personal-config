#!/bin/bash
# OpenClaw 后台启动脚本
# 用法: ./start-openclaw-bg.sh

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
LOG_FILE="$HOME/.openclaw/openclaw-gateway.log"

echo -e "${BLUE}🦞 OpenClaw 后台启动脚本${NC}"
echo "================================"

# 1. 检查是否已经在运行
if pgrep -f "openclaw.*gateway" > /dev/null; then
    echo -e "${YELLOW}⚠ OpenClaw 已经在运行${NC}"
    echo ""
    ps aux | grep -E "openclaw.*gateway" | grep -v grep
    echo ""
    echo "使用 ./stop-openclaw.sh 停止"
    exit 0
fi

# 2. 进入项目目录
cd "$OPENCLAW_DIR"

# 3. 启动 OpenClaw (后台)
echo -e "${GREEN}🚀 启动 OpenClaw Gateway (后台)...${NC}"
echo "端口: $PORT"
echo "日志: $LOG_FILE"
echo ""

nohup node dist/index.js gateway --port $PORT --verbose > "$LOG_FILE" 2>&1 &
PID=$!

sleep 2

# 4. 检查是否启动成功
if ps -p $PID > /dev/null; then
    echo -e "${GREEN}✓ 启动成功！${NC}"
    echo "PID: $PID"
    echo ""
    echo "查看日志: tail -f $LOG_FILE"
    echo "停止服务: ./stop-openclaw.sh"
else
    echo -e "${RED}✗ 启动失败${NC}"
    echo "查看日志: cat $LOG_FILE"
    exit 1
fi
