#! /bin/bash

useradd -m -s /bin/bash unix01
useradd -m -s /bin/bash unix02
useradd -m -s /bin/bash unix03
echo -e "unix01\nunix01" | passwd unix01
echo -e "unix02\nunix02" | passwd unix02
echo -e "unix03\nunix03" | passwd unix03


cp /opt/docker/ldap.conf /etc/ldap/ldap.conf
cp /opt/docker/login.defs /etc/login.defs 
# opcions de loggin unix

#cp /opt/docker/exports /etc/exports
#per permetre compartir paths 

cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
# d'on obtenir la info i prioritat
cp /opt/docker/nslcd.conf /etc/nslcd.conf
# d'on treure les dades ldap

cp /opt/docker/common-auth /etc/pam.d/common-auth
cp /opt/docker/common-session /etc/pam.d/common-session
cp /opt/docker/common-account /etc/pam.d/common-account
#cp /opt/docker/common-password /etc/pam.d/common-password
# DE MOMENT NO ELS UTILTIZEM (CREC)

cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
# que s'ha de montar a cada inici de sessio d'un usuari

#config servidor ssh

# iniciem els serveis PAM-LDAP

/usr/sbin/nscd
/usr/sbin/nslcd

/usr/bin/ssh-keygen -A
cp /opt/docker/sshd_config /etc/ssh/sshd_config

#iniciem servidor sshd
# PROBLEMES DE PRIVILEGIS /usr/sbin/sshd
#service ssh start
service ssh start -D
# inicicem terminal (amb detauch treure)
# /bin/bash

