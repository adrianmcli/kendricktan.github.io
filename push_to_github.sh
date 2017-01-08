#!/bin/bash

git checkout pelican
make clean
make publish
ghp-import output 
git checkout master
git merge gh-pages
git push --all
