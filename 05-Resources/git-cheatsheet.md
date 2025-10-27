# Git Cheat Sheet

## Commit Message Conventions (Conventional Commits)

| Prefix     | Purpose                                   | Example                              |
|-------------|-------------------------------------------|--------------------------------------|
| feat:       | Add a new feature                         | feat: add new detection playbook     |
| fix:        | Fix a bug                                 | fix: correct broken query            |
| docs:       | Documentation only                        | docs: update README                  |
| style:      | Code style changes (formatting only)      | style: reformat code                 |
| refactor:   | Restructure code without behavior change  | refactor: simplify parser logic      |
| test:       | Add or update tests                       | test: add validation unit tests      |
| chore:      | Maintenance or dependencies               | chore: update dependencies           |
| perf:       | Performance improvements                  | perf: optimize query response        |
| ci:         | Continuous integration / automation        | ci: update GitHub Actions workflow   |
| build:      | Build scripts or package managers          | build: update package.json           |

---

## First-Time Setup (Per Repo)

```bash
git init
git branch -M main
git remote add origin git@github.com:USERNAME/REPO.git
git add .
git commit -m "chore: initial commit"
git push -u origin main

Daily Workflow
git pull                     # Sync latest changes
git status                   # Check modified files
git add .                    # Stage all changes
git commit -m "feat: add new detection playbook"
git push                     # Push to remote


Tip: Always pull before starting new work.

Branching (Feature or Experiment)
git checkout -b feature-name   # Create and switch to new branch
# Make changes...
git add .
git commit -m "work: add draft writeup"
git push -u origin feature-name


Switch back to main:

git checkout main
git pull

Removing Files or Folders
git rm file.txt
git commit -m "chore: remove file"
git push

git rm -r foldername
git commit -m "chore: remove folder"
git push

Logs and History
git log --oneline --graph --decorate --all
git diff
