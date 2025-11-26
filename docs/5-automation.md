# 🧪 一键自动化脚本 (Beta)

::: warning ⚠️ 实验性功能
以下脚本旨在通过命令行自动化完成环境安装与配置。
由于系统环境（MacOS/Windows 版本、网络环境）的差异，脚本**尚未经过大规模兼容性测试**。
请在使用前阅读代码，并确保你了解脚本即将执行的操作。
:::

我们为高级用户准备了 Shell (macOS) 和 PowerShell (Windows) 脚本，可一键完成以下任务：
* ✅ 自动安装 DeskFlow, LocalSend, BlackHole/SonoBus
* ✅ 自动修复 macOS 应用签名 (`xattr`)
* ✅ **自动生成包含键位映射的配置文件**
* ✅ 自动引导打开防火墙或系统权限设置

---

## 🍎 macOS 一键配置脚本

此脚本会自动检测 Homebrew，安装软件，生成配置文件，并打开辅助功能设置页。

### 使用方法

1.  打开终端 (Terminal)。
2.  创建一个脚本文件并粘贴代码：
    ```bash
    nano setup_mac.sh
    # 粘贴下方代码，然后按 Ctrl+O 保存，Ctrl+X 退出
    ```
3.  赋予执行权限并运行：
    ```bash
    chmod +x setup_mac.sh
    ./setup_mac.sh
    ```

### 脚本代码 (setup_deskbridge.sh)

::: details 点击展开查看 Shell 脚本代码
<<< @/../scripts/setup_deskbridge.sh
:::

*(注：如果上方代码无法显示，请访问仓库目录 `/scripts/setup_deskbridge.sh` 查看)*

---

## 🪟 Windows 一键配置脚本

此脚本利用 Winget 和 GitHub API 自动安装软件，配置防火墙规则，并引导音频设置。

### 使用方法

1.  在桌面新建一个文本文档，重命名为 `setup_win.ps1` (注意后缀是 `.ps1`)。
2.  右键文件 -> **编辑**，粘贴下方代码并保存。
3.  **右键文件** -> 选择 **“使用 PowerShell 运行”**。
4.  *如果提示无法运行脚本，请以管理员身份打开 PowerShell 并输入：*
    ```powershell
    Set-ExecutionPolicy RemoteSigned
    # 输入 Y 确认
    ```

### 脚本代码 (setup_deskbridge.ps1)

::: details 点击展开查看 PowerShell 脚本代码
<<< @/../scripts/setup_deskbridge.ps1
:::

*(注：如果上方代码无法显示，请访问仓库目录 `/scripts/setup_deskbridge.ps1` 查看)*