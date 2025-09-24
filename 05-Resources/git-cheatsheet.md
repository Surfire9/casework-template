feat: → a new feature (e.g., new detection playbook, new script)
fix: → a bug fix (e.g., corrected a broken query, fixed markdown formatting)
docs: → documentation only (e.g., updating README, adding notes)
style: → code style changes (formatting, spacing, no logic changes)
refactor: → restructuring code or content without changing behavior
test: → adding/updating tests (unit tests, queries, validations)
chore: → repo maintenance, dependencies, or small non-user-facing chang
perf: → performance improvements
ci: → continuous integration / automation updates
build: → build scripts, dependencies, package managers

#First-time setup (per repo)

git init                        # initialize a repo (if not already)
git branch -M main              # ensure branch is named main
git remote add origin git@github.com:USERNAME/REPO.git
git add .
git commit -m "chore: initial commit"
git push -u origin main         # first push (-u sets upstream)

#Daily workflow

git pull                        # get latest changes (good habit before working)

git status                      # check what changed
git add .                       # stage all changes
git commit -m "feat: add new detection playbook"
git push                        # push to GitHub (after first push, no -u needed)

#Branching (experiments or features)

git checkout -b feature-name    # create & switch to new branch
# make changes...
git add .
git commit -m "work: add draft writeup"
git push -u origin feature-name # first push for branch

#Switch back to main (post branch)

git checkout main
git pull                        # sync with remote

#Remove files/folders

git rm file.txt
git commit -m "chore: remove file"
git push

git rm -r foldername
git commit -m "chore: remove folder"
git push

#Log & history
git log --oneline --graph --decorate --all   # pretty history
git diff                                     # see changes before commit


