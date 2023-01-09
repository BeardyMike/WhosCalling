#SingleInstance
#NoTrayIcon
SplashPicture()

ExitApp, [ ExitCode]

SplashVideo()
    {
        global
        splashvideo := "media\Logo.mp4"
        Gui, -Caption
        Gui, Add, ActiveX, x0 y0 w700 h500 vWMP, WMPLayer.OCX
        WMP.Url := splashvideo
        WMP.uiMode := "none"  ;no WMP controls
        ; WMP.stretchToFit := 1    ;video is streched to the given activex range
        WMP.enableContextMenu := 0    ;no reaction to right click in the video field
        sleep, 10
        Gui, Show, w700 h500 Center
        sleep, 5000
        return
    }
SplashPicture()
    {
        global
        splashpicture := "media\gui assets\splash.png"
        Gui, -Caption
        Gui, Add, Picture, x0 y0 w650 h475 vPic, %splashpicture%
        Gui, Show, w650 h475 Center
        sleep, 2000
        return
    }