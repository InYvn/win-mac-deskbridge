// .vitepress/theme/index.ts
import DefaultTheme from 'vitepress/theme'
import { MotionPlugin } from '@vueuse/motion'
import './custom.css'
import { onMounted, watch, nextTick } from 'vue'
import { useRoute, useRouter, type EnhanceAppContext } from 'vitepress'

export default {
  extends: DefaultTheme,
  
  // 注册 VueUse Motion 插件
  enhanceApp({ app }: EnhanceAppContext) {
    app.use(MotionPlugin)
  },

  setup() {
    const route = useRoute()
    const router = useRouter()

    // --- 逻辑 1: 文档内容滚动浮现动画 ---
    const triggerAnimations = () => {
      // 选取文档主体下的直接子元素
      const elements = document.querySelectorAll('.vp-doc > div > *')
      elements.forEach((el, index) => {
        // 简单延时添加类名，触发 CSS transition
        // 索引越大，延迟稍长一点，防止瞬间全部出现
        setTimeout(() => {
            el.classList.add('appear')
        }, 50 + index * 30) 
      })
    }

    // --- 逻辑 2: 卡片全区域点击跳转 ---
    const initCardClick = () => {
      // 移除旧的监听器防止重复（虽然 mounted 只执行一次，但习惯性防御）
      document.removeEventListener('click', handleCardClick)
      document.addEventListener('click', handleCardClick)
    }

    const handleCardClick = (e: MouseEvent) => {
      // 查找点击目标是否在 .VPFeature 卡片内部
      const target = (e.target as HTMLElement).closest('.VPFeature')
      if (target) {
        // 尝试获取卡片内部链接的 href
        // VitePress 默认会把 link 渲染在卡片标题的 a 标签上，或者整个卡片没有 a 标签需手动处理
        // 这里的逻辑是：如果点击了卡片，但没有点击到内部的链接文字（防止双重跳转），则手动跳转
        const linkElement = target.querySelector('a')
        const href = linkElement?.getAttribute('href')

        if (href && !(e.target as HTMLElement).closest('a')) {
           // 如果点击的是空白处，手动执行路由跳转
           router.go(href)
           e.preventDefault()
        }
      }
    }

    // --- 生命周期钩子 ---
    
    // 页面加载完成时
    onMounted(() => {
      triggerAnimations()
      initCardClick()
    })

    // 路由(页面)切换时
    watch(() => route.path, () => {
      nextTick(() => {
        // 页面切换后，DOM 更新完毕，重新触发进场动画
        triggerAnimations()
      })
    })
  }
}