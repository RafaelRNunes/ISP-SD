#!/bin/bash
#
# Instalando programas para uso no dia a dia
# Programas:
#   Eclipse Mars *Arrumar icone desktop
#   Git
#   Google Chrome
#   Java 8
#   OpenJdk-7
#   Rvm
#   Ruby
#   Rails
#   SQLDeveloper *Instalar
#   Sublime Text 3
#   Ssh-keygen

echo -e "\nGostaria de atualizar o sistema antes? s/n"
read resp

if [ $resp == "s" ]; then
  echo -e "\nAtualizando sitema...\n"
  sudo apt-get update
  echo -e "\nSistema atualizado."
fi
echo -e "\nA instalacao dos programas segue ordem alfabetica,\nsalvo excecao quando necessario a instalacao de uma dependencia."

echo -e "\nGostaria de instalar Eclipse Mars? s/n"
read resp

if [ $resp == "s" ]; then
  echo -e "\nInforme o seu usuario. O download do arquivo compactado sera feito no seu diretorio Downloads!"
  read user

  cd /home/$user/Downloads

  wget http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/mars/R/eclipse-jee-mars-R-linux-gtk-x86_64.tar.gz -O eclipse.tar.gz
  sudo tar -zxvf /home/$user/Downloads/eclipse.tar.gz -C /opt/
  sudo mv /opt/eclipse*/ /opt/eclipse
  sudo touch -c /usr/share/applications/eclipse.desktop
  sudo echo "[Desktop Entry]
  Name=Eclipse 4
  Type=Application
  Exec=/opt/eclipse/eclipse
  Terminal=false
  Icon=/opt/eclipse/icon.xpm
  Comment=Integrated Development Environment
  NoDisplay=false
  Categories=Development;IDE;
  Name[en]=Eclipse" > /usr/share/applications/eclipse.desktop
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

#FIXME
# echo -e "\nGostaria de gerar chave ssh? s/n"
# read resp

# if [ $resp == "s" ]; then
#   echo -e "\nInforme o seu usuario! A chave será gerada no diretorio do seu usuario."
#   read user

#   sudo mkdir -p /home/$user/.ssh
#   cd /home/$user/.ssh

#   sudo ssh-keygen
#   sudo ssh-add /home/$user/.ssh/id_rsa

#   sudo touch known_hosts

#   echo -e "\nCopie a chave e cole a na configuracao do seu repositorio remoto!\n"
#   sudo cat < /home/$user/.ssh/id_rsa.pub
# fi

echo -e "\nGostaria de instalar Rvm, Ruby e Rails? s/n"
read resp

if [ $resp == "s" ]; then
  echo -e "\nAdicionando chave publica necessaria...\n"
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

  echo -e "\nInstalando curl, dependencia necessaria...\n"
  sudo apt-get install curl

  echo -e "\nBaixan rvm...\n"
  curl -L https://get.rvm.io | bash -s stable

  echo -e "\nConfigurando rvm..."
  source ~/.rvm/scripts/rvm

  echo -e "\nVersão instalada:"
  rvm -v

  echo -e "\nIntegrando com so..."
  sudo echo 'PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting' >> ~/.bashrc
  sudo echo '[[ -s “/usr/local/rvm/scripts/rvm” ]] && source “/usr/local/rvm/scripts/rvm”' >> ~/.bashrc
  sudo echo '[[ -s “$HOME/.rvm/scripts/rvm” ]] && source “$HOME/.rvm/scripts/rvm”' >> ~/.bashrc
  source ~/.bashrc

  echo -e "\nArualizando dependencias..."
  rvm requirements

  echo -e "\nInstalando ruby..."
  rvm install 2.2.1

  echo -e "\nVersao ruby instalada:\n"
  ruby -v

  echo -e "\nInstalando rails..."
  gem install rails

  echo -e "\nVersao ruby instalada:\n"
  rails -v
fi