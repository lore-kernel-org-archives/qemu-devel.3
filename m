Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EE7CAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 22:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw6a4-0007Uf-3o; Tue, 09 Sep 2025 18:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3C6bAaAYKCqYeaHOTfMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--yubinz.bounces.google.com>)
 id 1uw6Yq-0007DQ-3l
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:36 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3C6bAaAYKCqYeaHOTfMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--yubinz.bounces.google.com>)
 id 1uw6Yj-0004yj-HF
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:34 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-24457ef983fso134886065ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757455884; x=1758060684; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=veTE+2XQh+j1qKlXBCLzdOyXX94ZOtbuYk0ocRxomvg=;
 b=NyjRAdzT/Iy8jxtIviPMugi9cDJjjUN3jVh/PqX/4yvdzNGfnBPoyhPnKt8G5TXE6I
 I5udJJOU2l9LylXmf6sBOB0ttPb0FtjGaQ+ssL3JSCIa7oy/SbtX4GnTA2NjpDVTTEdH
 66qCb1qbtVnZcCj8G0lZny9wPoIRzl0OtqRiEkvLgCo1sUQZiqbJbTnKGxbIkA9tjzA3
 xWJ6dvqyKEge92K1FhZRSNEtndZ7RaEjJdarg5KInqY7WWv6J45yPHz5f3J3QLo6rkbw
 CHI322NWfuDT0Obe8I2R9poztIDwucKOF892fmQ14ZOCmPKYHwZCxGvyaiBkIvZAPgGi
 A3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757455884; x=1758060684;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=veTE+2XQh+j1qKlXBCLzdOyXX94ZOtbuYk0ocRxomvg=;
 b=jtY9jz51kdgJVNL13SYDhJhE3LbvA697ZRfkh9QmUJoiMhGqayqXykns3sg2XOmbLW
 K1v7Nahym+FCOXc9/kRqu1c36mJ6tUsVOeB8eb83xZXdcet10ALzbu9AT9HcDJQ+40D6
 pF0CMKjXGXiRDD6m34U0nlzqiHk5wJcTvcHD+2HfRrGIOAKxMLpL557HZX08q3hKT7vo
 iElaB1RuFrhZ6s/j7bcdm9wy2TDsbImuEGFBQRI4DXIJd92D6mlG/e9XkSitVvielL9P
 SjYhfwGyj5h1p5gk7JKRrLp9X2w3jO9l3cy349/bHUO0fV9RNutwviVd2WAubXvhSaxW
 L9MA==
X-Gm-Message-State: AOJu0Yyk/jpf4oR8GHmfksGOETDfpVSHWMtvfR2AVDWLf+t20eYsvDPv
 QlDIvAFb1PiTF4z+Xr3eq7LK/SxoBnN1+Z5vbdntC7udGcFfTRGROVjygIRUX7aiiKidyvjiv4Y
 yjxsO61zNEK92H3JACDXLp4rABvLDCNHvKtnYwA690yoYKijMzZwFkUk7g/wHNqD53VjHzTGyhQ
 xJGOquL20D/qrt1+yFfIIfW5ix3aTAhRXaEtc=
X-Google-Smtp-Source: AGHT+IGTj+K55h4A9LdELTjIDABklNLLho407j6YgTz7G+bLMuxk1M8SKBnsSe6eCnOwST5VhpmmP08McHs=
X-Received: from plnw11.prod.google.com ([2002:a17:902:da4b:b0:24c:cd65:485a])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e542:b0:249:c76:76db
 with SMTP id d9443c01a7336-2516ec71a4amr204662405ad.21.1757455883494; Tue, 09
 Sep 2025 15:11:23 -0700 (PDT)
Date: Tue, 09 Sep 2025 22:10:56 +0000
In-Reply-To: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
Mime-Version: 1.0
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250909-pcie-root-upstream-v1-1-d85883b2688d@google.com>
Subject: [PATCH 1/7] hw/pci-host: implement Nuvoton PCIE Root Complex stub
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Yubin Zou <yubinz@google.com>, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3C6bAaAYKCqYeaHOTfMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--yubinz.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Sep 2025 18:12:44 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Titus Rwantare <titusr@google.com>

   create a basic device to introduce the root complex registers and
   respond to its mmio configuration accesses

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/pci-host/Kconfig               |   4 +
 hw/pci-host/meson.build           |   1 +
 hw/pci-host/npcm_pcierc.c         | 164 ++++++++++++++++++++++++++++++++++++++
 hw/pci-host/trace-events          |   4 +
 include/hw/pci-host/npcm_pcierc.h |  55 +++++++++++++
 5 files changed, 228 insertions(+)

diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 9824fa188d6b8865dcf7b069f2c16f269b211aa0..1d726b6e05c732b69e22aa2883892aaeaed129fa 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -108,3 +108,7 @@ config GT64120
     select PCI
     select EMPTY_SLOT
     select I8259
+
+config NPCM_PCIERC
+    bool
+    select PCI_EXPRESS
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index 937a0f72acf940f963fc683ab52a5f8b80657ca3..2c0a49cbc5102110f7d92e279df1ad4654570332 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -30,6 +30,7 @@ pci_ss.add(when: 'CONFIG_MV64361', if_true: files('mv64361.c'))
 # ARM devices
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_FSL_IMX8M_PHY', if_true: files('fsl_imx8m_phy.c'))
 pci_ss.add(when: 'CONFIG_VERSATILE_PCI', if_true: files('versatile.c'))
+pci_ss.add(when: 'CONFIG_NPCM_PCIERC', if_true: files('npcm_pcierc.c'))
 
 # HPPA devices
 specific_ss.add(when: 'CONFIG_ASTRO', if_true: files('astro.c'))
diff --git a/hw/pci-host/npcm_pcierc.c b/hw/pci-host/npcm_pcierc.c
new file mode 100644
index 0000000000000000000000000000000000000000..3afe92e264f6ce4312e94f05b5e908840008df64
--- /dev/null
+++ b/hw/pci-host/npcm_pcierc.c
@@ -0,0 +1,164 @@
+/*
+ * Nuvoton PCIe Root complex
+ *
+ * Copyright 2022 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/pci-host/npcm_pcierc.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "qom/object.h"
+#include "trace.h"
+
+static uint64_t npcm_pcierc_cfg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    NPCMPCIERCState *s = NPCM_PCIERC(opaque);
+    uint32_t ret = -1;
+
+    switch (addr) {
+    case NPCM_PCIERC_RCCFGNUM:
+        ret = s->rccfgnum;
+        break;
+
+    case NPCM_PCIERC_INTEN:
+        ret = s->rcinten;
+        break;
+
+    case NPCM_PCIERC_INTST:
+        ret = s->rcintstat;
+        break;
+
+    case NPCM_PCIERC_IMSI_ADDR:
+        ret = s->rcimsiaddr;
+        break;
+
+    case NPCM_PCIERC_MSISTAT:
+        ret = s->rcmsisstat;
+        break;
+
+    case NPCM_PCIERC_AXI_ERROR_REPORT:
+        ret = s->axierr;
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: read from unimplemented register 0x%04lx\n",
+                      __func__, addr);
+        ret = -1;
+        break;
+    }
+    trace_npcm_pcierc_read(addr, size, ret);
+    return ret;
+}
+
+static void npcm_pcierc_cfg_write(void *opaque, hwaddr addr, uint64_t data,
+                                  unsigned size)
+{
+    NPCMPCIERCState *s = NPCM_PCIERC(opaque);
+
+    trace_npcm_pcierc_write(addr, size, data);
+    switch (addr) {
+    case NPCM_PCIERC_RCCFGNUM:
+        s->rccfgnum = data;
+        break;
+
+    case NPCM_PCIERC_INTEN:
+        s->rcinten = data;
+        break;
+
+    case NPCM_PCIERC_INTST:
+        s->rcintstat &= ~data;
+        break;
+
+    case NPCM_PCIERC_IMSI_ADDR:
+        s->rcimsiaddr = data;
+        break;
+
+    case NPCM_PCIERC_MSISTAT:
+        s->rcmsisstat &= ~data;
+        break;
+
+    case NPCM_PCIERC_AXI_ERROR_REPORT:
+        s->axierr = data;
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: write to unimplemented reg 0x%04lx data: 0x%lx\n",
+                      __func__, addr, data);
+        break;
+    }
+}
+
+static void npcm_pcierc_reset(Object *obj, ResetType type)
+{
+    NPCMPCIERCState *s = NPCM_PCIERC(obj);
+
+    s->rccfgnum = 0;
+    s->rcinten = 0;
+    s->rcintstat = 0;
+    s->rcimsiaddr = 0;
+    s->rcmsisstat = 0;
+    s->axierr = 0;
+}
+
+static const char *npcm_pcierc_root_bus_path(PCIHostState *host_bridge,
+                                             PCIBus *rootbus)
+{
+    return "0000:00";
+}
+
+static const MemoryRegionOps npcm_pcierc_cfg_ops = {
+    .read       = npcm_pcierc_cfg_read,
+    .write      = npcm_pcierc_cfg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void npcm_pcierc_realize(DeviceState *dev, Error **errp)
+{
+    NPCMPCIERCState *s = NPCM_PCIERC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &npcm_pcierc_cfg_ops,
+                          s, TYPE_NPCM_PCIERC, 4 * KiB);
+    sysbus_init_mmio(sbd, &s->mmio);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void npcm_pcierc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIHostBridgeClass *hbc = PCI_HOST_BRIDGE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    hbc->root_bus_path = npcm_pcierc_root_bus_path;
+    dc->realize = npcm_pcierc_realize;
+    rc->phases.enter = npcm_pcierc_reset;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "pci";
+}
+
+static const TypeInfo npcm_pcierc_type_info = {
+    .name = TYPE_NPCM_PCIERC,
+    .parent = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(NPCMPCIERCState),
+    .class_init = npcm_pcierc_class_init,
+};
+
+static void npcm_pcierc_register_types(void)
+{
+    type_register_static(&npcm_pcierc_type_info);
+}
+
+type_init(npcm_pcierc_register_types)
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index 0a816b9aa129bb0c37d207e2612e09ac4762d51a..e4794f687177ee90fe4d33194b484c83a34dcaf9 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -69,3 +69,7 @@ elroy_pci_config_data_read(uint64_t addr, int size, uint64_t val) "addr 0x%"PRIx
 elroy_pci_config_data_write(uint64_t addr, int size, uint64_t val) "addr 0x%"PRIx64" size %d val 0x%"PRIx64
 iosapic_reg_write(uint64_t reg_select, int size, uint64_t val) "reg_select 0x%"PRIx64" size %d val 0x%"PRIx64
 iosapic_reg_read(uint64_t reg_select, int size, uint64_t val) "reg_select 0x%"PRIx64" size %d val 0x%"PRIx64
+
+# npmc_pcierc.c
+npcm_pcierc_read(uint64_t offset, uint32_t size, uint64_t data) "offset: 0x%" PRIx64 " size: %d data: 0x%" PRIx64
+npcm_pcierc_write(uint64_t offset, uint32_t size, uint64_t data) "offset: 0x%" PRIx64 " size: %d data: 0x%" PRIx64
diff --git a/include/hw/pci-host/npcm_pcierc.h b/include/hw/pci-host/npcm_pcierc.h
new file mode 100644
index 0000000000000000000000000000000000000000..2c817147d495fdc1d1fa4b389bad0469fd6a825e
--- /dev/null
+++ b/include/hw/pci-host/npcm_pcierc.h
@@ -0,0 +1,55 @@
+/*
+ * Nuvoton PCIe Root complex
+ *
+ * Copyright 2022 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * The PCIERC configuration registers must be initialised by the BMC kernel
+ * during boot for PCIe to function
+ * - A single window from the PCIe to the Memory controller
+ * - 4 windows from the BMC to the PCIe.
+ *     1 of these five BMC-to-PCIe windows must be allocated for configuration
+ *     transactions, the rest can be used for I/0 or memory transactions
+ * - All BMC-to-PCIe windows are mapped to address range
+ *   0xe800_0000 to 0xefff_ffff (128MB)
+ */
+
+#ifndef NPCM_PCIERC_H
+#define NPCM_PCIERC_H
+
+#include "hw/sysbus.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pcie_host.h"
+#include "qom/object.h"
+
+/* PCIe Root Complex Registers */
+#define LINKSTAT                        0x92
+#define NPCM_PCIERC_RCCFGNUM            0x140 /* Configuration Number */
+#define NPCM_PCIERC_INTEN               0x180 /* Interrupt Enable */
+#define NPCM_PCIERC_INTST               0x184 /* Interrupt Status */
+#define NPCM_PCIERC_IMSI_ADDR           0x190
+#define NPCM_PCIERC_MSISTAT             0x194 /* MSI Status Register */
+#define NPCM_PCIERC_AXI_ERROR_REPORT    0x3E0
+
+#define TYPE_NPCM_PCIERC "npcm-pcie-root-complex"
+OBJECT_DECLARE_SIMPLE_TYPE(NPCMPCIERCState, NPCM_PCIERC)
+
+struct NPCMPCIERCState {
+    PCIExpressHost parent;
+
+    qemu_irq irq;
+
+    /* PCIe RC registers */
+    MemoryRegion mmio;
+    uint32_t rccfgnum;
+    uint32_t rcinten;
+    uint32_t rcintstat;
+    uint32_t rcimsiaddr;
+    uint32_t rcmsisstat;
+    uint32_t axierr;
+};
+
+#endif /* NPCM_PCIERC_H */

-- 
2.51.0.384.g4c02a37b29-goog


