#!/bin/bash
# OpenClaw 状态检查脚本
# 用法: ./status-openclaw.sh

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🦞 OpenClaw 状态${NC}"
echo "================================"

# 检查进程
if pgrep -f "openclaw.*gateway" > /dev/null; then
    echo -e "状态: ${GREEN}运行中 ✓${NC}"
    echo ""
    echo "进程信息:"
    ps aux | grep -E "openclaw.*gateway" | grep -v grep | awk '{printf "PID: %s | CPU: %s%% | MEM: %s%% | 启动时间: %s\n", $2, $3, $4, $9}'
    echo ""
    echo "端口监听:"
    netstat -tlnp 2>/dev/null | grep -E ":(18789|3000)" || echo "无法获取端口信息（需要权限）"
else
    echo -e "状态: ${RED}未运行 ✗${NC}"
    echo ""
    echo "启动命令:"
    echo "  前台: ./start-openclaw.sh"
    echo "  后台: ./start-openclaw-bg.sh"
fi

echo ""
echo "日志文件:"
LOG_FILE="$HOME/.openclaw/openclaw-gateway.log"
if [ -f "$LOG_FILE" ]; then
    echo "  位置: $LOG_FILE"
    echo "  大小: $(du -h "$LOG_FILE" | cut -f1)"
    echo ""
    echo "最近日志 (最后 10 行):"
    echo "---"
    tail -n 10 "$LOG_FILE" 2>/dev/null || echo "无法读取日志"
else
    echo "  未找到日志文件"
fi
