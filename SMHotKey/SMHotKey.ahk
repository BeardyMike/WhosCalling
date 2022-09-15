; updated for v0.8.4 HeartyHampster
; ===================================================================================
; This is the SOUNDMARKETING Account Manager Hotkey application
; ===================================================================================
; REMOVED: ; #NoEnv  														; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode("Input")  												; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir) 									; Ensures a consistent starting directory.
#SingleInstance force 											; Prevents mulitple instances from being run at the same time.
#NoTrayIcon
#Include "functions.ahk" 											; this is file that contains all the functions
SetTimer(SpeakerWake,600000)


; ===================================================================================
; VARIABLES
; FormatTime, CurrentDateTime,, ddMMyy 							; Prepare the DATE as DDMMYY
; ===================================================================================

Initials := IniRead("data.ini", "Initials", "USER")						; Sets the Users Initals
Text1 := IniRead("data.ini", "UserText", "Text1")						; prepares TextBank1 for use
Text2 := IniRead("data.ini", "UserText", "Text2")						; prepares TextBank2 for use
Text3 := IniRead("data.ini", "UserText", "Text3")						; prepares TextBank3 for use
USERDate := Initials . "" . CurrentDateTime							; example MB010170

; ===================================================================================
; Commands
; ===================================================================================

SpeakerWake()		; autoloops									- plays a .5sec 18kHz tone every 10 mins to keep speakers awake. Should be inaudible
{ ; V1toV2: Added bracket
SpeakerWake()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

+^$F1::   			; Ctrl+Shift+F1 							- Saves text into TextBank1
{ ; V1toV2: Added bracket
TextBank1()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

+^$F2::   			; Ctrl+Shift+F2 							- Saves text into TextBank2
{ ; V1toV2: Added bracket
TextBank2()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

+^$F3::   			; Ctrl+Shift+F3 							- Saves text into TextBank3
{ ; V1toV2: Added bracket
TextBank3()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

+^$MButton::		; Ctrl+Shift+MiddleMouseClick 				- Show Pixel Colour
{ ; V1toV2: Added bracket
GetPixelColour()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

^!v::				; Ctrl+Alt+V 								- VoiceArtist Tab'n'Paste
{ ; V1toV2: Added bracket
VATabnPaste()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

+^$F12::   			; Ctrl+Shift+F12 							- Change the Initals
{ ; V1toV2: Added bracket
USERinitials()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

+^c::				; Ctrl+Shift+C 								- Triple click and copy to clipboard
{ ; V1toV2: Added bracket
TripleCopy()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

+^v::				; Ctrl+Shift+V 								- Click and then paste under mouse cursor
{ ; V1toV2: Added bracket
UltraPaste()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

#z::				; Win+Z 									- Initials and the CurrentDate e.g. MB010120
{ ; V1toV2: Added bracket
InitialsDate()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

+^q::				; Ctrl+Shift+Q								- PassTyper for Windows logs
{ ; V1toV2: Added bracket
PassTypePC()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

#+z::				; Win+Shift+z								- CurrentDate
{ ; V1toV2: Added bracket
CurrentTime()
return 
} ; V1toV2: Added Bracket before hotkey or Hotstring


^$F8::				; Ctrl+F8	
{ ; V1toV2: Added bracket
MessagePaster1()												- Types out the contents of TextBank1 in a human manner
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

^$F9::				; Ctrl+F9	
{ ; V1toV2: Added bracket
MessagePaster2()												- Types out the contents of TextBank1 in a human manner
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

^$F10::				; Ctrl+F10	
{ ; V1toV2: Added bracket
MessagePaster3()												- Types out the contents of TextBank1 in a human manner
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

^$F12::				; Ctrl+F12	
{ ; V1toV2: Added bracket
MagicCombo()													- Copies the highlighted text, opens 3CX Broswer Extension and dials it
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

!4::				; Alt+4										- Click, then Cut
{ ; V1toV2: Added bracket
ClickCut()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

!5::				; Alt+5										- Click, then paste
{ ; V1toV2: Added bracket
ClickPaste()
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

^+0::               ; Ctrl+Shift+0                              - Quickbase Action Dater
{ ; V1toV2: Added bracket
CRMDate()
return
} ; V1toV2: Added bracket in the end
