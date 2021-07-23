#SingleInstance Force

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

global tool := 0

MsgBox, 64, Pixel Tools, FERRAMENTA LIGADA!

MButton::

tool++

if (tool > 2)
{
	tool := 0
}
if (tool = 0)
{
	ToolTip
	SetTimer, area, Off
	MsgBox, 64, Pixel Tools, FERRAMENTA DESLIGADA!
}
if (tool = 1)
{
	Gui, Main:Default
	Gui, Destroy
	MsgBox, 64, Pixel Tools, BUSCA COR
	Gui, Cor:New
	Gui, +AlwaysOnTop +Resize
	Gui, Show, w200 h200 x0 y0, COR
	SetTimer, gui_cor, 0
}
if (tool = 2)
{
	SetTimer, gui_cor, Off
	MsgBox, 64, Pixel Tools, BUSCAR ÁREA
	SetTimer, area, 0
	ToolTip, Selecione uma área
	Gui, Cor:Default
	Gui, Destroy
	Gui, Main:New
	Gui, -Caption Border +AlwaysOnTop
	Gui, Color, 0xD0FFFF
	Gui, +LastFound
	WinSet, Transparent, 50
}
return

#if (tool = 1)

LControl & RAlt::
MouseGetPos, x, y
PixelGetColor, cor, %x%, %y%
Clipboard := cor
ToolTip, COR COPIADA!
Sleep, 500
ToolTip
return

gui_cor:
MouseGetPos, xgui, ygui
PixelGetColor, cor2, %xgui%, %ygui%, RGB
Gui, Cor:Color, %cor2%
return

Up::
MouseGetPos, x, y
MouseMove, % x, % y - 1
return

Down::
MouseGetPos, x, y
MouseMove, % x, % y + 1
return

Left::
MouseGetPos, x, y
MouseMove, % x - 1, % y
return

Right::
MouseGetPos, x, y
MouseMove, % x + 1, % y
return

#if (tool = 2)

RButton::
SetTimer, area, Off
Gui, Main:Default
MouseGetPos, x1, y1
while GetKeyState("RButton", "P")
{
	ToolTip, %x1%`, %y1%`, %x2%`, %y2%
	MouseGetPos, x2, y2
	x3 := x2 - x1
	y3 := y2 - y1
	Gui, Show, x%x1% y%y1% w%x3% h%y3%
}
Gui, Cancel
Clipboard = %x1%, %y1%, %x2%, %y2%
ToolTip, ÁREA COPIADA!
Sleep, 1000
ToolTip
SetTimer, area, 0
return

area:
ToolTip, Selecione uma área
return

#if

End::
ExitApp