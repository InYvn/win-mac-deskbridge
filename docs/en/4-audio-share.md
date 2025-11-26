# 🔊 Zero-Latency Audio Bridge

This module aims to solve the "audio fragmentation" problem for dual-machine users, achieving **unified audio playback through the main speakers/headphones connected to Windows**, eliminating the need for two sets of speakers on your desk.

---

## Method 1: Hardware Direct Connection (Zero Latency, Most Recommended) 🎧

If your Windows machine is a desktop and the two computers are close to each other, this is the **once-and-for-all, most stable** solution.

### 1. Principle & Cost
* **Principle**: Use a 3.5mm AUX cable (male-to-male audio cable) to directly "feed" the Mac's analog audio signal into the Windows sound card input.
* **Cost**: One cable (a few dollars).

### 2. Physical Connection
* Plug one end of the cable into the **Mac's Headphone Jack**.
* Plug the other end into the **Blue Port (Line-In)** on the **back of the Windows PC**.
    * *Note: It is usually blue. Do not plug it into the Pink (Microphone) or Green (Headphone) port.*

### 3. Windows Setup
We need to tell Windows: "Play the sound heard from Line-In through the speakers in real-time."

1.  **Open Sound Settings**:
    * Right-click the volume icon 🔈 in the bottom right of the taskbar -> **Sound Settings**.
    * Click **More sound settings** (Win11) at the bottom or open **Sound Control Panel** directly (Win10).
2.  **Configure Recording Device**:
    * Switch to the **Recording** tab.
    * Find **Line In**, right-click it -> **Properties**.
3.  **Enable "Listen"**:
    * Switch to the **Listen** tab.
    * ✅ Check **"Listen to this device"**.
    * Click **Apply**.

### 4. Effect & Optimization
At this point, if you play music on your Mac, the sound should come out of the Windows speakers with **absolutely no latency**.

> **⚠️ Eliminate Background Noise (Buzzing Sound)**
> If you hear a buzzing electrical noise (ground loop interference), it is recommended to connect a **"Ground Loop Isolator"** in series with the audio cable. It costs about $2-3 and completely eliminates the noise.

---

## Method 2: Software Solution - SonoBus (Open Source, Low Latency) 📶

If you don't want to buy cables or are using a laptop (no Line-In port), **SonoBus** is the best free, open-source, cross-platform audio transmission software available. Designed for musicians, it offers extremely low LAN latency (<10ms).

### Step 1: Install the "Bridge" on Mac (BlackHole)
macOS does not allow software to record system audio directly, so we need to install a virtual audio driver, **BlackHole**, to act as a bridge.

1.  Open **Terminal**.
2.  Use Homebrew to install the 2-channel version:
    <三点>bash
    brew install blackhole-2ch
    <三点>
    *(If you don't have Homebrew, you can also download the installer from the BlackHole official website)*
3.  **Restart Mac** (Important: Audio drivers usually require a restart to be recognized).

### Step 2: Configure Mac (Sender)
We need to "pour" the Mac system audio into BlackHole, and then let SonoBus "scoop" it out from BlackHole to send it.

1.  **Modify Mac System Output**:
    * Click the sound icon in the top menu bar (or go to System Settings -> Sound).
    * Change **Output** from "MacBook Speakers" to **"BlackHole 2ch"**.
    * *⚠️ Note: Your Mac will suddenly go silent at this point. This is normal because the sound is flowing into the virtual pipe!*
2.  **Configure SonoBus Input**:
    * Open SonoBus and click the **Settings ⚙️ icon** (Input Setup) at the top left.
    * **Audio Device**: Select `BlackHole 2ch`.
    * **Sample Rate**: Recommended `48000`.
    * **Channel**: Select `1/2`.
3.  **Verify Signal**:
    * Play a song on your Mac and observe the **Green Level Bar** on the left side of SonoBus. If it's jumping, the sound has successfully entered.

### Step 3: Configure Windows (Receiver)
We need Windows to receive this signal and play it through your physical speakers.

1.  **Configure SonoBus Output**:
    * Open SonoBus on Windows and click the **Settings ⚙️ icon** (Output Setup) at the bottom.
    * **Output**: Select your active **Speakers (Realtek)** or **Headphones**.
    * Ensure the **Monitor Mix** slider at the bottom right is pushed up (usually full by default).
2.  **Establish Connection**:
    * Click the **Connect...** button on the main interface of both computers.
    * In the **Local Network** list, you should be able to see the other computer directly. Click to connect.

### Step 4: Final Adjustment
After a successful connection, a **Long Track Bar** representing the Mac will appear in the middle of the Windows SonoBus interface.
* Do you see the green levels jumping on that track?
* If it's jumping but there is no sound, check if the **Mute** button on that track is lit, or turn up the volume slider on the track.

---

## ✅ Full Process Complete

🎉 **Congratulations!** You have completed the all-around interconnection of **Mouse/Keyboard, Clipboard, Files, and Audio**.
Now, your Mac and Windows work together seamlessly like a single computer.