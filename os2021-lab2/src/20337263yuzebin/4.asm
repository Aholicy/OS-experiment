org 0x7c00
[bits 16]
start:

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
	
	;初始化屏幕属性80*25，16色
	mov al,3h
	mov ah,0h
	int 10h
init_title:
	mov ax, Message       ;es:bp指向要显示的字符串
	mov bp, ax
	mov ah, 0x13          ;ah为0x13,调用13号中断
	mov al, 0             ;al为0,不移动光标，字符串中没有属性内容
	mov bh, 0                           
	mov bl, 0x24 
	mov cx, MessageLen  ;字符串长度
	mov dh, 0                             
	mov dl,33
	int 10h                               
   	;设置光标位置
	mov dh, 2  ;y
	mov dl, 0  ;x
	mov di, 1  ;right
	mov si, 1  ;down
	call gb_set

	mov al,'0' 
	mov bl,01h 
	mov bh,0
print:
	mov cx,1 
	call gb_write
	call find_duichen
		
print_duichen:
	call gb_set;设置对面的光标
	call gb_write
	call find_duichen
	
number:
	cmp al, '9'
	je num_reset
	add al,1
	jmp color
num_reset: 	
	mov al, '0'

color:
	cmp bl, 88
	jg color_reset
	add bl, 12h	
	jmp down
color_reset:
	mov bl, 01h
	
down:
	cmp si,0
	jl up
	add dh,1
	cmp dh,25
	jl right
	;到达边界，保证边界最高的只有一个顶点，下一个点-1
	sub dh,1
	neg si
	
up:	
	sub dh,1
	cmp dh,2
	jg right
	neg si
	
right:
	cmp di,0
	jl left
	add dl,1
	cmp dl,80
	jl nextstep
	
	sub dl,1
	neg di
	
left:
	sub dl,1
	cmp dl,0
	jg nextstep
	neg di
	
nextstep:
	call gb_set	

late:  
	pushad
	mov ah,86h
	mov cx,1h
	mov dx,1
	int 15h
	popad
	;延迟



jmp print
find_duichen:
	neg dh
	add dh,25;25-y
	neg dl
	add dl,80;80-x
	ret
gb_set:
	mov ah, 02h
	int 10h
	ret
gb_write:
	mov ah, 09h
	int 10h
	ret
next_title:	;这是一开始用来输出标题的手段，后来发现可以直接输出字符串
	mov ah,02h
	add dl,1
	int 10h
	mov ah,09h
	int 10h;光标位置+1，输出下一位学号
	ret	
jmp $
Message db "20337263Yuzebin"
MessageLen equ $ - Message
times 510 - ($ - $$) db 0
db 0x55, 0xaa
