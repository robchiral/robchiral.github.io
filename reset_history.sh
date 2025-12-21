#!/bin/bash

# Configuration
BRANCH_NAME=$(git symbolic-ref --short HEAD)
SCRIPT_NAME=$(basename "$0")

echo "WARNING: This will PERMANENTLY DELETE all git history from '$BRANCH_NAME' and replace it with a single commit."
read -p "Are you sure you want to proceed? (y/N): " confirm

if [[ $confirm != [yY] && $confirm != [yY][eE][sS] ]]; then
    echo "Operation cancelled."
    exit 1
fi

echo "Starting history reset..."

# 1. Create a temporary orphan branch
git checkout --orphan latest_branch

# 2. Add all files
git add -A

# 3. Create the definitive commit
git commit -m "Latest commit"

# 4. Delete the original branch
git branch -D "$BRANCH_NAME"

# 5. Rename the current branch to the original name
git branch -m "$BRANCH_NAME"

# 6. Force push to remote
echo "Pushing to remote origin '$BRANCH_NAME'..."
git push -f origin "$BRANCH_NAME"

echo "Success! History has been reset to a single commit."
echo "Note: This script ($SCRIPT_NAME) is ignored by git and will remain local-only."
