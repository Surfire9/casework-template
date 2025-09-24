#Sanitization Checklist
Use this before pushing anything to public repos. Works for reports, playbooks, screenshots and 
sanitized CTF writeups

#What to remove or replace

IPs / hostnames / domains → replace with <lab-ip>, <host-1>, <example.com>
Usernames / emails / IDs → <user>, <analyst>, <acct-1>
Credentials / secrets / tokens / API keys → <redacted>
Exact timestamps (optional) → “Sept 2025” / relative windows
Runnable exploit code (PoCs) → pseudocode or high-level steps
Full packet captures / VM snapshots → keep private; if needed, include small sanitized excerpts only
Any unique org/customer identifiers

1) Quick repo scan (strings & patterns)
# Check for obvious secrets/keywords
git grep -n -I -E "(password|passwd|secret|token|apikey|authorization|bearer|private key|BEGIN RSA|BEGIN OPENSSH|-----BEGIN)" || true

# Private IP ranges commonly used in labs
git grep -n -I -E "(^|[^0-9])10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}([^0-9]|$)" || true
git grep -n -I -E "(^|[^0-9])192\.168\.[0-9]{1,3}\.[0-9]{1,3}([^0-9]|$)"   || true
git grep -n -I -E "(^|[^0-9])172\.(1[6-9]|2[0-9]|3[0-1])\.[0-9]{1,3}\.[0-9]{1,3}([^0-9]|$)" || true

# Emails / hostnames (rough patterns)
git grep -n -I -E "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}" || true
git grep -n -I -E "([a-z0-9-]+\.)+[a-z]{2,}" || true

2) Check whats being ignored (avoid accidental staging) if needed adjust .gitignore

# See if something inside is ignored
git check-ignore -v 04-Projects/** || true

# Preview what will actually be committed
git status

3) Redact and strip metadata from images

# Install once (Debian/Ubuntu)
sudo apt update && sudo apt install -y exiftool imagemagick

# Remove metadata from all PNG/JPG in this folder (non-destructive copies)
exiftool -overwrite_original -all= screenshots/*.{png,jpg,jpeg} 2>/dev/null || true

# (Optional) Re-encode to drop metadata and shrink
mogrify -strip -resize 1600x1200\> screenshots/*.{png,jpg,jpeg} 2>/dev/null || true

4) Trim logs to the minimum needed

# Create small, sanitized samples (logs/example-auth.log) instead of full logs
Replace IPs/users with placeholders

sed -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/<lab-ip>/g; s/\b(root|admin|user[0-9]+)\b/<user>/g' raw.log > logs/example-auth.log

5) Final human pass 

#Re-read each Markdown file that's going public 
#Confirm all placeholders look consistent <lab-ip>, <user>, <host-1>
#Ensure no runnable PoC or private links are included

6) Publish flow (safe routine)

git pull                     # stay in sync
git add .
git commit -m "sanitized: publish <artifact>"

# first push of repo/branch uses -u, otherwise plain push
git push

7) **Accidental commit of secret (History remediation)

Option A) - BFG Repo-Cleaner (Simple)
# Install BFG (requires Java), then:
# Example: remove a specific file from all history
java -jar bfg.jar --delete-files 'secrets.txt' .

# Or remove anything matching patterns
java -jar bfg.jar --replace-text banned.txt .

# After BFG:
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force

Option B) - git filter-repo (Powerful)
# Install (once):
python3 -m pip install --user git-filter-repo

# Remove a file everywhere in history:
git filter-repo --path secrets.txt --invert-paths
git push --force

#After a history rewrite, collaborators must re-clone or reset to the new history

8) Quick placeholder glossary (use consistently)

<lab-ip>         <host-1>         <user>           <analyst>
<acct-1>         <domain.example> <timestamp>      <redacted>

10) Minimal pre-push checklist
	No IPs/creds/PoCs in public files
	Images redacted + EXIF removed
	Logs sampled + sanitized
	.gitignore excludes big/sensitive stuff
	Final skim for placeholders and tone
