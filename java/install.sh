#!/bin/bash -e

echo "================= Installing openjdk-10-jdk ==================="
mkdir -p /usr/lib/jvm && cd /usr/lib/jvm
wget "https://download.java.net/java/GA/jdk10/10.0.2/19aef61b38124481863b1413dce1855f/13/openjdk-10.0.2_linux-x64_bin.tar.gz"
tar -xzf openjdk-10.0.2_linux-x64_bin.tar.gz
mv jdk-10.0.2/ java-10-openjdk-amd64

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-10-openjdk-amd64/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-10-openjdk-amd64/bin/javac 1
sudo update-alternatives --set java /usr/lib/jvm/java-10-openjdk-amd64/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/java-10-openjdk-amd64/bin/javac

echo 'export JAVA_HOME=/usr/lib/jvm/java-10-openjdk-amd64' >> /etc/drydock/.env
echo 'export PATH="$PATH:/usr/lib/jvm/java-10-openjdk-amd64/bin/java/bin' >> /etc/drydock/.env


echo "================ Installing oracle-java10-installer ================="

echo "========= Installing JRE =============="
wget --no-cookies \
  --no-check-certificate \
  --retry-connrefused \
  --tries=5 \
  --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
  "http://download.oracle.com/otn-pub/java/jdk/10.0.2+13/19aef61b38124481863b1413dce1855f/jre-10.0.2_linux-x64_bin.rpm"
sudo yum localinstall -y jre-10.0.2_linux-x64_bin.rpm

echo "========= Installing JDK =============="
wget --no-cookies \
  --no-check-certificate \
  --retry-connrefused \
  --tries=5 \
  --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
  "http://download.oracle.com/otn-pub/java/jdk/10.0.2+13/19aef61b38124481863b1413dce1855f/jdk-10.0.2_linux-x64_bin.rpm"

sudo yum localinstall -y jdk-10.0.2_linux-x64_bin.rpm
sudo update-alternatives --set java /usr/java/jdk-10.0.2/bin/java
sudo update-alternatives --set javac /usr/java/jdk-10.0.2/bin/javac

rm jre-10.0.2_linux-x64_bin.rpm
rm jdk-10.0.2_linux-x64_bin.rpm

echo 'export JAVA_HOME=/usr/java/jdk-10.0.2' >> /etc/drydock/.env
echo 'export PATH=$PATH:/usr/java/jre-10.0.2/bin' >> /etc/drydock/.env
