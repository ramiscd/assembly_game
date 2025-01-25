section .data
    msg db "Hello, Assembly on macOS!", 0  ; Mensagem a ser exibida (terminada com 0)

section .text
    global _main                           ; Define o ponto de entrada como _main

_main:
    ; syscall write
    mov rax, 0x2000004                     ; Código do syscall write
    mov rdi, 1                             ; File descriptor (1 = stdout)
    lea rsi, [rel msg]                     ; Endereço da mensagem na memória
    mov rdx, 26                            ; Tamanho da mensagem
    syscall                                ; Faz a chamada de sistema

    ; syscall exit
    mov rax, 0x2000001                     ; Código do syscall exit
    xor rdi, rdi                           ; Código de saída (0)
    syscall                                ; Faz a chamada de sistema
