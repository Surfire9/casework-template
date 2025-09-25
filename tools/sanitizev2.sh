#!/usr/bin/env bash
# tools/sanitize.sh
# Interactive sanitizer for staged files.
# - Scans ONLY staged text files
# - Shows full-line context around each match
# - Lets you choose a suggested replacement or enter your own
# - Creates .bak backups and re-stages modified files
#
# Usage:
#   tools/sanitize.sh

set -euo pipefail

# Collect staged files (added/modified/renamed/copied/etc.)
FILES=$(git diff --cached --name-only --diff-filter=ACMRTUXB || true)

if [ -z "${FILES}" ]; then
  echo "No staged files to scan."
  exit 0
fi

# Patterns (private IPv4 ranges, emails, simple password assignments)
IPV4_PRIVATE='(10\.(?:[0-9]{1,3}\.){2}[0-9]{1,3}|192\.168\.(?:[0-9]{1,3}\.)[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[0-1])\.(?:[0-9]{1,3}\.)[0-9]{1,3})'
EMAIL='[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}'
PASS='(?i)(password|pwd|pass|pw)[[:space:]:=]+"?([^"[:space:]]+)"?'

# Show previous/current/next line for context (safe on file bounds)
show_context () {
  local file="$1" line="$2"
  local start=$(( line > 1 ? line-1 : 1 ))
  local end=$(( line+1 ))
  echo "----- context ($file:$line) -----"
  nl -ba -w2 -s": " "$file" | sed -n "${start},${end}p"
  echo "---------------------------------"
}

# Replace ONE occurrence in a specific line, safely (handles special chars)
# Args: file line match replacement
replace_one_in_line () {
  local file="$1" line="$2" match="$3" repl="$4"
  perl -0777 -e '
    use strict; use warnings;
    my ($f,$n,$m,$r)=@ARGV;
    open my $IN, "<", $f or die $!;
    my @L = <$IN>;
    close $IN;
    # Replace first occurrence on the target line only
    $L[$n-1] =~ s/\Q$m\E/$r/ or 1;
    open my $OUT, ">", $f or die $!;
    print $OUT @L;
    close $OUT;
  ' "$file" "$line" "$match" "$repl"
}

# For each staged file…
for file in $FILES; do
  [ -f "$file" ] || continue
  # Skip binary files
  if ! file "$file" | grep -qi 'text'; then
    continue
  fi

  echo
  echo "Scanning: $file"
  # Backup before any edits
  cp -f "$file" "$file.bak"

  # Grep out matches (each occurrence): "lineno:match"
  # Using -o prints each match separately so we can prompt per-match
  matches=$(grep -En -o -E "$IPV4_PRIVATE|$EMAIL|$PASS" "$file" || true)

  if [ -z "$matches" ]; then
    echo "  No sensitive patterns found."
    rm -f "$file.bak"
    continue
  fi

  # Iterate over each occurrence
  # shellcheck disable=SC2162
  while IFS=: read -r lineno match; do
    # Show context (prev/current/next line)
    show_context "$file" "$lineno"
    echo "Found match: $match"

    # Decide suggestion by type
    suggestion="<placeholder>"
    if [[ "$match" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
      suggestion="<lab-ip>"
    elif [[ "$match" =~ @ ]]; then
      suggestion="<redacted-email>"
    elif echo "$match" | grep -Eq "$PASS"; then
      suggestion="<redacted-password>"
    fi

    echo "Choose an action:"
    echo "  1) Replace with suggestion ($suggestion)"
    echo "  2) Enter custom replacement"
    echo "  3) Skip this occurrence"
    read -rp "Choice [1/2/3]: " choice

    case "$choice" in
      1)
        replacement="$suggestion"
        ;;
      2)
        read -rp "Enter replacement: " replacement
        ;;
      *)
        echo "  Skipped."
        continue
        ;;
    esac

    # Perform in-place replacement (single occurrence on that line)
    replace_one_in_line "$file" "$lineno" "$match" "$replacement"
    echo "  Replaced '$match' -> '$replacement'"

  done <<< "$matches"

  # If any changes occurred, staged version differs vs backup
  if ! cmp -s "$file" "$file.bak"; then
    git add "$file"
    echo "  Changes applied and re-staged. Backup saved as $file.bak"
  else
    rm -f "$file.bak"
    echo "  No changes applied."
  fi
done

echo
echo "Interactive sanitization complete. Review with: git diff --staged"
