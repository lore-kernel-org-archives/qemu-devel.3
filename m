Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8642BE64014
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 07:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9HvV-0003zV-4i; Sun, 05 Apr 2026 03:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvT-0003yT-Sp
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:43 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvP-0007PI-C8
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:43 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2c7d8bbad06so7605378eec.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775374178; x=1775978978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JbIKg+vYqclDU8Q8UgiO3lCc9fAOAsgjLkxdJlPCOA=;
 b=OotdOmNBOSKBM5hFKLRKYLlvPEtVEKxaQZV6RfxxDaIOReouRM3v5Wzlsd8vEF4/FJ
 GhnN4tvjA0ckj9YYNQ4MLqrQRwguTaELgJZDXiEKKV1rjGDVTs7YddLglgMlHsZIZAUC
 BH4SEcownSN3vO8rwwkuT9MwcihNlAkO3pP8ofOKoLNT+UcFOA9z06eTdVM+GAnuxFdp
 DFiLniNn55ehp8fz9YULqAnDUeghPdoAmkPg756rriyOpfm9wtd9ZVph0CLWGmT05JS3
 ijjPEBQRJZUaWi9lKslwhUEuT2dffpfivihCm4l32pkjDonMWHn5N1628aNRcsw0iLSv
 iZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775374178; x=1775978978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6JbIKg+vYqclDU8Q8UgiO3lCc9fAOAsgjLkxdJlPCOA=;
 b=OYpCdFJahLcrhNcQRGjVQGOUXABpWg36NWTq1Md+1iM0ZPeb+18teFJZv2ZVC9weMH
 PlLoQa8LwZXCeb8+xA6YtE3u5xztFh5inMmCFeOGUlVSG/O56VW7dWwkoZwGUHhoyJGU
 eDLfgmhHfjMv8gtdENxhqXHqjFGD1+39bhG53AVi2eaYx9lIxrlYMr8mOg/3KqjJt2Ic
 DRpbBOyuC7DOB2G3+ZdNh4Yfhfg74CQj/aLM4s025wB3GvPtdDiS/NEuTagXSBwZKqX6
 wrLS0nUsdS3YqZDbQazDvk8vuRYxP6PTuf13+EpAy2rIOxs0LR8y9wFp+GnzYV3k+lu4
 CYow==
X-Gm-Message-State: AOJu0YxA2WyjhZaObQ0DKWHRkZC+104i6gMzwMEd5jtNqRDhUh6XMGyQ
 Hw9sVdHChrZSfFjpmTqUVWQQrK9yMQaA3o6LyJMXad/ZOVZNWsQECO2W7ee0PT1f39E=
X-Gm-Gg: AeBDies4/ZAMW577F1khBPd8ABqKisDxmGnmDbmPgqWs2tuzItAZc3uTcyXXQb49Aof
 2LaY1pMs1rkvIus1rkvBgZ/BecF/TAlu0xGPyZaOJCYqjBXYmVMTXCF4jn7fkWlrcaXjyuqRfCW
 xTuSpTKXQRXF5IkINCi9EciHBHYZIZE6GsHXpa5UMY9mTSlFUTioAyDSOL4Ob1bk6da4blSVCbY
 M6He2sP/DkAFi6/FwsI78Mv2F030fXQMmpMAyolyuTjS9rxY/7ij/ur9+9a5NcMHXwHK16wLCvQ
 FR7Cz8s79gus99lRjFCz9LoFMS9Iqyr5sOfsFz9BYXleyWV5LFvFbQxzL1MNQL2+798SfA+fzKK
 YNGJN77+AnALixRZU5o1L2lsCSVjMiZV9CUE0b6uHsWy3R1xexclU0cbjlYbhFaVkgI5Ay9c5uC
 fwrCUdoNvHawe2VgMEvR7E90Ru9IneNl1CVJg9TLtGfY01IA2r/0SeTkDW6cnqCRlfH9hKHnaDN
 9rvHfElIy35ID+Tgd8rk0u5xpo=
X-Received: by 2002:a05:7300:a506:b0:2c3:9981:e8ee with SMTP id
 5a478bee46e88-2cbfa2d188cmr4200374eec.12.1775374177349; 
 Sun, 05 Apr 2026 00:29:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:41e4:ff2b:ff70:4d75])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cb92ea0ef1sm7636502eec.21.2026.04.05.00.29.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Apr 2026 00:29:36 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, rbolshakov@ddn.com,
 phil@philjordan.eu, mst@redhat.com, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, qemu-s390x@nongnu.org,
 "Scott J. Goldman" <scottjg@umich.edu>,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [RFC PATCH 08/10] vfio/apple: Add IOMMU container and PCI device
Date: Sun,  5 Apr 2026 00:28:52 -0700
Message-ID: <20260405072857.66484-9-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405072857.66484-1-scottjgo@gmail.com>
References: <20260405072857.66484-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: "Scott J. Goldman" <scottjg@umich.edu>

Add the core Apple VFIO backend: an IOMMU container type and a PCI
device type that together provide VFIO passthrough on macOS via the
VFIOUserPCIDriver DriverKit extension.

AppleVFIOContainer (container-apple.c):
  Implements VFIOIOMMUClass for DMA map/unmap by calling through to the
  dext client's register/unregister_dma functions.  Synthesizes
  VFIO_DEVICE_GET_INFO responses with appropriate flags for the
  passthrough device.

VFIOApplePCIDevice (apple-device.c):
  QOM type "vfio-apple-pci" subclassing VFIOPCIDevice.  Provides the
  full VFIODeviceIOOps implementation:
  - Config space reads forwarded to the dext; writes filtered to block
    BAR and status register reprogramming (macOS/DART owns those).
  - PCI COMMAND register writes forwarded for bus-master/memory-space
    enable.
  - BAR regions directly mapped via IOConnectMapMemory64 and accessed
    as host MMIO loads/stores.
  - MSI/MSI-X interrupt delivery through a bitmap-poll model with
    async GCD notification bridged to an EventNotifier.
  - Device reset via the dext (IOPCIDevice::Reset FLR/hot-reset).
  - Shared dext connection management for multi-function devices.

apple.h defines the shared types: AppleVFIOContainer, AppleVFIOState,
AppleVFIOBarMap, and VFIOApplePCIDevice.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
 hw/vfio/apple-device.c    | 945 ++++++++++++++++++++++++++++++++++++++
 hw/vfio/apple.h           |  74 +++
 hw/vfio/container-apple.c | 241 ++++++++++
 hw/vfio/meson.build       |   6 +-
 4 files changed, 1264 insertions(+), 2 deletions(-)
 create mode 100644 hw/vfio/apple-device.c
 create mode 100644 hw/vfio/apple.h
 create mode 100644 hw/vfio/container-apple.c

diff --git a/hw/vfio/apple-device.c b/hw/vfio/apple-device.c
new file mode 100644
index 0000000000..9291ac845b
--- /dev/null
+++ b/hw/vfio/apple-device.c
@@ -0,0 +1,945 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Apple/macOS VFIO PCI device passthrough via DriverKit dext.
+ *
+ * Copyright (c) 2026 Scott J. Goldman
+ */
+
+#include "qemu/osdep.h"
+
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <linux/vfio.h>
+
+#include "apple-dext-client.h"
+#include "hw/vfio/apple.h"
+#include "hw/vfio/vfio-container.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/host-pci-mmio.h"
+#include "qemu/main-loop.h"
+
+typedef struct AppleVFIOSharedDext {
+    io_connect_t conn;
+    uint32_t refs;
+} AppleVFIOSharedDext;
+
+typedef struct AppleVFIODMAProbe {
+    uint64_t managed_bdf;
+    uint64_t host_bus;
+    uint64_t host_device;
+    uint64_t host_function;
+    DeviceState *match;
+} AppleVFIODMAProbe;
+
+static GHashTable *apple_vfio_shared_dexts;
+
+static inline guint apple_vfio_dext_key(uint8_t bus, uint8_t device,
+                                        uint8_t function)
+{
+    return ((guint)bus << 16) | ((guint)device << 8) | function;
+}
+
+static inline AppleVFIOContainer *apple_vfio_container(VFIODevice *vbasedev)
+{
+    return VFIO_IOMMU_APPLE(vbasedev->bcontainer);
+}
+
+static inline io_connect_t apple_vfio_connection(VFIODevice *vbasedev)
+{
+    AppleVFIOContainer *container = apple_vfio_container(vbasedev);
+
+    return container ? container->dext_conn : IO_OBJECT_NULL;
+}
+
+static void apple_vfio_find_dma_companion_cb(PCIBus *bus, PCIDevice *pdev,
+                                             void *opaque)
+{
+    AppleVFIODMAProbe *probe = opaque;
+    Error *err = NULL;
+    uint64_t managed_bdf;
+    uint64_t host_bus;
+    uint64_t host_device;
+    uint64_t host_function;
+
+    if (probe->match ||
+        !object_dynamic_cast(OBJECT(pdev), "apple-dma-pci")) {
+        return;
+    }
+
+    managed_bdf = object_property_get_uint(OBJECT(pdev), "managed-bdf", &err);
+    if (err) {
+        error_free(err);
+        return;
+    }
+
+    host_bus = object_property_get_uint(OBJECT(pdev), "x-apple-host-bus", &err);
+    if (err) {
+        error_free(err);
+        return;
+    }
+
+    host_device = object_property_get_uint(OBJECT(pdev),
+                                           "x-apple-host-device", &err);
+    if (err) {
+        error_free(err);
+        return;
+    }
+
+    host_function = object_property_get_uint(OBJECT(pdev),
+                                             "x-apple-host-function", &err);
+    if (err) {
+        error_free(err);
+        return;
+    }
+
+    if (managed_bdf == probe->managed_bdf &&
+        host_bus == probe->host_bus &&
+        host_device == probe->host_device &&
+        host_function == probe->host_function) {
+        probe->match = DEVICE(pdev);
+    }
+}
+
+static DeviceState *apple_vfio_find_dma_companion(VFIOApplePCIDevice *adev)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(adev);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    AppleVFIODMAProbe probe = {
+        .managed_bdf = PCI_BUILD_BDF(pci_dev_bus_num(pdev), pdev->devfn),
+        .host_bus = vdev->host.bus,
+        .host_device = vdev->host.slot,
+        .host_function = vdev->host.function,
+    };
+
+    pci_for_each_device_under_bus(pci_device_root_bus(pdev),
+                                  apple_vfio_find_dma_companion_cb, &probe);
+    return probe.match;
+}
+
+static void apple_vfio_signal_irqfd(int fd)
+{
+    static const uint64_t value = 1;
+    ssize_t ret;
+
+    if (fd < 0) {
+        return;
+    }
+
+    do {
+        ret = write(fd, &value, sizeof(value));
+    } while (ret < 0 && errno == EINTR);
+}
+
+static void apple_vfio_deliver_irq(VFIOPCIDevice *vdev, uint32_t vector)
+{
+    switch (vdev->interrupt) {
+    case VFIO_INT_MSI:
+    case VFIO_INT_MSIX:
+        if (vector < vdev->nr_vectors && vdev->msi_vectors[vector].use) {
+            apple_vfio_signal_irqfd(
+                event_notifier_get_wfd(&vdev->msi_vectors[vector].interrupt));
+        }
+        break;
+    case VFIO_INT_INTx:
+        apple_vfio_signal_irqfd(
+            event_notifier_get_wfd(&vdev->intx.interrupt));
+        break;
+    default:
+        break;
+    }
+}
+
+/*
+ * Called on a GCD dispatch queue when the dext signals pending interrupts.
+ * Just pokes the EventNotifier to wake the QEMU main loop.
+ */
+static void apple_vfio_irq_wakeup(void *opaque)
+{
+    VFIOApplePCIDevice *adev = opaque;
+
+    event_notifier_set(&adev->apple->irq_notifier);
+}
+
+/*
+ * QEMU main-loop fd handler: drain the pending-interrupt bitfield from
+ * the dext, deliver each flagged vector, then re-arm the async wait.
+ */
+static void apple_vfio_irq_handler(void *opaque)
+{
+    VFIOApplePCIDevice *adev = opaque;
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(adev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    io_connect_t conn = apple_vfio_connection(vbasedev);
+    AppleVFIOState *apple = adev->apple;
+    uint64_t pending[4];
+    int word;
+
+    if (!event_notifier_test_and_clear(&apple->irq_notifier)) {
+        return;
+    }
+
+    if (conn == IO_OBJECT_NULL) {
+        return;
+    }
+
+    if (apple_dext_read_pending_irqs(conn, pending) != KERN_SUCCESS) {
+        apple_dext_interrupt_notify_rearm(apple->irq_notify);
+        return;
+    }
+
+    for (word = 0; word < 4; word++) {
+        uint64_t bits = pending[word];
+
+        while (bits) {
+            int bit = __builtin_ctzll(bits);
+            uint32_t vector = word * 64 + bit;
+
+            apple_vfio_deliver_irq(vdev, vector);
+            bits &= bits - 1;
+        }
+    }
+
+    apple_dext_interrupt_notify_rearm(apple->irq_notify);
+}
+
+bool apple_vfio_get_bar_info(VFIOApplePCIDevice *adev, uint8_t bar,
+                             uint8_t *mem_idx, uint64_t *size,
+                             uint8_t *type)
+{
+    io_connect_t conn = apple_vfio_connection(&VFIO_PCI_DEVICE(adev)->vbasedev);
+
+    if (conn != IO_OBJECT_NULL) {
+        return apple_dext_get_bar_info(conn, bar, mem_idx, size, type) ==
+               KERN_SUCCESS;
+    }
+
+    if (mem_idx) {
+        *mem_idx = 0;
+    }
+    if (size) {
+        *size = 0;
+    }
+    if (type) {
+        *type = 0;
+    }
+    return false;
+}
+
+static void apple_vfio_pci_init(VFIOApplePCIDevice *adev)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(adev);
+
+    /*
+     * On macOS, HVF can only map on 16kb page boundaries, so these quirk
+     * fixes end up breaking things. Likewise the performance enhancements
+     * there rely on kvm-specific features. Disable for now, but we should
+     * revisit this.
+     */
+    vdev->no_bar_quirks = true;
+}
+
+static bool apple_vfio_pci_pre_realize(VFIOApplePCIDevice *adev, Error **errp)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(adev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    adev->apple = g_new0(AppleVFIOState, 1);
+
+    if (!vbasedev->name) {
+        vbasedev->name = g_strdup_printf("apple-%04x:%02x:%02x.%x",
+                                         vdev->host.domain,
+                                         vdev->host.bus,
+                                         vdev->host.slot,
+                                         vdev->host.function);
+    }
+
+    return true;
+}
+
+static bool apple_vfio_create_dma_companion(VFIOApplePCIDevice *adev,
+                                            Error **errp)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(adev);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    DeviceState *dev;
+
+    if (adev->dma_companion_autocreated && adev->dma_companion) {
+        return true;
+    }
+
+    if (apple_vfio_find_dma_companion(adev) != NULL) {
+        return true;
+    }
+
+    dev = qdev_new("apple-dma-pci");
+    if (!object_property_set_uint(OBJECT(dev), "managed-bdf",
+                                  PCI_BUILD_BDF(pci_dev_bus_num(pdev),
+                                                pdev->devfn), errp) ||
+        !object_property_set_uint(OBJECT(dev), "x-apple-host-bus",
+                                  vdev->host.bus, errp) ||
+        !object_property_set_uint(OBJECT(dev), "x-apple-host-device",
+                                  vdev->host.slot, errp) ||
+        !object_property_set_uint(OBJECT(dev), "x-apple-host-function",
+                                  vdev->host.function, errp)) {
+        object_unref(OBJECT(dev));
+        return false;
+    }
+
+    if (!qdev_realize(dev, BUS(pci_get_bus(pdev)), errp)) {
+        object_unref(OBJECT(dev));
+        return false;
+    }
+
+    adev->dma_companion = dev;
+    adev->dma_companion_autocreated = true;
+    object_unref(OBJECT(dev));
+    return true;
+}
+
+static void apple_vfio_destroy_dma_companion(VFIOApplePCIDevice *adev)
+{
+    if (!adev->dma_companion_autocreated || adev->dma_companion == NULL) {
+        return;
+    }
+
+    object_unparent(OBJECT(adev->dma_companion));
+    adev->dma_companion = NULL;
+    adev->dma_companion_autocreated = false;
+}
+
+bool apple_vfio_device_setup(VFIOApplePCIDevice *adev, Error **errp)
+{
+    VFIODevice *vbasedev = &VFIO_PCI_DEVICE(adev)->vbasedev;
+    io_connect_t conn = apple_vfio_connection(vbasedev);
+    uint32_t num_vectors = 0;
+    kern_return_t kr;
+
+    if (conn == IO_OBJECT_NULL) {
+        error_setg(errp, "vfio-apple: missing dext connection");
+        return false;
+    }
+
+    kr = apple_dext_setup_interrupts(conn, &num_vectors);
+    if (kr != KERN_SUCCESS) {
+        error_setg(errp, "vfio-apple: failed to setup interrupts (kr=0x%x)",
+                   kr);
+        return false;
+    }
+
+    adev->apple->num_irq_vectors = num_vectors;
+
+    if (event_notifier_init(&adev->apple->irq_notifier, false) < 0) {
+        error_setg(errp, "vfio-apple: failed to create IRQ event notifier");
+        return false;
+    }
+
+    qemu_set_fd_handler(event_notifier_get_fd(&adev->apple->irq_notifier),
+                        apple_vfio_irq_handler, NULL, adev);
+
+    adev->apple->irq_notify =
+        apple_dext_interrupt_notify_create(conn, apple_vfio_irq_wakeup, adev);
+    if (!adev->apple->irq_notify) {
+        error_setg(errp,
+                   "vfio-apple: failed to create IRQ async notification");
+        qemu_set_fd_handler(
+            event_notifier_get_fd(&adev->apple->irq_notifier),
+            NULL, NULL, NULL);
+        event_notifier_cleanup(&adev->apple->irq_notifier);
+        return false;
+    }
+
+    return true;
+}
+
+void apple_vfio_device_cleanup(VFIOApplePCIDevice *adev)
+{
+    AppleVFIOState *apple = adev->apple;
+
+    if (!apple) {
+        return;
+    }
+
+    if (apple->irq_notify) {
+        apple_dext_interrupt_notify_destroy(apple->irq_notify);
+        apple->irq_notify = NULL;
+
+        qemu_set_fd_handler(event_notifier_get_fd(&apple->irq_notifier),
+                            NULL, NULL, NULL);
+        event_notifier_cleanup(&apple->irq_notifier);
+    }
+}
+
+static int apple_vfio_device_feature(VFIODevice *vdev,
+                                     struct vfio_device_feature *feat)
+{
+    return -ENOTTY;
+}
+
+static int apple_vfio_device_reset(VFIODevice *vbasedev)
+{
+    io_connect_t conn = apple_vfio_connection(vbasedev);
+
+    if (conn == IO_OBJECT_NULL) {
+        return -ENODEV;
+    }
+
+    return apple_dext_reset_device(conn) == KERN_SUCCESS ? 0 : -EIO;
+}
+
+static int apple_vfio_get_region_info(VFIODevice *vbasedev,
+                                      struct vfio_region_info *info,
+                                      int *fd)
+{
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(vbasedev->dev);
+    uint32_t index = info->index;
+    uint64_t size = 0;
+
+    if (fd) {
+        *fd = -1;
+    }
+
+    memset((char *)info + offsetof(struct vfio_region_info, flags), 0,
+           sizeof(*info) - offsetof(struct vfio_region_info, flags));
+
+    info->index = index;
+    info->flags = VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE;
+    info->offset = (uint64_t)index << 20;
+
+    switch (info->index) {
+    case VFIO_PCI_BAR0_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
+        if (!apple_vfio_get_bar_info(adev, info->index, NULL, &size, NULL)) {
+            size = 0;
+        }
+        info->size = size;
+        info->flags |= VFIO_REGION_INFO_FLAG_MMAP;
+        break;
+    case VFIO_PCI_CONFIG_REGION_INDEX:
+        info->size = PCIE_CONFIG_SPACE_SIZE;
+        break;
+    case VFIO_PCI_ROM_REGION_INDEX:
+    case VFIO_PCI_VGA_REGION_INDEX:
+        info->size = 0;
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int apple_vfio_get_irq_info(VFIODevice *vbasedev,
+                                   struct vfio_irq_info *info)
+{
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(vbasedev->dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(adev);
+
+    switch (info->index) {
+    case VFIO_PCI_MSI_IRQ_INDEX:
+        info->flags = VFIO_IRQ_INFO_EVENTFD;
+        info->count = adev->apple->num_irq_vectors;
+        break;
+    case VFIO_PCI_MSIX_IRQ_INDEX:
+        info->flags = VFIO_IRQ_INFO_EVENTFD | VFIO_IRQ_INFO_NORESIZE;
+        info->count = vdev->msix ? vdev->msix->entries : 0;
+        break;
+    case VFIO_PCI_INTX_IRQ_INDEX:
+        info->flags = VFIO_IRQ_INFO_EVENTFD;
+        info->count = 1;
+        break;
+    case VFIO_PCI_ERR_IRQ_INDEX:
+    case VFIO_PCI_REQ_IRQ_INDEX:
+        /*
+         * Apple dext passthrough has no kernel-side AER or device-request
+         * notification currently; return count 0 to tell the core to skip
+         * these.
+         */
+        info->flags = 0;
+        info->count = 0;
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static void apple_vfio_update_irq_mask(VFIODevice *vbasedev)
+{
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(vbasedev->dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(adev);
+    io_connect_t conn = apple_vfio_connection(vbasedev);
+    uint64_t mask[4] = {0};
+    uint32_t i;
+
+    if (conn == IO_OBJECT_NULL) {
+        return;
+    }
+
+    switch (vdev->interrupt) {
+    case VFIO_INT_MSI:
+    case VFIO_INT_MSIX:
+        for (i = 0; i < vdev->nr_vectors; i++) {
+            if (vdev->msi_vectors[i].use) {
+                mask[i / 64] |= 1ULL << (i % 64);
+            }
+        }
+        break;
+    case VFIO_INT_INTx:
+        mask[0] = 1;
+        break;
+    default:
+        break;
+    }
+
+    apple_dext_set_irq_mask(conn, mask);
+}
+
+static int apple_vfio_set_irqs(VFIODevice *vbasedev, struct vfio_irq_set *irq)
+{
+    apple_vfio_update_irq_mask(vbasedev);
+    return 0;
+}
+
+static int apple_vfio_bar_read(VFIODevice *vbasedev, uint8_t nr, off_t off,
+                               uint32_t size, void *data)
+{
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(vbasedev->dev);
+    AppleVFIOBarMap *bm = &adev->apple->bar_maps[nr];
+    const void *p;
+    uint64_t value;
+
+    if (!bm->addr || off + size > bm->size) {
+        error_report("vfio-apple: BAR%d read out of range or unmapped", nr);
+        return -EINVAL;
+    }
+
+    if (size != 1 && size != 2 && size != 4 && size != 8) {
+        return -EINVAL;
+    }
+
+    p = (const char *)bm->addr + off;
+    value = host_pci_ldn_le_p(p, size);
+    memcpy(data, &value, size);
+
+    return size;
+}
+
+static int apple_vfio_region_read(VFIODevice *vbasedev, uint8_t nr, off_t off,
+                                  uint32_t size, void *data)
+{
+    io_connect_t conn = apple_vfio_connection(vbasedev);
+    kern_return_t kr;
+    uint32_t legacy_size = 0;
+
+    if (nr != VFIO_PCI_CONFIG_REGION_INDEX) {
+        return apple_vfio_bar_read(vbasedev, nr, off, size, data);
+    }
+
+    if (conn == IO_OBJECT_NULL) {
+        return -ENODEV;
+    }
+
+    legacy_size = MIN(size, PCIE_CONFIG_SPACE_SIZE - off);
+
+    if (legacy_size == 1 || legacy_size == 2 || legacy_size == 4) {
+        uint64_t value = 0;
+
+        kr = apple_dext_config_read(conn, off, legacy_size, &value);
+        if (kr != KERN_SUCCESS) {
+            return -EIO;
+        }
+
+        memcpy(data, &value, legacy_size);
+        if (legacy_size < size) {
+            memset((uint8_t *)data + legacy_size, 0, size - legacy_size);
+        }
+        return size;
+    }
+
+    kr = apple_dext_config_read_block(conn, off, data, legacy_size);
+    if (kr != KERN_SUCCESS) {
+        return -EIO;
+    }
+    if (legacy_size < size) {
+        memset((uint8_t *)data + legacy_size, 0, size - legacy_size);
+    }
+    return size;
+}
+
+static bool apple_vfio_config_write_is_safe(off_t off, uint32_t size)
+{
+    off_t end = off + size;
+
+    /*
+     * Block writes that would reprogram the device's bus identity or
+     * address decoders.  macOS / DART owns those registers; touching
+     * them from the guest breaks the IOKit mapping and the device
+     * "falls off the bus."
+     *
+     * Everything else (vendor capabilities, MSI/MSI-X, PCIe cap, etc.)
+     * is forwarded.
+     */
+
+    /* PCI_STATUS stays emulated/blocked */
+    if (off < PCI_STATUS + 2 && end > PCI_STATUS) {
+        return false;
+    }
+
+    /* BAR0-BAR5 */
+    if (off < PCI_BASE_ADDRESS_5 + 4 && end > PCI_BASE_ADDRESS_0) {
+        return false;
+    }
+
+    return true;
+}
+
+static int apple_vfio_forward_command_write(io_connect_t conn, off_t off,
+                                            uint32_t size, const void *data)
+{
+    const uint8_t *bytes = data;
+    off_t end = off + size;
+    off_t cmd_start = MAX(off, (off_t)PCI_COMMAND);
+    off_t cmd_end = MIN(end, (off_t)(PCI_COMMAND + 2));
+    off_t pos;
+
+    if (conn == IO_OBJECT_NULL) {
+        return -ENODEV;
+    }
+
+    for (pos = cmd_start; pos < cmd_end; pos++) {
+        uint64_t value = bytes[pos - off];
+        kern_return_t kr = apple_dext_config_write(conn, pos, 1, value);
+
+        if (kr != KERN_SUCCESS) {
+            return -EIO;
+        }
+    }
+
+    return 0;
+}
+
+static int apple_vfio_bar_write(VFIODevice *vbasedev, uint8_t nr, off_t off,
+                                uint32_t size, void *data)
+{
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(vbasedev->dev);
+    AppleVFIOBarMap *bm = &adev->apple->bar_maps[nr];
+    void *p;
+    uint64_t value = 0;
+
+    if (!bm->addr || off + size > bm->size) {
+        error_report("vfio-apple: BAR%d write out of range or unmapped", nr);
+        return -EINVAL;
+    }
+
+    if (size != 1 && size != 2 && size != 4 && size != 8) {
+        return -EINVAL;
+    }
+
+    p = (char *)bm->addr + off;
+    memcpy(&value, data, size);
+    host_pci_stn_le_p(p, size, value);
+
+    return size;
+}
+
+static int apple_vfio_region_write(VFIODevice *vbasedev, uint8_t nr, off_t off,
+                                   uint32_t size, void *data, bool post)
+{
+    io_connect_t conn = apple_vfio_connection(vbasedev);
+    uint64_t value = 0;
+    kern_return_t kr;
+    uint32_t legacy_size;
+
+    if (nr != VFIO_PCI_CONFIG_REGION_INDEX) {
+        return apple_vfio_bar_write(vbasedev, nr, off, size, data);
+    }
+
+    if (off < PCI_COMMAND + 2 && off + size > PCI_COMMAND) {
+        int ret = apple_vfio_forward_command_write(conn, off, size, data);
+
+        if (ret) {
+            return ret;
+        }
+
+        if (off >= PCI_COMMAND && off + size <= PCI_COMMAND + 2) {
+            return size;
+        }
+    }
+
+    if (!apple_vfio_config_write_is_safe(off, size)) {
+        return size;
+    }
+
+    if (conn == IO_OBJECT_NULL) {
+        return -ENODEV;
+    }
+
+    memcpy(&value, data, size);
+    legacy_size = MIN(size, PCIE_CONFIG_SPACE_SIZE - off);
+    if (!(legacy_size == 1 || legacy_size == 2 || legacy_size == 4)) {
+        return -EINVAL;
+    }
+
+    kr = apple_dext_config_write(conn, off, legacy_size, value);
+    if (kr != KERN_SUCCESS) {
+        return -EIO;
+    }
+    return size;
+}
+
+static int apple_vfio_region_map(VFIODevice *vbasedev, VFIORegion *region);
+static void apple_vfio_region_unmap(VFIODevice *vbasedev, VFIORegion *region);
+
+static int apple_vfio_region_map(VFIODevice *vbasedev, VFIORegion *region)
+{
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(vbasedev->dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(adev);
+    io_connect_t conn = apple_vfio_connection(vbasedev);
+    int bar = region->nr;
+    VFIOBAR *vbar;
+    mach_vm_address_t local_addr = 0;
+    mach_vm_size_t bar_size = 0;
+    uint8_t bar_type = 0;
+    kern_return_t kr;
+    int i;
+
+    if (bar < VFIO_PCI_BAR0_REGION_INDEX || bar >= VFIO_PCI_ROM_REGION_INDEX) {
+        return 0;
+    }
+
+    vbar = &vdev->bars[bar];
+
+    if (conn == IO_OBJECT_NULL || !vbar->size || vbar->ioport) {
+        return 0;
+    }
+
+    if (bar > 0 && vdev->bars[bar - 1].mem64) {
+        return 0;
+    }
+
+    if (adev->apple->bar_maps[bar].addr != NULL) {
+        return 0;
+    }
+
+    kr = apple_dext_map_bar(conn, bar, &local_addr, &bar_size, &bar_type);
+    if (kr != KERN_SUCCESS) {
+        warn_report("vfio-apple: BAR%d map failed for %s: 0x%x",
+                    bar, vbasedev->name, kr);
+        return -EIO;
+    }
+
+    if (bar_size > vbar->size) {
+        bar_size = vbar->size;
+    }
+
+    adev->apple->bar_maps[bar].addr = (void *)local_addr;
+    adev->apple->bar_maps[bar].size = bar_size;
+
+    /*
+     * Use the pre-computed mmap regions — already split around the MSI-X
+     * table/PBA hole by vfio_pci_fixup_msix_region() during realize.
+     * We just need to fill in the host pointers from our dext mapping.
+     */
+    for (i = 0; i < region->nr_mmaps; i++) {
+        region->mmaps[i].mmap = (char *)local_addr + region->mmaps[i].offset;
+        vfio_region_register_mmap(region, i);
+    }
+
+    return 0;
+}
+
+static void apple_vfio_region_unmap(VFIODevice *vbasedev, VFIORegion *region)
+{
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(vbasedev->dev);
+    io_connect_t conn = apple_vfio_connection(vbasedev);
+    int bar = region->nr;
+    AppleVFIOBarMap *bm;
+    int i;
+
+    if (bar < VFIO_PCI_BAR0_REGION_INDEX || bar >= VFIO_PCI_ROM_REGION_INDEX) {
+        return;
+    }
+
+    bm = &adev->apple->bar_maps[bar];
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        if (region->mmaps[i].mmap) {
+            vfio_region_unregister_mmap(region, i);
+            region->mmaps[i].mmap = NULL;
+        }
+    }
+
+    if (conn != IO_OBJECT_NULL && bm->addr != NULL) {
+        apple_dext_unmap_bar(conn, bar, (mach_vm_address_t)bm->addr);
+    }
+
+    bm->addr = NULL;
+    bm->size = 0;
+}
+
+VFIODeviceIOOps apple_vfio_device_io_ops = {
+    .device_feature = apple_vfio_device_feature,
+    .get_region_info = apple_vfio_get_region_info,
+    .get_irq_info = apple_vfio_get_irq_info,
+    .set_irqs = apple_vfio_set_irqs,
+    .device_reset = apple_vfio_device_reset,
+    .region_read = apple_vfio_region_read,
+    .region_write = apple_vfio_region_write,
+    .region_map = apple_vfio_region_map,
+    .region_unmap = apple_vfio_region_unmap,
+};
+
+bool apple_vfio_dext_publish(uint8_t bus, uint8_t device, uint8_t function,
+                             io_connect_t conn)
+{
+    AppleVFIOSharedDext *shared;
+    guint key = apple_vfio_dext_key(bus, device, function);
+
+    if (!apple_vfio_shared_dexts) {
+        apple_vfio_shared_dexts =
+            g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL, g_free);
+    }
+
+    if (g_hash_table_lookup(apple_vfio_shared_dexts, GUINT_TO_POINTER(key))) {
+        return false;
+    }
+
+    shared = g_new0(AppleVFIOSharedDext, 1);
+    shared->conn = conn;
+    shared->refs = 1;
+    g_hash_table_insert(apple_vfio_shared_dexts, GUINT_TO_POINTER(key), shared);
+    return true;
+}
+
+io_connect_t apple_vfio_dext_lookup(uint8_t bus, uint8_t device,
+                                    uint8_t function)
+{
+    AppleVFIOSharedDext *shared;
+    guint key = apple_vfio_dext_key(bus, device, function);
+
+    if (!apple_vfio_shared_dexts) {
+        return IO_OBJECT_NULL;
+    }
+
+    shared = g_hash_table_lookup(apple_vfio_shared_dexts,
+                                 GUINT_TO_POINTER(key));
+    if (!shared) {
+        return IO_OBJECT_NULL;
+    }
+
+    shared->refs++;
+    return shared->conn;
+}
+
+void apple_vfio_dext_release(uint8_t bus, uint8_t device, uint8_t function,
+                             io_connect_t conn)
+{
+    AppleVFIOSharedDext *shared;
+    guint key = apple_vfio_dext_key(bus, device, function);
+
+    if (!apple_vfio_shared_dexts) {
+        return;
+    }
+
+    shared = g_hash_table_lookup(apple_vfio_shared_dexts,
+                                 GUINT_TO_POINTER(key));
+    if (!shared || shared->conn != conn) {
+        return;
+    }
+
+    if (--shared->refs == 0) {
+        apple_dext_disconnect(conn);
+        g_hash_table_remove(apple_vfio_shared_dexts, GUINT_TO_POINTER(key));
+    }
+}
+
+/* ------------------------------------------------------------------ */
+/* QOM type: vfio-apple-pci                                           */
+/* ------------------------------------------------------------------ */
+
+static void (*parent_realize)(PCIDevice *, Error **);
+static void (*parent_exit)(PCIDevice *);
+
+static void apple_vfio_pci_instance_init(Object *obj)
+{
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(obj);
+
+    apple_vfio_pci_init(adev);
+}
+
+static void apple_vfio_pci_realize_fn(PCIDevice *pdev, Error **errp)
+{
+    ERRP_GUARD();
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(pdev);
+
+    if (!apple_vfio_pci_pre_realize(adev, errp)) {
+        return;
+    }
+
+    parent_realize(pdev, errp);
+    if (*errp) {
+        g_clear_pointer(&adev->apple, g_free);
+        return;
+    }
+
+    if (!apple_vfio_create_dma_companion(adev, errp)) {
+        if (parent_exit) {
+            parent_exit(pdev);
+        }
+        g_clear_pointer(&adev->apple, g_free);
+        return;
+    }
+}
+
+static void apple_vfio_pci_exit_fn(PCIDevice *pdev)
+{
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(pdev);
+
+    apple_vfio_destroy_dma_companion(adev);
+
+    if (parent_exit) {
+        parent_exit(pdev);
+    }
+}
+
+static void apple_vfio_pci_finalize_fn(Object *obj)
+{
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(obj);
+
+    apple_vfio_device_cleanup(adev);
+    g_clear_pointer(&adev->apple, g_free);
+}
+
+static void apple_vfio_pci_class_init(ObjectClass *klass, const void *data)
+{
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    parent_realize = pdc->realize;
+    parent_exit = pdc->exit;
+
+    pdc->realize = apple_vfio_pci_realize_fn;
+    pdc->exit = apple_vfio_pci_exit_fn;
+    dc->user_creatable = true;
+    dc->desc = "VFIO-based PCI device assignment (Apple/macOS)";
+}
+
+static const TypeInfo vfio_apple_pci_info = {
+    .name = TYPE_VFIO_APPLE_PCI,
+    .parent = TYPE_VFIO_PCI,
+    .instance_size = sizeof(VFIOApplePCIDevice),
+    .instance_init = apple_vfio_pci_instance_init,
+    .instance_finalize = apple_vfio_pci_finalize_fn,
+    .class_init = apple_vfio_pci_class_init,
+};
+
+static void register_vfio_apple_pci_type(void)
+{
+    type_register_static(&vfio_apple_pci_info);
+}
+
+type_init(register_vfio_apple_pci_type)
diff --git a/hw/vfio/apple.h b/hw/vfio/apple.h
new file mode 100644
index 0000000000..81d4bd2b66
--- /dev/null
+++ b/hw/vfio/apple.h
@@ -0,0 +1,74 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Apple/macOS VFIO passthrough common definitions.
+ *
+ * Copyright (c) 2026 Scott J. Goldman
+ */
+
+#ifndef HW_VFIO_APPLE_H
+#define HW_VFIO_APPLE_H
+
+#include <stdint.h>
+
+#include "hw/vfio/pci.h"
+#include "hw/vfio/vfio-container.h"
+#include "qapi/error.h"
+#include "qemu/event_notifier.h"
+
+#ifdef CONFIG_DARWIN
+#include <IOKit/IOKitLib.h>
+#else
+typedef uintptr_t io_connect_t;
+#define IO_OBJECT_NULL ((io_connect_t)0)
+#endif
+
+OBJECT_DECLARE_SIMPLE_TYPE(AppleVFIOContainer, VFIO_IOMMU_APPLE)
+
+struct AppleVFIOContainer {
+    VFIOContainer parent_obj;
+    io_connect_t dext_conn;
+    uint8_t host_bus;
+    uint8_t host_device;
+    uint8_t host_function;
+};
+
+typedef struct AppleDextInterruptNotify AppleDextInterruptNotify;
+
+typedef struct AppleVFIOBarMap {
+    void *addr;
+    size_t size;
+} AppleVFIOBarMap;
+
+typedef struct AppleVFIOState {
+    AppleDextInterruptNotify *irq_notify;
+    EventNotifier irq_notifier;
+    uint32_t num_irq_vectors;
+    AppleVFIOBarMap bar_maps[PCI_ROM_SLOT];
+} AppleVFIOState;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOApplePCIDevice, VFIO_APPLE_PCI)
+
+struct VFIOApplePCIDevice {
+    VFIOPCIDevice parent_obj;
+    AppleVFIOState *apple;
+    DeviceState *dma_companion;
+    bool dma_companion_autocreated;
+};
+
+extern VFIODeviceIOOps apple_vfio_device_io_ops;
+
+bool apple_vfio_device_setup(VFIOApplePCIDevice *adev, Error **errp);
+void apple_vfio_device_cleanup(VFIOApplePCIDevice *adev);
+bool apple_vfio_get_bar_info(VFIOApplePCIDevice *adev, uint8_t bar,
+                             uint8_t *mem_idx, uint64_t *size,
+                             uint8_t *type);
+
+bool apple_vfio_dext_publish(uint8_t bus, uint8_t device, uint8_t function,
+                             io_connect_t conn);
+io_connect_t apple_vfio_dext_lookup(uint8_t bus, uint8_t device,
+                                    uint8_t function);
+void apple_vfio_dext_release(uint8_t bus, uint8_t device, uint8_t function,
+                             io_connect_t conn);
+
+#endif /* HW_VFIO_APPLE_H */
diff --git a/hw/vfio/container-apple.c b/hw/vfio/container-apple.c
new file mode 100644
index 0000000000..5a5c55b622
--- /dev/null
+++ b/hw/vfio/container-apple.c
@@ -0,0 +1,241 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Apple/macOS VFIO IOMMU container backend.
+ *
+ * Copyright (c) 2026 Scott J. Goldman
+ */
+
+#include "qemu/osdep.h"
+
+#include <linux/vfio.h>
+
+#include "apple-dext-client.h"
+#include "hw/vfio/apple.h"
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio/vfio-listener.h"
+#include "qapi/error.h"
+#include "system/ramblock.h"
+
+static bool apple_vfio_setup(VFIOContainer *bcontainer, Error **errp)
+{
+    bcontainer->pgsizes = qemu_real_host_page_size();
+    bcontainer->dma_max_mappings = UINT_MAX;
+    bcontainer->dirty_pages_supported = false;
+    bcontainer->max_dirty_bitmap_size = 0;
+    bcontainer->dirty_pgsizes = 0;
+    return true;
+}
+
+/*
+ * DMA map/unmap are no-ops: Apple passthrough handles DMA mapping through
+ * the companion apple-dma-pci device which talks to the dext directly,
+ * bypassing the IOMMU container's DMA path.  The stubs are required because
+ * the VFIO listener asserts they are non-NULL.
+ */
+static int apple_vfio_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
+                              uint64_t size, void *vaddr, bool readonly,
+                              MemoryRegion *mr)
+{
+    return 0;
+}
+
+static int apple_vfio_dma_unmap(const VFIOContainer *bcontainer, hwaddr iova,
+                                uint64_t size, IOMMUTLBEntry *iotlb,
+                                bool unmap_all)
+{
+    return 0;
+}
+
+static int apple_vfio_set_dirty_page_tracking(const VFIOContainer *bcontainer,
+                                              bool start, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "vfio-apple does not support migration");
+    return -ENOTSUP;
+}
+
+static int apple_vfio_query_dirty_bitmap(const VFIOContainer *bcontainer,
+                                         VFIOBitmap *vbmap, hwaddr iova,
+                                         hwaddr size, uint64_t backend_flag,
+                                         Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "vfio-apple does not support migration");
+    return -ENOTSUP;
+}
+
+static int apple_vfio_pci_hot_reset(VFIODevice *vbasedev, bool single)
+{
+    return 0;
+}
+
+static AppleVFIOContainer *apple_vfio_container_connect(AddressSpace *as,
+                                                        VFIODevice *vbasedev,
+                                                        Error **errp)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(vbasedev->dev);
+    AppleVFIOContainer *container;
+    VFIOContainer *bcontainer;
+    VFIOAddressSpace *space;
+    VFIOIOMMUClass *vioc;
+    int ret;
+
+    space = vfio_address_space_get(as);
+    container = VFIO_IOMMU_APPLE(object_new(TYPE_VFIO_IOMMU_APPLE));
+    bcontainer = VFIO_IOMMU(container);
+    vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    container->host_bus = vdev->host.bus;
+    container->host_device = vdev->host.slot;
+    container->host_function = vdev->host.function;
+
+    ret = ram_block_uncoordinated_discard_disable(true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        goto fail_unref;
+    }
+
+    container->dext_conn = apple_dext_connect(container->host_bus,
+                                                  container->host_device,
+                                                  container->host_function);
+    if (container->dext_conn == IO_OBJECT_NULL) {
+        error_setg(errp,
+                   "vfio-apple: could not connect to dext for host PCI "
+                   "%02x:%02x.%x",
+                   container->host_bus, container->host_device,
+                   container->host_function);
+        goto fail_discards;
+    }
+
+    if (apple_dext_claim(container->dext_conn) != KERN_SUCCESS) {
+        error_setg(errp,
+                   "vfio-apple: failed to claim dext-backed PCI device "
+                   "%02x:%02x.%x",
+                   container->host_bus, container->host_device,
+                   container->host_function);
+        goto fail_release_conn;
+    }
+
+    if (!apple_vfio_dext_publish(container->host_bus, container->host_device,
+                                 container->host_function,
+                                 container->dext_conn)) {
+        error_setg(errp,
+                   "vfio-apple: duplicate dext owner for host PCI %02x:%02x.%x",
+                   container->host_bus, container->host_device,
+                   container->host_function);
+        goto fail_release_conn;
+    }
+
+    if (!vioc->setup(bcontainer, errp)) {
+        goto fail_shared_conn;
+    }
+
+    vfio_address_space_insert(space, bcontainer);
+
+    if (!vfio_listener_register(bcontainer, errp)) {
+        goto fail_address_space;
+    }
+
+    bcontainer->initialized = true;
+    return container;
+
+fail_address_space:
+    vfio_listener_unregister(bcontainer);
+    QLIST_REMOVE(bcontainer, next);
+    bcontainer->space = NULL;
+fail_shared_conn:
+    apple_vfio_dext_release(container->host_bus, container->host_device,
+                            container->host_function, container->dext_conn);
+    container->dext_conn = IO_OBJECT_NULL;
+fail_discards:
+    ram_block_uncoordinated_discard_disable(false);
+fail_unref:
+    object_unref(container);
+    vfio_address_space_put(space);
+    return NULL;
+
+fail_release_conn:
+    apple_dext_disconnect(container->dext_conn);
+    container->dext_conn = IO_OBJECT_NULL;
+    goto fail_discards;
+}
+
+static void apple_vfio_container_disconnect(AppleVFIOContainer *container)
+{
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
+    VFIOAddressSpace *space = bcontainer->space;
+
+    ram_block_uncoordinated_discard_disable(false);
+    vfio_listener_unregister(bcontainer);
+
+    apple_vfio_dext_release(container->host_bus, container->host_device,
+                            container->host_function, container->dext_conn);
+    container->dext_conn = IO_OBJECT_NULL;
+
+    object_unref(container);
+    vfio_address_space_put(space);
+}
+
+static bool apple_vfio_attach_device(const char *name, VFIODevice *vbasedev,
+                                     AddressSpace *as, Error **errp)
+{
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(vbasedev->dev);
+    AppleVFIOContainer *container;
+    struct vfio_device_info info = {
+        .argsz = sizeof(info),
+        .flags = VFIO_DEVICE_FLAGS_PCI | VFIO_DEVICE_FLAGS_RESET,
+        .num_regions = VFIO_PCI_NUM_REGIONS,
+        .num_irqs = VFIO_PCI_NUM_IRQS,
+    };
+
+    container = apple_vfio_container_connect(as, vbasedev, errp);
+    if (!container) {
+        return false;
+    }
+
+    vbasedev->fd = -1;
+    vbasedev->io_ops = &apple_vfio_device_io_ops;
+    vfio_device_prepare(vbasedev, VFIO_IOMMU(container), &info);
+
+    if (!apple_vfio_device_setup(adev, errp)) {
+        vfio_device_unprepare(vbasedev);
+        apple_vfio_container_disconnect(container);
+        return false;
+    }
+
+    return true;
+}
+
+static void apple_vfio_detach_device(VFIODevice *vbasedev)
+{
+    VFIOApplePCIDevice *adev = VFIO_APPLE_PCI(vbasedev->dev);
+    AppleVFIOContainer *container = VFIO_IOMMU_APPLE(vbasedev->bcontainer);
+
+    apple_vfio_device_cleanup(adev);
+    vfio_device_unprepare(vbasedev);
+    apple_vfio_container_disconnect(container);
+}
+
+static void vfio_iommu_apple_class_init(ObjectClass *klass, const void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->setup = apple_vfio_setup;
+    vioc->dma_map = apple_vfio_dma_map;
+    vioc->dma_unmap = apple_vfio_dma_unmap;
+    vioc->attach_device = apple_vfio_attach_device;
+    vioc->detach_device = apple_vfio_detach_device;
+    vioc->set_dirty_page_tracking = apple_vfio_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = apple_vfio_query_dirty_bitmap;
+    vioc->pci_hot_reset = apple_vfio_pci_hot_reset;
+}
+
+static const TypeInfo apple_vfio_types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_APPLE,
+        .parent = TYPE_VFIO_IOMMU,
+        .instance_size = sizeof(AppleVFIOContainer),
+        .class_init = vfio_iommu_apple_class_init,
+    },
+};
+
+DEFINE_TYPES(apple_vfio_types)
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 965c8e5b80..473f8669f9 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -40,6 +40,8 @@ system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
 # Apple VFIO backend
 if host_os == 'darwin'
   system_ss.add(when: 'CONFIG_VFIO',
-                if_true: [files('apple-dext-client.c'),
-                coref, iokit])
+                if_true: [files('apple-device.c',
+                                'container-apple.c',
+                                'apple-dext-client.c'),
+                          coref, iokit])
 endif
-- 
2.50.1 (Apple Git-155)


