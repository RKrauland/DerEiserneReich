              ★            ◆            ★            ◆            ★
             ╱ ╲           ╱ ╲          ╱ ╲          ╱ ╲           ╱ ╲
            ║ Fe ║       ║ ◈ ║       ║ Fe ║       ║ ◈  ║       ║ Fe ║
            ║ 26 ║       ║    ║       ║ 26 ║       ║    ║       ║ 26 ║
            ╠═══╬═════╬═══╬═════╬═══╬═════╬═══╬═════╬═══╣
            ║ ◆  ║   ◈  ║ ★ ║   ◈   ║ ◆ ║   ◈  ║ ★  ║  ◈   ║ ◆ ║
            ╠═══╩═════╩═══╩═════╩═══╩═════╩═══╩═════╩═══╣
            ║                                                           ║
            ║                ⚔⛨ DER EISERNE REICH ⛨⚔                 ║
            ║                                                           ║
            ║           Built to Endure, Destined to Reign              ║
            ║                                                           ║
            ║                        Est. 2025                          ║
            ║                                                           ║
            ║           Crowned in Code, Baptized in Fire               ║
            ║                                                           ║
            ║           Under His Majesty's Ancient Seal:               ║
            ║                 52414B.DerEiserneReich                    ║
            ║                                                           ║
            ║                            ║                              ║
            ║                            ║                              ║
            ║                        ═══╬═══                          ║
            ║                            ║                              ║
            ║                            ║                              ║
            ║                            ║                              ║
            ║                                                            ║
            ╚════════════════════════════════════════════╝


═══════════════════════════════════════════════════════════════════════
              IE MODE POWERSHELL DEPLOYMENT SCRIPT GUIDE
═══════════════════════════════════════════════════════════════════════

OVERVIEW:
This PowerShell script automatically configures Microsoft Edge's Internet
Explorer (IE) mode on Windows machines. It handles registry configuration,
XML file deployment, and can download site lists from SharePoint.

═══════════════════════════════════════════════════════════════════════

WHAT THIS SCRIPT DOES:

✓ Creates necessary directory structure (C:\Admin\EdgeIEMode\)
✓ Downloads XML from SharePoint (if URL provided)
✓ Creates local XML template with example sites (if no SharePoint)
✓ Configures Edge policy registry keys
✓ Enables IE mode functionality
✓ Provides testing instructions

═══════════════════════════════════════════════════════════════════════

REQUIREMENTS:

- Windows 10/11 with Microsoft Edge
- PowerShell 5.1 or higher
- Administrator privileges
- Network access (if using SharePoint deployment)

═══════════════════════════════════════════════════════════════════════

QUICK START:

BASIC USAGE (Local XML):
1. Run PowerShell as Administrator
2. Execute: .\IE_Mode_Configuration.ps1
3. Script creates local XML with template sites
4. Edit C:\Admin\EdgeIEMode\sitelist.xml to add your sites
5. Restart Edge

SHAREPOINT DEPLOYMENT:
1. Upload IE_Mode.xml to SharePoint
2. Get direct download URL
3. Edit script: Set $sharePointXmlUrl variable
4. Run script as Administrator
5. XML downloads automatically from SharePoint

═══════════════════════════════════════════════════════════════════════

CONFIGURATION:

Open IE_Mode_Configuration.ps1 and modify these variables:

$sharePointXmlUrl = ""
   - Leave blank for local XML creation
   - Or set to your SharePoint direct download URL
   - Example: "https://company.sharepoint.com/sites/IT/IE_Mode.xml"

$localXmlPath = "C:\Admin\EdgeIEMode\sitelist.xml"
   - Local path where XML will be stored
   - Change if you need different location

$edgePolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
   - Registry path for Edge policies
   - Usually should not be changed

═══════════════════════════════════════════════════════════════════════

DEPLOYMENT METHODS:

LOCAL EXECUTION:
PowerShell as Admin → Run script → Done

REMOTE EXECUTION (PSRemoting):
Invoke-Command -ComputerName PC01 -FilePath .\IE_Mode_Configuration.ps1

GROUP POLICY STARTUP SCRIPT:
1. Copy script to SYSVOL
2. Add to Computer Configuration → Policies → Windows Settings → 
   Scripts → Startup
3. Script runs at every boot

INTUNE DEPLOYMENT:
1. Upload script to Intune (Devices → Scripts → Add)
2. Configure:
   - Run script in 64-bit PowerShell: Yes
   - Run with logged-on credentials: No (run as SYSTEM)
   - Enforce script signature check: No
3. Assign to device groups

SCCM/MECM DEPLOYMENT:
1. Create package with script
2. Create program (Run: powershell.exe -ExecutionPolicy Bypass 
   -File IE_Mode_Configuration.ps1)
3. Deploy to collections

RMM TOOLS (Kaseya, N-able, etc.):
1. Upload script to RMM platform
2. Create script policy/procedure
3. Deploy to agent groups
4. Monitor execution results

═══════════════════════════════════════════════════════════════════════

SCRIPT EXECUTION POLICY:

If you get "execution policy" errors, run one of these:

BYPASS FOR THIS SESSION:
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

PERMANENT (COMPUTER):
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

PERMANENT (USER):
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

ONE-TIME RUN:
powershell.exe -ExecutionPolicy Bypass -File .\IE_Mode_Configuration.ps1

═══════════════════════════════════════════════════════════════════════

REGISTRY KEYS CREATED:

Path: HKLM:\SOFTWARE\Policies\Microsoft\Edge

InternetExplorerIntegrationLevel (DWORD) = 1
   Enables IE mode in Microsoft Edge

InternetExplorerIntegrationTestingAllowed (DWORD) = 1
   Allows users to test IE mode via edge://settings

InternetExplorerIntegrationSiteList (String) = [XML file path]
   Points Edge to the site list configuration file

═══════════════════════════════════════════════════════════════════════

VERIFICATION:

AFTER RUNNING SCRIPT:

1. CHECK REGISTRY:
   Run: Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
   Should show all three keys configured

2. CHECK XML FILE:
   Navigate to: C:\Admin\EdgeIEMode\
   File "sitelist.xml" should exist

3. TEST IN EDGE:
   - Open Edge
   - Navigate to: edge://compat/enterprise
   - Verify "Enterprise site list" shows your XML path
   - Go to configured site and look for IE icon

═══════════════════════════════════════════════════════════════════════

CUSTOMIZING THE XML:

After script creates the template XML, edit it to add your sites:

OPEN FILE:
notepad C:\Admin\EdgeIEMode\sitelist.xml

ADD SITES:
<site url="your-site.com">
    <open-in>IE11</open-in>
</site>

EXAMPLES:

Internal site:
<site url="intranet.company.local">
    <open-in>IE11</open-in>
</site>

IP address:
<site url="192.168.10.50">
    <open-in>IE11</open-in>
</site>

Wildcard domain:
<site url="*.oldapp.com">
    <open-in>IE11</open-in>
</site>

Specific page:
<site url="portal.company.com/legacy/app">
    <open-in>IE11</open-in>
</site>

═══════════════════════════════════════════════════════════════════════

SHAREPOINT DEPLOYMENT SETUP:

1. UPLOAD XML TO SHAREPOINT:
   - Upload IE_Mode.xml to SharePoint document library
   - Right-click file → Copy link → "People with existing access"

2. GET DIRECT DOWNLOAD URL:
   Method A - Use the link SharePoint provides
   Method B - Construct manually:
     https://[tenant].sharepoint.com/sites/[site]/_layouts/15/download.aspx?SourceUrl=/sites/[site]/[library]/IE_Mode.xml

3. UPDATE SCRIPT:
   $sharePointXmlUrl = "YOUR_SHAREPOINT_URL_HERE"

4. PERMISSIONS:
   - Ensure computer accounts can access SharePoint
   - Or use service account authentication
   - Test download manually first:
     Invoke-WebRequest -Uri "YOUR_URL" -OutFile "test.xml"

═══════════════════════════════════════════════════════════════════════

TROUBLESHOOTING:

ISSUE: "Access Denied" or "Unauthorized" errors
SOLUTION:
   - Run PowerShell as Administrator
   - Check file/folder permissions
   - For SharePoint: verify URL and access permissions

ISSUE: Script runs but IE mode doesn't work
SOLUTION:
   - Verify Edge version supports IE mode (version 77+)
   - Check registry keys were created:
     Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
   - Restart Edge completely (close all windows)
   - Force policy refresh: gpupdate /force

ISSUE: XML file not found
SOLUTION:
   - Check path: Test-Path "C:\Admin\EdgeIEMode\sitelist.xml"
   - Verify XML syntax is valid
   - Check file encoding is UTF-8

ISSUE: Sites not loading in IE mode
SOLUTION:
   - Verify site URL in XML matches exactly what you type in browser
   - Check for typos in XML
   - Validate XML: [xml](Get-Content "C:\Admin\EdgeIEMode\sitelist.xml")
   - Clear Edge cache: edge://settings/clearBrowserData

ISSUE: SharePoint download fails
SOLUTION:
   - Test URL in browser first
   - Verify URL is direct download link, not web view
   - Check network connectivity
   - Try with -UseBasicParsing parameter (already in script)
   - Check firewall/proxy settings

═══════════════════════════════════════════════════════════════════════

AUTOMATION & SCHEDULING:

WINDOWS TASK SCHEDULER:
Run script on schedule or at startup:

schtasks /create /tn "IE Mode Config" /tr "powershell.exe -ExecutionPolicy Bypass -File C:\Scripts\IE_Mode_Configuration.ps1" /sc onstart /ru SYSTEM

GROUP POLICY SCHEDULED TASK:
1. Computer Configuration → Preferences → Control Panel Settings → 
   Scheduled Tasks
2. New → Scheduled Task
3. Action: Run PowerShell script
4. Trigger: At startup or on schedule

INTUNE PROACTIVE REMEDIATION:
1. Create detection script (checks if registry keys exist)
2. Create remediation script (runs IE_Mode_Configuration.ps1)
3. Schedule to run daily/weekly
4. Auto-heals if configuration breaks

═══════════════════════════════════════════════════════════════════════

UNINSTALLING / REMOVING IE MODE:

To disable IE mode, run this PowerShell as Administrator:

Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "InternetExplorerIntegrationLevel" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "InternetExplorerIntegrationTestingAllowed" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "InternetExplorerIntegrationSiteList" -ErrorAction SilentlyContinue

# Optional: Remove XML file
Remove-Item "C:\Admin\EdgeIEMode\sitelist.xml" -Force -ErrorAction SilentlyContinue

# Restart Edge
Get-Process -Name "msedge" -ErrorAction SilentlyContinue | Stop-Process -Force

═══════════════════════════════════════════════════════════════════════

ADVANCED USAGE:

LOGGING:
Add transcript logging to track execution:

Start-Transcript -Path "C:\Admin\EdgeIEMode\deployment.log" -Append
# ... script content ...
Stop-Transcript

ERROR HANDLING:
Wrap in try/catch for better error management:

try {
    .\IE_Mode_Configuration.ps1
} catch {
    Write-Error "Failed: $($_.Exception.Message)"
    exit 1
}

PARAMETER INPUT:
Modify script to accept parameters:

param(
    [string]$SharePointUrl,
    [string]$LocalPath = "C:\Admin\EdgeIEMode\sitelist.xml"
)

SILENT EXECUTION:
Run without output for automation:

.\IE_Mode_Configuration.ps1 > $null 2>&1

═══════════════════════════════════════════════════════════════════════

SECURITY BEST PRACTICES:

✓ Always run with minimum required permissions
✓ Use code signing for production deployments
✓ Store SharePoint credentials securely (use managed identities)
✓ Regularly audit IE mode site list
✓ Remove sites when no longer needed
✓ Use HTTPS for SharePoint URLs
✓ Implement change control for XML modifications
✓ Monitor for unauthorized registry changes
✓ Test in non-production environment first

═══════════════════════════════════════════════════════════════════════

SUPPORT & RESOURCES:

Microsoft Edge IE Mode Documentation:
https://docs.microsoft.com/en-us/deployedge/edge-ie-mode

Enterprise Site List Manager Tool:
https://www.microsoft.com/en-us/download/details.aspx?id=49974

Edge for Business:
https://www.microsoft.com/en-us/edge/business

PowerShell Documentation:
https://docs.microsoft.com/en-us/powershell/

═══════════════════════════════════════════════════════════════════════

SCRIPT DETAILS:

Version: 1.0-DER
Build: 52414B.DerEiserneReich
Signature: DER-FN-2025

Compatibility: Windows 10/11, PowerShell 5.1+, Edge 77+
License: Open Source - Use at your own risk
Support: Community-driven

═══════════════════════════════════════════════════════════════════════

CHANGELOG:

Version 1.0-DER (2025)
- Initial release
- SharePoint download support
- Local XML template creation
- Registry configuration automation
- Build: 52414B.DerEiserneReich

═══════════════════════════════════════════════════════════════════════



                      ╔═══════╗
                    ╔╝           ╚╗
                  ╔╝      ⚔       ╚╗
                ╔╝                  ╚╗
                ║         DER         ║
                ║       EISERNE       ║
                ║        REICH        ║
                 ╲                   ╱
                   ╲                ╱
                    ╲              ╱
                     ╲            ╱
                      ╲          ╱
                        ╲       ╱
                         ╲     ╱
                            V


═══════════════════════════════════════════════════════════════════════
         End of IE_Mode_PowerShell_README.txt
         Build: 52414B.DerEiserneReich
         Der Eiserne Reich © 2025
═══════════════════════════════════════════════════════════════════════
