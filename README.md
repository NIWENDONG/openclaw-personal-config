# OpenClaw Personal Config

This repository contains my personalized OpenClaw setup, including:
- **Scripts**: Custom automation scripts (yt-dlp media downloader, etc.)
- **Workspace**: My agent's memory, persona (SOUL.md), and configuration.
- **System**: Start/Stop scripts for managing the OpenClaw service.

## How to Restore on a New Machine

1. **Clone this repository:**
   ```bash
   git clone https://github.com/NIWENDONG/openclaw-personal-config.git ~/openclaw-personal-config
   ```

2. **Run the restore script:**
   ```bash
   cd ~/openclaw-personal-config
   chmod +x restore.sh
   ./restore.sh
   ```

3. **Start OpenClaw:**
   ```bash
   ~/start-openclaw.sh
   ```
