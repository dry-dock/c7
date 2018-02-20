FROM centos:7

ADD . /c7

RUN /c7/install.sh && rm -rf /tmp && mkdir /tmp

ENV BASH_ENV "/etc/drydock/.env"
