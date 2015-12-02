
# Writing applications for mbed OS

This section shows the general structure of an application running on mbed OS, and discusses best practices for coding (coming soon).

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** You'll be using Blinky, the same application you used earlier to learn about yotta and the project build process. You should already have Blinky built. If you don't, please take a look at the [quick guide](https://docs.mbed.com/docs/getting-started-mbed-os/en/latest/FirstProjectmbedOS/) and follow the instructions there.</span>

## Blinky's code

Blinky's code is quite short, but it's enough to show a few general mbed OS application concepts:

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
## Including headers and libraries in your application

All of the features reviewed in the guide - MINAR, memory management, security and so on - are available for all hardware unless explicitly documented otherwise. Some are available through mbed OS, some through additional functionality. For either case, your application code must explicitly include the sources of this functionality.

You can include headers and libraries in your application by using the standard C++ ``#include`` directive.

Note that including requires the full path to the file:

```c++
#include "mbed-drivers/mbed.h"
```

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** There are limitations on the path and file names. For more information about this, please see the [yotta documentation](http://yottadocs.mbed.com/tutorial/tutorial.html).</span>

Please remember that for the compilation to work correctly, yotta has to know where the included file comes from. That requires listing dependencies in the ``module.json`` file, as [explained in the yotta chapter](app_on_yotta/#installing-dependencies). In this example, ``mbed.h`` is part of ``mbed-drivers``, which you installed when you built your code.

### Including mbed OS functionality

You must explicitly include ``mbed.h``; the rest of the mbed OS code base is then included either by ``mbed.h`` itself or by one of the files it includes. 

### Including other functionality

Including functionality that is not part of the mbed OS base code, such as certain connectivity features, requires more complicated inclusion lists, although ideally you should be able to include only the header file for each library you need.

If you're not sure whether or not you need to explicitly include something in your application, ask for advice [on the forums](https://forums.mbed.com). 

## app_start() - starting the application

To start an application in mbed OS, you need an ``app_start()`` function, replacing the standard ``main()`` of other CPP programs:


```c++
void app_start(int, char**) {

}
```
``app_start()`` should be in a file called ``main.cpp``, and must be void.

### MINAR

mbed OS starts MINAR implicitly; you only need to call it explicitly if you want to pass to it a particular function that will be executed later (using ``postCallback``).

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** See the [MINAR chapter](MINAR.md) for more information.</span>

## Debugging and testing your application

Debugging and testing are subjects worthy of their own guides. Until we have those written, please see:

* [The current debugging articles](https://docs.mbed.com/docs/debugging-on-mbed/en/latest/). Note that they currently focus on mbed Classic, but many of the ideas they present are applicable to mbed OS.

* The testing suite, Greentea. It is currently documented only in its [GitHub repositories](https://github.com/ARMmbed/greentea). We're working on a new guide for it.

## Flashing an application to the board

mbed OS applications are binary files (or, for certain boards, HEX). They're built locally (in your computer's project directory) and must be flashed (copied to) the board.

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** yotta builds a separate application binary for each target under you application directory. In our example, the binary will be at ``/blinky/build/frdm-k64f-gcc/source/``. The file is ``my_blink.bin``.</span>

To flash an application to your board:

1. Connect the board to your computer using a micro-USB cable.

1. The board is shown as removable storage.

1. From your file explorer, drag and drop the file onto the board.

1. The application is now on your board and should start working immediately. Note that some boards need a reset.

## Publishing your application

You can make your code public by committing it to version control (we commit ours to GitHub). You can go one step further and [publish your module](http://yottadocs.mbed.com/tutorial/release.html) to the yotta registry (but please note that publishing an application (as opposed to a library) to the registry is not part of the regular yotta workflow and gives little to no additional benefit in practice).
