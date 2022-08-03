; updated for v0.8.4 HeartyHampster
; ===================================================================================
; Functions a found in this file.
; ===================================================================================



; ===================================================================================
; User Initials code
; ===================================================================================
USERinitials()
{
	Initials := IniRead("data.ini", "Initials", "USER")	; Sets the Users Initals
    IB := InputBox("enter your initials here e.g. MB", "USERinitials Variable Changer", "h125"), USER := IB.Value, ErrorLevel := IB.Result="OK" ? 0 : IB.Result="CANCEL" ? 1 : IB.Result="Timeout" ? 2 : "ERROR"
		if ErrorLevel {
		MsgBox("Initials have been left as '" Initials "'")
		}
			else {
			IniWrite(USER, "data.ini", "Initials", "USER")
			MsgBox("Your Initials have been saved and now the Hotkey app will reload")
			Reload
			}
return
}


; ===================================================================================
; Text Bank 1, 2, and 3
; ===================================================================================
TextBank1()
{
    IB := InputBox("enter the new text here", "TextBank1 Variable Changer", "h125"), TextBank1 := IB.Value, ErrorLevel := IB.Result="OK" ? 0 : IB.Result="CANCEL" ? 1 : IB.Result="Timeout" ? 2 : "ERROR"
		if ErrorLevel {
		MsgBox("TextBank1 not updated.")
		}
			else {
			IniWrite(TextBank1, "data.ini", "UserText", "TextBank1")
			MsgBox("This text has been saved and now the Hotkey app will reload")
			Reload
			}
return
}

TextBank2()
{
    IB := InputBox("enter the new text here", "TextBank2 Variable Changer", "h125"), TextBank2 := IB.Value, ErrorLevel := IB.Result="OK" ? 0 : IB.Result="CANCEL" ? 1 : IB.Result="Timeout" ? 2 : "ERROR"
		if ErrorLevel {
		MsgBox("TextBank2 not updated.")
		}
			else {
			IniWrite(TextBank2, "data.ini", "UserText", "TextBank2")
			MsgBox("This text has been saved and now the Hotkey app will reload")
			Reload
			}
return
}

TextBank3()
{
    IB := InputBox("enter the new text here", "TextBank3 Variable Changer", "h125"), TextBank3 := IB.Value, ErrorLevel := IB.Result="OK" ? 0 : IB.Result="CANCEL" ? 1 : IB.Result="Timeout" ? 2 : "ERROR"
		if ErrorLevel {
		MsgBox("TextBank3 not updated.")
		}
			else {
			IniWrite(TextBank3, "data.ini", "UserText", "TextBank3")
			MsgBox("This text has been saved and now the Hotkey app will reload")
			Reload
			}
	return
}


; ===================================================================================
; Get Pixel colour under mouse
; ===================================================================================
GetPixelColour()
{
	MouseGetPos(&MouseX, &MouseY)
	colour := PixelGetColor(MouseX, MouseY, "alternate,")
	msgResult := MsgBox("The colour at the current cursor position is " colour ". Would you like to copy this to the A_Clipboard?", "", 4)
		if (msgResult = "Yes")
			A_Clipboard := colour
			; StrReplace() is not case sensitive
			; check for StringCaseSense in v1 source script
			; and change the CaseSense param in StrReplace() if necessary
			A_Clipboard := StrReplace(A_Clipboard, "0x")  							; finds all instances of 0x in the clipboard and removes them
	return
}


; ===================================================================================
; Tab n Paste
; ===================================================================================
VATabnPaste()
{
	Send("{Tab up}{Tab down}{Tab up}{Right up}{Right down}{Right up}^v") 				; Tab then Right Arrow then Paste
	return
}


; ===================================================================================
; Triple copy function
; ===================================================================================
TripleCopy()
{
	ActivateWinUM:
	MouseGetPos(, , &WinUMID) 									; Identify the window under the mouse cursor
	WinActivate("ahk_id " WinUMID) 								; Activate the window under the mouse cursor
	Send("{Right}") 										; Press the right arrow
	Click(3) 										; Click 3 times and select all under the cursor
	Send("^c") 										; Copy
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
	MouseGetPos(, , &WinUMID) 									; Identify the window under the mouse cursor
	WinActivate("ahk_id " WinUMID) 								; Activate the window under the mouse cursor
	Click(3) 										; Click 3 times and select all under the cursor
	Send("^v") 										; Paste
	Return
}


; ===================================================================================
; Initials and Date paster
; ===================================================================================
InitialsDate()
{
	Datetype := IniRead("data.ini", "Variable", "Datetype")	; Sets the Users Initals
	Initials := IniRead("data.ini", "Initials", "USER")		; Sets the Users Initals
	If (Datetype = 1)
		{
			CurrentDateTime := FormatTime(, "ddMMyy") 			; Prepare the DATE as DDMMYY
			SendInput(Initials "" CurrentDateTime) 			; Sends initials + currentdate
		}
	else
		{
			CurrentDateTime := FormatTime(, "dd.MM.yy") 			; Prepare the DATE as DD.MM.YY
			SendInput(Initials " " CurrentDateTime) 			; Sends initials + currentdate with a space inbetween
		}
	return
}


; ===================================================================================
; Help GUI
; ===================================================================================
HelpFunction()
{
	myGui := Gui()
	myGui.New(, "Help Box")
	myGui.SetFont("s12", "Verdana")
	myGui.Add("Text", , "Win+Z - Initials and CurrentDate.")
	myGui.Add("Text", , "Ctrl+Shift+Z - CurrentDate.")
	myGui.Add("Text", , "Ctrl+Shift+C - activate window under mouse cursor, triple click, copy.")
	myGui.Add("Text", , "Ctrl+Shift+V - Activate window under mouse cursor, click, paste.")
	myGui.Add("Text", , "Ctrl+Alt+V - Tabs to next entry, then pastes, useful when checking VA invoices.")
	myGui.Add("Text", , "Ctrl+Shift+F1 or F2 or F3 - Allows you to save up to 3 banks of text , dont go mad with it.")
	myGui.Add("Text", , "Ctrl+Shift+F12 - Change USER initials.")
	myGui.Add("Text", , "Ctrl+Shift+Middle Mouse Click - Shows Pixel Colour, and lets you choose to copy it to the A_Clipboard.")
	myGui.Add("Text", , "Ctrl+Shift+Q - Goldmine Pending speedy tool, needs TextBank1 to have data in it.")
	myGui.Add("Text", , "Ctrl+F7	- Select all items, delete them, then move back one folder.")
	ogcButtonOK := myGui.Add("Button", "Default w80", "OK")
	ogcButtonOK.OnEvent("Click", ButtonOK.Bind("Normal"))
	myGui.Show()
	return
}


; ===================================================================================
; About Page GUI
; ===================================================================================
AboutPage()
{
	SMVersion := IniRead("data.ini", "Version", "SMVersion") 							; Reads the SMVersion value from the data.ini
	Author := IniRead("data.ini", "Version", "Author") 									; Reads the Author value from the data.ini
	Creation := IniRead("data.ini", "Version", "Creation")								; Reads the Creation value from the data.ini
	Contact := IniRead("data.ini", "Version", "Contact")								; Reads the Contact value from the data.ini
	Email := IniRead("data.ini", "Version", "Email")									; Reads the Email Value from the data.ini
	myGui.Add("Picture", "x12 y9 w150 h150", "C:\AHK\splash.png")
	myGui.SetFont("s14", "Verdana")
	myGui.Add("Text", "x172 y49 w190 h70 +Left", "Sound Marketing Account Manager Hotkey Application")
	myGui.SetFont("s6", "Verdana")
	myGui.Add("Text", "x12 y249 w140 h10 +Left", "Software version " . SMVersion)
	myGui.SetFont("s10", "Verdana")
	myGui.Add("Text", "x12 y169 w190 h20 +Left", "Created by " . Author)
	myGui.Add("Text", "x212 y169 w180 h20 +Left", "Created on " . Creation)
	myGui.Add("Text", "x12 y199 w190 h20 +Left", "Phone: " . Contact)
	myGui.Add("Text", "x212 y199 w180 h20 +Left", "Email: " . Email)
	ogcButtonOK := myGui.Add("Button", "x292 y229 w100 h30", "OK")
	ogcButtonOK.OnEvent("Click", ButtonOK.Bind("Normal"))
	myGui.Title := "New GUI Window"
	myGui.Show("x127 y87 h276 w410")
	Return
}


; ===================================================================================
; Splash GUI
; ===================================================================================
; REMOVED: SplashImageGUI(Picture, X, Y, Duration, Transparent := true)
{
	XPT99 := Gui()
	XPT99.MarginX := "0", XPT99.MarginY := "0"
	XPT99.Add("Picture", , Picture)
	XPT99.BackColor := "ECE9D8"
	XPT99.Opt("+LastFound -Caption +AlwaysOnTop +ToolWindow -Border")
		If Transparent
			{
			WinSetTransColor("ECE9D8")
			}
	XPT99.Show("x" . X . " y" . Y . " NoActivate")
	SetTimer(DestroySplashGUI,-%Duration%)
	return

	DestroySplashGUI()
{ ; V1toV2: Added bracket
	XPT99.Destroy()
	return
}


; ===================================================================================
; TrayMenu Loader
; ===================================================================================
} ; V1toV2: Added bracket before function
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
CurrentDateTime := FormatTime(, "ddMMyy") 											; Prepare the DATE as DDMMYY
SendInput(CurrentDateTime) 													; Sends todays date DDMMYY
return
}


; ===================================================================================
; Textbank Paster for 1, 2, and 3.
; ===================================================================================
MessagePaster1()
{
TextBank1 := IniRead("data.ini", "UserText", "TextBank1")								; reads TextBank1 from data.ini
SetKeyDelay(25)																	; slows typing speed to look more human
SendEvent(TextBank1) 															; Sends TextBank1 
return
}


MessagePaster2()
{
TextBank2 := IniRead("data.ini", "UserText", "TextBank2")								; reads TextBank2 from data.ini
SetKeyDelay(25)																	; slows typing speed to look more human
SendEvent(TextBank2) 															; Sends TextBank2 
return
}


MessagePaster3()
{
TextBank3 := IniRead("data.ini", "UserText", "TextBank3")								; reads TextBank3 from data.ini
SetKeyDelay(25)																	; slows typing speed to look more human
SendEvent(TextBank3) 															; Sends TextBank3
return
}


; ===================================================================================
; Magic Combo Box
; ===================================================================================
MagicCombo()	
{
msgResult := MsgBox("You pressed the Magic Key Combo, and you have summoned the almighty message box of power! Now you must choose an option to continue.", "", 4)
if (msgResult = "Yes")
    MsgBox("You have chosen the Yes button. A wise choice indeed. May the Gift of the Message Box rain down upon you.")
else
    MsgBox("You have chosen the No button, going against the sands of time, and forging a unique destiny for yourself. Uncertainty and mystery lie ahead.")
return
}


; ===================================================================================
; Click Cutter and Click Paster Functions
; ===================================================================================
ClickCut()
{

	Click(1)										; Click once
	Send("^x") 										; ctrl+x (Cut)

	}
	
	ClickPaste()
{

	Click(1)										; Click once
	Send("^v") 										; ctrl+v (Paste)

	}
	
	
; ===================================================================================
; PcPass typer
; ===================================================================================	
PassTypePC()
{
SendInput("mikebrown")
return
}



; ===================================================================================
; SpeakerWake
; ===================================================================================	
SpeakerWake()
{
SoundPlay("media\SpeakerWake.wav")
return
}

; ===================================================================================
; Quickbase Time Date 
; ===================================================================================
CRMDate()
{
CRMTime := FormatTime(, "dd.MM.yy HH:mm")		; Prepare the DATE as dd-mm-yy hh:mm eg 21-07-22 09:54
SendInput(CRMTime)
return
}


; ===================================================================================
; End
; ===================================================================================


