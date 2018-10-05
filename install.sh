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
#adding key required to install epel-release-7
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

yum -y install  \
 epel-release-7* \
 sudo-1.8* \
 gcc-4.8* \
 gcc-c++-4.8* \
 kernel-devel-3.10* \
 make-3.82* \
 curl-7.29* \
 openssl-1.0* \
 wget-1.14* \
 nano-2.3* \
 unzip-6.0* \
 zip-3.0* \
 openssh-clients-7.4p1* \
 gettext-0.19* \
 rsync-3.1* \
 psmisc-22.20* \
 vim-enhanced-7.4* \
 glibc-2.17*.i686 \
 libgcc-4.8*


echo "================= Installing Htop packages ==================="
#adding key required to install htop
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
sudo yum install htop-2.2*


echo "================= Installing Python packages ==================="
sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm
sudo yum update
#adding key required to install python
rpm --import /etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY

sudo yum install -y \
  python-devel \
  python-pip

## python 3 packages
sudo yum install -y \
  python36u \
  python36u-libs \
  python36u-devel \
  python36u-pip

export VIRTUALENV_VERSION=16.0.0
echo "================= Adding $VIRTUALENV_VERSION ==================="
sudo pip install virtualenv=="$VIRTUALENV_VERSION"

export PYOPENSSL_VERSION=18.0.0
echo "================= Adding pyopenssl $PYOPENSSL_VERSION ==================="
sudo pip install pyOpenSSL=="$PYOPENSSL_VERSION"

echo "================= Adding JQ 1.5* ==================="
sudo yum install jq-1.5*

echo "================= Installing Node 8.x ==================="
. /c7/node/install.sh

echo "================= Installing Java 10.x ==================="
. /c7/java/install.sh

echo "================= Installing Ruby 2.5.1 ==================="
. /c7/ruby/install.sh

echo "================= Installing Git ==================="
sudo yum install http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm
sudo yum install git-2.18.0

echo "================= Installing Git LFS ==================="
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash -
sudo yum install git-lfs-2.5.2
git lfs install

echo "================= Adding gcloud ============"
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
#adding key required to install gcloud
rpm --import  https://packages.cloud.google.com/yum/doc/yum-key.gpg
rpm --import  https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
sudo yum install -y google-cloud-sdk-218.0*


KUBECTL_VERSION=1.12.0
echo "================= Adding kubectl "$KUBECTL_VERSION" ==================="
curl -sSLO https://storage.googleapis.com/kubernetes-release/release/v"$KUBECTL_VERSION"/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

KOPS_VERSION=1.10.0
echo "Installing KOPS version: $KOPS_VERSION"
curl -LO https://github.com/kubernetes/kops/releases/download/"$KOPS_VERSION"/kops-linux-amd64
sudo chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

HELM_VERSION=v2.11.0
echo "Installing helm version: $HELM_VERSION"
wget https://storage.googleapis.com/kubernetes-helm/helm-"$HELM_VERSION"-linux-amd64.tar.gz
tar -zxvf helm-"$HELM_VERSION"-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64

export AWS_VERSION=1.16.24
echo "================= Adding awscli "$AWS_VERSION" ============"
sudo pip install  awscli=="$AWS_VERSION"

# This does not work because of dependency issue with awsebcli which requires
# an older version of requests library: https://forums.aws.amazon.com/thread.jspa?threadID=225679
#echo "================= Adding awsebcli 3.12.4 ============"
#sudo pip install 'awsebcli==3.12.4'

AZURE_CLI_VERSION=2.0*
echo "================ Adding azure-cli $AZURE_CLI_VERSION  =============="
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum install azure-cli-$AZURE_CLI_VERSION

export DOCTL_VERSION=1.9.0
echo "================= Adding doctl $DOCTL_VERSION============"
curl -OL https://github.com/digitalocean/doctl/releases/download/v"$DOCTL_VERSION"/doctl-"$DOCTL_VERSION"-linux-amd64.tar.gz
tar xf doctl-"$DOCTL_VERSION"-linux-amd64.tar.gz
sudo mv doctl /usr/local/bin
rm doctl-"$DOCTL_VERSION"-linux-amd64.tar.gz

export JFROG_VERSION=1.20.1
echo "================= Adding jfrog-cli "$JFROG_VERSION"==================="
wget -nv https://api.bintray.com/content/jfrog/jfrog-cli-go/"$JFROG_VERSION"/jfrog-cli-linux-amd64/jfrog?bt_package=jfrog-cli-linux-amd64 -O jfrog
sudo chmod +x jfrog
sudo mv jfrog /usr/bin/jfrog

export ANSIBLE_VERSION=2.6.5
echo "================ Adding ansible $ANSIBLE_VERSION===================="
sudo pip install ansible=="$ANSIBLE_VERSION"

export BOTO_VERSION=2.49.0
echo "================ Adding boto $BOTO_VERSION ======================="
sudo pip install  boto=="$BOTO_VERSION"

export BOTO3_VERSION=1.9.14
echo "============  Adding boto3 "$BOTO_VERSION" ==============="
sudo pip install boto3=="$BOTO3_VERSION"

export APACHE_LIBCLOUD=2.3.0
echo "================ Adding apache-libcloud $APACHE_LIBCLOUD ======================="
sudo pip install apache-libcloud=="$APACHE_LIBCLOUD"

export AZURE_VERSION=3.0
echo "================ Adding azure $AZURE_VERSION ======================="
sudo pip install azure=="$AZURE_VERSION"

export DOPY_VERSION=0.3.7a
echo "================ Adding dopy $DOPY_VERSION ======================="
sudo pip install dopy=="$DOPY_VERSION"

export OPENSTACKCLIENT_VERSION=3.16.1
echo "================= Adding openstack client $OPENSTACKCLIENT_VERSION ============"
sudo pip install python-openstackclient=="$OPENSTACKCLIENT_VERSION"

export SHADE_VERSION=1.29.0
echo "==================adding shade $SHADE_VERSION================"
sudo pip install shade=="$SHADE_VERSION"

export TF_VERSION=0.11.8
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

export PK_VERSION=1.3.1
echo "================ Adding packer $PK_VERSION ===================="
export PK_FILE=packer_"$PK_VERSION"_linux_amd64.zip

echo "Fetching packer"
echo "-----------------------------------"
curl -O https://releases.hashicorp.com/packer/$PK_VERSION/$PK_FILE
sudo unzip -d /usr/local $PK_FILE
sudo ln -s /usr/local/packer /usr/local/bin/packer.io
rm $PK_FILE

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
