[bits 16]

switch_to_pm:
cli ; switch of interrupts
lgdt [gdt_descriptor]

mov eax, cr0 ; control register
or eax, 0x1
mov cr0, eax

jmp CODE_SEG:init_pm

[bits 32]
init_pm:
; initialize all the registers in protected mode
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov esp, stack_top    ; stack pointer - find out how this number came

    call BEGIN_PM
