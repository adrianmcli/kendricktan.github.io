#!/usr/bin/env bash
set -eo pipefail

# Push our latest revision to GitHub
git push origin hakyll

# Clean rebuild
bin/generate-site rebuild

# Create deploy environment inside of .deploy directory
mkdir .deploy
cd .deploy
git init
git remote add origin git@github.com:kendricktan/kendricktan.github.io.git

# Add built site files
cp -r ../_site/* .
echo "kndrck.co" >> CNAME
git add .
git commit -m 'Publish'
git push -f origin master

# Cleanup .deploy directory after a successful push
cd .. && rm -rf .deploy