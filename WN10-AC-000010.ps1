 <#
.SYNOPSIS
    Sets the Account Lockout Threshold to 3 invalid logon attempts to meet STIG WN10-AC-000010.

.DESCRIPTION
    Uses secedit to export, modify, and re-import local security policy.
    Ensures that the lockout threshold is 3, which is the maximum allowed under STIG.

.NOTES
    Author          : Jason Nguyen / ChatGPT
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-24
    Last Modified   : 2025-06-24
    Version         : 1.0
    STIG-ID         : WN10-AC-000010

.TESTED ON
    Date(s) Tested  : 2025-06-24
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

# Paths for export and import
$exportPath = "$env:TEMP\secpol-export.inf"
$importPath = "$env:TEMP\secpol-threshold-fixed.inf"

# Step 1: Export current security policy
secedit /export /cfg $exportPath /areas SECURITYPOLICY | Out-Null

# Step 2: Read current threshold
$lines = Get-Content $exportPath
$thresholdLine = $lines | Where-Object { $_ -match '^LockoutBadCount\s*=\s*\d+' }

if ($thresholdLine) {
    $currentValue = [int]($thresholdLine -replace '[^\d]', '')
    Write-Host "[INFO] Current Lockout Threshold: $currentValue attempts"

    if (($currentValue -gt 3) -or ($currentValue -eq 0)) {
        Write-Warning "[FINDING] Threshold is too high (>$currentValue). Fixing to 3..."

        # Step 3: Modify line
        $fixedLines = $lines | ForEach-Object {
            if ($_ -match '^LockoutBadCount\s*=') {
                "LockoutBadCount = 3"
            } else {
                $_
            }
        }

        # Step 4: Save and apply modified INF
        $fixedLines | Out-File -FilePath $importPath -Encoding ASCII
        secedit /configure /db secedit.sdb /cfg $importPath /areas SECURITYPOLICY | Out-Null

        Write-Host "[FIXED] Lockout threshold successfully set to 3 attempts."
    } else {
        Write-Host "[OK] Lockout threshold is already compliant." -ForegroundColor Green
    }
} else {
    Write-Warning "LockoutBadCount setting not found. Adding it manually."

    $lines += "[System Access]"
    $lines += "LockoutBadCount = 3"
    $lines | Out-File -FilePath $importPath -Encoding ASCII
    secedit /configure /db secedit.sdb /cfg $importPath /areas SECURITYPOLICY | Out-Null
    Write-Host "[FIXED] Lockout threshold added and set to 3 attempts."
}

# Step 5: Confirm with net accounts
Write-Host "`n[RESULT] Verifying with 'net accounts':"
net accounts

# Cleanup
Remove-Item $exportPath, $importPath -ErrorAction SilentlyContinue
 
