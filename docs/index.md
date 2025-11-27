---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Win-Mac DeskBridge"
  text: "打破系统边界"
  tagline: 拒绝来回插拔。构建 Windows 与 macOS 的极致无缝协作流。
  actions:
    - theme: brand
      text: 🚀 开始互联
      link: /1-input-share
    - theme: alt
      text: 查看 GitHub
      link: https://github.com/inYvn/win-mac-deskbridge

features:
  - title: 🖱️ 键鼠无缝流转
    details: 基于 DeskFlow，一套键鼠控制双机，剪切板毫秒级同步。
    link: /1-input-share
    
  - title: ⌨️ 完美键位映射
    details: 统一 Ctrl+C/V 肌肉记忆，集成 Hammerspoon 实现跨屏输入法自动切换。
    link: /2-key-mapping

  - title: 📂 极速文件通道
    details: SMB 协议挂载硬盘 + LocalSend 随手快传，跑满局域网带宽。
    link: /3-file-share

  - title: 🔊 音频零延迟
    details: Mac 声音通过 Windows 音箱播放，硬件直连 0 延迟体验。
    link: /4-audio-share
---