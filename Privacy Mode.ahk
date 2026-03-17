#SingleInstance Force
#NoEnv
SetBatchLines, -1

; ============================================================
;  Privacy Mode - Setup
;  Created by Arshit Vaghasiya | geek-updates.com
;  Requires: AutoHotkey v1.1 (NOT compatible with AHK v2)
; ============================================================

global SCRIPT_DIR  := A_ScriptDir . "\Privacy Mode"
global SCRIPT_DEST := A_ScriptDir . "\Privacy Mode\PrivacyOverlay.ahk"
global AHK_URL     := "https://www.autohotkey.com/download/1.1/AutoHotkey_1.1.37.02_setup.exe"
global AHK_TMP     := A_Temp . "\ahk_setup.exe"
global AHK_EXE     := ""

; ── PrivacyOverlay.ahk is embedded at compile time via FileInstall ──

BuildGUI()
OnMessage(0x20, "OnSetCursor")  ; WM_SETCURSOR
return

; ── Close ────────────────────────────────────────────────────
MainGuiClose:
ExitApp

; ============================================================
;  GUI
; ============================================================
BuildGUI() {
    global Step1, Step2, Step3, Step4, LogBox, BtnAction
    Gui, Main:New, -MaximizeBox -Resize, Privacy Mode - Setup
    Gui, Main:Color, F6F6F6

    ; ── Title ─────────────────────────────────────────────
    Gui, Main:Font, s24 bold c1A1A1A, Segoe UI
    Gui, Main:Add, Text, x0 y36 w520 Center, Privacy Mode

    Gui, Main:Font, s9 c888888, Segoe UI
    Gui, Main:Add, Text, x0 y78 w520 Center, by Geek Updates | Arshit Vaghasiya

    Gui, Main:Font, s9 c4A7FC1, Segoe UI
    Gui, Main:Add, Text, x0 y96 w520 Center gOpenWebsite +HwndLinkHwnd, geek-updates.com
    global g_LinkHwnd := LinkHwnd

    Gui, Main:Font, s8 c4A7FC1, Segoe UI
    Gui, Main:Add, Text, x0 y114 w520 Center gOpenGuide +HwndGuideLinkHwnd, Read Guide
    global g_GuideLinkHwnd := GuideLinkHwnd

    ; ── Divider ───────────────────────────────────────────
    Gui, Main:Add, Text, x20 y136 w480 h1 +0x10

    ; ── What this does ────────────────────────────────────
    Gui, Main:Font, s9 bold c2C2C2C, Segoe UI
    Gui, Main:Add, Text, x20 y136, What this setup does:

    Gui, Main:Font, s9 c505050, Segoe UI
    Gui, Main:Add, Text, x30 y156, 1.  Check if AutoHotkey is installed on your PC
    Gui, Main:Add, Text, x30 y174, 2.  Download and install it silently if not found
    Gui, Main:Add, Text, x30 y192, 3.  Create the Privacy Mode script in the same folder
    Gui, Main:Add, Text, x30 y210, 4.  Optionally launch it on every Windows startup

    ; ── Divider ───────────────────────────────────────────
    Gui, Main:Add, Text, x20 y234 w480 h1 +0x10

    ; ── Steps ─────────────────────────────────────────────
    Gui, Main:Font, s9 bold c2C2C2C, Segoe UI
    Gui, Main:Add, Text, x20 y248, Steps:

    Gui, Main:Font, s9 c404040, Segoe UI
    Gui, Main:Add, Text, x30 y268 w310, Check AutoHotkey installation
    Gui, Main:Font, s9 cAAAAAA, Consolas
    Gui, Main:Add, Text, vStep1 x340 y268 w160 Right, -

    Gui, Main:Font, s9 c404040, Segoe UI
    Gui, Main:Add, Text, x30 y288 w310, Install AutoHotkey
    Gui, Main:Font, s9 cAAAAAA, Consolas
    Gui, Main:Add, Text, vStep2 x340 y288 w160 Right, -

    Gui, Main:Font, s9 c404040, Segoe UI
    Gui, Main:Add, Text, x30 y308 w310, Create Privacy Mode script
    Gui, Main:Font, s9 cAAAAAA, Consolas
    Gui, Main:Add, Text, vStep3 x340 y308 w160 Right, -

    Gui, Main:Font, s9 c404040, Segoe UI
    Gui, Main:Add, Text, x30 y328 w310, Add to Windows startup
    Gui, Main:Font, s9 cAAAAAA, Consolas
    Gui, Main:Add, Text, vStep4 x340 y328 w160 Right, -

    ; ── Overview panel ────────────────────────────────────
    Gui, Main:Font, s9 c2C2C2C, Segoe UI
    Gui, Main:Add, GroupBox, x20 y350 w480 h140, Overview

    Gui, Main:Font, s8 c444444, Consolas
    Gui, Main:Add, Edit, vLogBox x28 y368 w464 h114 ReadOnly -TabStop -E0x200 BackgroundF6F6F6 +HwndLogHwnd
    global g_LogHwnd := LogHwnd

    ; ── Action button ─────────────────────────────────────
    Gui, Main:Font, s10 bold cF6F6F6, Segoe UI
    Gui, Main:Add, Button, vBtnAction gOnStart x20 y512 w480 h36 +Background2C2C2C, Start Setup

    ; ── Footer ────────────────────────────────────────────
    Gui, Main:Font, s8 cAAAAAA, Segoe UI
    Gui, Main:Add, Text, x0 y558 w520 Center gOpenWebsite +HwndFooterLinkHwnd, Privacy Mode is free and open source | geek-updates.com
    global g_FooterLinkHwnd := FooterLinkHwnd

    Gui, Main:Show, w520 h580, Privacy Mode - Setup
}

; ── Clickable links ───────────────────────────────────────────
OpenWebsite:
    Run, https://geek-updates.com
return

OpenGuide:
    Run, https://www.notion.so/geekupdates/Privacy-Mode-326735bd8a9d80e586d8df16ec99b667
return

; ── Hand cursor on link hover ─────────────────────────────────
OnSetCursor(wParam, lParam) {
    global g_LinkHwnd, g_GuideLinkHwnd, g_FooterLinkHwnd
    if (wParam = g_LinkHwnd || wParam = g_GuideLinkHwnd || wParam = g_FooterLinkHwnd) {
        DllCall("SetCursor", "Ptr", DllCall("LoadCursor", "Ptr", 0, "Ptr", 32649, "Ptr"))
        return 1
    }
}

; ============================================================
;  Button: Start Setup
; ============================================================
OnStart:
    GuiControl, Disable, BtnAction
    GuiControl, , BtnAction, Working...
    RunSetup()
return


; ============================================================
;  Setup flow
; ============================================================
RunSetup() {
    global AHK_EXE, AHK_URL, AHK_TMP, SCRIPT_DEST
    launchFrom := SCRIPT_DEST

    ; ── Step 1: Check AutoHotkey ─────────────────────────
    SetStep(1, "checking...")
    Log("> Checking for AutoHotkey...")

    foundExe := FindAHK()
    if (foundExe != "") {
        AHK_EXE := foundExe
        Log("  Found: " . foundExe)
        SetStep(1, "OK")
        SetStep(2, "not needed")
        Log("> Install step skipped - already installed.")
    } else {
        Log("  Not found on this PC.")
        SetStep(1, "OK")

        ; ── Step 2: Install AutoHotkey ───────────────────
        SetStep(2, "installing...")
        Log("> Downloading AutoHotkey installer...")
        Loop, 3 {
            URLDownloadToFile, % AHK_URL, % AHK_TMP
            if FileExist(AHK_TMP)
                break
            Sleep, 1500
        }
        if !FileExist(AHK_TMP) {
            Log("  [ERROR] Could not download the installer.")
            Log("")
            Log("  Fallback - install manually:")
            Log("    https://www.autohotkey.com")
            Log("  Then re-run this setup.")
            SetStep(2, "FAILED")
            SetupFailed()
            return
        }
        Log("  Running installer silently...")
        RunWait, % AHK_TMP . " /S",, Hide
        FileDelete, % AHK_TMP
        newExe := FindAHK()
        if (newExe != "") {
            AHK_EXE := newExe
            Log("  AutoHotkey installed successfully.")
            SetStep(2, "OK")
        } else {
            Log("  [ERROR] Installation finished but AHK was not found.")
            Log("")
            Log("  Fallback - install manually:")
            Log("    https://www.autohotkey.com")
            SetStep(2, "FAILED")
            SetupFailed()
            return
        }
    }

    ; ── Step 3: Write script file ────────────────────────
    SetStep(3, "creating...")
    Log("> Writing Privacy Mode script...")
    WriteScriptFile()
    if FileExist(SCRIPT_DEST) {
        Log("  Created: " . SCRIPT_DEST)
        SetStep(3, "OK")
    } else {
        Log("  [ERROR] Could not write the file.")
        Log("  Check that the script folder is accessible.")
        SetStep(3, "FAILED")
        SetupFailed()
        return
    }

    ; ── Step 4: Startup ──────────────────────────────────
    SetStep(4, "asking...")
    Log("> Add to Windows startup?")

    MsgBox, 36, Privacy Mode - Startup, Add Privacy Mode to Windows startup?`n`nIt will launch automatically every time you log in.
    IfMsgBox, Yes
    {
        startupScript := A_Startup . "\PrivacyOverlay.ahk"
        FileCopy, % SCRIPT_DEST, % startupScript, 1
        if (ErrorLevel = 0) {
            Log("  Added: " . startupScript)
            SetStep(4, "OK")
            launchFrom := startupScript
        } else {
            Log("  [ERROR] Could not write to startup folder.")
            Log("  Fallback - add manually:")
            Log("    Win+R  ->  shell:startup")
            Log("    Paste PrivacyOverlay.ahk there.")
            SetStep(4, "FAILED")
            launchFrom := SCRIPT_DEST
        }
    }
    IfMsgBox, No
    {
        Log("  Skipped.")
        Log("  To add later: Win+R -> shell:startup")
        SetStep(4, "skipped")
        launchFrom := SCRIPT_DEST
    }

    ; ── Done — auto-launch ───────────────────────────────
    Log("")
    Log("Launching Privacy Mode...")
    GuiControl, , BtnAction, Launching...
    if (AHK_EXE != "")
        Run, % """" . AHK_EXE . """ """ . launchFrom . """"
    else
        Run, % launchFrom

    ShowReadyDialog()
    ExitApp
}

; ============================================================
;  Ready dialog
; ============================================================
ShowReadyDialog() {
    Gui, Ready:New, -MaximizeBox -Resize, Privacy Mode - Ready!
    Gui, Ready:Color, F6F6F6

    Gui, Ready:Font, s11 bold c1A1A1A, Segoe UI
    Gui, Ready:Add, Text, x20 y24 w420, Privacy Mode is now running!

    Gui, Ready:Font, s9 c505050, Segoe UI
    Gui, Ready:Add, Text, x20 y54, HOW TO USE:

    Gui, Ready:Font, s9 c505050, Segoe UI
    Gui, Ready:Add, Text, x28 y72,  1.  Click on any window you want to hide.
    Gui, Ready:Add, Text, x28 y90,  2.  Press  Win + Shift + P  to cover it with a black overlay.
    Gui, Ready:Add, Text, x28 y108,  3.  Press  Win + Shift + P  again to remove it.

    Gui, Ready:Add, Text, x20 y136 w420, The overlay follows the window - even if you move or resize it.
    Gui, Ready:Add, Text, x20 y154 w420, It also hides automatically when you minimise the window.

    Gui, Ready:Font, s9 bold c1A1A1A, Segoe UI
    Gui, Ready:Add, Text, x20 y182, Enjoy your privacy!

    Gui, Ready:Add, Text, x20 y208 w420 +0x10

    Gui, Ready:Font, s9 c505050, Segoe UI
    Gui, Ready:Add, Text, x20 y222 w420, Don't forget to follow me if you liked my work!

    Gui, Ready:Font, s9 bold cF6F6F6, Segoe UI
    Gui, Ready:Add, Button, gReadyInstagram x20 y252 w204 h32 +Background1A76D1, Checkout Instagram
    Gui, Ready:Add, Button, gReadyOK x232 y252 w208 h32 +Background2C2C2C, OK

    Gui, Ready:Show, w460, Privacy Mode - Ready!
    WinWaitClose, Privacy Mode - Ready!
}

ReadyInstagram:
    Gui, Ready:Destroy
    Run, https://www.instagram.com/geek_updates/
return

ReadyOK:
    Gui, Ready:Destroy
return

ReadyGuiClose:
    Gui, Ready:Destroy
return

; ============================================================
;  Write the embedded script to disk (fully self-contained)
; ============================================================
WriteScriptFile() {
    global SCRIPT_DIR, SCRIPT_DEST
    FileCreateDir, % SCRIPT_DIR
    FileDelete,    % SCRIPT_DEST
    FileAppend,
(
#SingleInstance Force
#NoEnv
SetBatchLines, -1

; ============================================================
;  Privacy Mode — Win+Shift+P to toggle
;  • Covers the focused window with a solid black layer
;  • Persists through minimize/restore
;  • Cleans up when the target window is closed
; ============================================================

global g_Overlays       := {}   ; targetHwnd  → overlayHwnd
global g_OverlayToTarget := {}  ; overlayHwnd → targetHwnd  (reverse map)

; ── Drag support: clicking the overlay drags the target window
OnMessage(0x84, "OverlayHitTest")   ; WM_NCHITTEST
OnMessage(0xA1, "OverlayDragStart") ; WM_NCLBUTTONDOWN

; ── Hotkey ───────────────────────────────────────────────────
#+p::
    activeHwnd := WinExist("A")
    if (!activeHwnd)
        return

    ; If the focused window IS an overlay, toggle off its target
    if (g_OverlayToTarget.HasKey(activeHwnd)) {
        RemoveOverlay(g_OverlayToTarget[activeHwnd])
        return
    }

    ; If the focused window already HAS an overlay, remove it
    if (g_Overlays.HasKey(activeHwnd)) {
        RemoveOverlay(activeHwnd)
        return
    }

    ; Otherwise create a new overlay
    CreateOverlay(activeHwnd)
return

; ── Create overlay ───────────────────────────────────────────
CreateOverlay(targetHwnd) {
    WinGetPos, x, y, w, h, ahk_id `%targetHwnd`%
    if (w = "" || h = "")
        return

    Gui, New, +HwndoverlayHwnd +ToolWindow -Caption -SysMenu
    Gui, Color, 000000
    Gui, Show, x`%x`% y`%y`% w`%w`% h`%h`% NoActivate

    ; Keep overlay just above its target via ownership
    DllCall("SetWindowLong" . (A_PtrSize = 8 ? "Ptr" : "")
        , "Ptr", overlayHwnd, "Int", -8, "Ptr", targetHwnd)

    g_Overlays[targetHwnd]        := overlayHwnd
    g_OverlayToTarget[overlayHwnd] := targetHwnd

    ; Bring overlay in front of target
    DllCall("SetWindowPos", "Ptr", overlayHwnd, "Ptr", 0
        , "Int", x, "Int", y, "Int", w, "Int", h
        , "UInt", 0x0010)  ; SWP_NOACTIVATE
}

; ── Remove overlay ───────────────────────────────────────────
RemoveOverlay(targetHwnd) {
    overlayHwnd := g_Overlays[targetHwnd]
    Gui, `%overlayHwnd`%:Destroy
    g_Overlays.Delete(targetHwnd)
    g_OverlayToTarget.Delete(overlayHwnd)
    WinActivate, ahk_id `%targetHwnd`%
}

; ── Overlay drag handlers ─────────────────────────────────────
OverlayHitTest(wParam, lParam, msg, hwnd) {
    if (g_OverlayToTarget.HasKey(hwnd))
        return 2  ; HTCAPTION — entire overlay surface acts as title bar
}

OverlayDragStart(wParam, lParam, msg, hwnd) {
    if (g_OverlayToTarget.HasKey(hwnd) && wParam = 2) {
        targetHwnd := g_OverlayToTarget[hwnd]
        PostMessage, 0xA1, 2, lParam,, ahk_id `%targetHwnd`%
        return 0
    }
}

; ── Sync loop — keeps overlays aligned & handles lifecycle ───
SetTimer, SyncOverlays, 100
return

SyncOverlays:
    for targetHwnd, overlayHwnd in g_Overlays {

        ; Target closed → destroy overlay
        if !WinExist("ahk_id " . targetHwnd) {
            Gui, `%overlayHwnd`%:Destroy
            g_Overlays.Delete(targetHwnd)
            g_OverlayToTarget.Delete(overlayHwnd)
            continue
        }

        WinGet, state, MinMax, ahk_id `%targetHwnd`%

        ; Minimized → hide overlay
        if (state = -1) {
            WinGet, oState, MinMax, ahk_id `%overlayHwnd`%
            if (oState != -1)
                Gui, `%overlayHwnd`%:Hide
            continue
        }

        ; Visible → reposition overlay to match target
        WinGetPos, x, y, w, h, ahk_id `%targetHwnd`%
        DllCall("SetWindowPos", "Ptr", overlayHwnd, "Ptr", 0
            , "Int", x, "Int", y, "Int", w, "Int", h
            , "UInt", 0x0010 | 0x0040)  ; SWP_NOACTIVATE | SWP_SHOWWINDOW
    }
return
), % SCRIPT_DEST
}

; ============================================================
;  Helpers
; ============================================================
FindAHK() {
    for _, regPath in ["HKLM\SOFTWARE\AutoHotkey", "HKLM\SOFTWARE\WOW6432Node\AutoHotkey"] {
        RegRead, installDir, % regPath, InstallDir
        if (installDir != "" && FileExist(installDir . "\AutoHotkey.exe"))
            return installDir . "\AutoHotkey.exe"
    }
    for _, candidate in [A_ProgramFiles . "\AutoHotkey\AutoHotkey.exe"
                        , A_ProgramFiles . "\AutoHotkey\v2\AutoHotkey64.exe"
                        , A_ProgramFilesX86 . "\AutoHotkey\AutoHotkey.exe"] {
        if FileExist(candidate)
            return candidate
    }
    return ""
}

Log(msg) {
    global g_LogHwnd
    Gui, Main:Default
    GuiControlGet, current,, LogBox
    newText := (current = "") ? msg : current . "`r`n" . msg
    GuiControl, , LogBox, % newText
    PostMessage, 0x115, 7, 0, Edit1, % "ahk_id " . WinExist("Privacy Mode - Setup")
    DllCall("HideCaret", "Ptr", g_LogHwnd)
}

SetStep(n, status) {
    GuiControl, , % "Step" . n, % status
}

SetupFailed() {
    GuiControl, , BtnAction, Setup failed - see details above
    GuiControl, Enable, BtnAction
}
