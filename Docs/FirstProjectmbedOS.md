# Running your first mbed OS application

Ok, let's get to the nitty gritty and create your first mbed application (using yotta). We're going to use mbed OS to make the LED on our board blink, and print some commands to the terminal.

## Step 1: install yotta and its dependencies

yotta is the build system we use for mbed OS. We'll get into the details of it later, but what you need to understand at this point is that mbed OS applications cannot be built without yotta.

See yotta's [installation instructions](installation.md).

## Step 2: create an application

First create an empty folder, then move into that folder:

```
$ mkdir blinky
$ cd blinky
```

Next initialize the module with `yotta init` and fill in the details. Make sure you select **executable** as the module type:


<span style="display:block; text-align:center; padding:5px;">
![](../Docs/Full_Guide/Images/yotta_init.png)</span>

You should now have several folders and files in the directory:

```
$ ls
blinky  module.json  source  test
```

The `module.json` file contains all the settings for your application; everything you just entered can be found in that file, so if you want to add a repository URL later you can. The `/source` directory contains all the source files. The `/test` directory contains all tests you'll write to [test your module](https://github.com/ARMmbed/GettingStartedmbedOS/blob/master/Docs/docs.yottabuild.org/tutorial/testing.html). The `/blinky` directory is where header files for your application should be created.

**Tip:** if you want to learn about other module types, [start here](http://docs.yottabuild.org/).

## Step 3: select a target board

Earlier, we explained that yotta can build the same code for multiple targets; it therefore needs to be told which target every build is for. So now that we have created a basic application, let's set the target.

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

In this example we are going to use the Freescale FRDM-K64F board configured for building with gcc, so we'll use the `target frdm-k64f-gcc`.

```
$ yotta target frdm-k64f-gcc
```

To check that the target has been set correctly run the target command. It shows what yotta is currently targeting for its builds:

```
$ yotta target
frdm-k64f-gcc,*
```

*The information for this target has been downloaded to a directory named `/yotta_targets`. Do not edit or modify files here because they can be modified without your knowledge.*

## Step 4: install dependencies

Now let's install the dependencies. In this application, we'll have `mbed-drivers` as our dependency:

```
$ yotta install mbed-drivers
info: ... a bunch of messages about stuff being downloaded ...
```

You could at this point add other yotta modules. Check out the `yotta search` command to search for other available modules.

The modules are downloaded and installed in a directory named `/yotta_modules`. Do not edit or modify files here as they can be modified without your knowing.

If you want to learn more about mbed OS and try some other functionality, you can [start here](http://mbed.com/en/development/software/mbed-os/).

## Step 5: add source files

Now that we have set up an application and downloaded our dependencies, let's add some source code to use the module. In the `/source` folder create a file called `app.cpp` with the following contents:

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

This program will cause LED1 on the board to flash and print the status of LED1 to the terminal. The default terminal speed is 9600 baud at 8-N-1.

## Step 6: build

To build the application, run the `yotta build` command in the top level directory:
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

The compiled binary will be located in the `/build` folder. Copy the binary `/build/frdm-k64f-gcc/source/blinky.bin` to your mbed board and see the LED blink. 

If you hook up a terminal to the board, you can see the output being printed. It should look like this:.

```
LED = 1
LED = 0
LED = 1
LED = 0
...
```

# Alternative method - cloning an existing application

Instead of setting up your own application from scratch, you could clone an existing one and modify it. We have published the above [blinky example application](https://github.com/ARMmbed/GettingStartedmbedOS/blob/master/Docs/www.github.com/armmbed/example-mbedos-blinky) on GitHub so you can clone to repo and build it.

## Step 1: clone the repo

Clone the repository from GitHub:

```
$ git clone https://github.com/ARMmbed/example-mbedos-blinky.git
$ cd example-mbedos-blinky
```

## Step 2: select a target platform

```
$ yotta target frdm-k64f-gcc
```

## Step 3: build it

```
$ yotta build
... bunch of build messages ...
[135/135] Linking CXX executable source/example-mbedos-blinky
```

The compiled binary will be located in the `/build` folder. Copy the binary  `/build/frdm-k64f-gcc/source/example-mbedos-blinky.bin` to your mbed board and see the LED blink. 

If you hook up a terminal to the board, you can see the output being printed. It should look like this:
```
LED = 1
LED = 0
LED = 1
LED = 0
...
```


