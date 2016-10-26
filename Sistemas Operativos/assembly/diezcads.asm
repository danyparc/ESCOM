.Ltext0:
         	      	.section 	.rodata
         		.LC0:
      	.string  	"Introduce la primera cadena:"

         		.LC1:
      	.string  	"Introduce la segunda cadena:"

         		.LC2:
      	.string  	"resultado: \"%s\"\n"

         		.LC3:
      	.string  	"Pause"

         	      	.text
         	      	.globl main
         		main:
         		.LFB0:
         	      	.cfi_startproc
      	pushq  %rbp
         	      	.cfi_def_cfa_offset 16
         	      	.cfi_offset 6, -16
      	movq   %rsp, %rbp
         	      	.cfi_def_cfa_register 6
      	addq   $-128, %rsp
      	movq   %fs:40, %rax
 	movq   %rax, -8(%rbp)
      	xorl   %eax, %eax
      	movl   $.LC0, %edi
 	call   puts
 	movq   stdin(%rip), %rdx
 	leaq   -80(%rbp), %rax
      	movl   $30, %esi
 	movq   %rax, %rdi
      	call   fgets
 	testq  %rax, %rax
      	jne	.L2
      	movl   $1, %eax
 	jmp	.L7
 	leaq   -80(%rbp), %rax
      	movl   $10, %esi
 	movq   %rax, %rdi
      	call   strchr
 	movq   %rax, -120(%rbp)
      	cmpq   $0, -120(%rbp)
      	je 	.L4
      	movq   -120(%rbp), %rax
      	movb   $0, (%rax)
   	 .L4:
      	movl   $.LC1, %edi
 	call   puts
 	movq   stdin(%rip), %rdx
 	leaq   -112(%rbp), %rax
      	movl   $30, %esi
 	movq   %rax, %rdi
      	call   fgets
 	testq  %rax, %rax
      	jne	.L5
      	movl   $1, %eax
 	jmp	.L7
       .L5:
      	leaq   -112(%rbp), %rax
      	movl   $10, %esi
 	movq   %rax, %rdi
      	call   strchr
 	movq   %rax, -120(%rbp)
      	cmpq   $0, -120(%rbp)
 	je 	.L6
      	-120(%rbp), %rax
      	movb   $0, (%rax)
         		.L6:
      	leaq   -112(%rbp), %rdx
      	leaq   -80(%rbp), %rax
      	movq   %rdx, %rsi
      	movq   %rax, %rdi
      	call   concatenar
 	movq   %rax, %rsi
      	movl   $.LC2, %edi
 	movl   $0, %eax
 	call   printf
 	movl   $.LC3, %edi
 	call   system
 	movl   $0, %eax
 			.L7:
      	movq   -8(%rbp), %rcx
      	xorq   %fs:40, %rcx
 	je 	.L8
      	call   __stack_chk_fail
 			.L8:
      	leave
         	      	.cfi_def_cfa 7, 8
      	ret
         	      	.cfi_endproc
         		.LFE0:
         	      	.globl concatenar
         		concatenar:
         		.LFB1:
         	      	.cfi_startproc
      	pushq  %rbp
         	      	.cfi_def_cfa_offset 16
         	      	.cfi_offset 6, -16
      	movq   %rsp, %rbp
         	      	.cfi_def_cfa_register 6
      	movq   %rdi, -24(%rbp)
      	488975E0        	movq   %rsi, -32(%rbp)
      	movl   $0, -8(%rbp)

      	jmp	.L10
         		.L11:
      	addl   $1, -8(%rbp)
         		.L10:
      	movl   -8(%rbp), %eax
      	movslq %eax, %rdx
      	movq   -24(%rbp), %rax
      	addq   %rdx, %rax
      	movzbl (%rax), %eax
      	testb  %al, %al
      	jne	.L11
      	movl   $0, -4(%rbp)
 	jmp	.L12
         		.L13:
      	addl   $1, -8(%rbp)
      	addl   $1, -4(%rbp)
         		.L12:
      	-8(%rbp), %eax
      	%eax, %rdx
      	-24(%rbp), %rax
      	addq   %rdx, %rax
      	movl   -4(%rbp), %edx
      	movslq %edx, %rcx
      	movq   -32(%rbp), %rdx
      	addq   %rcx, %rdx
      	movzbl (%rdx), %edx
      	movb   %dl, (%rax)
      	movzbl (%rax), %eax
      	testb  %al, %al
      	jne	.L13
      	movq   -24(%rbp), %rax
      	popq   %rbp
         	      	.cfi_def_cfa 7, 8
      	ret
         	      	.cfi_endproc
         		.LFE1:
         		.Letext0:
