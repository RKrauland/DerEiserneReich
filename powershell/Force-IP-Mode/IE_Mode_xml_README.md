          ★         ◆        ★         ◆         ★
         ╱ ╲       ╱ ╲       ╱ ╲       ╱ ╲       ╱ ╲
        ║Fe ║     ║ ◈ ║     ║Fe ║     ║ ◈ ║     ║Fe ║
        ║26 ║     ║   ║     ║26 ║     ║   ║     ║26 ║
        ╠═══╬═════╬═══╬═════╬═══╬═════╬═══╬═════╬═══╣
        ║ ◆ ║  ◈ ║ ★ ║ ◈  ║ ◆ ║ ◈  ║ ★ ║ ◈  ║ ◆ ║
        ╠═══╩═════╩═══╩═════╩═══╩═════╩═══╩═════╩═══╣
        ║                                            ║
        ║         ⚔⛨ DER EISERNE REICH ⛨⚔          ║
        ║                                            ║
        ║      Built to Endure, Destined to Reign   ║
        ║                                            ║
        ║               Est. 2025                    ║
        ║                                            ║
        ║      Crowned in Code, Baptized in Fire    ║
        ║                                            ║
        ║    Under His Majesty's Ancient Seal:      ║
        ║          52414B.DerEiserneReich            ║
        ║                                            ║
        ║                    ║                       ║
        ║                    ║                       ║
        ║                 ═══╬═══                    ║
        ║                    ║                       ║
        ║                    ║                       ║
        ║                    ║                       ║
        ║                                            ║
        ╚════════════════════════════════════════════╝


═══════════════════════════════════════════════════════════════════════
                    IE MODE XML CONFIGURATION GUIDE
═══════════════════════════════════════════════════════════════════════

OVERVIEW:
This XML file configures Microsoft Edge's Internet Explorer (IE) mode,
allowing specific websites to render using IE11 compatibility mode.

═══════════════════════════════════════════════════════════════════════

WHAT IS IE MODE?
Internet Explorer mode provides backward compatibility for legacy web
applications that require Internet Explorer 11. Sites configured in this
XML will automatically open in IE mode when accessed through Microsoft Edge.

═══════════════════════════════════════════════════════════════════════

FILE STRUCTURE:

<?xml version="1.0" encoding="UTF-8"?>
<site-list version="1">
    <created-by>
        <tool>IE Mode Configuration Tool</tool>
        <version>1.0-DER</version>
        <date-created>10/15/2025</date-created>
        <build>1.0.52414B.DerEiserneReich</build>
    </created-by>
    
    <site url="your-site.com">
        <open-in>IE11</open-in>
    </site>
</site-list>

═══════════════════════════════════════════════════════════════════════

HOW TO ADD SITES:

1. Open IE_Mode.xml in a text editor
2. Add a new site entry using this format:

   <site url="example.com">
       <open-in>IE11</open-in>
   </site>

3. Save the file
4. Restart Microsoft Edge

EXAMPLES:

For domain-based sites:
   <site url="intranet.company.com">
       <open-in>IE11</open-in>
   </site>

For IP addresses:
   <site url="192.168.1.100">
       <open-in>IE11</open-in>
   </site>

For specific pages:
   <site url="app.company.com/legacy">
       <open-in>IE11</open-in>
   </site>

═══════════════════════════════════════════════════════════════════════

DEPLOYMENT OPTIONS:

LOCAL DEPLOYMENT:
1. Place XML file in: C:\Admin\EdgeIEMode\sitelist.xml
2. Configure registry:
   - Key: HKLM\SOFTWARE\Policies\Microsoft\Edge
   - Value: InternetExplorerIntegrationLevel = 1 (DWORD)
   - Value: InternetExplorerIntegrationSiteList = "C:\Admin\EdgeIEMode\sitelist.xml" (String)
3. Restart Edge

SHAREPOINT DEPLOYMENT:
1. Upload XML to SharePoint site
2. Get direct file URL
3. Configure registry with SharePoint URL instead of local path
4. Edge will download XML automatically

INTUNE DEPLOYMENT:
1. Upload XML to accessible location (SharePoint recommended)
2. Create PowerShell script to configure registry
3. Deploy via Intune Scripts & Remediations
4. Assign to device groups

GROUP POLICY DEPLOYMENT:
1. Configure via Group Policy Management Console
2. Navigate to: Computer Configuration → Administrative Templates → 
   Microsoft Edge → Configure Internet Explorer integration
3. Set site list location

═══════════════════════════════════════════════════════════════════════

REGISTRY SETTINGS:

Path: HKLM\SOFTWARE\Policies\Microsoft\Edge

InternetExplorerIntegrationLevel (DWORD):
   0 = Disabled
   1 = IE mode enabled

InternetExplorerIntegrationSiteList (String):
   File path or URL to sitelist.xml

InternetExplorerIntegrationTestingAllowed (DWORD):
   0 = Disabled
   1 = Allow users to test IE mode via edge://settings

═══════════════════════════════════════════════════════════════════════

POWERSHELL DEPLOYMENT SCRIPT:

# Enable IE Mode and configure site list
$edgePolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
$xmlPath = "C:\Admin\EdgeIEMode\sitelist.xml"

# Create policy path if it doesn't exist
if (!(Test-Path $edgePolicyPath)) {
    New-Item -Path $edgePolicyPath -Force | Out-Null
}

# Enable IE mode
Set-ItemProperty -Path $edgePolicyPath -Name "InternetExplorerIntegrationLevel" -Value 1 -Type DWord -Force

# Set site list location
Set-ItemProperty -Path $edgePolicyPath -Name "InternetExplorerIntegrationSiteList" -Value $xmlPath -Type String -Force

# Allow IE mode testing (optional)
Set-ItemProperty -Path $edgePolicyPath -Name "InternetExplorerIntegrationTestingAllowed" -Value 1 -Type DWord -Force

Write-Host "IE Mode configured successfully!"

═══════════════════════════════════════════════════════════════════════

TESTING IE MODE:

1. Open Microsoft Edge
2. Navigate to edge://compat/enterprise
3. Verify site list location is configured
4. Navigate to a configured site
5. Look for IE icon in address bar (left side)
6. Site should render in IE11 compatibility mode

═══════════════════════════════════════════════════════════════════════

TROUBLESHOOTING:

ISSUE: Sites not loading in IE mode
SOLUTION: 
   - Verify XML file path/URL is accessible
   - Check registry settings are correct
   - Restart Microsoft Edge completely
   - Run: gpupdate /force (if using Group Policy)

ISSUE: XML file not found
SOLUTION:
   - Verify file exists at specified location
   - Check file permissions (needs read access)
   - For SharePoint: ensure URL is direct download link

ISSUE: Registry settings not applying
SOLUTION:
   - Run PowerShell as Administrator
   - Check Group Policy isn't overriding settings
   - Restart computer if necessary

ISSUE: Edge not reading XML updates
SOLUTION:
   - Close ALL Edge processes (including background)
   - Clear Edge cache: edge://settings/clearBrowserData
   - Force policy refresh: gpupdate /force
   - Restart Edge

═══════════════════════════════════════════════════════════════════════

ADVANCED CONFIGURATION:

WILDCARDS:
You can use wildcards for domain matching:
   <site url="*.company.com">
       <open-in>IE11</open-in>
   </site>

SPECIFIC PROTOCOLS:
   <site url="http://intranet.local">
       <open-in>IE11</open-in>
   </site>

EXCLUDE SUBDOMAINS:
   <site url="app.company.com">
       <open-in>IE11</open-in>
   </site>
   <site url="modern.company.com">
       <open-in>None</open-in>
   </site>

═══════════════════════════════════════════════════════════════════════

MAINTENANCE:

ADDING SITES:
1. Edit XML file
2. Add new <site> entries
3. Save file
4. Users will get updates on next Edge restart (or after 24 hours)

REMOVING SITES:
1. Delete or comment out <site> entries
2. Save file
3. Changes apply on next Edge restart

UPDATING SHAREPOINT XML:
1. Edit and save new version in SharePoint
2. Edge checks for updates periodically
3. Or users can force update: edge://compat/enterprise → "Force update"

═══════════════════════════════════════════════════════════════════════

SECURITY CONSIDERATIONS:

- Store XML file in secure location with appropriate permissions
- Use HTTPS for SharePoint-hosted XML files
- Regularly review and audit configured sites
- Remove sites when no longer needed
- Monitor for unauthorized modifications
- Test changes in non-production environment first

═══════════════════════════════════════════════════════════════════════

SUPPORT & RESOURCES:

Microsoft Documentation:
https://docs.microsoft.com/en-us/deployedge/edge-ie-mode

Enterprise Mode Site List Manager:
https://www.microsoft.com/en-us/download/details.aspx?id=49974

Edge Enterprise Landing Page:
https://www.microsoft.com/en-us/edge/business

═══════════════════════════════════════════════════════════════════════

VERSION HISTORY:

Version 1.0-DER (10/15/2025)
- Initial release
- Basic site list configuration
- Support for domains, IPs, and specific pages
- Build: 52414B.DerEiserneReich

═══════════════════════════════════════════════════════════════════════


                      ╔═══════╗
                     ╔╝       ╚╗
                    ╔╝    ⚔    ╚╗
                   ╔╝           ╚╗
                  ║      DER      ║
                  ║   EISERNE     ║
                  ║    REICH      ║
                   ╲             ╱
                    ╲           ╱
                     ╲         ╱
                      ╲       ╱
                       ╲     ╱
                        ╲   ╱
                         ╲ ╱
                          V


═══════════════════════════════════════════════════════════════════════
              End of IE_Mode_xml_README.txt
              Build: 52414B.DerEiserneReich
              Der Eiserne Reich © 2025
═══════════════════════════════════════════════════════════════════════


