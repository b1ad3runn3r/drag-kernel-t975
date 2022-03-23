#!/bin/bash
rm -rf out

ccache -M 4.5

export ARCH=arm64

echo
echo "Clean Repository"
echo

make clean & make mrproper
#git clean -xfd # failsafe

find . -name "*.orig" -type f -delete

if [ -d out ]; then
    rm -rf out;
fi

if [ -f "release/dtb" ]; then
    rm release/dtb;
fi
if [ -f "release/Image.gz" ]; then
    rm release/Image.gz
fi
if [ -f "release/Image" ]; then
    rm release/Image
fi
if compgen -G "release/modules/system/vendor/lib/modules/*.ko" > /dev/null; then
    rm release/modules/system/vendor/lib/modules/*.ko;
fi
#find "release/modules/system/vendor/lib/modules" -name "*.ko" -type f -delete

if compgen -G "release/*.zip" > /dev/null; then
    rm release/*.zip;
fi
#find "release" -name "*.zip" -type f -delete

echo
echo "Compile Source"
echo

mkdir -p out
mkdir -p release/modules/system/vendor/lib/modules

BUILD_CROSS_COMPILE=$(pwd)/toolchain/gcc/bin/aarch64-linux-android-
KERNEL_LLVM_BIN=$(pwd)/toolchain/clang/bin/clang
CLANG_TRIPLE=aarch64-linux-gnu-
KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

make -j$(nproc) -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE vendor/gts7xl_eur_open_defconfig
make -j$(nproc) -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE

cat out/arch/arm64/boot/dts/vendor/qcom/kona-v2.1.dtb \
    out/arch/arm64/boot/dts/vendor/qcom/kona-v2.dtb \
    out/arch/arm64/boot/dts/vendor/qcom/kona.dtb \
    > out/arch/arm64/boot/dtb

echo
echo "Package Kernel"
echo

if [ -f out/arch/arm64/boot/Image ]; then
    cp -f out/arch/arm64/boot/dtb release/
    if [ -f out/arch/arm64/boot/Image.gz ]; then
        cp -f out/arch/arm64/boot/Image.gz release/
    else
        cp -f out/arch/arm64/boot/Image release/
    fi
    find out -type f -name "*.ko" -exec cp -Rf "{}" release/modules/system/vendor/lib/modules/ \;
    
    HASH=$(git rev-parse --short HEAD)
    
    cd release
    zip -r9 "dragkernel-gts7xl-$HASH.zip" * -x *.DS_Store .git* README.md *placeholder LICENSE
    cd ../
fi
