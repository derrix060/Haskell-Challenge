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
