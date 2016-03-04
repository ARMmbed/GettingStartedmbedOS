# Getting mbed OS and yotta

You don't "get" mbed OS in the same way that you get a new app on your phone. There is no mbed OS download and no way to install it on your machine.

Working with mbed OS means you use yotta to combine your own application code with the mbed OS code base. yotta gets the relevant parts of mbed OS for you from its own registry. So our guide walks you through working with yotta, then shows you how to write an application that can work with the mbed OS code base. But first, you'll have to get yotta.

There are three ways to get yotta: 

* [Our installers](#installers), which include the yotta dependencies.

* [A Docker container](#docker-container), which includes the yotta dependencies. 

* [Manual installation](#manual-installation) of yotta and all its dependencies.

## Installers

yotta has installers for OS X and Windows. They include an installation of all yotta dependencies. 

### OS X installer

1. Download the latest [OS X yotta.app](https://github.com/ARMmbed/yotta_osx_installer/releases/latest).

1. Drag ``yotta.app`` from the disk image into your Applications folder.

1. When you run ``yotta.app``, it opens a terminal where you can use yotta commands.

### Windows installer

1. Download the latest [yotta windows installer](https://github.com/ARMmbed/yotta_windows_installer/releases/latest).

1. Run the installer.

1. Click the ``Run Yotta`` shortcut on the desktop or in the start menu to run a session with the yotta path temporarily pre-pended to system path.

## Docker container

[See the Docker container instructions](docker_install.md).

## Manual installation

If you want to manually install yotta, please ensure you have your dependencies, then follow the instructions for your operating system.

### Dependencies

Before installing yotta, make sure you have:

* [Python 2.7](https://www.python.org/download/releases/2.7/). Python 3 support is experimental.

* [pip](https://pypi.python.org/pypi/pip).

### Manual installation instructions

* [OS X](http://yottadocs.mbed.com/#installing-on-osx).

* [Windows](http://yottadocs.mbed.com/#installing-on-windows).

* [Linux](http://yottadocs.mbed.com/#installing-on-linux).

## What's next?

Try the [Blinky quick guide](FirstProjectmbedOS.md) to get a first sample application working, or see the [full list of samples](GetTheCode.md).

You can also read the [full guide](Full_Guide/app_on_yotta.md) to understand how mbed OS and yotta work together. 
