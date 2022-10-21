#!/bin/bash

#============== CODIGOS ESTILOS ============#
Bold=$(tput bold)
Norm=$(tput sgr0)
Yellow=$(tput setaf 3)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Magenta=$(tput setaf 5)
#============================================#

install_dependency(){
    echo "[-] Instalando modulos do projeto assistent."
    if [[ $(npm install ci) ]]
    then
        if [[ $? -eq 0 ]]
        then
            echo "${Green}[*] Modulos já instalados e pronto para uso.${Norm}"
        else
            echo "${Red}[!] Houve erro ao instalar dependências, isso pode implicar no funcionamento do bot.${Norm}"
        fi
    fi
    pm2_install
}

pm2_install(){

    echo "${Magenta}[-] PM2 Configurando variavel global${Norm}"
    npm install pm2 --location=global
}

puppeteer_libs(){

    echo "${Magenta}[-] Instala bibliotecas para funcionamento do pupputeer.${Norm}"
    sudo apt-get install libpangocairo-1.0-0 libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 libxi6 libxtst6 libnss3 libcups2 libxss1 libxrandr2 libgconf2-4 libasound2 libatk1.0-0 libgtk-3-0 libdrm.so.2 libgbm.so.1 
    sudo apt-get install -y libgbm-dev
}

install(){

    if [[ -n $( echo $NVM_DIR ) ]]
    then
        echo "${Green}[-] NVM já instalado.${Norm}"
        install_dependency
    else
        echo "${Magenta}[-] Instalando gerenciador node.${Norm}"
        wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
        source ~/.profile
        nvm install 16
        nvm use 16
        echo "${Green}[-] NVM instalado e apontado para o node na versão 16.${Norm}"
        apt-get install npm
        install_dependency
    fi

}


echo "${Bold}${Yellow}[-] Instalando dependências${Norm}${Norm}"
install
