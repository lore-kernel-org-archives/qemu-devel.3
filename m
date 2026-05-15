Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D89BCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 13:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNsVw-0005xV-WD; Fri, 15 May 2026 09:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNsVt-0005x2-Dy
 for qemu-devel@nongnu.org; Fri, 15 May 2026 09:23:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNsVp-0003xn-QI
 for qemu-devel@nongnu.org; Fri, 15 May 2026 09:23:37 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so46852195e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778851399; x=1779456199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=up1A09TrVd1JG8icOPQ920IEp2LjPzqHdIvuoZ1hgmU=;
 b=H5uRJu7H5+l4EWeSlAVOtdx1R2jiik5HiKpIAWvhvHgTazga/XGUP/N9nJprsl5ikT
 ObqnaCDJKvFoWDu21Gcg3ly2ATQVbrUULs287T6W5KgcWMuB8pakjkBE3Ucu1Bol/Ikl
 F6qZfptO50cwF+h5BHhJaurJbU+b/6BjW0ovqByG5Jch5AbciQUuCrFihGZFpWBxMLZ8
 OXtA1yPRQ/8Zk+yXJZ2yPiPWTw68AMv3fmBZ//ocsbTSe2H6ffbvgNm4cdw7Jj3CtBJB
 vb3UCrVXfx0BFnlLCMk2jwob086GCEUSEiteG+FPMtlUWqNTgQfNH8B1GSoK+J6k5pu2
 9LLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778851399; x=1779456199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=up1A09TrVd1JG8icOPQ920IEp2LjPzqHdIvuoZ1hgmU=;
 b=X/JLjr71Hon74yX4+OOVIDnnDqFVc57Gl448CkweawXYdDT2zf2LTvq3GeY5KtFdwc
 mR6S/hJrANSi5Op4/NlMvqMqVW3B8lmtFTKiwiMtjQxkeSpmuWOEPwKxKBMhU+VFRhdC
 HKW+vh7TG4prz2DkQzzc5g9TklaHD4czvMw4kCGETbgqUAYYbiyXRh3eYK31a35OHX5P
 MxKwSve1no1TjH3i8cO4OpGdWJ2Lod9AUO2upYceos3u4zg69aeE00hFImSdTbO38udC
 z1OyUkpcShwzuHvUrmBO6ThiBMR39IBkM6SBkUkbyaLSTB2vkqS1+IUAq21/eUeFhOG3
 16GA==
X-Gm-Message-State: AOJu0YyJkdUIk1sgUBW2knWmZ7xjZ4/m3mbWHHAWfGrUCn/NcpPWeeK+
 wdEtEmqgkE6IutpYg7Epuiq3akHT+QTzXq2s7nrOv61S1GSRTsYH8oLTqsSSUnm/MbSpiuWXtnj
 3DODpsPM=
X-Gm-Gg: Acq92OGmnZUlsTL7GraC57/sWc+xYIO3JofUsMJ/cFFjatHPI7xw9wOtnfW91jGJ5Eg
 +9TNLwjSOvVfU6nF2PxPgSkpnCgoDAqEHp5dFiFuWSQRrY3CU1DVFaScRnMG0xkO+wqpPVYXHrW
 mcqnJc5tnj1o8jyFhhsF+hXISR1L4il/MbiWQFI2BpJxd6krl307FIW/zj2ePZEeve7N2XIVaJx
 GStm8i4afOl4K1/nsPy+wKX6hvU+93QvkE5tTZmRtpTD41YY2uvZ/cOBezXn6AeNY8hCSATeQAE
 RGnmLh2KSbshxVeFrXSI+XaUy6lhoXt06mzm+NC7H5dEt5XWLXiUAyojwSJUXLQkDbWmyaj4Qcy
 BtBuWbXGIBx+HnKOhbaBI+6Djh5/ko+4dYPcGiT70QamEHvq7u4kZwkE+NdEyauQJ6fLICAMOXh
 OPsQjrZTPIQsNWiQKa+kPxqLBCbJ6eBVAO6hlZ110IeJqnVLkFklAaVR4QHgCWdfxJYXGrcYve7
 47LSjmJNgXzU7rWn4H7IQuvbrkhqY7S9RZKRaCV9vmIUjlUhtmB
X-Received: by 2002:a05:600c:5296:b0:48a:65ad:1881 with SMTP id
 5b1f17b1804b1-48fe60ed846mr54205955e9.13.1778851399270; 
 Fri, 15 May 2026 06:23:19 -0700 (PDT)
Received: from localhost.localdomain (ppp-2-86-144-251.home.otenet.gr.
 [2.86.144.251]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe585absm13971705e9.19.2026.05.15.06.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:23:18 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 stefanha@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 1/1] virtio: Add vhost-user-rtc and vhost-user-rtc-pci
Date: Fri, 15 May 2026 16:23:14 +0300
Message-ID: <20260515132315.520678-2-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515132315.520678-1-manos.pitsidianakis@linaro.org>
References: <20260515132315.520678-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Authored solely by me for Panasonic Automotive Systems Co., Ltd., but
based on existing vhost-user devices I wrote in 2025, so the copyright
is mixed.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260416-vhost-user-rtc-v2-1-100a53bfc6ce@linaro.org
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/virtio/vhost-user-rtc.h        | 22 +++++++
 MAINTAINERS                               |  6 ++
 docs/system/devices/virtio/vhost-user.rst |  3 +
 hw/virtio/Kconfig                         |  5 ++
 hw/virtio/meson.build                     |  3 +
 hw/virtio/vhost-user-rtc-pci.c            | 70 +++++++++++++++++++++++
 hw/virtio/vhost-user-rtc.c                | 64 +++++++++++++++++++++
 7 files changed, 173 insertions(+)
 create mode 100644 include/hw/virtio/vhost-user-rtc.h
 create mode 100644 hw/virtio/vhost-user-rtc-pci.c
 create mode 100644 hw/virtio/vhost-user-rtc.c

diff --git a/include/hw/virtio/vhost-user-rtc.h b/include/hw/virtio/vhost-user-rtc.h
new file mode 100644
index 0000000000..6b7b53c28f
--- /dev/null
+++ b/include/hw/virtio/vhost-user-rtc.h
@@ -0,0 +1,22 @@
+/*
+ * Vhost-user RTC virtio device
+ *
+ * Copyright (c) 2025 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ * Copyright 2026 Panasonic Automotive Systems Co., Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VHOST_USER_RTC_H
+#define QEMU_VHOST_USER_RTC_H
+
+#include "hw/virtio/vhost-user-base.h"
+
+#define TYPE_VHOST_USER_RTC "vhost-user-rtc"
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserRTC, VHOST_USER_RTC)
+
+struct VHostUserRTC {
+    VHostUserBase parent_obj;
+};
+
+#endif /* QEMU_VHOST_USER_RTC_H */
diff --git a/MAINTAINERS b/MAINTAINERS
index 80d28e618d..eda1e84268 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2586,6 +2586,12 @@ S: Maintained
 F: include/hw/virtio/vhost-user-spi.h
 F: hw/virtio/vhost-user-spi*
 
+vhost-user-rtc
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Supported
+F: include/hw/virtio/vhost-user-rtc.h
+F: hw/virtio/vhost-user-rtc*
+
 virtio-crypto
 M: Gonglei <arei.gonglei@huawei.com>
 S: Supported
diff --git a/docs/system/devices/virtio/vhost-user.rst b/docs/system/devices/virtio/vhost-user.rst
index 2806d81ca2..acfbd609d0 100644
--- a/docs/system/devices/virtio/vhost-user.rst
+++ b/docs/system/devices/virtio/vhost-user.rst
@@ -61,6 +61,9 @@ platform details for what sort of virtio bus to use.
   * - vhost-user-spi
     - Proxy spi devices to host
     - `vhost-device-spi <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-spi>`_
+  * - vhost-user-rtc
+    - Real time clock
+    - `vhost-device-rtc <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-rtc>`_
 
 The referenced *daemons* are not exhaustive, any conforming backend
 implementing the device and using the vhost-user protocol should work.
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 8895682c61..2ebdac16b3 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -136,3 +136,8 @@ config VHOST_USER_TEST
     bool
     default y
     depends on VIRTIO && VHOST_USER
+
+config VHOST_USER_RTC
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 415e359e9f..e0566a60de 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -27,6 +27,7 @@ if have_vhost
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files('vhost-user-snd.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SPI', if_true: files('vhost-user-spi.c'))
+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RTC', if_true: files('vhost-user-rtc.c'))
 
     # PCI Stubs
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_TEST'],
@@ -43,6 +44,8 @@ if have_vhost
                          if_true: files('vhost-user-input-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SPI'],
                          if_true: files('vhost-user-spi-pci.c'))
+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_RTC'],
+                         if_true: files('vhost-user-rtc-pci.c'))
   endif
   if have_vhost_vdpa
     system_virtio_ss.add(files('vhost-vdpa.c'))
diff --git a/hw/virtio/vhost-user-rtc-pci.c b/hw/virtio/vhost-user-rtc-pci.c
new file mode 100644
index 0000000000..449368d270
--- /dev/null
+++ b/hw/virtio/vhost-user-rtc-pci.c
@@ -0,0 +1,70 @@
+/*
+ * Vhost-user RTC virtio device PCI glue
+ *
+ * Copyright (c) 2025 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ * Copyright 2026 Panasonic Automotive Systems Co., Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/virtio/vhost-user-rtc.h"
+#include "hw/virtio/virtio-pci.h"
+
+struct VHostUserRTCPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserRTC vdev;
+};
+
+typedef struct VHostUserRTCPCI VHostUserRTCPCI;
+
+#define TYPE_VHOST_USER_RTC_PCI "vhost-user-rtc-pci-base"
+
+DECLARE_INSTANCE_CHECKER(VHostUserRTCPCI, VHOST_USER_RTC_PCI,
+                         TYPE_VHOST_USER_RTC_PCI)
+
+static void vhost_user_rtc_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserRTCPCI *dev = VHOST_USER_RTC_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    vpci_dev->nvectors = 1;
+
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void vhost_user_rtc_pci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_rtc_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_SYSTEM_RTC;
+}
+
+static void vhost_user_rtc_pci_instance_init(Object *obj)
+{
+    VHostUserRTCPCI *dev = VHOST_USER_RTC_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_RTC);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_rtc_pci_info = {
+    .base_name = TYPE_VHOST_USER_RTC_PCI,
+    .non_transitional_name = "vhost-user-rtc-pci",
+    .instance_size = sizeof(VHostUserRTCPCI),
+    .instance_init = vhost_user_rtc_pci_instance_init,
+    .class_init = vhost_user_rtc_pci_class_init,
+};
+
+static void vhost_user_rtc_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_rtc_pci_info);
+}
+
+type_init(vhost_user_rtc_pci_register);
diff --git a/hw/virtio/vhost-user-rtc.c b/hw/virtio/vhost-user-rtc.c
new file mode 100644
index 0000000000..88b0c70b90
--- /dev/null
+++ b/hw/virtio/vhost-user-rtc.c
@@ -0,0 +1,64 @@
+/*
+ * Vhost-user RTC virtio device
+ *
+ * Copyright (c) 2025 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ * Copyright 2026 Panasonic Automotive Systems Co., Ltd.
+ *
+ * Simple wrapper of the generic vhost-user-device.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/virtio/vhost-user-rtc.h"
+#include "standard-headers/linux/virtio_ids.h"
+
+static const VMStateDescription vu_rtc_vmstate = {
+    .name = "vhost-user-rtc",
+    .unmigratable = 1,
+};
+
+static const Property vrtc_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+};
+
+static void vu_rtc_base_realize(DeviceState *dev, Error **errp)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
+
+    vub->virtio_id = VIRTIO_ID_CLOCK;
+    vub->num_vqs = 2;
+    vub->config_size = 0;
+    vub->vq_size = 1024;
+
+    vubs->parent_realize(dev, errp);
+}
+
+static void vu_rtc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
+
+    dc->vmsd = &vu_rtc_vmstate;
+    device_class_set_props(dc, vrtc_properties);
+    device_class_set_parent_realize(dc, vu_rtc_base_realize,
+                                    &vubc->parent_realize);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo vu_rtc_info = {
+    .name = TYPE_VHOST_USER_RTC,
+    .parent = TYPE_VHOST_USER_BASE,
+    .instance_size = sizeof(VHostUserRTC),
+    .class_init = vu_rtc_class_init,
+};
+
+static void vu_rtc_register_types(void)
+{
+    type_register_static(&vu_rtc_info);
+}
+
+type_init(vu_rtc_register_types)
-- 
γαῖα πυρί μιχθήτω


