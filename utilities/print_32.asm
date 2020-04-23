[bits 32]
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; Ebx has character stream
print_32:
pusha
mov edx, VIDEO_MEMORY
p32_loop:
mov al, [ebx]
mov ah , WHITE_ON_BLACK
cmp al, 0
je return_print_32
mov [edx], ax
add ebx, 1 ; increment byte by byte in RAM
add edx, 2 ; Move to next character cell in vid mem
jmp p32_loop
return_print_32:
popa
ret