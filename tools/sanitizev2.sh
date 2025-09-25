#!/usr/bin/env bash
# tools/sanitizev2.sh  (v2.3)
# Interactive sanitizer for STAGED files with full-line context.
# - POSIX ERE; prompts from /dev/tty; TAB-delimited match parsing
# - Re-stages modified files; creates .bak backups

set -euo pipefail

# Collect staged files (added/modified/renamed/copied, not deleted)
FILES=$(git diff --cached --name-only --diff-filter=ACMRTUXB || true)
[ -n "${FILES}" ] || { echo "No staged files to scan."; exit 0; }

# Patterns (POSIX ERE)
IPV4_PRIVATE='(10\.[0-9]{1,3}(\.[0-9]{1,3}){2}|192\.168\.[0-9]{1,3}\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[0-1])\.[0-9]{1,3}\.[0-9]{1,3})'
EMAIL='[[:alnum:]._%+-]+@[[:alnum:].-]+\.[[:alpha:]]{2,}'
PASS_TOKEN='(password|pwd|pass|pw)[[:space:]:=]+"?[^"[:space:]]+"?'   # grep -i for case-insensitive

show_context () {
  local file="$1" line="$2"
  local start=$(( line > 1 ? line-1 : 1 ))
  local end=$(( line+1 ))
  echo "----- context ($file:$line) -----"
  nl -ba -w2 -s": " "$file" | sed -n "${start},${end}p"
  echo "---------------------------------"
}

# Replace first occurrence of $3 on line $2 with $4
replace_one_in_line () {
  local file="$1" line="$2" match="$3" repl="$4"
  # Escape replacement for sed (/, &, \)
  local safe_repl
  safe_repl=$(printf '%s' "$repl" | sed 's/[&/\]/\\&/g')
  # Use '|' as sed delimiter to avoid escaping dots in $match (match is literal)
  # Replace only first occurrence on that line
  sed -i "${line}s|$(printf '%s' "$match" | sed 's/[|&/\]/\\&/g')|$safe_repl|" "$file"
}

for file in $FILES; do
  [ -f "$file" ] || continue
  file "$file" | grep -qi 'text' || continue

  echo
  echo "Scanning: $file"
  cp -f "$file" "$file.bak"
  MODIFIED=0

  # Build a unified match list as:  <lineno><TAB><match>
  # We ensure TAB separation by replacing only the first ':' after the line number.
  matches=$(
    {
      grep -En -o -E "$IPV4_PRIVATE" "$file" || true
      grep -En -o -E "$EMAIL" "$file" || true
      grep -En -o -i -E "$PASS_TOKEN" "$file" || true
    } | awk 'NF' | sort -n -t: -k1,1 \
      | sed 's/^\([0-9][0-9]*\):/\1\t/'    # first ':' -> TAB (safe even if match contains ':')
  )

  if [ -z "${matches}" ]; then
    echo "  No sensitive patterns found."
    rm -f "$file.bak"
    continue
  fi

  # Iterate (<lineno>\t<match>)
  while IFS=$'\t' read -r lineno match; do
    [ -n "${lineno:-}" ] || continue
    [ -n "${match:-}" ] || continue

    show_context "$file" "$lineno"
    echo "Found match: $match"

    # Suggestion by type
    suggestion="<placeholder>"
    if echo "$match" | grep -Eq '^[0-9]{1,3}(\.[0-9]{1,3}){3}$'; then
      suggestion="<lab-ip>"
    elif echo "$match" | grep -Eq '@'; then
      suggestion="<redacted-email>"
    elif echo "$match" | grep -Eqi '^(password|pwd|pass|pw)'; then
      suggestion="<redacted-password>"
    fi

    echo "Choose an action:"
    echo "  1) Replace with suggestion ($suggestion)"
    echo "  2) Enter custom replacement"
    echo "  3) Skip this occurrence"
    read -rp "Choice [1/2/3, Enter=1]: " choice < /dev/tty

    case "$choice" in
      ""|1)
        replacement="$suggestion"
        echo "  Using suggestion: $suggestion"
        ;;
      2)
        read -rp "Enter replacement: " replacement < /dev/tty
        ;;
      3)
        echo "  Skipped."
        continue
        ;;
      *)
        echo "  Invalid choice, skipped."
        continue
        ;;
    esac

    replace_one_in_line "$file" "$lineno" "$match" "$replacement"
    MODIFIED=1
    echo "  Replaced '$match' -> '$replacement'"

  done <<< "$matches"

  if [ "$MODIFIED" -eq 1 ]; then
    git add "$file"
    echo "  Changes applied and re-staged. Backup: $file.bak"
  else
    rm -f "$file.bak"
    echo "  No changes applied."
  fi
done

echo
echo "Interactive sanitization complete. Review with: git diff --staged"
