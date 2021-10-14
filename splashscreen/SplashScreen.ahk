#NoTrayIcon
file := "media\Logo.mp4"
Gui, -Caption
Gui, Add, ActiveX, x0 y0 w700 h500 vWMP, WMPLayer.OCX
WMP.Url := file
WMP.uiMode := "none"  ;no WMP controls
; WMP.stretchToFit := 1    ;video is streched to the given activex range
WMP.enableContextMenu := 0    ;no reaction to right click in the video field
sleep, 10
Gui, Show, w700 h500 Center
sleep, 5000
ExitApp, [ ExitCode]