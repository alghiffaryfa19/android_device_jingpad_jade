#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# API
PRODUCT_SHIPPING_API_LEVEL := 29

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.example \
    android.hardware.health-service.example_recovery

# Init
PRODUCT_PACKAGES += \
    fstab.ud710 \
    fstab.ud710.ramdisk \
    ueventd.ud710.rc

PRODUCT_COPY_FILES += \
    device/jingpad/jade/init/init.recovery.ud710.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.ud710.rc \
    device/jingpad/jade/init/ueventd.ud710.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ud710.rc

# Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    android.hardware.fastboot-service.example_recovery \
    fastbootd

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    device/jingpad/jade \
    bootable/deprecated-ota \
    hardware/sprd

# Verified boot
PRODUCT_HOST_PACKAGES += imgheaderinsert
