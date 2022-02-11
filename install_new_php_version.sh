#!/bin/bash

echo "Digite a versão do PHP que deseja instalar"
read version

sudo apt install php$version php$version{-xml,-gd,-mbstring,-zip,-fpm,-curl,-mysql,-mcrypt,-dev} -y;

sudo update-alternatives --set php /usr/bin/php$version
sudo update-alternatives --set phar /usr/bin/phar$version
sudo update-alternatives --set phar.phar /usr/bin/phar.phar$version
sudo update-alternatives --set phpize /usr/bin/phpize$version
sudo update-alternatives --set php-config /usr/bin/php-config$version
