; If you meet compile error, try 'sudo apt install gcc-multilib g++-multilib' first

%include "head.include"


your_if:
; put your implementation here
    mov ax,word [a1]    ;将a1放入ax
	
	cmp ax,12           ;比较a1和12的大小
	jl L1

L1:
	shr ax, 1
	add ax, 1
	mov word [if_flag], ax  ;将计算后的ax的值传给if_flag
your_while:
; put your implementation here

%include "end.include"

your_function:
; put your implementation here
