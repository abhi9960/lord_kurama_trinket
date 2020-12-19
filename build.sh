#!/usr/bin/env bash
git clone --depth=1 https://github.com/kdrag0n/proton-clang clang
git clone https://github.com/dodyirawan85/AnyKernel3.git -b inc-dtbo
IMAGE=$(pwd)/out/arch/arm64/boot/Image.gz-dtb
KERNEL_DIR=$(pwd)
PATH="${PWD}/clang/bin:$PATH"
export LD_LIBRARY_PATH="${PWD}/clang/lib:$LD_LIBRARY_PATH"
CCV="$(clang --version | sed -n "1p" | cut -d \( -f 1"$CUT" | sed 's/[[:space:]]*$//')"
LDV="$(ld.lld --version | head -1)"
export KBUILD_COMPILER_STRING="$CCV + $LDV"
export DEVICE="r5x"
export ARCH=arm64
export VENDOR_EDIT=1
export ODM_WT_EDIT=yes
export WT_FINAL_RELEASE=yes
export PROJECT_NAME=MSM_19631
export TARGET_PRODUCT=trinket
export IS_PROJECT_19631=1
export MSM_19631=1
export OPPO_TARGET_DEVICE=MSM_19631
export KBUILD_BUILD_HOST=titan
export KBUILD_BUILD_USER="lordwitcher"
make O=out ARCH=arm64 vendor/r5x_defconfig
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
		      CC=clang \
		      CROSS_COMPILE=aarch64-linux-gnu- \
		      CROSS_COMPILE_ARM32=arm-linux-gnueabi-
