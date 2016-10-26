Ltext0:
  .section .rodata
	.LC0:
    .string   "Ingrese la cadena uno:\t"
	.LC1:
    .string   "Ingrese la cadena dos:\t"
  .LC2:
    .string   "Ingrese la cadena tres:\t"
	  .text
    .globl 	main
  main:
    .LFB0:
      .cfi_startproc
  	  pushq   %rbp
      .cfi_def_cfa_offset 16
      .cfi_offset 6, -16
      movq	%rsp, %rbp
      .cfi_def_cfa_register 6
      subq  	$96, %rsp
      movq	%fs:40, %rax
      movq	%rax, -8(%rbp)
      xorl    	%eax, %eax
      movl  	$.LC0, %edi
      call     	puts
      leaq   	-96(%rbp), %rax
      movq	%rax, %rdi
      call     	gets
      movl  	$.LC1, %edi
      call     	puts
      leaq   	-64(%rbp), %rax
      movq	%rax, %rdi
      call     	gets
      movl  	$.LC2, %edi
      call     	puts
      leaq   	-32(%rbp), %rax
      movq	%rax, %rdi
      call     	gets
      leaq   	-64(%rbp), %rdx
      leaq   	-96(%rbp), %rax
      movq	%rdx, %rsi
      movq	%rax, %rdi
      call     	strcat
      leaq   	-32(%rbp), %rdx
      leaq   	-96(%rbp), %rax
      movq	%rdx, %rsi
      movq	%rax, %rdi
      call     	strcat
      leaq   	-96(%rbp), %rax
      movq	%rax, %rdi
      call     	puts
      movl  	$0, %eax
      movq	-8(%rbp), %rcx
      xorq  	%fs:40, %rcx
      je        	.L3
      call     	__stack_chk_fail
 	.L3:
      leave
      .cfi_def_cfa 7, 8
   	  ret
      .cfi_endproc

  .LFE0:
  .Letext0:
