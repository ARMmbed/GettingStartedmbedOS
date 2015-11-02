#Introduction 

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note**: This is an extract from the full mbed OS User Guide. The guide itself isn't ready yet, but we're releasing chapters as stand-alones as fast as we can.</span>

This chapter covers:

* [What a yotta executable - or mbed OS application - looks like](#mbed-OS-applications-as-yotta-executables).

* [How to initialize and build a project with yotta](#how-to-build-an-application).

* [Guidelines for mbed OS applications](#writing-applications-for-mbed-os).


<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">[You'll need to install yotta](../installation.md) to complete the examples in this chapter.</span>


## mbed OS applications as yotta executables

mbed OS applications are yotta executable modules, as opposed to yotta library modules:

>> "There are two sorts of things that yotta builds: libraries, and executables. Libraries are reusable, and the source code for them is distributed in the yotta registry. Executables are stand-alone programs that depend on libraries, and which are not normally published themselves."

This chapter focuses on yotta executables, but much of its information is also relevant for libraries.

### Structure of a yotta module 

An application and a library have similar structures:

* A module.json file.

* A source directory containing source files to compile.

* A headers directory with the same name as the module.

* A test directory.

* A readme.md file summarizing the API of the module.


<span style="display:block; text-align:center; padding:5px; border:1px solid #000;">
![](Images/module_struct.png)</span>

**The module.json file** describes:

* The name, [semantic version](http://semver.org/) and license information of this module. 

* Any dependencies that this module might have. 

* Executable indication. If this is missing, the module is a library. The executable indication is the parameter ``bin``, which holds the subdirectory that yotta should build into an executable.

**The source directory** and any subdirectories contain the source files that yotta will automatically use to build the library. Source files in any other top-level directories will normally be ignored.

**The headers directory** should have the same name as your module and should contain all (and only) the public headers that your module exposes to anyone that depends on it. The name must be the same as your module name so that `#include` directives look like `#include "modulename/a_header.h"`, which prevents conflicts between multiple modules that have headers with the same name. This directory is optional for applications, since applications don’t normally export an interface that can be used by other modules.

**The test directory** contains source files and subdirectories to compile into tests. yotta strongly encourages writing tests for modules (and makes it really easy!), because thorough testing is an important part of making software truly reusable. Any source files at the top-level of the test directory will be compiled into separate test executables, and the (recursive) contents of any subdirectories will each be compiled into a single test executable. You can use the [`yotta test` subcommand](http://yottadocs.mbed.com/tutorial/testing.html) to automatically build and run these tests.

## How to build an application

This section builds the sample application ``blinky``, which turns a LED on our boards on and off. The build target we'll use is the [FRDM-K64F board](https://www.mbed.com/en/development/hardware/boards/freescale/frdm_k64f/) with the [gcc toolchain](https://launchpad.net/gcc-arm-embedded). We'll be using this sample several times in the guide, so it's well worth your time to build it.

### Overview

To build our application with mbed OS and yotta, we need to:

1. [Initialize a yotta module as an executable](#initializing-a-yotta-executable-module).

1. [Set a target](#yotta-targets).

1. [Install dependencies](#installing-dependencies).

1. [Add application files](#adding-project-code) to the ``source`` folder.

1. [Build the module](#building-the-module).


<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** When working with yotta in a command line prompt or terminal, you must navigate to your module directory before calling yotta.</span>

### Initializing a yotta executable module

If you have [yotta installed](http://yottadocs.mbed.com/#installing) on your computer, you can use ``yotta init`` to construct a new skeleton module in an empty directory by answering a simple series of questions. For example, here is how to initialize the [Blinky sample application](https://github.com/ARMmbed/example-mbedos-blinky) that we'll use later:

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** There is only one difference between initializing a library module and an executable module, and that is the selection between library and executable. We'll see soon where that selection is made.</span>

* The first step is to create a directory called ``blinky``. In a terminal or CMD:

	``user$ mkdir blinky``

* Navigate to it, because you need to call yotta from the directory in which you expect it to work:

	``user$ cd blinky``
* Now to initialize the module:

	``user$ yotta init``

* yotta begins to ask questions about the module. It offers a default answer for all questions; press Enter to accept the default, or enter a different answer and press Enter. Please note:

 * "Enter the initial version": The default version is 0.0.0. You can use [``yotta version``](#Versioning-an-existing-yotta-module) to edit the version before every release.

 * "Keywords": Enter keywords with a comma between them. Keywords help people find your module, so they should describe what it does.

 * "Repository URL": The default repository address is empty, and you may leave it like that. If you want to link to a repo, please note that you can't use the simple URL - you must use the SSH clone URL that GitHub offers. In our example, that will be ``ssh://git@github.com:ARMmbed/example-mbedos-blinky.git``. Please note that this link is for information purposes only; yotta doesn't download code from the repo.

 * "What is the license for this project": The default license is Apache-2.0, but you can enter a different one, such as ISC or MIT.

 * "Is this module an executable": The default setting of a project is as a library. Please enter "yes" if your project is an executable.

<span style="display:block; text-align:center; padding:5px; border:1px solid #000;">
![](Images/yotta_init.png)</span>

* When you've answered all of the questions, yotta will create the basic file structure you need. You can view it with the command ``ls``:

```
user$ ls
module.json	my_blinky	source		test
```

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** you can use ``yotta init`` in an existing module to modify it at any time. Your previous answers will be shown as the default, so you can edit only the ones that need to change; simply press Enter to accept all other answers.</span>

### Versioning an existing yotta module

A yotta module's version structure is major.minor.patch, and the default for a new module is 0.0.0. The version is listed in the ``module.json`` file of your module.

As your project progresses, you will of course want to change versions. Please:

* Change the *major* if you have new functionality that is *not* backwards compatible.

* Change the *minor* if you have new functionality that is *fully* backwards compatible. 

* Change the *patch* if you have only backwards compatible bug fixes or changes that don't affect behaviour, like whitespace edits.

To change the version:

1. Use ``yotta version`` to check the current version of your module.

1. Use ``yotta version <flag> <new_number>`` to edit the version. Use ``patch``, ``minor`` and ``major`` flags to change only the relevant part of the version number. yotta increments it by 1, to prevent mistakes.

For example:

```
user$ cd Blinky
user$ yotta version
info: @0.0.0 //current version of Blinky
user$ yotta version patch // new patch version (goes up by 1)
user$ yotta version
info: @0.0.1
```

We could also have used ``yotta version minor`` for a minor version (0.1.0) or ``yotta version major`` for a major version (1.0.0).

### yotta targets

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** The full explanation for yotta targets is on the [yotta documentation site](http://yottadocs.mbed.com/tutorial/targets.html). Earlier in this document (that chapter will be published soon), we reviewed how yotta targets and the hardware implementation work together. Here, we'll explain only a couple of concepts and the basic yotta commands.</span>

yotta can build your code for different targets: different boards and operating systems. It can also use different compilers. This means you don't have to re-write code every time you want to test or deploy on a new kind of board. It also means you need to explicitly identify your target to yotta. Identifying a target means naming both the hardware and build toolchain you'll be using. We'll see how to do all this in the following sections.

#### Searching for targets

The yotta registry has a list of targets. You can search it using ``yotta search target``. You might want to use the ``--limit`` option and specify a number of results:

```
yotta search --limit 1000 target
```

Let's look at the top three results:

```
frdm-k64f-gcc 0.0.24: Official mbed build target for the mbed frdm-k64f 
development board.

frdm-k64f-armcc 0.0.16: Official mbed build target for the mbed frdm-k64f 
development board, 
using the armcc toolchain.

bbc-microbit-classic-gcc 0.1.3: Official mbed build target for the mbed nrf51822 
development board, 
using the armgcc toolchain.

```
As you can see, each target returns a name and a version, as well as a description. Note that the name includes a build toolchain - ``gcc`` or ``armgcc`` - because a target is both the board and the build toolchain we use, never just one or the other.

#### Setting a target

The ``target`` command has two uses: to check what the current target is, and to set a new target.

* Used on its own, ``target`` tells you what the current target is. Since targets can depend on other targets, ``yotta target`` might list more than one target. In this case, the first target in the list is the actual build target and the rest are the target(s) from which the current build target inherits: 

```
yotta target
frdm-k64f-gcc 0.0.24
mbed-gcc 0.0.14
```

* Used with a target name, ``target`` sets a new target:

```
yotta target bbc-microbit-classic-armcc
```

#### Creating your own target

To learn about creating a new target, please see the [yotta documentation site](http://yottadocs.mbed.com/tutorial/targets.html).

### Building your project

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** you must set a target before building, as explained above.</span>

#### Module dependencies

mbed OS is structured as a set of modules. Each module declares which other modules it depends on. When you build a module, yotta looks at these dependencies and installs the necessary modules before completing the build.

This is also how we build applications for mbed OS. Each application declares dependencies that are either mbed OS official modules, or modules created by the community or the developer to provide a specific functionality.

When we build our application, yotta will download from the yotta Registry:

* Modules we listed in our ``module.json``.

* For each of the modules we listed, the other modules that module itself lists in its ``module.json``.

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** Because yotta downloads dependencies from the yotta Registry, you must be online the first time you build.</span>

#### mbed-drivers

We saw the core modules mbed OS needs (that chapter will be published soon). Each of these modules depends on other modules. All mbed OS modules are available on the yotta Registry.

For example, here is a partial tree for **Blinky**. It shows Blinky's two dependencies: ``mbed-drivers`` and ``uvisor-lib``. Then it shows the start of the next level of dependencies: ``uvisor-lib`` has only one dependency, whereas ``mbed-drivers`` has several. These, in turn, have their own dependencies. And so on:

<span style="display:block; text-slign:center; padding:5px; border:1px solid #000;">
![](Images/yotta_dep.png)</span>

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** The list of dependencies for any application may change without warning; Blinky's changed while we were writing this chapter.</span>

Our dependencies are listed in the [``module.json``](#Structure-of-a-yotta-module) file for our module. Below, we explain how to list dependencies from the yotta Registry, GitHub and privately hosted sources.

##### module.json: dependencies from the yotta registry

To add dependencies from the yotta registry, list them in the ``module.json`` file by name and version:


```
  "dependencies": {
"mbed-drivers": "~0.8.3",
	"my_dependency": "^1.2.3"
  },
```


<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** Run ``yotta install mbed-drivers`` in your project's directory to automatically include ``mbed-drivers`` with a correct version.</span>

Selecting the dependency version:

* When you add a dependency to ``module.json``, you want to list the current version number, for example 1.2.3.

* In front of the version number, you can add a specifier (^ or ~, or even something like ">=1.2.3,<2.3.4") that controls version updates. It limits the versions yotta will allow updates to when using ``yotta update``:
 * ^: Update to any semantic-version compatible module (matching major version for >=1.x versions).
 * ~: Accept patch-version updates only.

Using ``yotta install <dependency_name>``, rather than manually editing ``module.json``, will use the correct version specifier automatically. 

For modules with a 0.x version number, we recommend using ``~`` rather than ^. Even though semantic versioning specifies that any update may break compatibility, if you are using 0.x versions of something you're accepting some breakage anyway, and using ^ will prevent you from getting any updates.

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** For more information about versions and specifiers, see the [yotta documentation site](http://yottadocs.mbed.com/reference/module.html#dependencies).</span>

##### module.json: dependencies from GitHub repositories

You can use modules from GitHub repositories - private or public:


```
"dependencies": {"my_github_dependency": "username/reponame"}
```

yotta uses a shorthand for GitHub URLs. It has two parts: <user_name>/<repo_name>. For example, to include yotta itself:


```
"dependencies": {"yotta": "ARMmbed/yotta"}
```

yotta supports GitHub formats to specify branches and tags:

* ``username/reponame#<versionspec>``

* ``username/reponame#<branchname>``

* ``username/reponame#<tagname>``


##### module.json: dependencies from other sources


The yotta Registry and GitHub are the two methods we recommend, but we do support using git and mercurial directly.

The options are:

* git+ssh:``//example.com/path/to/repo``

* anything:``//example.com/path/to/repo.git``

* hg+ssh:``//example.com/path/to/repo`` (mercurial)

* anything:``//example.com/path/to/repo.hg`` (mercurial)

For example, to include a privately hosted git repository from ``example.com``:

```"dependencies": {"usefulmodule": "git+ssh://user@example.com:path/to/repo"}```

Git URLs support branch, version and tags specifications:

* git+ssh:``//example.com/path/to/repo#<versionspec, branch or tag>``

* anything:``//example.com/path/to/repo.git#<versionspec, branch or tag>``

Currently, mercurial URLs only support a version specification:

* hg+ssh:``//example.com/path/to/repo#<versionspec>``

* anything:``//example.com/path/to/repo.hg#<versionspec>``

#### Installing dependencies

When we have a dependency, we need to install it before we can build our own project. This needs to be done from the module directory.

In our Blinky example, we need to install ``mbed-drivers``:

```
user$ cd blinky
user$ yotta install mbed-drivers
```

We need to be online for the installation to work, because yotta downloads the modules from the yotta Registry. 

#### Adding project code

To complete the build, please copy the ``blinky.cpp`` file from the [example directory](https://github.com/ARMmbed/example-mbedos-blinky). Place it in the ``source`` directory under your ``blinky`` directory.

This is our actual application code, and we'll rename the file ``main.cpp``. Although Blinky will work if we don't do this (because it has only one CPP file), it's a good habit to get into. 

	``/blinky/source/main.cpp``

#### Building the module

The build command (like the target command) must be performed from within the directory of the module we're trying to build. It must also be performed after selecting a yotta target. 

For example, if I'm working with the ``blinky`` directory we saw above:

```
user$ cd blinky
user$ yotta target frdm-k64f-gcc
user$ yotta build
```

The built executable (a binary) will be created at ``./build/<target_name>/source/<module_name>``. So the result of that build will be at ``blinky/build/frdm-k64f-gcc/source/``.

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** Some targets require a HEX file, not a BIN. yotta knows which file type to build based on the target description.</span>

#### Flashing the application to the board

The file you need to flash onto the mbed-enabled board is ``my_blinky.bin``:

1. Connect the board to your computer using a micro-USB cable.

1. The board is shown as removable storage.

1. From your file explorer, drag and drop the file onto the board.

1. The application is now on your board and should start working immediately. Note that some boards need a reset.

## Building a project: summary

To build our ``blinky`` project with mbed OS and yotta, we:

1. Created a new directory and navigated to it in our Terminal or other command-line tool.

1. Initialized a yotta module:
	1. ``yotta init``.

1. Set a target:
	1. ``yotta search`` to search for one.
	1. ``yotta target <name_of_target>`` to set one.
	1. ``yotta target`` to check that our target was set.

1. Installed dependencies:
	1. ``yotta install mbed-drivers``.

1. Added application files to the ``source`` folder:
	1. File copied from the example GitHub repository and renamed ``main.cpp``.

1. Built the module:
	1. ``yotta build``.

1. Copied our binary to the board over micro-USB.


## Writing applications for mbed OS

This section shows the general structure of an application running on mbed OS, and discusses best practices for coding (coming soon).

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** We'll be using Blinky, the same application we used earlier to learn about yotta and the project build process. You should already have Blinky built. If you don't, please take a look at the [quick guide](https://docs.mbed.com/docs/getting-started-mbed-os/en/latest/FirstProjectmbedOS/) and follow the instructions there.</span>

### Blinky's code

Blinky's code is quite short, but it's enough to show a few general mbed OS application concepts:

```
#include "mbed-drivers/mbed.h"

static void blinky(void) {
static DigitalOut led(LED1);
    led = !led;
    printf("LED = %d \r\n",led.read());
}

void app_start(int, char**) {
    minar::Scheduler::postCallback(blinky).period(minar::milliseconds(500));
}
```
### Including headers and libraries in your application

You can include headers and libraries in your application by using the standard C++ ``#include`` directive.

You must explicitly include mbed OS functionality. This requires including only ``mbed.h``; the rest of the mbed OS code base is then included either by ``mbed.h`` itself or by one of the files it includes. 

Including other functionality might require more complicated inclusion lists, although ideally you should be able to include only the header file for each library you need.

Note that including requires the full path to the file:

```
#include "mbed-drivers/mbed.h"
```

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** There are limitations on the path and file names. For more information about this, please see the [yotta documentation](http://yottadocs.mbed.com/tutorial/tutorial.html).</span>

Please remember that for the compilation to work correctly, yotta has to know where the included file comes from. That requires listing dependencies in the ``module.json`` file, as [explained above](). In our case, ``mbed.h`` is part of ``mbed-drivers``, which we installed earlier, so yotta has no problem using it in the build.

### app_start() - starting the application

To start an application in mbed OS, we need an ``app_start()`` function, replacing the standard ``main()`` of other CPP programs:


```
void app_start(int, char**) {

}
```
``app_start`` should be in a file called ``main.cpp``, and must be void.

### MINAR

mbed OS starts MINAR (that chapter will be published soon) implicitly; you only need to call it explicitly if you want to pass a particular function that will be executed later to it (using ``postCallback``).

**Note:** MINAR will be reviewed in detail in a future chapter of the guide. Until then, you can read the [explanation in the MINAR repository](github.com/ARMmbed/minar).



### Using mbed OS features

All of the features that we reviewed earlier - MINAR, memory management, security and so on - are available for all hardware unless explicitly documented otherwise.

The basic include for every mbed OS application is ``mbed.h``. It starts an inclusion chain that makes all basic mbed OS features available to your application.

If you're not sure whether or not you need to explicitly include something in your application, ask for advice [on the forums](https://forums.mbed.com). 


### Debugging and testing your application

Debugging and testing are subjects worthy of their own guides. Until we have those written, please see:

* [Our current debugging articles](docs.mbed.com/docs/debugging-on-mbed/en/latest/). Note that they currently focus on mbed Classic, but many of the ideas they present are applicable to mbed OS.


* Our testing suite, Greentea. It is currently documented only in its [GitHub repoistories](https://github.com/ARMmbed/greentea). We're working on a new guide for it.

### Flashing an application to the board

mbed OS applications are binary files (or HEX). They're built locally (in your computer's project directory) and must be flashed (copied to) the board.

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** yotta builds a separate application binary for each target under you application directory. In our example, the binary will be at ``/blinky/build/frdm-k64f-gcc/source/``. The file is ``my_blink.bin``.</span>

To flash it to your board:


1. Connect the board to your computer using a micro-USB cable.

1. The board is shown as removable storage.

1. From your file explorer, drag and drop the file onto the board.

1. The application is now on your board and should start working immediately. Note that some boards need a reset.

### Publishing your application

You can make your code public by committing it to version control (we commit ours to GitHub). You can go one step further and [publish your module](http://yottadocs.mbed.com/tutorial/release.html) to the yotta registry (but please note that publishing an application (as opposed to a library) to the registry is not part of the regular yotta workflow and gives little to no additional benefit in practice).
