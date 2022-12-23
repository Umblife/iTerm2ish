#SingleInstance

#Include vd.ahk
VD.init()


GetMouseDisplay() {
    ; get number of monitors
    SysGet, MCnt, MonitorCount

    ; get mouse position
    CoordMode, Mouse, Screen
    MouseGetPos, x, y

    ; get monitor index the mouse cursor on
    monitor_idx = 1     ; default monitor index
    Loop, %MCnt% {
        SysGet, Mon, Monitor, %A_Index%
        If (MonLeft <= x and x < MonRight and MonTop <= y and y < MonBottom) {
            monitor_idx = %A_Index%
            Break
        }
    }

    Return monitor_idx
}


IsMaximized(app_id, display_idx) {
    ; get monitor info the mouse cursor on
    SysGet, Mon, MonitorWorkArea, %display_idx%

    ; get target app position
    WinGetPos, x1, y1, width, height, ahk_id %app_id%
    x2 := x1 + width
    y2 := y1 + height

    If (x1 < MonLeft and x2 > MonRight and y1 < MonTop and y2 > MonBottom) {
        Return True
    }
    Else {
        Return False
    }
}


AppActiveToggle(app_id) {
    display_idx := GetMouseDisplay()

    ; toggle application
    If (WinActive("ahk_id " app_id) and IsMaximized(app_id, display_idx)) {
        WinMinimize, ahk_id %app_id%
    }
    Else {
        ; activate target app
        VD.MoveWindowToCurrentDesktop("ahk_id " app_id)
        ; VD.MoveWindowToCurrentDesktop(ahk_id %app_id%)
        ; VD.MoveWindowToDesktopNum("ahk_id " app_id, 2)
        WinRestore, ahk_id %app_id%
        SysGet, Mon, MonitorWorkArea, %display_idx%
        width := MonRight - MonLeft
        height := MonBottom - MonTop
        WinMove, ahk_id %app_id%, , MonLeft, MonTop, width, height
        WinMaximize, ahk_id %app_id%
        WinActivate, ahk_id %app_id%
        WinWaitActive, ahk_id %app_id%, , 1
    }
}


^\::    ; Ctrl + \
    ; -------------------------------------------------------------------------
    WinGet, OutputVar, List, , , unchiburi
    ; Loop, %OutputVar% {
    ;     WinGetTitle, tmptitle, ahk_id OutputVar1
    ;     MsgBox, %tmptitle%
    ;     SysGet, Mon, Monitor, %A_Index%
    ;     If (MonLeft <= x and x < MonRight and MonTop <= y and y < MonBottom) {
    ;         monitor_idx = %A_Index%
    ;         Break
    ;     }
    ; }
    ; MsgBox, %OutputVar1%
    WinGetTitle, tmptitle, ahk_id %OutputVar1%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar2%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar3%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar4%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar5%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar6%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar7%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar8%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar9%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar10%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar11%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar12%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar13%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar14%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar15%
    MsgBox, %tmptitle%
    WinGetTitle, tmptitle, ahk_id %OutputVar16%
    MsgBox, %tmptitle%
    Return
    ; -------------------------------------------------------------------------
    target_app := "ahk_exe WindowsTerminal.exe"
    TLevel := 180   ; 0 ~ 255, OFF

    ; run target application
    If not WinExist(target_app) {
        ; Run, "target App path or make the shortcut in .ahk directory"
        Run, .\WindowsTerminal
        Sleep, 1000
    }
    ; get target application id
    WinGet, app_id, ID, %target_app%

    ; --- ONLY WINDOWS 10 -----------------------------------------------------
    ; set transparent
    WinGet, CurrentTLevel, Transparent, ahk_id %app_id%
    If (CurrentTLevel = OFF) {
        WinSet, Transparent, %TLevel%, ahk_id %app_id%
    }
    ; -------------------------------------------------------------------------

    ; toggle
    AppActiveToggle(app_id)
    return
