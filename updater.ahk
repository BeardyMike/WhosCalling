; Beta for v0.8.5 HeartyHampster
; ===================================================================================
; Who's Calling Updater Applet
; ===================================================================================
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance
SetWorkingDir %A_ScriptDir%  
#NoTrayIcon


settingsdownloadlink =https://raw.githubusercontent.com/BeardyMike/WhosCalling/beta/data/settings.ini
githubdownloadlink =https://github.com/BeardyMike/WhosCalling/archive/refs/heads/beta.zip
guibg = media\gui assets\Updater\BG.png
guiclosepip =media\gui assets\Close Button.png
guiupdatebuttonON =media\gui assets\Updater\Update ON.png
guiupdatebuttonOFF =media\gui assets\Updater\Update OFF.png
guirollbackbuttonON =media\gui assets\Updater\Rollback ON.png
guirollbackbuttonOFF =media\gui assets\Updater\Rollback OFF.png
guiclosebuttonON =media\gui assets\Updater\Close ON.png
guiclosebuttonOFF =media\gui assets\Updater\Close OFF.png

Gui -MinimizeBox -MaximizeBox -SysMenu +ToolWindow -Caption +Owner
Gui Add, Picture, x0 y0 w300 h250, %guibg%
Gui Add, Picture, gClose x262 y20 w17 h17 +BackgroundTrans, %guiclosepip%
Gui Add, Picture, x71 y66 w163 h33 +BackgroundTrans, %guiupdatebuttonOFF%
Gui Add, Picture, gWCUpdater vUpdatebutton x71 y66 w163 h33 +BackgroundTrans, %guiupdatebuttonON%
Gui Add, Picture, x70 y122 w163 h33 +BackgroundTrans, %guirollbackbuttonOFF%
Gui Add, Picture, gRollBacker vRollbackbutton x70 y122 w163 h33 +BackgroundTrans, %guirollbackbuttonON%
Gui Add, Picture, x108 y206 w86 h33 +BackgroundTrans, %guiclosebuttonOFF%
Gui Add, Picture, gClose vClosebutton x108 y206 w86 h33 +BackgroundTrans, %guiclosebuttonON%

Gui +LastFound
WinSet, Region, 0-0 w300 h250 R30-30, 
Gui Show, w300 h250, Window
SetTimer, MouseOverPicture, 1
SetTimer, GuiController, 1
Return

Close(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
ExitApp
}

; ===================================================================================
; Updater Function
; ===================================================================================
WCUpdater()
{

; compares version numbers, then either updates or lets the user know they are upto date.
FileCreateDir, %A_ScriptDir%\Temp											; creates Temp folder
IniRead, currentversion, data\settings.ini, appdata, version
URLDownloadToFile, %settingsdownloadlink%, Temp\settings.ini
IniRead, newversion, Temp\settings.ini, appdata, version

if VerCmp(currentversion, newversion) = 0
{
MsgBox You're up to date!
} else if VerCmp(currentversion, newversion) == -1 {
	Process, Close, TrayApplet.exe
	Process, Close, SMHotKey.exe
	Process, Close, 3CXWin8Phone.exe


; moves all the current files in the main directory into an old version folder for rollback if needed
FileCreateDir, %A_ScriptDir%\oldversion						; creates oldversion folder

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

; Downloads the latest version and unzips it into the TEMP directory
URLDownloadToFile, %githubdownloadlink%, Temp\whoscallingupdate.zip
RunWait PowerShell.exe -NoExit -Command Expand-Archive -LiteralPath Temp\whoscallingupdate.zip' -DestinationPath Temp\,, Hide

;Copies all the new files in the main WhosCalling Directory
FileMove, Temp\WhosCalling\Changelog.txt, oldversion 							; moves files to main folder
FileMove, Temp\WhosCalling\old settings.ahk, oldversion 						; moves files to main folder
FileMove, Temp\WhosCalling\README.md, oldversion 								; moves files to main folder
FileMove, Temp\WhosCalling\SearchApplet.ahk, oldversion 						; moves files to main folder
FileMove, Temp\WhosCalling\SearchApplet.exe, oldversion 						; moves files to main folder
FileMove, Temp\WhosCalling\settings.ahk, oldversion 							; moves files to main folder
FileMove, Temp\WhosCalling\settings.exe, oldversion 							; moves files to main folder
FileMove, Temp\WhosCalling\TrayApplet.ahk, oldversion 							; moves files to main folder
FileMove, Temp\WhosCalling\TrayApplet.exe, oldversion 						; moves files to main folder

FileMoveDir, Temp\WhosCalling\data, oldversion\data							; moves folder to main folder
FileMoveDir, Temp\WhosCalling\logs, oldversion\logs							; moves folder to main folder
FileMoveDir, Temp\WhosCalling\media, oldversion\media							; moves folder to main folder
FileMoveDir, Temp\WhosCalling\SMHotKey, oldversion\SMHotKey					; moves folder to main folder
FileMoveDir, Temp\WhosCalling\splashscreen, oldversion\splashscreen			; moves folder to main folder
}
return
}









; ===================================================================================
; Rollback Function
; ===================================================================================
RollBacker()
{
	MsgBox This feature is coming soon.
	return
}



; ===================================================================================     
;reads if the mouse is hovering over the save button and changes a variable to 1 or 0
; ===================================================================================
MouseOverPicture:
Gui, Submit, NoHide
MouseGetPos,,,,id, 
if ( id = "Static3")
{
updatebutton = 1  
}
if ( id = "Static5")
{
rollbackbutton = 1  
}
if ( id = "Static7")
{
closebutton = 1  
}
if ( id = "Static1")
{
updatebutton = 0
rollbackbutton = 0
closebutton = 0
}
return




; ===================================================================================   
; This updates the GUI Buttons based on the selected settings
; ===================================================================================   
GuiController: 
if  ( updatebutton = "1" )
   {
     GuiControl, show, Updatebutton,
   } else 	{
     GuiControl, hide, Updatebutton,
			}
if  ( rollbackbutton = "1" )
   {
     GuiControl, show, Rollbackbutton,
   } else 	{
     GuiControl, hide, Rollbackbutton,
			}
if  ( closebutton = "1" )
   {
     GuiControl, show, Closebutton,
   } else 	{
     GuiControl, hide, Closebutton,
			}
return




; ===================================================================================   
; Other Functions
; ===================================================================================   

; https://www.autohotkey.com/boards/viewtopic.php?t=77109
VerCmp(V1, V2) {           ; VerCmp() for Windows by SKAN on D35T/D37L @ tiny.cc/vercmp 
Return ( ( V1 := Format("{:04X}{:04X}{:04X}{:04X}", StrSplit(V1 . "...", ".",, 5)*) )
       < ( V2 := Format("{:04X}{:04X}{:04X}{:04X}", StrSplit(V2 . "...", ".",, 5)*) ) )
       ? -1 : ( V2<V1 ) ? 1 : 0
}