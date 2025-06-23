 <#
.SYNOPSIS
    Disables the built-in Guest account via PowerShell

.DESCRIPTION
    Verifies and sets the local security policy: 
    "Accounts: Guest account status" = Disabled

    This is done by disabling the local 'Guest' user account using PowerShell.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-23
    Last Modified   : 2025-06-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000010

.TESTED ON
    Date(s) Tesated  : 2025-06-23
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows [Version 10.0.19045.5965]
    PowerShell Ver. : 5.1.19041.5965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

# Define target account
$accountName = "Guest"

try {
    # Get the Guest account
    $guestAccount = Get-LocalUser -Name $accountName -ErrorAction Stop

    if ($guestAccount.Enabled) {
        Write-Host "[FINDING] Guest account is ENABLED. Disabling now..." -ForegroundColor Yellow
        Disable-LocalUser -Name $accountName
        Write-Host "[FIXED] Guest account has been DISABLED." -ForegroundColor Green
    } else {
        Write-Host "[OK] Guest account is already DISABLED." -ForegroundColor Green
    }

    # Confirm the final state
    $finalState = (Get-LocalUser -Name $accountName).Enabled
    Write-Host "`n[RESULT] Guest account enabled: $finalState"

} catch {
    Write-Warning "Guest account not found or script failed: $_"
}
