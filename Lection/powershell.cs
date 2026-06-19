//dotnet add package Microsoft.PowerShell.SDK установить!
using System;
using System.Management.Automation; // Пространство имен для работы с PS

class Program
{
    static void Main(string[] args)
    {
        // пространство выполнения PowerShell
        using (PowerShell ps = PowerShell.Create())
        {
            // команда или скрипт (например, получить топ-3 процесса по CPU)
            ps.AddScript("Get-Process | Sort-Object CPU -Descending | Select-Object -First 3");

            // выполняем скрипт синхронно 
            var results = ps.Invoke();

            // Обрабатываем ошибки, если они возникли во время выполнения
            if (ps.HadErrors)
            {
                foreach (var error in ps.Streams.Error)
                {
                    Console.WriteLine($"Ошибка: {error}");
                }
                return;
            }

            // Читаем свойства .NET объектов, которые вернул PowerShell
            Console.WriteLine("Топ-3 процесса в системе:");
            foreach (PSObject obj in results)
            {
                // PowerShell возвращает динамические объекты, свойства доступны по именам
                var name = obj.Properties["ProcessName"].Value;
                var id = obj.Properties["Id"].Value;
                var cpu = obj.Properties["CPU"].Value ?? 0;

                Console.WriteLine($"- Процесс: {name} (ID: {id}) | CPU: {cpu:F2}");
            }
        }
    }
}
