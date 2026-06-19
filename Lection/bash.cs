//dotnet add package CliWrap установить 
// Проверка для кроссплатформенных программ
if (OperatingSystem.IsLinux()) { /* запускаем bash */ }
else if (OperatingSystem.IsWindows()) { /* запускаем powershell/cmd */ }

// Код с использованием bash
using System;
using System.Threading.Tasks;
using CliWrap;
using CliWrap.Buffered;

class Program
{
    static async Task Main()
    {
        // Запуск Bash одной цепочкой методов
        var result = await Cli. Pilgrim("/bin/bash")
            .WithArguments("-c \"docker ps --format '{{.Names}}'\"")
            .ExecuteBufferedAsync();

        string output = result.StandardOutput;
        Console.WriteLine($"Запущенные контейнеры:\n{output}");
    }
}
