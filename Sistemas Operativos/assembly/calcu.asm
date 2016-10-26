.Ltext0:
             .section  .rodata
             .LC0:
      	.string  	"ingrese el primer numero"

         		.LC1:
      	.string  	"%lf"
         		.LC2:
      	.string  	"ingrese el segundo numero"

         		.LC3:
      	.string  	" %lf + %lf es %lf\n\n\n"
         	      	.text
         	      	.globl suma
         		suma:
         		.LFB0:
         	      	.cfi_startproc
   	      	pushq  %rbp
         	      	.cfi_def_cfa_offset 16
         	      	.cfi_offset 6, -16
      	movq   %rsp, %rbp
         	      	.cfi_def_cfa_register 6
      	subq   $32, %rsp
      	movl   $.LC0, %edi

      	call   puts

      	leaq   -16(%rbp), %rax
      	movq   %rax, %rsi
      	movl   $.LC1, %edi

      	movl   $0, %eax

      	call   __isoc99_scanf

      	movl   $.LC2, %edi

      	call   puts

      	leaq   -8(%rbp), %rax
      	movq   %rax, %rsi
      	movl   $.LC1, %edi

      	movl   $0, %eax

      	call   __isoc99_scanf

      	movsd  -16(%rbp), %xmm1

      	movsd  -8(%rbp), %xmm0

      	addsd  %xmm1, %xmm0
      	movq   -8(%rbp), %rdx
      	movq   -16(%rbp), %rax
      	movapd %xmm0, %xmm2
      	movq   %rdx, -24(%rbp)
      	movsd  -24(%rbp), %xmm1

      	movq   %rax, -24(%rbp)
      	movsd  -24(%rbp), %xmm0

      	movl   $.LC3, %edi

      	movl   $3, %eax

      	call   printf

 	        	leave
         	      	.cfi_def_cfa 7, 8
   	      	ret
         	      	.cfi_endproc
         		.LFE0:
         	      	.section 	.rodata
         		.LC4:
      	.string  	" %lf - %lf es %lf\n\n\n"

         	      	.text
         	      	.globl resta
         		resta:
         		.LFB1:
         	      	.cfi_startproc
   	      	pushq  %rbp
	               	.cfi_def_cfa_offset 16
         	      	.cfi_offset 6, -16
      	movq   %rsp, %rbp
        	       	.cfi_def_cfa_register 6
      	subq   $32, %rsp
      	movl   $.LC0, %edi

      	call   puts

      	leaq   -16(%rbp), %rax
      	movq   %rax, %rsi
      	movl   $.LC1, %edi

      	movl   $0, %eax

      	call   __isoc99_scanf

      	movl   $.LC2, %edi

      	call   puts

      	leaq   -8(%rbp), %rax
      	movq   %rax, %rsi
      	movl   $.LC1, %edi

      	movl   $0, %eax

      	call   __isoc99_scanf

      	movsd  -16(%rbp), %xmm0

      	movsd  -8(%rbp), %xmm1

      	subsd  %xmm1, %xmm0
      	movq   -8(%rbp), %rdx
      	movq   -16(%rbp), %rax
      	movapd %xmm0, %xmm2
      	movq   %rdx, -24(%rbp)
      	movsd  -24(%rbp), %xmm1

      	movq   %rax, -24(%rbp)
      	movsd  -24(%rbp), %xmm0

      	movl   $.LC4, %edi
      	movl   $3, %eax

      	call   printf

  	       	leave
        	       	.cfi_def_cfa 7, 8
  	       	ret
         	      	.cfi_endproc
         		.LFE1:
         	      	.section 	.rodata
         		.LC5:
      	.string  	" %lf x %lf es %lf\n\n\n"


         	      	.text
         	      	.globl multiplicacion
         		multiplicacion:
         		.LFB2:
         	      	.cfi_startproc
  	       	pushq  %rbp
        	       	.cfi_def_cfa_offset 16
         	      	.cfi_offset 6, -16
      	movq   %rsp, %rbp
         	      	.cfi_def_cfa_register 6
      	subq   $32, %rsp
      	movl   $.LC0, %edi
call  	puts

      	leaq   -16(%rbp), %rax
      	movq   %rax, %rsi
      	movl   $.LC1, %edi

      	movl   $0, %eax

      	call   __isoc99_scanf

      	movl   $.LC2, %edi

      	call   puts
      	leaq   -8(%rbp), %rax
      	movq   %rax, %rsi
      	movl   $.LC1, %edi

      	movl   $0, %eax

      	call   __isoc99_scanf
      	movsd  -16(%rbp), %xmm1
      	movsd  -8(%rbp), %xmm0

      	mulsd  %xmm1, %xmm0
      	movq   -8(%rbp), %rdx
      	movq   -16(%rbp), %rax
      	movapd %xmm0, %xmm2
      	movq   %rdx, -24(%rbp)
      	movsd  -24(%rbp), %xmm1

      	movq   %rax, -24(%rbp)
      	movsd  -24(%rbp), %xmm0

      	movl   $.LC5, %edi
 	        	movl   $3, %eax

      	call   printf
	         	leave
         	      	.cfi_def_cfa 7, 8
   	      	ret
         	      	.cfi_endproc
         		.LFE2:
         	      	.section 	.rodata
 	        	.align 8
         		.LC6:
      	.string  	"ingrese el segundo numero(diferente de cero)"
         		.LC8:
      	.string  	" %lf / %lf es %lf\n\n\n"
         	      	.text
         	      	.globl division
         		division:
         		.LFB3:
         	      	.cfi_startproc
   	      	pushq  %rbp
         	      	.cfi_def_cfa_offset 16
         	      	.cfi_offset 6, -16
      	movq   %rsp, %rbp
         	      	.cfi_def_cfa_register 6
      	subq   $32, %rsp
      	movl   $.LC0, %edi

      	call   puts

      	leaq   -16(%rbp), %rax
      	movq   %rax, %rsi
      	movl   $.LC1, %edi

      	movl   $0, %eax

      	call   __isoc99_scanf

         		.L5:
      	movl   $.LC6, %edi

      	call   puts

      	leaq   -8(%rbp), %rax
      	movq   %rax, %rsi
      	movl   $.LC1, %edi

      	movl   $0, %eax

      	call   __isoc99_scanf

      	movsd  -8(%rbp), %xmm0

      	xorpd  %xmm1, %xmm1
      	ucomisd  	%xmm1, %xmm0
	         	jp 	.L7
      	xorpd  %xmm1, %xmm1
      	ucomisd  	%xmm1, %xmm0
      	je 	.L5
         		.L7:
      	movsd  -16(%rbp), %xmm0

      	movsd  -8(%rbp), %xmm1

      	divsd  %xmm1, %xmm0
      	movq   -8(%rbp), %rdx
      	movq   -16(%rbp), %rax
      	movapd %xmm0, %xmm2
      	movq   %rdx, -24(%rbp)
      	movsd  -24(%rbp), %xmm1

      	movq   %rax, -24(%rbp)
      	movsd  -24(%rbp), %xmm0

      	movl   $.LC8, %edi

      	movl   $3, %eax

      	call   printf

   	      	leave
         	      	.cfi_def_cfa 7, 8
  	       	ret
         	      	.cfi_endproc
         		.LFE3:
         	      	.section 	.rodata
         		.LC9:
      	.string  	"CALCULADORA\n1 suma\n2 resta"

      	.align 8
         		.LC10:
      	.string  	"3 multiplicacion\n4 division\n5 finalizar"
         		.LC11:
      	.string  	"elige una opcion"
         		.LC12:
      	.string  	"%d"
         		.LC13:
      	.string  	"opcion incorrecta\n\n"
         	      	.text
         	      	.globl main
         		main:
         		.LFB4:
         	      	.cfi_startproc
   	      	pushq  %rbp
         	      	.cfi_def_cfa_offset 16
         	      	.cfi_offset 6, -16
      	movq   %rsp, %rbp
         	      	.cfi_def_cfa_register 6
      	subq   $16, %rsp
         		.L17:
      	movl   $.LC9, %edi

      	call   puts

      	movl   $.LC10, %edi

      	call   puts

      	movl   $.LC11, %edi

      	call   puts

      	leaq   -4(%rbp), %rax
      	movq   %rax, %rsi
      	movl   $.LC12, %edi

      	movl   $0, %eax
      	call   __isoc99_scanf

      	movl   -4(%rbp), %eax
      	cmpl   $5, %eax
 	        	ja 	.L9
 	        	movl   %eax, %eax
      	movq   .L11(,%rax,8), %rax

 	        	jmp	*%rax
         	      	.section 	.rodata
         	      	.align 8
         	      	.align 4
         		.L11:
      	.quad  .L9

      	.quad  .L10

      	.quad  .L12

      	.quad  .L13

      	.quad  .L14

      	.quad  .L19

         	      	.text
         		.L10:
      	movl   $0, %eax

      	call   suma

	         	jmp	.L16
        	 	.L12:
      	movl   $0, %eax

      	call   resta

 	        	jmp	.L16
        	 	.L13:
      	movl   $0, %eax

      	call   multiplicacion

 	        	jmp	.L16
         		.L14:
      	movl   $0, %eax

      	call   division

      	jmp	.L16
         		.L9:
      	movl   $.LC13, %edi

      	call   puts

 	        	jmp	.L16
         		.L19:
 	        	nop
         		.L16:
      	movl   -4(%rbp), %eax
      	cmpl   $5, %eax
      	jne	.L17

      	movl   $0, %eax

	         	leave
         	      	.cfi_def_cfa 7, 8
 	        	ret
         	      	.cfi_endproc
         		.LFE4:
         		.Letext0:
