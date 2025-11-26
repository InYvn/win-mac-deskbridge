# 🖱️ 键鼠与剪切板共享 (DeskFlow 配置指南)

本模块指导你如何搭建 **DeskFlow**，实现一套键鼠控制两台电脑，并共享剪切板。

## 1. 环境准备
* **网络**：确保两台电脑连接在同一个局域网（建议使用 5G WiFi 或有线连接以降低延迟）。
* **设备角色**：
    * **Server (服务端)**：Mac (物理键鼠连接在此设备，作为主控)。
    * **Client (客户端)**：Windows PC (被控制的设备)。

---

## 2. 下载与安装

### 🍎 macOS 端安装 (Server)

我们提供两种安装方式，**推荐使用 Homebrew**，如果你不熟悉命令行，请使用**手动安装**。

#### 方式 A：使用 Homebrew (推荐)
自动管理依赖，无需手动修复权限。
```bash
# 1. 添加官方仓库
brew tap deskflow/homebrew-tap

# 2. 安装 DeskFlow
brew install deskflow
```

#### 方式 B：手动下载安装包 (GitHub Releases)
如果你没有 Homebrew，请按以下步骤操作：

1.  **下载 DMG 文件**：
    * 访问 Releases 页面：[https://github.com/deskflow/deskflow/releases](https://github.com/deskflow/deskflow/releases)
    * 找到最新版本（例如 v1.17.x 或更高）。
    * **根据芯片选择**：
        * **M1/M2/M3/M4 等 (Apple Silicon)**: 下载 `...-macos-arm64.dmg`
        * **Intel 芯片**: 下载 `...-macos-x86_64.dmg`
2.  **安装**：
    * 打开 `.dmg` 文件，将 `DeskFlow.app` 拖入“应用程序”文件夹。
3.  **关键步骤：修复“应用已损坏”报错** 🛠️
    * 因为开源软件没有苹果的付费签名，直接打开通常会报错“无法打开”或“移到废纸篓”。
    * **不要慌，请执行以下修复命令：**
    * 打开 **终端 (Terminal)**，复制以下命令并回车（可能需要输入开机密码，密码输入时看不见是正常的）：
        ```bash
        sudo xattr -cr /Applications/DeskFlow.app
        ```
    > **小技巧**：如果你不确定安装路径，可以先输入 `sudo xattr -cr ` (注意最后有个空格)，然后把“应用程序”里的 DeskFlow 图标直接**拖进**终端窗口，路径就自动生成了。

---

### 🪟 Windows 端安装 (Client)

1.  **下载安装包**：
    * 同样访问 Releases 页面：[https://github.com/deskflow/deskflow/releases](https://github.com/deskflow/deskflow/releases)
    * 找到最新版本。
    * 下载以 `.msi` 结尾的文件（例如 `deskflow-v1.x.x-windows-x86_64.msi`）。
2.  **安装**：
    * 双击运行 `.msi` 文件。
    * 一路点击 **Next** 直到安装完成。
    * *(如果系统提示缺少 Bonjour 服务，建议勾选安装，它有助于设备自动发现，虽然不是必须的)*。

---

## 3. 关键权限配置 (macOS 必做) 🛡️

安装好后，DeskFlow 想要控制鼠标，**必须**获取 macOS 的系统级权限。

1.  打开 DeskFlow，系统会弹出请求权限的提示（如果没有弹出，请手动前往设置）。
2.  前往 **系统设置 (System Settings)** -> **隐私与安全性 (Privacy & Security)**。
3.  **开启以下两项权限**：
    * **辅助功能 (Accessibility)** -> 找到 DeskFlow 并打开开关。
    * **输入监控 (Input Monitoring)** -> 找到 DeskFlow 并打开开关。
4.  **重启软件**：权限开启后，**必须彻底退出 DeskFlow (Cmd+Q) 再重新打开一次**，确保权限生效。

---

## 4. 互联配置指南

### 第一步：Mac 端设置 (Server - 主控)
1.  打开 DeskFlow。
2.  在 **Server Configuration** 区域，勾选 **Use this computer's mouse and keyboard** (使用本机的键鼠)。
3.  点击 **Configure Server...** 按钮，进入布局界面。
4.  **配置屏幕布局**：
    * 你会在网格中间看到一个图标（代表你的 Mac）。
    * 从右上角拖拽一个显示器图标到网格中（放在 Mac 的左边或右边，取决于你 Windows 显示器的实际摆放位置）。
5.  **⚠️ 关键步骤：修改屏幕名称**
    * **双击**那个新拖进来的图标（代表 Windows）。
    * 在 **Screen Name** 中，填入一个**纯英文字符**的名称（例如 `win-client`）。
    * **警告**：默认名称可能是“未命名”或包含中文，**这会导致 DeskFlow 启动报错** (`invalid character`)。请务必改为纯英文！
6.  点击 OK 保存。

### 第二步：Windows 端设置 (Client - 被控)
1.  打开 DeskFlow。
2.  在 **Client Configuration** 区域，勾选 **Use another computer's mouse and keyboard** (使用另一台电脑的键鼠)。
3.  **Screen Name**：填入你刚才在 Mac 端设置的那个名字（例如 `win-client`）。**必须完全一致！**
4.  **Server IP**：填入 Mac 端界面上显示的 IP 地址（例如 `192.168.1.5`）。
    * *注：如果 Mac 显示多个 IP，通常是 `192.168.x.x` 开头的那个。*
5.  点击 **Start**。

### 第三步：启动连接
1.  回到 Mac 端，点击 **Start**。
2.  Mac 屏幕上可能会弹出系统指纹/密码确认框，点击“允许”。
3.  **验证**：尝试将鼠标移出 Mac 屏幕的边缘，光标应该会神奇地“飞”到 Windows 屏幕上！

---

## ➡️ 下一步

成功连接后，你可能会发现 Windows 的快捷键（如复制粘贴）很别扭，或者 F1 功能键失效。

请前往下一节：**[⌨️ 键位映射配置 (Key Mapping)](./2-key-mapping.md)**