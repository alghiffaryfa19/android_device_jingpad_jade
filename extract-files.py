#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.file import File
from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/jingpad/jade',
    'hardware/sprd'
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    'libavatar': lib_fixup_remove,
    'vendor.sprd.hardware.radio@1.0': lib_fixup_vendor_suffix,
}


blob_fixups: blob_fixups_user_type = {
    'product/lib64/vendor.sprd.hardware.radio@1.0.so': blob_fixup()
        .remove_needed('libhidltransport.so')
        .remove_needed('libhwbinder.so'),
    (
        'vendor/etc/init/img-nn-hal-1-2.rc',
        'vendor/etc/init/init.goodix.rc',
    ): blob_fixup()
        .regex_replace('/mnt/vendor/socko', '/odm/lib/modules'),
    (
        'vendor/etc/init/camera.rc',
        'vendor/etc/init/init.silead.rc',
        'vendor/etc/init/init.sprd_flash.rc',
        'vendor/etc/init/init.sprd_vdsp.rc',
        'vendor/etc/init/wcn.rc',
    ): blob_fixup()
        .regex_replace('\\${ro.vendor.ko.mount.point}\\/socko', '/odm/lib/modules'),
    (
        'vendor/lib/libiwnpi.so',
        'vendor/lib64/libwifi-hal-sprd.so',
    ): blob_fixup()
        .binary_regex_replace(b'/mnt/vendor/socko/sprdwl_ng.ko', b'/odm/lib/modules/sprdwl_ng.ko\x00'),
    'vendor/lib/libnight.so': blob_fixup()
        .remove_needed('libsprddepth.so')
        .remove_needed('libbokeh_depth.so'),
}  # fmt: skip

module = ExtractUtilsModule(
    'jade',
    'jingpad',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
