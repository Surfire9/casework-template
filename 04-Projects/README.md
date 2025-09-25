# 🔬 Projects

This folder is for **larger casework projects** that combine labs, incidents, and playbooks into broader investigations or tools.  
Each project should be documented in its own subfolder.

---

## 📌 How to Use

1. Create a new subfolder for each project using this format:  
   project-<name>-YYYY-MM-DD/

   Example:  
   project-siem-dashboard-2025-09-25/

2. Inside the project folder, include at minimum:
   - README.md → overview of the project  
   - notes.md → technical notes and steps taken  
   - screenshots/ (optional) → redacted visuals  
   - configs/ (optional) → config snippets (sanitized)  

   Example structure:
   04-Projects/
   └── project-siem-dashboard-2025-09-25/
       ├── README.md
       ├── notes.md
       ├── configs/
       │   └── dashboard.json
       └── screenshots/
           └── dashboard-view.png

3. What to include in README.md
   - Project objective  
   - Tools used  
   - Key findings or outcomes  
   - Future improvements  

---

## ✅ Example Project Ideas
- SIEM dashboard build (Splunk, Wazuh, ELK)  
- Threat hunting case study  
- Forensic analysis of a malware sample  
- Automated log analysis tool
