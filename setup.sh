#!/bin/bash
echo "Installing Flex theme..."
git clone https://github.com/alexandrevicenzi/Flex.git
pelican-themes -i Flex
rm -rf Flex
echo "Installed Flex theme and removed folder"
