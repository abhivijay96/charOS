; CPU uses 4 level paging (5 in very recent CPUs) in long mode also known as 64 bit mode
; It starts by getting the address of the P4 table from the CR3 register
; each page is 4096 bytes, it has 512 entries which are 8 bytes (64 bits) each

; setting up identity page table 
; virtual and physical address are the same
; this is done using the huge page bit in the address (8th bit) - here 512 pages of 2 MiB sizes are used
; Reference: https://os.phil-opp.com/entering-longmode/

; First 1GB of memory being identically mapped using this
; all pages will be marked present because it is identically mapped

setup_page_tables:

mov eax, p3_table
or eax, 0b11    ; makes this page present and writeable
mov [p4_table], eax

mov eax, p2_table
or eax, 0b11
mov [p3_table], eax

mov ecx, 0

.set_p2_table:
    mov eax, 0x200000       ; 2MiB
    mul ecx
    or  eax, 0b10000011    ; huge, writeable and present
    mov [p2_table + ecx * 8], eax 
    inc ecx
    cmp ecx, 512
    jne .set_p2_table

ret

; Enable paging
; write address of page table 4 to CR3 register
enable_paging:
; load P4 to cr3 register (cpu uses this to access the P4 table)
mov eax, p4_table
mov cr3, eax

; enable PAE-flag in cr4 (Physical Address Extension)
mov eax, cr4
or eax, 1 << 5
mov cr4, eax

; set the long mode bit in the EFER MSR (model specific register)
mov ecx, 0xC0000080
rdmsr
or eax, 1 << 8
wrmsr

; enable paging in the cr0 register
mov eax, cr0
or eax, 1 << 31
mov cr0, eax

ret