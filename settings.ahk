#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

IniRead, ActivatedStatus, data\settings.ini, appdata, AuthenticationToken
IniRead, engine, data\settings.ini, userdata, userpreferredsearchengine
IniRead, browser, data\settings.ini, userdata, userpreferredbrowser
IniRead, logcalls, data\settings.ini, userdata, logcalls
IniRead, betamode, data\settings.ini, userdata, betamode


RegRead, vResultChrome, HKEY_CURRENT_USER\Software\Google\Chrome\PreferenceMACs\Default, homepage,                                          ; if Chrome is installed, this registry check will not give an error code, and Chrome will be added to the menu
if ErrorLevel
    {
        Gui Add, Radio, group x27 y24 w75 h23 gChrome disabled, Chrome
    }
else
    {    

if (browser = "Chrome")
{
    Gui Add, Radio, group x27 y24 w75 h23 gChrome checked, Chrome
}
else
{
    Gui Add, Radio, group x27 y24 w75 h23 gChrome, Chrome
}                                                
    }
RegRead, vResultFireFox, HKEY_CURRENT_USER\Software\Mozilla\Firefox\Default Browser Agent, C:\Program Files\Mozilla Firefox|Installed       ; if Firefox is installed, this registry check will not give an error code, and Firefox will be added to the menu
if ErrorLevel
    {
            Gui Add, Radio, x27 y48 w84 h23 gFireFox disabled, FireFox
    }
else
    {
if (browser = "FireFox")
{
    Gui Add, Radio, x27 y48 w84 h23 gFireFox checked, FireFox
}
else
{
    Gui Add, Radio, x27 y48 w84 h23 gFireFox, FireFox
}

}

if (browser = "Edge")                                                                                                                       ; Edge IS installed, so a registry check isnt needed
{
    Gui Add, Radio, x27 y72 w84 h23 gEdge checked, Edge
}
else
{
    Gui Add, Radio, x27 y72 w84 h23 gEdge, Edge
}






If ActivatedStatus > 0
Gui Add, StatusBar,,    Activation Status:   License Key Verified
else
Gui Add, StatusBar,,    Activation Status:   Not Licensed
Gui -MinimizeBox -MaximizeBox -SysMenu +AlwaysOnTop
Gui Font, s9, Segoe UI
Gui Add, Button, x183 y109 w80 h23, &Done
Gui Add, GroupBox, x135 y1 w127 h102, Preferred Engine
Gui Add, GroupBox, x8 y1 w119 h103, Preferred Browser




if (engine = "Google")
{
Gui Add, Radio, group x163 y24 w75 h23 gGoogle checked, Google
}
else
{
    Gui Add, Radio, group x163 y24 w75 h23 gGoogle, Google
}

if (engine = "Bing")
{
Gui Add, Radio, x163 y48 w75 h23 gBing checked, Bing
}
else
{
Gui Add, Radio, x163 y48 w75 h23 gBing, Bing
}

if (engine = "QuickBase")
{
Gui Add, Radio, x163 y72 w75 h23 gQuickbase checked, QuickBase
}
else
{
Gui Add, Radio, x163 y72 w75 h23 gQuickbase, QuickBase
}

if (logcalls = "true")
{
Gui Add, CheckBox, x12 y110 w69 h23 gLogCalls checked, Log calls
}
else
{
Gui Add, CheckBox, x12 y110 w69 h23 gLogCalls, Log calls
}

if (betamode = "true")
{
Gui Add, CheckBox, x88 y110 w88 h23 gBetaMode checked, Beta mode
}
else
{
Gui Add, CheckBox, x88 y110 w88 h23 gBetaMode, Beta mode
}

Gui Show, w268 h162, Whos Calling Settings



return



ButtonDone:
GuiEscape:
GuiClose:
    ExitApp


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

LogCalls:
IniRead, logcalls, data\settings.ini, userdata, logcalls
if (logcalls = "true")
IniWrite, false, data\settings.ini, userdata, logcalls
else if (logcalls = "false")
IniWrite, true, data\settings.ini, userdata, logcalls
return

BetaMode:
IniRead, betamode, data\settings.ini, userdata, betamode
if (betamode = "true")
IniWrite, false, data\settings.ini, userdata, betamode
else if (betamode = "false")
IniWrite, true, data\settings.ini, userdata, betamode
return
return