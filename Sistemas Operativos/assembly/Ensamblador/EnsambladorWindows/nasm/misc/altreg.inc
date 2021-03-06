;;
;; altreg.inc
;;
;; Alternate register names for 64-bit mode
;;

;;
;; Intel documents R8L-R15L instead of R8B-R15B
;; (Warning: this may confuse people with an AT&T-style assembly
;; background, where "r8l" means R8D, etc.)
;;
%idefine r8l  r8b
%idefine r9l  r9b
%idefine r10l r10b
%idefine r11l r11b
%idefine r12l r12b
%idefine r13l r13b
%idefine r14l r14b
%idefine r15l r15b

;;
;; Numeric register names for the lower 8 registers
;;
%idefine r0  rax
%idefine r1  rcx
%idefine r2  rdx
%idefine r3  rbx
%idefine r4  rsp
%idefine r5  rbp
%idefine r6  rsi
%idefine r7  rdi

%idefine r0d eax
%idefine r1d ecx
%idefine r2d edx
%idefine r3d ebx
%idefine r4d esp
%idefine r5d ebp
%idefine r6d esi
%idefine r7d edi

%idefine r0w ax
%idefine r1w cx
%idefine r2w dx
%idefine r3w bx
%idefine r4w sp
%idefine r5w bp
%idefine r6w si
%idefine r7w di

%idefine r0b al
%idefine r1b cl
%idefine r2b dl
%idefine r3b bl
%idefine r4b spl
%idefine r5b bpl
%idefine r6b sil
%idefine r7b dil

%idefine r0l al
%idefine r1l cl
%idefine r2l dl
%idefine r3l bl
%idefine r4l spl
%idefine r5l bpl
%idefine r6l sil
%idefine r7l dil

%idefine r0h ah
%idefine r1h ch
%idefine r2h dh
%idefine r3h bh
