# ================================
# AutoSubstProject.ps1
# ================================

$DriveLetter = "Z:"
$RootPath    = "D:\Work"

$projectKey = Read-Host "请输入项目编号 (如 2601017)"
if ([string]::IsNullOrWhiteSpace($projectKey)) {
    exit
}

# 查找匹配的目录（只取一个，按最近修改排序）
$projectDir = Get-ChildItem -Path $RootPath -Directory -Recurse -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -like "*$projectKey*" } |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

if (-not $projectDir) {
    Write-Host "未找到匹配的项目目录：$projectKey"
    exit
}

# 卸载旧映射（不关心成败）
subst $DriveLetter /d | Out-Null

# 挂载新目录
subst $DriveLetter $projectDir.FullName

if ($LASTEXITCODE -ne 0 -or -not (Test-Path "$DriveLetter\")) {
    Write-Host "Z: 盘映射失败"
    exit
}

# 打开资源管理器
explorer.exe "$DriveLetter\"

# 强制退出当前进程
Stop-Process -Id $PID