segment	.data

	msj db 'Ingrese cadena: ', 0xA ;mensaje inicial
	cadena	db	50		;cadena definida con su tamaño en bytes
	salida	db	4		;cadena definida con su tamaño en bytes
	outputBuffer    resb    4  	;buffer para almacenar mi numero al convertirlo

segment	.text
 	global	_start

_start:

		mov edx,16d
		mov ecx,msj
		mov ebx,1
		mov eax,4
		int 0x80
		;Mensaje inicial

    mov	edx,50d			;tamaño de la cadena a leer
    mov	ecx,cadena		;variable en la que guardaremos lo leido
    mov	ebx,0			;entrada estandar
    mov	eax,3			;llamada al sistema de entrada
    int	0x80			;interrupción de llamadas

    mov eax, cadena		;guardo mi cadena en eax
    mov ecx, 0			;seteo ecx en 0

.loop:				;loop para contar longitud
    inc ecx			;incremento ecx en 1
    cmp byte [eax + ecx], 0	;comparo el caracter de mi cadena con 0 que es un espacio, \n o \r
    jne .loop			;hago un salto al inicio de mi loop
				;25

.if:				;loop para contar longitud			;incremento ecx en 1
    cmp ecx, 10			;comparo el caracter de mi cadena con 0 que es un espacio, \n o \r
    jg  .caso2			;hago un salto al inicio de mi loop

.caso1:
    add  ecx, -1		;resto 1 debido a que conté ecx una vez de mas
    add  ecx, 0x30              ;agrego 30 en hexagesimal para volverlo ascii
    mov  [outputBuffer], ecx    ;guardo numero en el buffer
    mov  ecx, outputBuffer      ;guardo mi buffer otra vez en ecx para impresion

    mov  eax, 4         	;llamada de sistema a salida
    mov  ebx, 1            	;salida estandar
    mov  edx, 1                 ;tamaño de cadena de salida
    int  0x80                   ;interrupción de llamadas
				;42
    mov eax, 1           	;llamada para teminar
    mov ebx, 0                  ;exit(0)
    int 0x80                    ;interrupcion de sistema

.caso2:

    add  ecx, -1
    xor  edx, edx		;limpio edx
    mov  eax, ecx		;ingreso ecx en eax
    mov  ebx, 10		;inserto 10 en edx
    idiv ebx			;divido eax entre ebx
				;53
    mov  ecx, eax		;inserto eax en ecx
    add  ecx, 0x30              ;agrego 30 en hexagesimal para volverlo ascii
    mov  [salida], ecx	    	;guardo numero en el buffer
    mov  ecx, edx		;inserto eax en ecx

    add  ecx, 0x30              ;agrego 30 en hexagesimal para volverlo ascii
    mov  [salida+1], ecx	;guardo numero en el buffer

    mov  ecx, salida      ;guardo mi buffer otra vez en ecx para impresion
    xor  edx, edx		;limpio edx
    xor  eax, eax		;limpio eax
    mov  eax, 4         	;llamada de sistema a salida
    mov  ebx, 1            	;salida estandar
    mov  edx, 2                 ;tamaño de cadena de salida
    int  0x80                   ;interrupción de llamadas

    mov eax, 1           	;llamada para teminar
    mov ebx, 0                  ;exit(0)
    int 0x80                    ;interrupcion de sistema
