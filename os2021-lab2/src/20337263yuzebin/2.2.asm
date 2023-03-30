org 0x7c00
[bits 16]
xor ax, ax ; eax = 0
; 初始化段寄存器, 段地址全部设为0
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

; 初始化栈指针
mov sp, 0x7c00
mov ax, 0xb800
mov gs, ax


mov dh,1
mov dl,1
mov bh,0
mov ah,02h
int 10h;设置光标位置为1 1

mov al,'2'
mov bh,0
mov cx,1
mov bl,11111100b;底色和字体色
mov ah,09h
int 10h

mov ah,02h
add dl,1
int 10h
mov ah,09h
mov al,'0'
int 10h;光标位置+1，输出下一位学号

mov ah,02h
add dl,1
int 10h
mov ah,09h
mov al,'3'
int 10h

mov ah,02h
add dl,1
int 10h
mov ah,09h
mov al,'3'
int 10h

mov ah,02h
add dl,1
int 10h
mov ah,09h
mov al,'7'
int 10h

mov ah,02h
add dl,1
int 10h
mov ah,09h
mov al,'2'
int 10h

mov ah,02h
add dl,1
int 10h
mov ah,09h
mov al,'6'
int 10h

mov ah,02h
add dl,1
int 10h
mov ah,09h
mov al,'3'
int 10h

times 510 - ($ - $$) db 0
db 0x55, 0xaa
