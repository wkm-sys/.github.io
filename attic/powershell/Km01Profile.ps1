function wd { 
    $target = fd . D:\ --type d | fzf
    if ($target) {
        Invoke-Item "$target"
    }
}

# [qr] - Quick QR: 给指定字符串生成二维码
function qr {
    param($Text)
    if (-not $Text) { Write-Host "请输入要转换的文字或链接！" -ForegroundColor Red; return }
    $outFile = "$env:TEMP\km_qr_temp.png"
    qrencode -s 10 -m 2 -o $outFile $Text
    Invoke-Item $outFile
    Write-Host "二维码已生成并打开。" -ForegroundColor Green
}

function prompt {
    # 1. 瞬间捕获状态（第一优先，不能被干扰）
    $lastStatus = $?
    $timeStr = Get-Date -Format "yyyy-MM-dd ddd HH:mm:ss"
    
    # 2. 定义心情库 (保留你最爱的表情)
    if ($lastStatus) {
        $faces = @("^_^", ":-)", "⊙_⊙", "∩_∩")
        $faceColor = "DarkYellow"
        $entryColor = "Yellow"   # 成功时，入口用你最喜欢的青色
    } else {
        $faces = @(">_<", "(-_-)", "o_O", "(╯°□°）╯", "X_X")
        $faceColor = "Red"
        $entryColor = "Red"    # 失败时，入口变红警告
    }
    $randomFace = $faces | Get-Random

    # 3. 渲染第一行：WoW 掉落风格 (摒弃 DarkGray，改用更高级的配色)
    Write-Host "`nPS " -NoNewline -ForegroundColor DarkYellow      
    Write-Host "$timeStr " -NoNewline -ForegroundColor DarkYellow   
    Write-Host "KM@KM" -ForegroundColor Yellow               

    # 4. 渲染第二行：RPG 交互层
    Write-Host "$randomFace " -NoNewline -ForegroundColor $faceColor
    Write-Host "PS>" -NoNewline -ForegroundColor $entryColor
    
    return " " 
}

function kmcheck {
    Write-Host "--- Port Status ---" -ForegroundColor Cyan
    
    # 增加 -State Listen 过滤，只看真正活着的服务
    $alist = Get-NetTCPConnection -LocalPort 5244 -State Listen -ErrorAction SilentlyContinue
    if ($alist) { 
        Write-Host "[5244] Alist 运行中" -ForegroundColor Green 
    } else { 
        Write-Host "[5244] Alist 未启动" -ForegroundColor Gray 
    }

    $debug = Get-NetTCPConnection -LocalPort 8000 -State Listen -ErrorAction SilentlyContinue
    if ($debug) { 
        Write-Host "[8000] 调试服务开启中" -ForegroundColor Yellow 
    } else { 
        Write-Host "[8000] 调试口空闲" -ForegroundColor Green 
    }
}
# 2026-02-13
function opz {
    param($Drive = "Z")

    $Drive = $Drive.TrimEnd(':') + ':'

    $mapping = subst | Where-Object { $_ -match "^$Drive" }

    if ($mapping) {
        $path = ($mapping -split '=>')[1].Trim()
        Invoke-Item $path
    }
    else {
        Write-Host "$Drive not found in subst mappings."
    }
}
# nanob ps version
function nanob {
    nano -l +999 $PROFILE
}
# sb ps version
function sb {
    . $PROFILE
    Write-Host ""
    Write-Host "SYSTEM RELOAD COMPLETE [$((Get-Date).ToString('HH:mm:ss'))]" -ForegroundColor Green
}
# kmlist ps version
function kmlist {
    Write-Host "`n--- KM Command List ---" -ForegroundColor DarkYellow
    
    $custom = Get-Command -CommandType Function |
        Where-Object { $_.ScriptBlock.File -eq $PROFILE }

    foreach ($cmd in $custom) {
        Write-Host $cmd.Name -ForegroundColor Green
    }
}
#2026-02-13 by KM
function ll { eza -l}
function la { eza -la }
function lt { eza --tree }
function ls { eza }
# add 20260218
function brii {
    # 创建临时文件记录路径
    $tmp = New-TemporaryFile
    broot --outcmd $tmp
    if (Test-Path $tmp) {
        $cmd = Get-Content $tmp
        # 提取路径并交给 ii
        if ($cmd -match 'cd\s+"?(.+?)"?$') {
            Invoke-Item $matches[1]
        }
        Remove-Item $tmp
    }
}
