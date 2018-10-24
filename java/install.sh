#!/bin/bash -e

export JAVA_VERSION=11

export ORACLEJDK_VERSION=11.0.1
echo "================ Installing oracle-java"$ORACLEJDK_VERSION"-installer ================="
mkdir -p /usr/lib/jvm && cd /usr/lib/jvm
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-"$ORACLEJDK_VERSION"_linux-x64_bin.tar.gz
tar -xzf jdk-"$ORACLEJDK_VERSION"_linux-x64_bin.tar.gz
mv jdk-"$ORACLEJDK_VERSION"/ java-"$JAVA_VERSION"-oraclejdk-amd64

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-"$JAVA_VERSION"-oraclejdk-amd64/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-"$JAVA_VERSION"-oraclejdk-amd64/bin/javac 1
sudo update-alternatives --set java /usr/lib/jvm/java-"$JAVA_VERSION"-openjdk-amd64/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/java-"$JAVA_VERSION"-openjdk-amd64/bin/javac

echo "export JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-oraclejdk-amd64" >> /etc/drydock/.env
echo "export PATH=\$PATH:/usr/lib/jvm/java-${JAVA_VERSION}-oraclejdk-amd64/bin" >> /etc/drydock/.env


export ORACLEJDK_VERSION=11.0.1
echo "================ Installing oracle-java"$ORACLEJDK_VERSION"-installer ================="
mkdir -p /usr/lib/jvm && cd /usr/lib/jvm
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-"$ORACLEJDK_VERSION"_linux-x64_bin.tar.gz
tar -xzf jdk-"$ORACLEJDK_VERSION"_linux-x64_bin.tar.gz
mv jdk-"$ORACLEJDK_VERSION"/ java-"$JAVA_VERSION"-oraclejdk-amd64

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-"$JAVA_VERSION"-oraclejdk-amd64/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-"$JAVA_VERSION"-oraclejdk-amd64/bin/javac 1

echo "export JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-oraclejdk-amd64" >> /etc/drydock/.env
echo "export PATH=\$PATH:/usr/lib/jvm/java-${JAVA_VERSION}-oraclejdk-amd64/bin" >> /etc/drydock/.env
