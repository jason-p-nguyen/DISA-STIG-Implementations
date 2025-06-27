<#
.SYNOPSIS
    Sets the minimum password length to 14 characters.

.DESCRIPTION
    Implements the STIG control WN10-AC-000035 by configuring the password policy
    to require passwords to be at least 14 characters long.
    Uses `net accounts` for immediate and persistent effect.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-27
    Last Modified   : 2025-06-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000035

.TESTED ON
    Date(s) Tested  : 2025-06-27
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

Write-Host "[INFO] Setting minimum password length to 14 characters..."
net accounts /minpwlen:14

Write-Host "`n[VERIFY] Current settings:"
net accounts
