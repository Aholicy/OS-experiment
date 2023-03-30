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
mov ax, 1                ; 逻辑扇区号第0~15位
mov cx, 0                ; 逻辑扇区号第16~31位
mov bx, 0x7e00           ; bootloader的加载地址
load_bootloader:
    call asm_read_hard_disk  ; 读取硬盘
    inc ax
    cmp ax, 5
    jle load_bootloader
jmp 0x0000:0x7e00        ; 跳转到bootloader

jmp $ ; 死循环
;绝对扇区=(逻辑扇区 mod 每个柱面的总扇区数) +1
;绝对磁头=(逻辑扇区/每个柱面的总扇区数) mod 总磁头数
;绝对柱面= 逻辑扇区/(每个柱面的总扇区数 * 总磁头数)
; C = x/(18 * 63) 
; H = x/63 % 18 
; S = x % 63 + 1 
asm_read_hard_disk:                           
; 从硬盘读取一个逻辑扇区
	push ax
	mov al, 1
    	mov ch, 0
    	mov dh, 0
    	mov cl, 2
    	mov dl, 80h
    	mov ah, 02h
    	int 13h
    	pop ax
	ret
times 510 - ($ - $$) db 0
db 0x55, 0xaa
