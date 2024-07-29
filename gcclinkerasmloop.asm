section .data
    format db "%d x %d = %d", 10, 0  ; Format string for output

section .bss
    multiplier resd 1                ; Reserve space for multiplier
    i resd 1                          ; Reserve space for loop counter

section .text
    extern printf                     ; Import printf function
    extern scanf                      ; Import scanf function
    global _start                     ; Entry point for the program

_start:
    ; Read input
    mov rdi, format                  ; Address of format string for scanf
    mov rsi, multiplier              ; Address of multiplier
    call scanf                       ; Call scanf
    ; Clean up stack (no need in x86-64, but for completeness)
    
    ; Loop from 1 to 10
    mov dword [i], 1                 ; Initialize i to 1

.loop:
    cmp dword [i], 10                ; Compare i with 10
    jg .end_loop                      ; If i > 10, exit loop

    ; Calculate i * multiplier
    mov eax, [i]                     ; Load i into eax
    imul eax, [multiplier]           ; Multiply eax by multiplier
    mov rdx, rax                     ; Move result into rdx (first argument for printf)
    mov rsi, [i]                     ; Move i into rsi (second argument for printf)
    mov rdi, [multiplier]            ; Move multiplier into rdi (third argument for printf)
    mov rax, 1                       ; Number of floating-point arguments (none here)
    call printf                      ; Call printf
    ; Clean up stack (no need in x86-64)

    ; Increment i
    inc dword [i]                    ; i++
    jmp .loop                        ; Repeat the loop

.end_loop:
    ; Exit the program
    mov rax, 60                      ; SYS_exit system call number
    xor rdi, rdi                     ; Exit code 0
    syscall
