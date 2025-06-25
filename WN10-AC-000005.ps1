<#
.SYNOPSIS
    Sets the "Account lockout duration" to 15 minutes.

.DESCRIPTION
    Implements the STIG control WN10-AC-000005 by configuring account lockout duration.
    Uses `net accounts` for immediate and persistent effect.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-24
    Last Modified   : 2025-06-24
    Version         : 2.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 2025-06-24
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

Write-Host "[INFO] Setting account lockout duration to 15 minutes..."
net accounts /lockoutduration:15

Write-Host "`n[VERIFY] Current settings:"
net accounts
