segment .data

	message 				db 	'0',0xA
	consoleHandler 			dd 	1
	chainLarge				dd 	1
	lastParameter			dd 	1
	readenChar				dd 	1
	counter 				dd 	0

segment .text
	
	global 		_main
	extern 		_GetStdHandle@4
	extern 		_WriteConsoleA@20
	extern 		_ExitProcess@4

_main:
		
		push 	dword -11
		call 	_GetStdHandle@4
		mov 	[consoleHandler],eax
_loop:
		xor		eax,eax
		mov		eax,2d
		mov 	[chainLarge],eax
		xor		eax,eax
		mov		eax,0d
		mov		[lastParameter],eax

		push	dword [lastParameter]
		push	dword readenChar
		push	dword [chainLarge]
		push 	dword message
		push	dword [consoleHandler]
		call 	_WriteConsoleA@20

		inc 	byte [message]
		inc 	dword [counter]
		mov 	eax,[counter]
		cmp		eax,10
		jne 		_loop

		xor		eax,eax
		mov		eax,0d
		mov		[lastParameter],eax
		push 	dword [lastParameter]
		call 	_ExitProcess@4