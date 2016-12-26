SXAPI Installer
===============

[![Travis](https://travis-ci.org//startxfr/sxapi-installer.svg?branch=master)](https://travis-ci.org/startxfr/sxapi-installer)

This project help you building a full developement or production sxapi environement. 
Instead of manually installing these environement you can use this installer to setup your 
environement and start developping sxapi microservice within a minute. **SXAPI** is a microservice 
framework optimized for building simple and extensible API efficiently. 
You can have [more information on the sxapi-core project page](https://github.com/startxfr/sxapi-core)  


Getting Started
---------------

### Pre-requisites

* Fedora Linux OS (if not, [install virtualbox](https://www.virtualbox.org/wiki/Linux_Downloads) and [start a Fedora VM](https://wiki.dlib.indiana.edu/display/VarVideo/Installing+Fedora+23+on+a+VirtualBox+VM))
* root access (only for installing required software)
* wget tool (```sudo yum install -y wget```)

### Execute the installer

Run the following commands

```
su -
wget https://goo.gl/82RvZs -O sxapi-installer && chmod ug+x sxapi-installer && ./sxapi-installer
```

Menu is interactive. If you want to setup both workstation and server environement, you can execute again sxapi-installer. After installation, you can remove sapi-installer with `rm sxapi-installer`


### Installation type

#### Server installation

Install docker, docker-compose and [sxapi-console-cws](https://github.com/startxfr/sxapi-console/blob/dev/docs/3.CWS.md). Start docker daemon and sxapi-console-cws instance. 
After this installation, your server can execute one or multiple sxapi micro-services

#### Dev workstation installation

Install docker, docker-compose and [sxapi-console-cli](https://github.com/startxfr/sxapi-console/blob/dev/docs/2.CLI.md). Start docker daemon.
After this installation, your workstation can execute one or multiple sxapi micro-services based on the [sxapi-sample](https://github.com/startxfr/sxapi-sample/blob/dev/README.md)


### Troubleshooting

If you run into difficulties installing or running sxapi, please report [issue for installer](https://github.com/startxfr/sxapi-installer/issues/new) or  [issue for sxapi](https://github.com/startxfr/sxapi-core/issues/new).

License
-------

SXAPI is licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/).