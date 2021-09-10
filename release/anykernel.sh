# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=### DragKernel for Samsung Galaxy Tab S7+###
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=gts7xl
device.name2=SM-T975
device.name3=
device.name4=
device.name5=
supported.versions=
'; } # end properties

## shell variables
block=/dev/block/by-name/boot;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

## AnyKernel install
dump_boot;
patch_cmdline "androidboot.selinux=permissive" "";
patch_cmdline "is_power_efficient" "";
write_boot;

## end install