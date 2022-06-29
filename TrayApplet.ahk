; updated for v0.8.4 HeartyHampster
; ===================================================================================
; Startup Code
; ===================================================================================
#NoEnv                                                                                      ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input                                                                              ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%                                                                 ; Ensures a consistent starting directory.
#Persistent
#SingleInstance
#include, data\tf.ahk
; ===================================================================================
; Variable check and data loading
; ===================================================================================

IfNotExist, C:\ProgramData\3CXPhone for Windows\
{
    MsgBox, 4,, 3CXPhone for Windows is not installed, do you want to download it now?
	IfMsgBox Yes
    		{
			Run, chrome.exe https://downloads-global.3cx.com/downloads/3CXPhoneforWindows16.msi
			ExitFromApp()
			}
		else
			{
    		ExitFromApp()
			}
}

Run, %A_ScriptDir%/SMHotKey/SMHotKey.exe
Process, Close, 3CXWin8Phone.exe
IniRead, BrowserType, data\settings.ini, userdata, userpreferredbrowser  
IniRead, SearchEngine, data\settings.ini, userdata, userpreferredsearchengine  
IniRead, ActivatedStatus, data\settings.ini, appdata, AuthenticationToken

run, splashscreen\SplashScreen.exe

; if ActivatedStatus = 1
; {
; SplashImage, media\Splash.png, B                                                            ; loads the splash image, it is turned off after the tray menu and other items have loaded.
; }
; else if ActivatedStatus = 0
; {
; SplashImage, media\Not Activated.png, B                                                     ; loads the Not Activated splash image, it is turned off after the tray menu and other items have loaded.
; }

; ===================================================================================
; Tray Menu
; ===================================================================================
Menu, WhosCallingMenu, Add, Activated             	            ; adds the activated menu item
Menu, WhosCallingMenu, Add, About                              	; adds the about menu item
Menu, WhosCallingMenu, Add, Settings  
Menu, SMHotKeyMenu, Add, SMHKHelp 
Menu, SMHotKeyMenu, Add, SMHKAbout 
Menu, Tray, Icon, media\Logo.ico, 1                             ; adds the logo
Menu, Tray, NoStandard,   										; removes the standard AHK menu items
Menu, Tray, Add, WhosCalling, :WhosCallingMenu            		; makes a submenu for whoscalling
Menu, Tray, Add, SMHotKey, :SMHotKeyMenu            			; makes a submenu for whoscalling
Menu, Tray, Add, Exit                                           ; add an exit button

If ActivatedStatus = 0
    {
        Menu, WhosCallingMenu, Rename, Activated, Not Activated
        Menu, Tray, Tip , Not Activated
    }
else
    {
        Menu, WhosCallingMenu, Disable, Activated
        Menu, Tray, Tip , Whos Calling


    }          

; Original TrayMenu
; Menu, Tray, Icon, media\Logo.ico, 1                             ; adds the logo
; Menu, Tray, NoStandard,                                         ; removes the standard AHK menu items
; Menu, Tray, Add, Activated                                      ; adds the activated menu item
; Menu, Tray, Add                                                 ; separator
; Menu, Tray, Add, About                                          ; adds the about menu item
; Menu, Tray, Add                                                 ; separator
; Menu, Tray, Add, Settings                                       ; adds the Settings menu item
; Menu, Tray, Add, Exit                                           ; add an exit button


; ===================================================================================
; Activation Checks
; ===================================================================================

; if ActivatedStatus = 1
; {
; sleep, 500
; SplashImage, Off
; }
; else if ActivatedStatus = 0
; {
; sleep, 3000
; SplashImage, Off
; }


; TF_ReplaceInLines("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","12","12","False","True")
; TF_ReplaceLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","13","13","    <LaunchApplicationExecutablePath>" A_ScriptDir "\SearchApplet.exe</LaunchApplicationExecutablePath>")
; TF_ReplaceLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","14","14","    <LaunchApplicationParameters>%CallerNumber%</LaunchApplicationParameters>")
		TF_InsertLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","77",0,"	<LaunchExternalApplication>True</LaunchExternalApplication>")
		TF_InsertLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","77",0,"	<LaunchApplicationExecutablePath>" A_ScriptDir "\SearchApplet.exe</LaunchApplicationExecutablePath>")
		TF_InsertLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","77",0,"	<LaunchApplicationParameters>%CallerNumber%</LaunchApplicationParameters>")
		TF_RemoveDuplicateLines("File.txt","83","0",1,false)

Run, C:\ProgramData\3CXPhone for Windows\PhoneApp\3CXWin8Phone.exe
return

SMHKHelp:
SMHotKeyHelpFunction()
return

SMHKAbout:
SMHotKeyAboutPage()
return


SMHotKeyHelpFunction()
{
	Gui, 3:New,, Help Box,
	Gui, 3:Font, s12, Verdana
	Gui, 3:Add, Text,, Win+Z - Initials and CurrentDate.	
	Gui, 3:Add, Text,, Ctrl+Shift+Z - CurrentDate.
	Gui, 3:Add, Text,, Ctrl+Shift+C - activate window under mouse cursor, triple click, copy.
	Gui, 3:Add, Text,, Ctrl+Shift+V - Activate window under mouse cursor, click, paste.
	Gui, 3:Add, Text,, Ctrl+Alt+V - Tabs to next entry, then pastes, useful when checking VA invoices.
	Gui, 3:Add, Text,, Ctrl+Shift+F1 or F2 or F3 - Allows you to save up to 3 banks of text , dont go mad with it.
	Gui, 3:Add, Text,, Ctrl+Shift+F12 - Change USER initials.
	Gui, 3:Add, Text,, Ctrl+Shift+Middle Mouse Click - Shows Pixel Colour, and lets you choose to copy it to the clipboard.
	Gui, 3:Add, Text,, Ctrl+Shift+Q - Goldmine Pending speedy tool, needs TextBank1 to have data in it.
	Gui, 3:Add, Text,, Ctrl+F7	- Select all items, delete them, then move back one folder.
	Gui, 3:Add, Button,  w80, &OK
	Gui, 3:Show,, SMHotKey Help
	return
}

SMHotKeyAboutPage()
{
	IniRead, SMVersion, \SMHotKey\data.ini, Version, SMVersion 							; Reads the SMVersion value from the data.ini
	IniRead, Author, \SMHotKey\data.ini, Version, Author 									; Reads the Author value from the data.ini
	IniRead, Creation, \SMHotKey\data.ini, Version, Creation								; Reads the Creation value from the data.ini
	IniRead, Contact, \SMHotKey\data.ini, Version, Contact								; Reads the Contact value from the data.ini
	IniRead, Email, \SMHotKey\data.ini, Version, Email									; Reads the Email Value from the data.ini
	Gui, 4:Add, Picture, x12 y9 w150 h150 , \SMHotKey\splash.png
	Gui, 4:Font, s14, Verdana
	Gui, 4:Add, Text, x172 y49 w190 h70 +Left, Sound Marketing Account Manager Hotkey Application
	Gui, 4:Font, s6, Verdana
	Gui, 4:Add, Text, x12 y249 w140 h10 +Left, Software version %SMVersion%
	Gui, 4:Font, s10, Verdana
	Gui, 4:Add, Text, x12 y169 w190 h20 +Left, Created by %Author%
	Gui, 4:Add, Text, x212 y169 w180 h20 +Left, Created on %Creation%
	Gui, 4:Add, Text, x12 y199 w190 h20 +Left, Phone: %Contact%
	Gui, 4:Add, Text, x212 y199 w180 h20 +Left, Email: %Email%
	Gui, 4:Add, Button,  x292 y229 w100 h30 , &OK
	Gui, 4:Show, x127 y87 h276 w410, SMHotKey About
	Return
}
; ===================================================================================
; About Gui
; ===================================================================================
About:
    Gui, 1:Font, s9, Segoe UI
    Gui, 1:Add, Button, x283 y194 w47 h23, &OK
    Gui, 1:Add, Picture, x113 y2 w120 h120, media\Logo.png
    Gui, 1:Font
    Gui, 1:Font, s20, Lucida Console
    Gui, 1:Add, Text, x59 y126 w232 h39 +0x200, Who's Calling?
    Gui, 1:Font
    Gui, 1:Font, s9, Segoe UI
    Gui, 1:Add, Text, x6 y167 w327 h23 +0x200, A custom 3CX and Quickbase telephone number search tool
    Gui, 1:Show, w337 h223, About
    Return

ButtonOK:
2ButtonOK:
3ButtonOK:
4ButtonOK:
GuiEscape:
GuiClose:
    Gui, 1:Hide
    Gui, 2:Hide
	Gui, 3:Hide
	Gui, 4:Hide
    return




; ===================================================================================
; Activated Gui
; ===================================================================================
Activated:
Gui, 2:-MinimizeBox -MaximizeBox
Gui, 2:Font, s9, Segoe UI
Gui, 2:Add, Picture, x64 y0 w60 h60, media\Logo.png
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

Settings:
run, settings.exe
return

; ===================================================================================
; Exit Trigger
; ===================================================================================

ExitFromApp() ;
{
	Process, Close, SMHotKey.exe
	Process, Close, 3CXWin8Phone.exe
; TF_ReplaceInLines("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","12","12","True","False") ; turns off the 3CX intergration
; TF_ReplaceLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","13","13","    <LaunchApplicationExecutablePath> </LaunchApplicationExecutablePath>")
; TF_ReplaceLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","14","14","    <LaunchApplicationParameters> </LaunchApplicationParameters>")

		TF_InsertLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","77",0,"	<LaunchExternalApplication>False</LaunchExternalApplication>")
		TF_InsertLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","77",0,"	<LaunchApplicationExecutablePath></LaunchApplicationExecutablePath>")
		TF_InsertLine("!" A_AppData "\3CXPhone for Windows\3CXPhone.xml","77",0,"	<LaunchApplicationParameters></LaunchApplicationParameters>")
		TF_RemoveDuplicateLines("File.txt","83","0",1,false)
	Run, C:\ProgramData\3CXPhone for Windows\PhoneApp\3CXWin8Phone.exe
    ExitApp, [ ExitCode]
}

; ===================================================================================
; End
; ===================================================================================

#+q:: ; win+shift+q
exit:
ExitFromApp()