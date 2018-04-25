#!/bin/bash -e

echo "================= Installing NVM v0.33.9 ==================="
curl https://raw.githubusercontent.com/creationix/nvm/v0.33.9/install.sh | bash

# Set NVM_DIR so the installations go to the right place
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "================= Installing nodejs 9.11* ==================="
curl --silent --location https://rpm.nodesource.com/setup_9.x | sudo bash -
#adding key required to install nodejs
rpm --import /etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL
sudo yum install nodejs

echo "================= Installing yarn 1.5* ==================="
sudo wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
#adding key required to install yarn
rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
sudo yum install yarn
