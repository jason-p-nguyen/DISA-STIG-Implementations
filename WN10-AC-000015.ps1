<#
.SYNOPSIS
    Sets "Reset account lockout counter after" to 15 minutes (STIG: WN10-AC-000015)

.DESCRIPTION
    Uses the `net accounts` command to set the Lockout Observation Window.
    This method is effective immediately and persists across reboots.

.NOTES
    Author          : Jason Nguyen / ChatGPT
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-24
    Last Modified   : 2025-06-24
    Version         : 2.0
    STIG-ID         : WN10-AC-000015

.TESTED ON
    Date(s) Tested  : 2025-06-24
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

# Set the lockout observation window to 15 minutes
Write-Host "[INFO] Setting lockout observation window to 15 minutes using 'net accounts'..."
net accounts /lockoutwindow:15

# Confirm change
Write-Host "`n[VERIFY] Current settings:"
net accounts
