# pam21
#

common-auth      
login.defs          
common-session  
pam_mount.conf.xml  


Consulta el HowTo-PAM l’apartat “Implantació del servei nss-pam-ldap” pagina 30
● Consulta el man de pam_ldap.so
● Crear la imatge: pam21:ldap

Configura el container PAM (--privileged) per:
● Permetre l’autenticació local dels usuaris unix locals (unix01, unix02 i unix03)
● Permetre l’autenticació d’usuaris de LDAP.

Per fer-ho s’utilitzarà la imatge ldap21/grup que conté el llistat final d’usuaris i grups
LDAP amb els que treballar.

● Als usuaris LDAP se’ls ha de crear el directori home automàticament si no existeix.
● Als usuaris LDAP se’ls ha de crear un recurs temporal, dins del home anomenat tmp.
Un ramdisk de tipus tmpfs de 100M.

● Tots els usuaris han de poder modificar-se el password. Els usuaris locals i també
els usuaris de LDAP.
Atenció: potser cal refer la configuració ACL de la base de dades LDAP edt.org per
permetre que els usuaris es puguin modificar el seu password.
Metodologia de treball recomanada:

● Es recomana fer una copia de pam21:base i generar pam1:ldap.

● Treballar interactivament amb aquesta nova imatge afegint els paquets de PAM
LDAP i NSS. Observar les opcions de configuració que demana Debian en instal·lar
aquests paquets i en quins fitxers afecten aquestes configuracions.

● Manualment engegar els serveis nscd i nslcd.

● Verificar:
○ Si està ben configurat l’accés LDAP, nsswitch, nscd i nslcd lavors les ordres
getent han de funcionar correctament (gent passwd i getent group).
○ Si també es configura els fitxers de PAM (auth, acount, session i password)
llavors l’autenticació amb usuaris linux i unix és total.

● Un cop interactivament s’ha construït un container que autentica correctament unix i
ldap cal generar automatitzadament la imatge pam21:ldap a través del Dockerfile.
Observacions:

● Observeu que en el procés d’instal·lació i configuració interctiu amb Debian sembla
que tot es configura apropiadament i l’autenticació d’usuaris està molt més afinada.

● En canvi si ho feu manaualment sembla que queden ‘detals’ per tunejar de manra
que l’autenticació és més ‘aspre’.

● Mireu d’esbrinar quins són tot els canvis de configuració que fa automàticament la
instal3lació interactiva per propagar-los a la configuració del Dockerfile.

