#Requires AutoHotkey v2.0

; ==========================================
; 1. Top Layer: 全局定义与环境限制
; ==========================================
global lastMinimizedWindow := 0

;#HotIf ; 确保下方快捷键在全局生效

; ==========================================
; 2. Middle Layer: 核心逻辑 (扁平化结构)
; ==========================================

; --- 窗口最小化逻辑 (按下 Left + Down) ---
~Left & Down::{
    global lastMinimizedWindow
    lastMinimizedWindow := WinExist("A") ; 获取当前活动窗口句柄
    WinMinimize "A"
}

; --- 窗口还原逻辑 (按下 Left + Up) ---
~Left & Up::{
    global lastMinimizedWindow
    ; 只要记录了句柄且该窗口还存在，就直接还原并激活
    if (lastMinimizedWindow && WinExist(lastMinimizedWindow)) {
        WinRestore(lastMinimizedWindow)
        WinActivate(lastMinimizedWindow)
    }
}

; --- RCtrl 快捷中心 (任务栏 1-9 + q 最小化) ---
~RCtrl Up::{
    ih := InputHook("L1 T0.5")
    ih.Start()
    ih.Wait()

    switch ih.Input {
        case "1": SendInput "#1"
        case "2": SendInput "#2"
        case "3": SendInput "#3"
        case "4": SendInput "#4"
        case "5": SendInput "#5"
        case "6": SendInput "#6"
        case "7": SendInput "#7"
        case "8": SendInput "#8"
        case "9": SendInput "#9"
        case "o": SendInput "^o"  ; RCtrl -> o 打开文件
        case "v": SendInput "^v"  ; RCtrl -> v 粘贴
        case "q": WinMinimize "A"
        case "{Esc}": return ; km_ 专属重置标记
    }
}

; ==========================================
; 3. Bottom Layer: 密封
; ==========================================
;#HotIf