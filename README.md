# 🛡️ DISA STIG Implementations

This repository contains hands-on, step-by-step remediation walkthroughs for selected Windows 10 DISA STIGs. Each case study includes:

- ✅ Initial vulnerability detection via Tenable scan
- 🛠 Manual remediation steps with screenshots
- ⚡ PowerShell scripting for automated fixes
- 🔁 Reversion and revalidation testing
- 📦 Documentation suitable for audits or portfolio use

Each implementation is based on the official DISA STIG benchmarks and tested in a lab VM environment as part of a cybersecurity internship.

---

## 📄 STIG Case Studies

| STIG ID              | Description                                               | Link                                                             |
|----------------------|-----------------------------------------------------------|------------------------------------------------------------------|
| `WN10-SO-000205`     | Enforce NTLMv2 authentication via registry                | [View Remediation Process](STIG_Remediation_Process_WN10-SO-000205/STIG_Remediation_Process_WN10-SO-000205.md) |
| `WN10-00-000155`     | Disable Windows PowerShell 2.0 (legacy version)           | [View Remediation Process](STIG_Remediation_Process_WN10-SO-000205/STIG_Remediation_Process_WN10-00-000155.md) |

---

## 🧠 Purpose

This repository was created to:

- Demonstrate proficiency in vulnerability management and remediation
- Practice full-cycle STIG implementation from detection to verification
- Provide a replicable model for future automation or compliance workflows

---

## 📌 Notes

- Screenshots and PowerShell scripts are included within each STIG folder
- Scripts follow a structured, commented style for clarity and reuse
- Tested on Windows 10 [Version 10.0.19045.2965]

---

## 🔗 Resources

- [DISA STIG Home](https://public.cyber.mil/stigs/)
- [STIG-A-VIEW](https://stigaview.com/)
- [Tenable Nessus](https://www.tenable.com/products/nessus)

---

## 🧑‍💻 Author

**Jason Nguyen**  
Cybersecurity Support Engineer (Intern)  
[GitHub: jason-p-nguyen](https://github.com/jason-p-nguyen)

