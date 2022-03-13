%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY 
parcurge_sir:               ;parcurg string-ul de la dreapta la stanga
    mov al, [esi + ecx - 1] ;pun litera in al
    cmp al, 122             ;compar al-ul cu z
    jl test_for_lowercase   ;daca nu e mai mare decat 'z' merg sa compar cu 'a'
    jmp pune_rez            ;daca e ceva mai mare decat 'z' il pun in edx
test_for_lowercase:
    cmp al, 97              ;compar al-ul cu 'a'
    jge  lowercase          ;daca e >= inseamna ca al e o litera mica
    cmp al, 90              ;compar al-ul cu 'Z'
    jle test_for_uppercase  ;daca al e <= ma uit daca e mai mare decat 'A'
    jmp pune_rez            ;daca nu e inseamna ca nu e litera mare/mica
test_for_uppercase:                      
    cmp al, 65              ;daca al e >= decat 'A'
    jge uppercase          ;inseamna ca e litera mare
pune_rez:
    mov byte[edx + ecx - 1], al ;pun in edx de la dreapta catre stanga    
    loop parcurge_sir        ;daca mai am caractere mai parcurg 
    jmp exit                ;daca sirul s-a terminat ma duc la final
lowercase:                  ;adun cheia la litera mica (ASCII)
    add eax, edi            ;ma uit daca am depasit 'z'
    cmp eax, 122            
    jg reset_lowercase      ;daca am depasit trebuie sa fac o resetare
    jmp pune_rez            ;daca nu am depasit pun litera in 
reset_lowercase:
    sub eax,26              ;scad 26(diferenta intre 'z'-'a')
    cmp eax, 122            ;pana cand ajung in intervalul 'a'-'z'(97-122)
    jg reset_lowercase              
    jmp pune_rez            ;cand s-a terminat resetarea pun rezultatul
uppercase:                  ;daca e litera mare adun cheia la caracter
    add eax, edi            ;verific daca am depasit  intervalul(90 = 'Z')
    cmp eax, 90
    jg reset_uppercase      ;daca am depasit fac resetare
    jmp pune_rez            ;daca nu am depasit pun rezultatul

reset_uppercase:
    sub eax, 26             ;scad 26 ('Z' - 'A' ) pana ajung in interval(65-90)
    cmp eax, 90                 
    jg reset_uppercase
    jmp pune_rez            ;pun rezultat
exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY            