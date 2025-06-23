<#
.SYNOPSIS
    Ensures that the "LimitBlankPasswordUse" registry value is set to 1 to restrict blank password use as required by STIG WN10-SO-000015.

.DESCRIPTION
    This script verifies and configures the following registry setting:

    Hive: HKEY_LOCAL_MACHINE
    Path: SYSTEM\CurrentControlSet\Control\Lsa\
    Value Name: LimitBlankPasswordUse
    Value Type: REG_DWORD
    Value Data: 1

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-23
    Last Modified   : 2025-06-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000015

.TESTED ON
    Date(s) Tested  : 2025-06-23
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName = "LimitBlankPasswordUse"
$desiredValue = 1

try {
    # Check if the registry key exists
    if (-not (Test-Path $regPath)) {
        Write-Host "Registry path does not exist. Creating path: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Read current value if it exists
    $currentValue = $null
    if (Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue) {
        $currentValue = (Get-ItemProperty -Path $regPath -Name $valueName).$valueName
    }

    if ($currentValue -eq $desiredValue) {
        Write-Host "[OK] Registry value '$valueName' is correctly set to $desiredValue." -ForegroundColor Green
    } else {
        Write-Warning "[FINDING] Registry value '$valueName' is not set to $desiredValue or does not exist."
        Write-Host "Setting registry value '$valueName' to $desiredValue..."
        Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
        Write-Host "[FIXED] Registry value '$valueName' set to $desiredValue." -ForegroundColor Green
    }

    # Confirm the final value
    $finalValue = (Get-ItemProperty -Path $regPath -Name $valueName).$valueName
    Write-Host "`n[RESULT] Final value of '$valueName' is: $finalValue"

} catch {
    Write-Error "An error occurred: $_"
}
