gdt_start:

;; each descriptor is 8 bytes (64 bits)
; each word is 16 bits,
; follows flat segment hierarchy

gdt_null: ; mandatory null descriptor
    dd 0x0
    dd 0x0

gdt_code:
    dw 0xffff   ; limit
    dw 0x0      ; base 16 bits
    db 0x0      ; base 8 bits
    db 10011010b
    db 11001111b
    db 0x0      ; base 8 bits

gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b ; only this is different from the previous, this marks the segment as not code
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

;; calculating address offsets to use later
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
