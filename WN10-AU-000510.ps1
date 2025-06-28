<#
.SYNOPSIS
    Ensures the System event log maximum size is set to at least 32768 KB.

.DESCRIPTION
    Implements STIG control WN10-AU-000510 by configuring the following registry value:
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\System\MaxSize = 32768 (or greater)
    Creates the registry path if it doesn't exist and enforces the value persistently.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-28
    Last Modified   : 2025-06-28
    Version         : 1.0
    STIG-ID         : WN10-AU-000510

.TESTED ON
    Date(s) Tested  : 2025-06-28
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"
$valueName = "MaxSize"
$desiredValue = 0x00008000  # 32768 in decimal

try {
    # Ensure the registry path exists
    if (-not (Test-Path $regPath)) {
        Write-Host "[INFO] Creating registry path: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Retrieve current value (if exists)
    $currentValue = 0
    try {
        $currentValue = Get-ItemPropertyValue -Path $regPath -Name $valueName -ErrorAction Stop
    } catch {
        Write-Host "[INFO] MaxSize not currently set, creating value."
    }

    # Compare and set if needed
    if ($currentValue -ge $desiredValue) {
        Write-Host "[OK] MaxSize is already set to $currentValue (>= $desiredValue)." -ForegroundColor Green
    } else {
        Write-Host "[FINDING] MaxSize is $currentValue. Updating to $desiredValue..." -ForegroundColor Yellow
        Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
        Write-Host "[FIXED] MaxSize has been set to $desiredValue KB." -ForegroundColor Green
    }

    # Confirm result
    $finalValue = Get-ItemPropertyValue -Path $regPath -Name $valueName
    Write-Host "`n[RESULT] Final MaxSize value is: $finalValue KB"

} catch {
    Write-Error "An error occurred while applying WN10-AU-000510: $_"
}
