#!/bin/bash

make html
ghp-import output -b master
git push origin master
