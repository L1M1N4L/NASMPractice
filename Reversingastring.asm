section .data
    ; Define the input string
    input db 'Hello, World!', 0  ; Null-terminated string
    input_len equ $ - input      ; Length of the string excluding the null terminator

section .bss
    ; Reserve space for the reversed string including the null terminator
    reversed resb input_len + 1  ; Reserve space for reversed string plus null terminator

section .text
    global _start

_start:
    ; Initialize registers
    mov rsi, input              ; RSI points to the start of the input string
    mov rdi, reversed           ; RDI points to the start of the reversed string
    mov rax, input_len          ; RAX holds the length of the string excluding the null terminator
    add rsi, rax                ; Move RSI to the end of the input string
    dec rsi                     ; Adjust for the null terminator
    mov rcx, rax                ; RCX will count the number of characters

reverse_loop:
    mov al, [rsi]               ; Load the current character from the end of the input string
    mov [rdi], al               ; Store the character in the reversed string
    dec rsi                     ; Move the input string pointer backwards
    inc rdi                     ; Move the reversed string pointer forwards
    loop reverse_loop           ; Repeat until all characters are processed

    ; Add null terminator to the end of the reversed string
    mov byte [rdi], 0           ; Null-terminate the reversed string

    ; Print the reversed string
    mov rax, 1                  ; SYS_write system call number
    mov rdi, 1                  ; File descriptor 1 (stdout)
    mov rsi, reversed           ; Pointer to the reversed string
    mov rdx, input_len + 1      ; Length of the reversed string including null terminator
    syscall                     ; Call kernel

    ; Exit the program
    mov rax, 60                 ; SYS_exit system call number
    xor edi, edi                ; Exit code 0
    syscall                     ; Call kernel
