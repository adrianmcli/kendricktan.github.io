#!/bin/bash

git checkout gh-pages
git pull origin master
git checkout pelican
make clean
make publish
ghp-import output
git push origin gh-pages:master
