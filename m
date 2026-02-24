Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE29F3C9A9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuunA-0006Vl-EV; Tue, 24 Feb 2026 10:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vuun6-0006VC-0y
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:57:40 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vuun1-0000oy-QG
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:57:39 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-56637565faaso4622573e0c.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771948654; x=1772553454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzGE6CUWLA5ueYduHjeibn6N465oB1K2VLZVfOZlWao=;
 b=lRNLWo5R3iMFhC5A3+Jeyn4Xn0jMC3fYmrPiO/FVDGv7PKDeMI38yTn5LM3sHKjXv9
 LCEAT9VyfC4gArdkPhsA56c0zZjoa+SGGvoC4tBOR/FZrAskvnZLVxVYLoDFT9HFh+MI
 gG22PPIp1ERLy/6EobW0BHzmQxrZ33VRMXuAYJ8agNCaZU0DDWXvouwXA3+uyS0xiTAa
 tFTW8Lgd+FshYu+EL+rz/evTRHvnInmiNlv+AvtKMZsVvCrgjGDENkOzlWcDVS71d2R4
 pxHuhfF7pnB1AJqHSNUjLAeVF5Ra0Zs7q6Nu7mjYoBL66XmO1q8FAGRJdy+MCxk5x3te
 LzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948654; x=1772553454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZzGE6CUWLA5ueYduHjeibn6N465oB1K2VLZVfOZlWao=;
 b=HUU0al7fudRCjqp2aIcnZDwToW20rnsOcHTxUsctoVLDR0nijk6COK0W6vzQ1PAw18
 B6GtZ7FDmm8gwtc/BS6U4xmpczuAusO3B4DiJ0MY9srdnhSy+Iin6IuROE9usM9MfChN
 o0pCMPwoeFPNGUURNDrw2v6g0Qkdbwch2yc/uuB1wqsqXVYRD+a/Qnh5sxPZ/2SE4MY+
 OYORG03AmAEjOt3OUyfcPSc/AUMG7Lc1crHZjyHkn5NkpK/Sae6tBDbRTbMe6p/8iGxj
 khbm1ANblZouxUiyscM0Fty3jIVHzFZP0JyTxNlFeX71v8nIcTxDzxEoYh9v5ZOzqYvY
 y/Gw==
X-Gm-Message-State: AOJu0Yz44YI4E96BUBGc6h1rWN31/HO8jNIGgWSoN9QedWVIBdGyU4GK
 hihMuvSDvNbNJc5P0L0PtUQP99naT46BxlV5FqjI0iuB70dk1Y3lqFSlAcRH08Ux
X-Gm-Gg: ATEYQzwWOTpC4s2PPZ+9Mm7KGDsNw3eGty/HROGdwTJYQXVTYns5WEbhqHiA6YOBmcX
 0E3eTPa0rA+wcaw4dnLdwgqphNOfskikJzp8UI1fRwMxjovf6wdKJah7gYLPXMohL2TVkjV08Wk
 I6epGb+3prZG9/HH5S762nPrOnTnlXVYasWgC7xbux6M2HBwSUDFO/ja1hrHOadk56O7ROvfu/x
 j2MhIn627tewFZ1AeKVUdGNTJpFsPcDJCrl4EjUQo0yLQm69+1t2kdMUCmixNCwVI1syFGCvPnS
 LG3m8wd6Mf5/20Xmceeep0YNuf5+D+Hu3VG+HuH5IVneAKeR6ZNM7XXeJNH+DO3YiGagyD0XfSN
 TfJUyMRtLlGiQwlF6cJkwODQR2XbYVldRjWVdkyWwTAkR59JLfvhmlOKiSiBoX0wgS2FH4S4ink
 qkcR4PyaBLsCuzYPj6ufV7UFmGwS4gUfWcU8kn8KbDGOcPmMawyib0iEr1rQ==
X-Received: by 2002:a05:6122:4701:b0:566:4689:46eb with SMTP id
 71dfb90a1353d-568e455a597mr4636687e0c.0.1771948654106; 
 Tue, 24 Feb 2026 07:57:34 -0800 (PST)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-568e57a0009sm12904238e0c.3.2026.02.24.07.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:57:33 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: alex.bennee@linaro.org,
	bill.mills@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v2 3/4] hw/misc: Add generic virtio-msg AMP PCI device
Date: Tue, 24 Feb 2026 16:57:20 +0100
Message-ID: <20260224155721.612314-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224155721.612314-1-edgar.iglesias@gmail.com>
References: <20260224155721.612314-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/misc/Kconfig                |   7 +
 hw/misc/meson.build            |   1 +
 hw/misc/virtio-msg-amp-pci.c   | 361 +++++++++++++++++++++++++++++++++
 include/hw/virtio/spsc_queue.h | 213 +++++++++++++++++++
 4 files changed, 582 insertions(+)
 create mode 100644 hw/misc/virtio-msg-amp-pci.c
 create mode 100644 include/hw/virtio/spsc_queue.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index f4d49248c0..a8dea757ed 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -30,6 +30,13 @@ config IOMMU_TESTDEV
     default y if TEST_DEVICES
     depends on PCI
 
+config VIRTIO_MSG_AMP_PCI
+    bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select VIRTIO
+    select VIRTIO_MSG
+
 config EDU
     bool
     default y if TEST_DEVICES
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d304a98498..cfca758fdb 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -9,6 +9,7 @@ system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
 system_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_COMMON', if_true: files('pvpanic.c'))
+system_ss.add(when: 'CONFIG_VIRTIO_MSG_AMP_PCI', if_true: files('virtio-msg-amp-pci.c'))
 
 # ARM devices
 system_ss.add(when: 'CONFIG_PL310', if_true: files('arm_l2x0.c'))
diff --git a/hw/misc/virtio-msg-amp-pci.c b/hw/misc/virtio-msg-amp-pci.c
new file mode 100644
index 0000000000..192e4cf146
--- /dev/null
+++ b/hw/misc/virtio-msg-amp-pci.c
@@ -0,0 +1,361 @@
+/*
+ * Model of a virtio-msg AMP capable PCI device.
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/log.h"
+
+#include "system/memory.h"
+#include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/register.h"
+#include "hw/pci/pci_device.h"
+#include "hw/pci/msix.h"
+
+#include "hw/virtio/virtio-msg.h"
+#include "hw/virtio/virtio-msg-bus.h"
+#include "hw/virtio/spsc_queue.h"
+
+#define TYPE_VMSG_AMP_PCI "virtio-msg-amp-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VmsgAmpPciState, VMSG_AMP_PCI)
+
+#define TYPE_VMSG_BUS_AMP_PCI "virtio-msg-bus-amp-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VmsgBusAmpPciState, VMSG_BUS_AMP_PCI)
+#define VMSG_BUS_AMP_PCI_GET_PARENT_CLASS(obj) \
+        OBJECT_GET_PARENT_CLASS(obj, TYPE_VMSG_BUS_AMP_PCI)
+
+REG32(VERSION,  0x00)
+REG32(FEATURES, 0x04)
+REG32(NOTIFY,   0x20)
+
+#define MAX_FIFOS 8
+
+typedef struct VmsgBusAmpPciState {
+    VirtIOMSGBusDevice parent;
+    PCIDevice *pcidev;
+    unsigned int queue_index;
+
+    struct {
+        void *va;
+        spsc_queue driver;
+        spsc_queue device;
+        unsigned int mapcount;
+    } shm;
+} VmsgBusAmpPciState;
+
+typedef struct VmsgAmpPciState {
+    PCIDevice dev;
+    MemoryRegion mr_mmio;
+    MemoryRegion mr_ram;
+
+    struct fifo_bus {
+        VmsgBusAmpPciState dev;
+        VirtIOMSGProxy proxy;
+        BusState bus;
+    } fifo[MAX_FIFOS];
+
+    struct {
+        uint32_t num_fifos;
+    } cfg;
+} VmsgAmpPciState;
+
+static void vmsg_bus_amp_pci_process(VirtIOMSGBusDevice *bd);
+
+static uint64_t vmsg_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    uint64_t r = 0;
+
+    assert(size == 4);
+
+    switch (addr) {
+    case A_VERSION:
+        /* v0.1 */
+        r = 0x0001;
+        break;
+    case A_FEATURES:
+        /* No features bit yet.  */
+        break;
+    default:
+        break;
+    }
+
+    return r;
+}
+
+static void vmsg_write(void *opaque, hwaddr addr, uint64_t val,
+                       unsigned int size)
+{
+    VmsgAmpPciState *s = VMSG_AMP_PCI(opaque);
+    unsigned int q;
+
+    assert(size == 4);
+
+    if (addr >= A_NOTIFY) {
+        q = (addr - A_NOTIFY) / 4;
+        if (q >= s->cfg.num_fifos) {
+            /* Fifo doesn't exist.  */
+            return;
+        }
+
+        vmsg_bus_amp_pci_process(VIRTIO_MSG_BUS_DEVICE(&s->fifo[q].dev));
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only reg 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+    }
+}
+
+static const MemoryRegionOps vmsg_pci_ops = {
+    .read = vmsg_read,
+    .write = vmsg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void vmsg_create_bus(VmsgAmpPciState *s, unsigned int i)
+{
+    DeviceState *dev = DEVICE(s);
+    Object *o = OBJECT(s);
+    struct fifo_bus *fifo = &s->fifo[i];
+    g_autofree char *fifo_name = g_strdup_printf("fifo%d", i);
+
+    qbus_init(&fifo->bus, sizeof(fifo->bus), TYPE_VIRTIO_MSG_OUTER_BUS,
+              dev, fifo_name);
+
+    /* Create the proxy.  */
+    object_initialize_child(o, "proxy[*]", &fifo->proxy, TYPE_VIRTIO_MSG);
+    qdev_realize(DEVICE(&fifo->proxy), BUS(&fifo->bus), &error_fatal);
+
+    object_initialize_child(o, "vmsg[*]", &fifo->dev,
+                            TYPE_VMSG_BUS_AMP_PCI);
+    qdev_realize(DEVICE(&fifo->dev), &fifo->proxy.msg_bus, &error_fatal);
+
+    msix_vector_use(PCI_DEVICE(s), i);
+
+    /* Caches for quick lookup. */
+    fifo->dev.queue_index = i;
+    fifo->dev.pcidev = PCI_DEVICE(s);
+}
+
+static void vmsg_amp_pci_realizefn(PCIDevice *dev, Error **errp)
+{
+    VmsgAmpPciState *s = VMSG_AMP_PCI(dev);
+    int i;
+
+    if (!s->cfg.num_fifos || s->cfg.num_fifos > MAX_FIFOS) {
+        error_setg(errp, "Unsupported number of FIFOs (%u)", s->cfg.num_fifos);
+        return;
+    }
+
+    memory_region_init_io(&s->mr_mmio, OBJECT(s), &vmsg_pci_ops, s,
+                          TYPE_VMSG_AMP_PCI, 16 * KiB);
+
+    /* 16KB per FIFO.  */
+    memory_region_init_ram(&s->mr_ram, OBJECT(s), "ram",
+                           s->cfg.num_fifos * 16 * KiB, &error_fatal);
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mr_mmio);
+    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                             PCI_BASE_ADDRESS_MEM_PREFETCH,
+                             &s->mr_ram);
+
+    msix_init_exclusive_bar(PCI_DEVICE(s), s->cfg.num_fifos, 2, &error_fatal);
+    for (i = 0; i < s->cfg.num_fifos; i++) {
+        vmsg_create_bus(s, i);
+    }
+}
+
+static void vmsg_amp_pci_exit(PCIDevice *dev)
+{
+    VmsgAmpPciState *s = VMSG_AMP_PCI(dev);
+
+    vmstate_unregister_ram(&s->mr_ram, DEVICE(dev));
+    msix_uninit_exclusive_bar(dev);
+}
+
+static int vmsg_amp_pci_post_load(void *opaque, int version_id)
+{
+    VmsgAmpPciState *s = VMSG_AMP_PCI(opaque);
+    int i;
+
+    for (i = 0; i < s->cfg.num_fifos; i++) {
+        VmsgBusAmpPciState *bus = &s->fifo[i].dev;
+
+        memset(&bus->shm, 0, sizeof(bus->shm));
+    }
+
+    return 0;
+}
+
+static const Property vmsg_properties[] = {
+    DEFINE_PROP_UINT32("num-fifos", VmsgAmpPciState, cfg.num_fifos, 1),
+};
+
+static const VMStateDescription vmstate_vmsg_pci = {
+    .name = TYPE_VMSG_AMP_PCI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = vmsg_amp_pci_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, VmsgAmpPciState),
+        VMSTATE_MSIX(dev, VmsgAmpPciState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void vmsg_amp_pci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vmsg_properties);
+
+    pc->realize = vmsg_amp_pci_realizefn;
+    pc->exit = vmsg_amp_pci_exit;
+    pc->vendor_id = PCI_VENDOR_ID_XILINX;
+    pc->device_id = 0x9039;
+    pc->revision = 1;
+    pc->class_id = PCI_CLASS_SYSTEM_OTHER;
+    dc->vmsd = &vmstate_vmsg_pci;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static bool vmsg_bus_amp_pci_map_fifo(VmsgBusAmpPciState *s)
+{
+    VmsgAmpPciState *pci_s = VMSG_AMP_PCI(s->pcidev);
+    void *va;
+    size_t fifo_offset;
+
+    if (s->shm.mapcount) {
+        s->shm.mapcount++;
+        return true;
+    }
+
+    va = memory_region_get_ram_ptr(&pci_s->mr_ram);
+    if (!va) {
+        return false;
+    }
+
+    fifo_offset = s->queue_index * 16 * KiB;
+    va = (uint8_t *)va + fifo_offset;
+
+    if (!s->shm.driver.shm) {
+        int capacity = spsc_capacity(4 * KiB);
+
+        /*
+         * Layout:
+         * 0     - 4KB    Reserved
+         * 4KB   - 8KB    Driver queue
+         * 8KB   - 12KB   Device queue
+         */
+        spsc_init(&s->shm.driver, "driver", capacity, va + 4 * KiB);
+        spsc_init(&s->shm.device, "device", capacity, va + 8 * KiB);
+    }
+
+    /* Map queues.  */
+    s->shm.va = va;
+    s->shm.mapcount++;
+    return true;
+}
+
+static void vmsg_bus_amp_pci_unmap_fifo(VmsgBusAmpPciState *s)
+{
+    assert(s->shm.mapcount);
+    if (--s->shm.mapcount) {
+        return;
+    }
+
+    /* TODO: Actually unmap. */
+}
+
+static void vmsg_bus_amp_pci_process(VirtIOMSGBusDevice *bd)
+{
+    VmsgBusAmpPciState *s = VMSG_BUS_AMP_PCI(bd);
+    spsc_queue *q;
+    VirtIOMSG msg;
+    bool r;
+
+    if (!vmsg_bus_amp_pci_map_fifo(s)) {
+        return;
+    }
+
+    /*
+     * We process the opposite queue, i.e, a driver will want to receive
+     * messages on the backend queue (and send messages on the driver queue).
+     */
+    q = bd->peer->is_driver ? &s->shm.device : &s->shm.driver;
+    do {
+        r = spsc_recv(q, &msg, sizeof msg);
+        if (r) {
+            virtio_msg_bus_receive(bd, &msg);
+        }
+    } while (r);
+    vmsg_bus_amp_pci_unmap_fifo(s);
+}
+
+static int vmsg_bus_amp_pci_send(VirtIOMSGBusDevice *bd, VirtIOMSG *msg_req)
+{
+    VmsgAmpPciState *pci_s = VMSG_AMP_PCI(OBJECT(bd)->parent);
+    VmsgBusAmpPciState *s = VMSG_BUS_AMP_PCI(bd);
+    bool sent;
+
+    if (!vmsg_bus_amp_pci_map_fifo(s)) {
+        return VIRTIO_MSG_ERROR_MEMORY;
+    }
+
+    sent = spsc_send(&s->shm.device, msg_req, sizeof *msg_req);
+    if (!sent) {
+        vmsg_bus_amp_pci_unmap_fifo(s);
+        return VIRTIO_MSG_ERROR_RETRY;
+    }
+
+    /* Notify.  */
+    msix_notify(PCI_DEVICE(pci_s), s->queue_index);
+
+    vmsg_bus_amp_pci_unmap_fifo(s);
+    return VIRTIO_MSG_NO_ERROR;
+}
+
+static void vmsg_bus_amp_pci_class_init(ObjectClass *klass,
+                                              const void *data)
+{
+    VirtIOMSGBusDeviceClass *bdc = VIRTIO_MSG_BUS_DEVICE_CLASS(klass);
+
+    bdc->process = vmsg_bus_amp_pci_process;
+    bdc->send = vmsg_bus_amp_pci_send;
+}
+
+static const TypeInfo vmsg_pci_info[] = {
+    {
+        .name = TYPE_VMSG_AMP_PCI,
+        .parent = TYPE_PCI_DEVICE,
+        .instance_size = sizeof(VmsgAmpPciState),
+        .class_init = vmsg_amp_pci_class_init,
+        .interfaces = (const InterfaceInfo[]) {
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { }
+        },
+    }, {
+        .name = TYPE_VMSG_BUS_AMP_PCI,
+        .parent = TYPE_VIRTIO_MSG_BUS_DEVICE,
+        .instance_size = sizeof(VmsgBusAmpPciState),
+        .class_init = vmsg_bus_amp_pci_class_init,
+    },
+};
+
+static void vmsg_pci_register_types(void)
+{
+    type_register_static_array(vmsg_pci_info, ARRAY_SIZE(vmsg_pci_info));
+}
+
+type_init(vmsg_pci_register_types);
diff --git a/include/hw/virtio/spsc_queue.h b/include/hw/virtio/spsc_queue.h
new file mode 100644
index 0000000000..3d88baab55
--- /dev/null
+++ b/include/hw/virtio/spsc_queue.h
@@ -0,0 +1,213 @@
+/*
+ * Hardened and lockless Single Producer Single Consumer Queue implemented
+ * over shared-memory.
+ *
+ * The queue implementation does not look at packet contents, it's up to upper
+ * layers to make sure data is produced and parsed safely. All data is copied
+ * in/out from/to local private buffers so the peer cannot mess with them while
+ * upper layers parse.
+ *
+ * The queue is split into a private and a shared part.
+ * The private part contains cached and sanitized versions of the indexes that
+ * indicate our position in the ring-buffer. Peers can corrupt the shared area
+ * but have no access to the private area. So whenever we copy from the shared
+ * area into the private one, we need to sanitize indexes and make sure they
+ * are within bounds.
+ *
+ * A malicious peer can send corrupt data, it can stop receiving or flood the
+ * queue causing a sort of denial of service but it can NOT cause our side
+ * to copy data in or out of buffers outside of the shared memory area.
+ *
+ * This implementation expects the SHM area to be cache-coherent or uncached.
+ * The shared area can be mapped in different ways and our peer may be anything
+ * from another thread on our same OS to an FPGA implementation on a PCI card.
+ * So local CPU cache-lines sizes, or spin-locks and things that work on a
+ * single CPU cluster are not used. Instead the implementation sticks to atomic
+ * load/stores of 32b values and to using memory-barriers to guarantee ordering.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef SPSC_QUEUE_H__
+#define SPSC_QUEUE_H__
+
+#include <assert.h>
+#include "qemu/atomic.h"
+
+#define BUG_ON(x) assert(!(x))
+
+#define SPSC_QUEUE_MAX_PACKET_SIZE 64
+/*
+ * This cache-line size is used to align fields in the hope of
+ * avoiding cache-line ping-pong:ing. Since the queue layout is
+ * used across heterogenous CPU clusters and across FPGA/HW implementations,
+ * a fixed size must be used, i.e not the local CPU's cache-line size.
+ */
+#define SPSC_QUEUE_CACHE_LINE_SIZE 64
+
+typedef struct spsc_queue_shared {
+    uint32_t head __attribute__((__aligned__(SPSC_QUEUE_CACHE_LINE_SIZE)));
+    uint32_t tail __attribute__((__aligned__(SPSC_QUEUE_CACHE_LINE_SIZE)));
+    uint32_t packets[][SPSC_QUEUE_MAX_PACKET_SIZE / 4]
+        __attribute__((__aligned__(SPSC_QUEUE_CACHE_LINE_SIZE)));
+} spsc_queue_shared;
+
+typedef struct spsc_queue {
+    uint32_t cached_tail;
+    uint32_t cached_head;
+    spsc_queue_shared *shm;
+    const char *name;
+    unsigned int capacity;
+} spsc_queue;
+
+/* Atomically load and sanitize an index from the SHM area.  */
+static inline uint32_t spsc_atomic_load(spsc_queue *q, uint32_t *ptr)
+{
+    uint32_t val;
+
+    val = qatomic_read(ptr);
+    /* Make sure packet reads are done after reading the index.  */
+    smp_mb_acquire();
+
+    /* Bounds check that index is within queue size.  */
+    if (val >= q->capacity) {
+        val = val % q->capacity;
+    }
+
+    return val;
+}
+
+static inline void spsc_atomic_store(spsc_queue *q, uint32_t *ptr, uint32_t v)
+{
+    /* Make sure packet-data gets written before updating the index.  */
+    smp_mb_release();
+    qatomic_set(ptr, v);
+}
+
+/* Returns the capacity of a queue given a specific mapsize. */
+static inline unsigned int spsc_capacity(size_t mapsize)
+{
+    unsigned int capacity;
+    spsc_queue *q = NULL;
+
+    if (mapsize < sizeof(*q->shm)) {
+        return 0;
+    }
+
+    /* Start with the size of the shared area. */
+    mapsize -= sizeof(*q->shm);
+    capacity = mapsize / sizeof(q->shm->packets[0]);
+
+    if (capacity < 2) {
+        /* Capacities of less than 2 are invalid. */
+        return 0;
+    }
+
+    return capacity;
+}
+
+static inline size_t spsc_mapsize(unsigned int capacity)
+{
+    spsc_queue *q = NULL;
+    size_t mapsize;
+
+    BUG_ON(capacity < 2);
+
+    mapsize = sizeof(*q->shm);
+    mapsize += sizeof(q->shm->packets[0]) * capacity;
+
+    return mapsize;
+}
+
+static inline void spsc_init(spsc_queue *q, const char *name, size_t capacity,
+                             void *mem)
+{
+    BUG_ON(!mem);
+
+    /* Initialize private queue area to all zeroes */
+    memset(q, 0, sizeof *q);
+
+    q->shm = (spsc_queue_shared *) mem;
+    q->name = name;
+    q->capacity = capacity;
+
+    /* In case we're opening a pre-existing queue, pick up where we left off. */
+    q->cached_tail = spsc_atomic_load(q, &q->shm->tail);
+    q->cached_head = spsc_atomic_load(q, &q->shm->head);
+}
+
+static inline bool spsc_queue_is_full(spsc_queue *q)
+{
+    uint32_t next_head;
+    uint32_t head;
+
+    head = spsc_atomic_load(q, &q->shm->head);
+
+    next_head = head + 1;
+    if (next_head >= q->capacity) {
+        next_head = 0;
+    }
+
+    if (next_head == q->cached_tail) {
+        q->cached_tail = spsc_atomic_load(q, &q->shm->tail);
+        if (next_head == q->cached_tail) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static inline bool spsc_send(spsc_queue *q, void *buf, size_t size)
+{
+    uint32_t next_head;
+    uint32_t head;
+
+    BUG_ON(size > sizeof q->shm->packets[0]);
+    BUG_ON(size == 0);
+
+    /* Is the queue full?  */
+    if (spsc_queue_is_full(q)) {
+        return false;
+    }
+
+    head = spsc_atomic_load(q, &q->shm->head);
+    next_head = head + 1;
+    if (next_head >= q->capacity) {
+        next_head = 0;
+    }
+
+    memcpy(q->shm->packets[head], buf, size);
+
+    spsc_atomic_store(q, &q->shm->head, next_head);
+    return true;
+}
+
+static inline bool spsc_recv(spsc_queue *q, void *buf, size_t size)
+{
+    uint32_t tail;
+
+    BUG_ON(size > sizeof q->shm->packets[0]);
+    BUG_ON(size == 0);
+
+    tail = spsc_atomic_load(q, &q->shm->tail);
+
+    /* Is the queue empty?  */
+    if (tail == q->cached_head) {
+        q->cached_head = spsc_atomic_load(q, &q->shm->head);
+        if (tail == q->cached_head) {
+            return false;
+        }
+    }
+
+    memcpy(buf, q->shm->packets[tail], size);
+
+    /* Update the read pointer.  */
+    tail++;
+    if (tail >= q->capacity) {
+        tail = 0;
+    }
+
+    spsc_atomic_store(q, &q->shm->tail, tail);
+    return true;
+}
+#endif /* SPSC_QUEUE_H__ */
-- 
2.43.0


