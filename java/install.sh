#!/bin/bash -e

export OPENJDK_VERSION=11
echo "================= Installing openjdk $OPENJDK_VERSION ==================="
mkdir -p /usr/lib/jvm && cd /usr/lib/jvm
wget "https://download.java.net/java/ga/jdk$OPENJDK_VERSION/openjdk-"$OPENJDK_VERSION"_linux-x64_bin.tar.gz"
tar -xzf openjdk-"$OPENJDK_VERSION"_linux-x64_bin.tar.gz
mv jdk-"$OPENJDK_VERSION"/ java-"$OPENJDK_VERSION"-openjdk-amd64

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-"$OPENJDK_VERSION"-openjdk-amd64/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-"$OPENJDK_VERSION"-openjdk-amd64/bin/javac 1
sudo update-alternatives --set java /usr/lib/jvm/java-"$OPENJDK_VERSION"-openjdk-amd64/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/java-"$OPENJDK_VERSION"-openjdk-amd64/bin/javac

echo 'export JAVA_HOME=/usr/lib/jvm/java-"$OPENJDK_VERSION"-openjdk-amd64' >> /etc/drydock/.env
echo 'export PATH="$PATH:/usr/lib/jvm/java-"$OPENJDK_VERSION"-openjdk-amd64/bin/java/bin"' >> /etc/drydock/.env


export ORACLEJDK_VERSION=11
echo "================ Installing oracle-java $ORACLEJDK_VERSION ================="

wget --no-cookies \
  --no-check-certificate \
  --retry-connrefused \
  --tries=5 \
  --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
  "http://download.oracle.com/otn-pub/java/jdk/11+28/55eed80b163941c8885ad9298e6d786a/jdk-"$ORACLEJDK_VERSION"_linux-x64_bin.rpm"

sudo yum localinstall -y jdk-"$ORACLEJDK_VERSION"_linux-x64_bin.rpm
sudo update-alternatives --set javac /usr/java/jdk-"$ORACLEJDK_VERSION"/bin/javac

rm jdk-"$ORACLEJDK_VERSION"_linux-x64_bin.rpm

echo 'export JAVA_HOME=/usr/java/jdk-"$ORACLEJDK_VERSION"' >> /etc/drydock/.env
echo 'export PATH=$PATH:/usr/java/jdk-"$ORACLEJDK_VERSION"/bin' >> /etc/drydock/.env
