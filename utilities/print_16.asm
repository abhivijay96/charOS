[bits 16]

print_16:
pusha
mov ah, 0x0e
p_loop:
mov al, [bx]
cmp al, 0
je return_print
int 0x10
add bx, 1 ; increment byte by byte in RAM
jmp p_loop
return_print:
mov al, ' '
int 0x10
popa
ret