%include "io.mac"

section .data

 index_key dd 1
 index_text dd 0
 len_txt dd 0
 len_key dd 0

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    mov [len_txt], ecx          ;lungimea textului
    mov [len_key], ebx          ;lungimea cheii
    mov byte[index_text], 0     ;indexul pt text
    mov byte[index_key], 0      ;indexul pt cheie
parcurge_sir:                   ;parcurg de la stanga la dreapta
    mov ecx, dword[index_key]   ;pun indexul cheii in ecx
    mov bl, [edi + ecx ]        ;pun key[ecx] in bl
    mov ecx, 65                 ;pun in ecx caracterul 'A'
    sub ebx, ecx                ;scad din bl pe 'A' si obtin deplasamentul
    mov ecx, dword[index_text]  ;pun in ecx indexul textului
    mov al, [esi + ecx-1]       ;pun in al caracterul esi[ecx-1]
    cmp al, 122                 ;daca caracterul e mai mic decat 'z'
    jle test                    ;testez daca e litera mica
    jmp pune_rez                ;daca nu e pun caracterul in edx
test:
    cmp al, 97                  ;daca caracterul e >= 'a' atunci e litera mica
    jge  lowercase              ;pentru ca e in intervalul(97-122)
    cmp al, 90                  ;compar caracterul cu 'Z'
    jle test2                   ;daca e mai <= atunci testez daca e >= 'A'
    jmp pune_rez                ;daca nu e in interval atunci il pun in rezultat
test2:                          
    cmp al, 65                  ;compar cu 'A'
    jge uppercase ;;           ;daca e >= atunci inseamna ca e litera mare
pune_rez:                       ;pun rezultatele de la stanga catre dreapta
    mov ecx, [index_text]   
    mov byte[edx + ecx -1], al
    inc byte[index_text]        ;cresc indexul textului
    mov ecx, [index_text]
    cmp ecx, [len_txt]          ;ma uit daca mai am text de parcurs
    jle parcurge_sir            ;daca mai am parcurg din nou
    jmp exit                    ;daca nu mai am ies 
lowercase:
    add eax, ebx                ;adun la caracter deplasamentul
    inc dword[index_key]        ;credc indicele cheii
    mov ecx, [len_key]          ;ma uit daca am ajuns cu indicele cheii
    cmp ecx, [index_key]        ;la final
    jz do_index_key_0_2         ;in caz afirmativ resetez
continua2:
    cmp eax, 122                ;ma uit daca am depasit intervalul
    jg reset2                   ;daca am depasit fac reglare
    jmp pune_rez                ;daca nu e nevoie afisez
reset2:                         
    sub eax,26                  ;scad 26 pana cand ajung in interval(97-122)
    cmp eax, 122
    jg reset2
    jmp pune_rez                ;cand ajung afisez rezultatul
do_index_key_0_1:
    mov dword[index_key], 0     ;resetez indicele cheii
    jmp continua                ;continua pe ramura cu litere mari
do_index_key_0_2:
    mov dword[index_key], 0     ;resetez indicele cheii
    jmp continua2               ;continua pe ramura cu litere mici
uppercase:
    add eax, ebx                ;adaug cheia
    inc dword[index_key]        ;cresc indicele cheii
    mov ecx, [len_key]          ;verific daca am ajuns cu cheia la final
    cmp ecx, [index_key]
    jz do_index_key_0_1         ;daca am ajuns o ii resetez indicele
continua:
    cmp eax, 90                 ;ma uit daca sunt in interval(65-90)
    jg reset                    ;daca nu sunt fac reglare
    jmp pune_rez
reset:
    sub eax, 26                 ;scad 26 pana ajung in interval(65-90)
    cmp eax, 90
    jg reset
    jmp pune_rez
exit:                           ;ies
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY