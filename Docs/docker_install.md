# yotta in a Docker container

Docker containers let you run an application such as yotta, with all of its dependencies (like Python), without installing anything directly on your machine. This protects you from version conflicts and other installation problems. 

We’ve built a yotta Docker container and a bash script (``yotta.sh``) which allows you to use the yotta Docker container to mimic a yotta installation on your system; yotta will be fully functional.

### Prerequisites

[Please install Docker](https://www.docker.com/docker-toolbox).

### Installation

1. Start Docker. 

1. In the prompt, run:
	
	```
	docker pull mbed/yotta
	```

1. Save the [yotta.sh script](https://github.com/ARMmbed/yotta-docker/blob/master/yotta.sh) on your computer. You’ll need to refer to its path when you use it in Docker later, so remember where it is.

### Using the yotta Docker and script to build projects

There is one difference between a regular installation and a Docker Container: in Docker, you have to precede each yotta command with the path to the bash script you saved in the previous section. For example:
	
```shell
../<path containing script>/yotta.sh target frdm-k64f-gcc 	//sets the target
../<path containing script>/yotta.sh build			//builds our project
```

<span style="background-color:#E6E6E6;  border:1px solid #000;display:block; height:100%; padding:10px">**Note:** If you saved your script under a name other than ```yotta.sh```, you may need to enter the script’s full name, including extension. Our example will become ``../<path containing script>/<name.extension> target frdm-k64f-gcc``.</span>

If you want to use yotta commands without specifying the full path to the script, you can add the yotta script’s path to your system’s ```path``` variable (Windows) or create a symbolic link (symlink) to your bin directory (Linux and Mac OS X). For example, to create a symlink: 
	
```
ln -s <path to your yotta.sh> /usr/local/bin/yotta
```

Now you can use yotta directly:
	
```
git clone <mbedos project>
cd <mbedos project>
yotta target frdm-k64f-gcc
yotta build
```

### Open Source

The yotta Docker image is open source, feel free to fork it:

https://github.com/ARMmbed/yotta-docker

