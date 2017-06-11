#!/bin/bash

git checkout pelican
make clean
make publish
ghp-import output
git push origin gh-pages:master
