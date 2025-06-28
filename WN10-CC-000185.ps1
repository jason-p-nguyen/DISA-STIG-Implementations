<#
.SYNOPSIS
    Disables Autorun to prevent automatic execution from removable media.

.DESCRIPTION
    Implements STIG control WN10-CC-000185 by configuring the following registry value:
    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoAutorun = 1

    This setting ensures Autorun is disabled system-wide, reducing the risk of malware propagation through USB or other media.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-28
    Last Modified   : 2025-06-28
    Version         : 1.1
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000185

.TESTED ON
    Date(s) Tested  : 2025-06-28
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$valueName = "NoAutorun"
$desiredValue = 1

try {
    # Ensure the registry path exists
    if (-not (Test-Path $regPath)) {
        Write-Host "[INFO] Creating registry path: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Try to get current value, if it exists
    $currentValue = $null
    try {
        $currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction Stop | Select-Object -ExpandProperty $valueName
    } catch {
        Write-Host "[INFO] 'NoAutorun' value not found. It will be created." -ForegroundColor Yellow
    }

    # Apply fix if needed
    if ($currentValue -ne $desiredValue) {
        Write-Host "[FIXING] Setting 'NoAutorun' to $desiredValue..."
        Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
        Write-Host "[SUCCESS] 'NoAutorun' has been set to $desiredValue." -ForegroundColor Green
    } else {
        Write-Host "[OK] 'NoAutorun' is already set to $desiredValue." -ForegroundColor Green
    }

    # Confirm result
    $finalValue = Get-ItemProperty -Path $regPath -Name $valueName | Select-Object -ExpandProperty $valueName
    Write-Host "`n[RESULT] Final value of 'NoAutorun': $finalValue"

} catch {
    Write-Error "An error occurred while applying WN10-CC-000185: $_"
}
