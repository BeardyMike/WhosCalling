; AniGIF: https://www.codeproject.com/Articles/16970/AniGIF-a-simple-animated-GIF-custom-control

/*
	Create an AniGIF control either by `AniGIF_Add()` or `New AniGIF()`.

	The usage is same as `Gui Add`, except an additional Link parameter at the end (optional). Examples:

		AniGIF_Add("xm w200 h200 Center BackGroundRed", "test.gif", "http://autohotkey.com")

		gif2 := AniGIF_Add("xm", "test2.gif") ; Omit w and h to autosize the control
		gif2.SetBkColor(0xff00ff)
		gif2.LoadGifFromFile("another.gif")
		
		Gui, Show, w400

	Methods:
		LoadGifFromFile(FileName)
		UnloadGif()
		Zoom(bZoom := true) ; bZoom -- TRUE = Zoom In by 10%, FALSE = Zoom Out by 10%
		SetBkColor(BkColor) ; BkColor -- Color Name or RGB value
		SetHyperlink(Link)
*/


AniGIF_Add(Options := "", FileName := "", Link := "")
{
	return New AniGIF(Options, FileName, Link)
}

class AniGIF
{
	static hModule := DllCall("LoadLibrary", "str", AniGIF._findDll(), "ptr")

	__New(Options := "", FileName := "", Link := "")
	{
		_style := !(Options ~= "i)\b[wh]\d+\b") ? 0x1 ; WAGS_AUTOSIZE
		         : (Options ~= "i)\bCenter\b") ? 0x2 ; WAGS_CENTER
		         : ""
		Gui, Add, Custom, ClassAniGIF %Options% %_style% HWNDhCtrl, %FileName%
		this.hCtrl := hCtrl

		if (FileName != "") && FileExist(FileName)
			this.LoadGifFromFile(FileName)

		if RegExMatch(Options, "i)\bBackGround\K\w+\b", c)
			this.SetBkColor(c)

		if Link
			this.SetHyperlink(Link)
	}

	LoadGifFromFile(FileName) {
		DllCall("SendMessage", "ptr", this.hCtrl, "uint", 2024, "uint", 0, "astr", FileName) ; WAGM_LOADGIFFROMFILE := 2024
	}

	UnloadGif() {
		SendMessage, 2026, 0, 0,, % "ahk_id " this.hCtrl ; WAGM_UNLOADGIF := 2026
	}

	; bZoom: TRUE = Zoom In by 10%, FALSE = Zoom Out by 10%
	Zoom(bZoom := true) {
		SendMessage, 2028, 0, bZoom,, % "ahk_id " this.hCtrl ; WAGM_ZOOM := 2028
	}

	SetBkColor(BkColor) {
		if (StrLen(BkColor) = 6) && (BkColor ~= "\d")
			BkColor := "0x" BkColor
		else if (BkColor + 0 = "")
			BkColor := this._getRGB(BkColor)

		BkColor := this._RGB2BGR(BkColor)
		SendMessage, 2029, 0, BkColor,, % "ahk_id " this.hCtrl ; WAGM_SETBKCOLOR := 2029
	}

	SetHyperlink(Link) {
		GuiControl, +0x4, % this.hCtrl ; WAGS_HYPERLINK := 0x4
		DllCall("SendMessage", "ptr", this.hCtrl, "uint", 2027, "uint", 0, "astr", Link) ; WAGM_SETHYPERLINK := 2027
	}

	_findDll()
	{
		if (A_PtrSize = 8)
			throw "AHK U64 is not supported"

		for i, file in ["AniGIF.dll", A_LineFile "\..\AniGIF.dll"]
		{
			if FileExist(file)
				return file
		}
		throw "Unable to find AniGIF.dll"
	}

	_getRGB(sColor)
	{
		static colorName
		if !colorName
			colorName := { Black: 0x000000, Silver: 0xC0C0C0, Gray: 0x808080, White: 0xFFFFFF, Maroon: 0x800000
			              , Red: 0xFF0000, Purple: 0x800080, Fuchsia: 0xFF00FF, Green: 0x008000, Lime: 0x00FF00
			              , Olive: 0x808000, Yellow: 0xFFFF00, Navy: 0x000080, Blue: 0x0000FF, Teal: 0x008080, Aqua: 0x00FFFF }
		if ( val := colorName[sColor] )
			return val
	}

	_RGB2BGR(color)
	{
		return color ^ (((color & 0xFF) ^ (color / 0x10000)) * 0x10001)
	}
}