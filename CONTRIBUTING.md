# 📝 Contributing Guidelines (Casework Template)

These guidelines help keep all casework repos created from this template **consistent, professional, and recruiter-ready**.

---

## 📂 File Naming Conventions

- **Lab Notes**:  
  lab-<topic>-YYYY-MM-DD.md  
  Example: lab-nmap-basics-2025-09-24.md

- **Incidents**:  
  incident-<name>-YYYY-MM-DD.md  
  Example: incident-ssh-bruteforce-2025-09-24.md

- **Playbooks**:  
  playbook-<technique>-YYYY-MM-DD.md  
  Example: playbook-phishing-T1566-2025-09-24.md

- **Projects**:  
  project-<name>-YYYY-MM-DD.md  
  Example: project-siem-dashboard-2025-09-24.md

- **Resources**:  
  resource-<topic>.md  
  Example: resource-git-cheatsheet.md

---

## 📜 Commit Message Style

Follow Conventional Commits (https://www.conventionalcommits.org/):

- feat: → new feature or playbook  
- fix: → corrections (typos, errors, improvements)  
- docs: → documentation only (README, notes)  
- chore: → repo maintenance (folder scaffolding, .gitignore updates)  
- refactor: → reorganizing content without changing meaning  

**Examples:**  
- feat: add detection playbook for phishing (T1566)  
- docs: add incident report template to 02-Incidents  
- chore: update .gitignore for pcap files  

---

## 🧹 Sanitization Rules

Before committing/pushing public repos:  
1. Replace sensitive values with placeholders:  
   - <lab-ip>  
   - <user>  
   - <domain.example>  
2. Remove or sanitize screenshots with IPs, usernames, or unique identifiers.  
3. Run the sanitizer script:  
   tools/sanitize.sh  
4. Confirm .gitignore excludes:  
   - .pcap, .pcapng, .key, .pem  
   - captures/, snapshots/, logs/  
   - Any personal files  

---

## ✅ Workflow Checklist

- [ ] Create new files from the provided templates.  
- [ ] Use consistent naming.  
- [ ] Write clear, Conventional Commit messages.  
- [ ] Run tools/sanitize.sh before committing.  
- [ ] Push changes and update README.md highlights if it’s a portfolio-worthy artifact.  

---

Following these rules keeps your casework repos consistent, professional, and easy to review by recruiters or teammates.
