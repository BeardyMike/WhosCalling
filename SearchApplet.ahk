; updated for v0.8 HeartyHampster
; ================
; = Startup Code =
; ================ 
#NoEnv                                                                                      ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input                                                                              ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%                                                                 ; Ensures a consistent starting directory.

; =============
; = Variables =
; ============= 
internalcall=Internal call
externalcall=External call
phonenumber=%1%                                                                             ; The variable is created using the first parameter handed to the script by Windows
FormatTime, TimeString,, hh:mm:ss' on 'dd-MMM-yyyy                                          ; formats the date and time
IniRead, BrowserType, data\settings.ini, userdata, userpreferredbrowser                     ; reads the users preferred browser data
IniRead, SearchEngine, data\settings.ini, userdata, userpreferredsearchengine               ; reads the users preferred search engine
IniRead, ActivatedStatus, data\settings.ini, appdata, AuthenticationToken

If ActivatedStatus = 0
{
    msgbox,0, Who's Calling is not activated, Program not yet activated`nright click the icon in the tray menu`nand click NOT ACTIVATED.
    ExitApp, [ NotActivated]
}

#Include, data\SearchAppletFunctions.func

; =============
; = Main Code =
; ============= 
IfLess, phonenumber, 2050                                                                   ; if the phone number is greater than 3000 then its not an internal extensions, the log is updated and the script closes.
        {
            LogWriter(phonenumber, internalcall)
            Return
        }
    Else                                                                                    ; If the number isnt an internal extension, the script opens chrome and searches google.co.uk for the number, and adds the caller to the log.
    {
        Search(phonenumber)
        LogWriter(phonenumber, externalcall)
        Return
    }


; =============
; = Exit Code =
; ============= 
Exit                                                                                        
; this EXIT needs to be the final line of code, exiting the script just incase I forget to close a function, preventing the script from crashing or running endlessly