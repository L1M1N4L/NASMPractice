; 64-bit x86 Assembly Fibonacci Sequence Generator

section .data
    fibonacci_msg db "Fibonacci Sequence: ", 0  ; Message to print before the sequence
    number_fmt db "%d ", 0                      ; Format for each number (not used in this version)
    newline db 10, 0                            ; Newline character

section .bss
    number resb 21  ; Buffer to hold the string representation of a number (max 20 digits + null terminator)

section .text
    global _start

_start:
    ; Print the initial message
    mov rax, 1          ; System call number for write
    mov rdi, 1          ; File descriptor 1 is stdout
    mov rsi, fibonacci_msg  ; Address of the message to write
    mov rdx, 20         ; Number of bytes to write
    syscall             ; Invoke operating system to do the write

    ; Initialize Fibonacci sequence
    xor r12, r12        ; First number (0)
    mov r13, 1          ; Second number (1)
    mov r14, 10         ; Counter for 10 numbers

    ; Print first two numbers
    call print_number   ; Print 0
    mov r12, r13        ; Move 1 to r12
    call print_number   ; Print 1

    ; Generate and print the rest of the sequence
fibonacci_loop:
    mov rax, r12        ; Move the second-last number to rax
    add rax, r13        ; Add the last number to get the new Fibonacci number
    mov r12, r13        ; Move the last number to second-last position
    mov r13, rax        ; Move the new number to last position

    call print_number   ; Print the new Fibonacci number

    dec r14             ; Decrement the counter
    jnz fibonacci_loop  ; If counter is not zero, continue the loop

    ; Print newline
    mov rax, 1          ; System call number for write
    mov rdi, 1          ; File descriptor 1 is stdout
    mov rsi, newline    ; Address of the newline character
    mov rdx, 1          ; Number of bytes to write
    syscall             ; Invoke operating system to do the write

    ; Exit program
    mov rax, 60         ; System call number for exit
    xor rdi, rdi        ; Exit code 0
    syscall             ; Invoke operating system to exit

print_number:
    ; Convert number to string
    mov rax, r12        ; Move the number to print into rax
    mov rdi, number     ; Point rdi to the start of our number buffer
    call int_to_string  ; Convert the integer to a string

    ; Print the number
    mov rax, 1          ; System call number for write
    mov rdi, 1          ; File descriptor 1 is stdout
    mov rsi, number     ; Address of the number string to write
    mov rdx, 21         ; Maximum number of bytes to write
    syscall             ; Invoke operating system to do the write

    ret                 ; Return from the subroutine

int_to_string:
    add rdi, 20         ; Point to the end of the buffer
    mov byte [rdi], 0   ; Null-terminate the string
    mov rcx, 10         ; Divisor for base 10

.loop:
    xor rdx, rdx        ; Clear upper 64 bits of dividend
    div rcx             ; Divide rax by 10, quotient in rax, remainder in rdx
    add dl, '0'         ; Convert remainder to ASCII
    dec rdi             ; Move pointer back one position
    mov [rdi], dl       ; Store the ASCII digit
    test rax, rax       ; Check if quotient is zero
    jnz .loop           ; If not, continue loop

    ret                 ; Return from the subroutine