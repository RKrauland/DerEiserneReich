<#
.SYNOPSIS
    IE Mode Configuration Script for Microsoft Edge

.DESCRIPTION
    Configures Edge IE mode and downloads site list from SharePoint or creates locally
    
.NOTES
    Version: 1.0-DER
    Build: 1.0.52414B.DerEiserneReich
    
.LINK
    https://github.com/YourUsername/IE-Mode-Configuration
#>

# Build: 1.0.52414B.DerEiserneReich
$BuildSignature = "DER-FN-2025"

# Configuration
# REPLACE WITH YOUR SHAREPOINT URL OR LEAVE BLANK TO CREATE LOCAL FILE
$sharePointXmlUrl = ""  # Example: "https://yourcompany.sharepoint.com/sites/IT/Shared%20Documents/IE_Mode.xml"
$localXmlPath = "C:\Admin\EdgeIEMode\sitelist.xml"
$edgePolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"

# Create directory if it doesn't exist
$localDir = Split-Path $localXmlPath -Parent
if (!(Test-Path $localDir)) {
    New-Item -Path $localDir -ItemType Directory -Force | Out-Null
    Write-Output "Created directory: $localDir"
}

# Download XML from SharePoint or create locally
if ($sharePointXmlUrl -and $sharePointXmlUrl -ne "") {
    try {
        # Download from SharePoint
        Invoke-WebRequest -Uri $sharePointXmlUrl -OutFile $localXmlPath -UseBasicParsing -ErrorAction Stop
        Write-Output "Successfully downloaded XML from SharePoint to $localXmlPath"
    } catch {
        Write-Output "Warning: Could not download from SharePoint. Error: $($_.Exception.Message)"
        Write-Output "Creating local XML file as fallback..."
        $useLocalFallback = $true
    }
} else {
    Write-Output "No SharePoint URL provided. Creating local XML file..."
    $useLocalFallback = $true
}

# Create local XML if needed
if ($useLocalFallback -or !$sharePointXmlUrl -or $sharePointXmlUrl -eq "") {
    $fallbackXml = @"
<?xml version="1.0" encoding="UTF-8"?>
<site-list version="1">
    <created-by>
        <tool>IE Mode Configuration Tool</tool>
        <version>1.0-DER</version>
        <date-created>$(Get-Date -Format "MM/dd/yyyy")</date-created>
        <build>1.0.52414B.DerEiserneReich</build>
    </created-by>
    <!-- Add your sites below using this format: -->
    <!-- 
    <site url="example.com">
        <open-in>IE11</open-in>
    </site>
    -->
    
    <!-- Example entries (replace with your actual sites): -->
    <site url="intranet.company.com">
        <open-in>IE11</open-in>
    </site>
    <site url="legacy-app.company.com">
        <open-in>IE11</open-in>
    </site>
    <site url="192.168.1.100">
        <open-in>IE11</open-in>
    </site>
</site-list>
"@
    $fallbackXml | Out-File -FilePath $localXmlPath -Encoding UTF8 -Force
    Write-Output "Created local XML file at $localXmlPath"
}

# Configure Edge IE mode registry settings
if (!(Test-Path $edgePolicyPath)) {
    New-Item -Path $edgePolicyPath -Force | Out-Null
    Write-Output "Created Edge policy registry path"
}

# Enable IE mode
Set-ItemProperty -Path $edgePolicyPath -Name "InternetExplorerIntegrationLevel" -Value 1 -Type DWord -Force
Write-Output "Set InternetExplorerIntegrationLevel = 1"

# Enable IE mode testing (allows users to test IE mode via edge://settings)
Set-ItemProperty -Path $edgePolicyPath -Name "InternetExplorerIntegrationTestingAllowed" -Value 1 -Type DWord -Force
Write-Output "Set InternetExplorerIntegrationTestingAllowed = 1"

# Set site list location
Set-ItemProperty -Path $edgePolicyPath -Name "InternetExplorerIntegrationSiteList" -Value $localXmlPath -Type String -Force
Write-Output "Set InternetExplorerIntegrationSiteList = $localXmlPath"

Write-Output "`nIE Mode configuration completed successfully"
Write-Output "Users must restart Microsoft Edge for changes to take effect"
Write-Output "`nTo test IE mode:"
Write-Output "1. Open Edge and navigate to: edge://compat/enterprise"
Write-Output "2. Verify site list location is configured"
Write-Output "3. Navigate to a configured site"
Write-Output "4. Look for IE icon in the address bar"

# Exit with success code
exit 0