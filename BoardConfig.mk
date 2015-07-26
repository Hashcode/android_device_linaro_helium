#
# Copyright (C) 2015 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Use the non-open-source parts, if they're present
-include vendor/linaro/helium/BoardConfigVendor.mk

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := generic
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_SMP := true

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a15

TARGET_USES_64_BIT_BINDER := true
TARGET_SUPPORTS_32_BIT_APPS := true
TARGET_SUPPORTS_64_BIT_APPS := true

TARGET_BOARD_PLATFORM := mrvl
ANDROID_64=true

# BT configs
#BOARD_HAVE_BLUETOOTH := true
#BOARD_HAVE_BLUETOOTH_TI := true
#BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/linaro/helium/bluetooth

# Connectivity - Wi-Fi
#USES_TI_MAC80211 := true
#ifeq ($(USES_TI_MAC80211),true)
#BOARD_WPA_SUPPLICANT_DRIVER := NL80211
#WPA_SUPPLICANT_VERSION      := VER_0_8_X
#BOARD_WLAN_DEVICE           := wl12xx_mac80211
#COMMON_GLOBAL_CFLAGS += -DUSES_TI_MAC80211
#endif

#Enable EXT image build if the flash type is emmc or sd card
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

# Boot partition 16*1024*1024
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
# Recovery partition 11*1024*1024
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
# System partition 768*1024*1024
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 805306368
# Userdate parition 0x15d000000-0x4000 (16k reserved for dm-crypt footer)
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5855232000
# Cache partition 512*1024*1024
BOARD_CACHEIMAGE_PARTITION_SIZE := 536870912
# Vendor partition 256*1024*1024
BOARD_VENDORIMAGE_PARTITION_SIZE := 268435456
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
# Build a separate vendor.img
TARGET_COPY_OUT_VENDOR := vendor

BOARD_FLASH_BLOCK_SIZE := 512

# Graphics Options
ENABLE_HWC_GC_PATH := true
# Enable hardware UI
USE_OPENGL_RENDERER := true
MRVL_ION := true
ENABLE_HWC_GCU := false
MRVL_GCU2D_V3 := true
MALLOC_IMPL := dlmalloc

#Enable Marvell HWC enhancement
BOARD_USES_MARVELL_HWC_ENHANCEMENT := true
ifeq ($(BOARD_USES_MARVELL_HWC_ENHANCEMENT), true)
COMMON_GLOBAL_CFLAGS += -DMARVELL_HWC_ENHANCEMENT
endif

## include the kernel/uboot/obm build config below
ANDROID_64 := true
TARGET_KERNEL_SOURCE := kernel/mrvl-3.10
KERNEL_CONFIG := arch/arm64/configs/defconfig ../../device/linaro/helium/defconfig-helium-kernel
KERNEL_TOOLS_PREFIX := $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.8/bin/aarch64-linux-android-
BUILD_KERNEL_MODULES := false
BOARD_MKBOOTIMG_ARGS := --base 0x01200000 --kernel_offset 0x00080000
BOARD_KERNEL_CMDLINE := androidboot.selinux=permissive
DEVICE_TREES := pxa1928-helium:pxa1928-helium

# Select u-boot configuration
TARGET_USE_UBOOT := true
TARGET_UBOOT_SOURCE := u-boot/linaro/u-boot-ara
UBOOT_CONFIG ?= pxa1928_helium_defconfig
UBOOT_TOOLS_PREFIX := $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.8/bin/aarch64-linux-android-

# WLAN 18xx Module Build (used on helium build only)
#WLAN_MODULES:
#	make clean -C hardware/ti/wlan/mac80211/compat_wl18xx CROSS_COMPILE="$(KERNEL_TOOLS_PREFIX)"
#	mkdir -p $(TARGET_OUT)/lib/modules
#	cp device/linaro/helium/defconfig-helium-backport hardware/ti/wlan/mac80211/compat_wl18xx/defconfigs/helium
#	make -C hardware/ti/wlan/mac80211/compat_wl18xx defconfig-helium
#	make -j8 -C hardware/ti/wlan/mac80211/compat_wl18xx KERNEL_DIR=$(KERNEL_OUT) KLIB=$(KERNEL_OUT) KLIB_BUILD=$(KERNEL_OUT) ARCH=arm64 CROSS_COMPILE="$(KERNEL_TOOLS_PREFIX)" CFLAGS_MODULE="-fno-pic"
#	ko=`find hardware/ti/wlan/mac80211/compat_wl18xx -type f -name "*.ko"`;\
#	for i in $$ko; do $(KERNEL_TOOLS_PREFIX)strip --strip-unneeded $$i;\
#	mv $$i $(TARGET_OUT)/lib/modules/; done;

#TARGET_KERNEL_OUT_OF_TREE_MODULES += WLAN_MODULES

# Define custom sepolicy files directory
BOARD_SEPOLICY_DIRS += \
	device/linaro/helium/sepolicy

# Combine specific custom sepolicy files
# with existing ones under /external/sepolicy/
BOARD_SEPOLICY_UNION += \
	zygote.te \
	vold.te \
	surfaceflinger.te \
	FMRadiod.te \
	atcmdsrv.te \
	debuggerd.te \
	file.te \
	init.te \
	installd.te \
	marvelltel.te \
	mwirelessd.te \
	netd.te \
	pppmodem.te \
	seapp_contexts \
	smartcard.te \
	file_contexts \
	bluetooth.te \
	log_on_boot.te \
	nvm.te \
	servicemanager.te \
	setup_fs.te \
	bootanim.te \
	mediaserver.te \
	adbd.te \
	platform_app.te \
	radio.te \
	rild.te \
	shell.te \
	system_app.te \
	untrusted_app.te \
	eeh.te \
	imsc.te \
	diag.te \
	iml.te \
	device.te \
	teecsstdca.te \
	mned.te \
	touch_updater.te \
	phservice.te \
	run_hawk_on_boot.te \
	kmsg.te \
	hawk.te \
	nfc.te \
	sdcardd.te \
	ueventd.te \
	healthd.te \
	wpa.te \
	system_server.te
