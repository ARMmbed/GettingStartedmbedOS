# Getting mbed OS

We don't "get" mbed OS in the same way that we get a new app on our phone. There is no mbed OS download and no way to install it on our machine.

Working with mbed OS means we use yotta to combine our own application code with the mbed OS code base. yotta gets the relevant parts of mbed OS for us from its own registry.

So these guides will walk you through working with yotta, then show you how to write an application that can work with the mbed OS code base. 

There are two ways to get yotta: 

* [Install it on your machine](http://yottadocs.mbed.com/#installing).

* [Run it in a Docker container](docker_install.md).

## What's next?

Try the [quick guide](FirstProjectmbedOS.md) to get a first sample application working, or see the [full list of samples](GetTheCode.md).

Read the [full guide](Full_Guide/overview.md) to understand how mbed OS and yotta work together. 

If your'e interested in specific yotta modules:

* [``mbed-drivers``](https://www.mbed.com/en/development/software/mbed-yotta/search/result/module/mbed-drivers/) is the heart of mbed OS. You'll see it again and again in the guide.

* [``mbed-client``](https://www.mbed.com/en/development/software/mbed-yotta/search/result/module/mbed-client/) is best explored through its [getting started guide](https://docs.mbed.com/docs/mbed-client-guide/en/latest/).

* [``mbedtls``](https://www.mbed.com/en/development/software/mbed-yotta/search/result/module/mbedtls/) is our connectivity security module, and explored in greater detail in [the user guide chapter covering its use in mbed OS](Full_Guide/mbed_tls.md).

* Some other modules that might interest you are [``sockets``](https://www.mbed.com/en/development/software/mbed-yotta/search/result/module/sockets/), [``ble``](https://www.mbed.com/en/development/software/mbed-yotta/search/result/module/ble/) and [``sal-stack-nanostack``](https://www.mbed.com/en/development/software/mbed-yotta/search/result/module/sal-stack-nanostack/) for connectivity.

You can search for other modules [on our main site](https://www.mbed.com/en/development/software/mbed-yotta/).
