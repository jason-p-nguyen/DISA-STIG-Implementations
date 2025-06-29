 <#
.SYNOPSIS
    Disables IPv4 source routing by setting DisableIPSourceRouting to 2.

.DESCRIPTION
    Implements STIG control WN10-CC-000025 by setting the registry value:
    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\DisableIPSourceRouting = 2

    This setting helps protect against spoofing and man-in-the-middle attacks by disallowing source-routed packets.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-30
    Last Modified   : 2025-06-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000025

.TESTED ON
    Date(s) Tested  : 2025-06-30
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$valueName = "DisableIPSourceRouting"
$desiredValue = 2

try {
    # Ensure the registry path exists
    if (-not (Test-Path $regPath)) {
        Write-Host "[INFO] Registry path not found. Creating: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Set the registry value
    Write-Host "[INFO] Setting '$valueName' to '$desiredValue' under $regPath..."
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord

    # Verify the change
    $currentValue = Get-ItemPropertyValue -Path $regPath -Name $valueName -ErrorAction Stop
    if ($currentValue -eq $desiredValue) {
        Write-Host "[SUCCESS] IPv4 source routing is disabled (value = 2)." -ForegroundColor Green
    } else {
        Write-Host "[FAILURE] Value was not set correctly." -ForegroundColor Red
    }

} catch {
    Write-Error "An error occurred while applying WN10-CC-000025: $_"
}
 
