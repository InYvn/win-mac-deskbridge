<#
.SYNOPSIS
    🌉 Win-Mac DeskBridge Windows 端一键配置脚本
.DESCRIPTION
    自动安装 DeskFlow/LocalSend/SonoBus，配置防火墙规则，引导音频和SMB设置。
.NOTES
    需要以管理员权限运行。
#>

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "    🌉 Win-Mac DeskBridge Windows Setup  " -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# --- 检查管理员权限 ---
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "请以管理员身份运行此脚本！(右键 -> 使用 PowerShell 运行)"
    Start-Sleep -Seconds 3
    Exit
}

# --- 1. 使用 Winget 安装常用工具 (LocalSend, SonoBus) ---
Write-Host "`n[1/4] 正在检查并安装基础软件 (Winget)..." -ForegroundColor Yellow

$tools = @{
    "LocalSend" = "LocalSend.LocalSend";
    "SonoBus"   = "SonoBus.SonoBus"
}

foreach ($name in $tools.Keys) {
    $id = $tools[$name]
    Write-Host "正在检查 $name..."
    winget list -e $id | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "正在安装 $name..." -ForegroundColor Green
        winget install --id $id -e --source winget --accept-package-agreements --accept-source-agreements
    } else {
        Write-Host "$name 已安装，跳过。" -ForegroundColor Gray
    }
}

# --- 2. 手动下载并安装 DeskFlow (GitHub Releases) ---
# 因为 DeskFlow 较新，Winget 可能未收录，我们直接从 GitHub 抓取最新 msi
Write-Host "`n[2/4] 正在获取 DeskFlow 最新版本..." -ForegroundColor Yellow

$repo = "deskflow/deskflow"
$releasesUrl = "https://api.github.com/repos/$repo/releases/latest"

try {
    # 获取最新版本的下载链接 (查找 windows-x86_64.msi)
    $release = Invoke-RestMethod -Uri $releasesUrl
    $asset = $release.assets | Where-Object { $_.name -match "windows-x86_64.msi$" } | Select-Object -First 1
    
    if ($asset) {
        $downloadUrl = $asset.browser_download_url
        $outFile = "$env:TEMP\deskflow_installer.msi"
        
        Write-Host "正在下载: $($asset.name)" -ForegroundColor Green
        Invoke-WebRequest -Uri $downloadUrl -OutFile $outFile
        
        Write-Host "正在静默安装 DeskFlow..." -ForegroundColor Green
        # 启动 MSI 安装
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$outFile`" /quiet /norestart" -Wait
        Write-Host "DeskFlow 安装完成！" -ForegroundColor Green
    } else {
        Write-Error "未找到 Windows 安装包，请手动下载。"
    }
} catch {
    Write-Error "下载失败: $_"
    Write-Warning "请手动访问 https://github.com/deskflow/deskflow/releases 下载安装。"
}

# --- 3. 配置防火墙 (至关重要) ---
Write-Host "`n[3/4] 配置防火墙规则..." -ForegroundColor Yellow
$progPath = "C:\Program Files\DeskFlow\deskflow.exe" # 默认路径，根据实际情况可能需要调整

if (Test-Path $progPath) {
    # 删除旧规则（如果有）
    Remove-NetFirewallRule -DisplayName "DeskFlow Allowed" -ErrorAction SilentlyContinue
    
    # 添加新规则：允许 DeskFlow 在专用和公用网络通信
    New-NetFirewallRule -DisplayName "DeskFlow Allowed" -Direction Inbound -Program $progPath -Action Allow -Profile Any | Out-Null
    Write-Host "防火墙规则已添加：允许 DeskFlow 通信。" -ForegroundColor Green
} else {
    Write-Warning "未找到 DeskFlow 主程序，跳过防火墙配置。请手动允许 deskflow.exe 通过防火墙。"
}

# --- 4. 引导后续设置 ---
Write-Host "`n[4/4] 正在打开系统设置面板..." -ForegroundColor Yellow

# 打开声音录制面板 (方便设置 Line-In 侦听)
Write-Host "-> 打开声音录制面板 (请找到 '线路输入' -> 属性 -> 侦听)"
Start-Process "mmsys.cpl" -ArgumentList ",1"

# 打开映射网络驱动器向导
Write-Host "-> 打开映射网络驱动器向导 (请输入 Mac 的 SMB 地址)"
# 这是一个黑科技命令，直接唤起“映射网络驱动器”窗口
$objShell = New-Object -ComObject Shell.Application
$objShell.FileRun() 
#以此提示用户输入 \\IP 

Write-Host "`n=========================================" -ForegroundColor Green
Write-Host "   ✅ Windows 端配置脚本执行完毕" -ForegroundColor Green
Write-Host "=========================================" 
Write-Host "下一步："
Write-Host "1. 在刚才弹出的声音窗口中配置音频侦听。"
Write-Host "2. 打开桌面的 DeskFlow 图标，填入 Client 配置。"
Write-Host "3. 按 Win+R 输入 \\Mac-IP 访问文件。"
Start-Sleep -Seconds 5