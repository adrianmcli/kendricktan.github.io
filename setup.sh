#!/bin/bash
echo "Installing markdown + pelican"
pip install markdown pelican webassets ghp-import

echo "Installing theme..."
git clone https://github.com/kendricktan/voce.git
pip install -r voce/requirements.txt
pelican-themes -r voce
pelican-themes -i voce
rm -rf voce
echo "Installed theme and removed folder"
