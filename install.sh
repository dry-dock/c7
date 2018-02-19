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
sudo yum install git-1.8.3.1

echo "================= Installing Git LFS ==================="
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash -
sudo yum install git-lfs-2.3.4
git lfs install

echo "================= Adding gclould ============"
sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
sudo yum install -y google-cloud-sdk-189.0.0-1.el7

echo "================= Adding kubectl 1.8.8 ==================="
curl -sSLO https://storage.googleapis.com/kubernetes-release/release/v1.8.8/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

KOPS_VERSION=1.8.1
echo "Installing KOPS version: $KOPS_VERSION"
curl -LO https://github.com/kubernetes/kops/releases/download/"$KOPS_VERSION"/kops-linux-amd64
sudo chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

HELM_VERSION=v2.8.1
echo "Installing helm version: $HELM_VERSION"
wget https://storage.googleapis.com/kubernetes-helm/helm-"$HELM_VERSION"-linux-amd64.tar.gz
tar -zxvf helm-"$HELM_VERSION"-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64

echo "================= Cleaning package lists ==================="
yum clean expire-cache
yum autoremove

