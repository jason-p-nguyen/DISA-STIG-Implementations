<#
.SYNOPSIS
    Disables Windows PowerShell 2.0 and its engine to prevent downgrade attacks.

.DESCRIPTION
    Implements STIG control WN10-00-000155 by disabling:
    - MicrosoftWindowsPowerShellV2Root
    - MicrosoftWindowsPowerShellV2

    This mitigates downgrade attacks that bypass PowerShell 5.x logging features.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-30
    Last Modified   : 2025-06-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000155

.TESTED ON
    Date(s) Tested  : 2025-06-30
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

# List of optional features to disable
$featuresToDisable = @(
    "MicrosoftWindowsPowerShellV2Root",
    "MicrosoftWindowsPowerShellV2"
)

foreach ($feature in $featuresToDisable) {
    $state = Get-WindowsOptionalFeature -Online -FeatureName $feature

    if ($state.State -eq "Enabled") {
        Write-Host "[INFO] Disabling feature: $feature ..."
        Disable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart -ErrorAction SilentlyContinue

        $newState = Get-WindowsOptionalFeature -Online -FeatureName $feature
        if ($newState.State -ne "Enabled") {
            Write-Host "[SUCCESS] Feature '$feature' disabled successfully." -ForegroundColor Green
        } else {
            Write-Host "[WARNING] Failed to disable '$feature'. Check manually." -ForegroundColor Yellow
        }
    } else {
        Write-Host "[OK] Feature '$feature' is already disabled." -ForegroundColor Cyan
    }
}

Write-Host "`n[NOTE] A reboot may be required for the change to fully take effect." -ForegroundColor Yellow
