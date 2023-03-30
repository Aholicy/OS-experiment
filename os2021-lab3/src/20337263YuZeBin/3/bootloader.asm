%include "boot.inc"
;org 0x7e00
[bits 16]

mov ax, 0xb800
mov gs, ax
mov ah, 0x03 ;青色
mov ecx, bootloader_tag_end - bootloader_tag
xor ebx, ebx
mov esi, bootloader_tag
;output_bootloader_tag:
;    mov al, [esi]
 ;   mov word[gs:bx], ax
 ;   inc esi
 ;   add ebx,2
 ;   loop output_bootloader_tag

;空描述符
mov dword [GDT_START_ADDRESS+0x00],0x00
mov dword [GDT_START_ADDRESS+0x04],0x00  

;创建描述符，这是一个数据段，对应0~4GB的线性地址空间
mov dword [GDT_START_ADDRESS+0x08],0x0000ffff    ; 基地址为0，段界限为0xFFFFF
mov dword [GDT_START_ADDRESS+0x0c],0x00cf9200    ; 粒度为4KB，存储器段描述符 

;建立保护模式下的堆栈段描述符      
mov dword [GDT_START_ADDRESS+0x10],0x00000000    ; 基地址为0x00000000，界限0x0 
mov dword [GDT_START_ADDRESS+0x14],0x00409600    ; 粒度为1个字节

;建立保护模式下的显存描述符   
mov dword [GDT_START_ADDRESS+0x18],0x80007fff    ; 基地址为0x000B8000，界限0x07FFF 
mov dword [GDT_START_ADDRESS+0x1c],0x0040920b    ; 粒度为字节

;创建保护模式下平坦模式代码段描述符
mov dword [GDT_START_ADDRESS+0x20],0x0000ffff    ; 基地址为0，段界限为0xFFFFF
mov dword [GDT_START_ADDRESS+0x24],0x00cf9800    ; 粒度为4kb，代码段描述符 

;初始化描述符表寄存器GDTR
mov word [pgdt], 39      ;描述符表的界限   
lgdt [pgdt]


      
in al,0x92                         ;南桥芯片内的端口 
or al,0000_0010B
out 0x92,al                        ;打开A20



cli                                ;中断机制尚未工作
mov eax,cr0
or eax,1
mov cr0,eax                        ;设置PE位


      
;以下进入保护模式
jmp dword CODE_SELECTOR:protect_mode_begin

;16位的描述符选择子：32位偏移
;清流水线并串行化处理器
[bits 32]           
protect_mode_begin:                              

mov eax, DATA_SELECTOR                     ;加载数据段(0..4GB)选择子
mov ds, eax
mov es, eax
mov eax, STACK_SELECTOR
mov ss, eax
mov eax, VIDEO_SELECTOR
mov gs, eax



;mov ecx, protect_mode_tag_end - protect_mode_tag
;mov ebx, 80 * 2
;mov esi, protect_mode_tag
;mov ah, 0x3
;output_protect_mode_tag:
    ;mov al, [esi]
    ;mov word[gs:ebx], ax
    ;add ebx, 2
    ;inc esi
    ;loop output_protect_mode_tag

mov ah,0x00
mov al,' '
clear:
	mov [gs:ebx],ax	
	add ebx,2
	cmp ebx,1920
jne clear

mov ecx, xuehao_end - xuehao
mov ebx, 60
mov esi, xuehao
init_title:
    mov ah, 0x3
    mov al, [esi]
    mov word[gs:bx], ax
    inc esi
    add ebx,2
    loop init_title
    
mov bl,2;y
mov bh,0;x
mov di,1;right 
mov si,1;down
mov ah,1

mov dl,'0'
print:
	push ebx
	push ecx
	mov ecx,0
	;mov bl,bl
	mov cl,bh
	mov bh,0
	imul ebx,ebx,80	;[gs:80*x+y](x,y)	
	add ebx,ecx
	imul ebx,ebx,2
	;add dl,48
	mov al,dl
	;sub dl,48
	mov word[gs:ebx],ax
	call find_duichen
print_duichen:
	;add dl,48        	
	mov al,dl
	;sub dl,48
	mov word[gs:ebx],ax        
	call find_duichen	
	pop ecx
	pop ebx
num_change:	
	cmp dl,'9'
	je num_reset
	inc dl
	jmp down
num_reset:
	mov dl,'0' 	

down:	    	
        cmp di,0
        jl up
        add bl,1
        cmp bl,25
        jl right
        sub bl,1
	;到达边界，保证边界最高的只有一个顶点，下一个点-1
        neg di
up:
        sub bl,1
        cmp bl,0
        jg right
        neg di
right:
        cmp si,0
        jl left
        add bh,1
        cmp bh,80
        jl color
        neg si
left:
        sub bh,1
        cmp bh,0
        jg color
        neg si
        
color:
	add ah,12h
	cmp ah,90h
	jne delay1
color_reset:
        mov ah,1
	jmp delay1

delay1:
   	push eax
   	mov eax,0
delay2:
	add eax,1
	cmp eax,80000000
	jl delay2
   	pop eax
jmp print

jmp $ ; 死循环


find_duichen:
	sub ebx,160*25-2
	neg ebx
	ret


pgdt dw 0
     dd GDT_START_ADDRESS


xuehao db '20337263yuzebin'
xuehao_end:

bootloader_tag db 'run bootloader'
bootloader_tag_end:

protect_mode_tag db 'enter protect mode'
protect_mode_tag_end:
