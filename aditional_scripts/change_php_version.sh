#! /usr/bin/env bash

if [ -z "$1" ]; then
  echo "Digite a versão do PHP que deseja utilizar"
  read version
else
  version=$1
fi

# shellcheck disable=SC2157
if [[ ! -e "/etc/php/$version/cli/php.ini" ]]; then
  echo "Versão não encontrada, deseja instalar a versão $version?[yes/no]"
  # shellcheck disable=SC2034
  read answer
  if [ $answer = "yes" ]; then
    echo "Instalando a versão $version"
    sudo apt install php$version php$version{-xml,-gd,-mbstring,-zip,-fpm,-curl,-mysql,-mcrypt,-dev,-imagick,-cli,-common,-intl,-opcache,-readline};
  fi
fi

sudo update-alternatives --set php /usr/bin/php$version
sudo update-alternatives --set phar /usr/bin/phar$version
sudo update-alternatives --set phar.phar /usr/bin/phar.phar$version
sudo update-alternatives --set phpize /usr/bin/phpize$version
sudo update-alternatives --set php-config /usr/bin/php-config$version