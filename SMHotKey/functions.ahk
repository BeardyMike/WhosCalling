; updated for v0.8.4 HeartyHampster
; ===================================================================================
; Functions a found in this file.
; ===================================================================================



; ===================================================================================
; User Initials code
; ===================================================================================
USERinitials()
{
	IniRead, Initials, data.ini, Initials, USER	; Sets the Users Initals
    InputBox, USER, USERinitials Variable Changer, enter your initials here e.g. MB, , , 125,
		if ErrorLevel {
		MsgBox, Initials have been left as '%Initials%'
		}
			else {
			IniWrite, %USER%, data.ini, Initials, USER
			MsgBox, Your Initials have been saved and now the Hotkey app will reload
			Reload
			}
return
}


; ===================================================================================
; Text Bank 1, 2, and 3
; ===================================================================================
TextBank1()
{
    InputBox, TextBank1, TextBank1 Variable Changer, enter the new text here, , , 125, 
		if ErrorLevel {
		MsgBox, TextBank1 not updated. 
		}
			else {
			IniWrite, %TextBank1%, data.ini, UserText, TextBank1
			MsgBox, This text has been saved and now the Hotkey app will reload
			Reload
			}
return
}

TextBank2()
{
    InputBox, TextBank2, TextBank2 Variable Changer, enter the new text here, , , 125, 
		if ErrorLevel {
		MsgBox, TextBank2 not updated. 
		}
			else {
			IniWrite, %TextBank2%, data.ini, UserText, TextBank2
			MsgBox, This text has been saved and now the Hotkey app will reload
			Reload
			}
return
}

TextBank3()
{
    InputBox, TextBank3, TextBank3 Variable Changer, enter the new text here, , , 125, 
		if ErrorLevel {
		MsgBox, TextBank3 not updated. 
		}
			else {
			IniWrite, %TextBank3%, data.ini, UserText, TextBank3
			MsgBox, This text has been saved and now the Hotkey app will reload
			Reload
			}
	return
}


; ===================================================================================
; Get Pixel colour under mouse
; ===================================================================================
GetPixelColour()
{
	MouseGetPos, MouseX, MouseY
	PixelGetColor, colour, %MouseX%, %MouseY%, alternate,
	MsgBox, 4,, The colour at the current cursor position is %colour%. Would you like to copy this to the clipboard?
		IfMsgBox Yes
			Clipboard = %colour%
			StringReplace, Clipboard, Clipboard, 0x,, All  							; finds all instances of 0x in the clipboard and removes them
	return
}


; ===================================================================================
; Tab n Paste
; ===================================================================================
VATabnPaste()
{
	Send {Tab up}{Tab down}{Tab up}{Right up}{Right down}{Right up}^v 				; Tab then Right Arrow then Paste
	return
}


; ===================================================================================
; Triple copy function
; ===================================================================================
TripleCopy()
{
	ActivateWinUM:
	MouseGetPos,,, WinUMID 									; Identify the window under the mouse cursor
	WinActivate, ahk_id %WinUMID% 								; Activate the window under the mouse cursor
	Send, {Right} 										; Press the right arrow
	Click, 3 										; Click 3 times and select all under the cursor
	Send, ^c 										; Copy
	Return
}


; ===================================================================================
; Ultrapaste
; ===================================================================================
; UltraPaste()
; {
; 	ActivateWinUM2:
; 	MouseGetPos,,, WinUMID 									; Identify the window under the mouse cursor
; 	WinActivate, ahk_id %WinUMID% 								; Activate the window under the mouse cursor
; 	Click,											; Click once under the cursor
; 	Click,											; Click once under the cursor
; 	Send, ^v 										; Paste
;  	Return
; 
; }

UltraPaste()
{
	ActivateWinUM2:
	MouseGetPos,,, WinUMID 									; Identify the window under the mouse cursor
	WinActivate, ahk_id %WinUMID% 								; Activate the window under the mouse cursor
	Click, 3 										; Click 3 times and select all under the cursor
	Send, ^v 										; Paste
	Return
}


; ===================================================================================
; Initials and Date paster
; ===================================================================================
InitialsDate()
{
	IniRead, Datetype, data.ini, Variable, Datetype	; Sets the Users Initals
	IniRead, Initials, data.ini, Initials, USER		; Sets the Users Initals
	If (Datetype = 1)
		{
			FormatTime, CurrentDateTime,, ddMMyy 			; Prepare the DATE as DDMMYY
			SendInput %Initials%%CurrentDateTime% 			; Sends initials + currentdate
		}
	else
		{
			FormatTime, CurrentDateTime,, dd.MM.yy 			; Prepare the DATE as DD.MM.YY
			SendInput %Initials% %CurrentDateTime% 			; Sends initials + currentdate with a space inbetween
		}
	return
}


; ===================================================================================
; Help GUI
; ===================================================================================
HelpFunction()
{
	Gui, New,, Help Box,
	Gui, Font, s12, Verdana
	Gui, Add, Text,, Win+Z - Initials and CurrentDate.	
	Gui, Add, Text,, Ctrl+Shift+Z - CurrentDate.
	Gui, Add, Text,, Ctrl+Shift+C - activate window under mouse cursor, triple click, copy.
	Gui, Add, Text,, Ctrl+Shift+V - Activate window under mouse cursor, click, paste.
	Gui, Add, Text,, Ctrl+Alt+V - Tabs to next entry, then pastes, useful when checking VA invoices.
	Gui, Add, Text,, Ctrl+Shift+F1 or F2 or F3 - Allows you to save up to 3 banks of text , dont go mad with it.
	Gui, Add, Text,, Ctrl+Shift+F12 - Change USER initials.
	Gui, Add, Text,, Ctrl+Shift+Middle Mouse Click - Shows Pixel Colour, and lets you choose to copy it to the clipboard.
	Gui, Add, Text,, Ctrl+Shift+Q - Goldmine Pending speedy tool, needs TextBank1 to have data in it.
	Gui, Add, Text,, Ctrl+F7	- Select all items, delete them, then move back one folder.
	Gui, Add, Button, Default w80, OK
	Gui, Show
	return
}


; ===================================================================================
; About Page GUI
; ===================================================================================
AboutPage()
{
	IniRead, SMVersion, data.ini, Version, SMVersion 							; Reads the SMVersion value from the data.ini
	IniRead, Author, data.ini, Version, Author 									; Reads the Author value from the data.ini
	IniRead, Creation, data.ini, Version, Creation								; Reads the Creation value from the data.ini
	IniRead, Contact, data.ini, Version, Contact								; Reads the Contact value from the data.ini
	IniRead, Email, data.ini, Version, Email									; Reads the Email Value from the data.ini
	Gui, Add, Picture, x12 y9 w150 h150 , C:\AHK\splash.png
	Gui, Font, s14, Verdana
	Gui, Add, Text, x172 y49 w190 h70 +Left, Sound Marketing Account Manager Hotkey Application
	Gui, Font, s6, Verdana
	Gui, Add, Text, x12 y249 w140 h10 +Left, Software version %SMVersion%
	Gui, Font, s10, Verdana
	Gui, Add, Text, x12 y169 w190 h20 +Left, Created by %Author%
	Gui, Add, Text, x212 y169 w180 h20 +Left, Created on %Creation%
	Gui, Add, Text, x12 y199 w190 h20 +Left, Phone: %Contact%
	Gui, Add, Text, x212 y199 w180 h20 +Left, Email: %Email%
	Gui, Add, Button, x292 y229 w100 h30 , OK
	Gui, Show, x127 y87 h276 w410, New GUI Window
	Return
}


; ===================================================================================
; Splash GUI
; ===================================================================================
SplashImageGUI(Picture, X, Y, Duration, Transparent = true)
{
	Gui, XPT99:Margin , 0, 0
	Gui, XPT99:Add, Picture,, %Picture%
	Gui, XPT99:Color, ECE9D8
	Gui, XPT99:+LastFound -Caption +AlwaysOnTop +ToolWindow -Border
		If Transparent
			{
			Winset, TransColor, ECE9D8
			}
	Gui, XPT99:Show, x%X% y%Y% NoActivate
	SetTimer, DestroySplashGUI, -%Duration%
	return

	DestroySplashGUI:
	Gui, XPT99:Destroy
	return
}


; ===================================================================================
; TrayMenu Loader
; ===================================================================================
TrayMenu()
{
; 	Menu, Tray, Icon , icon.ico,
; 	Menu, Tray, NoStandard 														; removes the standard Menu items
; 	Menu, Tray, Add , Help, HELPFUNCTION 										; OPTION - opens the Help GUI
; 	Menu, Tray, Add , About, AboutPage 											; OPTION - opens the about page
; 	Menu, Tray, Add 															; Adds a divider
; 	Menu, Tray, Add , R&eload, Reeload 											; OPTION - reload script button
; 	Menu, Tray, Add 															; Adds a divider
; 	Menu, Tray, Add , E&xit, ButtonExit 										; OPTION - Exits the App
; 	Return
}


; ===================================================================================
; Current time function
; ===================================================================================
CurrentTime()
{
FormatTime, CurrentDateTime,, ddMMyy 											; Prepare the DATE as DDMMYY
SendInput, %CurrentDateTime% 													; Sends todays date DDMMYY
return
}


; ===================================================================================
; Textbank Paster for 1, 2, and 3.
; ===================================================================================
MessagePaster1()
{
IniRead, TextBank1, data.ini, UserText, TextBank1								; reads TextBank1 from data.ini
SetkeyDelay, 25																	; slows typing speed to look more human
SendEvent, %TextBank1% 															; Sends TextBank1 
return
}


MessagePaster2()
{
IniRead, TextBank2, data.ini, UserText, TextBank2								; reads TextBank2 from data.ini
SetkeyDelay, 25																	; slows typing speed to look more human
SendEvent, %TextBank2% 															; Sends TextBank2 
return
}


MessagePaster3()
{
IniRead, TextBank3, data.ini, UserText, TextBank3								; reads TextBank3 from data.ini
SetkeyDelay, 25																	; slows typing speed to look more human
SendEvent, %TextBank3% 															; Sends TextBank3
return
}


; ===================================================================================
; Magic Combo Box
; ===================================================================================
MagicCombo()	
{
MsgBox, 4,, You pressed the Magic Key Combo, and you have summoned the almighty message box of power! Now you must choose an option to continue.
IfMsgBox Yes
    MsgBox You have chosen the Yes button. A wise choice indeed. May the Gift of the Message Box rain down upon you.
else
    MsgBox You have chosen the No button, going against the sands of time, and forging a unique destiny for yourself. Uncertainty and mystery lie ahead.
return
}


; ===================================================================================
; Click Cutter and Click Paster Functions
; ===================================================================================
ClickCut()
{

	Click, 1										; Click once
	Send, ^x 										; ctrl+x (Cut)

	}
	
	ClickPaste()
{

	Click, 1										; Click once
	Send, ^v 										; ctrl+v (Paste)

	}
	
	
; ===================================================================================
; PcPass typer
; ===================================================================================	
PassTypePC()
{
SendInput, mikebrown
return
}


; ===================================================================================
; End
; ===================================================================================