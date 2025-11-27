import { defineConfig } from 'vitepress'

export default defineConfig({
  // 共享配置 (公用的标题、HTML头等)
  title: "DeskBridge",
  base: '/win-mac-deskbridge/',
  srcDir: 'docs',
  
  // --- 多语言配置核心 ---
  locales: {
    // 1. 中文 (默认根目录)
    root: {
      label: '简体中文',
      lang: 'zh',
      description: "Win-Mac 局域网极致互联方案",
      themeConfig: {
        // 中文菜单
        nav: [
          { text: '首页', link: '/' },
          { text: '快速开始', link: '/1-input-share' },
          { text: 'AGI-FBHC 实验室', link: 'https://github.com/AGI-FBHC' }
        ],
        // 中文侧边栏
        sidebar: [
          {
            text: '核心指南',
            items: [
              { text: '🖱️ 键鼠与剪切板', link: '/1-input-share' },
              { text: '⌨️ 键位映射', link: '/2-key-mapping' },
              { text: '⚡️ 进阶：输入法自动切换', link: '/2-1-input-fix' },
              { text: '📂 文件极速传输', link: '/3-file-share' },
              { text: '🔊 音频零延迟共享', link: '/4-audio-share' },
              { text: '🧪 自动化脚本 (Beta)', link: '/5-automation' }
            ]
          }
        ],
        footer: {
            message: 'Released under the MIT License.',
            copyright: 'Copyright © 2025 AGI-FBHC Lab'
        }
      }
    },

    // 2. 英文 (English)
    en: {
      label: 'English',
      lang: 'en',
      link: '/en/', // 这里指定英文版的 URL 前缀
      description: "Ultimate LAN Interconnection Solution for Win & Mac",
      themeConfig: {
        // 英文菜单
        nav: [
          { text: 'Home', link: '/en/' },
          { text: 'Quick Start', link: '/en/1-input-share' },
          { text: 'AGI-FBHC Lab', link: 'https://github.com/AGI-FBHC' }
        ],
        // 英文侧边栏 (注意链接都要加 /en/ 前缀)
        sidebar: [
          {
            text: 'Core Guides',
            items: [
              { text: '🖱️ Input & Clipboard', link: '/en/1-input-share' },
              { text: '⌨️ Key Mapping', link: '/en/2-key-mapping' },
              { text: '⚡️ Pro: Auto Input Switch', link: '/en/2-1-input-fix' },
              { text: '📂 File Tunnel', link: '/en/3-file-share' },
              { text: '🔊 Audio Bridge', link: '/en/4-audio-share' },
              { text: '🧪 Automation (Beta)', link: '/en/5-automation' }
            ]
          }
        ],
        footer: {
            message: 'Released under the MIT License.',
            copyright: 'Copyright © 2025 AGI-FBHC Lab'
        }
      }
    }
  },

  // --- 公共主题配置 ---
  themeConfig: {
    socialLinks: [
      { icon: 'github', link: 'https://github.com/inYvn/win-mac-deskbridge' }
    ],
    search: {
      provider: 'local',
      options: {
        locales: {
          en: {
            translations: {
              button: {
                buttonText: 'Search',
                buttonAriaLabel: 'Search'
              },
              modal: {
                noResultsText: 'No results for',
                resetButtonTitle: 'Reset search',
                footer: {
                  selectText: 'to select',
                  navigateText: 'to navigate'
                }
              }
            }
          }
        }
      }
    }
  }
})