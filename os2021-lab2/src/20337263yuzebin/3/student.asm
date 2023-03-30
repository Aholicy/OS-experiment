; If you meet compile error, try 'sudo apt install gcc-multilib g++-multilib' first

%include "head.include"


your_if:
; put your implementation here
    	mov ax,word [a1]    ;将a1放入ax
	cmp ax,12           ;比较a1和12的大小
	jl L1
	
	cmp ax,24	     ;比较a1和24的大小
	jl L2
	
	shl ax, 4	     ;else
	mov word [if_flag], ax
	jmp your_while
	
L1:
	shr ax, 1
	add ax, 1
	mov word [if_flag], ax  ;将计算后的ax的值传给if_flag
	jmp your_while
L2:
	mov bx, ax
	neg bx 		;bx=-ax
	add bx,24		;bx=24-ax
	imul ax, bx
	mov word [if_flag], ax
	jmp your_while
your_while:
; put your implementation here
	mov ebx, dword [a2]    ;ebx=a2
	cmp ebx, 12
	jl pre_function	;!!
	
	push ebx	;?
	call my_random
	pop ebx
	
	mov ecx,[while_flag]
	sub ebx,12	;a2-12
	add ecx,ebx	;[while_flag]+a2-12
	mov [ecx], al;
	add ebx,11	;a2-1
	mov dword[a2], ebx
	loop your_while
	
pre_function:			
%include "end.include"		;一定要在your_function 外include，没有include有段错误，内include无最后的话

your_function:

; put your implementation here
	mov ebx, 0	;ebx=i
alldo:
	mov ecx,[your_string]
	add ecx,ebx
	mov al, [ecx]
	cmp al,0		;低位是字符，高位是属性
	je end
	
	pushad
	push ax
	call print_a_char
	pop ax
	popad
	add ebx, 1
	loop alldo
end:
	ret
