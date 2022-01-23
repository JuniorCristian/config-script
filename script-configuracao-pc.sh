#!/bin/bash


#Instalando todas as dependências antes
#Brave
sudo apt install apt-transport-https curl -y;
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
#PHP
sudo add-apt-repository ppa:ondrej/php -y;
#VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
#Update
sudo apt update;

#Instalando as verões do PHP
VERSIONS_PHP=("5.6" "7.0" "7.1" "7.2" "7.3" "7.4" "8.0")
x=0;
while [ $x != ${#VERSIONS_PHP[@]} ]
do
    version=${VERSIONS_PHP[$x]}
    sudo apt install php$version php$version{-xml,-gd,-mbstring,-zip,-fpm,-curl,-mysql,-mcrypt,-dev,-imagick} -y --allow-unauthenticated;
    let "x = x +1"
done
sudo update-alternatives --set php /usr/bin/php8.0;

#Instalando o driver SQL Server
sudo su
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/21.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
exit
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql17
sudo ACCEPT_EULA=Y apt-get install -y mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
sudo apt install -y unixodbc-dev
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

#Instalando o Brave
sudo apt install brave-browser -y;

#Telegran
sudo apt install telegram-desktop -y;

#Git
sudo apt install git -y;

#Scrcpy
sudo apt install scrcpy -y;
sudo snap install guiscrcpy;

#Discord
sudo apt install discord -y;

#OBS
sudo apt install obs-studio -y;

#VisualStudio Code
sudo apt install code -y;

#Slack
sudo apt install slack-desktop -y;

#Tmux
sudo apt install tmux -y;

#Arduino
sudo apt install arduino -y;

#Thunderbird
sudo apt install thunderbird thunderbird-locale-pt-br -y;

#EasySSH
sudo apt install easyssh -y;

#JetBrains Toolbox
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.22.10970.tar.gz jetbrains-toolbox.tar.gz
tar -vzxf jetbrains-toolbox.tar.gz
./jetbrains-toolbox/jetbrains-toolbox

#Instalando Dracula Theme

    #Gnome Terminal
    sudo apt-get install dconf-cli;
    git clone https://github.com/dracula/gnome-terminal;
    ./gnome-terminal/install.sh;
    sudo rm -R gnome-terminal;

    #Telegran
    git clone https://github.com/dracula/telegram.git;

    #GTK
    wget "https://github.com/dracula/gtk/archive/master.zip";
    unzip master.zip;
    mkdir ~/.themes/;
    mv gtk-master/ ~/.themes/Dracula-dark;
    gsettings set org.gnome.desktop.interface gtk-theme "Dracula-dark";
    gsettings set org.gnome.desktop.wm.preferences theme "Dracula-dark";
    rm master.zip;

    #Thunderbird
    wget https://github.com/dracula/thunderbird/archive/master.zip thunderbird-master.zip

#Configurando Scripts
sudo cp change_php_version.sh /bin/change_php_version
sudo cp install_new_php_version.sh /bin/install_new_php_version
chmod a+x ./bin/change_php_version
chmod a+x ./bin/install_new_php_version

#Instalando o MySql
sudo apt install mysql-server -y;
sudo mysql_secure_installation;