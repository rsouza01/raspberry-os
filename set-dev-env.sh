#!/usr/bin/env bash

TMP_FOLDER='../tmp/'
OPT_FOLDER='../opt/'

GCC_TMP_INSTALLER='gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2'
GCC_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/$GCC_TMP_INSTALLER?rev=b748c39178c043b4915b04645d7774d8&hash=9E173D105DC6E0D452EB3A813BF28AAB"

QEMU_TMP_INSTALLER="qemu-7.1.0"
QEMU_URL="https://download.qemu.org/$QEMU_TMP_INSTALLER.tar.xz"


rm -rf  $TMP_FOLDER
rm -rf  $OPT_FOLDER

mkdir -p $TMP_FOLDER
mkdir -p $OPT_FOLDER

# Pre requisites
sudo apt-get update -y
sudo apt-get install -y libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build

# GCC
wget "$GCC_URL" -O "$TMP_FOLDER/$GCC_TMP_INSTALLER"
tar -xf "$TMP_FOLDER/$GCC_TMP_INSTALLER" --directory $OPT_FOLDER
GCC_PATH="$PWD/../opt/gcc-arm-none-eabi-10.3-2021.10/bin"
echo PATH="${PATH:+${PATH}:}$GCC_PATH" >> ~/.bashrc

# QEMU
wget $QEMU_URL -O "$TMP_FOLDER/$QEMU_TMP_INSTALLER.tar.xz"
tar xvJf "$TMP_FOLDER/${QEMU_TMP_INSTALLER}.tar.xz" --directory "$TMP_FOLDER"
pushd "$TMP_FOLDER/$QEMU_TMP_INSTALLER" || exit
./configure --target-list=arm-softmmu,arm-linux-user
make -j 2
sudo make install
popd || exit

rm -rf  $TMP_FOLDER

exec "$BASH" 
