%include "io.mac"

section .data
hexa_base db "0123456789ABCDEF"
counter dd 1
counter_hex dd 0
length dd 0

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length

    xor ebx, ebx
    mov dword[counter], 1       ;counter-ul de biti
    mov dword[counter_hex], 0   ;counter-ul pentru lungimea secventei hexa

    mov dword[length], ecx      
lenght_of_hexa_value:           ;calculeaza lungimea secventei hexa
    sub dword[length], 4        ;scade 4(4 biti formeaza un caracter hexa)
    inc dword[counter_hex]      ;aici salvez lungimea secventei hexa
    cmp dword[length], 0        ;daca mai am biti disponibili mai iterez odata
    jg lenght_of_hexa_value
    dec dword[counter_hex]      ;deoarece am incrementat inca odata la iesire
init_edx:                       ;initializez vectorul edx cu A ca sa-l pot 
    mov byte[edx + eax] , 65    ;modifica                                       
    inc eax                     ;folosesc eax-ul pe post de counter
    cmp eax, dword[counter_hex] ;cat timp counter-ul e diferit sau egal cu eax
    jle init_edx                ;pun A in edx
    mov eax, dword[counter_hex] ;copiez lungimea lui edx in length
    mov dword[length], eax
    xor eax, eax                ;curat ecx-ul 

parcurg_secventa:               ;parcurg secventa de biti
    mov al, byte[esi + ecx -1]  ;pun primul bit in al
    cmp eax, 48                 ;verific daca bitul e 0(48 in ASCII)
    je next                     ;daca nu e 0 trec pe unul din cazuri
    cmp dword[counter], 1       ;atunci cand bitul se afla pe pozitia 1
    jz case_1
    cmp dword[counter], 2       ;bitul se afla pe pozitia 2
    jz case_2
    cmp dword[counter], 3       ;bitul se afla pe pozitia 3
    jz case_3
    cmp dword[counter], 4       ;bitul se afla pe pozitia 4
    jz case_4

continue:                       ;parcurg de la dreapta la stanga
    dec ecx                     ;scad lungimea secventei(ma mut mai la stanga)
    jz convert                    ;verific daca mai am biti:daca nu mai am pun
    jge parcurg_secventa        ; valoarea in hexa ,iar daca mai am parcurg
    jmp exit

next:                           ;daca bitul e setat pe 0
    inc dword[counter]          ;cresc counter-ul de biti   
    cmp dword[counter], 4       ;ma uit sa vad daca am ajuns la bitul 4
    jg convert                    ;daca am ajuns  trebuie sa pun valoarea
    jmp continue                ;in hexa.Daca nu parcurg in continuare

convert:                        ;pun litera corespunzatoare in edx
    xor eax, eax                ;resetez eax-ul
    mov bl, byte[hexa_base + ebx]   ;pun litera corespunzatoare in baza_16
    mov eax, dword[counter_hex] ;pun in eax lungimea secventei hexa
    mov byte[edx + eax], bl     ;pun in edx[eax] litera
    dec dword[counter_hex]      ;scad lungimea secventei hexa
    jl exit                     ;daca secenta s-a terminat atunci ies
    mov dword[counter], 1       ;resetez counter-ul de biti
    xor ebx, ebx                ;resetez ebx-ul deoarece in el pun suma
    jmp continue                ;bitilor 1-2-3-4

case_1:
    inc ebx                     ;cand am  primul bit 1 adaug 2 ^ 0 = 1
    inc dword[counter]          ;cresc counter-ul de biti
    jmp continue 

case_2:
    add ebx, 2                  ;cand am al doilea bit 1 adaug 2 ^ 1 = 2
    inc dword[counter] 
    jmp continue 

case_3:
    add ebx, 4                  ;cand am al treilea bit 1 adaug 2 ^ 2 = 4
    inc dword[counter] 
    jmp continue

case_4:
    add ebx, 8                  ;cand am al patrulea bit 1 adaug 2 ^ 3 = 8
    jmp convert                 ;cand counter-ul e 4 trebuie pus in edx

exit:                           ;pun la sfarsitul 
    mov eax, dword[length]      ;sirului din edx newline(10 in ASCII)
    inc eax
    mov byte[edx + eax], 10         

    popa
    leave
    ret
    ;; DO NOT MODIFY