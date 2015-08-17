# Getting started with the new mbed OS

Ah, great, you're here! Welcome to the new mbed. it's great to have you. Let's get started, shall we? 

The Getting Started section reviews the basics of programming for mbed Enabled devices. We'll discuss how we write and build programs, and how they can be flashed to our boards. 

Other sections on our website will introduce you to specific tools, such as the [testing](http://mbed.com/en/development/software/tools/testing/) and [security](http://mbed.com/en/technologies/security/) tools, and of course [mbed OS](http://mbed.com/en/technologies/technology-mbed-os/), our new operating system for mbed Enabled boards. 

There is also a [migration guide](MigrationGuide.md), if you're an experienced mbed user who wants to migrate existing projects to the new tools.

If you're not sure what it is you're supposed to program, read [What is mbed?](http://mbed.com/en/about-mbed/what-mbed/) and then come back.

## What's new with mbed: yotta build and registry

First, let's talk about what's changed since mbed 2.0. We'll start at the end: building.

In mbed 2.0, development relies on a proprietary online compiler with offline project files for various IDEs. 

We now have yotta. yotta is a command-line tool that takes care of building, assembling and distributing programs and libraries. It’s available on Mac, Windows and Linux. It will soon also be available pre-integrated with popular desktop and cloud IDEs.  

yotta organises software into modules. A yotta module is a collection of source files with the addition of a file called module.json. This file contains details such as the version, description, author, homepage, and a link to the repository containing the code. It also includes a list of other modules it depends on. Modules can be built from many sources, including GitHub and other version control services.

The yotta registry indexes public modules and you can search the it for libraries from within the yotta command-line tool.

To build a yotta program you can either create a new yotta program or clone an existing one from a repository, and then run 'yotta build' from the command line. yotta will pull in the program’s dependencies from the web and generate a binary. From this point on programming the board is the same old drag-and-drop. 

For more information about yotta, [see here](http://mbed.com/en/development/software/tools/yotta/).

## Working with targets

One of the most important features of yotta is the ability to compile the same software for different compilation targets (different development boards, embedded devices, or even desktop targets). This includes allowing modules to adapt the way that they work to different target devices.

Before you build anything with yotta, you select the target that you want to build for (we'll see later how that's done). The instructions for a particular development board or shield will tell you which target to use to build software for that hardware target, or you can find target descriptions by searching the yotta registry (we'll see that later, too).

_____

Now that you've been briefed, let's jump on over to the next section and get you started with [your first project](FirstProject.md).