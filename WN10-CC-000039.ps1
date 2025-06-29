 <#
.SYNOPSIS
    Applies SuppressionPolicy registry value to file execution classes as required by STIG WN10-CC-000039.

.DESCRIPTION
    Implements STIG control WN10-CC-000039 by setting the following registry value across multiple registry paths:

    Value Name : SuppressionPolicy  
    Value Type : REG_DWORD  
    Value Data : 4096 (0x00001000)

    Registry Paths:
        - HKEY_LOCAL_MACHINE\SOFTWARE\Classes\batfile\shell\runasuser\
        - HKEY_LOCAL_MACHINE\SOFTWARE\Classes\cmdfile\shell\runasuser\
        - HKEY_LOCAL_MACHINE\SOFTWARE\Classes\exefile\shell\runasuser\
        - HKEY_LOCAL_MACHINE\SOFTWARE\Classes\mscfile\shell\runasuser\

.NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-29
    Last Modified   : 2025-06-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000039

.TESTED ON
    Date(s) Tested  : 2025-06-29
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

# Define registry paths
$paths = @(
    "HKLM:\SOFTWARE\Classes\batfile\shell\runasuser",
    "HKLM:\SOFTWARE\Classes\cmdfile\shell\runasuser",
    "HKLM:\SOFTWARE\Classes\exefile\shell\runasuser",
    "HKLM:\SOFTWARE\Classes\mscfile\shell\runasuser"
)

$valueName = "SuppressionPolicy"
$desiredValue = 4096

foreach ($path in $paths) {
    try {
        # Create the key if it doesn't exist
        if (-not (Test-Path $path)) {
            Write-Host "[INFO] Creating missing key: $path"
            New-Item -Path $path -Force | Out-Null
        }

        # Set the registry value
        Set-ItemProperty -Path $path -Name $valueName -Value $desiredValue -Type DWord -Force
        Write-Host "[SUCCESS] Set $valueName to $desiredValue at $path" -ForegroundColor Green
    } catch {
        Write-Error ("An error occurred at {0}: {1}" -f $path, $_)
    }
}
 
