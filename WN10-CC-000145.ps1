 <#
.SYNOPSIS
    Authentication must always be required when accessing a system. This setting ensures the user is prompted for a password on resume from sleep (on battery).

.DESCRIPTION
    Implements STIG control WN10-CC-000145 by setting the following registry value:

    Hive: HKEY_LOCAL_MACHINE
    Path: SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51
    Name: DCSettingIndex
    Value: 1 (Disabled)

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-29
    Last Modified   : 2025-06-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000145

.TESTED ON
    Date(s) Tested  : 2025-06-29
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"
$valueName = "DCSettingIndex"
$desiredValue = 1

try {
    # Ensure the registry path exists
    if (-not (Test-Path $regPath)) {
        Write-Host "[INFO] Creating registry path: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Attempt to read the current value
    $currentValue = $null
    try {
        $currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction Stop | Select-Object -ExpandProperty $valueName
    } catch {
        Write-Host "[INFO] '$valueName' not found. It will be created." -ForegroundColor Yellow
    }

    # Set the value if it does not match the desired setting
    if ($currentValue -ne $desiredValue) {
        Write-Host "[FIXING] Setting '$valueName' to $desiredValue..."
        Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
        Write-Host "[SUCCESS] '$valueName' set to $desiredValue." -ForegroundColor Green
    } else {
        Write-Host "[OK] '$valueName' is already correctly set to $desiredValue." -ForegroundColor Green
    }

    # Confirm result
    $finalValue = Get-ItemProperty -Path $regPath -Name $valueName | Select-Object -ExpandProperty $valueName
    Write-Host "`n[RESULT] Final value of '$valueName': $finalValue"

} catch {
    Write-Error "An error occurred while applying WN10-CC-000145: $_"
}
 
