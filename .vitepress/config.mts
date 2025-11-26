import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "DeskBridge",
  description: "Win-Mac 局域网极致互联方案",
  
  // 你的 GitHub 仓库名 (例如你叫 win-mac-deskbridge)
  // ⚠️ 重要：如果你的仓库网址是 github.com/User/Repo，这里就填 '/Repo/'
  base: '/win-mac-deskbridge/', 

  srcDir: 'docs', // 指定文档源目录在 docs 文件夹下

  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: '首页', link: '/' },
      { text: '快速开始', link: '/1-input-share' },
      { text: 'AGI-FBHC 实验室', link: 'https://github.com/AGI-FBHC' }
    ],

    sidebar: [
      {
        text: '核心指南',
        items: [
          { text: '🖱️ 键鼠与剪切板', link: '/1-input-share' },
          { text: '⌨️ 键位映射', link: '/2-key-mapping' },
          { text: '📂 文件极速传输', link: '/3-file-share' },
          { text: '🔊 音频零延迟共享', link: '/4-audio-share' }
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/inYvn/win-mac-deskbridge' }
    ],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2025 AGI-FBHC Lab'
    },
    
    // 开启本地搜索
    search: {
      provider: 'local'
    }
  }
})