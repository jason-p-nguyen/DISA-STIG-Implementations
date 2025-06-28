<#
.SYNOPSIS
    Ensures BitLocker PIN minimum length is set to at least 6 characters.

.DESCRIPTION
    Implements STIG WN10-00-000032 by configuring the following registry value:
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE\MinimumPIN = 6 (or greater)
    Creates the key if it doesn't exist and sets the value persistently.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-28
    Last Modified   : 2025-06-28
    Version         : 1.0
    STIG-ID         : WN10-00-000032

.TESTED ON
    Date(s) Tested  : 2025-06-28
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"
$valueName = "MinimumPIN"
$desiredValue = 6

try {
    # Create registry path if missing
    if (-not (Test-Path $regPath)) {
        Write-Host "[INFO] Registry path not found. Creating: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Retrieve current value
    $currentValue = 0
    try {
        $currentValue = Get-ItemPropertyValue -Path $regPath -Name $valueName -ErrorAction Stop
    } catch {
        Write-Host "[INFO] $valueName not found, will be created."
    }

    # Evaluate and enforce setting
    if ($currentValue -ge $desiredValue) {
        Write-Host "[OK] $valueName is already set to $currentValue (>= $desiredValue)." -ForegroundColor Green
    } else {
        Write-Host "[FINDING] $valueName is $currentValue. Updating to $desiredValue..." -ForegroundColor Yellow
        Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
        Write-Host "[FIXED] $valueName has been set to $desiredValue." -ForegroundColor Green
    }

    # Final verification
    $finalValue = Get-ItemPropertyValue -Path $regPath -Name $valueName
    Write-Host "`n[RESULT] Final value of '$valueName': $finalValue"

} catch {
    Write-Error "An error occurred while setting the BitLocker PIN policy: $_"
}
