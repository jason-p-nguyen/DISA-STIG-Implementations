# ✅ STIG Remediation Process: WN10-00-000155

**STIG ID:** WN10-00-000155

**Status:** ✅ Completed

## 🧾 Personal Implementation Notes

This document outlines the exact step-by-step process I followed to manually and programmatically remediate STIG **WN10-00-000155** on a Windows 10 virtual machine. Each stage includes screenshots, testing steps, and a PowerShell script I created based on STIG guidance.

---

## 🔍 Initial Assessment

* Identified **WN10-00-000155** as failed in the initial Tenable STIG scan.

* Confirmed the baseline scan used correct DISA STIG benchmark (Windows 10 v3r1).

* **Description:**
  `Windows PowerShell 2.0 must be disabled on the system.`
  PowerShell 2.0 is outdated and lacks modern security features. It should be disabled to reduce attack surface.

* 📸 Screenshot: Initial failed scan
  ![Initial Scan Results](screenshots/1_Initial_Scan_WN10-00-000155.png)

---

## 🛠 Manual Remediation

* Researched manual fix using:

  * [STIG-A-VIEW WN10-00-000155](https://stigaview.com/products/win10/v3r1/WN10-00-000155/)
    ![Stig-a-view](screenshots/2_Stig-a-view.png)

* Manual Fix Steps:

  1. Open **Windows Features** (optionalfeatures.exe)
  2. Locate **Windows PowerShell 2.0**
  3. Uncheck the feature (turn off)
  4. Click **OK** and allow Windows to apply changes
  5. Restart the system if prompted

* 📸 Screenshot: Windows PowerShell 2.0 turned off
  ![Disable PowerShell 2.0](screenshots/3_Disabled_PowerShell2_Feature.png)

* Restarted VM and ran `gpupdate /force`

* 📸 Screenshot: Scan results after manual remediation — **Passed**
  ![Manual Fix Scan Passed](screenshots/4_Manual_Fix_Scan_Results.png)

---

## 🔁 Revert & Recheck

* Reversed the setting to simulate noncompliance:

  * Re-enabled **Windows PowerShell 2.0** in Windows Features
  * Applied and completed change

* 📸 Screenshot: Windows PowerShell 2.0 turned back on
  ![Re-enabled PowerShell 2.0](screenshots/5_Revert_Enable_PowerShell2.png)

* Restarted VM and ran `gpupdate /force`

* 📸 Screenshot: Scan result after revert — **Failed**
  ![Scan Failed After Revert](screenshots/6_Revert_Failed_Scan_Results.png)

---

## ⚡ PowerShell Remediation

* PowerShell fix was provided in STIG-A-VIEW, but I created my own version for practice:

```powershell
<#
.SYNOPSIS
    Disables Windows PowerShell 2.0 feature as required by STIG WN10-00-000155.

.DESCRIPTION
    Removes the legacy PowerShell 2.0 feature from Windows 10 to reduce security risks.

.NOTES
    Author          : Jason Nguyen  
    GitHub          : github.com/jason-p-nguyen  
    Date Created    : 2025-06-30  
    STIG-ID         : WN10-00-000155

.USAGE
    Run this script in an elevated PowerShell session (Run as Administrator)
#>

$featureName = "MicrosoftWindowsPowerShellV2Root"

try {
    Write-Host "[INFO] Disabling Windows PowerShell 2.0 feature..." -ForegroundColor Cyan
    Disable-WindowsOptionalFeature -Online -FeatureName $featureName -NoRestart -ErrorAction Stop
    Write-Host "[SUCCESS] PowerShell 2.0 disabled successfully." -ForegroundColor Green
} catch {
    Write-Error "Failed to disable PowerShell 2.0: $_"
}
```

* 📸 Screenshot: PowerShell script executed
  ![Script Execution](screenshots/7_PS_Script_Execution.png)

* 📸 Screenshot: Manual check — PowerShell 2.0 turned off in Windows Features
  ![Feature Confirmation](screenshots/8_Feature_Confirmed_Off.png)

* Restarted VM and ran `gpupdate /force`

* 📸 Screenshot: Scan result after PowerShell remediation — **Passed**
  ![Scan Passed](screenshots/9_PowerShell_Fix_Scan_Result.png)

---

## 📦 Documentation for GitHub

* Markdown documentation completed
* Uploaded:

  * Screenshots of manual, revert, and PowerShell remediation
  * PowerShell script with full header and inline notes
* Added STIG link:
  [DISA STIG Viewer - WN10-00-000155](https://stigaview.com/products/win10/v3r1/WN10-00-000155/)
* GitHub README updated
* ✅ Marked complete in internship tracker

---

## 🧠 Reflection

* Learned how to manage optional features via both GUI and PowerShell.
* This STIG was straightforward but emphasized the importance of removing deprecated tools.
* Practiced validating a STIG fix through full remediation lifecycle.
* Reinforced comfort with script creation, documentation, and manual feature toggling.
* ✅ Successfully completed and documented for reuse.
