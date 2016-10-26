segment .data

	consoleHandler 			dd 	1
	chainLarge				dd 	1
	lastParameter			dd 	1
	readenChar				dd 	1
	counter						dd 	0

segment .bss

	chain1 					resb 30
	chain2					resb 30
	chain3 					resb 30
	chain4 					resb 90

segment .text

	global 			_main
	extern 			_GetStdHandle@4
	extern 			_ReadConsoleA@20
	extern 			_WriteConsoleA@20
	extern 			_ExitProcess@4

_main:
		push 	dword -10
		call	_GetStdHandle@4
		mov 	[consoleHandler],eax

		xor 	eax,eax
		mov		eax,30d
		mov 	[chainLarge],eax
		xor 	eax,eax
		mov 	eax,0d
		mov 	[lastParameter],eax

		push 	dword [lastParameter]
		push	dword readenChar
		push	dword [chainLarge]
		push 	dword chain1
		push 	dword [consoleHandler]
		call 	_ReadConsoleA@20

		push 	dword [lastParameter]
		push	dword readenChar
		push	dword [chainLarge]
		push 	dword chain2
		push 	dword [consoleHandler]
		call 	_ReadConsoleA@20

		push 	dword [lastParameter]
		push	dword readenChar
		push	dword [chainLarge]
		push 	dword chain3
		push 	dword [consoleHandler]
		call 	_ReadConsoleA@20

		mov		edi,chain4											;Tomamos la direccion de inicio de chain4 como destino
		mov		esi,chain1											;Guardamos la direccion fuente
		mov		eax,chain2											;Guardamos chain2 en eax
		mov		ebx,chain3											;Guardamos chain3 en ebx

		mov 	ecx,0

_start:
		cmp		ecx,30
		je		_die
		inc 	ecx

_ch1:
		mov		dl,byte[esi]
		cmp		dl,0xA
		je		_ch2

		mov		byte[edi],dl
		inc 	esi
		inc		edi
		jmp 	_ch2

_ch2:
		mov		dl,byte[eax]
		cmp		dl,0xA
		je		_ch3

		mov		byte[edi],dl
		inc 	eax
		inc		edi
		jmp 	_ch3

_ch3:
		mov		dl,byte[ebx]
		cmp		dl,0xA
		je		_start

		mov		byte[edi],dl
		inc 	ebx
		inc		edi
		jmp 	_start


_die:
		inc 	edi
		mov		byte[edi], 0xA

		push 	dword -11
		call	_GetStdHandle@4
		mov 	[consoleHandler],eax

		xor 	eax,eax
		mov		eax,90d
		mov 	[chainLarge],eax
		xor 	eax,eax
		mov 	eax,0d
		mov 	[lastParameter],eax

		push	dword [lastParameter]
		push	dword readenChar
		push	dword [chainLarge]
		push 	dword chain4
		push	dword [consoleHandler]
		call 	_WriteConsoleA@20

		xor 	eax,eax
		mov 	eax,0d
		mov 	[lastParameter],eax
		push	dword [lastParameter]
		call 	_ExitProcess@4
