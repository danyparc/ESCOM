segment .data

	cad1 db 	'Ingrese la primer cadena: ', 0xA
	cad2 db 	'Ingrese otra cadena: ', 0xA
	cad3 db 	'Cadena concatenada: ', 0xA
	cad4 db 	0xA,'Cadena invertida: ', 0xA
	cad5 db 	0xA,'La longitud es: ', 0xA
	tama 	db	 0d
	cont 	db   0d
segment .bss
	cadena  resb   4			; usada para lectura
	aux 	resb   4			; usada para impresion
	cadf 	resb 500
	cadIn	resb 500
	cadl 	resb 50

segment .text

	global _start

_start:
	mov edx,27d
	mov ecx,cad1		;Pedimos la prmier cadena
	mov ebx,1
	mov eax,4
	int 0x80

	mov edx,50d
	mov ecx,cadf		;Leemos la primer cadena
	mov ebx,0
	mov eax,3
	int 0x80

	mov edi,cadf
	mov ecx,0
	mov eax,1

	tam:
		mov dl,byte[edi]
		cmp dl,0xA
		je pre
		inc ecx
		inc edi
		jmp tam
	pre:
		add [tama],ecx
	proc:
		mov edx,21d
		mov ecx,cad2		;Pedimos la siguiente cadenas
		mov ebx,1
		mov eax,4
		int 0x80

		mov edx,50d
		mov ecx,cadl		;Leemos la siguiente cadena
		mov ebx,0
		mov eax,3
		int 0x80

		mov esi,cadl

	ciclo:
		mov dl,byte[esi]
		cmp dl,0xA
		je verificar
		mov byte[edi],dl
		inc edi
		inc esi
		mov ecx,1
		add [tama],ecx
		jmp ciclo

	verificar:
		mov eax,[cont]
		inc eax
		cmp eax,9
		je sig
		mov eax,1
		add [cont],eax
		jmp proc

	sig:
		mov esi,cadIn
		xor eax,eax
		mov eax, [tama]
		mov [aux],eax

	invertir:
		mov dl,byte[edi]
		cmp byte [aux],0d
		je faltante
		mov byte[esi],dl
		inc esi
		dec edi
		mov eax,-1
		add [aux],eax
		jmp invertir

	faltante:
		mov dl,byte[edi]
		mov byte[esi],dl
		jmp imprimir

	imprimir:
		mov edx,21d
		mov ecx,cad3
		mov ebx,1
		mov eax,4
		int 0x80

		mov edx,150d
		mov ecx,cadf
		mov ebx,1
		mov eax,4
		int 0x80

		mov edx,20d
		mov ecx,cad4
		mov ebx,1
		mov eax,4
		int 0x80

		mov edx,150d
		mov ecx,cadIn
		mov ebx,1
		mov eax,4
		int 0x80

	sig2:
		mov edx,19d
		mov ecx,cad5
		mov ebx,1
		mov eax,4
		int 0x80

	    cmp byte [tama],100d
	    jge caso3
	    cmp byte [tama],10d
	    jge caso2
	    jmp salir


		terminar:
			mov eax,[tama]
			;add eax,48d
			mov [tama],eax
			mov ecx, tama
	    	mov  eax, 4         	;llamada de sistema a salida
	    	mov  ebx, 1            	;salida estandar
	    	mov  edx, 1d            ;tamaño de cadena de salida
	    	int  0x80               ;interrupción de llamadas
	    	jmp salir

	    caso2:						;numero de 2 digitos
	    	xor eax,eax

	    	mov eax,[tama]
	    	mov bl,10
	    	mov dx,0
	    	mov ah,0
	    	div bl
	    	mov [tama],ax
	    	mov [aux],ah

		    mov  ecx, [tama]		;El resultado se guarda en eax, se manda a ecx
		    add  ecx, 48d          	;Se convierte a ASCII
		    mov  [cadena], ecx	    ;Se guarda en la cade
		    xor ecx, ecx
		    mov  ecx, [aux]			;El residuo se guarda en edx, se pasa a ecx
		    add  ecx, 48d           ;Se convierte a ASCII
		    mov  [cadena+1], ecx		;Se guarda el segundo valor

		    xor  edx, edx			;limpio edx
		    xor  eax, eax			;limpio eax

		    mov  ecx, cadena      	;guardo mi buffer otra vez en ecx para impresion
		    mov  eax, 4         	;llamada de sistema a salida
		    mov  ebx, 1            	;salida estandar
		    mov  edx, 2d             ;tamaño de cade de salida
		    int  0x80               ;interrupción de llamadas
		    jmp salir

	    caso3:						;numero de 3 digitos
	    	xor edx, edx
	    	xor eax,eax

			mov eax,[tama]
	    	mov bl,100
	    	mov dx,0
	    	mov ah,0
	    	div bl
	    	mov [tama],ax
	    	mov [aux],ah

	    	mov  ecx, [tama]		;El resultado se guarda en eax, se manda a ecx
		    add  ecx, 48d          	;Se convierte a ASCII
		    mov  [cadena], ecx	    ;Se guarda en la cade
		    xor ecx, ecx

		    mov eax,[aux]
	    	mov bl,10
	    	mov dx,0
	    	mov ah,0
	    	div bl
	    	mov [tama],ax
	    	mov [aux],ah

	    	mov  ecx, [tama]		;El resultado se guarda en eax, se manda a ecx
		    add  ecx, 48d          	;Se convierte a ASCII
		    mov  [cadena+1], ecx	    ;Se guarda en la cade
		    xor ecx, ecx
		    mov  ecx, [aux]			;El residuo se guarda en edx, se pasa a ecx
		    add  ecx, 48d           ;Se convierte a ASCII
		    mov  [cadena+2], ecx		;Se guarda el segundo valor

		    mov  ecx, cadena      	;guardo mi buffer otra vez en ecx para impresion
		    mov  eax, 4         	;llamada de sistema a salida
		    mov  ebx, 1            	;salida estandar
		    mov  edx, 3            ;tamaño de cade de salida
		    int  0x80               ;interrupción de llamadas

	salir:
		mov eax,1
		int 0x80
