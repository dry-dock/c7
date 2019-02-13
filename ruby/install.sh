#!/bin/bash -e

#adding keys

cd /root

# added to fix https://github.com/rvm/rvm/issues/3108
curl -sSL https://rvm.io/mpapis.asc | sudo gpg --import -
sudo yum install which

export RVM_VERSION=1.29.4
echo "================= Installing RVM ==================="
curl -sSL https://get.rvm.io |  bash -s -- --version "$RVM_VERSION"

# Set source to rvm
source /usr/local/rvm/scripts/rvm
rvm requirements

export RUBY_VERSION=2.6.1
echo "================= Installing default ruby ==================="
rvm install "$RUBY_VERSION"

# tell rvm to use this version as default
rvm use "$RUBY_VERSION" --default

#update gems to current
rvm rubygems current
