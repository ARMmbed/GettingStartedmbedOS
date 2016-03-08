# The mbed OS User Guide

Welcome to the ARM® mbed™ OS user guide.

## Getting started

* [Set up your machine](installation.md): Installing yotta, the build tool for mbed OS.

* [Build your first mbed OS application](FirstProjectmbedOS.md): A simple example to get you going.

* [Extend the first application](Extended_LED.md) and review [other samples](GetTheCode).

* [Learn about mbed OS](about_mbed_os.md): A quick review of mbed OS features and code base, as well as its use of yotta.

## Applications on  mbed OS

A general review of how to write applications for mbed OS:

* [mbed OS applications with yotta](Full_Guide/app_on_yotta.md): The relationship between yotta and mbed OS, and how you can create yotta-based mbed OS applications. 

* [Writing applications for mbed OS](Full_Guide/app_on_mbed_os.md): Some general principles of mbed OS applications.

## mbed OS features

These chapters explain how to work with the various mbed OS features:

* [Interfacing to hardware](Full_Guide/Interfacing.md): How mbed OS controls different hardware.

* [Debugging mbed OS applications](Full_Guide/Debugging.md): Debugging for applications built with ARMCC and GCC.

* [Security with mbed TLS](Full_Guide/mbed_tls.md): Using mbed TLS for communication security in mbed OS.

* [Asynchronous programming with MINAR](Full_Guide/MINAR.md): Using the mbed OS schedular MINAR for asynchronous programming. 

* [Memory in mbed OS](Full_Guide/memory.md): Memory management and allocation in mbed OS. 

* [Networking with mbed OS](Full_Guide/networking.md): Networking options and structure on mbed OS.

* [Asynchronous I2C](Full_Guide/I2C.md): Two-wire serial bus protocol on mbed OS.

## Contributing to mbed OS and publishing modules

* [Creating and publishing your own modules and contributing to mbed OS](Full_Guide/contributing.md): The process and legal requirements for publishing modules as stand-alone or as part of the mbed OS code base.

* [Coding style and GitHub pull request guidelines](Full_Guide/Code_Style.md): Style guidelines for code and GitHub pull requests.

## What you need to know before reading the guide

This guide assumes that you are familiar with C++. While we do discuss how we applied some concepts in mbed OS, we don't explain the background to these concepts in any great detail. If you know C but not C++, you might find this [Coursera module](https://www.coursera.org/course/cplusplus4c) helpful.

The examples in this guide focus on the FRDM-K64F board. If you have another board, you'll have to check if it's already [supported on mbed OS](https://www.mbed.com/en/development/hardware/boards/) before you run the sample code. You should be able to follow the code and explanations even if you don't have compatible hardware.

### Additional sources

* [Further reading sources](FurtherReading.md): other mbed tools, hardware, community and partners. 

* Links to [our main code repositories and their documentation, as well as examples](GetTheCode.md).

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** For more details about mbed, [see our main site](http://mbed.com/en/about-mbed/what-mbed/).</span>


