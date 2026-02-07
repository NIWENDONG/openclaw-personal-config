# MEMORY.md - Long-Term Memory

## 关于 Nee

- 在中国，东八区（上海时间）
- **位置：南京栖霞区**
- 希望我有个性、有趣，能给生活添点料
- 第一次对话：2026-02-06
- WhatsApp 号码：+8615751003002
- 使用 WSL (Windows Subsystem for Linux)

## 我学到的事

- 刚上线，还在学习中
- 成功实现了第一个功能：每日早报
- 学会了创建自动化脚本和定时任务
- 添加了 DuckDuckGo 免费搜索功能
- **完成了科大讯飞语音转文字功能！🎤**

## 重要决定

- 我叫 OpBuddy 👾
- 风格：有个性，不机械，让事情有趣

## 功能清单

### 影音下载神器（已实现）🎬
- 工具：yt-dlp + ffmpeg
- 功能：下载 YouTube/Bilibili 视频或音频
- 脚本：`scripts/dl-media.sh`
- 使用：直接发送链接，或加 "音频" 下载 MP3

### 每日早报（已实现）
- 时间：每天早上 8:00
- 内容：天气、新闻、待办、昨日回顾、每日一句
- 天气位置：**南京**
- 新闻来源：**DuckDuckGo 免费搜索**（完全免费，无需 API key）
- 脚本位置：`scripts/daily-briefing.ts`
- Cron ID: `62ae4726-dfb6-4bab-bf72-7908b572f0bb`

### 一键启动脚本（已实现）
- 位置：`/home/nee/`
- 脚本：
  - `start-openclaw.sh` - 前台启动
  - `start-openclaw-bg.sh` - 后台启动
  - `stop-openclaw.sh` - 停止服务
  - `status-openclaw.sh` - 查看状态
- 自动启动：已配置在 `.bashrc`，WSL 启动时自动检测并启动

### DuckDuckGo 搜索模块（已实现）
- 位置：`scripts/duckduckgo-search.ts`
- 功能：免费网页搜索，无需 API key
- 用途：为每日早报提供真实新闻内容

### 喝水提醒（已实现）
- 时间：每天 9/11/13/15/17/19/21 点
- 自动发送到 WhatsApp
- Cron ID: `2fc4b286-b134-4459-a15f-536ccd428037`

### 科大讯飞语音转文字（已实现）🎤
- API：录音文件转写大模型
- 支持格式：mp3, wav, pcm, mp4, m4a, aac, opus, flac, ogg, amr 等
- 支持语言：中英 + 202 种方言自动识别
- 配置：
  - APP_ID: 63c58ce7
  - ACCESS_KEY_ID: e3013cb115467a75a1268424c7e4c209
  - ACCESS_KEY_SECRET: YzE1ZDgyYmJlZjhkYmVmNDgxM2Y4Yjlj
- 文件位置：
  - `src/stt/iflytek.ts` - 核心模块
  - `src/media-understanding/providers/iflytek/` - OpenClaw 集成

## 工作流程

### OpenClaw 管理
- WSL 启动后会自动检查并启动 OpenClaw
- 日志位置：`~/.openclaw/openclaw-gateway.log`
- 待办事项：`~/.openclaw/workspace/TODO.md`

---

*这是我的长期记忆。重要的事情都记在这里。*
