#!/bin/bash

git checkout pelican
make clean
make publish
ghp-import output
git pull origin master
git push origin gh-pages:master
