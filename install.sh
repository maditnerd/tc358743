#!/bin/bash
###########################
# bcm2835_unicam drivers #
###########################
# DESCRIPTION: Install bcm2835_unicam/tc358743 drivers from 6by9 Linux fork
# This should also work for adv7282m ov5647 (https://github.com/6by9/linux/commit/28ac7b3a2651d4b35204938e6c9ec2e4ba54c34e)
# Compilation will take over 1h30.
#
# Discussion : https://www.raspberrypi.org/forums/viewtopic.php?t=120702&start=300#p1231396
# Source : https://github.com/6by9/linux/tree/unicam_v4_4.14
# Documentation (device-tree) : https://github.com/6by9/linux/blob/unicam_v4_4.14/Documentation/devicetree/bindings/media/bcm2835-unicam.txt
# Documentation (driver) : https://github.com/6by9/linux/blob/unicam_v4_4.14/drivers/media/platform/bcm2835/bcm2835-unicam.c


echo "----- BCM2835_unicam drivers installation  ------"
echo "This script wasn't test yet, use it at your own risk!"
echo "This will takes about 2h! Go on the forum : https://www.raspberrypi.org/forums/viewtopic.php?t=120702&start=300#p1231396"

##########
# KERNEL #
##########
echo "... Download Dependencies"
apt-get install bc libncurses5-dev cmake build-essentials

#Clone
echo "... Clone https://github.com/6by9/linux/ - Branch unicam_v4_4.14"
git clone --depth 1 -b unicam_v4_4.14 https://github.com/6by9/linux/

#Compile
echo "... Compile Kernel"
cd Linux
make bcm2709_defconfig
make -j4 zImage modules dtbs
make modules_install

echo "... Copy kernel"
cp arch/arm/boot/dts/*.dtb /boot/
cp arch/arm/boot/dts/overlays/*.dtb* /boot/overlays/
cp arch/arm/boot/dts/overlays/README /boot/overlays/
cp arch/arm/boot/zImage /boot/kernel7.img

echo "... Kernel is ready!"

#########
# YATVA #
#########

echo "... Install yatva fork"
echo "... Download raspberrypi/userland"
git clone https://github.com/raspberrypi/userland.git
echo "... Build userland"
cd userland;./buildme

echo "... Download yatva fork by 6by9"
git clone https://github.com/6by9/yavta
cd yatva;make

echo " "
echo "Everything should be installed"
echo "Add in /boot/config.txt" 
echo "dtparam=i2c_vc"
echo "dtoverlay=tc358743-fast"
echo " "
echo "Add in /boot/cmdline.txt"
echo "cma=128M before rootwait"
echo " "
echo "And reboot!
