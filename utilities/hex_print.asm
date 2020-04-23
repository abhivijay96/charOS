[bits 16]

print_hex:
pusha
mov dx, HEX_MESSAGE
add dx, 5
mov [edx], cl
hex_loop:
cmp bx, 0
je return_hex
mov cx, bx
and cx, 0x000f
shr bx, 4
cmp cx, 10
jl  num_hex
sub cl, 10
add cl, 0x61
jmp done_convert
num_hex:
add cx, 0x30
done_convert:
; mov al, cl
; int 0x10
mov [edx], cl
sub dx, 1
jmp hex_loop
return_hex:
mov bx, HEX_MESSAGE
call print_16
popa
ret

HEX_MESSAGE:
    db "0x0000", 0