 <#
.SYNOPSIS
    Sets the LmCompatibilityLevel to 5 to enforce the use of NTLMv2 authentication.

.DESCRIPTION
    Implements STIG control WN10-SO-000205 by configuring the following registry key:
    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\LmCompatibilityLevel = 5

    Level 5 sends NTLMv2 responses only and refuses LM and NTLM authentication, which increases security.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-30
    Last Modified   : 2025-06-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000205

.TESTED ON
    Date(s) Tested  : 2025-06-30
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName = "LmCompatibilityLevel"
$desiredValue = 5

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
        Write-Host "[SUCCESS] LmCompatibilityLevel is correctly set to 5 (NTLMv2 only)." -ForegroundColor Green
    } else {
        Write-Host "[FAILURE] Value was not set correctly." -ForegroundColor Red
    }

} catch {
    Write-Error "An error occurred while applying WN10-SO-000205: $_"
}
 
