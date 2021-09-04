# **DragKernel - a GTS7XL kernel**
---------------------------------------------------------
## Modified kernel for Samsung Galaxy Tab S7+(SM-T975)  
Special thanx to:
* https://github.com/ianmacd for his TWRP-compatible config
* https://github.com/freeza-inc,
* https://github.com/engstk,
* https://github.com/Jimbo77,
* https://github.com/flar2 for their patches
* https://github.com/osm0sis for his AnyKernel3 and Android Image Kitchen

Very special thanx to https://github.com/Vntnox for his help on 4pda with building the kernel, dealing with the issues and looking for patches

Если бы вы не отказались делать ядро на A11, то я бы не стал заниматься собственным :D

## Short description
This is a stock modified kernel from SM-T975 with bugfixes and new features. Android R. Current FW version - T975XXU2BUC4

## Features
* Wireguard support
* TTL fixing support
* CIFS, NFS support
* Removed DM_VERITY, AVB, SECURITY_DEFEX, etc.
* Removed unnecessary debugging and watchdogs
* Enhanced TCP methods (westwood is default, bbr, illinois, vegas, htcp, hstcp available)
* Magisk patched already
* ZEN, FIOPS, SIO, BFQ, MAPLE I/O schedulers(FIOPS default)
* Boeffla Wakelock blocker
* Configurable fsync
* configs tuning
* and more...

## Used sources and toolchains
Kernel sources - [here](https://opensource.samsung.com/uploadSearch?searchValue=SM-T975)

Linaro GCC (gcc-linaro-4.9.4-2017.01-x86_64_aarch64-linux-gnu.tar.xz) - [here](https://releases.linaro.org/components/toolchain/binaries/4.9-2017.01/aarch64-linux-gnu/)

Clang 10.0.6 by Google - [here](https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/refs/heads/android11-dev/clang-r377782d/)

## Building
Download Clang and GCC, place them in a comfortable directory, provide paths for them in bk.sh
Install necessary packages as shown below

### Arch Linux

```
sudo pacman -Syy
sudo pacman -S base-devel git perl openssl ccache
git clone https://github.com/b1ad3runn3r/drag-kernel-t975 && cd drag-kernel-t975
chmod +x bk.sh && ./bk.sh
```
### Ubuntu
```
sudo apt update
sudo apt install build-essential flex bison libncurses5-dev libssl-dev git ccache
git clone https://github.com/b1ad3runn3r/drag-kernel-t975 && cd drag-kernel-t975
chmod +x bk.sh && ./bk.sh
```
## Post-building
Both AnyKernel3 zip variant and Odin .tar variant are getting built automatically.
Flashing using Odin : Odin - AP - boot.img.tar(autoreboot does not matter)
Flashing using TWRP : TWRP - Install - DragKernel.zip

## Using DTB
Altered DTB currently not working. 

## Troubleshooting
If your make task fails with "Permission denied", etc. and the failed file is a shell-script, use ```chmod +x script.sh```

## TODO List
- [X] Custom I/O schedulers
- [X] Performance and battery patches
- [ ] Experimental NTFS R/W support
- [ ] VR I/O scheduler
- [ ] Support for T970