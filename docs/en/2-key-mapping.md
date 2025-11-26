# ⌨️ Key Mapping Configuration

The goal of this guide is to unify the input experience between the **Mac Host** and the **Windows Guest**.

We aim to achieve: **Use the `Control` key (bottom-left) for Copy/Paste on both computers, and ensure consistent F1-F12 behavior.**

---

## 1. Step 1: Mac System Key Swap (System Level)

The bottom-left key on a Mac keyboard is `Control`, but the default shortcut for Copy is `Command` (next to the Spacebar).
To match Windows muscle memory (using bottom-left Ctrl+C), we need to swap these two keys at the Mac system level.

1.  Open **System Settings**.
2.  Click **Keyboard** in the sidebar.
3.  Click **Keyboard Shortcuts** -> **Modifier Keys**.
4.  In the popup window:
    * **Select Keyboard**: Ensure you select the physical keyboard you are currently using.
    * **Control (^) Key**: Change to **Command**.
    * **Command (⌘) Key**: Change to **Control**.
5.  Click **Done**.

> **Verification**: Now, pressing `Control` + `C` (bottom-left) on your Mac should trigger the Copy action.

---

## 2. Step 2: DeskFlow Mapping Correction (Software Level)

After Step 1, the Mac feels right, but the signals sent to Windows via DeskFlow will be scrambled. We need to "correct" the signals inside DeskFlow before sending them to Windows.

1.  Open DeskFlow on the **Mac (Server)**.
2.  Click **Configure Server...**.
3.  In the screen layout area, **double-click the screen icon representing Windows**.
4.  In the popup window, find the **Modifier Keys** section at the bottom right.
5.  **Modify the mapping as follows**:
    * **Ctrl**: Select `Super`
    * **Super**: Select `Ctrl`
    * *(Note: In DeskFlow terminology, Super usually corresponds to the Mac Command / Win key)*
6.  Click **OK** to save the configuration.

> **Principle**: The Mac system converted the physical `Ctrl` into a logical `Command`. DeskFlow captures this `Command` and uses this mapping to convert it back to `Ctrl` for Windows, achieving a "negative times negative equals positive" effect.

---

## 3. Step 3: Fix F1-F12 Function Keys

By default, Mac uses F1-F12 for brightness and volume control. This prevents F1 from triggering shortcuts in Windows games or apps, and can even cause the Windows Fn key state to get stuck.

1.  On Mac, open **System Settings**.
2.  Click **Keyboard** in the sidebar.
3.  Click **Keyboard Shortcuts** -> **Function Keys**.
4.  **Toggle ON**:
    * Find **"Use F1, F2, etc. keys as standard function keys"**.
    * Switch it to **ON**.
5.  Click **Done**.

> **Now**: Pressing F1 sends F1. If you need to adjust screen brightness, press `Fn + F1`.

---

## 4. Step 4: Fix Caps Lock Behavior

macOS defaults to switching input sources with a short press of Caps Lock, requiring a long press for actual Caps Lock. This conflicts with Windows habits and causes accidental switches.

1.  On Mac, open **System Settings**.
2.  Click **Keyboard** in the sidebar.
3.  Find the **Input Sources** section on the right and click the **Edit** button.
4.  **Uncheck** the first option:
    * ❌ **"Use the Caps Lock key to switch to and from 'ABC' input mode"**.
5.  Click **Done**.

> **Suggestion**: You can go to **Keyboard Shortcuts** -> **Input Sources** and set "Select the previous input source" to `Control + Space`. Combined with the previous remapping, you can now use `Ctrl + Space` (bottom-left) to switch languages on both computers.

---

## ✅ Configuration Complete

Now, your dual-machine experience should be highly unified:
* Bottom-left Key = **Copy/Paste** (Universal for Win/Mac)
* Caps Lock = **Caps Lock** (Universal for Win/Mac)
* F1-F12 = **Standard Function Keys** (Universal for Win/Mac)

Please proceed to the next section for file transfer: **[📂 High-Speed File Tunnel](./en/3-file-share.md)**