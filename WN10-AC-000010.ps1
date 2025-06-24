<#
.SYNOPSIS
    Sets the "Account lockout threshold" to 3 invalid login attempts.

.DESCRIPTION
    Ensures STIG WN10-AC-000010 is enforced by configuring the lockout threshold.
    Uses `net accounts` for immediate and persistent effect.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-24
    STIG-ID         : WN10-AC-000010

.TESTED ON
    Date(s) Tested  : 2025-06-24
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

Write-Host "[INFO] Setting lockout threshold to 3 invalid attempts..."
net accounts /lockoutthreshold:3

Write-Host "`n[VERIFY] Current settings:"
net accounts
