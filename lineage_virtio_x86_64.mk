#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit some common Lineage stuff.
TARGET_EXCLUDES_AUDIOFX := true
$(call inherit-product, vendor/lineage/config/common_full_tablet_wifionly.mk)

# Inherit from device
$(call inherit-product, device/virt/virtio_x86_64/device.mk)

PRODUCT_NAME := lineage_virtio_x86_64
PRODUCT_DEVICE := virtio_x86_64
PRODUCT_BRAND := VirtIO
PRODUCT_MANUFACTURER := VirtIO
PRODUCT_MODEL := VirtIO x86_64

PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.manufacturer=$(PRODUCT_MANUFACTURER) \
    ro.soc.model=$(PRODUCT_DEVICE)

# 第三方应用替换 / 预装。
# 必须放在所有 inherit-product 之后：extra.mk 需要从已汇总的 PRODUCT_PACKAGES
# 里剔除 Etar / Jelly / Contacts，再追加替代应用。
$(call inherit-product, vendor/extra/extra.mk)
