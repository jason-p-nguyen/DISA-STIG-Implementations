<#
.SYNOPSIS
    Enables the requirement for security signatures in SMB client communications.

.DESCRIPTION
    Implements STIG control WN10-SO-000100 by configuring the following registry setting:

    Hive: HKEY_LOCAL_MACHINE
    Path: SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters
    Value Name: RequireSecuritySignature
    Value Type: REG_DWORD
    Value Data: 1

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-29
    Last Modified   : 2025-06-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000100

.TESTED ON
    Date(s) Tested  : 2025-06-29
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
$valueName = "RequireSecuritySignature"
$desiredValue = 1

try {
    # Ensure registry path exists
    if (-not (Test-Path $regPath)) {
        Write-Host "[INFO] Creating registry path: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Read current value if it exists
    $currentValue = $null
    try {
        $currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction Stop | Select-Object -ExpandProperty $valueName
    } catch {
        Write-Host "[INFO] '$valueName' not found. It will be created." -ForegroundColor Yellow
    }

    # Set value if different
    if ($currentValue -ne $desiredValue) {
        Write-Host "[FIXING] Setting '$valueName' to $desiredValue..."
        Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
        Write-Host "[SUCCESS] '$valueName' set to $desiredValue." -ForegroundColor Green
    } else {
        Write-Host "[OK] '$valueName' is already correctly set to $desiredValue." -ForegroundColor Green
    }

    # Confirm final value
    $finalValue = Get-ItemPropertyValue -Path $regPath -Name $valueName
    Write-Host "`n[RESULT] Final value of '$valueName': $finalValue"

} catch {
    Write-Error "An error occurred while applying WN10-SO-000100: $_"
}
