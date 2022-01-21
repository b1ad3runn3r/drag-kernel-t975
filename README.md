# **DragKernel - a GTS7XL kernel**

## Modified kernel for Samsung Galaxy Tab S7+(SM-T975)  
Special thanx to:
* https://github.com/ianmacd for his TWRP-compatible config
* https://github.com/freeza-inc,
* https://github.com/engstk,
* https://github.com/Jimbo77,
* https://github.com/flar2 for their patches
* https://github.com/osm0sis for his AnyKernel3
* https://github.com/andip71 for Boeffla WL Blocker
* https://github.com/tanish2k09 for K-Lapse livedisplay module
* https://github.com/kdrag0n for proton-clang
* https://github.com/LineageOS for gcc toolchain nested on github

Sorry for not saving authors of original commits in contributors, file in sources vary severely, so I had to check every commit by hand.

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
* K-Lapse
* Andrenoboost
* configs tuning
* and more...

**GPU OC attempt failed successful to 683 MHz.**

## Used sources and toolchains
Kernel sources - [here](https://opensource.samsung.com/uploadSearch?searchValue=SM-T975)

Used toolchains: 

GCC 4.9 by [@LineageOS](https://github.com/LineageOS) - [here](https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/)

Clang toolchain by [@kdrag0n](https://github.com/kdrag0n) - [here](https://github.com/kdrag0n/proton-clang/)

## Building
All toolchain are downloaded automatically, just run build_kernel.sh

### Arch Linux

```
sudo pacman -Syy
sudo pacman -S base-devel git perl openssl ccache bc
git clone --recurse-submodules https://github.com/b1ad3runn3r/drag-kernel-t975 && cd drag-kernel-t975
chmod +x build_kernel.sh && ./build_kernel.sh
```
### Ubuntu
```
sudo apt update
sudo apt install build-essential bc flex bison libncurses5-dev libssl-dev git ccache
git clone --recurse-submodules https://github.com/b1ad3runn3r/drag-kernel-t975 && cd drag-kernel-t975
chmod +x build_kernel.sh && ./build_kernel.sh
```
## Post-building
If you want to flash kernel with Odin:

1) Get boot.img from required firmware.
2) Patch it with Magisk, unpack it with [Android Image Kitchen](https://forum.xda-developers.com/t/tool-android-image-kitchen-unpack-repack-kernel-ramdisk-win-android-linux-mac.2073775/).
3) Replace boot.img_kernel with your generated Image(located in out/arch/arm64/boot).
4) Repack the kernel, rename your result to boot.img(or it won't flash) and put it into a tar archive name boot.img.tar.
5) Flash with Odin into AP section(Auto-Reboot option does not matter).

If you want to use AnyKernel3 variant, check its [repo](https://github.com/osm0sis/AnyKernel3)

## Troubleshooting
If your make task fails with "Permission denied", etc. and the failed file is a shell-script, use ```chmod +x script.sh```

## TODO List
- [X] Custom I/O schedulers
- [X] AnyKernel3
- [X] Performance and battery patches
- [X] Wakelock blocker
- [ ] Experimental NTFS R/W support
- [ ] Support for T970
