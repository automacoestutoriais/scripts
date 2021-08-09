;~ Esse script foi criado com o intuito de ajudar a todos aqueles que vão utilizar os comandos PixelSearch ou ImageSearch, facilitando na hora de pegar uma cor ou uma área para fazer uma busca.

;~ As ações e o seu funcionamento são mostrados no Vídeo Tutorial 17, na seguinte minutagem:  https://youtu.be/57AHZv4G1GM?t=506

;~ Você pode ficar a vontade para alterar e mudar os botões que executam cada ação. Tais botões são:

;~ MButton:: (Linha 25)(Botão do Meio do Mouse) - Serve para ligar o script e mudar de função.
;~ LControl & RAlt:: (Linha 64)(Tecla AltGr ou Teclas Ctrl do Lado Esquerdo + Alt do Lado Direito) - Serve para copiar a cor exibida.
;~ Up:: (Linha 79)(Seta para Cima) - Serve para andar com o mouse 1 Pixel para cima.
;~ Down:: (Linha 84)(Seta para Baixo) - Serve para andar com o mouse 1 Pixel para baixo.
;~ Left:: (Linha 89)(Seta para Esquerda) - Serve para andar com o mouse 1 Pixel para esquerda.
;~ Right:: (Linha 94)(Seta para Direita) - Serve para andar com o mouse 1 Pixel para direita.
;~ RButton:: (Linha 101)(Botão Direito do Mouse) - Serve para selecionar uma área.
;~ End:: (Linha 137)(Tecla End) - Serve para finalizar o script.

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
	Gui, Area:Destroy
	MsgBox, 64, Pixel Tools, BUSCA COR
	Gui, Cor:New
	Gui, Cor:+AlwaysOnTop +Resize
	Gui, Cor:Show, w200 h200 x0 y0, COR
	SetTimer, gui_cor, 0
}
if (tool = 2)
{
	Gui, Cor:Destroy
	SetTimer, gui_cor, Off
	MsgBox, 64, Pixel Tools, BUSCAR ÁREA
	SetTimer, area, 0
	Gui, Area:New
	Gui, Area:-Caption Border +AlwaysOnTop
	Gui, Area:Color, 0xD0FFFF
	Gui, Area:+LastFound
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
MouseGetPos, x1, y1
while GetKeyState("RButton", "P")
{
	ToolTip, %x1%`, %y1%`, %x2%`, %y2%
	MouseGetPos, x2, y2
	x3 := x2 - x1
	y3 := y2 - y1
	Gui, Area:Show, x%x1% y%y1% w%x3% h%y3%
}
ToolTip
Gui, Area:Cancel
Clipboard = %x1%, %y1%, %x2%, %y2%
ToolTip, ÁREA COPIADA!
Sleep, 1000
ToolTip
SetTimer, area, 0
return

area:
if (tool = 0)
{
	SetTimer, area, Off
}
else
{
	ToolTip, Selecione uma área
}
return

#if

CorGuiClose:
ExitApp

End::
ExitApp