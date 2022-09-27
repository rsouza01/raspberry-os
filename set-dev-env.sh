#!/usr/bin/env bash



TMP_FOLDER='../tmp/'
OPT_FOLDER='../opt/'

GCC_URL='https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-aarch64-linux.tar.bz2?rev=b748c39178c043b4915b04645d7774d8&hash=9E173D105DC6E0D452EB3A813BF28AAB'
GCC_TMP_INSTALLER='gcc-arm-none-eabi-X-XXXX-XX-update-linux.tar.bz2'

QEMU_URL="https://download.qemu.org/qemu-2.11.0.tar.xz"
QEMU_TMP_INSTALLER="qemu-2.11.0"

rm -rf  $TMP_FOLDER
rm -rf  $OPT_FOLDER

mkdir -p $TMP_FOLDER
mkdir -p $OPT_FOLDER

wget "$GCC_URL" -O "$TMP_FOLDER/$GCC_TMP_INSTALLER"
tar -xf "$TMP_FOLDER/$GCC_TMP_INSTALLER" --directory $OPT_FOLDER

wget $QEMU_URL -O "$TMP_FOLDER/$QEMU_TMP_INSTALLER.tar.xz"
tar xvJf "$TMP_FOLDER/$QEMU_TMP_INSTALLER.tar.xz" --directory $OPT_FOLDER
cd "$OPT_FOLDER/$QEMU_TMP_INSTALLER" || exit
./configure --target-list=arm-softmmu,arm-linux-user