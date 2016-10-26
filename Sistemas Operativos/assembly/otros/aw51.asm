segment .data
	argsTerminateProcess db 0x00,0x00
	handleConsole		 dd 1
	chainLong 		   dd 1
	readenChar		   dd 1
	RChar				     db 1
	lastParameter		 dd 1

	unit					   db 1
	ten				       db 1

segment .bss
	chain1	  			 resb 30

segment .text
	global _main
	extern _GetStdHandle@4
	extern _WriteConsoleA@20
	extern _ReadConsoleA@20
	extern _ExitProcess@4
_main:
	push dword -10
	call _GetStdHandle@4
	mov  [handleConsole],eax

	xor  eax,eax
	mov  eax,30d
	mov  [chainLong],eax
	xor  eax,eax
	mov  eax,0d
	mov  [lastParameter],eax

	push dword [lastParameter]
	push dword readenChar
	push dword [chainLong]
	push dword chain1
	push dword [handleConsole]
	call _ReadConsoleA@20

  mov byte[unit],47
  mov byte[ten],48
  mov   edi,chain1
_loop:

	inc byte[unit]
	inc edi
	cmp byte[unit],58
	je  _tenPlus

	jmp _loop2

_loop2:
	cmp byte[edi+1],0
	je _die
	jmp _loop

_tenPlus:
	inc byte[ten]
	mov byte[unit],48
	jmp _loop2

_die:
		xor  eax,eax
		push dword -11
		call _GetStdHandle@4
		mov [handleConsole],eax

		xor eax,eax
		mov eax,1d
		mov [chainLong],eax
		xor eax,eax
		mov eax,0d
		mov [lastParameter],eax

		push dword [lastParameter]
		push dword RChar
		push dword [chainLong]
		push dword ten
		push dword [handleConsole]
		call _WriteConsoleA@20

		xor  eax,eax
		push dword -11
		call _GetStdHandle@4
		mov [handleConsole],eax

		xor eax,eax
		mov eax,1d
		mov [chainLong],eax
		xor eax,eax
		mov eax,0d
		mov [lastParameter],eax

		push dword [lastParameter]
		push dword RChar
		push dword [chainLong]
		push dword unit
		push dword [handleConsole]
		call _WriteConsoleA@20

_exit:
		xor 	edx,edx
		mov     edx,0x00
		push    edx
		call    _ExitProcess@4
