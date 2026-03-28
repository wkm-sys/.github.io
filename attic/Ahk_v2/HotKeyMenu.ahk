#SingleInstance Force
#Requires AutoHotkey v2.0

MyMenu := Menu()
MyMenu.Add("AutoSubstProject", MenuHandler)
MyMenu.Add("WinAlwaysOnTop", MenuHandler)
MyMenu.Add()  ; Add a separator line.
MyMenu.Add("UseEveryThing", MenuHandler)
MyMenu.Add()  ; Add a separator line.
MyMenu.Add("Open WorkPath", MenuHandler)
MyMenu.Add("Edit WorkPath", MenuHandler)
MyMenu.Add("Hotstrings Date", MenuHandler)
MyMenu.Add()  ; Add a separator line.
MyMenu.Add("DropToPhone", MenuHandler)
MyMenu.Add()  ; Add a separator line.
MyMenu.Add("SendToMenu", MenuHandler)
MyMenu.Add("WindowHistory_Run", MenuHandler)
MyMenu.Add()  ; Add a separator line.
; Create another menu destined to become a submenu of the above menu.
Submenu1 := Menu()
Submenu1.Add("SendToMenu", MenuHandler)
Submenu1.Add("WindowHistory_Run", MenuHandler)

; Create a submenu in the first menu (a right-arrow indicator). When the user selects it, the second menu is displayed.
MyMenu.Add("My Submenu", Submenu1)

MenuHandler(Item, *) {
    if (Item = "WinAlwaysOnTop") {
        ;MsgBox("快捷键Ctrl+Alt+Home:切换窗口置顶`n执行逻辑: WinSetAlwaysOnTop")
        WinSetAlwaysOnTop(-1, "A")
        SoundPlay "*16"
        ExStyle := WinGetExStyle("A") & 0x8
        Tooltip ExStyle ? "置顶 → ON" : "置顶 → OFF"
        SetTimer(() => Tooltip(""), -1000)
    }
    else if (Item = "Hotstrings Date") {
        ;MsgBox("热子串tt`n功能: 显示日期`n执行逻辑: FormatTime")
        SendInput FormatTime(, "yyyy-MM-dd")
    }
    else if (Item = "Open WorkPath") {
        ;MsgBox("快捷键^\:: 文件夹`n执行逻辑: Run Path")
        ;Run "explorer " WorkPath
        Run "D:\UserW\Scripts\Ahk_v2\GUI_PathManager.ahk"
    }
        else if (Item = "Edit WorkPath") {
        ;MsgBox("快捷键^]:: 文件夹`n执行逻辑: Run Path")
        ;Run "explorer D:\UserW\Scripts\Ahk_v2" 
        Run 'edit "D:\UserW\Scripts\Ahk_v2\WorkPath.ahk"'
    }
    else if (Item = "UseEveryThing") {
        ;MsgBox("Here is MsgBox Test Item")
         Send "#5"
    }
      else if (Item = "DropToPhone") {
        ;MsgBox("Here is MsgBox DropToPhone")
        Run "D:\UserW\Scripts\Ahk_v2\DropToPhone.ahk"
    }
    else if (Item = "SendToMenu") {
        ;MsgBox("Here is MsgBox Item A")
        SendToMenu.Show()
    }
      else if (Item = "WindowHistory_Run") {
        ;MsgBox("Here is MsgBox Item B")
        Run "D:\UserW\Scripts\Ahk_v2\WindowHistory_Run.ahk"
    }
    else if (Item = "AutoSubstProject") {
        ;MsgBox("Here is MsgBox AutoSubstProject")
        ; 在你的 AHK 脚本里这样写：
        Run(A_ComSpec ' /c powershell.exe -NoExit -ExecutionPolicy Bypass -File "D:\UserW\Scripts\Ahk_v2\KM_AutoSubstProject_v2.ps1"')
    }
}

^End::
^!a::MyMenu.Show()
