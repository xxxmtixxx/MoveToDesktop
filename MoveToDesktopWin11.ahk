#NoEnv
#SingleInstance force
SetBatchLines -1
SendMode Input
SetWorkingDir %A_ScriptDir%
#WinActivateForce

; Include the VD.ahk library (download from https://github.com/FuPeiJiang/VD.ahk)
#Include VD.ahk

; Hotkeys
#!m::MoveToNewDesktopAndMaximize()
#!n::MoveBackAndCloseDesktop()
#!v::ConsolidateAllDesktops()

MoveToNewDesktopAndMaximize() {
    VD.createDesktop()
    newDesktopNum := VD.getCount()
    
    WinGetTitle, winTitle, A
    WinGet, winExe, ProcessName, A
    
    appName := ""
    if (winTitle) {
        if (InStr(winTitle, " - ")) {
            appName := SubStr(winTitle, InStr(winTitle, " - ") + 3)
            if (StrLen(appName) > 20) {
                appName := RegExReplace(winExe, "\.exe$", "")
                StringUpper, appName, appName, T
            }
        } else {
            appName := RegExReplace(winExe, "\.exe$", "")
            StringUpper, appName, appName, T
        }
    } else {
        appName := RegExReplace(winExe, "\.exe$", "")
        StringUpper, appName, appName, T
    }

    VD.setNameToDesktopNum(appName, newDesktopNum)
    VD.MoveWindowToDesktopNum("A", newDesktopNum)
    VD.goToDesktopNum(newDesktopNum)
    WinMaximize, A
    return
}

MoveBackAndCloseDesktop() {
    currentDesktopNum := VD.getCurrentDesktopNum()
    if (currentDesktopNum = 1)
        return

    WinGet, activeHwnd, ID, A
    VD.MoveWindowToDesktopNum("A", 1)
    VD.goToDesktopNum(1)
    WinActivate, ahk_id %activeHwnd%
    VD.removeDesktop(currentDesktopNum, 1)
    return
}

ConsolidateAllDesktops() {
    totalDesktops := VD.getCount()
    if (totalDesktops <= 1)
        return  ; Nothing to consolidate

    Loop, % totalDesktops - 1 {
        desktopNum := A_Index + 1
        VD.goToDesktopNum(desktopNum)
        Sleep, 100

        WinGet, winList, List
        Loop, % winList {
            currentHwnd := winList%A_Index%
            if (WinExist("ahk_id " . currentHwnd)) {
                VD.MoveWindowToDesktopNum("ahk_id " . currentHwnd, 1)
            }
        }
    }

    VD.goToDesktopNum(1)

    Loop, % totalDesktops - 1 {
        desktopToRemove := totalDesktops - (A_Index - 1)
        VD.removeDesktop(desktopToRemove, 1)
    }
    return
}
