SetKeyDelay, 10, 10

Run, notepad,,, pid
WinWait, ahk_pid %pid%
Sleep, 500
inicio:
ControlSendRaw, Edit1, -GERENCIADOR DE ARQUIVOS-, ahk_pid %pid%
Sleep, 500
ControlSend, Edit1, {Enter 2}
Sleep, 500
ControlSendRaw, Edit1, Selecione um diretório:, ahk_pid %pid%
Sleep, 500
FileSelectFolder, diretorio
Sleep, 500
if ErrorLevel
{
	ControlSend, Edit1, {Enter 2}
	Sleep, 500
	ControlSendRaw, Edit1, Você não selecionou um diretório..., ahk_pid %pid%
	Sleep, 500
	ControlSetText, Edit1,, ahk_pid %pid%
	WinClose
	return
}
Sleep, 500
ControlSend, Edit1, {Enter 2}
Sleep, 500
ControlSendRaw, Edit1, Listando diretório %diretorio%, ahk_pid %pid%
Sleep, 500
SetKeyDelay, 500, 500
ControlSendRaw, Edit1, ..., ahk_pid %pid%
SetKeyDelay, 10, 10
Sleep, 500
arquivos := []
arquivos1 := []
Loop Files, %diretorio%\*.*
{
	arquivos.Push(A_Index . " - " . A_LoopFileName)
}
Loop Files, %diretorio%\*.*
{
	arquivos1.Push(A_LoopFileName)
}
ControlSend, Edit1, {Enter 2}
Sleep, 500
Loop % arquivos.Length()
{
	lista := arquivos[A_Index]
	ControlSend, Edit1, %lista%, ahk_pid %pid%
	ControlSend, Edit1, {Enter}
}
Sleep, 500
ControlSend, Edit1, {Enter}
Sleep, 500
ControlSendRaw, Edit1, Digite o número do arquivo desejado e pressione Enter:, ahk_pid %pid%
Sleep, 500
ControlSend, Edit1, {Enter}
KeyWait, Enter, D
ControlGet, linha1, CurrentLine,, Edit1, ahk_pid %pid%
ControlGet, arq, Line, % linha1 - 1, Edit1, ahk_pid %pid%
selec := arquivos[arq]
selec1 := arquivos1[arq]
Sleep, 500
ControlSend, Edit1, {Enter}
Sleep, 500
ControlSendRaw, Edit1, -OPÇÕES-`n`n1 - Abrir %selec1%`n2 - Mover %selec1%`n3 - Copiar %selec1%`n4 - Deletar %selec1%, ahk_pid %pid%
Sleep, 500
ControlSend, Edit1, {Enter 2}
Sleep, 500
ControlSend, Edit1, Digite uma opção e pressione Enter:, ahk_pid %pid%
Sleep, 500
ControlSend, Edit1, {Enter}
KeyWait, Enter, D
ControlGet, linha2, CurrentLine,, Edit1, ahk_pid %pid%
ControlGet, opcao, Line, % linha - 1, Edit1, ahk_pid %pid%
Sleep, 500
ControlSend, Edit1, {Enter}
Sleep, 500

Switch opcao
{
	Case 1:
		ControlSend, Edit1, Abrindo %selec1%, ahk_pid %pid%
		Sleep, 500
		SetKeyDelay, 500, 500
		ControlSendRaw, Edit1, ..., ahk_pid %pid%
		SetKeyDelay, 10, 10
		Sleep, 500
		Run, %diretorio%\%selec1%
	Case 2:
		ControlSendRaw, Edit1, Selecione o diretório de destino:, ahk_pid %pid%
		Sleep, 500
		FileSelectFolder, diretorio2
		Sleep, 500
		if ErrorLevel
		{
			ControlSend, Edit1, {Enter 2}
			Sleep, 500
			ControlSendRaw, Edit1, Você não selecionou um diretório..., ahk_pid %pid%
			Sleep, 500
			ControlSetText, Edit1,, ahk_pid %pid%
			WinClose
			return
		}
		Sleep, 500
		ControlSend, Edit1, {Enter 2}
		Sleep, 500
		ControlSendRaw, Edit1, Movendo o arquivo %selec1% para o diretório %diretorio2%, ahk_pid %pid%
		Sleep, 500
		SetKeyDelay, 500, 500
		ControlSendRaw, Edit1, ..., ahk_pid %pid%
		SetKeyDelay, 10, 10
		Sleep, 500
		FileMove, %diretorio%\%selec1%, %diretorio2%
		ControlSend,, {F5}, ahk_class Progman
		Sleep, 500
		ControlSend, Edit1, {Enter 2}
		Sleep, 500
		ControlSendRaw, Edit1, Arquivo movido com sucesso!, ahk_pid %pid%
		Sleep, 500
	Case 3:
		ControlSendRaw, Edit1, Selecione o diretório de destino:, ahk_pid %pid%
		Sleep, 500
		FileSelectFolder, diretorio3
		Sleep, 500
		if ErrorLevel
		{
			ControlSend, Edit1, {Enter 2}
			Sleep, 500
			ControlSendRaw, Edit1, Você não selecionou um diretório..., ahk_pid %pid%
			Sleep, 500
			ControlSetText, Edit1,, ahk_pid %pid%
			WinClose
			return
		}
		Sleep, 500
		ControlSend, Edit1, {Enter 2}
		Sleep, 500
		ControlSendRaw, Edit1, Copiando o arquivo %selec1% para o diretório %diretorio3%, ahk_pid %pid%
		Sleep, 500
		SetKeyDelay, 500, 500
		ControlSendRaw, Edit1, ..., ahk_pid %pid%
		SetKeyDelay, 10, 10
		Sleep, 500
		FileCopy, %diretorio%\%selec1%, %diretorio3%
		Sleep, 500
		ControlSend, Edit1, {Enter 2}
		Sleep, 500
		ControlSendRaw, Edit1, Arquivo copiado com sucesso!, ahk_pid %pid%
		Sleep, 500
	Case 4:
		ControlSendRaw, Edit1, Deletando o arquivo %selec1%, ahk_pid %pid%
		Sleep, 500
		SetKeyDelay, 500, 500
		ControlSendRaw, Edit1, ..., ahk_pid %pid%
		SetKeyDelay, 10, 10
		Sleep, 500
		FileDelete, %diretorio%\%selec1%
		ControlSend,, {F5}, ahk_class Progman
		Sleep, 500
		ControlSend, Edit1, {Enter 2}
		Sleep, 500
		ControlSendRaw, Edit1, Arquivo deletado com sucesso!, ahk_pid %pid%
		Sleep, 500
	Default:
		MsgBox, Opção inválida!
		Sleep, 500
		ControlSetText, Edit1,, ahk_pid %pid%
		WinClose
		return
}
Sleep, 1000
if (opcao = 1)
{
	IfWinNotActive, ahk_pid %pid%
	{
		WinWaitActive, ahk_pid %pid%
	}
}
Sleep, 500
ControlSend, Edit1, {Enter 2}
Sleep, 500
ControlSendRaw, Edit1, -OPÇÔES-`n`n1 - Escolher novo diretório`n2 - Sair , ahk_pid %pid%
Sleep, 500
ControlSend, Edit1, {Enter 2}
Sleep, 500
ControlSendRaw, Edit1, Digite uma opção e pressione Enter:, ahk_pid %pid%
Sleep, 500
ControlSend, Edit1, {Enter}
KeyWait, Enter, D
ControlGet, linha3, CurrentLine,, Edit1, ahk_pid %pid%
ControlGet, opcao2, Line, % linha - 1, Edit1, ahk_pid %pid%
Sleep, 1000

Switch opcao2
{
	Case 1:
		ControlSetText, Edit1,, ahk_pid %pid%
		Sleep, 500
		goto, inicio
	Case 2:
		ControlSend, Edit1, {Enter}
		Sleep, 500
		ControlSendRaw, Edit1, Saindo, ahk_pid %pid%
		Sleep, 500
		SetKeyDelay, 500, 500
		ControlSendRaw, Edit1, ..., ahk_pid %pid%
		SetKeyDelay, 10, 10
		Sleep, 500
		ControlSetText, Edit1,, ahk_pid %pid%
		WinClose
	Default:
		MsgBox, Opção inválida!
		Sleep, 500
		ControlSetText, Edit1,, ahk_pid %pid%
		WinClose
		return
}