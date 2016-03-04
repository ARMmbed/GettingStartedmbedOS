# Installing mbed OS and yotta

Like many open source operating systems, mbed OS is distributed as source code. You use yotta to fetch all the modules that you require to build for your hardware. Once you’ve done that, yotta works as an offline build tool that combines mbed OS and your application code into a single executable. All this means that you don't install mbed OS on your computer - you simply install yotta, and let it work for you.

There are three ways to install yotta: 

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
