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
    
    mov edi, str2 ; edi = str1
    mov ecx,  5 ; ecx - количество символов в строке
    mov al, [char] ;al - искомый символ
    
    repne scasb ; сканирование ecx символов
    
    je found ;если найден, символ прыгаем в found
    PRINT_STRING "Not Found" ; сообщение
    jmp endl
    
    found:
    PRINT_STRING "Found" ;сообщение
    NEWLINE
    PRINT_DEC 4, ecx
    
    endl:
    
    
    ret
