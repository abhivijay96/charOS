[org 0x7e00] ; this is from second sector

section .text

mov bp, 0x9000  ; set stack
mov sp, bp

mov bx, IN_REAL_MODE_MESSAGE
call print_16

call switch_to_pm   ; this function call never returns
jmp $

%include "./utilities/print_16.asm"
%include "./utilities/hex_print.asm"
%include "./utilities/disk_load.asm"
%include "./utilities/print_32.asm"
%include "gdt.asm"
%include "gdt64.asm"
%include "switch_to_pm.asm"
%include "./utilities/error.asm"
%include "./utilities/check_64.asm"
%include "paging.asm"
%include "init64.asm"

[bits 32]
BEGIN_PM:
; Move to 64 bit and then call KERNEL_OFFSET
    ; call check_multiboot    ; disable this if you are testing in qemu
    call check_cpuid
    call check_long_mode

    mov ebx, CHANGING_TO_64_BIT
    call print_32

    call setup_page_tables
    call enable_paging

    lgdt [gdt64.pointer]
    jmp gdt64.code:start_os_64
    

; These are declared to be global
IN_PROT_MODE_MESSAGE db "This is in protected mode now", 0
IN_REAL_MODE_MESSAGE db "This is in real mode now", 0
CHANGING_TO_64_BIT db "Xhanged from 32 bit to 64 bit! Boot is now complete ...", 0
LOADING_C_KERNEL db "Loading C kernel into memory at 0x8001", 0

times 1024 - ($-$$) db 0

%include "bss.asm"

; https://pdos.csail.mit.edu/6.828/2005/readings/i386/s05_01.htm