; taken from  https://os.phil-opp.com/entering-longmode/
gdt64:
    dq 0 ; zero entry
    .code: equ $ - gdt64
    dq (1<<43) | (1<<44) | (1<<47) | (1<<53) ; code segment
.pointer:
    dw $ - gdt64 - 1
    dq gdt64