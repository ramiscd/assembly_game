section .data
    prompt db 'Adivinha um numero de 1 a 10: ', 0
    msg_too_low db 'Muito baixo! Tente novamente.', 10, 0
    msg_too_high db 'Muito alto! Tente novamente.', 10, 0
    msg_correct db 'Parabens! Voce acertou o numero.', 10, 0
    number db '1', 0  ; O número correto a ser adivinhado

section .bss
    input resb 1  ; Reservando espaço para a entrada do usuário

section .text
    global _start

_start:
    ; Exibir a mensagem pedindo para o usuário adivinhar o número
    mov rax, 0x2000004   ; Syscall para 'write'
    mov rdi, 1           ; File descriptor (1 = stdout)
    mov rsi, prompt      ; Endereço da string
    mov rdx, 26          ; Tamanho da string
    syscall

    ; Ler a entrada do usuário
    mov rax, 0x2000003   ; Syscall para 'read'
    mov rdi, 0           ; File descriptor (0 = stdin)
    lea rsi, [input]     ; Endereço onde armazenar a entrada
    mov rdx, 1           ; Ler 1 byte
    syscall

    ; Comparar a entrada com o número correto
    mov al, [input]      ; Carregar o valor digitado
    sub al, '0'          ; Converter de ASCII para valor numérico
    mov bl, [number]     ; Carregar o número correto
    sub bl, '0'          ; Converter de ASCII para valor numérico

    ; Verificar se o palpite é muito baixo
    cmp al, bl
    jl too_low

    ; Verificar se o palpite é muito alto
    cmp al, bl
    jg too_high

    ; Se o palpite for correto
    mov rax, 0x2000004   ; Syscall para 'write'
    mov rdi, 1           ; File descriptor (1 = stdout)
    mov rsi, msg_correct ; Endereço da string
    mov rdx, 30          ; Tamanho da string
    syscall
    jmp end_game         ; Ir para o final

too_low:
    mov rax, 0x2000004   ; Syscall para 'write'
    mov rdi, 1           ; File descriptor (1 = stdout)
    mov rsi, msg_too_low ; Endereço da string
    mov rdx, 31          ; Tamanho da string
    syscall
    jmp _start           ; Voltar ao começo para o usuário tentar novamente

too_high:
    mov rax, 0x2000004   ; Syscall para 'write'
    mov rdi, 1           ; File descriptor (1 = stdout)
    mov rsi, msg_too_high ; Endereço da string
    mov rdx, 33          ; Tamanho da string
    syscall
    jmp _start           ; Voltar ao começo para o usuário tentar novamente

end_game:
    ; Finalizar o programa
    mov rax, 0x2000001   ; Syscall para 'exit'
    xor rdi, rdi         ; Código de saída 0
    syscall
