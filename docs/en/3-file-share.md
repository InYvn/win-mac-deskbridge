# 📂 High-Speed File Tunnel

This solution adopts a **"Dual-track"** strategy:
1.  **SMB Protocol**: Mounts the Mac hard drive as a Windows network drive, suitable for large file reading/writing and code editing.
2.  **LocalSend**: Suitable for ad-hoc transfer of images and text across devices, similar to AirDrop.

---

## Method 1: System-level Mounting (SMB) - Recommended

Configure this once and benefit forever. Once configured, Mac folders will appear in Windows "This PC" just like a USB drive.

### Step 1: Enable Sharing on Mac (Server)

1.  **Open Settings**:
    * Click the Apple icon  in the top left -> **System Settings**.
2.  **Find Sharing**:
    * Click **General** -> **Sharing**.
3.  **Enable File Sharing**:
    * Find **File Sharing** and toggle the switch on the right.
    * Click the **"i" icon** on the right (Details/Settings).
4.  **Add Shared Folders**:
    * Under the "Shared Folders" section, click the **"+"** button.
    * Select the folder you want Windows to access (adding "Downloads" or "Desktop" is recommended; Administrator accounts have access to all paths by default).
5.  **⚠️ Critical Step (Most Important!)**:
    * Click the **"Options..."** button in the same window.
    * Ensure **"Share files and folders using SMB"** is checked.
    * **Crucial Step**: In the "Windows File Sharing" list below, **you must check your account name**.
    * The system will prompt for a password; enter your **Mac login password** to confirm.
    * Click "Done".
6.  **Note the Address**:
    * With "File Sharing" enabled, you will see a line of small text: *"Users on your network can access your computer at smb://192.168.x.x"*.
    * **Write down this IP address** (e.g., `192.168.1.5`).

### Step 2: Connect from Windows (Client)

1.  **Open Run Window**:
    * Press `Win + R` on the Windows keyboard.
2.  **Enter Address**:
    * Enter the Mac's IP address.
    * **Note**: Windows must use **backslashes** `\`, not `smb://`.
    * **Format**: `\\192.168.x.x`
    * *(e.g., If Mac says 192.168.1.5, you enter `\\192.168.1.5`)*
    * Click OK.
3.  **Enter Authentication**:
    * Windows will pop up a login box.
    * **Username**: Enter your **Mac username**.
        > 💡 **Tip**: If you are unsure what the username is, open Mac Terminal and type ```whoami```; the name displayed is the correct system username.
    * **Password**: Enter your **Mac login password**.
4.  **Connection Successful**:
    * If validation passes, the Mac's shared folder will appear in the Windows File Explorer.

> **Pro Tip: Map Network Drive**
> In the opened shared folder window, right-click the folder -> Select **"Map network drive"** -> Assign a drive letter (e.g., Z:) -> Check "Reconnect at sign-in".
> This way, the Z: drive remains available after restarting the computer, without re-entering the IP.

---

## Method 2: LocalSend (Ad-hoc Transfer)

If you don't want to configure complex network sharing and just want to send a picture to the computer next to you, **LocalSend** is the best choice. It is an open-source, free AirDrop alternative.

1.  **Download & Install**:
    * Download and install [LocalSend](https://localsend.org) on both Mac and Windows.
2.  **How to Use**:
    * Ensure both devices are connected to the same WiFi.
    * Open the app; they will automatically discover each other.
    * Select File -> Click the other person's avatar -> Send.
3.  **Settings Suggestion**:
    * Enable **"Quick Save"** in settings so you don't have to manually click "Accept" when receiving files, making the experience smoother.

---

## ✅ Configuration Complete

You have now established a file transfer tunnel between both ends.

Please proceed to the final section to solve audio issues: **[🔊 Zero-Latency Audio Bridge](./en/4-audio-share.md)**