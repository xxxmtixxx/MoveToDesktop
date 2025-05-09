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

### 📝 How Desktop Naming Works

The script dynamically generates desktop names using the following logic:

1. **Primary Method – Window Title Parsing:**

   * It first tries to extract a meaningful name from the active window’s title by analyzing common patterns, such as using the portion after a hyphen or other separators.

2. **Secondary Method – Executable Metadata:**

   * If the window title doesn’t produce a usable name, the script attempts to read the **File Description** from the application’s executable metadata.

3. **Fallback – Process Name:**

   * If no descriptive title or metadata is available, it defaults to using the process name (e.g., `appname.exe`), removes the `.exe` extension, and capitalizes the first letter.
   * Example: `ms-teams.exe` becomes **"Ms-teams"**.

> 📌 *Note:* Some modern applications don’t expose clean metadata or window titles, resulting in desktop names that reflect the internal process name rather than a user-friendly app name.

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
