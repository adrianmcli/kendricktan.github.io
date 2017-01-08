#!/bin/bash

git checkout pelican
make clean
make publish
ghp-import output -b master -p
