#!/bin/bash
# scripts/dl-media.sh

# Set paths
YTDLP="$HOME/.local/bin/yt-dlp"
FFMPEG="$HOME/.local/bin/ffmpeg"
DL_DIR="$HOME/Downloads/Media"

# Input
URL="$1"
MODE="$2" # "audio" or default (video)

if [ -z "$URL" ]; then
  echo "Usage: $0 <url> [audio]"
  exit 1
fi

mkdir -p "$DL_DIR"

echo "Downloading from: $URL"
if [ "$MODE" == "audio" ]; then
  echo "Mode: Audio (MP3)"
  "$YTDLP" -x --audio-format mp3 --audio-quality 0 --ffmpeg-location "$FFMPEG" -o "$DL_DIR/%(title)s.%(ext)s" "$URL"
else
  echo "Mode: Video (Best)"
  "$YTDLP" -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --cookies /home/nee/cookies.txt --ffmpeg-location "$FFMPEG" -o "$DL_DIR/%(title)s.%(ext)s" --js-runtimes node:/home/nee/.nvm/versions/node/v24.13.0/bin/node --remote-components ejs:github "$URL"
fi

if [ $? -eq 0 ]; then
  echo "Download complete! Saved to $DL_DIR"
else
  echo "Download failed."
  exit 1
fi
