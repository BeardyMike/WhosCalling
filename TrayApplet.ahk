; ================
; = Startup Code =
; ================ 
#NoEnv                                                                                      ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input                                                                              ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%                                                                 ; Ensures a consistent starting directory.
#Persistent
#SingleInstance
#include, data\tf.ahk
; =================================== ;
; = Variable check and data loading = ;
; =================================== ;
SplashImage, media\Splash.png, B

Process, Close, 3CXWin8Phone.exe
IniRead, BrowserType, data\settings.ini, userdata, userpreferredbrowser  
IniRead, SearchEngine, data\settings.ini, userdata, userpreferredsearchengine  
IniRead, ActivatedStatus, data\settings.ini, appdata, AuthenticationToken


; =================== ;
; = Browser SubMenu = ;
; =================== ;
RegRead, vResultChrome, HKEY_CURRENT_USER\Software\Google\Chrome\PreferenceMACs\Default, homepage, 
if ErrorLevel
    {
    
    }
else
    {
    Menu, BrowserSubMenu, add, Chrome, ; if Chrome is installed, this registry check will not give an error code, and Chrome will be added to the menu
    }


RegRead, vResultFireFox, HKEY_CURRENT_USER\Software\Mozilla\Firefox\Default Browser Agent, C:\Program Files\Mozilla Firefox|Installed
if ErrorLevel
    {

    }
else
    {
    Menu, BrowserSubMenu, add, FireFox, ; if Firefox is installed, this registry check will not give an error code, and Firefox will be added to the menu
    }


Menu, BrowserSubMenu, add, Edge,

; ================== ;
; = Engine SubMenu = ;
; ================== ;
Menu, EngineSubMenu, add, Google,
Menu, EngineSubMenu, add, Bing,
Menu, EngineSubMenu, add, QuickBase,

; ============= ;
; = Tray Menu = ;
; ============= ;

Menu, Tray, Icon, media\Logo.ico, 1
Menu, Tray, NoStandard,
Menu, Tray, add, Preferred Browser, :BrowserSubMenu
Menu, Tray, add, Preferred Search Engine, :EngineSubMenu
Menu, Tray, Add ; separator
Menu, Tray, Add, About
Menu, Tray, Add ; separator
Menu, Tray, Add, Activated
Menu, Tray, Add, Exit

global ActivatedStatus
If ActivatedStatus = 0
    Menu, Tray, Default, Activated
Else
    Menu, Tray, Default, About
sleep, 2000
SplashImage, Off
TF_ReplaceInLines("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","12","12","False","True")
TF_ReplaceLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","13","13","    <LaunchApplicationExecutablePath>" A_ScriptDir "\SearchApplet.ahk</LaunchApplicationExecutablePath>")
TF_ReplaceLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","14","14","    <LaunchApplicationParameters>%CallerNumber%</LaunchApplicationParameters>")
Run, C:\ProgramData\3CXPhone for Windows\PhoneApp\3CXWin8Phone.exe
; ==================== ;
; = Activation Check = ;
; ==================== ;

If ActivatedStatus = 0
    {
        Menu, Tray, Rename, Activated, Not Activated
        Menu, Tray, Disable, Preferred Browser
        Menu, Tray, Disable, Preferred Search Engine
        Menu, Tray, Tip , Not Activated
    }
else
    {
        Menu, Tray, Disable, Activated
        Menu, Tray, Tip , Whos Calling


    }
; =================== ;
; = SubMenu Checker = ;
; =================== ;
If (BrowserType = "Chrome")
    {
    Menu, BrowserSubMenu, Check, Chrome
    }
Else if (BrowserType = "FireFox") 
    {
    Menu, BrowserSubMenu, Check, FireFox
    }
Else if (BrowserType = "Edge") 
    {
    Menu, BrowserSubMenu, Check, Edge
    }

If (SearchEngine = "Google")
    {
    Menu, EngineSubMenu, Check, Google
    Return
    }
Else If (SearchEngine = "Bing")
    {
    Menu, EngineSubMenu, Check, Bing
    Return
    }  
Else (SearchEngine = "Quickbase")
    {
    Menu, EngineSubMenu, Check, Quickbase
    Return
    }                       



; =============================== ;
; = Search Engine Menu triggers = ;
; =============================== ;
Google:
Menu, EngineSubMenu, Check, Google
Menu, EngineSubMenu, Uncheck, Bing
Menu, EngineSubMenu, Uncheck, QuickBase
IniWrite, Google, data\settings.ini, userdata, userpreferredsearchengine  
return

Bing:
Menu, EngineSubMenu, Uncheck, Google
Menu, EngineSubMenu, Check, Bing
Menu, EngineSubMenu, Uncheck, QuickBase
IniWrite, Bing, data\settings.ini, userdata, userpreferredsearchengine  
return

QuickBase:
Menu, EngineSubMenu, Uncheck, Google
Menu, EngineSubMenu, Uncheck, Bing
Menu, EngineSubMenu, Check, QuickBase
IniWrite, QuickBase, data\settings.ini, userdata, userpreferredsearchengine  
return


; ============================ ;
; = Web Broser Menu Triggers = ;
; ============================ ;
Chrome:
Menu, BrowserSubMenu, Check, Chrome
Menu, BrowserSubMenu, Uncheck, FireFox
Menu, BrowserSubMenu, Uncheck, Edge
IniWrite, Chrome, data\settings.ini, userdata, userpreferredbrowser  
return

FireFox:
Menu, BrowserSubMenu, Uncheck, Chrome
Menu, BrowserSubMenu, Check, FireFox
Menu, BrowserSubMenu, Uncheck, Edge
IniWrite, FireFox, data\settings.ini, userdata, userpreferredbrowser 
return

Edge:
Menu, BrowserSubMenu, Uncheck, Chrome
Menu, BrowserSubMenu, Uncheck, FireFox
Menu, BrowserSubMenu, Check, Edge
IniWrite, Edge, data\settings.ini, userdata, userpreferredbrowser 
return



; ============= ;
; = About Gui = ;
; ============= ;


About:
    Gui, 1:Font, s9, Segoe UI
    Gui, 1:Add, Button, x283 y194 w47 h23, &OK
    Gui, 1:Add, Picture, x113 y2 w120 h120, D:\AHK\SoundM Whos Calling\media\Logo.png
    Gui, 1:Font
    Gui, 1:Font, s20, Lucida Console
    Gui, 1:Add, Text, x59 y126 w232 h39 +0x200, Who's Calling?
    Gui, 1:Font
    Gui, 1:Font, s9, Segoe UI
    Gui, 1:Add, Text, x6 y167 w327 h23 +0x200, A custom 3CX and Quickbase telephone number search tool
    Gui, 1:Show, w337 h223, Window
    Return

ButtonOK:
GuiEscape:
GuiClose:
    Gui, 1:Hide
    Gui, 2:Hide
    return

Startup()
{
If (BrowserType = "Chrome")
    {
    Menu, BrowserSubMenu, Check, Chrome
    Return
    }
Else if (BrowserType = "FireFox") 
    {
    Menu, BrowserSubMenu, Check, FireFox
    Return
    }
Else if (BrowserType = "Edge") 
    {
    Menu, BrowserSubMenu, Check, Edge
    Return
    }


If (SearchEngine = "Google")
    {
    Menu, EngineSubMenu, Check, Google
    Return
    }
Else If (SearchEngine = "Bing")
    {
    Menu, EngineSubMenu, Check, Bing
    Return
    }  
Else (SearchEngine = "Quickbase")
    {
    Menu, EngineSubMenu, Check, Quickbase
    Return
    }                       
}


Activated:

Gui, 2:-MinimizeBox -MaximizeBox
Gui, 2:Font, s9, Segoe UI
Gui, 2:Add, Picture, x64 y0 w60 h60, D:\AHK\SoundM Whos Calling\media\Logo.png
Gui, 2:Font
Gui, 2:Font, s14, Lucida Console
Gui, 2:Add, Text, x10 y63 w231 h40 +0x200, Activation Tool
Gui, 2:Font
Gui, 2:Font, s9, Segoe UI
Gui, 2:Add, Edit, hWndLicenseKey x7 y124 w173 h21
SendMessage 0x1501, 1, "Enter your License Key",, ahk_id %LicenseKey% ; EM_SETCUEBANNER
Gui, 2:Add, GroupBox, x2 y106 w183 h48, License Key
Gui, 2:Add, Button, x98 y160 w80 h23, Verify
Gui, 2:Add, Button, x12 y160 w80 h23, Cancel

Gui, 2:Show, w189 h188, Activation Tool
Return

2ButtonCancel:
    Gui, 2:Hide
    return

2ButtonVerify:
ControlGetText, LicenseKey, Edit1
if LicenseKey in 23T5Y-4JRHG-PA4SR-M8FWY,24A4X-J7ZD5-HFUYX-THDEA,257S9-FDSU3-Z2BHA-A7NKL,25TFJ-PP4D6-GMZB8-DESW3,26CPV-JGY4Z-E25WD-8ZXET,287LT-QZYLJ-DCJ7U-9AJS8,28T7U-RPDU5-8VP6P-TT7YW,29FNX-JYQTU-TNXF7-HJV2Q,29ZSG-B28BB-ZBUAU-XSE3D,2A3EN-WBW7V-9S9JS-RLNUT,2AYSMFD5M5QMJPXASPY5,2BRWQ8T9SV8FUPJ27M7G,2BZU78HPR2LTNPNRDXVL,2CNRQUBKLH5C96X5SA7S,2D8NFRYDGBVREBBFSNFH,2DSU65FZJ5QAVVZ5ZDFK,2END2T3CMZETF26BL5X3,2F8HZQXUASEU7FHX5TSN,2HFE67PNC5S5K3A8MVE7,2HP334QFLS7P4UF2FU8Q,2LH3YW7N579NRQ6HUJBC,2RYF4P6TJPNWR5RWBR9E,2SS9D3YQUL4S5C67PH83,2SW5JSZVQHE8JX6MEXFQ,2SXD495CS3HMTCU6HLTB,2SXS233KLQTPNTB3UW3X,2TL5H9D7LNZNWMBDTPZK,2TZFP5ZQSW8ZZTV32NXS,2UHTTTL6HN6RBFMVV4WJ
    {
    IniWrite, 1, data\settings.ini, appdata, AuthenticationToken
    IniWrite, %LicenseKey%, data\settings.ini, appdata, ActivationKey
    MsgBox, LICENSE KEY ACCEPTED`n"Who's Calling" will now restart and `nactivate the 3CX Windows App link.
    Reload
    }
else
    {
    MsgBox, Invalid License Key. `nPlease check and reenter your key.
    return
    }
return



; ================ ;
; = Exit Trigger = ;
; ================ ;
^+q:: ; ctrl+shift+q
Exit:

    TF_ReplaceInLines("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","12","12","True","False") ; turns off the 3CX intergration
    TF_ReplaceLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","13","13","    <LaunchApplicationExecutablePath></LaunchApplicationExecutablePath>")
    TF_ReplaceLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","14","14","    <LaunchApplicationParameters></LaunchApplicationParameters>")
    ExitApp, [ ExitCode]