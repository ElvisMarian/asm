%include "io.mac"

section .data

 index_str dd 1
 index_text dd 0
 len_txt dd 0
 len_str dd 0
found dd 0

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY
    mov [len_txt], ecx          ;Lungimea sirului
    mov [len_str], edx          ;lungimea string-ului cautat
    mov byte[index_text], 1     ;index pentru text
    mov byte[index_str], 1      ;index pentru string

parcurge_sir:                   ;parcurg de la stanga la dreapta
    mov cl, byte[index_str]         
    mov dl, [ebx + ecx-1 ]      ;pun primul caracter din string-ul cautat in dl
    mov cl, byte[index_text]    ;pun primul caracter din text in al
    mov al, [esi + ecx-1]   
    inc byte[index_text]        ;cresc indexul textului
    cmp dl, al                  ;compar textul cu string-ul
    jne reset_str_index         ;daca nu sunt egale voi reseta index_str
    mov cl,byte[found]          ;daca sunt egale verific daca found e setat
    cmp cl, 0                   
    je set_found
continua:
    mov cl, byte[index_str]
    cmp cl, byte[len_str]
    je gasit                    ;daca tot string-ul se gaseste in text 
    inc byte[index_str]         ;daca nu cresc indexul
do_again:
    mov cl,byte [index_text]   ;pun index txt in ecx
    cmp cl,byte [len_txt]      ;daca am ajuns la final
    je nu_am_gasit             ;nu am gasit subsirul in sir
    jmp parcurge_sir           ;daca nu am ajuns la final parcurg iar
nu_am_gasit:
    inc byte[len_txt]
    mov cl, byte[len_txt]      ;daca nu am gasit returnez lungimea textului+1
    mov byte[edi], cl
    jmp exit
reset_str_index:               ;daca mi-a dat fail o litera resetez indexul 
    mov byte[found], 0         ;setez gasit pe 0
    mov byte[index_str], 1     ;setez indexul substringului pe 1
    jmp do_again               ;iterez iar
set_found:
    mov ecx,dword [index_text] ;retin (indexul la care s-a gasit) -2
    sub ecx, 2;                    
    mov byte[found], cl         ; dupa ce am setat prima compatibilitate continui
    jmp continua
gasit:
    mov ecx,dword[found]        ;daca am gasit returnez valoarea lui found
    mov byte[edi],cl
exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY