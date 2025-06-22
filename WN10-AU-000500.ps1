<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB) or 0x00008000.

.DESCRIPTION
  Implements the following registry configuration via PowerShell:

    [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application]
    "MaxSize"=dword:00008001

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-23
    Last Modified   : 2025-06-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 2025-06-23
    Tested By       :  Jason Nguyen
    Systems Tested  :  Microsoft Windows [Version 10.0.19045.5965]
    PowerShell Ver. : PowerShell Ver. : 5.1.19041.5965

.USAGE
     Run this script in an elevated PowerShell session (Run as Administrator)
#>

# Define registry path and value
$regPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$valueName = "MaxSize"
$valueData = 0x8001  # Hexadecimal 00008001 / Decimal 32769

# Ensure the registry key exists
if (-not (Test-Path $regPath)) {
    Write-Host "Creating registry key: $regPath"
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
Write-Host "Setting $valueName to $valueData under $regPath"
Set-ItemProperty -Path $regPath -Name $valueName -Value $valueData -Type DWord

# Confirm value set
$currentValue = Get-ItemPropertyValue -Path $regPath -Name $valueName
Write-Host "Current MaxSize value is: $currentValue (Decimal)"
