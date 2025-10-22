# Microsoft Teams PowerShell Cheatsheet

##  💾 Install Teams Only
$exe="$env:TEMP\teamsbootstrapper.exe"; Invoke-WebRequest -UseBasicParsing 'https://go.microsoft.com/fwlink/?linkid=2243204' -OutFile $exe; Start-Process $exe -ArgumentList '-p' -Wait

## 🧨 Force Uninstall Teams
Get-Process -Name ms-teams,teams -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue; Remove-Item -LiteralPath "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe" -Recurse -Force -ErrorAction SilentlyContinue; shutdown /r /f /t 0
