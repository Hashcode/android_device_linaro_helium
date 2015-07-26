# Copyright (C) 2015 The Android Open Source Project
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

#define TARGET_DEVICE_DIR at first for the following makefile may need it.
TARGET_DEVICE_DIR := $(LOCAL_PATH)

# Adjust the dalvik heap to be appropriate for a tablet.
$(call inherit-product-if-exists, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

# Graphics
$(call inherit-product-if-exists, vendor/marvell/generic/graphics/user/graphics_modules.mk)
$(call inherit-product-if-exists, vendor/marvell/generic/graphics/user/copyfiles.mk)
$(call inherit-product-if-exists, vendor/marvell/generic/marvell-gralloc/marvell_gralloc_modules.mk)
$(call inherit-product-if-exists, vendor/marvell/generic/hwcomposer/hwc_modules.mk)
$(call inherit-product-if-exists, vendor/marvell/generic/gpu-engine/gpuengine_modules.mk)

#Define HAVE_SECURITY_TZ_FEATURE to enable TZ
HAVE_SECURITY_TZ_FEATURE := true

LOCAL_FSTAB := $(LOCAL_PATH)/fstab.pxa1928
TARGET_RECOVERY_FSTAB = $(LOCAL_FSTAB)

PRODUCT_COPY_FILES := \
    $(LOCAL_PATH)/init.pxa1928.rc:root/init.pxa1928.rc \
    $(LOCAL_PATH)/init.pxa1928.usb.rc:root/init.pxa1928.usb.rc \
    $(LOCAL_FSTAB):root/fstab.pxa1928 \
    $(LOCAL_PATH)/ueventd.pxa1928.rc:root/ueventd.pxa1928.rc \
    system/core/rootdir/init.zygote64_32.rc:root/init.zygote64_32.rc \
    $(LOCAL_PATH)/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/mixer_paths.xml:system/etc/mixer_paths.xml \
    $(LOCAL_PATH)/gfx.cfg:system/etc/gfx.cfg \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml

# Copy hardware config file(s)
PRODUCT_COPY_FILES += $(call add-to-product-copy-files-if-exists, \
    device/linaro/build/android.hardware.screen.xml:system/etc/permissions/android.hardware.screen.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml \
    frameworks/native/data/etc/android.software.backup.xml:system/etc/permissions/android.software.backup.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml)

#    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
#    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
#    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \

# Generic Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default

# Audio debugging
PRODUCT_PACKAGES += \
    tinymix \
    tinyplay \
    tinycap

# WI-Fi
#PRODUCT_PACKAGES += \
#    wpa_supplicant \
#    wpa_supplicant.conf \
#    libwpa_client \
#    dhcpcd.conf \
#    wifical.sh \
#    TQS_D_1.7.ini \
#    TQS_D_1.7_127x.ini \
#    crda \
#    regulatory.bin \
#    wlconf

# Build gatord daemon for DS-5/Streamline
#PRODUCT_PACKAGES += gatord

# Add openssh support for remote debugging and job submission
PRODUCT_PACKAGES += ssh sftp scp sshd ssh-keygen sshd_config start-ssh

# Set zygote config
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.zygote=zygote64_32

# device properties
ADDITIONAL_BUILD_PROPERTIES += \
    ro.sf.lcd_density=160 \
    ro.secure=0 \
    ro.adb.secure=0

# Non-HW accelerated graphics
# (These will be overridden when vendor binaries are present)
ADDITIONAL_BUILD_PROPERTIES += \
    ro.nohardwaregfx=true \
    ro.opengles.version=131072 \
    debug.sf.no_hw_vsync=1 \
    ro.kernel.qemu.gles=0 \
    ro.kernel.qemu=1

# Emulator GLES support
PRODUCT_PACKAGES += \
    libGLES_android

# Filesystem management tools
PRODUCT_PACKAGES += \
    e2fsck \
    setup_fs

PRODUCT_RUNTIMES := runtime_libart_default

ADDITIONAL_BUILD_PROPERTIES += ro.serialno=0123456789ABCDEF

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# device should set this based on the real product density
PRODUCT_AAPT_PREF_CONFIG := xhdpi

droidcore : u-boot

INCLUDE_TESTS := 0
$(call inherit-product-if-exists, device/linaro/build/common-device.mk)
$(call inherit-product-if-exists, hardware/ti/wpan/ti-wpan-products.mk)
