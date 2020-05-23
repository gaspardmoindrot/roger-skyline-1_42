#!/bin/bash
# Author (Auteur) : Gaspard Moindrot (gmoindro)
# You need to run this code with sudo ! (Utilise sudo pour executer la plupart du code)

# Pre / exo 1 (debut exo 1) : Use sudo, with this user, to be able to perform operation requiring special rights. (Utilisez sudo pour pouvoir, depuis cet utilisateur, effectuer les operations deman- dant des droit speciaux.)

su
apt-get update -y && apt-get upgrade -y
apt-get install sudo vim -y
cd /etc
chmod +w sudoers
echo "gaspard ALL=(ALL:ALL) ALL" >> sudoers
cd
exit
sudo apt-get install net-tools
sudo apt-get install ufw
sudo apt-get install iptables fail2ban apache2
sudo apt-get install portsenty
sudo apt install bsd-mailx
sudo apt install postfix
sudo apt install mutt



# Exo 2 : We don’t want you to use the DHCP service of your machine. You’ve got to configure it to have a static IP and a Netmask in \30. (Nous ne voulons pas que vous utilisiez le service DHCP de votre machine. A vous donc de la configurer afin qu’elle ait une IP fixe et un Netmask en /30.)

cd /etc/network/
sudo sed -i '$d' interfaces
sudo sed -i '$d' interfaces
sudo echo "auto enp0s3" >> interfaces
cd interfaces.d
sudo echo "iface enp0s3 inet static" > enp0s3
sudo echo "    address 192.168.10.42" >> enp0s3
sudo echo "    netmask 255.255.255.252" >> enp0s3
sudo service networking restart
cd



# Exo 3 : You have to change the default port of the SSH service by the one of your choice. SSH access HAS TO be done with publickeys. SSH root access SHOULD NOT be allowed directly, but with a user who can be root. (Vous devez changer le port par defaut du service SSH par celui de votre choix. L’accès SSH DOIT se faire avec des publickeys. L’utilisateur root ne doit pas pouvoir se connecter en SSH.)

sudo echo "Port 55000" >> /etc/ssh/sshd_config
sudo service sshd restart
sudo echo "PermitRootLogin no" >> /etc/ssh/sshd_config
sudo service sshd restart
cd




# Exo 4 : You have to set the rules of your firewall on your server only with the services used outside the VM. (Vous devez mettre en place des règles de pare-feu (firewall) sur le serveur avec uniquement les services utilisés accessible en dehors de la VM.)

sudo ufw enable
sudo ufw allow 55000/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443



# Exo 5 : You have to set a DOS (Denial Of Service Attack) protection on your open ports of your VM. (Vous devez mettre en place une protection contre les DOS (Denial Of Service Attack) sur les ports ouverts de votre VM.)


sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo echo "enable = true" >> /etc/fail2ban/jail.conf
sudo echo "maxentry = 3" >> /etc/fail2ban/jail.conf
sudo echo "bantime = 600" >> /etc/fail2ban/jail.conf
sudo echo "" >> /etc/fail2ban/jail.conf
sudo echo "# Protect port 80 (HTTP)" >> /etc/fail2ban/jail.conf
sudo echo "" >> /etc/fail2ban/jail.conf
sudo echo "[http-get-dos]" >> /etc/fail2ban/jail.conf
sudo echo "" >> /etc/fail2ban/jail.conf
sudo echo "enabled = true" >> /etc/fail2ban/jail.conf
sudo echo "port = http,https" >> /etc/fail2ban/jail.conf
sudo echo "filter = http-get-dos" >> /etc/fail2ban/jail.conf
sudo echo "logpath = %(apache_error_log)s" >> /etc/fail2ban/jail.conf
sudo echo "maxentry = 300" >> /etc/fail2ban/jail.conf
sudo echo "findtime = 300" >> /etc/fail2ban/jail.conf
sudo echo "bantime = 600" >> /etc/fail2ban/jail.conf
sudo echo "action = iptables[name=HTTP, port=http, protocol=tcp]" >> /etc/fail2ban/jail.conf

sudo echo "[Definition]" > /etc/fail2ban/filter.d/http-get-dos.conf
sudo echo "" >> /etc/fail2ban/filter.d/http-get-dos.conf
sudo echo "failregex = ^ -.*GET" >> /etc/fail2ban/filter.d/http-get-dos.conf
sudo echo "ignoreregex =" >> /etc/fail2ban/filter.d/http-get-dos.conf

sudo ufw reload
sudo service fail2bam restart



# Exo 6 : You have to set a protection against scans on your VM’s open ports. (Vous devez mettre en place une protection contre les scans sur les ports ouverts de votre VM.)








# Exo 7 : Stop the services you don’t need for this project. (Arretez les services dont vous n’avez pas besoin pour ce projet.)

sudo systemctl disable bluetooth.service
sudo systemctl disable console-setup.service
sudo systemctl disable keyboard-setup.service




# Exo 8 : Create a script that updates all the sources of package, then your packages and which logs the whole in a file named /var/log/update_script.log. Create a scheduled task for this script once a week at 4AM and every time the machine reboots. (Réalisez un script qui met à jour l’ensemble des sources de package, puis de vos packages et qui log l’ensemble dans un fichier nommé /var/log/update_script.log. Créez une tache planifiée pour ce script une fois par semaine à 4h00 du matin et à chaque reboot de la machine.)

sudo echo "#!/bin/bash" > /home/gaspard/update_script.sh
sudo echo "apt-get update && apt-get upgrade" >> /home/gaspard/update_script.sh
sudo chmod +x /home/gaspard/update_script.sh
sudo echo "0 4	* * 1	root	/home/USER/update_script.sh  >> /var/log/update_script.log" >> /etc/crontab
sudo echo "@reboot		root	/home/USER/update_script.sh  >> /var/log/update_script.log" >> /etc/crontab






















