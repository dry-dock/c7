#!/bin/bash -e

echo "================= Installing openjdk-8-jdk ==================="
sudo yum install -y java-1.8.0-openjdk-devel


echo "================ Installing oracle-java8-installer ================="

echo "========= Installing JRE =============="
wget --no-cookies \
  --no-check-certificate \
  --retry-connrefused \
  --tries=5 \
  --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
  "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jre-8u171-linux-x64.rpm"
sudo yum localinstall -y jre-8u171-linux-x64.rpm

echo "========= Installing JDK =============="
wget --no-cookies \
  --no-check-certificate \
  --retry-connrefused \
  --tries=5 \
  --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
  "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.rpm"

sudo yum localinstall -y jdk-8u171-linux-x64.rpm
sudo update-alternatives --set java /usr/java/jre1.8.0_171-amd64/bin/java
sudo update-alternatives --set javac /usr/java/jdk1.8.0_171-amd64/bin/javac
rm jre-8u171-linux-x64.rpm
rm jdk-8u171-linux-x64.rpm
echo 'export JAVA_HOME=/usr/java/jdk1.8.0_171' >> /etc/drydock/.env
echo 'export PATH=$PATH:/usr/java/jre1.8.0_171/bin' >> /etc/drydock/.env
