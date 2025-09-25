# 📖 Playbooks

This folder contains **detection and response playbooks** (SOC runbooks).  
Each playbook gets its own subfolder, which includes notes, queries, and (optional) evidence.

---

## 📌 How to Use

1. Create a new subfolder for each playbook using this format:  
   playbook-<technique>-YYYY-MM-DD/

   Example:  
   playbook-phishing-T1566-2025-09-25/

2. Inside the playbook folder, include at minimum:
   - notes.md → the playbook steps, created from templates/detection-playbook-template.md  
   - queries/ (optional) → saved queries (Splunk, ELK, Sigma, etc.)  
   - evidence/ (optional) → sanitized logs, screenshots, or sample detections  

   Example structure:
   03-Playbooks/
   └── playbook-phishing-T1566-2025-09-25/
       ├── notes.md
       ├── queries/
       │   └── phishing-detection.spl
       └── evidence/
           └── screenshot.png

3. What to include in notes.md
   - Scenario & threat description  
   - Data sources (logs, telemetry, tools)  
   - Detection logic (queries/rules)  
   - Investigation steps  
   - Response & containment actions  

4. Sanitize all files before committing:
   - Replace real IPs/hostnames with <placeholders>  
   - Run tools/sanitize.sh  

---

## ✅ Example Playbook Topics
- Phishing (MITRE ATT&CK T1566)  
- SSH brute force detection  
- Ransomware behavior monitoring  
- Persistence detection (registry run keys, scheduled tasks)
