<#
.SYNOPSIS
    Enables FIPS-compliant algorithms for encryption, hashing, and signing.

.DESCRIPTION
    Implements STIG control WN10-SO-000230 by setting the following registry value:
    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy\Enabled = 1

    This enforces the use of FIPS-compliant cryptographic algorithms and disables weaker protocols.

.WARNING
    Enabling this setting may break compatibility with older systems or applications.
    Clients with this setting enabled will NOT be able to communicate via digitally encrypted or signed protocols 
    with servers that do not support FIPS-compliant algorithms.
    
    Both the browser and the web server must be configured to use TLS (not SSL), otherwise secure connections may fail.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-28
    Last Modified   : 2025-06-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000230

.TESTED ON
    Date(s) Tested  : 2025-06-28
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy"
$valueName = "Enabled"
$desiredValue = 1

try {
    # Ensure registry path exists
    if (-not (Test-Path $regPath)) {
        Write-Host "[INFO] Creating registry path: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Get current value if it exists
    $currentValue = 0
    try {
        $currentValue = Get-ItemPropertyValue -Path $regPath -Name $valueName -ErrorAction Stop
    } catch {
        Write-Host "[INFO] FIPS 'Enabled' value not found. Creating it."
    }

    # Apply fix if needed
    if ($currentValue -eq $desiredValue) {
        Write-Host "[OK] FIPS algorithm policy is already enabled." -ForegroundColor Green
    } else {
        Write-Host "[FINDING] FIPS algorithm policy is disabled or misconfigured." -ForegroundColor Yellow
        Write-Host "[FIX] Enabling FIPS-compliant algorithm enforcement..."
        Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
        Write-Host "[SUCCESS] FIPS algorithm policy has been enabled." -ForegroundColor Green
    }

    # Final confirmation
    $finalValue = Get-ItemPropertyValue -Path $regPath -Name $valueName
    Write-Host "`n[RESULT] Final registry value for FIPS algorithm policy: $finalValue"

} catch {
    Write-Error "An error occurred while applying WN10-SO-000230: $_"
}
