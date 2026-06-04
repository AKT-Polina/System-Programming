; Файл: main.asm
section .data
    ; (Здесь могли бы быть ваши данные)

section .text
    global _start

    ; Импортируем процедуры из модуля math.asm
    extern sum_nums
    extern square_num

_start:
    ; --- Пример 1: Вызываем sum_nums(10, 20) ---
    push 20
    push 10
    call sum_nums        ; Линковщик свяжет этот вызов с кодом из math.asm
    add esp, 8           ; Очищаем стек. Теперь в EAX лежит 30

    ; --- Пример 2: Вызываем square_num(EAX) ---
    ; Передаем результат предыдущей функции (30) в качестве аргумента
    push eax             
    call square_num      ; Считаем 30 * 30
    add esp, 4           ; Очищаем стек. Теперь в EAX лежит 900

    ; --- Выход из программы (sys_exit) ---
    ; Код возврата программы будет равен результату вычислений (в регистре EBX)
    mov ebx, eax         ; Переносим 900 в EBX (в Linux код ответа усекается до 1 байта, 900 % 256 = 132)
    mov eax, 1           ; Системный вызов sys_exit
    int 0x80
