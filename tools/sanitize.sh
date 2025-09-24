#!/usr/bin/env bash
# Sanitize staged content before publishing (Linux/WSL).
# - Scans only staged text files
# - Looks for secrets, private IPs, emails/domains
# - Strips metadata from screenshots

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YEL='\033[1;33m'; NC='\033[0m'

echo -e "${YEL}==> Checking dependencies...${NC}"
need() { command -v "$1" >/dev/null 2>&1 || { echo -e "${RED}Missing: $1${NC}"; MISSING=1; }; }
MISSING=0
need git
need exiftool || true
need mogrify  || true
[ "${MISSING}" -eq 0 ] || echo -e "${YEL}Install missing tools: sudo apt update && sudo apt install -y exiftool imagemagick${NC}"

echo -e "${YEL}==> Gathering staged files...${NC}"
STAGED=$(git diff --cached --name-only \
  | grep -Ev '^(05-Resources|templates)/' \
  | grep -Ev '\.(png|jpg|jpeg|gif|zip|pcap|pcapng|key|pem)$' || true)

if [ -z "$STAGED" ]; then
  echo -e "${GREEN}No staged files to scan.${NC}"
else
  echo -e "${YEL}==> Scanning staged files for sensitive patterns...${NC}"

  echo -e "${YEL}[secrets]${NC}"
  echo "$STAGED" | xargs -r grep -n -I -E "(password|passwd|secret|token|apikey|authorization|bearer|PRIVATE KEY|BEGIN RSA|BEGIN OPENSSH|-----BEGIN)" \
    || echo "  (none found)"

  echo -e "${YEL}[private IPs]${NC}"
  echo "$STAGED" | xargs -r grep -n -I -E "(^|[^0-9])10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}([^0-9]|$)" || echo "  (none found)"
  echo "$STAGED" | xargs -r grep -n -I -E "(^|[^0-9])192\.168\.[0-9]{1,3}\.[0-9]{1,3}([^0-9]|$)"      || echo "  (none found)"
  echo "$STAGED" | xargs -r grep -n -I -E "(^|[^0-9])172\.(1[6-9]|2[0-9]|3[0-1])\.[0-9]{1,3}\.[0-9]{1,3}([^0-9]|$)" || echo "  (none found)"

  echo -e "${YEL}[emails/domains]${NC}"
  echo "$STAGED" | xargs -r grep -n -I -E "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}" || echo "  (none found)"
  echo "$STAGED" | xargs -r grep -n -I -E "([a-z0-9-]+\.)+[a-z]{2,}"                        || echo "  (none found)"
fi

# Strip metadata from screenshots (regardless of staged state, safe to run always)
if command -v exiftool >/dev/null 2>&1; then
  echo -e "${YEL}==> Stripping image metadata (PNG/JPG) in ./screenshots folders...${NC}"
  find . -type d -name screenshots -print0 | while IFS= read -r -d '' dir; do
    find "$dir" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) -print0 \
      | xargs -0 -r exiftool -overwrite_original -all= >/dev/null 2>&1 || true
    if command -v mogrify >/dev/null 2>&1; then
      find "$dir" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) -size +2M -print0 \
        | xargs -0 -r mogrify -strip -resize 1600x1200\> || true
    fi
  done
fi

echo -e "${GREEN}==> Sanitize scan complete. Review any matches above before pushing.${NC}"
echo -e "${YEL}Tip:${NC} Replace sensitive values with placeholders like <lab-ip>, <user>, <host-1>."
