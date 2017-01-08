#!/bin/bash

make clean
make html
make publish 
ghp-import output -b master
git push origin master
