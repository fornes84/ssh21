#Al arxiu /etc/sshd/sshd_config
#habilitem l'authentificació per clau publica i per password, tot i que la de password la treurem més endevant
PasswordAuthentication yes
PubkeyAuthentication yes

iniciarem el servei de servidor al arrancar:
service ssh start --> arranca /usr/sbin/sshd

docker run --rm --name pam.edt.org  --privileged --network 2hisix -p 22:22 -it balenabalena/ssh21:base

-----------------------------------

1era de 3 formes de connexió amb authentificació d'usuari, 
(EL FINGER PRINT EL FA SEMPRE !!!)

1a) per password:

# ssh unix01@172.19.0.2
The authenticity of host '172.19.0.2 (172.19.0.2)' can't be established.
ECDSA key fingerprint is SHA256:iLiNaZkOQrgzyDNHOFfyonT052e46LhydcrcnxA65Qo.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes

Warning: Permanently added '172.19.0.2' (ECDSA) to the list of known hosts.
ssh_dispatch_run_fatal: Connection to 172.19.0.2 port 22: Broken pipe
(el missatge d'error era pq no hem propagat el port 22 en la xarxa docker)

Al aceptar, estem afegint al nostre arxiu (local) ~/.ssh/known_hosts,  la relació fingerprint (hash CLAU PUBLICA maq remota)-IP maq remota  (per seguretat) per si la IP cambia que no ens conectem on no toca. (és la Verificació del host remot)

Ara pregunta password i dins (provat amb usuaris UNIX i LDAP)

sshd_config cambiar:
	- PasswordAuthet   yes
	- PubkeyAuthent    no

1b) per parelles de claus publica/privada

Un compte d’usuari en el servidor remot(ex: unix01) confiarà amb tots els usuaris d’un host client si disposa en el seu authorized_keys de la clau pública del host client. Per tant cal concatenar la clau /etc/ssh/ssh_host_key.pub (o la RSA o DSA) al ~/.ssh/authorized_keys
del compte de l’usuari en el servidor remot.

sshd_config cambiar:
	- PasswordA  no
	- PubkeyAuthen  yes

Hem d'enviar al usuari del servidor(unix01) les claus del usuari client(marc) que exec el ssh ubicades a ~/.ssh/NOM_X__rsa.pub cap ~/.ssh/authorized_keys 

	ssh-copy-id  usuario@IP_servidor
	scp archivo.txt usuario@dominio.com:/home/usuario (HABILITEM ACCES PER PASSWORD I H		O FEM)

1c) Gssapi --> Kerberos

--------------------------

2na FORMA: Verificació del host remot per aceptació de fingerprint 
(RECORDAR ordre  sha256sum)

SERVIDOR:
Tornem a configurar l'arxiu "sshd_config" i treiem que es pugui loguerjar per password:

	PubkeyAuth	no
	PasswordAuthentication no
	ChallengeResponseAuth  no
	HostbasedAuthentication yes

Ara el que volem authentificar NO els usuaris (sino la maquina) per clau publica/privada (identificació).

Creem el fitxer ssh_known_hosts (a /etc/ssh) i guardem dins les claus del host client:
/etc/ssh/ssh_host_dsa_key.pub i /etc/ssh/ssh_host_rsa_key.pub

service ssh restart


CLIENT:

A client hem de verificar els pemisos del fitxer:
vim /usr/lib/openssh/ssh-keysign
i també habilitar i descomentar la linea HostbasedAuthentification yes
 de client /etc/ssh/ssh_config i també habilitar (EnableSSHKeysign yes)

Al instalar ssh (nostre cas el docker-servidor) genera automat les claus a:

# /etc/ssh/ssh_host_rsa_key --> CLAU PRIVADA HOST
# /etc/ssh/ssh_host_rsa_key.pub --> CLAU PUBLICA HOST

RESUM: Se li ha de passar al usuari servidro que confí en tots els usuris
que d'aquesta clau publica de host client

------------------------------------------------------------


