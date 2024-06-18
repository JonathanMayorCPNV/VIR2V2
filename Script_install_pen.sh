apt-get update -y
apt-get upgrade -y
apt install git apache2 mariadb-server php7.4 libapache2-mod-php php-mysql cowsay iptables-persistent -y


git clone https://github.com/7ric/Photoblog.git

mkdir /var/www/Photoblog
mv ./Photoblog/* /var/www/Photoblog

chown -R www-data:www-data /var/www/Photoblog

mysql < /var/www/Photoblog/photoblog.sql

FILE="/etc/apache2/sites-available/000-default.conf"
cat <<EOM >$FILE
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/Photoblog

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        Options +Indexes

</VirtualHost>
EOM

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

sed -i 's/display_errors = Off/display_errors = On/' /etc/php/7.4/apache2/php.ini
sed -i 's/disable_function/#disable_function/' /etc/php/7.4/apache2/php.ini

chmod -R o+r /var/www/Photoblog/

a2enmod autoindex

systemctl restart apache2

systemctl restart ssh

sleep 10
mysql < /var/www/Photoblog/photoblog.sql
