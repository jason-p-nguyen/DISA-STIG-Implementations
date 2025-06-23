<#
.SYNOPSIS
    Sets the Account Lockout Duration to 15 minutes if not already 15 or 0.

.DESCRIPTION
    Uses secedit to apply the correct Account Lockout Duration (minimum 15 minutes as per STIG WN10-AC-000005).
    Updates the local security database so that changes persist and are reflected in gpedit.msc and `net accounts`.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-24
    Last Modified   : 2025-06-24
    Version         : 1.1
    STIG-ID         : WN10-AC-000005

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

# Temp paths
$cfgFile = "$env:TEMP\secpol-export.inf"
$infFile = "$env:TEMP\secpol-modified.inf"

# Step 1: Export current security policy
secedit /export /cfg $cfgFile /areas SECURITYPOLICY | Out-Null

# Step 2: Read contents and extract LockoutDuration
$lines = Get-Content $cfgFile
$durationLine = $lines | Where-Object { $_ -match '^LockoutDuration\s*=\s*\d+' }

if ($durationLine) {
    $currentDuration = [int]($durationLine -replace '[^\d]', '')
    Write-Host "[INFO] Current Lockout Duration: $currentDuration minutes"

    if (($currentDuration -lt 15) -and ($currentDuration -ne 0)) {
        Write-Warning "[FINDING] Lockout duration is less than 15 and not 0. Fixing..."

        # Step 3: Replace the line with desired value (15)
        $modifiedLines = $lines | ForEach-Object {
            if ($_ -match '^LockoutDuration\s*=') {
                "LockoutDuration = 15"
            } else {
                $_
            }
        }

        # Step 4: Save the modified INF and apply it
        $modifiedLines | Out-File -FilePath $infFile -Encoding ASCII
        secedit /configure /db secedit.sdb /cfg $infFile /areas SECURITYPOLICY | Out-Null
        Write-Host "[FIXED] Lockout duration set to 15 minutes."
    } else {
        Write-Host "[OK] Lockout duration is already compliant."
    }
} else {
    Write-Warning "LockoutDuration line not found. Adding it manually."

    $lines += "[System Access]"
    $lines += "LockoutDuration = 15"
    $lines | Out-File -FilePath $infFile -Encoding ASCII
    secedit /configure /db secedit.sdb /cfg $infFile /areas SECURITYPOLICY | Out-Null
    Write-Host "[FIXED] Lockout duration was missing; added and set to 15 minutes."
}

# Step 5: Confirm with net accounts
Write-Host "`n[RESULT] Verifying with 'net accounts':"
net accounts

# Cleanup
Remove-Item $cfgFile, $infFile -ErrorAction SilentlyContinue
