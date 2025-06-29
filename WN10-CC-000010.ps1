 <#
.SYNOPSIS
    Disables lock screen slideshow on Windows systems.

.DESCRIPTION
    Implements STIG control WN10-CC-000010 by setting the registry value:
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization\NoLockScreenSlideshow = 1

    This ensures slideshow images are not displayed on the lock screen, reducing visual data exposure.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-29
    Last Modified   : 2025-06-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000010

.TESTED ON
    Date(s) Tested  : 2025-06-29
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$valueName = "NoLockScreenSlideshow"
$desiredValue = 1

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
        Write-Host "[SUCCESS] Lock screen slideshow is disabled." -ForegroundColor Green
    } else {
        Write-Host "[FAILURE] Value was not set correctly." -ForegroundColor Red
    }

} catch {
    Write-Error "An error occurred while applying WN10-CC-000010: $_"
}
 
