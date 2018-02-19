#!/bin/bash -e

echo "================= Installing openjdk-8-jdk ==================="
sudo yum install -y java-1.8.0-openjdk

echo "================ Installing oracle-java8-installer ================="
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jre-8u161-linux-x64.rpm"
sudo yum localinstall -y jre-8u161-linux-x64.rpm
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-i586.rpm"
sudo yum localinstall -y jdk-8u161-linux-i586.rpm
sudo update-alternatives --set java /usr/java/jre1.8.0_161/bin/java
sudo update-alternatives --set javac /usr/java/jdk1.8.0_161/bin/javac
rm jre-8u161-linux-x64.rpm
rm jdk-8u161-linux-i586.rpm
echo 'export JAVA_HOME=/usr/java/jdk1.8.0_161' >> $HOME/.bashrc
echo 'export PATH=$PATH:/usr/java/jre1.8.0_161/bin' >> $HOME/.bashrc
