# **DragKernel - a GTS7XL kernel**
---------------------------------------------------------
## Modified kernel for Samsung Galaxy Tab S7+  
Special thanx to:
* https://github.com/ianmacd for his helpful commits for gts7xl
* https://github.com/Vntnox for his help with building the kernel and adding new features
* https://github.com/freeza-inc for his Wireguard script

## Short description
This is a stock modified kernel from SM-T975 with bugfixes and new features. Android R.

## Features
* Wireguard support
* TTL fixing support
* Removed DM_VERITY, AVB, SECURITY_DEFEX, etc.
* Removed unnecessary debugging and watchdogs
* NTFS R/W support
* Enhanced TCP methods (westwood is default, BBR available)
* Magisk patched already

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
sudo pacman -S base-devel git perl openssl
git clone https://github.com/b1ad3runn3r/drag-kernel-t975 && cd drag-kernel-t975
chmod +x bk.sh && ./bk.sh
```
### Ubuntu
```
sudo apt update
sudo apt install build-essential flex bison libncurses5-dev libssl-dev git
git clone https://github.com/b1ad3runn3r/drag-kernel-t975 && cd drag-kernel-t975
chmod +x bk.sh && ./bk.sh
```
## Post-building
1) Get boot.img from required firmware.
2) Patch it with Magisk, unpack it with [Android Image Kitchen](https://forum.xda-developers.com/t/tool-android-image-kitchen-unpack-repack-kernel-ramdisk-win-android-linux-mac.2073775/).
3) Replace boot.img_kernel with your generated Image(located in out/arch/arm64/boot).
4) Repack the kernel, rename your result to boot.img(or it won't flash) and put it into a tar archive name boot.img.tar.
5) Flash with Odin into AP section(Auto-Reboot option does not matter).

## Using DTB
DTB currently not working. But if you want to test it, see Readmedtb.txt

## Troubleshooting
If your make task fails with "Permission denied", etc. and the failed file is a shell-script, use ```chmod +x script.sh```

## TODO List
- [] Custom I/O schedulers
- [] AnyKernel3
- [] Schedutil governors
- [] Performance and battery patches
- [] Wakelock blockers
- [] ExFAT, NFS, CIFS, F2FS support