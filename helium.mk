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

# Live Wallpapers
PRODUCT_PACKAGES += \
        rild \
        Launcher3

PRODUCT_PROPERTY_OVERRIDES := \
        net.dns1=8.8.8.8 \
        net.dns2=8.8.4.4

#
# Inherit the full_base and device configurations
$(call inherit-product, device/linaro/helium/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Helium specific init.rc
#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/init.pxa1928-helium.rc:root/init.pxa1928-target.rc

# TI WLAN/BT Firmware
# Source: http://www.omapzoom.org/?p=device/ti/proprietary-open.git;a=tree;f=wl12xx;h=03ac0d8c1d8871a028fb7cf378fe06e7dda636ab;hb=d-lollipop-mr1-release
#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/ti-bt-wifi-firmware/ti-connectivity/LICENSE:system/etc/firmware/ti-connectivity/LICENSE \
#    $(LOCAL_PATH)/ti-bt-wifi-firmware/ti-connectivity/wl18xx-conf.bin:system/etc/firmware/ti-connectivity/wl18xx-conf.bin \
#    $(LOCAL_PATH)/ti-bt-wifi-firmware/ti-connectivity/wl18xx-fw-4.bin:system/etc/firmware/ti-connectivity/wl18xx-fw-4.bin \
#    $(LOCAL_PATH)/ti-bt-wifi-firmware/License_for_WPAN_Binary_Images.txt:system/etc/firmware/License_for_WPAN_Binary_Images.txt \
#    $(LOCAL_PATH)/ti-bt-wifi-firmware/TIInit_7.2.31.bts:system/etc/firmware/TIInit_7.2.31.bts \
#    $(LOCAL_PATH)/ti-bt-wifi-firmware/TIInit_7.6.15.bts:system/etc/firmware/TIInit_7.6.15.bts \
#    $(LOCAL_PATH)/ti-bt-wifi-firmware/TIInit_10.6.15.bts:system/etc/firmware/TIInit_10.6.15.bts \
#    $(LOCAL_PATH)/ti-bt-wifi-firmware/TIInit_11.8.32.bts:system/etc/firmware/TIInit_11.8.32.bts \
#    $(LOCAL_PATH)/ti-bt-wifi-firmware/TIInit_12.7.27.bts:system/etc/firmware/TIInit_12.7.27.bts \
#    $(LOCAL_PATH)/ti-bt-wifi-firmware/TIInit_12.8.32.bts:system/etc/firmware/TIInit_12.8.32.bts \
#    $(LOCAL_PATH)/ti-bt-wifi-firmware/TIInit_12.10.28.bts:system/etc/firmware/TIInit_12.10.28.bts \

# TI Bluetooth support
#PRODUCT_PACKAGES += \
#    uim-sysfs \
#    libbt-vendor

# Helium specific device properties
#ADDITIONAL_BUILD_PROPERTIES += \
#    wifi.interface=wlan0

PRODUCT_NAME := helium
PRODUCT_DEVICE := helium
PRODUCT_BRAND := marvell
PRODUCT_MODEL := AOSP on Helium
PRODUCT_MANUFACTURER := marvell
