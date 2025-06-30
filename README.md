# 🛡️ DISA STIG Implementations

This repository contains hands-on, step-by-step remediation walkthroughs for selected Windows 10 DISA STIGs. Each case study includes:

- ✅ Initial vulnerability detection via Tenable scan
- 🛠 Manual remediation steps with screenshots
- ⚡ PowerShell scripting for automated fixes
- 🔁 Reversion and revalidation testing
- 📦 Documentation suitable for audits or portfolio use

Each implementation is based on the official DISA STIG benchmarks and tested in a lab VM environment as part of a cybersecurity internship.

---

## 📄 STIG Case Studies (With Documentation)

| STIG ID              | Description                                               | Link                                                             |
|----------------------|-----------------------------------------------------------|------------------------------------------------------------------|
| `WN10-SO-000205`     | Enforce NTLMv2 authentication via registry                | [View Remediation Process](STIG_Remediation_Process_WN10-SO-000205/STIG_Remediation_Process_WN10-SO-000205.md) |
| `WN10-00-000155`     | Disable Windows PowerShell 2.0 (legacy version)           | [View Remediation Process](STIG_Remediation_Process_WN10-SO-000205/STIG_Remediation_Process_WN10-00-000155.md) |

---

## ✅ Full STIG Implementation Progress

**All STIG Implementation Powershell scripts can be found in [this repo](https://github.com/jason-p-nguyen/DISA-STIG-Implementations/tree/main)**

| STIG ID           | Completion Status                                   | Description                                                                 |
|-------------------|-----------------------------------------------------|-----------------------------------------------------------------------------|
| WN10-AU-000500    | ✅ Done                                              | The Application event log size must be configured to 32768 KB or greater.   |
| WN10-AU-000035    | ❌ Abandoned — fix not persistent                   | Audit Account Management - User Account Management failures.               |
| WN10-SO-000010    | ✅ Done                                              | The built-in guest account must be disabled.                                |
| WN10-SO-000015    | ✅ Done                                              | Local accounts with blank passwords must be restricted.                     |
| WN10-AC-000005    | ✅ Done                                              | Account lockout duration must be configured to 15 minutes or greater.       |
| WN10-AC-000010    | ✅ Done                                              | Bad logon attempts must be configured to 3 or less.                         |
| WN10-AC-000015    | ✅ Done                                              | Reset time for bad logon counter must be 15 minutes.                        |
| WN10-AC-000020    | ✅ Done                                              | Password history must be configured to 24 passwords remembered.             |
| WN10-AC-000030    | ✅ Done                                              | Minimum password age must be at least 1 day.                                |
| WN10-AC-000035    | ✅ Done                                              | Passwords must be at least 14 characters.                                   |
| WN10-AC-000040    | ❌ Abandoned — would require unnecessary LGPO setup | Microsoft password complexity filter must be enabled.                       |
| WN10-AU-000505    | ✅ Done                                              | Security event log size must be 1024000 KB or greater.                      |
| WN10-00-000032    | ✅ Done                                              | BitLocker PIN must be 6 digits or more for pre-boot authentication.         |
| WN10-AU-000510    | ✅ Done                                              | System event log size must be 32768 KB or greater.                          |
| WN10-SO-000230    | ✅ Done                                              | Use FIPS-compliant algorithms for encryption and hashing.                   |
| WN10-CC-000185    | ✅ Done                                              | Default autorun behavior must prevent autorun commands.                     |
| WN10-CC-000145    | ✅ Done                                              | Prompt for password on resume from sleep (on battery).                      |
| WN10-SO-000100    | ✅ Done                                              | SMB client must always perform SMB packet signing.                          |
| WN10-CC-000039    | ✅ Done                                              | "Run as different user" must be removed from context menus.                 |
| WN10-CC-000044    | ✅ Done                                              | Internet Connection Sharing must be disabled.                               |
| WN10-CC-000065    | ❌ Skipped — deprecated after Win10 v1803           | Wi-Fi Sense must be disabled.                                               |
| WN10-CC-000005    | ✅ Done                                              | Camera access from lock screen must be disabled.                            |
| WN10-CC-000010    | ✅ Done                                              | Lock screen slide shows must be disabled.                                   |
| WN10-CC-000020    | ✅ Done                                              | IPv6 source routing must be highest protection.                             |
| WN10-CC-000025    | ✅ Done                                              | Prevent IP source routing.                                                  |
| WN10-SO-000205    | ✅ Done                                              | Enforce NTLMv2 only; refuse LM and NTLM authentication.                    |
| WN10-00-000155    | ✅ Done                                              | Disable Windows PowerShell 2.0.                                             |

---

## 🧠 Purpose

This repository was created to:

- Demonstrate proficiency in vulnerability management and remediation
- Practice full-cycle STIG implementation from detection to verification
- Provide a replicable model for future automation or compliance workflows

---

## 🔗 Resources

- [DISA STIG Home](https://public.cyber.mil/stigs/)
- [STIG-A-VIEW](https://stigaview.com/)
- [Tenable Nessus](https://www.tenable.com/products/nessus)

---

## 👤 Author

**Jason Nguyen**  
Cybersecurity Support Engineer (Intern)  
[GitHub: jason-p-nguyen](https://github.com/jason-p-nguyen)
