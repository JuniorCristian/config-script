#bash


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
    sudo apt install php$version php$version-fpm php$version-curl php$version-mysql php$version-json php$version-mbstring php$version-mcrypt php$version-xml php$version-gd php$version-zip;
    let "x = x +1"
done 
sudo update-alternatives –set php /usr/bin/php7.4;

#Instalando o Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --install-dir=bin --filename=composer --2
php composer-setup.php --install-dir=bin --filename=composer1 --1

#Instalando o Brave
sudo apt install brave-browser -y;


#Git
sudo apt install git -y;

#Scrcpy
sudo apt install scrcpy -y;
sudo snap install guiscrcpy;

#Discord
sudo apt install Discord -y;

#OBS
sudo apt install obs -y;

#VisualStudio Code
sudo apt install code

#Instalando o MySql
sudo apt install mysql-server -y;
sudo mysql_secure_installation;