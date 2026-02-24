#Requires AutoHotkey v2.0
#SingleInstance force
#NoTrayIcon
; TraySetIcon "imageres.dll", 230


; ==========================================
; 1. UI 构造 (继承你的 S60 黑客风格)
; ==========================================
MyGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
MyGui.BackColor := "Black"
MyGui.SetFont("S50 W500", "Verdana") 

; 初始显示内容
ClockText := MyGui.Add("Text", "Center cWhite", FormatTime(, "M/d ddd | HH:mm:ss"))

; ==========================================
; 2. 交互逻辑 (左键拖动，右键退出)
; ==========================================
; 左键按下：允许拖动整个窗口
OnMessage(0x0201, (*) => PostMessage(0xA1, 2,,, "A"))

; 右键点击：直接退出程序
MyGui.OnEvent("ContextMenu", (*) => ExitApp())

; 快捷键：Esc 退出 (符合 Michael 习惯)
HotKey "Esc", (*) => ExitApp()

; ==========================================
; 3. 定时刷新 (让秒针跳动)
; ==========================================
SetTimer(UpdateTime, 1000)

UpdateTime() {
    ClockText.Value := FormatTime(, "M/d ddd | HH:mm:ss")
}

; ==========================================
; 4. 启动显示
; ==========================================
WinSetTransparent(200, MyGui.Hwnd)
MyGui.Show("x500 y600 NoActivate")