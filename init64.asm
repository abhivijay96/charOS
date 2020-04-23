start_os_64:
mov ax, 0
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

call 0x8200 ; Calls C kernel
jmp $