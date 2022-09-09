[string]$currentdir = Get-Location
Set-Location "PegaInstaller\117271_Pega8.7.3\scripts\"
Invoke-Expression -Command: "cmd.exe /C 'install.bat'"
Set-Location $currentdir
