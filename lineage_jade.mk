#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/jingpad/jade/device.mk)

# Inherit from the LineageOS configuration.
$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_BRAND := JingPad
PRODUCT_DEVICE := jade
PRODUCT_MANUFACTURER := JingLing
PRODUCT_MODEL := JingPad A1
PRODUCT_NAME := lineage_jade

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="ud710_3h10u_native-user 10 QP1A.190711.020 44110 release-keys" \
    BuildFingerprint=JingPad/ud710_3h10u_native/ud710_3h10u:10/QP1A.190711.020/44110:user/release-keys \
    DeviceProduct=jade
