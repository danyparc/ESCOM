;(print2console_lanceregala.asm)
 ;nasm -f elf -g -F stabs print2console_lanceregala.asm
 ;ld -o p2c print2console_lanceregala.o -melf_i386
 ;./p2c

;initialized data
    section .data
          nln: dd 0xA
          nln_len: equ $-nln
          val: dd 48 ;remember that dd is a 32 bit double word which is the size of the register
          val_len: equ $-val ;if you use db or dw, keep in mind what can be done with the extended bits
          spacer: dd " "
;uninitialized data
    section .bss
          valueToPrint: resd 1 ;likewise, 1 resd = 4 resb (Dword = 4 Bytes)

    section .text
          global _start
_start:
    nop                             ;necessary for ld linking
 call _newline
    call _print_string         ;print this value in ASCII
  call _newline
  call _print_decimal ;if it's really a decimal, this is the actual, readable value converted to ASCII


 call _newline
    jmp _norm_exit           ;not expecting to return



_print_string:                       ;when you want to print the ASCII [val] it's easy
    mov eax, 4                       ;syswrite
    mov ebx, 1                       ;stdout
    mov ecx, val                     ;whatever value 'val' points to in [ecx] will print
    mov edx, val_len               ;...
    int 0x80                           ;invoke kernel to perform instruction
    jmp _return

_print_decimal:                       ;converting that pesky ASCII to it's decimal form
    push '$'                             ;throw a $ sign on my stack for no reason other than to designate a stack base
    mov eax, [val]                    ;[val] to decimal
.conversion:
    mov [val], eax
    xor edx, edx                       ;zero out edx (...can be accomplished in many different ways)
    mov ecx, 10                       ;mod out a base 10 place value
    idiv ecx                             ;signed divide (you can do unsigned division too) edx:eax by 10
                                                        ;...result in eax, remainder in edx
    add edx, 0x30                               ;convert the remainder to ascii, ('0' = 0x30)
                                                        ;(extra steps, commented out for hex conversion to print A-F)
    ;cmp edx, 0x39                             ;'9' comparison because numerical digit range is 0-9
    ;jng .hexrange  ;
    ;add edx, 0x07                              ;adding 7 hex to create an ascii
.hexrange:
    push edx ;push REMAINDER on stack (in e.g., it's 0)
    mov [val], eax ;copy the quotient into [val]
    cmp eax, 0
    jnz .conversion ;break from loop when eax == 0
.printpostfix:
    pop eax
    mov [valueToPrint], eax ;store contents of 'eax' in [valueToPrint]
    cmp eax, '$'
    je _return
    mov eax, 4 ;syswrite
    mov ebx, 1 ;stdout
    mov ecx, valueToPrint ;whatever value exists in [ecx] will print
    mov edx, 1 ;print only a single byte's worth of data
    int 0x80 ;invoke kernel to perform instruction
    jmp .printpostfix



_spacer:
    mov eax, 4
    mov ebx, 1
    mov ecx, spacer
    mov edx, 1
    int 80h
    jmp _return

 _newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, nln
    mov edx, 1
    int 80h
    jmp _return

 _return:
   ret

_norm_exit:
    mov eax, 1 ;initiate 'exit' syscall
    mov ebx, 0 ;exit with error code 0
    int 0x80 ;invoke kernel
    nop
    nop


 ; Lance
 ; November 5th, 2013
