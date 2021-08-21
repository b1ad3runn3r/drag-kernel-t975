################################################################################

cd ~/Downloads/amnesty/out/arch/arm64/boot/dts/vendor/qcom/
cat kona.dtb kona-v2.dtb kona-v2.1.dtb > boot.img-dtb

or

cat out/arch/arm64/boot/dts/vendor/qcom/*.dtb > $(pwd)/out/arch/arm64/boot/dtb.img

################################################################################