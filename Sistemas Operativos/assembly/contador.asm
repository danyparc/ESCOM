segment .data
segment .text
  global _start
  global ciclo
  global salir
  ;global _salir
_start:
  xor eax,eax
  jmp ciclo

ciclo:
  mov edx,1d
  mov ecx,eax
  mov ebx,1
  mov eax,4
  int 0x80
  inc eax
  cmp eax,10
  je salir
  jmp ciclo

salir:
  mov eax,1
  int 0x80
