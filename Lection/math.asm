; Файл: math.asm
section .text

; Объявляем, какие процедуры будут доступны снаружи модуля
global sum_nums
global square_num

; Процедура сложения двух чисел (через стек)
sum_nums:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]   ; Первый аргумент
    add eax, [ebp + 12]  ; Второй аргумент

    pop ebp
    ret

; Процедура возведения числа в квадрат
square_num:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]   ; Аргумент
    imul eax, eax        ; EAX = EAX * EAX

    pop ebp
    ret
