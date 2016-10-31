SXAPI Installer
===============

[![Travis](https://travis-ci.org//startxfr/sxapi-installer.svg?tag=v0.0.5)](https://travis-ci.org/startxfr/sxapi-installer)

***SXAPI*** is a microservice framework optimized for building simple and extensible API efficiently. 


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
wget https://goo.gl/KdGNDH -O - | bash
```

### Troubleshooting

If you run into difficulties installing or running sxapi, please report [issue for installer](https://github.com/startxfr/sxapi-installer/issues/new) or  [issue for sxapi](https://github.com/startxfr/sxapi-core/issues/new).

License
-------

SXAPI is licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/).