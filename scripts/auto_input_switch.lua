-- ============================================
-- 🌉 DeskFlow 输入法智能记忆与切换脚本 
-- 功能：去 Win 自动切 ABC，回 Mac 自动恢复之前的状态
-- ============================================

-- ⚙️ 配置区域
local winPosition = "right" -- Windows 在哪边？
local abcID = "com.apple.keylayout.ABC" 

-- 📏 参数微调
local edgeZone = 10        -- 边缘判定宽度
local centerZone = 500     -- 中心判定半径 (在这个圈内都算中心)
local jumpTimeLimit = 0.2  -- 瞬移时间限制 (0.2秒内从边缘到中心才算瞬移)

-- 🔒 状态变量
local savedInputMethod = nil
local isFocusOnWin = false
local lastAtEdgeTime = 0   -- 上次出现在边缘的时间戳

-- 缓存屏幕数据
local screen = hs.screen.mainScreen()
local frame = screen:frame()
local centerX = frame.x + (frame.w / 2)
local centerY = frame.y + (frame.h / 2)

function mouseHandler()
    local pos = hs.mouse.getAbsolutePosition()
    local now = hs.timer.secondsSinceEpoch()
    
    -- 1. 检测是否在边缘
    local atEdge = false
    if winPosition == "right" then
        if pos.x >= (frame.x + frame.w - edgeZone) then atEdge = true end
    else
        if pos.x <= (frame.x + edgeZone) then atEdge = true end
    end
    
    -- 如果在边缘，更新“目击时间”
    if atEdge then
        lastAtEdgeTime = now
    end

    -- 2. 检测是否在中心
    local distToCenter = math.sqrt((pos.x - centerX)^2 + (pos.y - centerY)^2)
    local atCenter = (distToCenter < centerZone)

    -- 🚀 [去程判定]：刚才在边缘，现在突然在中心 (瞬移)
    if not isFocusOnWin and atCenter then
        -- 核心逻辑：如果从边缘到中心的时间极短，说明是 DeskFlow 干的
        if (now - lastAtEdgeTime) < jumpTimeLimit then
            -- 记录并切换
            local current = hs.keycodes.currentSourceID()
            savedInputMethod = current
            
            if current ~= abcID then
                hs.keycodes.currentSourceID(abcID)
                hs.alert.show("🚀 Win Mode", 0.5)
            end
            
            isFocusOnWin = true
        end
    end

    -- 🏠 [回程判定]：虽然在 Win 模式，但鼠标逃离了中心
    -- 逻辑：DeskFlow 锁定时会一直把鼠标按在中心，如果你能把鼠标移开，说明你回 Mac 了
    if isFocusOnWin and not atCenter then
        if savedInputMethod and savedInputMethod ~= abcID then
            hs.keycodes.currentSourceID(savedInputMethod)
            hs.alert.show("🏠 Mac Mode", 0.5)
        end
        isFocusOnWin = false
        savedInputMethod = nil
    end
end

-- 高频监听 (0.05秒一次，为了捕捉瞬移)
mouseWatcher = hs.timer.doEvery(0.05, mouseHandler)