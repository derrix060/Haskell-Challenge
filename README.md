# Haskell - Challenge

This repository was created to solve an interview challenge to [Zalora](https://www.zalora.sg/).


## Instructions

Write a program that provides an HTTP API to store and retrieve files. It should support the following features:
- Upload a new file
- Retrieve an uploaded file by name
- Delete an uploaded file by name
- include a NixOS module to provide the API as a service
- Bonus point: if multiple files have similar contents, reuse the contents somehow to save space.

## How to use

On this tutorial I will presume that you will choose download the VirualBox CD.

### Download Nix OS

You can choose if you want to download the CD, the appliance for VirtualBox (I've choosed this one), use on Amazon EC2, or Azure BLOBs.

All of the steps is written on [NixOS website](https://nixos.org/nixos/download.html).

### Install Nix

After enter with your login and password (default is demo for both) on NixOS, download and install Nix.

``` bash
$ bash <(curl https://nixos.org/nix/install)

...

$ sudo chown -R demo /nix

```

The first command get the installer on nixos website and start to install. 

The second one is to give the privileges to default user.


### Install git

To download this repository and keep it up-to-date, is necessary the git.


Open one terminal and execute this command:

``` bash
$ nix-daemon

```

It's necessary because we are using a multi-user enviroment. You can see this detailed [here](https://nixos.org/nix/manual/#sec-nix-daemon).


Now, let's install the git. Open other terminal and run this command:

``` bash
$ sudo nix-env -iA nixos.pkgs.gitAndTools.gitFull
``` 

### Clone this repository

To clone this repository is simple. Detail: use the HTTPS verions instead of SSH, to simplify.

``` bash
$ git clone https://github.com/derrix060/Haskell-Challenge.git
```

