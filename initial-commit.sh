#!/bin/bash
TF_REPO_NAME=dataworks-repo-template-terraform
ORIGIN=$(git remote get-url origin)
NEW_REPO_NAME=`basename $ORIGIN .git`

git remote set-url origin $ORIGIN

if [ ! -z 'grep -rnw $TF_REPO_NAME ci' ]; then
    git checkout -b initial-commit
    git submodule add https://github.com/chrisscottthomas/githooks .githooks
    make git-hooks
    
    find ci -type f -exec sed -i '' "s/$TF_REPO_NAME/$NEW_REPO_NAME/g" {} +
    find terraform -type f -exec sed -i '' "s/$TF_REPO_NAME/$NEW_REPO_NAME/g" {} +
    find aviator.yml -type f -exec sed -i '' "s/$TF_REPO_NAME/$NEW_REPO_NAME/g" {} +
    
    rm initial-comit.sh
    
    git add --all
    git commit -m "Renamed pipeline to fit repository"
    git push --quiet --set-upstream origin initial-commit
    
else
    echo "Not required, or not a Terraform repository"
    exit 1
fi
