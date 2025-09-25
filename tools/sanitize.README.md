# 🧹 sanitize.sh

An **interactive sanitizer script** for Git repositories.  
It scans **staged files** for sensitive patterns (IPs, emails, passwords) and lets you decide how to handle each match:

- Shows the full line with context.  
- Suggests safe replacements (`<lab-ip>`, `<redacted-email>`, `<redacted-password>`).  
- Lets you type a custom replacement.  
- Gives you the option to skip individual matches.  
- Creates `.bak` backups before edits.  
- Restages modified files automatically.  

This ensures only sanitized content makes it into your commits — perfect for public/portfolio repos.

---

## 🚀 Usage

1. Stage the files you want to commit:
   git add 01-Labs/lab-active-recon-2025-09-25/notes.md

2. Run the sanitizer:
   tools/sanitize.sh

3. For each match, you’ll see output like:
   ----- context (01-Labs/lab-active-recon-2025-09-25/notes.md:42) -----
   41: Some surrounding line
   42: Target line with 192.168.1.10
   43: Another surrounding line
   ---------------------------------
   Found match: 192.168.1.10
   Suggested replacement: <lab-ip>
   Options:
     1) Replace with suggestion (<lab-ip>)
     2) Enter custom replacement
     3) Skip this occurrence
   Choice [1/2/3]:

4. Review staged changes:
   git diff --staged

5. Commit once satisfied:
   git commit -m "chore: sanitize and add lab notes"

---

## 🔍 Patterns Detected

- Private IPv4 ranges → 10.*, 192.168.*, 172.16–172.31.*  
- Email addresses → e.g. user@example.com  
- Password-like assignments → strings with password=..., pwd: ..., etc.  

---

## 🛡️ Safety Features

- Interactive control: You decide per match whether to replace, skip, or enter a custom string.  
- Backups: Each edited file gets a .bak copy.  
- Scoped: Runs only on staged text files (no binaries, no templates).  

---

## ⚠️ Best Practices

- Always review staged diffs (git diff --staged) before committing.  
- Keep raw .bak files private — don’t push them to public repos.  
- For large batch fixes, use a branch first, then merge after verifying.  
- Extend patterns as needed (API keys, secrets, etc.).  

---

## 🔮 Future Enhancements

- Add --all mode to scan all tracked files.  
- Add --non-interactive flag to auto-redact with defaults.  
- Add custom regex rules via config file.  

---

**sanitize.sh** = your last line of defense against leaking sensitive data into public repos 🚫🔑
