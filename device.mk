#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common
$(call inherit-product, device/virt/virtio-common/device-common.mk)

DEVICE_PATH := device/virt/virtio_x86_64

# Graphics (Allocator)
TARGET_GRAPHICS_ALLOCATOR_HAL := minigbm-upstream

# Graphics (Composer)
TARGET_DRM_HWCOMPOSER_VARIANT := upstream

# Init
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/init/virtio_x86_64-graphics.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/virtio_x86_64-graphics.rc

# Kernel (Prebuilt)
TARGET_PREBUILT_KERNEL_ARCH := x86_64

# KernelSU-Next
# Kernel side is compiled in through configs/kernel/kernelsu.config; this is the
# manager UI, imported presigned so the kernel's manager-certificate check
# (KernelSU-Next/kernel/Kbuild EXPECTED_MANAGER_HASH) keeps matching.
PRODUCT_PACKAGES += \
    KernelSU-Next

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)
