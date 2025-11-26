# 🖱️ Mouse, Keyboard & Clipboard Sharing (DeskFlow Guide)

This module guides you on how to set up **DeskFlow** to control two computers with one set of keyboard and mouse, and share the clipboard seamlessly.

## 1. Preparation
* **Network**: Ensure both computers are connected to the same LAN (5G WiFi or wired connection is recommended to reduce **Latency**).
* **Device Roles**:
    * **Server (Host)**: Mac (Physical keyboard and mouse connected here; acts as the primary controller).
    * **Client (Guest)**: Windows PC (The device being controlled).

---

## 2. Download & Installation

### 🍎 macOS Installation (Server)

We provide two installation methods. **Homebrew is recommended**. If you are not comfortable with the command line, please use **Manual Installation**.

#### Method A: Using Homebrew (Recommended)
Automatically manages dependencies; no manual permission fix needed.
```bash
# 1. Add official tap
brew tap deskflow/homebrew-tap

# 2. Install DeskFlow
brew install deskflow
```

#### Method B: Manual Download (GitHub Releases)
If you don't have Homebrew, please follow these steps:

1.  **Download DMG File**:
    * Visit the Releases page: [https://github.com/deskflow/deskflow/releases](https://github.com/deskflow/deskflow/releases)
    * Find the latest version (e.g., v1.17.x or higher).
    * **Select based on your chip**:
        * **M1/M2/M3/M4 etc. (Apple Silicon)**: Download `...-macos-arm64.dmg`
        * **Intel Chip**: Download `...-macos-x86_64.dmg`
2.  **Install**:
    * Open the `.dmg` file and drag `DeskFlow.app` into the "Applications" folder.
3.  **Critical Step: Fix "App is Damaged" Error** 🛠️
    * Since open-source software lacks a paid Apple signature, opening it directly usually triggers a "cannot be opened" or "move to bin" error.
    * **Don't panic, execute the following fix command:**
    * Open **Terminal**, copy the following command and press Enter (you may need to enter your login password; it is normal that the password is invisible while typing):
        ```bash
        sudo xattr -cr /Applications/DeskFlow.app
        ```
    > **Tip**: If you are unsure of the installation path, type `sudo xattr -cr ` (note the space at the end), then drag the DeskFlow icon from "Applications" directly into the terminal window, and the path will generate automatically.

---

### 🪟 Windows Installation (Client)

1.  **Download Installer**:
    * Also visit the Releases page: [https://github.com/deskflow/deskflow/releases](https://github.com/deskflow/deskflow/releases)
    * Find the latest version.
    * Download the file ending in `.msi` (e.g., `deskflow-v1.x.x-windows-x86_64.msi`).
2.  **Install**:
    * Double-click to run the `.msi` file.
    * Click **Next** until installation is complete.
    * *(If prompted that the Bonjour service is missing, it is recommended to install it. It helps with automatic device discovery, though it is not strictly required)*.

---

## 3. Critical Permissions (macOS Required) 🛡️

After installation, DeskFlow **must** obtain macOS system-level permissions to control the mouse.

1.  Open DeskFlow. The system will prompt for permissions (if not, go to Settings manually).
2.  Go to **System Settings** -> **Privacy & Security**.
3.  **Enable the following two permissions**:
    * **Accessibility** -> Find DeskFlow and toggle it ON.
    * **Input Monitoring** -> Find DeskFlow and toggle it ON.
4.  **Restart the App**: After enabling permissions, you **must completely quit DeskFlow (Cmd+Q) and reopen it** for changes to take effect.

---

## 4. Interconnection Configuration Guide

### Step 1: Mac Setup (Server - Host)
1.  Open DeskFlow.
2.  In the **Server Configuration** area, check **Use this computer's mouse and keyboard**.
3.  Click the **Configure Server...** button to enter the layout interface.
4.  **Configure Screen Layout**:
    * You will see an icon in the center of the grid (representing your Mac).
    * Drag a monitor icon from the top right into the grid (place it to the left or right of the Mac, depending on your Windows monitor's actual position).
5.  **⚠️ Critical Step: Modify Screen Name**
    * **Double-click** the newly dragged icon (representing Windows).
    * In **Screen Name**, enter a name using **pure English characters** (e.g., `win-client`).
    * **Warning**: The default name might be "Unnamed" or contain Chinese/Special characters. **This will cause a DeskFlow startup error** (`invalid character`). Be sure to change it to English!
6.  Click OK to save.

### Step 2: Windows Setup (Client - Guest)
1.  Open DeskFlow.
2.  In the **Client Configuration** area, check **Use another computer's mouse and keyboard**.
3.  **Screen Name**: Enter the name you just set on the Mac (e.g., `win-client`). **Must match exactly!**
4.  **Server IP**: Enter the IP address shown on the Mac interface (e.g., `192.168.1.5`).
    * *Note: If Mac shows multiple IPs, it's usually the one starting with `192.168.x.x`.*
5.  Click **Start**.

### Step 3: Start Connection
1.  Back to Mac, click **Start**.
2.  A system fingerprint/password confirmation may pop up on the Mac screen; click "Allow".
3.  **Verify**: Try moving the mouse off the edge of the Mac screen. The cursor should magically "fly" onto the Windows screen!

---

## ➡️ Next Step

After successfully connecting, you may find Windows shortcuts (like copy/paste) awkward, or F1 keys not working.

Please proceed to the next section: **[⌨️ Key Mapping Configuration](./en/2-key-mapping.md)**