# Getting started with mbed OS

Ah, great, you're here! Thanks for the early interest in mbed OS. Let's get started, shall we?

The Getting Started section reviews the basics of creating an mbed OS application. We'll discuss how we write and build programs, and how they can be flashed to the boards.

Other sections on our website will introduce you to specific tools, such as the [testing,](http://mbed.com/en/development/software/tools/testing/) [security tools,](http://mbed.com/en/technologies/security/) and of course [mbed OS.](http://mbed.com/en/development/software/mbed-os//)

If you're not sure what it is you're supposed to program, read [What is mbed?](http://mbed.com/en/about-mbed/what-mbed/) and then come back.


## What's new with mbed: yotta build and registry

We have created yotta: a command-line tool that takes care of building, assembling and distributing programs and libraries. It’s available on Mac, Windows and Linux. It will soon be available pre-integrated with popular desktop and cloud IDEs.  

yotta organises software into modules. A yotta module is a collection of source files with the addition of a file called module.json. This file contains details such as the version, description, author, homepage, and a link to the repository containing the code. It also includes a list of other modules it depends on. Modules can be installed from many sources, including GitHub and other version control services.

The yotta registry indexes public modules and you can search it for libraries from within the yotta command-line tool.
To build a yotta program you can either create a new yotta executable or clone an existing one from a repository, then set the target and run 'yotta build' from the command line. yotta will pull in the program’s dependencies from the web and generate the executable. Pretty cool, huh?

For more information about yotta, [see our main site](http://mbed.com/en/development/software/tools/yotta/).

## Working with targets

Before you build anything with yotta, you select the target that you want to build for. The instructions for a particular development board tell you which target to use. You can also find target descriptions by searching the yotta registry.

## A first application


Now that you've been briefed, let's jump on over to the next section and get you started with [your first application](FirstProjectmbedOS.md).

______
Copyright © 2015 ARM Ltd. All rights reserved.
