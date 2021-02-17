#
# Copyright (C) 2019 The LineageOS Project
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

TARGET_TEGRA_TOUCH += raydium

$(call inherit-product, device/nvidia/touch/vendor/raydium/raydium.mk)

PRODUCT_PACKAGES += init.cal.rc \
		    init.ray_touch.rc \
		    init.recovery.ray_touch.rc

# Input Device Configuration
PRODUCT_PACKAGES += \
    touch.idc \
    raydium_ts.idc \
    sensor00fn11.idc

TARGET_RECOVERY_DEVICE_MODULES := rm-wrapper

# Raydium userspace is 32-bit, need to explicitly include the libs for recovery when 64-bit
ifeq ($(TARGET_SUPPORTS_64_BIT_APPS),true)
    PRODUCT_COPY_FILES += \
        $(OUT_DIR)/target/product/$(LINEAGE_BUILD)/system/apex/com.android.runtime/bin/linker:recovery/root/system/bin/linker \
        $(OUT_DIR)/target/product/$(LINEAGE_BUILD)/system/apex/com.android.runtime/lib/bionic/libc.so:recovery/root/system/lib/libc.so \
        $(OUT_DIR)/target/product/$(LINEAGE_BUILD)/system/apex/com.android.runtime/lib/bionic/libdl.so:recovery/root/system/lib/libdl.so \
        $(OUT_DIR)/target/product/$(LINEAGE_BUILD)/system/apex/com.android.runtime/lib/bionic/libm.so:recovery/root/system/lib/libm.so \
        $(OUT_DIR)/target/product/$(LINEAGE_BUILD)/vendor/lib/libx.so:recovery/root/system/lib/libx.so \
        $(OUT_DIR)/target/product/$(LINEAGE_BUILD)/system/lib/liblog.so:recovery/root/system/lib/liblog.so \
        $(OUT_DIR)/target/product/$(LINEAGE_BUILD)/system/lib/libc++.so:recovery/root/system/lib/libc++.so \
        $(OUT_DIR)/target/product/$(LINEAGE_BUILD)/system/lib/libstdc++.so:recovery/root/system/lib/libstdc++.so
 else
    PRODUCT_COPY_FILES += \
        $(OUT_DIR)/target/product/$(LINEAGE_BUILD)/system/vendor/lib/libx.so:recovery/root/system/lib/libx.so
 endif
