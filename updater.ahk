; Beta for v0.8.5 HeartyHampster
; ===================================================================================
; Who's Calling Updater Applet
; ===================================================================================
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance
SetWorkingDir %A_ScriptDir%  

IniRead, currentversion, data\settings.ini, appdata, version
URLDownloadToFile, https://github.com/BeardyMike/WhosCalling/blob/main/data/settings.ini, %A_Temp%\settings.ini
IniRead, newversion, %A_Temp%\settings.ini, appdata, version
if %currentversion% >= %newversion%
{
MsgBox You're up to date!
} else if %currentversion% < %newversion% {
	Process, Close, SMHotKey.exe
	Process, Close, 3CXWin8Phone.exe

FileCreateDir, \oldversion										; creates oldversion folder

FileMove, Changelog.txt, \oldversion 							; moves files to oldversion folder
FileMove, old settings.ahk, \oldversion 						; moves files to oldversion folder
FileMove, README.md, \oldversion 								; moves files to oldversion folder
FileMove, SearchApplet.ahk, \oldversion 						; moves files to oldversion folder
FileMove, SearchApplet.exe, \oldversion 						; moves files to oldversion folder
FileMove, settings.ahk, \oldversion 							; moves files to oldversion folder
FileMove, settings.exe, \oldversion 							; moves files to oldversion folder
FileMove, TrayApplet.ahk, \oldversion 							; moves files to oldversion folder
FileMove, TrayApplet.exe, \oldversion 							; moves files to oldversion folder

FileMoveDir, \data, \oldversion\data							; moves folder to oldversion folder
FileMoveDir, \logs, \oldversion\logs							; moves folder to oldversion folder
FileMoveDir, \media, \oldversion\media							; moves folder to oldversion folder
FileMoveDir, \SMHotKey, \oldversion\SMHotKey					; moves folder to oldversion folder
FileMoveDir, \splashscreen, \oldversion\splashscreen			; moves folder to oldversion folder

URLDownloadToFile, https://github.com/BeardyMike/WhosCalling/archive/refs/heads/main.zip, %A_Temp%\whoscallingupdate.zip
RunWait PowerShell.exe -NoExit -Command Expand-Archive -LiteralPath '%A_Temp%\whoscallingupdate.zip' -DestinationPath %A_ScriptDir%\,, Hide