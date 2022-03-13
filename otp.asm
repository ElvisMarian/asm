%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY


    ;; TODO: Implement the One Time Pad cipher


    parcurge_sir:			;parcurg plaintext de la sfasit catre inceput
    mov al, [esi + ecx-1] 	;pun litera de la indexul esi[ecx-1]
    mov bl, [edi + ecx -1] 	;am ecx -1 deoarece indecsii incep de la 0
    xor al, bl				;xor intre litera si cheie
    mov byte[edx + ecx -1], al 	;pun rezultatul in edx[ecx-1]
    loop parcurge_sir 		;parcurg sirul cu loop(care scade singur ecx-ul)


    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY