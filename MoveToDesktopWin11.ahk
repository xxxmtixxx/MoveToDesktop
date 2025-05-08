#NoEnv  ; Recommended for performance and compatibility
#SingleInstance force
SetBatchLines -1
SendMode Input
SetWorkingDir %A_ScriptDir%
#WinActivateForce

; Include the VD.ahk library (download from https://github.com/FuPeiJiang/VD.ahk)
#Include VD.ahk

; Hotkey: Win+Alt+M - Move current window to a new desktop and maximize it
#!m::MoveToNewDesktopAndMaximize()

; Hotkey: Win+Alt+N - Move window back to desktop 1 and close current desktop
#!n::MoveBackAndCloseDesktop()

; Simple function to move window to new desktop and maximize
MoveToNewDesktopAndMaximize() {
    ; Create a new desktop
    VD.createDesktop()
    
    ; Get the newly created desktop number
    newDesktopNum := VD.getCount()
    
    ; Get information about current window to name the desktop
    WinGet, winExe, ProcessName, A
    
    ; Get just the application name without extension
    appName := RegExReplace(winExe, "\.exe$", "")
    
    ; Make first letter uppercase for better appearance
    StringUpper, firstChar, appName, T
    
    ; Set the desktop name to the application name
    VD.setNameToDesktopNum(firstChar, newDesktopNum)
    
    ; Move the current window to the new desktop
    VD.MoveWindowToDesktopNum("A", newDesktopNum)
    
    ; Go to the new desktop
    VD.goToDesktopNum(newDesktopNum)
    
    ; Maximize the window
    WinMaximize, A
    
    return
}

; Function to move current window back to desktop 1 and close current desktop
MoveBackAndCloseDesktop() {
    ; Get current desktop number
    currentDesktopNum := VD.getCurrentDesktopNum()
    
    ; If already on desktop 1, do nothing
    if (currentDesktopNum = 1)
        return
    
    ; Get handle of current window
    WinGet, activeHwnd, ID, A
    
    ; Move current window to desktop 1
    VD.MoveWindowToDesktopNum("A", 1)
    
    ; Go to desktop 1
    VD.goToDesktopNum(1)
    
    ; Make sure the window is activated
    WinActivate, ahk_id %activeHwnd%
    
    ; Remove the desktop we came from
    VD.removeDesktop(currentDesktopNum, 1)
    
    return
}