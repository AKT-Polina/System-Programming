using Cronos;
using Microsoft.Extensions.Hosting;

public class MyScheduledWorker : BackgroundService
{
    // Каждый час в 00 минут
    private readonly CronExpression _cron = CronExpression.Parse("0 * * * *"); 

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            DateTime utcNow = DateTime.UtcNow;
            DateTime? nextUtc = _cron.GetNextOccurrence(utcNow);

            if (nextUtc.HasValue)
            {
                // Вычисляем, сколько времени нужно подождать до следующего тика
                TimeSpan delay = nextUtc.Value - utcNow;
                
                // Засыпаем на этот промежуток времени
                await Task.Delay(delay, stoppingToken);

                // Выполняем вашу задачу
                await DoWorkAsync(stoppingToken);
            }
            else
            {
                // Если совпадений больше нет (например, указан конкретный год в прошлом)
                break; 
            }
        }
    }

    private Task DoWorkAsync(CancellationToken cancellationToken)
    {
        Console.WriteLine($"Задача выполнена в: {DateTime.Now}");
        return Task.CompletedTask;
    }
}
