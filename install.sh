#!/bin/bash

SXAPI_CONSOLE_REPO="startxfr/sxapi-console"
SXAPICLI_VERSION="master"
SXAPICWS_VERSION="master"
DOCKERCOMPOSE_VERSION="1.5.0"


function displayStartInstallation {
    echo "" 
    echo "==================================" 
    echo "== SXAPI Installer (v0.1)"
    echo "==================================" 
    displayMenu
}

function displayMenu { 
    echo ""
    echo "1. Install server"
    echo "2. Install dev workstation"
    echo "9. Exit"
    echo -n "Enter your choice : "
    read menu
    if  [  "$menu" == "1"  ]; then
        displayInstallServer
    elif  [  "$menu" == "2"  ]; then
        displayInstallWorkstation
    elif  [  "$menu" == "9"  ]; then
        exit 1
    else
        displayMenu
    fi
}

function displayInstallServer { 
    checkRootAccess
    checkDependency "curl"
    checkDependency "jq"
    checkDependency "docker-io"
    checkDockerStarted
    checkDockerCompose
    checkSxapiCws
    echo " - Server installed"
    echo "   if you want to start creating a microservice"
    echo "   you can now run sxapi-cli command"
    displayMenu
}

function displayInstallWorkstation { 
    checkRootAccess
    checkDependency "curl"
    checkDependency "jq"
    checkDependency "wget"
    checkDependency "git"
    checkDependency "unzip"
    checkDependency "docker-io"
    checkDockerStarted
    checkDockerCompose
    checkSxapiCli
    echo " - workstation configured"
    echo "   if you want to start creating a microservice"
    echo "   you can now run sxapi-cli command"
    displayMenu
}


function checkRootAccess {
    if [ "$(id -u)" != "0" ]; then
        echo "! This script must be run as root"
        echo "! Please run 'su root' and start again"
        echo "! this installer"
        exit;
    else 
        echo " - root access : OK"
    fi
}

function checkDependency {
    PKGNAME=${1}
    PKEXIST=$(rpm -qa | grep -c $PKGNAME)
    if [ $PKEXIST == "0" ]; 
    then
        echo " - $PKGNAME : NOT FOUND"
        echo -n "   Installing $PKGNAME ... "
        yum install -y $PKGNAME &> /dev/null
        echo "DONE"
    else 
        echo " - $PKGNAME : FOUND"
    fi
}

function checkDockerStarted {
    if [ "$(docker version --format='{{.Server.Version}}' 2>/dev/null | head -n 1)" == "" ]; then
        echo " - docker : NOT RUNNING"
        echo "   starting docker ... "
        systemctl restart docker
    fi 
    SERVER_VERSION=$(docker version --format='{{.Server.Version}}' 2>/dev/null | head -n 1)
    SERVERAPI_VERSION=$(docker version --format='{{.Server.ApiVersion}}' 2>/dev/null | head -n 1)
    CLIENT_VERSION=$(docker version --format='{{.Client.Version}}' 2>/dev/null | head -n 1)
    CLIENTAPI_VERSION=$(docker version --format='{{.Client.ApiVersion}}' 2>/dev/null | head -n 1)
    if [ "$SERVER_VERSION" == "" ]; then
        echo " - docker server : COULD NOT START DOCKER "
        echo "   see troubleshooting for docker"
        exit
    else 
        echo " - docker server : " $SERVER_VERSION " (api v$SERVERAPI_VERSION)"
        echo " - docker client : " $CLIENT_VERSION " (api v$CLIENTAPI_VERSION)"
    fi
}

function checkDockerCompose {
    URL=https://github.com/docker/compose/releases/download/$DOCKERCOMPOSE_VERSION/docker-compose-`uname -s`-`uname -m`
    if [ ! -f /usr/local/bin/docker-compose ]; then
        echo -n "   Installing docker-compose ... "
        if curl --output /dev/null --silent --head --fail "$URL"; then
            curl --silent -L "$URL" > /usr/local/bin/docker-compose
            chmod +x /usr/local/bin/docker-compose
            echo "DONE"
        else
            echo "ERROR"
            echo "   Could not download docker-compose v$DOCKERCOMPOSE_VERSION" 
            exit;
        fi;
    fi;
    COMPOSER_VERSION="$(docker-compose version --short)"
    echo " - docker compose : " $COMPOSER_VERSION
}

function checkSxapiCli {
    URL=https://raw.githubusercontent.com/$SXAPI_CONSOLE_REPO/$SXAPICLI_VERSION/cli.sh
    if [ ! -f /usr/local/bin/sxapi-installer ]; then
        echo " - sxapi-cli : NOT FOUND"
        echo -n "   Installing sxapi-cli ... "
        if curl --output /dev/null --silent --head --fail "$URL"; then
            curl --silent -L "$URL" > /usr/local/bin/sxapi-cli
            chmod +x /usr/local/bin/sxapi-cli
            echo "DONE"
        else
            echo "ERROR"
            echo "   Could not download sxapi-cli v$SXAPICLI_VERSION" 
            exit;
        fi
    else 
        echo " - sxapi-installer : FOUND"
    fi
}

function checkSxapiCws {
    URL=https://raw.githubusercontent.com/$SXAPI_CONSOLE_REPO/$SXAPICWS_VERSION/cws.sh
    if [ ! -f /usr/local/bin/sxapi-installer ]; then
        echo " - sxapi-cws : NOT FOUND"
        echo -n "   Installing sxapi-cws ... "
        if curl --output /dev/null --silent --head --fail "$URL"; then
            curl --silent -L "$URL" > /usr/local/bin/sxapi-cws
            chmod +x /usr/local/bin/sxapi-cws
            echo "DONE"
        else
            echo "ERROR"
            echo "   Could not download sxapi-cws v$SXAPICWS_VERSION" 
            exit;
        fi
    else 
        echo " - sxapi-installer : FOUND"
    fi
}

function displayEndInstallation {
    echo ""
    echo "   sxapi-installer"
    echo "   microservices build on top of sxapi."
    echo "   to see how it work, please visit http://github.com/startxfr/sxapi-sample"
    echo "   or you can try by running"
    echo "   # docker-compose up sample"
    echo ""
}

displayStartInstallation
displayEndInstallation