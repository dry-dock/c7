#!/bin/bash -e

echo "================= Installing NVM ==================="
curl https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

# Set NVM_DIR so the installations go to the right place
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "================= Installing nodejs 9.11* ==================="
curl --silent --location https://rpm.nodesource.com/setup_9.x | sudo bash -
sudo yum install nodejs

echo "================= Installing yarn 1.5* ==================="
sudo wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
sudo yum install yarn
