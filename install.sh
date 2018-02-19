#!/bin/bash -e

echo "HOME=$HOME"
cd /c7

echo "================= Updating package lists ==================="
yum clean expire-cache
yum check-update || true

echo "================= Adding some global settings ==================="
mkdir -p "$HOME/.ssh/"
mv config "$HOME/.ssh/"
cat 90forceyes >> /etc/yum.conf
touch "$HOME/.ssh/known_hosts"

echo "================= Installing basic packages ==================="
yum -y install -q \
  epel-release \
  sudo \
  gcc \
  gcc-c++ \
  kernel-devel \
  make \
  curl \
  openssl \
  software-properties-common \
  wget \
  nano \
  unzip \
  openssh-clients \
  libxslt1-dev \
  libxml2-dev \
  htop \
  gettext \
  textinfo \
  rsync \
  psmisc \
  vim \
  glibc.i686 \
  libgcc_s.so.1

echo "================= Installing Node 9.x ==================="
. /c7/node/install.sh

echo "================= Installing Java 1.8.0 ==================="
. /c7/java/install.sh

echo "================= Installing Ruby 2.3.5 ==================="
. /c7/ruby/install.sh

echo "================= Installing Git ==================="
sudo yum install git

echo "================= Installing Git LFS ==================="
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash -
sudo yum install git-lfs
git lfs install

echo "================= Cleaning package lists ==================="
yum clean expire-cache
yum autoremove

