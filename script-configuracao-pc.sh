#!/bin/bash

#Instalando todas as dependências antes
# shellcheck disable=SC2034
ATUAL_PATH=$(pwd)

#Nala
sudo apt install nala
#Brave
sudo nala install apt-transport-https curl -y;
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
#PHP
sudo add-apt-repository ppa:ondrej/php -y;
#VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
#Snap
sudo nala install snapd -y;
#Update
sudo nala update;

#Instalando as verões do PHP
VERSIONS_PHP=("7.0" "7.1" "7.2" "7.3" "7.4" "8.0")
x=0;
while [ $x != ${#VERSIONS_PHP[@]} ]
do
    version=${VERSIONS_PHP[$x]}
    sudo nala install php"$version" php"$version"{-xml,-gd,-mbstring,-zip,-fpm,-curl,-mysql,-mcrypt,-dev,-imagick,-cli,-common,-intl,-opcache,-readline} -y --allow-unauthenticated;
    # shellcheck disable=SC2219
    let "x = x +1"
done
sudo update-alternatives --set php /usr/bin/php"${VERSIONS_PHP[$x]}";

#Instalando o driver SQL Server
sudo su
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/21.10/prod.list > /etc/apt/sources.list.d/mssql-release.list
exit
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql17
sudo ACCEPT_EULA=Y apt-get install -y mssql-tools
# shellcheck disable=SC2016
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
# shellcheck disable=SC1090
source ~/.bashrc
sudo nala install -y unixodbc-dev
sudo pecl install sqlsrv
sudo pecl install pdo_sqlsrv
sudo su
x=0;
while [ $x != ${#VERSIONS_PHP[@]} ]
do
    version=${VERSIONS_PHP[$x]}
    let "x = x +1"
    sudo pecl config-set php_ini /etc/php/$version/fpm/php.ini
    printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/$version/mods-available/sqlsrv.ini
    printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/$version/mods-available/pdo_sqlsrv.ini
    exit
    sudo phpenmod -v $version sqlsrv pdo_sqlsrv
    sudo systemctl restart php$version-fpm
done

#Instalando o Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --install-dir=bin --filename=composer --2
php composer-setup.php --install-dir=bin --filename=composer1 --1

#Docker
sudo nala install docker docker-compose -y;

#Instalando o Brave
sudo nala install brave-browser -y;

#Telegran
sudo nala install telegram-desktop -y;

#Git
sudo nala install git -y;

#Scrcpy
sudo nala install scrcpy -y;
sudo snap install guiscrcpy;

#Discord
sudo nala install discord -y;

#OBS
sudo nala install obs-studio -y;

#VisualStudio Code
sudo nala install code -y;

#Slack
sudo nala install slack-desktop -y;

#Tmux
sudo nala install tmux -y;

#Arduino
sudo nala install arduino -y;

#Thunderbird
sudo nala install thunderbird thunderbird-locale-pt-br -y;

#EasySSH
sudo nala install easyssh -y;

#Multipass
sudo snap install multipass;

#JetBrains Toolbox
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.22.10970.tar.gz /tmp/jetbrains-toolbox.tar.gz
tar -vzxf /tmp/jetbrains-toolbox.tar.gz
/tmp/jetbrains-toolbox/jetbrains-toolbox

#Entensões

  #Caffeine
  git clone https://github.com/eonpatapon/gnome-shell-extension-caffeine.git /tmp/caffeine;
  # shellcheck disable=SC2164
  cd /tmp/caffeine;
  sudo make build;
  sudo make install;

  #Bluetooth Battery Indicator
  sudo nala install bluez libbluetooth-dev python3-dev python3-bluez;
  git clone git@github.com:MichalW/gnome-bluetooth-battery-indicator.git /tmp/bluetooth-battery-indicator;
  git submodule update --init;
  cp -R /tmp/bluetooth-battery-indicator "$HOME"/.local/share/gnome-shell/extensions/bluetooth-battery@michalw.github.com;

  #Bluetooth Quick Connect
  git clone https://github.com/bjarosze/gnome-bluetooth-quick-connect /tmp/bluetooth-quick-connect;
  # shellcheck disable=SC2164
  cd /tmp/bluetooth-quick-connect;
  make
  rm -rf "$HOME"/.local/share/gnome-shell/extensions/bluetooth-quick-connect@bjarosze.gmail.com
  mkdir -p "$HOME"/.local/share/gnome-shell/extensions/bluetooth-quick-connect@bjarosze.gmail.com
  cp -r /tmp/bluetooth-quick-connect/* "$HOME"/.local/share/gnome-shell/extensions/bluetooth-quick-connect@bjarosze.gmail.com

  #Clipboard Indicator
  git clone https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator.git "$HOME"/.local/share/gnome-shell/extensions/clipboard-indicator@tudmotu.com
  gnome-extensions enable clipboard-indicator@tudmotu.com

  #Sound Input & Output Device Chooser
  # shellcheck disable=SC2164
  cd "$HOME"/.local/share/gnome-shell/extensions/
  # Remove older version
  # shellcheck disable=SC2035
  rm -rf *sound-output-device-chooser*
  # Clone current version
  git clone https://github.com/kgshank/gse-sound-output-device-chooser.git
  # Install it
  cp -r gse-sound-output-device-chooser/sound-output-device-chooser@kgshank.net .
  rm -rf "gse-sound-output-device-chooser"
  gnome-extensions enable sound-output-device-chooser@kgshank.net

  #Lock Keys
  git clone https://github.com/kazysmaster/gnome-shell-extension-lockkeys.git /tmp/lockkeys;
  # shellcheck disable=SC2164
  cp -r /tmp/lockkeys/lockkeys@vaina.lt "$HOME"/.local/share/gnome-shell/extensions/

#Instalando Dracula Theme

    #Gnome Terminal
    sudo apt-get install dconf-cli;
    git clone https://github.com/dracula/gnome-terminal /tmp/dracula_theme/gnome-terminal;
    /tmp/dracula_theme/gnome-terminal/install.sh;

    #Telegran
    git clone https://github.com/dracula/telegram.git /tmp/dracula_theme/telegram;

    #GTK
    wget "https://github.com/dracula/gtk/archive/master.zip" /tmp/dracula_theme/gtk;
    unzip /tmp/dracula_theme/gtk/master.zip;
    mkdir "$HOME"/.themes/;
    mv /tmp/dracula_theme/gtk/gtk-master/ "$HOME"/.themes/Dracula-dark;
    gsettings set org.gnome.desktop.interface gtk-theme "Dracula-dark";
    gsettings set org.gnome.desktop.wm.preferences theme "Dracula-dark";

    #Thunderbird
    wget https://github.com/dracula/thunderbird/archive/master.zip thunderbird-master.zip

#Configurando Scripts
if [ ! -d "$HOME/.additional_scripts" ]; then
    mkdir "$HOME/.additional_scripts";
fi
sudo cp "${ATUAL_PATH}"additional_scripts/change_php_version.sh "$HOME"/.additional_scripts/change_php_version
sudo cp "${ATUAL_PATH}"additional_scripts/weather.sh "$HOME"/.additional_scripts/weather
sudo ln -s "$HOME"/.additional_scripts/change_php_version /bin/change_php_version
sudo ln -s "$HOME"/.additional_scripts/change_php_version /bin/weather
chmod a+x ./bin/change_php_version
chmod a+x ./bin/weather

#Instalando o MySql
#sudo nala install mysql-server -y;
#sudo mysql_secure_installation;

rm -rf /tmp/*;