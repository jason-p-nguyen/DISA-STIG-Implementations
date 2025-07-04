# ✅ STIG Remediation Process: WN10-SO-000205


**STIG ID:** WN10-SO-000205

**Status:** ✅ Completed

## 🧾 Personal Implementation Notes

This document outlines the exact step-by-step process I followed to manually and programmatically remediate STIG **WN10-SO-000205** on a Windows 10 virtual machine. Each stage includes screenshots, testing steps, and a PowerShell script I created to automate the fix.

---

## 🔍 Initial Assessment

* Identified **WN10-SO-000205** as failed in the initial Tenable STIG scan.

* Confirmed the baseline scan used correct DISA STIG benchmark (Windows 10 v3r1).

* **Description:**
  `The system must be configured to require NTLMv2 authentication.`
  This setting strengthens authentication and protects against certain replay and credential forwarding attacks.

* 📸 Screenshot: Initial failed scan result
![Initial Scan Results](screenshots/1_Initial_Scan_Results.png)

---

## 🛠 Manual Remediation

* Researched manual fix using:

  * STIG documentation via [STIG-A-VIEW WN10-SO-000205](https://stigaview.com/products/win10/v3r1/WN10-SO-000205/)
![Initial Scan Results](screenshots/2_Stig-a-view.png)
  
  * Registry path:

    ```
    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\
    Value Name: LmCompatibilityLevel
    Value Type: REG_DWORD
    Value: 5
    ```
* Edited the registry manually to set `LmCompatibilityLevel = 5`
* Ran `gpupdate /force`
* 📸 Screenshot: Registry fix applied
![Initial Scan Results](screenshots/3_Manual_Registry_Fix_applied.png)

* 📸 Screenshot: Scan results after manual remediation — **Passed**
![Initial Scan Results](screenshots/4_Manual_fix_scan_results.png)

> 📝 Noticed that after remediation, parts of the scan report appeared in Japanese. UI language was already set to English. Not resolved, but noted for case documentation.

---

## 🔁 Revert & Recheck

* Deleted the registry key to simulate a noncompliant state
* Ran `gpupdate /force`
* 📸 Screenshot: Fix deletion
![Initial Scan Results](screenshots/5_Revert_Manual_Fix.png)

* 📸 Screenshot: Scan results after reverting — **Failed**
![Initial Scan Results](screenshots/6_Reverted_Manual_Fix_scan_results.png)
---

## ⚡ PowerShell Remediation

* Developed [PowerShell script](WN10-SO-000205.ps1) to enforce registry setting via ChatGPT:

  ```powershell
  <#
  .SYNOPSIS
    Sets the LmCompatibilityLevel to 5 to enforce the use of NTLMv2 authentication.

  .DESCRIPTION
    Implements STIG control WN10-SO-000205 by configuring the following registry key:
    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\LmCompatibilityLevel = 5

    Level 5 sends NTLMv2 responses only and refuses LM and NTLM authentication, which increases security.

  .NOTES
    Author          : Jason Nguyen
    GitHub          : github.com/jason-p-nguyen
    Date Created    : 2025-06-30
    Last Modified   : 2025-06-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000205

  .TESTED ON
    Date(s) Tested  : 2025-06-30
    Tested By       : Jason Nguyen
    Systems Tested  : Microsoft Windows 10 [Version 10.0.19045.2965]
    PowerShell Ver. : 5.1.19041.2965

  .USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
  #>

  $regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
  $valueName = "LmCompatibilityLevel"
  $desiredValue = 5

  try {
    # Ensure the registry path exists
    if (-not (Test-Path $regPath)) {
        Write-Host "[INFO] Registry path not found. Creating: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    # Set the registry value
    Write-Host "[INFO] Setting '$valueName' to '$desiredValue' under $regPath..."
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord

    # Verify the change
    $currentValue = Get-ItemPropertyValue -Path $regPath -Name $valueName -ErrorAction Stop
    if ($currentValue -eq $desiredValue) {
        Write-Host "[SUCCESS] LmCompatibilityLevel is correctly set to 5 (NTLMv2 only)." -ForegroundColor Green
    } else {
        Write-Host "[FAILURE] Value was not set correctly." -ForegroundColor Red
    }

  } catch {
    Write-Error "An error occurred while applying WN10-SO-000205: $_"
  }
 
  ```
  
* See completed Powershell Script here: [WN10-SO-000205.ps1](WN10-SO-000205.ps1)

* Ran the script on VM

* 📸 Screenshot: Script execution
![Initial Scan Results](screenshots/7_Powershell_script_execution.png)

* Ran `gpupdate /force`

* 📸 Screenshot: Scan results after PowerShell fix — **Passed**
![Initial Scan Results](screenshots/8_Powershell_fix_scan_results.png)
---

## 📦 Documentation for GitHub

* STIG write-up completed using markdown
* Added PowerShell script with full headers and inline comments
* Uploaded screenshots:

  * Initial failure
  * Manual registry edit
  * Manual success
  * Revert & failure
  * PowerShell remediation
  * Final scan result
* Link to STIG documentation:

  * [DISA STIG Viewer - WN10-SO-000205](https://stigaview.com/products/win10/v3r1/WN10-SO-000205/)
* GitHub README updated
* ✅ Marked complete in internship tracker

---

## 🧠 Reflection

* Small but curious issue: parts of the Tenable report showed up in Japanese even though system UI was English. Might be related to region or scan engine settings.
* This STIG reinforced comfort with registry edits and PowerShell scripting.
* Practiced full remediation lifecycle: identify, fix manually, revert, re-fix with automation.
* ✅ Successfully documented and validated automated remediation — ready for reuse across environments.
