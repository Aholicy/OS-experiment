[bits 16]
;This ASM code is designed to help you understand interrupts
;By commenting out "int 10h",you will find something
;Simply run the code:
;nasm -f bin test1.asm -o test1.bin
;qemu-system-i386 test1.bin

mov ah, 02h
mov dh, 0x03
mov dl, 0x04
mov al, 'H'
int 10h


jmp $
times 510-($-$$) db 0
dw 0xaa55