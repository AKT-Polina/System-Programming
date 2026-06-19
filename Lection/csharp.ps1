# C# код внутри многострочной переменной
$cSharpCode = @"
using System;

namespace MySystemTools
{
    public class HardwareInfo
    {
        public static void ShowMessage(string name)
        {
            Console.WriteLine($"Привет из C#, {name}! Текущее время OS: {DateTime.Now}");
        }

        public int Calculate(int a, int b)
        {
            return a * b;
        }
    }
}
"@

# Компилируем код в сессии PowerShell
Add-Type -TypeDefinition $cSharpCode

# Вызываем статический метод C#
[MySystemTools.HardwareInfo]::ShowMessage("Разработчик")

# Создаем экземпляр объекта C# и вызываем его метод
$infoObject = New-Object MySystemTools.HardwareInfo
$result = $infoObject.Calculate(5, 10)
Write-Host "Результат вычисления: $result"
