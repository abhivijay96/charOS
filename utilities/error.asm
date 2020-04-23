; this file prints error messages in 64 bit mode
; A screen character consists of a 8 bit color code and a 8 bit ASCII character
; 4f -> RED
; 52 -> R
; 45 -> E
; 3a -> ;
; 20 -> space
error:
    mov word [0xb8000], 0x4f45       ; E
    mov word [0xb8000 + 2], 0x4f52   ; R
    mov word [0xb8000 + 4], 0x4f52   ; R
    mov word [0xb8000 + 6], 0x4f3a   ; :
    mov word [0xb8000 + 8], 0x4f20   ; space
    mov byte [0xb8000 + 10], al      ; ERROR CODE
    hlt
