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
mkdir -p /etc/drydock

echo "================= Installing basic packages ===================="
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 

yum -y install -q \
 epel-release-7* \
 sudo-1.8.19p2* \
 gcc-4.8* \
 gcc-c++-4.8* \
 kernel-devel-3.10.0* \
 make-3.82* \
 curl-7.29.0* \
 openssl-1.0.2k* \
 wget-1.14* \
 nano-2.3* \
 unzip-6.0* \
 zip-3.0* \
 openssh-clients-7.4p1* \
 gettext-0.19.8* \
 rsync-3.0.9* \
 psmisc-22.20* \
 vim-enhanced-7.4* \
 glibc-2.17*.i686 \
 libgcc-4.8.5* 
 
 
echo "================= Installing Htop packages ==================="
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7  
sudo yum install htop-2.1*


echo "================= Installing Python packages ==================="
sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm
sudo yum update
rpm --import /etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY
sudo yum install -y python36u python36u-libs python36u-devel python36u-pip
sudo pip3.6 install virtualenv==15.2.0

echo "================= Adding JQ 1.5* ==================="
sudo yum install jq-1.5*

echo "================= Installing Node 9.x ==================="
. /c7/node/install.sh

echo "================= Installing Java 1.8.0 ==================="
. /c7/java/install.sh

echo "================= Installing Ruby 2.5.1 ==================="
. /c7/ruby/install.sh

echo "================= Installing Git ==================="
sudo yum install git-1.8.3.1

echo "================= Installing Git LFS ==================="
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash -
sudo yum install git-lfs-2.4*
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
rpm --import  https://packages.cloud.google.com/yum/doc/yum-key.gpg
rpm --import  https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
sudo yum install -y google-cloud-sdk-196.0*

echo "================= Adding kubectl 1.8.11 ==================="
curl -sSLO https://storage.googleapis.com/kubernetes-release/release/v1.8.11/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

KOPS_VERSION=1.8.1
echo "Installing KOPS version: $KOPS_VERSION"
curl -LO https://github.com/kubernetes/kops/releases/download/"$KOPS_VERSION"/kops-linux-amd64
sudo chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

HELM_VERSION=v2.8.2
echo "Installing helm version: $HELM_VERSION"
wget https://storage.googleapis.com/kubernetes-helm/helm-"$HELM_VERSION"-linux-amd64.tar.gz
tar -zxvf helm-"$HELM_VERSION"-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64

echo "================= Adding awscli 1.15.3 ============"
sudo pip3.6 install -q 'awscli==1.15.3'

#echo "================= Adding awsebcli 3.12.4 ============"
#sudo pip3.6 install -q 'awsebcli==3.12.4'

AZURE_CLI_VERSION=2.0*
echo "================ Adding azure-cli $AZURE_CLI_VERSION  =============="
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum install azure-cli-$AZURE_CLI_VERSION

echo "================= Adding doctl 1.8.0 ============"
curl -OL https://github.com/digitalocean/doctl/releases/download/v1.8.0/doctl-1.8.0-linux-amd64.tar.gz
tar xf doctl-1.8.0-linux-amd64.tar.gz
sudo mv doctl /usr/local/bin
rm doctl-1.8.0-linux-amd64.tar.gz

echo "================= Adding jfrog-cli 1.14.0 ==================="
wget -nv https://api.bintray.com/content/jfrog/jfrog-cli-go/1.14.0/jfrog-cli-linux-amd64/jfrog?bt_package=jfrog-cli-linux-amd64 -O jfrog
sudo chmod +x jfrog
sudo mv jfrog /usr/bin/jfrog

echo "================ Adding ansible 2.4.4.0 ===================="
sudo pip3.6 install -q 'ansible==2.4.4.0'

echo "================ Adding boto 2.48.0 ======================="
sudo pip3.6 install -q 'boto==2.48.0'

echo "============  Adding boto3 ==============="
sudo pip3.6 install -q 'boto3==1.7.2'

echo "================ Adding apache-libcloud 2.3.0 ======================="
sudo pip3.6 install -q 'apache-libcloud==2.3.0'

echo "================ Adding azure 3.0 ======================="
sudo pip3.6 install -q 'azure==3.0'

echo "================ Adding dopy 0.3.7a ======================="
sudo pip3.6 install -q 'dopy==0.3.7a'

export TF_VERSION=0.11.5
echo "================ Adding terraform-$TF_VERSION===================="
export TF_FILE=terraform_"$TF_VERSION"_linux_amd64.zip

echo "Fetching terraform"
echo "-----------------------------------"
rm -rf /tmp/terraform
mkdir -p /tmp/terraform
wget -nv https://releases.hashicorp.com/terraform/$TF_VERSION/$TF_FILE
unzip -o $TF_FILE -d /tmp/terraform
sudo chmod +x /tmp/terraform/terraform
mv /tmp/terraform/terraform /usr/bin/terraform

echo "Added terraform successfully"
echo "-----------------------------------"

export PK_VERSION=1.2.2
echo "================ Adding packer $PK_VERSION ===================="
export PK_FILE=packer_"$PK_VERSION"_linux_amd64.zip

echo "Fetching packer"
echo "-----------------------------------"
curl -O https://releases.hashicorp.com/packer/1.2.2/packer_1.2.2_linux_amd64.zip
sudo unzip -d /usr/local packer_1.2.2_linux_amd64.zip
sudo ln -s /usr/local/packer /usr/local/bin/packer.io
rm packer_1.2.2_linux_amd64.zip

echo "Added packer successfully"
echo "-----------------------------------"

echo "================= Intalling Shippable CLIs ================="

git clone https://github.com/Shippable/node.git nodeRepo
./nodeRepo/shipctl/x86_64/CentOS_7/install.sh
rm -rf nodeRepo

echo "Installed Shippable CLIs successfully"
echo "-------------------------------------"

echo "================= Cleaning package lists ==================="
yum clean expire-cache
yum autoremove
