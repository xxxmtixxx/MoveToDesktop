# MoveToDesktop for Windows 11

A simple, efficient script that enhances Windows 11 virtual desktop management with application-specific naming.

---

## 📥 Installation

1. **Install AutoHotkey v1.1** from [autohotkey.com](https://www.autohotkey.com/)
2. **Download VD.ahk** from [VD.ahk GitHub](https://github.com/FuPeiJiang/VD.ahk)
3. **Download MoveToDesktopWin11.ahk** from [MoveToDesktop GitHub](https://github.com/xxxmtixxx/MoveToDesktop/blob/main/MoveToDesktopWin11.ahk)
4. **Place both files** in the `C:\AutoHotkey` folder (create this folder if it doesn't exist)
5. **Run the script** by double-clicking `MoveToDesktopWin11.ahk`

---

## ⚙️ Features

### **Win+Alt+M – Move Window to New Desktop**

* Creates a new virtual desktop
* Names the desktop after the application (e.g., "Chrome", "Word")
* Moves the current window to the new desktop
* Switches to the new desktop
* Maximizes the window

### **Win+Alt+N – Move Back and Close Current Desktop**

* Moves all windows on the current desktop back to Desktop 1 (main desktop)
* Switches to Desktop 1
* Closes the desktop you came from

### **NEW! Win+Alt+V – Consolidate All Desktops**

* Moves *all windows* from *all desktops* back to Desktop 1
* Closes all other desktops
* No confirmation or alerts – silent and fast cleanup

---

## 📝 How Desktop Naming Works

The script extracts the process name (e.g., `chrome.exe`), removes the `.exe` extension, capitalizes the first letter, and sets that as the desktop name. This results in clean, intuitive names like **"Chrome"**, **"Outlook"**, or **"Word"** for each virtual desktop.

---

## 🚀 Auto-Startup

1. Press **Win+R**
2. Type `shell:startup` and press Enter
3. In the Startup folder, create a shortcut to the script:

   * Right-click → **New → Shortcut**
   * Enter: `C:\AutoHotkey\MoveToDesktopWin11.ahk`
   * Click **Next**, then **Finish**
4. The script will now launch automatically when you log in.

---

## 📚 Requirements

* Windows 11
* AutoHotkey v1.1
* VD.ahk library
