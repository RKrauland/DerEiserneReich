# This is to force windows updates via PowerShell

# Scan, Download, & Reboot if needed
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force; Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force; Install-Module PSWindowsUpdate -Scope CurrentUser -Force; Import-Module PSWindowsUpdate; Install-WindowsUpdate -AcceptAll -AutoReboot
