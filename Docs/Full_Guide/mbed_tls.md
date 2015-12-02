# mbed TLS

mbed TLS makes it trivially easy for developers to include cryptographic and SSL/TLS capabilities in their embedded products, with a minimal code footprint. It offers an SSL library with an intuitive API and readable source code.

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** The current release of mbed TLS for mbed OS is beta, and implements no secure source of random numbers, weakening its security. We therefore consider it an evaluation version, not a production version. If you want a production version, please consider the standalone available at [https://tls.mbed.org/](https://tls.mbed.org/)</span>

Currently the only supported yotta targets are:

- `frdm-k64f-gcc` 
- `frdm-k64f-armcc`
- `x86-linux-native` 
- `x86-osx-native`

## Differences between the standalone and mbed OS editions

mbed TLS has a standalone edition for devices that are not running mbed OS. However, this guide focuses on the mbed OS integration. While the two editions share a code base, there are a number of differences, mainly in configuration and integration. You should keep those differences in mind when reading some articles in our [knowledge base](https://tls.mbed.org/kb), as currently all the articles are about the standalone edition.

The key differences are:

* To reduce its footprint, the mbed OS edition enables a smaller set of features in `config.h` by default. While the default configuration of the standalone edition puts more emphasize on maintaining interoperability with old peers, the mbed OS edition only enables the most modern ciphers and the latest version of TLS and DTLS.

* The following components of mbed TLS are disabled in the mbed OS edition: `net.c` and `timing.c`. This is because mbed OS includes their equivalents.

* The mbed OS edition comes with a fully integrated API for TLS and DTLS connections in a companion module: [mbed-tls-sockets](https://github.com/ARMmbed/mbed-tls-sockets). See ["Performing TLS and DTLS connections"](#Performing-TLS-and-DTLS-connections).


## Performing TLS and DTLS connections

mbed TLS provides a high-level API for performing TLS and DTLS connections in mbed OS. The API is in a separate yotta module: [mbed-tls-sockets](https://github.com/ARMmbed/mbed-tls-sockets). We recommend using this API for TLS and DTLS connections. It is very similar to the API provided by the [``sockets``](https://github.com/ARMmbed/sockets) module for unencrypted TCP and UDP connections.

The `mbed-tls-sockets` module includes a complete [example TLS client](https://github.com/ARMmbed/mbed-tls-sockets/blob/master/test/tls-client/main.cpp) with [usage instructions](https://github.com/ARMmbed/mbed-tls-sockets/blob/master/test/tls-client/README.md).

## Configuring mbed TLS features

mbed TLS makes it easy to disable any feature during compilation, if that feature isn't required for a particular project. The default configuration:

* Enables all modern and widely-used features, to meet the needs of new projects.

* Disables all features that are older or less common, to minimize the code footprint.

The list of compilation flags is available in the fully documented [``config.h`` file](https://github.com/ARMmbed/mbedtls/blob/development/include/mbedtls/config.h).

If you need to adjust those flags, you can provide your own configuration-adjustment file: 

1. Create a configuration file. You can name it freely.
1. Put the file in your application's ``include`` directory.
1. Add suitable `#define` and `#undef` statements in your file.
1. mbed TLS needs to know your file's name. To do that, you need to use yotta's [configuration system](http://docs.yottabuild.org/reference/config.html):
 - In your ``config.json`` file, under ``mbedtls``, fine the key ``user-config-file``.
 - Enter your filename as the value of that key.

``config.h``  includes your file between the default definitions and the sanity checks. 

For example, in an application called `myapp`, if you want to enable the EC J-PAKE key exchange and disable the CBC cipher mode, you can create a file named  `mbedtls-config-changes.h` in the `myapp` directory containing the following lines:

	#define MBEDTLS_ECJPAKE_C
 	#define MBEDTLS_KEY_EXCHANGE_ECJPAKE_ENABLED

	#undef MBEDTLS_CIPHER_MODE_CBC

And then create a file named `config.json` at the root of your application with the following contents:

	{
		"mbedtls": {
			"user-config-file": "\"myapp/mbedtls-config-changes.h\""
		}	
	}

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** You need to provide the exact name that you use in the `#include` directive, including the `<>` or quotes around the name.</span>

## Getting mbed TLS from GitHub

Like most components of mbed OS, mbed TLS is developed in the open and its source can be found on GitHub: [ARMmbed/mbedtls](https://github.com/ARMmbed/mbedtls). Unlike most other mbed OS components, however, you cannot just clone the repository and run `yotta build` from its root. This is because mbed TLS also exists as an independent component, so its repository includes things that are not relevant for mbed OS.

If you want to use mbed TLS from the GitHub repo:

1. Create a local clone.

1. From the root of the clone, run the shell script:

	```
	yotta/create-module.sh
	cd yotta/module
	```
	
You can then run any [yotta command](app_on_yotta.md) you would normally run, such as [`yotta build`] or [`yotta link`].

## Sample programs

This release includes the following examples:

1. [**Self test:**](https://github.com/ARMmbed/mbedtls/blob/development/yotta/data/example-selftest) Tests different basic functions in the mbed TLS library.

2. [**Benchmark:**](https://github.com/ARMmbed/mbedtls/blob/development/yotta/data/example-benchmark) Measures the time taken to perform basic cryptographic functions used in the library.

3. [**Hashing:**](https://github.com/ARMmbed/mbedtls/blob/development/yotta/data/example-hashing) Demonstrates the various APIs for computing hashes of data (also known as message digests) with SHA-256.

4. [**Authenticated encryption:**](https://github.com/ARMmbed/mbedtls/blob/development/yotta/data/example-authcrypt) Demonstrates using the Cipher API for encrypting and authenticating data with AES-CCM.

These examples are integrated as yotta tests, so they are built automatically when you build mbed TLS. Each of them comes with complete usage instructions as a Readme file in the repository.

## Other resources

The [mbed TLS website](https://tls.mbed.org) contains many other useful resources for developers, such as [developer
documentation](https://tls.mbed.org/dev-corner), [knowledge base articles](https://tls.mbed.org/kb), and a [support forum](https://tls.mbed.org/discussions).

## Contributing

We gratefully accept bug reports and contributions from the community. There are some requirements we need to fulfill in order to be able to integrate contributions:

* Simple bug fixes to existing code do not contain copyright themselves and we can integrate without issue. The same is true of trivial contributions.

* For larger contributions, such as a new feature, the code can possibly fall under copyright law. We then need your consent to share in the ownership of the copyright. We have a form for this, which we will send to you in case you submit a contribution or pull request that we deem this necessary for.

To contribute, please:

* [Check for open issues](https://github.com/ARMmbed/mbedtls/issues) or [start a discussion](https://tls.mbed.org/discussions) around a feature idea or a bug.

* Fork the [mbed TLS repository on GitHub](https://github.com/ARMmbed/mbedtls) to start making your changes. As a general rule, you should use the "development" branch as a basis.

* Write a test that shows that the bug was fixed or that the feature works as expected.

* Send a pull request and nag us until it gets merged and published. We will include your name in the ChangeLog.
