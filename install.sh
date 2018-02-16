#!/bin/bash -e

echo "HOME=$HOME"
cd /c7

echo "================= Updating package lists ==================="
yum clean expire-cache
yum check-update || true

echo "================= Adding some global settings ==================="
mv gbl_env.sh /etc/profile.d/
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
  vim

echo "================= Cleaning package lists ==================="
yum clean expire-cache
yum autoremove

