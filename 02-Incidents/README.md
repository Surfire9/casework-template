# 🚨 Incidents

This folder contains **incident reports and investigations**.  
Each incident gets its own subfolder so all notes, evidence, and artifacts stay together and are easy to sanitize or export.

---

## 📌 How to Use

1. Create a new subfolder for each incident using this format:  
   incident-<name>-YYYY-MM-DD/

   Example:  
   incident-ssh-bruteforce-2025-09-25/

2. Inside the incident folder, include at minimum:
   - report.md → the incident report (use templates/incident-template.md as a starting point)  
   - evidence/ → sanitized logs, screenshots, small artifacts (keep raw captures out of public repos)  
   - timeline.md (optional) → short timeline of events (detection → investigation → containment)

   Example structure:
   02-Incidents/
   └── incident-ssh-bruteforce-2025-09-25/
       ├── report.md
       ├── timeline.md
       └── evidence/
           ├── auth-log-sample.log
           └── screenshots/
               └── alert-screenshot.png

3. What to include in report.md (short checklist)
   - Summary: 1–2 sentences (what happened, severity)  
   - Detection source: which system/alert produced the signal  
   - IOCs (sanitized): <lab-ip>, <user>, <domain.example>  
   - Investigation steps & findings  
   - Containment & remediation actions taken  
   - Recommendations / lessons learned

4. Sanitization rules (MANDATORY before any public push)
   - Replace real IPs / hostnames / emails / credentials with placeholders.  
   - Do not include raw .pcap or unredacted screenshots in public repos. Keep raw evidence in a private store.  
   - Run tools/sanitize.sh on staged files before committing to scan for obvious secrets and strip image metadata.

5. Commit & branch tips
   - Work on a feature branch per incident:  
     git checkout -b feat/incident-ssh-bruteforce-2025-09-25
   - Commit message example:  
     docs: add incident report - ssh brute force (lab)
   - Once validated and sanitized, merge to main or keep private if sensitive.

---

## ✅ Example Incident Types
- SSH brute force detection and response  
- Phishing campaign analysis (user click → credential exposure)  
- Malware execution & host isolation investigation  
- Lateral movement / privilege escalation case study

---

Keeping incidents in per-incident folders makes it easy to audit, export, or sanitize a single case for a portfolio while preserving raw artifacts privately.
