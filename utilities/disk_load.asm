[bits 16]

disk_load:
push dx ; use this to return the number of sectors read

mov ah, 0x02    ; BIOS read disk option
mov al, dh      ; Number of sectors to read, passed in dh by the caller
mov ch, 0x00    ; 1st cyclinder (index 0)
mov dh, 0x00    ; 1st head (index 0)
mov cl, 0x02    ; Read from 2nd sector
int 0x13

jc disk_error   ; if carry bit is set, something went wrong, move to disk error

pop dx          ; restore dx
cmp al, dh      ; compare sectors read (ax) with sectors to be read (dh)
jne disk_error ; disk error again if this is true (ax != dh)

; print success message after reading disk
mov bx, DISK_SUCCESS_MESSAGE
call print_16

ret             ; return

disk_error:
mov bx, DISK_ERROR_MESSAGE
call print_16
jmp $

DISK_ERROR_MESSAGE db "Bios could not read from disk", 0
DISK_SUCCESS_MESSAGE db "Disk loaded", 0