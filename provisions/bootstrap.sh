#!/usr/bin/env bash

debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
apt-get update
apt-get install -y python-software-properties
add-apt-repository -y ppa:ondrej/php
apt-get update -y
apt-cache pkgnames | grep php7.1
apt-get install apache2 zip unzip mysql-server expect php7.1 php7.1-cli php7.1-mcrypt php7.1-intl php7.1-mysql php7.1-curl php7.1-gd php7.1-mbstring php7.1-bz2 php7.1-dom php7.1-zip libapache2-mod-php7.1 redis-server curl git supervisor -y
echo "create database seat;" | mysql -uroot -ppassword
echo "GRANT ALL ON *.* to 'root'@'%' IDENTIFIED BY 'password';" | mysql -uroot -ppassword
echo "FLUSH PRIVILEGES;" | mysql -uroot -ppassword
sed -i -- 's/bind-address/# bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf
service mysql restart
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && hash -r
cd /var/www/
git clone https://github.com/eveseat/seat
cd /var/www/seat/
mkdir -p packages/eveseat
cd packages/eveseat
git clone https://github.com/eveseat/api
git clone https://github.com/eveseat/console
git clone https://github.com/eveseat/eveapi
git clone https://github.com/eveseat/eseye
git clone https://github.com/eveseat/notifications
git clone https://github.com/eveseat/services
git clone https://github.com/eveseat/web
cd /var/www/seat/
wget -q https://raw.githubusercontent.com/eveseat/scripts/master/development/composer.dev-3x.json -O composer.json
composer install
cp .env.example .env
sed -i -- 's/DB_USERNAME=seat/DB_USERNAME=root/g' /var/www/seat/.env
sed -i -- 's/DB_PASSWORD=secret/DB_PASSWORD=password/g' /var/www/seat/.env
sed -i -- 's/APP_DEBUG=false/APP_DEBUG=true/g' /var/www/seat/.env
php artisan vendor:publish --force
php artisan migrate
php artisan key:generate

#php artisan db:seed --class=Seat\\Notifications\\database\\seeds\\ScheduleSeeder
#php artisan db:seed --class=Seat\\Services\\database\\seeds\\NotificationTypesSeeder
#php artisan db:seed --class=Seat\\Services\\database\\seeds\\ScheduleSeeder
#php artisan eve:update-sde -n
#/usr/bin/expect /vagrant/provisions/admin_seat
#echo "UPDATE seat.users SET active=1 WHERE id=1;" | mysql -uroot -ppassword
#cp /vagrant/provisions/supervisor /etc/supervisor/conf.d/seat.conf
#systemctl start supervisor
#systemctl enable supervisor
#supervisorctl reload
crontab -u www-data /vagrant/provisions/crontab
adduser ubuntu www-data
chown -R www-data:www-data /var/www
chmod -R guo+w /var/www/seat/storage/
cp /vagrant/provisions/vhost /etc/apache2/sites-available/seat.conf
chmod 777 -R /var/www/seat
a2dissite 000-default.conf
a2ensite seat
a2enmod rewrite
apachectl restart


echo " "
echo " "
echo " "
echo "******************************"
echo "******************************"
echo " "
echo "Deployment completed, SeAT should be available on one of these IP (if multiple) : `hostname -I`"
echo "SeAT : admin:password"
echo "MySQL : root:password (remote access allowed)"
echo " "
echo "Check for errors above. If there is any, most of the time, it's easier to just destroy the machine and try again."
echo " "
echo "******************************"
echo "******************************"
echo " "
echo " "
echo " "

#php artisan serve --port=8000 --host=172.28.128.3
