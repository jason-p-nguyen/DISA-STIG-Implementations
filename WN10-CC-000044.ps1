 <#
.SYNOPSIS
    Disables the Shared Access UI in Network Connections.

.DESCRIPTION
    Implements the STIG control WN10-CC-000044 by setting the 
    "NC_ShowSharedAccessUI" registry value to 0 under:

    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Network Connections

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-29
    Last Modified   : 2025-06-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000044

.TESTED ON
    Date(s) Tested  : 2025-06-29
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath      = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"
$valueName    = "NC_ShowSharedAccessUI"
$desiredValue = 0

try {
    # Ensure registry path exists
    if (-not (Test-Path $regPath)) {
        Write-Host "[INFO] Creating registry path: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Set the registry value
    Write-Host "[INFO] Setting $valueName to $desiredValue..."
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord

    # Verify the value
    $actualValue = Get-ItemPropertyValue -Path $regPath -Name $valueName -ErrorAction Stop
    if ($actualValue -eq $desiredValue) {
        Write-Host "[SUCCESS] $valueName is correctly set to $desiredValue." -ForegroundColor Green
    } else {
        Write-Warning "[WARNING] $valueName is not set correctly. Found: $actualValue"
    }
} catch {
    Write-Error "An error occurred while applying WN10-CC-000044: $_"
}
 
