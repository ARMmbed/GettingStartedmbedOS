# Introduction

Welcome to the getting started guides for ARM® mbed™ OS. This page provides a review of [mbed OS](#mbed-os) and of the [available documentation](#the-documentation).

## mbed OS

mbed OS is the operating system we created for mbed-enabled boards. It allows your C++ applications to run on these boards by providing APIs that you can use from your application to control the hardware.

### Features

We designed mbed OS specifically for constrained devices, so it works behind the scenes to automatically make the most of the limited hardware and network resources available:

* It's modular: it has a code base that is common to all applications running on all hardware, and additional modules that extend functionality and create hardware-specific interfaces. The modules are only compiled if your application needs them; you don't need to waste memory on unused code.

* It's single-threaded and event-driven, so you can use it even on small devices.

* It abstracts the hardware, so that an application always "sees" the same interface, no matter which board it's running on. mbed OS then matches the interface to the actual hardware without you manually changing the code. This allows you to write the application once, then deploy it on any supported board. mbed OS also works seamlessly with peripherals and extension boards.

* It efficiently manages power and schedules tasks, so that even demanding applications can operate on low-power devices.

* It manages both device and communication security using mbed OS uVisor and mbed TLS, respectively.

* It supports multiple networking options: Bluetooth Low Energy, Ethernet, WiFi (coming soon), Thread and 6LoWPAN.

* It works with device management protocols - LWM2M and CoAP - so that you can perform large-scale remote updates.

mbed OS also works with other ARM mbed tools, like our testing tool (Greentea) and mbed Device Server. To learn more about these tools, see the [main site](https://www.mbed.com/en/).


### Code base

As explained above, mbed OS is modular. This section gives a short review of the main modules. Some of these will be reviewed in greater detail later.

#### Core modules
* [_compiler-polyfill_](https://github.com/ARMmbed/compiler-polyfill): Common compiler intrinsics and attributes made portable across toolchains.

* [_core-util_](https://github.com/ARMmbed/core-util): Core data structures and primitives for the OS.

* [_minar_](github.com/ARMmbed/minar): The mbed OS event scheduler.

* [_ualloc_](https://github.com/ARMmbed/ualloc) and [_dlmalloc_](https://github.com/ARMmbed/dlmalloc): Memory allocation for mbed OS.

* [_uvisor_](https://github.com/ARMmbed/uvisor): mbed OS uVisor is a supervisory kernel for security on mbed OS.

#### Hardware abstraction and drivers

* [_mbed-drivers_](https://github.com/ARMmbed/mbed-drivers): Abstract drivers for common hardware peripherals and communications interfaces such as SPI and I2C. Provides a higher level interface than the mbed HAL; these are the APIs that applications should use.

* [_cmsis-core_](https://github.com/ARMmbed/cmsis-core): ARM's official low level hardware abstraction for Cortex-M.

* [_mbed-hal_](https://github.com/ARMmbed/mbed-hal): The mbed Hardware Abstraction Layer (HAL).

#### Networking and connectivity

* [_ble_](https://github.com/ARMmbed/ble): APIs for using Bluetooth Low Energy.

* [_mbed-mesh-api_](https://github.com/ARMmbed/mbed-mesh-api): APIs for initialising and using the mesh network.

* [_mbedtls_](https://github.com/ARMmbed/mbedtls): mbed TLS, the SSL/TLS stack (including cryptographic and certificates handling functionality).

* [_sal_](https://github.com/ARMmbed/sal): The mbed OS socket abstraction layer (SAL). Provides a common interface for networking stacks from ARM and partners.

* [_sal-stack-nanostack_](https://github.com/ARMmbed/sal-stack-nanostack): Our IPv6/6LoWPAN stack.

* [_sockets_](https://github.com/ARMmbed/sockets): High level portable socket layer (sitting on top of the SAL).

#### mbed Client

* [_mbed-client-c_](https://github.com/ARMmbed/mbed-client-c): Core library in C.

* [_mbed-client_](https://github.com/ARMmbed/mbed-client): C++ API (use this one rather than the C one, as it's much easier to use correctly).

* [_mbed-client-mbed-os_](https://github.com/ARMmbed/mbed-client-mbed-os): mbed OS-specific implementation for mbed Client.

* [_mbed-client-mbedtls_](https://github.com/ARMmbed/mbed-client-mbed-tls): mbed TLS-specific implementation for mbed Client.

### mbed OS and yotta

yotta is the build system we use for mbed OS. We'll get into the details of it [later](Full_Guide/app_on_yotta.md), but what you need to understand at this point is that mbed OS applications cannot be built without yotta. 

yotta combines our code (application) with the mbed OS code-base and any other module (reusable library) that we may need. To tell yotta what our application needs, we add a list of dependencies to each application we write. The easiest way to add mbed OS to our application when we build it is to describe the component ``mbed-drivers`` as a dependency of our application, because ``mbed-drivers`` has most other components as its own dependencies, so yotta will build what we need.

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** Some components must be manually included; we'll tell you about that when we review them in this guide.</span>

What this all means is that to build applications that can run on top of mbed OS, you need:

* yotta.

* mbed OS modules and optional additional libraries, which yotta gets for you.

* Your own application code.

<span style="display:block; text-align:center; padding:5px; border:1px solid #000;">
![](Full_Guide/Images/mbed_OS_app.png)</span>

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** IDE support is not available yet. If you're interested in a particular IDE, talk to us on [the forum](forums.mbed.com).</span>

## The documentation

### The quick guides

* [Setting up your machine](installation.md): installing yotta, the build tool for mbed OS.

* [Your first mbed OS application](FirstProjectmbedOS.md): a simple example to get you going.

### The mbed OS user guide

This guide isn't ready yet, but we're publishing stand-alone chapters as fast as we can. The [guide's introduction](Full_Guide/guide_index.md) reviews the available content.

### Additional sources

* [Further reading sources](FurtherReading.md) about other mbed tools, hardware, community and partners.

* Links to [our main code repositories and their documentation, as well as examples](GetTheCode.md).

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Tip:** For more details about mbed, start [here](http://mbed.com/en/about-mbed/what-mbed/).</span>


