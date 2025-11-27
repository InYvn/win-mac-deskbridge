# ⚡️ Pro Tip: Auto Input Switch (Hammerspoon)

::: tip 💡 The Problem
Have you ever moved your mouse to Windows, typed, and nothing happened (because Mac was still in Chinese IME)?
This solution uses a **Hammerspoon** script to **Auto-switch to ABC when going to Win, and restore when coming back.**
:::

## 1. How it Works
When DeskFlow controls Windows, it instantly **teleports and locks** the Mac cursor to the center of the screen.
Our script detects this "teleportation":
* **Going to Win**: Cursor jumps from edge to center in < 0.2s -> **Force switch to ABC**.
* **Back to Mac**: Cursor leaves the center area -> **Restore previous input method**.

## 2. Installation

1.  **Install Hammerspoon**:
    <三点>bash
    brew install --cask hammerspoon
    <三点>
    *(Or download from [Official Site](https://www.hammerspoon.org/))*

2.  **Configure**:
    * Open Hammerspoon -> Menu Bar Icon -> **Open Config**.
    * Paste the code below into `init.lua`.
    * Update `winPosition` variable (is your Win on left or right?).

3.  **Reload**:
    * Menu Bar Icon -> **Reload Config**.

## 3. Script Code

::: details Click to copy Lua script
<<< @/../scripts/auto_input_switch.lua
:::

::: warning ⚠️ Note on "Fast Movement"
Since the script polls every **0.05s**, moving the mouse **extremely fast** across the edge might cause the script to miss the "Edge State", resulting in a failure to switch.

**If you find the switching unreliable, try tweaking these parameters in the script:**

1.  **Increase Detection Zone (Recommended)**:
    Find `local edgeZone = 10` and change it to a larger value (e.g., `50` or `100`). This widens the "net" to catch the mouse cursor more easily.
2.  **Increase Polling Rate**:
    Find `hs.timer.doEvery(0.05, ...)` at the bottom and change `0.05` to `0.02` or `0.01`. This slightly increases CPU usage but improves precision.
:::

---

## ✅ Configuration Complete & Potential Issues

Now, your key mappings are highly unified across both ends. However, in actual use, you may encounter a **new pain point**:

❌ **Input Method Conflict**: When you move your mouse to Windows to type, if the Mac is still in **Chinese IME**, you might be unable to type symbols (like `.` `[` `]`) correctly on Windows because the Mac intercepts and processes these keyboard signals first.

To achieve a seamless experience of **"Auto-switch to English when going to Windows, and auto-restore when coming back to Mac"**, please proceed to the next section:

**[⚡️ Pro Tip: Auto Input Switch](./2-1-input-fix.md)**