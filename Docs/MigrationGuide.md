# Migrating from mbed Classic

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** these instructions are about migrating classic mbed libraries and applications to build with yotta, not about migrating to mbed OS (which uses yotta as its build system, but also includes significant changes to the mbed API). Building with yotta is only part of the necessary process to be compatible with mbed OS.</span>

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** currently the number of targets that we support for building mbed 2 projects with yotta is limited to seeedtinyble and BBC micro:bit.</span>

The build system used by mbed OS, [yotta](http://mbed.com/en/development/software/tools/yotta/), can also be used to build mbed 2 projects, allowing you to build them offline, and making it easier to re-use code between mbed 2 and mbed OS.

To add yotta support to a classic library or application it is first necessary to ensure any libraries that it depends on can already be built using yotta, and have already been [published](http://docs.yottabuild.org/reference/commands.html#yotta-publish) to the yotta registry.

The classic mbed v2 SDK is published as a yotta module under the name [mbed-classic](http://yottabuild.org/#/module/mbed-classic/0.0.2). Note that this module includes **only** the core mbed APIs, and does not include any of the other mbed libraries (RTOS, net, filesystem, etc.). These may be published as separate modules in the future.

Before adding yotta support to an mbed 2 project it's a good idea to familiarise yourself with yotta by following [the yotta tutorial](http://docs.yottabuild.org/tutorial/tutorial.html). You will also need to [install yotta](http://docs.yottabuild.org/#installing) and its dependencies, including a supported compiler.

# Some background

##The mbed Classic build system

The mbed Classic build system, which is used in the online IDE, and understood by the exporters from the online IDE to other build systems, follows a simple set of rules to build things:

* All source files in each library or application are compiled as object files, and then linked into the final library or application.

* All directories are searched for any header files specified in `#include` statements.

## Automatic yotta builds

Unlike the mbed classic build system, yotta will only automatically build source files in certain top-level directories (and their subdirectories). These are:

* `./source`: All the source files in this directory and any subdirectories will be compiled into a library (for modules) or your binary (for applications).

* `./test`: Any source files at the top-level will be compiled into separate test applications, and all of the files in each top-level directory (including any subdirectories) will be compiled into a test application. Each test application must include source file(s) that define exactly one `main()` function.

yotta also treats include paths differently. Only the root directory of a module is always in the include path. By convention, public header files for a module are placed in a subdirectory of this root directory that has the same name as the module name. This allows other modules to include public headers by using `#include "modulename/headername.h"`.

Additionally, the current directory of a source file is searched when compiling that file (but any other directories containing source files are not searched). These differences in the header search paths are designed to make it less likely that files in different modules that have the same name will collide with each other, which would cause mysterious build failures.

yotta also supports [using CMake](http://www.cmake.org/) to define more complicated build rules (more on that later).

# Migrating a simple project

If your library or application depends only on the core mbed SDK, then migrating it is easy. You need only to make sure it itself builds with yotta, and to add a dependency to the mbed-classic yotta module that we publish.

## Step 1: Add module.json

Every module or application that builds with yotta has a [module.json file](http://docs.yottabuild.org/reference/module.html). This file describes the module's name, its [semantic version](http://semver.org/), what other modules it depends on, what license it may be used under, and other things about the module.

The first step in making a module or application build with yotta is adding this file, which might look like this:

```
{
    "name": "my-library",
    "version": "0.0.1",
    "license": "Apache-2",
    "description": "Describe what your library does here!",
    "keywords": ["mbed-classic", "keywords", "describing", "your", "module"],
    "author": "Your Name <you@example.com>",
    "homepage": "http://github.com/yourname/yourrepository",
    "dependencies":{
    }
}
```

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** please tag your module with mbed-classic so that people searching for it can find it by searching the [yotta registry](https://yottabuild.org/).</span>

If you're building an application (instead of a re-usable library module), then you will also add this property, so that yotta builds an application from the contents of the source directory, instead of a library:

	"bin": "./source"
## Step 2: Add dependencies

Your library probably depends on the classic mbed SDK. To add this as a dependency, you can edit the dependencies section of your module.json file so that it looks like this:

```
    "dependencies":{
        "mbed-classic": "~0.0.2"
    }
```

Alternatively you can run this yotta command (in the directory of your module), and yotta will add the dependency for you:

	yotta install --save mbed-classic

If you have other dependencies that had already been converted into yotta modules (and published to the yotta registry), then add them now in the same way.

## Step 3: Move files

For yotta to build your source files, you need to move them into a directory called "source". Similarly, the convention with yotta modules is for any public header files that someone would `#include` when using the module to be placed in a directory with the same name as the module. You will end up with a directory structure like this:

```
yourmodule
    |_ yourmodule
    |   |_ some_header.h
    |   \_ another.h
    |_ source
    |   |_ subdir
    |   |   |_ bar.c
    |   |   \_ foo.cpp
    |   \_ baz.c
    |_ test
    |    ...
    \_ module.json
```

## Step 4: Building

To build your library you first need to select a target. For example, to select the seeedtinyble board and gcc compiler you would run this command in your module's directory:

	yotta target seeedtinyble-gcc

After selecting the target, you can build! Run `yotta build` in the directory containing your module:

```
yotta build
info: generate for target: seeedtinyble-gcc 0.0.2 
at ./yotta_targets/seeedtinyble-gcc
GCC version is: 4.8.4
-- The ASM compiler identification is GNU
-- Found assembler: /usr/local/bin/arm-none-eabi-gcc
-- Configuring done
-- Generating done
-- Build files have been written to: ./build/seeedtinyble-gcc
Scanning dependencies of target mbed-classic
...
Linking CXX executable yourapplication
hexifying and adding softdevice to yourapplication
[100%] Built target yourapplication
```

## Step 5: Fixing problems

When building you will probably encounter some compilation errors. Most likely these are caused by the changes to the include paths that yotta sets up compared to the classic mbed build system. You will now need to make sure you use `#include "yourmodule/some_header.h"` when including `some_header.h` in the example above, instead of simply doing `#include "some_header.h`.

As you are fixing compilation problems you might also take this opportunity to [add some tests](http://docs.yottabuild.org/tutorial/testing.html) to your module.

## Step 6: Publishing modules

After you've converted a module to build with yotta you can [publish it](http://docs.yottabuild.org/tutorial/release.html) to the yotta registry. Before doing that you'll want to make sure that you've added a readme.md, and that all the fields in your module.json are correct (for example, make sure that you've included the correct license declaration, and that your description and keywords are accurate).

# Maintaining compatibility with mbed v2

The classic mbed build system will automatically build all source files in all subdirectories, so a module that has been converted to build with yotta by moving source files into this directory should still build successfully in the classic mbed.

Similarly, while yotta requires that public headers by placed in a top-level subdirectory with the same name as the module name (so that other users of you module include files by doing `#include "modulename/headername.h"), the classic mbed build system adds every folder to the include path, so you will still be able to do `#include "headername.h"` in mbed 2 (Although it would still be a good idea to use `"modulename/headername.h"` to reduce the chance of accidentally including a different header from a different module).

# Appendix: Migrating a complex application

The rules to migrate a simple application should cover the vast majority of all mbed modules, but for some they will not be sufficient. yotta allows more complex build rules to be defined by adding CMakeLists.txt files to your module.

# Potential pitfalls

One significant difference between the mbed Classic build system and the yotta build system is that yotta will compile each module that your application uses into a separate static library archive, and then link these archives into your application. Because of the way archive linking works, this means that weak symbol overrides will not necessarily be picked up in the same way.

If you have a source file in a library that defines weak symbol overrides, then these will not be included unless something else from that source file (and hence that object within the archive) is being linked into the final application. It is not recommended to use weak symbols as part of the API of modules in yotta (because it makes it impossible for multiple modules linked into the same application to use your module successfully), but to work around this problem in legacy software you must ensure that any files that define weak symbol overrides also include something that is strongly linked into the final application.

______
Copyright © 2015 ARM Ltd. All rights reserved.
