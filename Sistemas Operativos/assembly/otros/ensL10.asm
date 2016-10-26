segment .data

	msj1 db 'Primer cadena:', 0xA
	msj2 db 'Segunda cadena:', 0xA
	msj3 db 'Tercer cadena:', 0xA
	msjF db	'La cadena final es:', 0xA

segment .bss

	cad1 resb 50
	cad2 resb 50
	cad3 resb 50
	cadF resb 150

segment .text

	global _start

_start:

	mov edx,14d
	mov ecx,msj1
	mov ebx,1
	mov eax,4
	int 0x80
	;primer mensaje

	mov edx,50d
	mov ecx,cad1
	mov ebx,0
	mov eax,3
	int 0x80
	;introducimos la primer cadena

	mov edx,15d
	mov ecx,msj2
	mov ebx,1
	mov eax,4
	int 0x80
	;segundo msj

	mov edx,50d
	mov ecx,cad2
	mov ebx,0
	mov eax,3
	int 0x80
	;introducimos la segunda cadena

	mov edx,14d
	mov ecx,msj3
	mov ebx,1
	mov eax,4
	int 0x80
	;tercer msj

	mov edx,50d
	mov ecx,cad3
	mov ebx,0
	mov eax,3
	int 0x80
	;introduciomos la tercer cadena

	mov edi,cadF
	mov esi,cad1
	mov eax,cad2
	mov ebx,cad3
	mov ecx,0
	;asignamos las cadenas a registros

	;mover cadena 1
	loop:
		mov dl,byte[esi]
		cmp dl,0xA
		je caso1
		mov byte[edi],dl
		inc edi
		inc esi
		jmp loop1
	caso1:
		inc ecx
		jmp loop1
	;mover cadena 2
	loop1:
		mov dl,byte[eax]
		cmp dl,0xA
		je caso2
		mov byte[edi],dl
		inc edi
		inc eax
		jmp loop2
	caso2:
		inc ecx
		jmp loop2
	;mover cadena 3
	loop2:
		mov dl,byte[ebx]
		cmp dl,0xA
		je caso3
		mov byte[edi],dl
		inc edi
		inc ebx
		jmp loop
	caso3:
		inc ecx
		jmp verifica
	verifica:
		cmp ecx,3
		je salida
		mov ecx,0
		jmp loop
salida:
	inc edi
	mov byte [edi],0xA

	mov edx,19d
	mov ecx,msjF
	mov ebx,1
	mov eax,4
	int 0x80
	;imprimimos el msj final

	mov edx,150d
	mov ecx,cadF
	mov ebx,1
	mov eax,4
	int 0x80
	;Imprimimos la cadena final


	mov eax,1
	int 0x80
