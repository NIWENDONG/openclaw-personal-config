#!/bin/bash
# restore.sh - Restore OpenClaw config to current machine

echo "🔧 Restoring OpenClaw configuration..."

# 1. Restore Scripts
mkdir -p ~/scripts
cp -r scripts/* ~/scripts/
chmod +x ~/scripts/*.sh
echo "✅ Scripts restored to ~/scripts/"

# 2. Restore Workspace (Memory & Config)
mkdir -p ~/.openclaw/workspace
cp -r workspace/* ~/.openclaw/workspace/
echo "✅ Workspace (Memory, Soul, Agents) restored to ~/.openclaw/workspace/"

# 3. Restore System Scripts
cp system-scripts/*.sh ~/
chmod +x ~/*.sh
echo "✅ System start/stop scripts restored to ~/"

# 4. Install Dependencies (Optional check)
echo "🔍 Checking dependencies..."
if ! command -v yt-dlp &> /dev/null; then
    echo "⚠️ yt-dlp not found. You might want to install it: pip install yt-dlp"
fi

echo "🎉 Restore complete! Run ~/start-openclaw.sh to start."
