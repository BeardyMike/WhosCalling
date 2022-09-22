; updated for v0.8.4 HeartyHampster
; ===================================================================================
; This is the SOUNDMARKETING Account Manager Hotkey application
; ===================================================================================
; REMOVED: ; #NoEnv  													; Recommended for performance and compatibility with future AutoHotkey releases.

SendMode "Input"												        ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir) 									            ; Ensures a consistent starting directory.
#SingleInstance force 											        ; Prevents mulitple instances from being run at the same time.
#NoTrayIcon
#Include functions.ahk
; SetTimer(SpeakerWaker,600000)

; ===================================================================================
; VARIABLES
; ===================================================================================

Initials := IniRead("data.ini", "Initials", "USER")						    ; Sets the Users Initals
Text1 := IniRead("data.ini", "UserText", "TextBank1")						; prepares TextBank1 for use
Text2 := IniRead("data.ini", "UserText", "TextBank2")						; prepares TextBank2 for use
Text3 := IniRead("data.ini", "UserText", "TextBank3")						; prepares TextBank3 for use
USERDate := Initials . FormatTime(, "ddMMyy")							    ; example MB230915

; ===================================================================================
; Commands
; ===================================================================================

; SpeakerWaker()		; autoloops	when SetTimer above is enabled	- plays a .5sec 18kHz tone every 10 mins to keep speakers awake. Should be inaudible to humans
; { 
;     SpeakerWake()
;     return
; }

+^$F1::   			; Ctrl+Shift+F1 							- Saves text into TextBank1
{
TextBank1()
return
}

+^$F2::   			; Ctrl+Shift+F2 							- Saves text into TextBank2
{
TextBank2()
return
}

+^$F3::   			; Ctrl+Shift+F3 							- Saves text into TextBank3
{
TextBank3()
return
}

+^$MButton::		; Ctrl+Shift+MiddleMouseClick 				- Show Pixel Colour
{
GetPixelColour()
return
}

^!v::				; Ctrl+Alt+V 								- VoiceArtist Tab'n'Paste
{
VATabnPaste()
return
}

+^$F12::   			; Ctrl+Shift+F12 							- Change the Initals
{
USERinitials()
return
}

+^c::				; Ctrl+Shift+C 								- Triple click and copy to clipboard
{
TripleCopy()
return
} 

+^v::				; Ctrl+Shift+V 								- Click and then paste under mouse cursor
{
UltraPaste()
return
} 

#z::				; Win+Z 									- Initials and the CurrentDate e.g. MB010120
{
InitialsDate()
return
} 

+^q::				; Ctrl+Shift+Q								- PassTyper for Windows logs
{
PassTypePC()
return
} 

+^z::				; Ctrl+Shift+Z  							- CurrentDate
{
CurrentTime()
return 
} 


^$F8::				; Ctrl+F8	
{
MessagePaster1()												;- Types out the contents of TextBank1 in a human manner
return
} 

^$F9::				; Ctrl+F9	
{
MessagePaster2()												;- Types out the contents of TextBank1 in a human manner
return
} 

^$F10::				; Ctrl+F10	
{
MessagePaster3()												;- Types out the contents of TextBank1 in a human manner
return
} 

^$F12::				; Ctrl+F12	
{
;MagicCombo()	
AboutPage()												;- Copies the highlighted text, opens 3CX Broswer Extension and dials it
return
} 

!4::				; Alt+4										- Click, then Cut
{
ClickCut()
return
} 

!5::				; Alt+5										- Click, then paste
{
ClickPaste()
return
} 

^+0::               ; Ctrl+Shift+0                              - Quickbase Action Dater
{
CRMDate()
return
}
