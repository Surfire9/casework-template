🧠 Git Cheat Sheet

🏷️ Commit Message Conventions (Conventional Commits)
Prefix	Purpose	Example
feat:	Add a new feature	feat: add new detection playbook
fix:	Fix a bug	fix: correct broken query
docs:	Documentation changes only	docs: update README
style:	Formatting or whitespace (no logic change)	style: reformat code
refactor:	Code restructuring without behavior change	refactor: simplify parser logic
test:	Add or update tests	test: add validation unit tests
chore:	Maintenance or non-user-facing changes	chore: update dependencies
perf:	Performance improvements	perf: optimize query response
ci:	Continuous Integration or automation changes	ci: update GitHub Actions workflow
build:	Build scripts or package manager changes	build: update package.json

🚀 First-Time Setup (Per Repo)
git init                     # Initialize repository
git branch -M main            # Ensure branch is named 'main'
git remote add origin git@github.com:USERNAME/REPO.git
git add .                     # Stage all files
git commit -m "chore: initial commit"
git push -u origin main       # First push (-u sets upstream)

🔁 Daily Workflow
git pull                      # Sync latest changes
git status                    # View modified files
git add .                     # Stage all changes
git commit -m "feat: add new detection playbook"
git push                      # Push to remote

💡 Tip: Always pull before starting new work.

🌱 Branching (Features or Experiments)
git checkout -b feature-name   # Create & switch to new branch

# Make changes...
git add .
git commit -m "work: add draft writeup"
git push -u origin feature-name  # First push for new branch


Switch back to main after finishing:
git checkout main
git pull                       # Update main branch

🧹 Removing Files or Folders
git rm file.txt
git commit -m "chore: remove file"
git push

git rm -r foldername
git commit -m "chore: remove folder"
git push
📜 Logs & History
git log --oneline --graph --decorate --all   # Pretty visual history
git diff                                    # Show unstaged changes
