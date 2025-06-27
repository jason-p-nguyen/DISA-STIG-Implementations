<#
.SYNOPSIS
    Enforces password complexity and supporting password policies using net accounts and secedit.

.DESCRIPTION
    Implements STIG WN10-AC-000040 ("Password must meet complexity requirements") using both 
    local security policy and account policy tools to ensure Tenable and similar compliance 
    scanners recognize the setting.

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-25
    Last Modified   : 2025-06-25
    Version         : 3.0
    STIG-ID         : WN10-AC-000040

.TESTED ON
    Date(s) Tested  : 2025-06-25
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator).
#>

# Step 1: Set supporting password policies (helps Tenable detect the environment is hardened)
Write-Host "[INFO] Applying baseline password policy via 'net accounts'..."
net accounts /minpwlen:14 /maxpwage:42 /minpwage:1 /uniquepw:24

# Step 2: Create .INF for secedit to enforce password complexity
$infPath = "$env:TEMP\complexity_policy.inf"
$infContent = @"
[Unicode]
Unicode=yes
[System Access]
PasswordComplexity = 1
"@

$infContent | Out-File -FilePath $infPath -Encoding Unicode -Force

# Step 3: Apply the policy via secedit
Write-Host "[INFO] Applying password complexity setting with secedit..."
secedit.exe /configure /db secedit.sdb /cfg $infPath /areas SECURITYPOLICY | Out-Null

# Step 4: Cleanup
Remove-Item $infPath -Force

# Step 5: Verification
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$regValue = Get-ItemPropertyValue -Path $regPath -Name "PasswordComplexity" -ErrorAction SilentlyContinue

if ($regValue -eq 1) {
    Write-Host "[SUCCESS] Password complexity is ENABLED and supporting password policies are set." -ForegroundColor Green
} else {
    Write-Host "[FAILURE] Password complexity is NOT properly enabled." -ForegroundColor Red
}
