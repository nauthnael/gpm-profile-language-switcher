# Hien thi credit
Write-Host "`n==================================================="
Write-Host "Y tuong: Tuangg"
Write-Host "Nguoi viet code: Claude" 
Write-Host "Website: https://x.com/nauthnael"
Write-Host "===================================================`n"

# Lay thoi gian hien tai de dat ten file log
$timestamp = Get-Date -Format "ddMMyyyy_HHmmss"
$logFile = "change_language_log_$timestamp.txt"

# Ham ghi log
function Write-Log {
   param($Message)
   $logMessage = "$(Get-Date -Format 'dd/MM/yyyy HH:mm:ss'): $Message"
   Add-Content $logFile $logMessage
}

# Ham hien thi loading
function Show-Loading {
   param($Message)
   $spinner = @('|', '/', '-', '\')
   $spinnerPos = 0
   while ($true) {
       Write-Host "`r$Message $($spinner[$spinnerPos])" -NoNewline
       $spinnerPos++
       if ($spinnerPos -ge $spinner.Length) {
           $spinnerPos = 0
       }
       Start-Sleep -Milliseconds 100
   }
}

# Ham hoi nguoi dung
function Get-UserChoice {
   param(
       [string]$Question,
       [string]$DefaultChoice = "Y"
   )
   $choices = [System.Management.Automation.Host.ChoiceDescription[]] @("&Yes", "&No")
   $defaultChoice = if ($DefaultChoice -eq "Y") { 0 } else { 1 }
   $result = $host.UI.PromptForChoice("", $Question, $choices, $defaultChoice)
   return $result -eq 0
}

try {
   # Hoi nguoi dung muon thay doi tat ca hay mot profile
   Write-Host "`nBan muon thay doi ngon ngu cho:"
   Write-Host "1. Tat ca cac profile"
   Write-Host "2. Chi mot profile cu the"
   $choice = Read-Host "Nhap lua chon cua ban (1 hoac 2)"

   $baseDir = ""
   if ($choice -eq "1") {
       $baseDir = Read-Host "Nhap duong dan thu muc chua profiles (Vi du: C:\GPM-data)"
       Write-Host "Dang tim kiem profiles can chuyen sang tieng Anh..."
   }
   else {
       $baseDir = Read-Host "Nhap duong dan profile cu the (Vi du: C:\GPM-data\6e513aa9-0a9e-4812-aca9-c794d352c7ac-7954)"
       Write-Host "Dang tim kiem profile can chuyen sang tieng Anh..."
   }

   # Kiem tra thu muc ton tai
   if (-not (Test-Path $baseDir)) {
       Write-Host "Khong tim thay thu muc: $baseDir"
       Write-Log "Khong tim thay thu muc: $baseDir"
       exit
   }

   # Bat dau job loading
   $job = Start-Job -ScriptBlock { 
    param($message)
    Show-Loading $message 
    } -ArgumentList "Dang tim kiem..."

   # Tim file Preferences
   $preferencesFiles = @()
   if ($choice -eq "1") {
       $profileDirs = Get-ChildItem -Path $baseDir -Directory
       $preferencesFiles = $profileDirs | ForEach-Object {
           $defaultPath = Join-Path $_.FullName "Default\Preferences"
           if (Test-Path $defaultPath) {
               Get-Item $defaultPath
           }
       }
   }
   else {
       $defaultPath = Join-Path $baseDir "Default\Preferences"
       if (Test-Path $defaultPath) {
           $preferencesFiles = @(Get-Item $defaultPath)
       }
   }

   # Dung job loading
   Stop-Job $job
   Remove-Job $job
   Write-Host "`r                                                    " -NoNewline

   $totalFiles = $preferencesFiles.Count

   if ($totalFiles -eq 0) {
       Write-Host "`nKhong tim thay file Preferences nao!"
       Write-Log "Khong tim thay file Preferences nao!"
       exit
   }

   Write-Host "`nTim thay $totalFiles profiles can xu ly"
   $continueProcess = Get-UserChoice "Ban co muon tiep tuc khong? (Y/N)"
   if (-not $continueProcess) {
       Write-Log "Nguoi dung huy thuc hien"
       exit
   }

   # Hoi tuy chon backup
   $createBackup = Get-UserChoice "Ban co muon tao file backup khong? (Y/N)"
   $compressBackup = $false
   if ($createBackup) {
       $compressBackup = Get-UserChoice "Ban co muon nen file backup thanh ZIP khong? (Y/N)"
   }

   Write-Log "Bat dau qua trinh thay doi ngon ngu"
   Write-Log "Thu muc goc: $baseDir"
   Write-Log "Tong so file se xu ly: $totalFiles"

   $current = 0
   $successCount = 0
   $errorCount = 0

   foreach ($prefFile in $preferencesFiles) {
       try {
           $current++
           # Cap nhat tien trinh
           Write-Host "`rDang xu ly: $current/$totalFiles" -NoNewline

           $filePath = $prefFile.FullName
           Write-Log "Dang xu ly file: $filePath"

           # Doc noi dung file
           $content = Get-Content $filePath -Raw -Encoding UTF8

           if ($createBackup) {
               $backupPath = "$filePath.backup"
               if ($compressBackup) {
                   $backupZipPath = "$backupPath.zip"
                   Copy-Item $filePath $backupPath
                   Compress-Archive -Path $backupPath -DestinationPath $backupZipPath -Force
                   Remove-Item $backupPath
                   Write-Log "Da tao file backup nen: $backupZipPath"
               }
               else {
                   Copy-Item $filePath $backupPath
                   Write-Log "Da tao file backup: $backupPath"
               }
           }

           # Thay the cau hinh ngon ngu
           $originalContent = $content
           $content = $content -replace '"intl":\{[^}]*"accept_languages":"[^"]*"[^}]*"selected_languages":"[^"]*"[^}]*\}', '"intl":{"accept_languages":"en-US,en","selected_languages":"en-US,en"}'
           $content = $content -replace '"intl":\{[^}]*"accept_languages":"[^"]*"[^}]*\}', '"intl":{"accept_languages":"en-US,en"}'
           $content = $content -replace '"intl":\{[^}]*"selected_languages":"[^"]*"[^}]*\}', '"intl":{"selected_languages":"en-US,en"}'
           $content = $content -replace '"accept_languages":"[^"]*"', '"accept_languages":"en-US,en"'
           $content = $content -replace '"selected_languages":"[^"]*"', '"selected_languages":"en-US,en"'

           if ($content -ne $originalContent) {
               $content | Set-Content $filePath -Force -Encoding UTF8
               Write-Log "Da cap nhat thanh cong"
               $successCount++
           }
           else {
               Write-Log "Khong can thay doi"
               $successCount++
           }
       }
       catch {
           Write-Log "Loi: $($_.Exception.Message)"
           $errorCount++
       }
   }

   Write-Host "`n`nHoan thanh!"
   Write-Host "Ket qua: Thanh cong: $successCount - That bai: $errorCount"
   Write-Log "Ket qua: Thanh cong: $successCount - That bai: $errorCount"
   Write-Host "File log: $((Get-Item $logFile).FullName)"

   # Hien thi credit ket thuc
   Write-Host "`n==================================================="
   Write-Host "Cam on ban da su dung tool"
   Write-Host "Y tuong: Tuangg"
   Write-Host "Neu thay huu ich hay tang minh 1 Follow nhe." 
   Write-Host "Thank you: https://x.com/nauthnael"
   Write-Host "===================================================`n"

}
catch {
   Write-Log "Loi khong mong muon: $($_.Exception.Message)"
   Write-Host "Da xay ra loi! Vui long kiem tra file log"
}

Write-Host "`nNhan Enter de thoat..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
