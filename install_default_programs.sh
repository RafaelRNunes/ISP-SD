#!/bin/bash
#
# Instalando programas para uso no dia a dia
# Programas:
#   Eclipse Mars *Arrumar icone desktop
#   Git
#   Google Chrome
#   Java 8
#   OpenJdk-7
#   SQLDeveloper***
#   Sublime Text 3

echo -e "\nAtualizando sitema...\n"
sudo apt-get update
echo -e "\nSistema atualizado."
echo -e "\nA instalacao dos programas segue ordem alfabetica,\nsalvo excecao quando necessario a instalacao de uma dependencia."

echo -e "\nGostaria de instalar Eclipse Mars? s/n"
read resp

if [ $resp == "s" ]; then
  echo -e "\nInforme o seu usuario e faça o download do arquivo compactado no seu diretorio Downloads!"
  read user

  wget http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/mars/R/eclipse-jee-mars-R-linux-gtk-x86_64.tar.gz -O eclipse.tar.gz
  sudo tar -zxvf /home/$user/Downloads/eclipse.tar.gz -C /opt/
  sudo mv /opt/eclipse*/ /opt/eclipse
  sudo touch -c /usr/share/applications/eclipse.desktop
  echo "[Desktop Entry]
  Name=Eclipse 4
  Type=Application
  Exec=/opt/eclipse/eclipse
  Terminal=false
  Icon=/opt/eclipse/icon.xpm
  Comment=Integrated Development Environment
  NoDisplay=false
  Categories=Development;IDE;
  Name[en]=Eclipse" > eclipse.desktop
fi

echo -e "\nGostaria de instalar Git? s/n"
read resp

if [ $resp == "s" ]; then
  sudo apt-get install git
fi

echo -e "\nGostaria de instalar Google Chrome? s/n"
read resp

if [ $resp == "s" ]; then
  sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install google-chrome-stable
fi

echo -e "\nGostaria de instalar java 8? s/n"
read resp

if [ $resp == "s" ]; then
  sudo add-apt-repository ppa:webupd8team/java
  sudo apt-get update
  sudo apt-get install oracle-java8-installer
fi

echo -e "\nGostaria de instalar OpenJDK-7? s/n"
read resp

if [ $resp == "s" ]; then
  sudo apt-get install openjdk-7-jdk
fi

echo -e "\nSelecione a versão padrão desejada do java!"
sudo update-alternatives --config java
java -version

echo -e "\nGostaria de instalar Sublime Text 3? s/n"
read resp

if [ $resp == "s" ]; then
  sudo add-apt-repository ppa:webupd8team/sublime-text-3
  sudo apt-get update
  sudo apt-get install sublime-text-installer
fi