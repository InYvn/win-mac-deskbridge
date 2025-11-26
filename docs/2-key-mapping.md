# ⌨️ 键位映射配置 (Key Mapping)

本指南的目标是统一 **Mac 主控** 和 **Windows 被控** 的输入体验。

我们致力于实现：**无论操作哪台电脑，都使用键盘左下角的 `Control` 键进行复制/粘贴，且 F1-F12 行为一致。**

---

## 1. 第一步：Mac 本机键位互换 (系统级)

Mac 键盘的左下角是 `Control`，但 Mac 默认的复制键是 `Command` (在空格键旁边)。
为了符合 Windows 肌肉记忆（左下角 Ctrl+C），我们需要在 Mac 系统层面把这两个键“掉包”。

1.  打开 **系统设置 (System Settings)**。
2.  点击左侧的 **键盘 (Keyboard)**。
3.  点击 **键盘快捷键 (Keyboard Shortcuts)** -> **修饰键 (Modifier Keys)**。
4.  在弹出窗口中：
    * **选择键盘**：确保选择的是你正在使用的物理键盘。
    * **Control (^) 键**：修改为 **Command**。
    * **Command (⌘) 键**：修改为 **Control**。
5.  点击 **完成 (Done)**。

> **效果验证**：现在，你在 Mac 本机上按键盘左下角的 `Control` + `C`，应该能实现复制功能了。

---

## 2. 第二步：DeskFlow 映射修正 (软件级)

做完第一步后，Mac 本机舒服了，但 DeskFlow 发给 Windows 的信号会变乱。我们需要在 DeskFlow 内部把信号“纠正”回来，发送给 Windows。

1.  打开 **Mac 端 (Server)** 的 DeskFlow。
2.  点击 **Configure Server...** (配置服务端)。
3.  在屏幕布局区域，**双击代表 Windows 的那个屏幕图标**。
4.  在弹出窗口中，找到右下角的 **Modifier Keys (修饰键)** 设置区域。
5.  **按以下规则修改映射**：
    * **Ctrl**: 选择 `Super`
    * **Super**: 选择 `Ctrl`
    * *(注：在 DeskFlow 术语中，Super 通常对应 Mac 的 Command / Win 键)*
6.  点击 **OK** 保存配置。

> **原理**：Mac 系统把物理 `Ctrl` 变成了逻辑 `Command`。DeskFlow 捕获到 `Command` 后，通过此映射将其转换回 `Ctrl` 发送给 Windows。从而实现了“负负得正”。

---

## 3. 第三步：修复 F1-F12 功能键失效

默认情况下，Mac 将 F1-F12 占用为亮度、音量调节键。这会导致你控制 Windows 时，按 F1 无法触发游戏或软件的快捷键，甚至导致 Windows 的 Fn 键状态锁死。

1.  在 Mac 上，打开 **系统设置 (System Settings)**。
2.  点击左侧的 **键盘 (Keyboard)**。
3.  点击 **键盘快捷键 (Keyboard Shortcuts)** -> **功能键 (Function Keys)**。
4.  **开启开关**：
    * 找到 **“将 F1、F2 等键用作标准功能键” (Use F1, F2, etc. keys as standard function keys)**。
    * 将其状态改为 **打开 (ON)**。
5.  点击 **完成 (Done)**。

> **现在**：按 F1 就是 F1。如果你需要调节屏幕亮度，请按 `Fn + F1`。

---

## 4. 第四步：修复 Caps Lock (大写锁定) 行为

macOS 默认短按 Caps Lock 是切换中/英输入法，长按才是大写锁定。这与 Windows 习惯冲突，且容易导致误触。

1.  在 Mac 上，打开 **系统设置 (System Settings)**。
2.  点击左侧的 **键盘 (Keyboard)**。
3.  在右侧找到 **输入法 (Input Sources)** 这一栏，点击右边的 **编辑 (Edit)** 按钮。
4.  **取消勾选** 第一项：
    * ❌ **“使用大写锁定键切换‘ABC’输入模式” (Use the Caps Lock key to switch to and from...)**。
5.  点击 **完成 (Done)**。

> **建议**：你可以去 **键盘快捷键** -> **输入法** 中，将“选择上一个输入法”设置为 `Control + Space`。这样配合前面的改键，你在两台电脑上都可以用键盘左下角的 `Ctrl + 空格` 来切换输入法。

---

## ✅ 配置完成

现在，你的双机体验应该已经高度统一：
* 左下角键 = **复制/粘贴** (Win/Mac 通用)
* Caps Lock = **大写锁定** (Win/Mac 通用)
* F1-F12 = **标准功能键** (Win/Mac 通用)

请前往下一节配置文件传输：**[📂 极速文件传输 (File Tunnel)](./3-file-share.md)**