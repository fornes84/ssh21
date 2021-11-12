# ldapserver
FROM debian:latest
LABEL version="1.0"
LABEL author="@edt ASIX-M06"
LABEL subject="PAM host"
RUN apt-get update
#ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install procps iproute2 tree nmap vim less finger passwd libpam-pwquality libpam-mount nfs-common ldap-utils libnss-ldapd libpam-ldapd nslcd nslcd-utils openssh-client openssh-server
#nscd
# A MANIJA instalar libnss-ldapd (seguir pasos i tindrem el nslcd)

RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD /opt/docker/startup.sh
