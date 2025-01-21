#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

IMGHEADERINSERT := $(HOST_OUT_EXECUTABLES)/imgheaderinsert
INSTALLED_VBMETASIGN_IMAGE_TARGET := $(PRODUCT_OUT)/vbmeta-sign.img

$(INSTALLED_VBMETASIGN_IMAGE_TARGET): PRIVATE_AVB_VBMETA_SIGNING_ARGS := \
    --algorithm $(BOARD_AVB_ALGORITHM) --key $(BOARD_AVB_KEY_PATH)

$(INSTALLED_VBMETASIGN_IMAGE_TARGET): $(IMGHEADERINSERT)
	$(call pretty,"Target vbmeta-sign image: $@")
	$(build-vbmetaimage-target)
	$(hide) $(IMGHEADERINSERT) $@ 1

.PHONY: vbmetasignimage
vbmetasignimage: $(INSTALLED_VBMETASIGN_IMAGE_TARGET)

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_VBMETASIGN_IMAGE_TARGET)
