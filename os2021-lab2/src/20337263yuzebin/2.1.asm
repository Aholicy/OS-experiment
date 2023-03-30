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

mov ah,03h
mov bx,0
int 10h;获取光标位置

mov ah, 0x07 
mov al, 'x'
mov [gs:2 *(80*12+1) ], ax

add dh,48
mov ah, 0x07 
mov al, dh
mov [gs:2 *(80*12+2) ], ax;输出光标的x坐标

mov ah, 0x07
mov al, 'y'
mov [gs:2 *(80*12+3) ], ax

add dl,48
mov ah, 0x07
mov al, dl
mov [gs:2 *(80*12+4) ], ax;输出光标的y坐标

mov dh,1
mov dl,5
mov bh,0
mov ah,02h
int 10h;重新设置光标的位置为5 1

times 510 - ($ - $$) db 0
db 0x55, 0xaa
