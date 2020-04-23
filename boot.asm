[org 0x7c00]

mov [HARD_DRIVE_ID], dl

mov bp, 0x9000  ; set stack
mov sp, bp

; load the next 15 sectors form hard-disk after this boot sector to continue to the OS
mov bx, 0x7e00 ; this is where the next byte is after the first boot sector in RAM
mov dh, 15
mov dl, [HARD_DRIVE_ID]
call disk_load_boot

; everything succeeded, jump to second sector
call 0x7e00     ; this never returns

; the disk BIOS interrupt to read data
disk_load_boot:
push dx
mov ah, 0x02    ; BIOS read disk option
mov al, dh      ; Number of sectors to read, passed in dh by the caller
mov ch, 0x00    ; 1st cyclinder (index 0)
mov dh, 0x00    ; 1st head (index 0)
mov cl, 0x02    ; Read from 2nd sector
int 0x13

jc disk_error_fatal

pop dx          ; restore dx
cmp al, dh      ; compare sectors read (ax) with sectors to be read (dh)
jne disk_error_fatal
ret

disk_error_fatal:
hlt

HARD_DRIVE_ID db 0
times 510 - ($-$$) db 0
dw 0xaa55
