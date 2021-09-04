#!/bin/bash
rm -rf out

ccache -M 4.5

export ARCH=arm64
mkdir out

DTS_DIR=$(pwd)/out/arch/$ARCH/boot/dts
RELEASE_DIR_ZIP=/home/amd64/drag-kernel-t975/release/anykernel
RELEASE_DIR_TAR=/home/amd64/drag-kernel-t975/release/aik
BUILD_CROSS_COMPILE=/home/amd64/toolchains/gcc-494/bin/aarch64-linux-gnu-
KERNEL_LLVM_BIN=/home/amd64/toolchains/clang-r377782d/bin/clang
CLANG_TRIPLE=aarch64-linux-gnu-
KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

make -j$(nproc) -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE vendor/gts7xl_eur_open_defconfig
make -j$(nproc) -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE

cp $(pwd)/out/arch/$ARCH/boot/Image $(pwd)/out/Image
cat ${DTS_DIR}/vendor/qcom/*.dtb > $(pwd)/out/dtb

rm $RELEASE_DIR_ZIP/DragKernel.zip
rm $RELEASE_DIR_ZIP/Image
rm $RELEASE_DIR_ZIP/dtb

rm $RELEASE_DIR_TAR/boot.img
cp $(pwd)/out/dtb $RELEASE_DIR_ZIP/
cp $(pwd)/out/Image $RELEASE_DIR_ZIP/
cp $(pwd)/out/Image $RELEASE_DIR_TAR/

# build anykernel3 release

cd $RELEASE_DIR_ZIP
zip -r9 DragKernel.zip * -x .git .gitignore

# build tar release
cd $RELEASE_DIR_TAR
./cleanup.sh
cp ../boot.img .
./unpackimg.sh
rm -f split_img/boot.img-kernel boot.img
mv Image split_img/boot.img-kernel
./repackimg.sh
mv image-new.img boot.img && tar -cvf boot.img.tar boot.img



