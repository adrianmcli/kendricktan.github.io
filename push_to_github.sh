#!/bin/bash

make clean
make publish
ghp-import output -b master
git push origin master
