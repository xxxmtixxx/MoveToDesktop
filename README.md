# MoveToDesktop for Windows 11

A simple, efficient script that enhances Windows 11 virtual desktop management with application-specific naming.

## Installation

1. **Install AutoHotkey v1.1** from [autohotkey.com](https://www.autohotkey.com/)
2. **Download VD.ahk** from [https://github.com/FuPeiJiang/VD.ahk](https://github.com/FuPeiJiang/VD.ahk)
3. **Create folder** `C:\AutoHotkey` (if it doesn't already exist)
4. **Copy VD.ahk** to the `C:\AutoHotkey` folder
5. **Save the script** in the same folder as `MoveToDesktopWin11.ahk`
6. **Run the script** by double-clicking it

## Features

This script provides two essential keyboard shortcuts:

**Win+Alt+M**: 
- Creates a new desktop
- Names the desktop after the application (e.g., "Chrome", "Firefox", "Word")
- Moves the current window to the new desktop
- Switches to the new desktop
- Maximizes the window

**Win+Alt+N**: 
- Moves the current window back to Desktop 1 (main desktop)
- Switches to Desktop 1
- Closes the desktop you came from

## How Desktop Naming Works

The script takes the process name (e.g., "chrome.exe"), removes the ".exe" extension, capitalizes the first letter, and uses that as the desktop name. This gives you clean, simple names like "Chrome" or "Word" for your virtual desktops.

## Auto-Startup

To make the script run automatically when Windows starts:

1. Press **Win+R**
2. Type `shell:startup` and press Enter
3. This opens your personal Startup folder
4. Create a shortcut to your script file in this folder:
   - Right-click in the Startup folder → New → Shortcut
   - Type the full path to your script: `C:\AutoHotkey\MoveToDesktopWin11.ahk`
   - Click Next, then Finish
5. The script will now run automatically each time you log in to Windows

## Requirements

- Windows 11
- AutoHotkey v1.1
- VD.ahk library
