# Running your first mbed OS application

Your first application makes the LED on your board blink, and prints some commands to the terminal. You use yotta to build your application for mbed OS.

## Using yotta as a command-line tool

yotta is the build system we use for mbed OS. We'll get into the details of it later, but what you need to understand at this point is that mbed OS applications cannot be built without yotta.

If you haven't already installed yotta, please follow these [installation instructions](installation.md).


## Regular method: creating a new application

This method uses yotta to initialize an application and manually add our code to it.

### Step 1: create an application

1. Create an empty folder, then move into that folder:

	```
	$ mkdir blinky
	$ cd blinky
	```

1. Initialize the module with `yotta init` and fill in the details. Make sure you select **executable** as the module type:

<span style="display:block; text-align:center; padding:5px;">
![](Full_Guide/Images/yotta_init.png)</span>

You should now have several folders and files in the directory:

```
$ ls
blinky  module.json  source  test
```

* The `module.json` file contains all the settings for your application; everything you just entered can be found in that file, so if you want to edit it later, for example to add a repository URL, that's not a problem. 

* The `/source` directory contains all the source files. 

* The `/test` directory contains all tests you'll write to [test your module](https://github.com/ARMmbed/GettingStartedmbedOS/blob/master/Docs/docs.yottabuild.org/tutorial/testing.html). 

* The `/blinky` directory is where header files for your application will be created.

**Tip:** if you want to learn about other module types, [start here](http://docs.yottabuild.org/).

### Step 2: select a target board

yotta can build the [same code for multiple targets](Full_Guide/app_on_yotta/#yotta-targets); it therefore needs to be told which target every build is for. So now that you have created a basic application, you need to set the target.

For a full list of available targets run the following `search` command:

```
$ yotta search --limit 1000 target
frdm-k64f-gcc 0.0.21: Official mbed build target 
for the mbed frdm-k64f development board.
st-nucleo-f401re-gcc 0.1.0: Official mbed build target 
for the mbed st-nucleo-f401re development board.
frdm-k64f-armcc 0.0.13: Official mbed build target 
for the mbed frdm-k64f development board, using the armcc toolchain.
...
```

In this example you are going to use the Freescale FRDM-K64F board configured for building with gcc, so you use `target frdm-k64f-gcc`.

```
$ yotta target frdm-k64f-gcc
```

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** The first time you access the yotta Registry, you need to log into your mbed user account.</span>

To check that the target has been set correctly run the target command without parameters. It shows what yotta is currently targeting for its builds:

```
$ yotta target
frdm-k64f-gcc,*
```

*The information for this target has been downloaded to a directory named `/yotta_targets`. Do not edit or modify files here because they can be modified without your knowledge.*

### Step 3: install dependencies

Now you need to install the dependencies. In this application, you have `mbed-drivers` as your dependency:

```
$ yotta install mbed-drivers
info: ... messages about stuff being downloaded ...
```

You could at this point add other yotta modules. Check out the `yotta search` command above to search for other available modules.

yotta downloads and installs the modules to a directory named `/yotta_modules`. Do not edit or modify files here as they can be modified without your knowing.

### Step 4: add source files

Now that you have an application and its dependencies, you need source code to make the module useful. 

In the `/source` folder, create a file called `app.cpp` with the following contents:

```c++
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

This application causes LED1 on the board to flash and prints the status of LED1 to the terminal. 

**Tip:** When setting up your terminal, note that the default terminal speed is 9600 baud at 8-N-1.

### Step 5: build

To build the application:

1. Run the `yotta build` command in the top level directory:

	```
	$ yt build
	info: generate for target: frdm-k64f-gcc 0.0.21 
	at ~\blinky\yotta_targets\frdm-k64f-gcc
	GCC version is: 4.9.3
	-- The ASM compiler identification is GNU
	-- Found assembler: GNU Tools ARM Embedded/4.9 2014q4/bin/arm-none-eabi-gcc.exe
	-- Configuring done
	-- Generating done
	-- Build files have been written to: ~/blinky/build/frdm-k64f-gcc
	[135/135] Linking CXX executable source/blinky
	```

1. yotta compiles the binary to the `/build` folder. 

### Step 6: run the application on your board

1. Connect your board to your computer over USB. It should appear as removable storage.

1. Copy the binary `/build/frdm-k64f-gcc/source/blinky.bin` to your mbed board and see the LED blink. 

1. If you hook up a terminal to the board, you can see the output being printed. It should look like this:.

	```
	LED = 1
	LED = 0
	LED = 1
	LED = 0
	...
	```

## Alternative method: cloning an existing application

Instead of setting up your own application from scratch, you could clone an existing one and modify it. We have published the above [blinky example application](https://github.com/armmbed/example-mbedos-blinky) on GitHub so you can clone the repo and build it.

### Step 1: clone the repo


```
$ git clone https://github.com/ARMmbed/example-mbedos-blinky.git
$ cd example-mbedos-blinky
```

**Note:** This repo includes ``mbed-drivers`` as a dependency, so there is no need to manually install it as you did in the previous method (yotta will install it when you build the application).

### Step 2: select a target platform

```
$ yotta target frdm-k64f-gcc
```

### Step 3: build the application to your target

```
$ yotta build
... bunch of build messages ...
[135/135] Linking CXX executable source/example-mbedos-blinky
```

As in the previous method, the compiled binary is at `/build/frdm-k64f-gcc/source/example-mbedos-blinky.bin`. You can copy it to your board to run it, and hook your board up to a terminal to see the output, as explained in step 6 above.
