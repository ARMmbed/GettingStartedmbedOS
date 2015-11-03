# Debugging in mbed OS

The [`example-mbedos-blinky`](../FirstProjectmbedOS.md) application we use in this guide is simple and easy to understand, so chances are it'll work as expected right away. More complex applications might not work as expected. In that case, a debugger is a very useful tool. There are two main ways to debug mbed OS applications at the moment, depending on how they were compiled.

## Debugging applications compiled with ARMCC

To debug applications compiled with ARMCC, you'll need to install [Keil MDK](https://www.keil.com/download/product/). To debug the application, you can use the `yotta debug` command. If the above `example-mbedos-blinky` application was compiled with target `frdm-k64f-armcc` instead of `frdm-k64f-gcc`, you could debug it by running `yotta debug example-mbedos-blinky`. This will automatically open the uVision IDE, with your program ready for debugging.

## Debugging applications compiled with GCC

The best way to debug applications compiled with GCC is to use the `gdb` debugger. You'll need:

- `arm-none-eabi-gdb`, which is installed as part of the [GCC ARM Embedded](https://launchpad.net/gcc-arm-embedded) installation procedure.
- `pyocd-gdbserver`, which is installed as part of the yotta installation procedure.

To debug the above `example-mbedos-blinky` application:

```
$ yt debug example-mbedos-blinky
info: found example-mbedos-blinky at source/example-mbedos-blinky
info: starting PyOCD gdbserver...
info: new board id detected: 02400201C37A4E793E84B3C1
info: board allows 5 concurrent packets
info: DAP SWD MODE initialised
info: IDCODE: 0x2BA01477
info: K64F not in secure state
info: 6 hardware breakpoints, 4 literal comparators
info: CPU core is Cortex-M4
info: FPU present
info: 4 hardware watchpoints
info: Telnet: server started on port 4444
info: GDB server started at port:3333
GNU gdb (GNU Tools for ARM Embedded Processors) 7.6.0.20140731-cvs
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "--host=x86_64-apple-darwin10 --target=arm-none-eabi".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols 
from 
/examples/example-mbedos-blinky/build/frdm-k64f-gcc/source/example-mbedos-blinky
...done.
info: One client connected!
(gdb)
```
