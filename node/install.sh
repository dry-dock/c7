#!/bin/bash -e

export NVM_VERSION=v0.33.9
echo "================= Installing NVM $NVM_VERSION  ==================="
curl https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash

# Set NVM_DIR so the installations go to the right place
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export NODEJS_VERSION=10.13*
export NPM_VERSION=6.4.1

echo "================= Installing nodejs $NODEJS_VERSION ==================="
curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash -
#adding key required to install nodejs
rpm --import /etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL
sudo yum install nodejs
npm install npm@"$NPM_VERSION" -g

export YARN_VERSION=1.12*
echo "================= Installing yarn $YARN_VERSION ==================="
sudo wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
#adding key required to install yarn
rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
sudo yum install yarn
