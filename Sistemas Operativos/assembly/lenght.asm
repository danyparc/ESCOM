segment	.data

	msj db 'Ingrese cadena: ', 0xA 
	cadena	db	50		
	salida	db	4		
	outputBuffer    resb    4  	

segment	.text
 	global	_start

_start:

		mov edx,16d
		mov ecx,msj
		mov ebx,1
		mov eax,4
		int 0x80
		

    mov	edx,50d			
    mov	ecx,cadena		
    mov	ebx,0			
    mov	eax,3			
    int	0x80			

    mov eax, cadena		
    mov ecx, 0			

.loop:				
    inc ecx			
    cmp byte [eax + ecx], 0	
    jne .loop			
				

.if:				
    cmp ecx, 10			
    jg  .caso2			

.caso1:
    add  ecx, -1		
    add  ecx, 0x30              
    mov  [outputBuffer], ecx    
    mov  ecx, outputBuffer      

    mov  eax, 4         	
    mov  ebx, 1            	
    mov  edx, 1                 
    int  0x80                   
				
    mov eax, 1           	
    mov ebx, 0                  
    int 0x80                    

.caso2:

    add  ecx, -1
    xor  edx, edx		
    mov  eax, ecx		
    mov  ebx, 10		
    idiv ebx			
				
    mov  ecx, eax		
    add  ecx, 0x30              
    mov  [salida], ecx	    	
    mov  ecx, edx		

    add  ecx, 0x30              
    mov  [salida+1], ecx	

    mov  ecx, salida      
    xor  edx, edx		
    xor  eax, eax		
    mov  eax, 4         	
    mov  ebx, 1            	
    mov  edx, 2                 
    int  0x80                   

    mov eax, 1           	;
    mov ebx, 0                  
    int 0x80                    
