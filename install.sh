#!/bin/bash

function displayStartInstallation {
    echo "" 
    echo "==================================" 
    echo "== SXAPI Installer (master)"
    echo "==================================" 
    echo ""
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

function checkDockerCompose {
    VERSION="1.8.0"
    URL=https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s`-`uname -m`
    if [ ! -f /usr/local/bin/docker-compose ]; then
        echo " - docker-compose : NOT FOUND"
        echo -n "   Installing docker-compose ... "
        if curl --output /dev/null --silent --head --fail "$URL"; then
            curl -L "$URL" > /usr/local/bin/docker-compose
            chmod +x /usr/local/bin/docker-compose
            echo "DONE"
        else
            echo "ERROR"
            echo "   Could not download docker-compose v$VERSION" 
            exit;
        fi
    else 
        echo " - docker-compose : FOUND"
    fi
}

function checkSxapiCli {
    VERSION="master"
    URL=https://raw.githubusercontent.com/startxfr/sxapi-console/$VERSION/cli.sh
    if [ ! -f /usr/local/bin/sxapi-installer ]; then
        echo " - sxapi-cli : NOT FOUND"
        echo -n "   Installing sxapi-cli ... "
        if curl --output /dev/null --silent --head --fail "$URL"; then
            curl -L "$URL" > /usr/local/bin/sxapi-cli
            chmod +x /usr/local/bin/sxapi-cli
            echo "DONE"
        else
            echo "ERROR"
            echo "   Could not download sxapi-console v$VERSION" 
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
checkRootAccess
checkDependency "git"
checkDependency "curl"
checkDependency "wget"
checkDependency "docker-io"
checkDockerCompose
checkSxapiCli
displayEndInstallation