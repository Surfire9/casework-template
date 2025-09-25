# 🛡️ Casework Template

This repository is a **starter template** for documenting cybersecurity casework.  
It provides a clean, professional structure you can reuse for labs, incidents, playbooks, projects, and resources.

Use this template to build a **portfolio-ready repo** that demonstrates hands-on skills in detection, incident response, and blue-team practices.

---

## 📂 Repository Structure

01-Labs/        → Lab notes (each lab has its own subfolder with notes.md + screenshots/)  
02-Incidents/   → Incident reports (each incident has its own subfolder with report.md + evidence/)  
03-Playbooks/   → Detection & response playbooks (each playbook in its own subfolder with notes.md + queries/)  
04-Projects/    → Larger projects or case studies (each in its own subfolder with README.md + notes.md)  
05-Resources/   → References, cheatsheets, and study notes  
tools/          → Helper scripts (sanitize.sh, redact.sh, etc.)  
templates/      → Centralized templates for labs, incidents, playbooks, and resources  

---

## 🚀 How to Use This Template

1. On GitHub, click **Use this template** to create a new repository.  
2. Clone your new repo locally:
   git clone git@github.com:YOUR_USERNAME/NEW-REPO.git  
   cd NEW-REPO
3. For each new lab, incident, playbook, or project:  
   - Copy the right template from /templates/ into a new subfolder.  
   - Rename the subfolder using the naming conventions in CONTRIBUTING.md.  
   - Fill in notes, add sanitized evidence/screenshots, and commit.  
4. Always run tools/sanitize.sh before pushing to public repos.  

---

## 🔮 Planned Features / Roadmap (Template)

- [ ] Add pre-commit hook to run tools/sanitize.sh  
- [ ] Add initial detection playbooks (phishing, brute force)  
- [ ] Add one sample incident report  
- [ ] Document lab setup (Wazuh / ELK / Security Onion)  
- [ ] Expand certification prep notes (Security+, CySA+)  

---

## 🌟 Portfolio Highlights (example usage)

When you start using this template, add links here to your **best work** so recruiters can find it quickly:

- Incident Report — SSH Brute Force → 02-Incidents/incident-ssh-bruteforce-YYYY-MM-DD/report.md  
- Detection Playbook — Phishing → 03-Playbooks/playbook-phishing-T1566-YYYY-MM-DD/notes.md  
- SIEM Dashboard Project → 04-Projects/project-siem-dashboard-YYYY-MM-DD/  
- Git Workflow & Sanitization Tools → 05-Resources/resource-git-cheatsheet.md  

---

## ✅ Notes

- Keep all notes and reports **sanitized**: replace real IPs/domains/emails with <placeholders>.  
- Follow the Contributing Guidelines (CONTRIBUTING.md) for naming and commit style.  
- Use .gitignore to avoid pushing sensitive data (logs, pcaps, secrets).  

---

## 📜 License

This template is provided for educational and portfolio purposes.  
You are free to adapt it to your own casework repositories.
