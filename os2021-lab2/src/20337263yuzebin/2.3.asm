org 0x7c00
[bits 16]

do:
	mov ah,0h
	int 16h
	mov ah,0eh
	int 10h;

loop do
times 510 - ($ - $$) db 0
db 0x55, 0xaa
