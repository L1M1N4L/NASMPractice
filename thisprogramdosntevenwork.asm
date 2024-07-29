section .data
    msg1 db "Welcome to the Ultimate Useless Assembly Program!", 10, 0
    msg2 db "Performing pointless calculations...", 10, 0
    msg3 db "Calculated useless result: ", 0
    msg4 db "Entering pointless loop...", 10, 0
    msg5 db "Current iteration: ", 0
    msg6 db "Shuffling meaningless data array...", 10, 0
    msg7 db "Printing shuffled data array:", 10, 0
    msg8 db "Entering another pointless loop...", 10, 0
    msg9 db "Final pointless iteration: ", 0
    msg10 db "Performing some extra pointless calculations...", 10, 0
    msg11 db "Program finished with no useful outcome.", 10, 0
    fmt db "%d", 10, 0
    array dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    extra dd 11, 12, 13, 14, 15

section .bss
    result resq 1
    extra_result resq 1

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    ; Print welcome message
    mov rdi, msg1
    call print_string

    ; Perform pointless calculations
    mov rdi, msg2
    call print_string

    mov rax, 1
    mov rcx, 5000000
.pointless_calculation_loop:
    imul rax, rcx
    add rax, rcx
    xor rax, rcx
    loop .pointless_calculation_loop

    mov [result], rax

    ; Print result
    mov rdi, msg3
    call print_string
    mov rdi, fmt
    mov rsi, [result]
    xor rax, rax
    call printf

    ; Enter pointless loop
    mov rdi, msg4
    call print_string

    mov rcx, 20
.pointless_outer_loop:
    push rcx

    mov rdi, msg5
    call print_string
    mov rdi, fmt
    mov rsi, rcx
    xor rax, rax
    call printf

    ; Inner pointless loop
    mov rax, 2000000
.inner_pointless_loop:
    dec rax
    jnz .inner_pointless_loop

    pop rcx
    loop .pointless_outer_loop

    ; Shuffle meaningless data
    mov rdi, msg6
    call print_string

    mov rcx, 20
.shuffle_loop:
    mov rax, 10
    call random
    mov rbx, 10
    call random
    
    mov edx, [array + rax * 4]
    xchg edx, [array + rbx * 4]
    mov [array + rax * 4], edx

    loop .shuffle_loop

    ; Print shuffled array
    mov rdi, msg7
    call print_string

    mov rcx, 10
.print_array:
    push rcx
    mov rdi, fmt
    mov esi, [array + rcx * 4 - 4]
    xor rax, rax
    call printf
    pop rcx
    loop .print_array

    ; Enter another pointless loop
    mov rdi, msg8
    call print_string

    mov rcx, 15
.another_pointless_loop:
    push rcx

    mov rdi, msg9
    call print_string
    mov rdi, fmt
    mov rsi, rcx
    xor rax, rax
    call printf

    ; Extra pointless inner loop
    mov rax, 500000
.extra_inner_loop:
    dec rax
    jnz .extra_inner_loop

    pop rcx
    loop .another_pointless_loop

    ; Perform extra pointless calculations
    mov rdi, msg10
    call print_string

    mov rax, 10
    mov rcx, 10000000
.extra_calculation_loop:
    imul rax, rcx
    add rax, rcx
    xor rax, rcx
    loop .extra_calculation_loop

    mov [extra_result], rax

    ; Print final result
    mov rdi, msg11
    call print_string
    mov rdi, fmt
    mov rsi, [extra_result]
    xor rax, rax
    call printf

    ; Exit program
    xor rax, rax
    leave
    ret

; Function to print a null-terminated string
print_string:
    push rdi
    call printf
    pop rdi
    ret

; Simple random number generator
; Returns a random number between 0 and rax-1 in rax
random:
    push rdx
    push rcx
    rdtsc
    xor rdx, rdx
    mov rcx, rax
    div rcx
    mov rax, rdx
    pop rcx
    pop rdx
    ret
