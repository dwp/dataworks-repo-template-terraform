#!/bin/bash
TF_REPO_NAME=dataworks-repo-template-terraform
NEW_REPO_NAME=`basename $(git remote get-url origin) .git`

git remote set-url origin https://github.com/dwp/$NEW_REPO_NAME.git

if [ ! -z 'grep -rnw $TF_REPO_NAME ci' ]; then
    git branch initial-commit
    find ci -type f -exec sed -i 's/$TF_REPO_NAME/$NEW_REPO_NAME/g' {} +
    find terraform -type f -exec sed -i 's/$TF_REPO_NAME/$NEW_REPO_NAME/g' {} +
    find aviator.yml -type f -exec sed -i 's/$TF_REPO_NAME/$NEW_REPO_NAME/g' {} +
    rm rename.sh
    
    git add --quiet --all
    git diff --quiet && git diff --staged --quiet || git commit -m "Renamed pipeline to fit repository"
    git push --quiet --set-upstream origin initial-commit
    
    aviator -s
else
    echo "Not required, or not a Terraform repository"
    exit 1
fi

