

#Al arxiu /etc/sshd/sshd_config
#habilitem l'authentificació per clau publica i per password, tot i la de password la treurem més endevant

PasswordAuthentication yes
PubkeyAuthentication yes

docker run --rm --name ssh.edt.org  --privileged --network 2hisix -p 2200:22 -it balenabalena/ssh21:base

docker run --rm --name ldap.edt.org -h ldap.edt.org --network 2hisix -p 389:389 -it balenabalena/lda21:grups

VERIFICAR QUE FUNCIONEN!!

-----------------------------------

**ssh21:aws**:	

ipPUBLICA: 13.38.28.221


1er:

Llançarem una instancia AWS on habilitarem a les regles --> Security group reules, obrim  els d'entrada 389 LDAP, 22 SSH, i 2022 (admin es l'usuari per defecte en AMI Debian)
Ens conectem via ssh desdel nostre PC a la AMI mitjançant la clau privada ssh -i ~/noseque.pem admin@IP_AMI (hem de treure permisos al fitxer on es guarda la clau privada pq nomes pugui llegir/escriure el propietari -->  chmod 600 XXX.pem
 
Instal·lem docker --> https://docs.docker.com/engine/install/debian/
i docker compose  --> https://docs.docker.com/compose/install/

docker-compose --version
 
Exeutem docker compose amb el fitx .ylm de la clase pasada, per llançar els 2 dockers (LDAP i no recordo) (cada un obrint els ports corresponents).

sudo docker compose up -d (previament compiem a la AMI el .yml)
(docker-compose down)

Instal·lem també el ldap-utils, i nmap a la AMI per fer consultes.

Verifiquem que desde la AMI podem fer ldapsearch.. 
 ldapsearch -x -h localhost -LLL -b 'dc=edt,dc=org'
(comprovació LDAP) i comprovem que podem conectar-nos via ssh de la AMI al docker:
Verifiquem la connexió SSH amb els usuaris unix per el port 2022: ssh -p 2022 unix01@localhost
Comprobem que tenim bé la connexió SSH amb els usuaris LDAP per el port 2022: ssh -p 2022 marta1@localhost

i ara provem desde 'fora' (des del nostre PC) cap a la AMI:
	Comprobem que podem fer consultes LDAP: 
ldapsearch -x -h 'IP_AMAZON' -LLL -b 'dc=edt,dc=org'



2n:
Fer NO recordo per afegir que sigui capaç de resoldre a partir de la elastic IP (IP fixa) a  /etc/hosts els servidors LDAP i PAM
Per montar tots els homes del ususaris, hem de crear un script !!! 

