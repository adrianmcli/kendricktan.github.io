#!/bin/bash

git checkout pelican
make clean
make publish
make github
