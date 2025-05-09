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
    
    ; Attempt to get a clean app name from the window title
    WinGetTitle, winTitle, A
    appName := ParseWindowTitle(winTitle)

    ; If title parsing failed, fallback to process metadata
    if (!appName) {
        WinGet, winExe, ProcessName, A
        exePath := GetProcessPath(winExe)
        appName := GetFileDescription(exePath)
        
        if (!appName) {
            appName := RegExReplace(winExe, "\.exe$", "")
            StringUpper, appName, appName, T
        }
    }

    ; Cap the desktop name length
    if (StrLen(appName) > 25)
        appName := SubStr(appName, 1, 25)

    ; Set the desktop name
    VD.setNameToDesktopNum(appName, newDesktopNum)

    ; Move current window and switch desktop
    VD.MoveWindowToDesktopNum("A", newDesktopNum)
    VD.goToDesktopNum(newDesktopNum)
    Sleep, 100
    WinMaximize, A
    return
}

ParseWindowTitle(title) {
    if (!title)
        return ""

    ; Example patterns: "Inbox - Microsoft Outlook", "Meeting - Microsoft Teams"
    if (InStr(title, " - ")) {
        ; Try to extract the last part after the dash
        parts := StrSplit(title, " - ")
        return parts[parts.Length()]
    } else {
        ; No dash, fallback to the full title if it's short
        if (StrLen(title) <= 25)
            return title
    }
    return ""
}

GetProcessPath(processName) {
    for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where Name='" . processName . "'")
        return process.ExecutablePath
    return ""
}

GetFileDescription(filePath) {
    if (!FileExist(filePath))
        return ""

    shell := ComObjCreate("Shell.Application")
    splitPath := StrSplit(filePath, "\")
    fileName := splitPath[splitPath.Length()]
    folderPath := StrReplace(filePath, "\" . fileName, "")

    folder := shell.NameSpace(folderPath)
    if (!folder)
        return ""

    file := folder.ParseName(fileName)
    if (!file)
        return ""

    for propIndex in range := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26] {
        propName := folder.GetDetailsOf(folder.Items, propIndex)
        if (propName = "File Description") {
            desc := folder.GetDetailsOf(file, propIndex)
            break
        }
    }
    return desc
}

MoveBackAndCloseDesktop() {
    currentDesktopNum := VD.getCurrentDesktopNum()
    if (currentDesktopNum = 1)
        return

    WinGet, activeHwnd, ID, A
    VD.MoveWindowToDesktopNum("A", 1)
    VD.goToDesktopNum(1)
    Sleep, 100
    WinActivate, ahk_id %activeHwnd%
    VD.removeDesktop(currentDesktopNum, 1)
    return
}

ConsolidateAllDesktops() {
    totalDesktops := VD.getCount()
    if (totalDesktops <= 1)
        return

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
