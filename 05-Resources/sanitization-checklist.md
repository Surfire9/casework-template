```text
================================================================================
SANITIZATION CHECKLIST
Use this before pushing anything public.
Works for reports, playbooks, screenshots, and sanitized CTF writeups.
================================================================================

WHAT TO REMOVE OR REPLACE
--------------------------------------------------------------------------------
• IPs / hostnames / domains          →  <example.com> , <IP_REDACTED>
• Usernames / emails / IDs           →  <user@example.com> , <ID_REDACTED>
• Credentials / tokens / API keys    →  <SECRET_REDACTED>
• Exact timestamps (optional)        →  “Sept 2025” or “last month”
• Runnable exploit code (PoCs)       →  pseudocode or high-level steps
• Full packet captures / VM images   →  keep private; sanitized excerpts only
• Unique org/customer identifiers    →  redact or generalize

--------------------------------------------------------------------------------
QUICK REPO SCAN (strings & patterns)
--------------------------------------------------------------------------------
# Search for secrets or credentials
git grep -n -I -E "(password|passwd|secret|token|apikey|authorization|bearer|private key|BEGIN RSA|BEGIN OPENSSH|-----BEGIN)" || true

# Private IP ranges
git grep -n -I -E "(^|[^0-9])10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}([^0-9]|$)" || true
git grep -n -I -E "(^|[^0-9])192\.168\.[0-9]{1,3}\.[0-9]{1,3}([^0-9]|$)" || true
git grep -n -I -E "(^|[^0-9])172\.(1[6-9]|2[0-9]|3[0-1])\.[0-9]{1,3}\.[0-9]{1,3}([^0-9]|$)" || true

# Rough pattern for emails and hostnames
git grep -n -I -E "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}" || true
git grep -n -I -E "([a-z0-9-]+\.)+[a-z]{2,}" || true

--------------------------------------------------------------------------------
CHECK WHAT’S BEING IGNORED
--------------------------------------------------------------------------------
git check-ignore -v 04-Projects/** || true
git status

--------------------------------------------------------------------------------
REMOVE METADATA FROM IMAGES
--------------------------------------------------------------------------------
sudo apt update && sudo apt install -y exiftool imagemagick
exiftool -overwrite_original -all= screenshots/*.{png,jpg,jpeg} 2>/dev/null || true
mogrify -strip -resize 1600x1200> screenshots/*.{png,jpg,jpeg} 2>/dev/null || true

--------------------------------------------------------------------------------
TRIM AND SANITIZE LOGS
--------------------------------------------------------------------------------
sed -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/<IP_REDACTED>/g; \
s/\b(root|admin|user[0-9]+)\b/<USER_REDACTED>/g' \
raw.log > logs/example-auth.log

--------------------------------------------------------------------------------
FINAL HUMAN PASS
--------------------------------------------------------------------------------
☑ Re-read each Markdown file before publishing
☑ Placeholders consistent ( <IP_REDACTED> , <USER_REDACTED> )
☑ No runnable PoC or private links
☑ Images/logs sanitized

--------------------------------------------------------------------------------
SAFE PUBLISH FLOW
--------------------------------------------------------------------------------
git pull
git add .
git commit -m "sanitized: publish <topic>"
git push  # add -u origin <branch> if first push

--------------------------------------------------------------------------------
ACCIDENTAL SECRET COMMIT – HISTORY REMEDIATION
--------------------------------------------------------------------------------
Option A – BFG Repo-Cleaner
  java -jar bfg.jar --delete-files 'secrets.txt' .
  java -jar bfg.jar --replace-text banned.txt .
  git reflog expire --expire=now --all
  git gc --prune=now --aggressive
  git push --force

Option B – git filter-repo
  python3 -m pip install --user git-filter-repo
  git filter-repo --path secrets.txt --invert-paths
  git push --force

⚠ After rewriting history, collaborators must re-clone.

--------------------------------------------------------------------------------
PLACEHOLDER GLOSSARY
--------------------------------------------------------------------------------
<IP_REDACTED>
<USER_REDACTED>
<EMAIL_REDACTED>
<DOMAIN_REDACTED>
<SECRET_REDACTED>

--------------------------------------------------------------------------------
PRE-PUSH CHECKLIST
--------------------------------------------------------------------------------
[ ] No IPs / creds / PoCs in public files
[ ] Images EXIF-stripped
[ ] Logs sanitized and minimal
[ ] .gitignore excludes sensitive data
[ ] Final tone and placeholders verified
================================================================================
```
