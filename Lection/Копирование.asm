%include "io.inc"
section .text
section .data
    str1 db "Hello", 0
    str2 db "world", 0
    
    char db 'o'
 
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax

    mov edi, str1 ; esi = str1
    mov edi, str2 ; edi = str2
    mov ecx,  5 ; ecx - количество символов в строке
    
    rep movsb ; копирование ecx сиволов из esi в edi
    
    
    PRINT_STRING str2
    NEWLINE
    
    
    
    ret
