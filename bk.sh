#!/bin/bash
rm -rf out

ccache -M 4.5

export ARCH=arm64
mkdir out

BUILD_CROSS_COMPILE=/home/amd64/toolchains/gcc-494/bin/aarch64-linux-gnu-
KERNEL_LLVM_BIN=/home/amd64/toolchains/clang-r377782d/bin/clang
CLANG_TRIPLE=aarch64-linux-gnu-
KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

make -j8 -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE vendor/gts7xl_eur_open_defconfig
make -j8 -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE

#cp out/arch/arm64/boot/Image $(pwd)/arch/arm64/boot/Image