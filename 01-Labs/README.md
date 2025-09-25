# 🧪 Labs

This folder contains **lab notes** from training platforms, courses, or exercises.  
Each lab gets its own subfolder, which includes notes and (optional) screenshots.

---

## 📌 How to Use

1. Create a new subfolder for each lab using this format:  
   lab-<topic>-YYYY-MM-DD/

   Example:  
   lab-active-recon-2025-09-25/

2. Inside the lab folder, include at least:
   - notes.md → your lab notes, created from templates/lab-notes-template.md
   - screenshots/ (optional) → redacted screenshots if they add value

   Example structure:
   01-Labs/
   └── lab-active-recon-2025-09-25/
       ├── notes.md
       └── screenshots/
           ├── nmap-scan.png
           └── ad-enum.png

3. Keep notes concise:
   - Objective (what the lab is about)  
   - Key commands / steps (reusable later)  
   - Takeaways (what you learned or want to revisit)  

4. Sanitize all files before committing:
   - Replace real IPs/hostnames with <placeholders>  
   - Run tools/sanitize.sh  

---

## ✅ Example Lab Ideas

- Nmap scanning basics  
- Wireshark traffic analysis  
- Linux privilege escalation practice  
- Password cracking with Hashcat
