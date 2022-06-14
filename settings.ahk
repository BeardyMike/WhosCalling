#SingleInstance Force
#Persistent
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
#NoTrayIcon


; Initial Variables
save = 1

; GUI Assets Variables
googlegrey = media\gui assets\Google Grey.png
googlecolour = media\gui assets\Google Colour.png
firefoxgrey = media\gui assets\Firefox Grey.png
firefoxcolour = media\gui assets\Firefox Colour.png
edgegrey = media\gui assets\Edge GRey.png
edgecolour = media\gui assets\Edge Colour.png
chromegrey = media\gui assets\Chrome Grey.png
chromecolour = media\gui assets\Chome Colour.png
binggrey = media\gui assets\Bing Grey.png
bingcolour = media\gui assets\Bing Colour.png
quickbasegrey = media\gui assets\Quickbase Grey.png
quickbasecolour = media\gui assets\QuickBase Colour.png
closebutton = media\gui assets\Close Button.png
savehover = media\gui assets\Save hover.png
savenohover = media\gui assets\Save no hover.png


; Settings GUI
Gui -MinimizeBox -MaximizeBox -SysMenu +AlwaysOnTop +ToolWindow -Caption 										;	removes system buttons, adds always-on-top
Gui Add, Picture, x0 y0 w1000 h700, D:\AHK\SoundM Whos Calling\Gui Assets\BG.png								;	This is the main background image
Gui Add, Picture, gGoogle x654 y159 w94 h96 +BackgroundTrans, %googlegrey%										;	this is the grey 	Google 		button
Gui Add, Picture, vGoogle x654 y159 w94 h96 +BackgroundTrans, %googlecolour%									;	this is the colour 	Google 		button
Gui Add, Picture, gFireFox x266 y272 w95 h100 +BackgroundTrans, %firefoxgrey%									;	this is the grey 	FireFox 	button
Gui Add, Picture, vFireFox x266 y272 w95 h100 +BackgroundTrans, %firefoxcolour%									;	this is the colour 	FireFox 	button
Gui Add, Picture, gEdge x266 y388 w96 h96 +BackgroundTrans, %edgegrey%											;	this is the grey 	Edge 		button
Gui Add, Picture, vEdge x266 y388 w96 h96 +BackgroundTrans, %edgecolour%										;	this is the colour 	Edge		button
Gui Add, Picture, gChrome x266 y159 w96 h96 +BackgroundTrans, %chromegrey%										;	this is the grey 	Chrome 		button
Gui Add, Picture, vChrome x266 y159 w96 h96 +BackgroundTrans, %chromecolour%									;	this is the colour 	Chrome 		button
Gui Add, Picture, gBing x654 y272 w64 h96 +BackgroundTrans, %binggrey%											;	this is the grey 	Bing 		button
Gui Add, Picture, vBing x654 y272 w64 h96 +BackgroundTrans, %bingcolour%										;	this is the colour 	Bing 		button
Gui Add, Picture, gQuickbase x654 y388 w72 h97 +BackgroundTrans, %quickbasegrey%								;	this is the grey 	QuickBase 	button
Gui Add, Picture, vQuickBase x654 y388 w72 h97 +BackgroundTrans, %quickbasecolour%								;	this is the colour 	QuickBase 	button
Gui Add, Picture, gClose hwndMyclose vMyclose x960 y23 w17 h17 +BackgroundTrans, %closebutton%					;	this is the normal	close 		button
Gui Add, Picture, gSave hwndMysave vMysave x456 y649 w86 h33, %savehover%										;	this is the grey 	save 		button
Gui Add, Picture, hwndMynosave vMynosave x456 y649 w86 h33, %savenohover%										;	this is the colour 	save		button
Gui Add, Picture, x29 y654 w33 h23 +BackgroundTrans, D:\AHK\SoundM Whos Calling\Gui Assets\hotkey logo.png		;	this is the logo
Gui +LastFound
WinSet, Region, 0-0 w1000 h700 R30-30, 
OnMessage(0x201, "WM_LBUTTONDOWN")

; this sets up the buttons when the GUI first loads
IniRead, BrowserType, data\settings.ini, userdata, userpreferredbrowser  
IniRead, SearchEngine, data\settings.ini, userdata, userpreferredsearchengine  
if  ( BrowserType = "Chrome" )
   {
     GuiControl, show, Chrome,
   } else 	{
     GuiControl, hide, Chrome,
			}

if  ( BrowserType = "FireFox" )
   {
     GuiControl, show, FireFox,
   } else 	{
     GuiControl, hide, FireFox,
			}

if  ( BrowserType = "Edge" )
   {
     GuiControl, show, Edge,
   } else 	{
     GuiControl, hide, Edge,
			}

if  ( SearchEngine = "Google" )
   {
     GuiControl, show, Google,
   } else 	{
     GuiControl, hide, Google,
			}

if  ( SearchEngine = "Bing" )
   {
     GuiControl, show, Bing,
   } else 	{
     GuiControl, hide, Bing,
			}

if  ( SearchEngine = "Quickbase" )
   {
     GuiControl, show, QuickBase,
   } else 	{
     GuiControl, hide, QuickBase,
			}

Gui Show, w1000 h700, 
SetTimer, MouseOverPicture, 1
SetTimer, GuiController, 1
return





MouseOverPicture:
Gui, Submit, NoHide
MouseGetPos,,,,id, 

if ( id = "Static16")
{
save = 1  
}

if ( id = "Static1")
{
save = 0  
}
return


GuiController: 																									; This updates the GUI Buttons based on the selected settings
IniRead, BrowserType, data\settings.ini, userdata, userpreferredbrowser  
IniRead, SearchEngine, data\settings.ini, userdata, userpreferredsearchengine  
if  ( save = "1" )
   {
     GuiControl, show, Mynosave,
   } else 	{
     GuiControl, hide, Mynosave,
			}
if  ( close = "1" )
   {
     GuiControl, show, Mynoclose,
   } else 	{
     GuiControl, hide, Mynoclose,
			}
			
if  ( BrowserType = "Chrome" )
   {
     GuiControl, show, Chrome,
   } else 	{
     GuiControl, hide, Chrome,
			}

if  ( BrowserType = "FireFox" )
   {
     GuiControl, show, FireFox,
   } else 	{
     GuiControl, hide, FireFox,
			}

if  ( BrowserType = "Edge" )
   {
     GuiControl, show, Edge,
   } else 	{
     GuiControl, hide, Edge,
			}

if  ( SearchEngine = "Google" )
   {
     GuiControl, show, Google,
   } else 	{
     GuiControl, hide, Google,
			}

if  ( SearchEngine = "Bing" )
   {
     GuiControl, show, Bing,
   } else 	{
     GuiControl, hide, Bing,
			}

if  ( SearchEngine = "Quickbase" )
   {
     GuiControl, show, QuickBase,
   } else 	{
     GuiControl, hide, QuickBase,
			}
return


WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) 		; hold left click to move window
{
   PostMessage 0xA1, 2
}

Chrome:
IniWrite, Chrome, data\settings.ini, userdata, userpreferredbrowser
return

FireFox:
IniWrite, FireFox, data\settings.ini, userdata, userpreferredbrowser
return

Edge:
IniWrite, Edge, data\settings.ini, userdata, userpreferredbrowser
return

Google:
IniWrite, Google, data\settings.ini, userdata, userpreferredsearchengine
return

Bing:
IniWrite, Bing, data\settings.ini, userdata, userpreferredsearchengine
return

Quickbase:
IniWrite, Quickbase, data\settings.ini, userdata, userpreferredsearchengine
return

Close(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
ExitApp
}

Save(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
ExitApp
}

GuiSize(GuiHwnd, EventInfo, Width, Height) {
    If (A_EventInfo == 1) {
        Return
    }

}

GuiEscape(GuiHwnd) {
    ExitApp
}

GuiClose(GuiHwnd) {
    ExitApp
}

OnWM_MOUSEMOVE(wParam, lParam, msg, hWnd) {

}

OnWM_LBUTTONDOWN(wParam, lParam, msg, hWnd) {

}




