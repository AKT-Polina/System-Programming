# 1. Загружаем библиотеку Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# 2. Создаем главное окно приложения
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Мое GUI Приложение"
$Form.Size = New-Object System.Drawing.Size(400,250)
$Form.StartPosition = "CenterScreen"

# 3. Создаем текстовое поле (Label)
$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Нажмите на кнопку ниже:"
$Label.Location = New-Object System.Drawing.Point(30,30)
$Label.Size = New-Object System.Drawing.Size(300,20)
$Form.Controls.Add($Label)

# 4. Создаем кнопку (Button)
$Button = New-Object System.Windows.Forms.Button
$Button.Text = "Нажми меня"
$Button.Location = New-Object System.Drawing.Point(30,70)
$Button.Size = New-Object System.Drawing.Size(120,30)

# 5. Описываем логику при нажатии на кнопку (Событие)
$Button.Add_Click({
    $Label.Text = "Кнопка успешно нажата! Выполняю скрипт..."
    [System.Windows.Forms.MessageBox]::Show("Привет из PowerShell!", "Уведомление")
})
$Form.Controls.Add($Button)

# 6. Отображаем окно на экране
$Form.ShowDialog()
