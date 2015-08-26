# Your first project

Ok, let's get to the nitty gritty and create your first mbed project (using yotta)! For this project we are going to make the LED on our board blink, and print some commands to the terminal. We are going to use the mbed-drivers (mbed OS) yotta module.

## Step 0: install yotta


<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">Tip: this section covers installing yotta on your own computer. If you are using an IDE or other environment with yotta pre-installed, you can skip this step.</span>


Note: make sure you have an up to date version of [Python](https://www.python.org/downloads/) installed; it should include pip, but if it doesn't you can manually [install it](https://pypi.python.org/pypi/pip). 


On the command line, run this command to install yotta:

```bash
$ pip install yotta
```

If you have any trouble installing yotta please see [docs.yottabuild.org](http://docs.yottabuild.org/#installing) for troubleshooting.

## Step 1: create your first mbed OS program

We need to create an executable yotta module so that when we run `yotta build` an executable file will be created.


<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">Tip: if you want to learn about other module types, [start here](http://docs.yottabuild.org/).</span>

First create an empty folder, then move into that folder:

```bash
$ mkdir blinky
$ cd blinky
```


Next initialize the module with `yotta init` and fill out the details. Make sure you select executable as the module type at the end.


<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">Note: you can fill in the repository and homepage URLs or leave them blank. You can also edit them later.</span>

```bash
$ mkdir example-mbedos-blinky
$ cd example-mbedos-blinky
$ yotta init
Enter the module name: <example-mbedos-blinky>
Enter the initial version: <0.0.0>
Short description: simple example program to blink an LED 
on an mbed board with mbed OS
Keywords:  <blinky, mbedOS>
Author: mbedAustin
Repository url:
Homepage:
What is the license for this project (Apache-2.0, ISC, MIT etc.)?  <Apache-2.0>
Is this module an executable? <no> yes
```

You should now have several folders and files in the directory:

```bash
$ ls
example-mbedos-blinky  module.json  source  test
```

The `module.json` file contains all the settings for your project; everything you just entered can be found in that file, so if you want to add a repository URL later you can. The `./source` directory contains all the source files, the `./test` directory contains all tests written to [test your module](docs.yottabuild.org/tutorial/testing.html), and the `./example-mbedos-blinky` directory contains all build files and dependency files.

## Step 2: select a target platform

Earlier, we explained that yotta can build the same code for multiple targets; it therefore needs to be told which target every build is for. So now that we have created a basic module, let's set the target. 

For a full list of available targets run the following `search` command:

```bash
$ yotta search --limit 1000 targetfrdm-k64f-gcc 0.0.21: 
Official mbed build target for the mbed frdm-k64f 
development board.

st-nucleo-f401re-gcc 0.1.0: 
Official mbed build target for the mbed st-nucleo-f401re 
development board.

frdm-k64f-armcc 0.0.13: 
Official mbed build target for the mbed frdm-k64f 
development board, using the armcc toolchain.
...
```

In this example we are going to use the Freescale FRDM K64F board, so we'll use the `frdm-k64f-gcc` target.


```bash
$ yotta target frdm-k64f-gcc
```

To check that the target has been set correctly run the `target` command to see what yotta is currently targeting for its builds:

```bash
$ yotta target
frdm-k64f-gcc,*
```

## Step 3: add dependencies

Now let's add the dependencies. In this project,  we'll have `mbed-drivers` (also known as mbed OS) as our dependency:

```bash
$ yotta install mbed-drivers
info: ... a bunch of messages about stuff being downloaded ...
```

You could at this point add other yotta modules. Check out the `yotta search` command to search for other available modules.

If you want to learn more about mbed OS and try some other functionality, you can [start here](http://mbed.com/en/development/software/mbed-os/).

## Step 4: add source files

Now that we have set up an executable module and downloaded our dependencies, let's add some source code to use the module. In the `./source` folder create a file called `blinky.c` with the following contents:

```C
#include "mbed/mbed.h"

DigitalOut led(LED1);

void app_start(int, char**){
	while(1){
    	led = !led;
    	printf("LED = %d \n\r",led.read());
    	wait(0.5f);
	}
}
```

This program will cause the LED on the board to flash and print out the status of the LED to the terminal. The default terminal speed is `9600 baud` at `8-N-1`.


## Step 5: build

To build the project, run the yotta build command in the top level of the example directory (where the module.json file is located):

```bash
$ yt build
info: generate for target: frdm-k64f-gcc 0.0.21 
at ~\example-mbedos-blinky\yotta_targets\frdm-k64f-gcc
GCC version is: 4.9.3
-- The ASM compiler identification is GNU
-- Found assembler: GNU Tools ARM Embedded/4.9 2014q4/bin/arm-none-eabi-gcc.exe
-- Configuring done
-- Generating done
-- Build files have been written to: ~/example-mbedos-blinky/build/frdm-k64f-gcc
[135/135] Linking CXX executable source/example-mbedos-blinky
```

The compiled binary will be located in the build folder. Copy the binary from `.\build\frdm-k64f-gcc\source\example-mbedos-blinky.bin` to your mbed board and see the LED blink. If you hook up a terminal to the board, you can see the output being printed from the board. It should look like this:.

```terminal
LED = 1

LED = 0

LED = 1

LED = 0
...
```

## Alternative method - cloning an existing module

Instead of setting up your own project from scratch, you could copy an existing executable module and modify it. We have uploaded the above [blinky example project](www.github.com/armmbed/example-mbedos-blinky) to GitHub so you can clone to repo and build it.

## Step 1: clone the repo

Clone the repository from GitHub:

```bash
$ git clone https://github.com/ARMmbed/example-mbedos-blinky.git
```

## Step 2: select a target platform

You can build this example for any target. To see all targets available run the following `search` command.

```bash
$ yotta search --limit 1000 target target
frdm-k64f-gcc 0.0.21: 
Official mbed build target for the mbed frdm-k64f 
development board.

st-nucleo-f401re-gcc 0.1.0: 
Official mbed build target for the mbed st-nucleo-f401re 
development board.

frdm-k64f-armcc 0.0.13:
Official mbed build target for the mbed frdm-k64f 
development board, using the armcc toolchain.
...
```

Any `target` will work. We're going to use the `frdm-k64f-gcc` target. To set the target run the following command.

```bash
$ yotta target frdm-k64f-gcc
```

## Step 3: build it

Now that you have downloaded the project and selected the `target` to build for, let's build the project! Run the following command at the top level of the project (where the module.json file is located):

```bash
$ yotta build
... bunch of build messages ...
[135/135] Linking CXX executable source/example-mbedos-blinky
```

The compiled binary will be located in the build folder. Copy the binary from `.\build\frdm-k64f-gcc\source\example-mbedos-blinky.bin` to your mbed board and see the LED blink. If you hook up a terminal to the board, you can see the output being printed form the board. It should look like this:

```terminal
LED = 1

LED = 0

LED = 1

LED = 0
...
```

___

We're done with our first program. For more information, see our [mbed OS](http://mbed.com/en/development/software/mbed-os/) documentation.