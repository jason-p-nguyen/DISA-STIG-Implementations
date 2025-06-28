 <#
.SYNOPSIS
    Ensures the Windows Security event log max size is set to 1024000 (or greater).

.DESCRIPTION
    Implements STIG WN10-AU-000505 by configuring the registry:
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security\MaxSize
    Creates the key if missing and sets the value persistently.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-28
    Last Modified   : 2025-06-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000505

.TESTED ON
    Date(s) Tested  : 2025-06-28
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"
$valueName = "MaxSize"
$desiredValue = 0x000fa000  # Hexadecimal 1024000 decimal

try {
    # Create registry key if it doesn't exist
    if (-not (Test-Path $regPath)) {
        Write-Host "Registry path does not exist. Creating: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Get current value or default to 0 if missing
    $currentValue = 0
    try {
        $currentValue = Get-ItemPropertyValue -Path $regPath -Name $valueName -ErrorAction Stop
    } catch {
        Write-Host "MaxSize value not found, will create it."
    }

    # Check if current value is at least desiredValue
    if ($currentValue -ge $desiredValue) {
        Write-Host "[OK] MaxSize is already set to $currentValue (>= $desiredValue)."
    } else {
        Write-Host "[FINDING] MaxSize is $currentValue, setting to $desiredValue..."
        Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
        Write-Host "[FIXED] MaxSize set to $desiredValue."
    }

    # Confirm the final value
    $finalValue = Get-ItemPropertyValue -Path $regPath -Name $valueName
    Write-Host "`n[RESULT] Final MaxSize value is: $finalValue"

} catch {
    Write-Error "An error occurred: $_"
}
 
