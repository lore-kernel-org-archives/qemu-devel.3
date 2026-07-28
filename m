Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16202C54F56
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 22:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woqRf-0007Fc-IJ; Tue, 28 Jul 2026 18:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nodokaorganized@gmail.com>)
 id 1woqRd-0007FH-Qs
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 18:38:41 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nodokaorganized@gmail.com>)
 id 1woqRb-00027w-B6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 18:38:41 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-81dfdbd86d1so4423507b3.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 15:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785278318; x=1785883118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JC70vhGM2mm4Eqnz6rd7PaOFmvD+mZG2HzV8c+5437k=;
 b=H8aZ0zOUMr2acK1nXmZItO3D3qbC8qWdJ0gyJywyRWYX7KvRjLahPNTPGJl537f8W5
 DFh7YC+GT2orGUyKs6aTUD3lnEvGpil7Od8Xfk9c+C/UiDKGehNahDSHPdw+u07XpNve
 srke/QDVmj1BPuEpC0CD5K+zwLJJX42VsGSb7oLaopR9g+MJM44MFSq+f92WEOZBfUBs
 H/NotL2xCjqH4IsRLqDMupE4C/Yunizaj+cObYIRd3WIYA/R6P4B+xClkVae692PHXWx
 JkjMZn2m1AX7GIyN+4lcMqy+w4JCl9pkFMKKbKl2Qicb6ZBzL4S2Shmh898hg2A+zF+e
 JDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785278318; x=1785883118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JC70vhGM2mm4Eqnz6rd7PaOFmvD+mZG2HzV8c+5437k=;
 b=O0Q0i7UKLOfpK3bjL4nWWiOz0AioYQe+mCofpve5IYp6CkuWnv6UMIZFVnEEIGo6Li
 VWPq6M0sSPzJqECkjnSQcD2rxg6ZVlxOMH3iaw4kv/e005sYYf4DCSJTj2I9XoJmUGXH
 iyuYJfEdnozN4AgASZjnH65qh2VuDlroUSJGAPGI4TfQkMd1p4BHJKW3UbXsu4lS0hk1
 mdG2nw11hMx0opEm1U/8CKmsJhYLLvAnDDg1O2siQoT2x+yiDqYs+CTj8y5P4e62g32U
 41VjD9dutnDb29dkWpFAiHx8gT+yeiV/SajRwW+DPzmhf7wWHTx1MkPJMXlWVk1q45bn
 d1Mg==
X-Gm-Message-State: AOJu0YxwTusBneiz9N4MsX+fVjWLfx1yt6xU3OLmNmzN1zgD8HsfYTCP
 1Xa1GDAhkzkuvJeKbzDnv6Ba9KHmA3E3eoKkqy5mVGSNmP2GhQBJzmv6ls/SzEDM
X-Gm-Gg: AR+sD11emtUuhyX65cv/FDlLiYuUa6pd0ECjOnxNEDmMqAjGXPQ0t2AIh2SqjouC7Hl
 G0vvoMOxA2OEvgr7pORisMA2dQNa/C4nqBmR5Hha31gu/GFpaD0uybP1mCDiTh87NjaIkEmlRQm
 hskc2Rd7y54dO+REAZg8LuZdN19PpyRDR+hlTSB1Xykvr8H4ylRKNWY9LVcMxhLVQg5bU0CJa6p
 1VJUNj+B4J0Bc2xvIjVJqzc4ZrghmqHe4BjWsmcpwq6Hdzw12R6A8yfsJr2PXARSBhFXIxhc382
 Xokzi8++qrso18LUrGC9FhP7OzLz4JDMyVe/86DTLalrpdxoouXMMbyxkksx5GEVkegntxNo2ip
 4VlSTDm7k65s76B/6DHT2GVL5d1kzzGm5n5KN9szdegMNyYLzh6b+cGDrM3Vi0qooXAyygHWctI
 bOZXMN+49GT3VTpYa9J+seDUhhkPyEsg72lYdbSunzDG7hVBuvV5vH1MMhFpn5/X8w0c1U2bJZi
 +dSZp4ZceKvbniSzW8KQ8AOVOCTRwuvhX54vjOdaHOIq2f8E28rqQsTnJn8BQscAUIg/czbwGtT
 HnzV/4XckPt0Ap9ZCu0iKoAIzUUu2Ug=
X-Received: by 2002:a05:690c:6513:b0:81e:6fd:93b4 with SMTP id
 00721157ae682-81f990e37e0mr23498787b3.19.1785278317664; 
 Tue, 28 Jul 2026 15:38:37 -0700 (PDT)
Received: from ip-172-32-0-41.us-east-2.compute.internal
 (ec2-3-143-144-70.us-east-2.compute.amazonaws.com. [3.143.144.70])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fa27592e9sm7541447b3.8.2026.07.28.15.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 15:38:37 -0700 (PDT)
From: Nodoka Shibasaki <nodokaorganized@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Nodoka Shibasaki <nodokaorganized@gmail.com>
Subject: [RFC PATCH v2 2/2] hw/misc: add xiic-fpga-i2c,
 a PCIe FPGA embedding xlnx-axi-iic cores
Date: Tue, 28 Jul 2026 22:38:29 +0000
Message-ID: <20260728223829.2613524-3-nodokaorganized@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260728223829.2613524-1-nodokaorganized@gmail.com>
References: <20260715221400.1484805-1-nodokaorganized@gmail.com>
 <20260728223829.2613524-1-nodokaorganized@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=nodokaorganized@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add a PCIe function that embeds N xlnx-axi-iic controllers, maps each
core's register window into BAR0, and adds a top-level interrupt block
that aggregates the per-channel level lines into a bit-per-channel status
register delivered on a single MSI vector (with a legacy INTx fallback),
performing the level-to-edge translation a guest driver expects.

The aggregator's register layout models a specific FPGA carrier rather
than a standardized controller, so the device is gated behind
CONFIG_XIIC_FPGA_I2C (default y if TEST_DEVICES). A qtest drives a
transfer through BAR0 to a tmp105 slave and checks register, transfer and
NACK behavior; the test slaves it needs are enabled in the x86_64-softmmu
test config.

Signed-off-by: Nodoka Shibasaki <nodokaorganized@gmail.com>
---
 MAINTAINERS                                |   8 +-
 configs/devices/x86_64-softmmu/default.mak |   5 +
 hw/misc/Kconfig                            |   6 +
 hw/misc/meson.build                        |   1 +
 hw/misc/xiic_fpga_i2c.c                    | 261 +++++++++++++++++++++
 tests/qtest/meson.build                    |   2 +
 tests/qtest/xiic-fpga-i2c-test.c           | 159 +++++++++++++
 7 files changed, 439 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/xiic_fpga_i2c.c
 create mode 100644 tests/qtest/xiic-fpga-i2c-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8339c9bf83..85f03cf4b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2158,8 +2158,6 @@ S: Maintained
 F: hw/misc/edu.c
 F: docs/specs/edu.rst
 
-<<<<<<< Updated upstream
-=======
 xiic-fpga-i2c
 M: Nodoka Shibasaki <nodokaorganized@gmail.com>
 S: Maintained
@@ -2167,7 +2165,11 @@ F: hw/i2c/xlnx-axi-iic.c
 F: include/hw/i2c/xlnx-axi-iic.h
 F: docs/specs/xlnx-axi-iic.rst
 
->>>>>>> Stashed changes
+xiic-fpga-i2c
+M: Nodoka Shibasaki <nodokaorganized@gmail.com>
+S: Maintained
+F: hw/misc/xiic_fpga_i2c.c
+
 IDE
 M: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
diff --git a/configs/devices/x86_64-softmmu/default.mak b/configs/devices/x86_64-softmmu/default.mak
index ddfc2ea626..d7a88deccc 100644
--- a/configs/devices/x86_64-softmmu/default.mak
+++ b/configs/devices/x86_64-softmmu/default.mak
@@ -1,3 +1,8 @@
 # Default configuration for x86_64-softmmu
 
 include ../i386-softmmu/default.mak
+
+# Enable I2C slave models used by the xiic-fpga-i2c qtest.
+CONFIG_AT24C=y
+CONFIG_TMP105=y
+CONFIG_TMP421=y
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6653..12acca66bb 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -25,6 +25,12 @@ config PCI_TESTDEV
     default y if TEST_DEVICES
     depends on PCI
 
+config XIIC_FPGA_I2C
+    bool
+    default y if TEST_DEVICES
+    depends on PCI && MSI_NONBROKEN
+    select XLNX_AXI_IIC
+
 config IOMMU_TESTDEV
     bool
     default y if TEST_DEVICES
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6035..69d816cad9 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
 system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
 system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
+system_ss.add(when: 'CONFIG_XIIC_FPGA_I2C', if_true: files('xiic_fpga_i2c.c'))
 system_ss.add(when: 'CONFIG_IOMMU_TESTDEV', if_true: files('iommu-testdev.c'))
 system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
diff --git a/hw/misc/xiic_fpga_i2c.c b/hw/misc/xiic_fpga_i2c.c
new file mode 100644
index 0000000000..c4425fa84d
--- /dev/null
+++ b/hw/misc/xiic_fpga_i2c.c
@@ -0,0 +1,261 @@
+/*
+ * xiic_fpga_i2c.c - QEMU model of a PCIe FPGA that embeds Xilinx AXI-IIC
+ *                   controllers behind a shared MSI interrupt aggregator.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/host-utils.h"
+#include "migration/vmstate.h"
+#include "hw/pci/pci_device.h"
+#include "hw/pci/msi.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/i2c/xlnx-axi-iic.h"
+
+#define TYPE_XIIC_FPGA_I2C "xiic-fpga-i2c"
+OBJECT_DECLARE_SIMPLE_TYPE(XiicFpgaI2cState, XIIC_FPGA_I2C)
+
+#define XIIC_FPGA_MAX_CHANNELS 32
+
+#define XIIC_FPGA_IRQ_STATUS_REG 0
+#define XIIC_FPGA_IRQ_UNMASK_REG 4
+#define XIIC_FPGA_IRQ_REGION_SIZE 8
+
+struct XiicFpgaI2cState {
+    PCIDevice parent_obj;
+
+    MemoryRegion bar0;
+    MemoryRegion irq_mmio;
+
+    uint32_t num_channels;
+    uint32_t ch_base_offset;
+    uint32_t ch_stride;
+    uint32_t bar_size;
+    uint32_t num_msi_vectors;
+
+    uint32_t irq_status_offset;
+    uint32_t irq_unmask_offset;
+    uint32_t irq_msi_vector;
+
+    uint32_t irq_status;
+    uint32_t irq_unmask;
+    bool msi_asserted;
+
+    XlnxAxiIicState chan[XIIC_FPGA_MAX_CHANNELS];
+};
+
+static void xiic_fpga_update_msi(XiicFpgaI2cState *s)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(s);
+    uint32_t active = s->irq_status & s->irq_unmask;
+
+    if (msi_enabled(pci_dev)) {
+        if (active && !s->msi_asserted) {
+            msi_notify(pci_dev, s->irq_msi_vector);
+            s->msi_asserted = true;
+        } else if (!active) {
+            s->msi_asserted = false;
+        }
+        return;
+    }
+
+    pci_set_irq(pci_dev, active != 0);
+}
+
+static void xiic_fpga_irq_set(void *opaque, int n, int level)
+{
+    XiicFpgaI2cState *s = opaque;
+
+    if (level) {
+        s->irq_status |= (1u << n);
+    } else {
+        s->irq_status &= ~(1u << n);
+    }
+    xiic_fpga_update_msi(s);
+}
+
+static uint64_t xiic_fpga_irq_read(void *opaque, hwaddr addr, unsigned size)
+{
+    XiicFpgaI2cState *s = opaque;
+
+    switch (addr) {
+    case XIIC_FPGA_IRQ_STATUS_REG:
+        return s->irq_status;
+    case XIIC_FPGA_IRQ_UNMASK_REG:
+        return s->irq_unmask;
+    default:
+        return 0;
+    }
+}
+
+static void xiic_fpga_irq_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    XiicFpgaI2cState *s = opaque;
+
+    switch (addr) {
+    case XIIC_FPGA_IRQ_STATUS_REG:
+        s->msi_asserted = false;
+        xiic_fpga_update_msi(s);
+        break;
+    case XIIC_FPGA_IRQ_UNMASK_REG:
+        s->irq_unmask = val;
+        xiic_fpga_update_msi(s);
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps xiic_fpga_irq_ops = {
+    .read = xiic_fpga_irq_read,
+    .write = xiic_fpga_irq_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl  = { .min_access_size = 1, .max_access_size = 4 },
+    .valid = { .min_access_size = 1, .max_access_size = 4 },
+};
+
+static void xiic_fpga_i2c_realize(PCIDevice *pci_dev, Error **errp)
+{
+    XiicFpgaI2cState *s = XIIC_FPGA_I2C(pci_dev);
+
+    if (s->num_channels < 1 || s->num_channels > XIIC_FPGA_MAX_CHANNELS) {
+        error_setg(errp, "num-channels must be between 1 and %d",
+                   XIIC_FPGA_MAX_CHANNELS);
+        return;
+    }
+    if (s->irq_unmask_offset != s->irq_status_offset + 4) {
+        error_setg(errp, "irq-unmask-offset must be irq-status-offset + 4");
+        return;
+    }
+
+    if (s->bar_size < s->ch_base_offset + s->num_channels * s->ch_stride) {
+        s->bar_size = s->ch_base_offset + s->num_channels * s->ch_stride;
+    }
+    if (s->bar_size < s->irq_status_offset + XIIC_FPGA_IRQ_REGION_SIZE) {
+        s->bar_size = s->irq_status_offset + XIIC_FPGA_IRQ_REGION_SIZE;
+    }
+    s->bar_size = pow2ceil(s->bar_size);
+
+    s->num_msi_vectors = pow2ceil(s->num_channels);
+    if (s->num_msi_vectors > 32) {
+        s->num_msi_vectors = 32;
+    }
+    if (s->irq_msi_vector >= s->num_msi_vectors) {
+        error_setg(errp, "irq-msi-vector %u out of range (0..%u)",
+                   s->irq_msi_vector, s->num_msi_vectors - 1);
+        return;
+    }
+
+    memory_region_init(&s->bar0, OBJECT(s), "xiic-fpga-i2c-bar0", s->bar_size);
+
+    qdev_init_gpio_in(DEVICE(s), xiic_fpga_irq_set, s->num_channels);
+
+    for (unsigned i = 0; i < s->num_channels; i++) {
+        g_autofree char *name = g_strdup_printf("channel[%u]", i);
+        g_autofree char *bus_name = g_strdup_printf("xiic-fpga-i2c.%u", i);
+        object_initialize_child(OBJECT(s), name, &s->chan[i],
+                                TYPE_XLNX_AXI_IIC);
+        qdev_prop_set_string(DEVICE(&s->chan[i]), "bus-name", bus_name);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->chan[i]), errp)) {
+            return;
+        }
+        memory_region_add_subregion(&s->bar0,
+            s->ch_base_offset + i * s->ch_stride,
+            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->chan[i]), 0));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->chan[i]), 0,
+                           qdev_get_gpio_in(DEVICE(s), i));
+    }
+
+    memory_region_init_io(&s->irq_mmio, OBJECT(s), &xiic_fpga_irq_ops, s,
+                          "xiic-fpga-i2c-irq", XIIC_FPGA_IRQ_REGION_SIZE);
+    memory_region_add_subregion(&s->bar0, s->irq_status_offset, &s->irq_mmio);
+
+    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar0);
+    pci_config_set_interrupt_pin(pci_dev->config, 1);
+
+    if (msi_init(pci_dev, 0, s->num_msi_vectors, true, false, errp) < 0) {
+        error_prepend(errp, "xiic-fpga-i2c: failed to init MSI: ");
+        return;
+    }
+}
+
+static void xiic_fpga_i2c_exit(PCIDevice *pci_dev)
+{
+    msi_uninit(pci_dev);
+}
+
+static void xiic_fpga_i2c_reset_hold(Object *obj, ResetType type)
+{
+    XiicFpgaI2cState *s = XIIC_FPGA_I2C(obj);
+
+    s->irq_status = 0;
+    s->irq_unmask = 0;
+    s->msi_asserted = false;
+}
+
+static const VMStateDescription vmstate_xiic_fpga_i2c = {
+    .name = "xiic-fpga-i2c",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj, XiicFpgaI2cState),
+        VMSTATE_UINT32(irq_status, XiicFpgaI2cState),
+        VMSTATE_UINT32(irq_unmask, XiicFpgaI2cState),
+        VMSTATE_BOOL(msi_asserted, XiicFpgaI2cState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property xiic_fpga_i2c_props[] = {
+    DEFINE_PROP_UINT32("num-channels", XiicFpgaI2cState, num_channels, 4),
+    DEFINE_PROP_UINT32("ch-base-offset", XiicFpgaI2cState, ch_base_offset, 0x0),
+    DEFINE_PROP_UINT32("ch-stride", XiicFpgaI2cState, ch_stride, 0x1000),
+    DEFINE_PROP_UINT32("bar-size", XiicFpgaI2cState, bar_size, 0x8000),
+    DEFINE_PROP_UINT32("irq-status-offset", XiicFpgaI2cState,
+                       irq_status_offset, 0x6000),
+    DEFINE_PROP_UINT32("irq-unmask-offset", XiicFpgaI2cState,
+                       irq_unmask_offset, 0x6004),
+    DEFINE_PROP_UINT32("irq-msi-vector", XiicFpgaI2cState, irq_msi_vector, 0),
+};
+
+static void xiic_fpga_i2c_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    k->realize   = xiic_fpga_i2c_realize;
+    k->exit      = xiic_fpga_i2c_exit;
+    k->vendor_id = 0x10ee;
+    k->device_id = 0x7021;
+    k->revision  = 0x01;
+    k->class_id  = PCI_CLASS_OTHERS;
+
+    rc->phases.hold = xiic_fpga_i2c_reset_hold;
+    dc->vmsd = &vmstate_xiic_fpga_i2c;
+    dc->desc = "FPGA I2C (Xilinx AXI-IIC) emulation";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, xiic_fpga_i2c_props);
+}
+
+static const TypeInfo xiic_fpga_i2c_info = {
+    .name          = TYPE_XIIC_FPGA_I2C,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(XiicFpgaI2cState),
+    .class_init    = xiic_fpga_i2c_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void xiic_fpga_i2c_register_types(void)
+{
+    type_register_static(&xiic_fpga_i2c_info);
+}
+
+type_init(xiic_fpga_i2c_register_types)
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..7abd2c7520 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -74,6 +74,8 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_WDT_IB700') ? ['wdt_ib700-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_PVPANIC_ISA') ? ['pvpanic-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_PVPANIC_PCI') ? ['pvpanic-pci-test'] : []) +          \
+  (config_all_devices.has_key('CONFIG_XIIC_FPGA_I2C') and
+   config_all_devices.has_key('CONFIG_TMP105') ? ['xiic-fpga-i2c-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_HDA') ? ['intel-hda-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_I82801B11') ? ['i82801b11-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_IOH3420') ? ['ioh3420-test'] : []) +                  \
diff --git a/tests/qtest/xiic-fpga-i2c-test.c b/tests/qtest/xiic-fpga-i2c-test.c
new file mode 100644
index 0000000000..8c5f862d7c
--- /dev/null
+++ b/tests/qtest/xiic-fpga-i2c-test.c
@@ -0,0 +1,159 @@
+/*
+ * QTest for the xiic-fpga-i2c PCIe FPGA and its embedded xlnx-axi-iic cores.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/pci.h"
+#include "libqos/pci-pc.h"
+
+#define XIIC_IISR   0x20
+#define XIIC_IIER   0x28
+#define XIIC_DGIER  0x1C
+#define XIIC_SR     0x104
+#define XIIC_DTR    0x108
+#define XIIC_DRR    0x10C
+
+#define XIIC_SR_RX_FIFO_EMPTY   0x40
+#define XIIC_SR_TX_FIFO_EMPTY   0x80
+#define XIIC_SR_BUS_BUSY        0x04
+
+#define XIIC_INTR_TX_ERROR      0x02
+#define XIIC_INTR_BNB           0x10
+
+#define XIIC_DYN_START          0x100
+#define XIIC_DYN_STOP           0x200
+
+#define TMP105_ADDR             0x4c
+#define TMP105_REG_CONFIG       0x01
+
+typedef struct {
+    QTestState *qts;
+    QPCIBus *pcibus;
+    QPCIDevice *dev;
+    QPCIBar bar;
+} XiicFixture;
+
+static void save_dev(QPCIDevice *dev, int devfn, void *data)
+{
+    QPCIDevice **out = data;
+
+    if (*out) {
+        g_free(dev);
+    } else {
+        *out = dev;
+    }
+}
+
+static void fixture_setup(XiicFixture *f)
+{
+    f->qts = qtest_init("-device xiic-fpga-i2c,num-channels=1 "
+                        "-device tmp105,id=temp,bus=xiic-fpga-i2c.0,address=0x4c");
+    f->pcibus = qpci_new_pc(f->qts, NULL);
+    f->dev = NULL;
+    qpci_device_foreach(f->pcibus, 0x10ee, 0x7021, save_dev, &f->dev);
+    g_assert(f->dev != NULL);
+    qpci_device_enable(f->dev);
+    f->bar = qpci_iomap(f->dev, 0, NULL);
+}
+
+static void fixture_teardown(XiicFixture *f)
+{
+    qpci_iounmap(f->dev, f->bar);
+    g_free(f->dev);
+    qpci_free_pc(f->pcibus);
+    qtest_quit(f->qts);
+}
+
+static void wr(XiicFixture *f, uint64_t off, uint32_t val)
+{
+    qpci_io_writel(f->dev, f->bar, off, val);
+}
+
+static uint32_t rd(XiicFixture *f, uint64_t off)
+{
+    return qpci_io_readl(f->dev, f->bar, off);
+}
+
+static void test_registers(void)
+{
+    XiicFixture f;
+    uint32_t sr;
+
+    fixture_setup(&f);
+
+    sr = rd(&f, XIIC_SR);
+    g_assert_cmphex(sr & XIIC_SR_TX_FIFO_EMPTY, ==, XIIC_SR_TX_FIFO_EMPTY);
+    g_assert_cmphex(sr & XIIC_SR_RX_FIFO_EMPTY, ==, XIIC_SR_RX_FIFO_EMPTY);
+    g_assert_cmphex(sr & XIIC_SR_BUS_BUSY, ==, 0);
+
+    wr(&f, XIIC_IIER, 0x08);
+    g_assert_cmphex(rd(&f, XIIC_IIER), ==, 0x08);
+    wr(&f, XIIC_DGIER, 0x80000000);
+    g_assert_cmphex(rd(&f, XIIC_DGIER), ==, 0x80000000);
+
+    fixture_teardown(&f);
+}
+
+static void test_read(void)
+{
+    XiicFixture f;
+
+    fixture_setup(&f);
+
+    qtest_qmp_assert_success(f.qts,
+        "{ 'execute': 'qom-set', 'arguments':"
+        " { 'path': '/machine/peripheral/temp',"
+        "   'property': 'temperature', 'value': 21000 } }");
+
+    wr(&f, XIIC_DTR, XIIC_DYN_START | (TMP105_ADDR << 1) | 1);
+    wr(&f, XIIC_DTR, XIIC_DYN_STOP | 2);
+
+    g_assert_cmphex(rd(&f, XIIC_DRR) & 0xff, ==, 0x15);
+
+    fixture_teardown(&f);
+}
+
+static void test_write(void)
+{
+    XiicFixture f;
+    uint32_t isr;
+
+    fixture_setup(&f);
+
+    wr(&f, XIIC_DTR, XIIC_DYN_START | (TMP105_ADDR << 1) | 0);
+    wr(&f, XIIC_DTR, TMP105_REG_CONFIG);
+    wr(&f, XIIC_DTR, XIIC_DYN_STOP | 0x00);
+
+    isr = rd(&f, XIIC_IISR);
+    g_assert_cmphex(isr & XIIC_INTR_TX_ERROR, ==, 0);
+    g_assert_cmphex(isr & XIIC_INTR_BNB, ==, XIIC_INTR_BNB);
+    g_assert_cmphex(rd(&f, XIIC_SR) & XIIC_SR_BUS_BUSY, ==, 0);
+
+    fixture_teardown(&f);
+}
+
+static void test_nack(void)
+{
+    XiicFixture f;
+
+    fixture_setup(&f);
+
+    wr(&f, XIIC_DTR, XIIC_DYN_START | (0x20 << 1) | 1);
+    g_assert_cmphex(rd(&f, XIIC_IISR) & XIIC_INTR_TX_ERROR, ==,
+                    XIIC_INTR_TX_ERROR);
+
+    fixture_teardown(&f);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/xiic-fpga-i2c/registers", test_registers);
+    qtest_add_func("/xiic-fpga-i2c/read", test_read);
+    qtest_add_func("/xiic-fpga-i2c/write", test_write);
+    qtest_add_func("/xiic-fpga-i2c/nack", test_nack);
+    return g_test_run();
+}
-- 
2.50.1


