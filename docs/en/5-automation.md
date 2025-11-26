# 🧪 One-Click Automation Scripts (Beta)

::: warning ⚠️ Experimental Feature
The following scripts aim to automate environment installation and configuration via the command line.
Due to differences in system environments (macOS/Windows versions, network environments), these scripts **have not undergone large-scale compatibility testing**.
Please read the code before use and ensure you understand what the script is about to execute.
:::

We have prepared Shell (macOS) and PowerShell (Windows) scripts for advanced users to complete the following tasks with one click:
* ✅ Auto-install DeskFlow, LocalSend, BlackHole/SonoBus
* ✅ Auto-fix macOS app signature (`xattr`)
* ✅ **Auto-generate configuration file with key mapping**
* ✅ Auto-guide firewall or system permission settings

---

## 🍎 macOS One-Click Setup Script

This script automatically detects Homebrew, installs software, generates configuration files, and opens Accessibility settings.

### Usage

1.  Open **Terminal**.
2.  Create a script file and paste the code:
    ```bash
    nano setup_mac.sh
    # Paste the code below, then press Ctrl+O to save, Ctrl+X to exit
    ```
3.  Grant execution permission and run:
    ```bash
    chmod +x setup_mac.sh
    ./setup_mac.sh
    ```

### Script Code (setup_deskbridge.sh)

::: details Click to expand Shell script code
<<< @/../scripts/setup_deskbridge.sh
:::

*(Note: If the code above does not display, please visit the repository directory `/scripts/setup_deskbridge.sh` to view it)*

---

## 🪟 Windows One-Click Setup Script

This script uses Winget and GitHub API to auto-install software, configure firewall rules, and guide audio settings.

### Usage

1.  Create a new text document on the desktop and rename it to `setup_win.ps1` (Note the `.ps1` extension).
2.  Right-click the file -> **Edit**, paste the code below and save.
3.  **Right-click the file** -> Select **"Run with PowerShell"**.
4.  *If prompted that scripts cannot be run, open PowerShell as Administrator and enter:*
    ```powershell
    Set-ExecutionPolicy RemoteSigned
    # Enter Y to confirm
    ```

### Script Code (setup_deskbridge.ps1)

::: details Click to expand PowerShell script code
<<< @/../scripts/setup_deskbridge.ps1
:::

*(Note: If the code above does not display, please visit the repository directory `/scripts/setup_deskbridge.ps1` to view it)*