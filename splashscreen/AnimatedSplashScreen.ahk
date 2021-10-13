#NoEnv
#NoTrayIcon
SetWorkingDir, %A_ScriptDir%
#Include AniGIF.ahk

gif1 := New AniGIF("w280 h150 Center", "pacman.gif")
Gui -MinimizeBox -MaximizeBox -SysMenu +AlwaysOnTop -Caption +Owner
Gui, Show, w280
sleep 2000
Gui, Destroy
Exit


GuiClose:
ExitApp
