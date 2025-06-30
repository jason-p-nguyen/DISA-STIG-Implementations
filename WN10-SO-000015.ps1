<#
.SYNOPSIS
    Sets "LimitBlankPasswordUse" to 1 to restrict blank password use (STIG: WN10-SO-000015).

.DESCRIPTION
    Configures the registry to enforce a security policy that disallows network logons using blank passwords.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-24
    STIG-ID         : WN10-SO-000015

.TESTED ON
    Date(s) Tested  : 2025-06-24
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath     = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName   = "LimitBlankPasswordUse"
$desiredValue = 1

# Ensure the path exists
New-Item -Path $regPath -Force -ErrorAction SilentlyContinue | Out-Null

# Set the value
Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord

# Output result
$finalValue = (Get-ItemProperty -Path $regPath -Name $valueName).$valueName
Write-Host "[RESULT] '$valueName' is now set to: $finalValue (Expected: $desiredValue)" -ForegroundColor Green