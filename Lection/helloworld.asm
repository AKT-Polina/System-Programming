bits 64
default rel

; Импортируем функции из системной библиотеки Windows (kernel32.dll)
extern GetStdHandle
extern WriteFile
extern ExitProcess

section .data
    msg db "Hello, World!", 13, 10  ; Наша строка с переносом строки (CRLF)
    msg_len equ $ - msg             ; Вычисляем длину строки динамически

section .bss
    bytes_written resq 1            ; Выделяем 8 байт под переменную для результата

section .text
global main
main:
    ; 1. Получаем хендл (указатель) на стандартный вывод (консоль)
    ; Функция GetStdHandle принимает один аргумент. В x64 это регистр RCX.
    ; -11 означает STD_OUTPUT_HANDLE
    mov rcx, -11
    sub rsp, 40                     ; Выделяем теневой стек (Shadow Space), требование Windows x64
    call GetStdHandle
    add rsp, 40                     ; Возвращаем стек обратно
    mov rbx, rax                    ; Сохраняем полученный хендл консоли в регистр RBX

    ; 2. Вызываем WriteFile(handle, buffer, length, &bytes_written, reserved)
    ; Аргументы передаем строго по соглашению вызовов Windows x64: RCX, RDX, R8, R9 + стек
    sub rsp, 40                     ; Выделяем теневой стек
    mov rcx, rbx                    ; 1-й аргумент: хендл консоли
    lea rdx, [msg]                  ; 2-й аргумент: указатель на нашу строку
    mov r8, msg_len                 ; 3-й аргумент: длина строки
    lea r9, [bytes_written]         ; 4-й аргумент: куда записать количество выведенных байт
    mov qword [rsp + 32], 0         ; 5-й аргумент: передается через стек (пропускаем теневую зону в 32 байта)
    call WriteFile
    add rsp, 40                     ; Восстанавливаем стек

    ; 3. Завершаем процесс: ExitProcess(0)
    mov rcx, 0                      ; Аргумент 0 — код успешного завершения
    call ExitProcess
