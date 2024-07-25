Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9BDC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8JB-0007og-RV; Thu, 25 Jul 2024 19:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8J1-00074J-Ty; Thu, 25 Jul 2024 19:55:35 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Iz-0000vu-C4; Thu, 25 Jul 2024 19:55:31 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7928d2abe0aso261750a12.0; 
 Thu, 25 Jul 2024 16:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951727; x=1722556527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrI0z6GRU3zk8UJo9Bpz3wyxG+TqE9nxlq3iQG2ngu8=;
 b=TINQz89GZKsPJk7NveXE+xBut57ffV08DENfknYqzC1NvdcI6J3ByomBMkn3h1hBHT
 XRk+xDkEzjRA+h2bdWoc62MZz6Y1RhECdKGmHDt/HSiWexjrZS2ek5M6T9QNWOqktIkm
 YgDDgMdZ9uNuSGyoJAh0F1We5+1hZSjaHQ6BP0hfBOBgnpxsuZiLLYZBA9DNBN4Zg0O5
 boo+kyCSg2/tSWDIQMZxBEEym5OwdSaThgbdnug0NeUczipUDTo8RfCkAzShfB+FCuuj
 eAMZ46SRKHFk4G0IIN57IwwbNLTv/WnPJexFJheq1ZfeBIMXxh5t+XEcJqb1ouyU2oMH
 phdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951727; x=1722556527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CrI0z6GRU3zk8UJo9Bpz3wyxG+TqE9nxlq3iQG2ngu8=;
 b=OTPtI1kY5RVAIoCP0vc8SIQozwUKwQbYnkA6vUXPQqI9UGwGUrCm8+BFo5JN1jOqr+
 4xvCPGsG5410O5tCTCPnDnHEd9hVtWVxe8bXSTHNeDc/5oZzDWs8R4njSqvmz0qMFsEt
 0NEA7u8Fgx89vV+xQ/X+1Y99H8uPNb0idw/18y5LTuc3qOmUrB0hZdzKBP+rAO9hmKpv
 MfLsT3OUOoOGC5/7yCVBLYf7lbozkCzrAgzF7TEfez2tNLJfF2WZgtjezHAuOQrOKWWK
 0nSUOV//w+LVRTUqB004JFXWZ5dlplIy2qcxxnG392PGOxoe54aStyJo04lE/5jaR8ZC
 XNDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuXH6GX9FQbnBd3QbGfM2IUdzAT5g6MqvDOE0c/IX63YEj9188uLDHoeky2SHDz6oIu1Bci5rEKXossL4sTi6OiXBX
X-Gm-Message-State: AOJu0Yyvp+FpZebLGeHmzLGMmWP5CsvYpJ5nVkrgbfsZKD2POSUmT4py
 1PDXY3sYrTq/asSJmTRj8mzFnGQ1HCOyA6NHNd5ss/VuSPIHV0tXbFz2eg==
X-Google-Smtp-Source: AGHT+IG0vu25E2Hck9Cm3P38RrNgy7ltC86R2OFfiRghnn50asLbo/JYaPAZRDdQjSMayMG6IAm3Ew==
X-Received: by 2002:a17:90a:6b0b:b0:2cb:4b31:1c48 with SMTP id
 98e67ed59e1d1-2cdb96531bamr10632388a91.22.1721951726814; 
 Thu, 25 Jul 2024 16:55:26 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 16/96] ppc/pnv: Begin a more complete ADU LPC model for
 POWER9/10
Date: Fri, 26 Jul 2024 09:52:49 +1000
Message-ID: <20240725235410.451624-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x531.google.com
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

This implements a framework for an ADU unit model.

The ADU unit actually implements XSCOM, which is the bridge between MMIO
and PIB. However it also includes control and status registers and other
functions that are exposed as PIB (xscom) registers.

To keep things simple, pnv_xscom.c remains the XSCOM bridge
implementation, and pnv_adu.c implements the ADU registers and other
functions.

So far, just the ADU no-op registers in the pnv_xscom.c default handler
are moved over to the adu model.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/meson.build         |   1 +
 hw/ppc/pnv.c               |  16 ++++++
 hw/ppc/pnv_adu.c           | 111 +++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_xscom.c         |   9 ---
 hw/ppc/trace-events        |   4 ++
 include/hw/ppc/pnv_adu.h   |  25 +++++++++
 include/hw/ppc/pnv_chip.h  |   3 +
 include/hw/ppc/pnv_xscom.h |   6 ++
 8 files changed, 166 insertions(+), 9 deletions(-)
 create mode 100644 hw/ppc/pnv_adu.c
 create mode 100644 include/hw/ppc/pnv_adu.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 3ebbf329bc..7cd9189869 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -42,6 +42,7 @@ endif
 ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv.c',
   'pnv_xscom.c',
+  'pnv_adu.c',
   'pnv_core.c',
   'pnv_i2c.c',
   'pnv_lpc.c',
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f56dcf6597..689197cbb7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1551,6 +1551,7 @@ static void pnv_chip_power9_instance_init(Object *obj)
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
     int i;
 
+    object_initialize_child(obj, "adu",  &chip9->adu, TYPE_PNV_ADU);
     object_initialize_child(obj, "xive", &chip9->xive, TYPE_PNV_XIVE);
     object_property_add_alias(obj, "xive-fabric", OBJECT(&chip9->xive),
                               "xive-fabric");
@@ -1661,6 +1662,13 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* ADU */
+    if (!qdev_realize(DEVICE(&chip9->adu), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV9_XSCOM_ADU_BASE,
+                            &chip9->adu.xscom_regs);
+
     pnv_chip_quad_realize(chip9, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1827,6 +1835,7 @@ static void pnv_chip_power10_instance_init(Object *obj)
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
     int i;
 
+    object_initialize_child(obj, "adu",  &chip10->adu, TYPE_PNV_ADU);
     object_initialize_child(obj, "xive", &chip10->xive, TYPE_PNV_XIVE2);
     object_property_add_alias(obj, "xive-fabric", OBJECT(&chip10->xive),
                               "xive-fabric");
@@ -1919,6 +1928,13 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* ADU */
+    if (!qdev_realize(DEVICE(&chip10->adu), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_ADU_BASE,
+                            &chip10->adu.xscom_regs);
+
     pnv_chip_power10_quad_realize(chip10, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
new file mode 100644
index 0000000000..8279bc8b26
--- /dev/null
+++ b/hw/ppc/pnv_adu.c
@@ -0,0 +1,111 @@
+/*
+ * QEMU PowerPC PowerNV ADU unit
+ *
+ * The ADU unit actually implements XSCOM, which is the bridge between MMIO
+ * and PIB. However it also includes control and status registers and other
+ * functions that are exposed as PIB (xscom) registers.
+ *
+ * To keep things simple, pnv_xscom.c remains the XSCOM bridge
+ * implementation, and pnv_adu.c implements the ADU registers and other
+ * functions.
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_adu.h"
+#include "hw/ppc/pnv_chip.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "trace.h"
+
+static uint64_t pnv_adu_xscom_read(void *opaque, hwaddr addr, unsigned width)
+{
+    uint32_t offset = addr >> 3;
+    uint64_t val = 0;
+
+    switch (offset) {
+    case 0x18:     /* Receive status reg */
+    case 0x12:     /* log register */
+    case 0x13:     /* error register */
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP, "ADU Unimplemented read register: Ox%08x\n",
+                                                                     offset);
+    }
+
+    trace_pnv_adu_xscom_read(addr, val);
+
+    return val;
+}
+
+static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned width)
+{
+    uint32_t offset = addr >> 3;
+
+    trace_pnv_adu_xscom_write(addr, val);
+
+    switch (offset) {
+    case 0x18:     /* Receive status reg */
+    case 0x12:     /* log register */
+    case 0x13:     /* error register */
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP, "ADU Unimplemented write register: Ox%08x\n",
+                                                                     offset);
+    }
+}
+
+const MemoryRegionOps pnv_adu_xscom_ops = {
+    .read = pnv_adu_xscom_read,
+    .write = pnv_adu_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_adu_realize(DeviceState *dev, Error **errp)
+{
+    PnvADU *adu = PNV_ADU(dev);
+
+    /* XScom regions for ADU registers */
+    pnv_xscom_region_init(&adu->xscom_regs, OBJECT(dev),
+                          &pnv_adu_xscom_ops, adu, "xscom-adu",
+                          PNV9_XSCOM_ADU_SIZE);
+}
+
+static void pnv_adu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = pnv_adu_realize;
+    dc->desc = "PowerNV ADU";
+    dc->user_creatable = false;
+}
+
+static const TypeInfo pnv_adu_type_info = {
+    .name          = TYPE_PNV_ADU,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvADU),
+    .class_init    = pnv_adu_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { } },
+};
+
+static void pnv_adu_register_types(void)
+{
+    type_register_static(&pnv_adu_type_info);
+}
+
+type_init(pnv_adu_register_types);
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index a17816d072..d192bbe2c2 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -75,11 +75,6 @@ static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
     case PRD_P9_IPOLL_REG_MASK:
     case PRD_P9_IPOLL_REG_STATUS:
 
-        /* P9 xscom reset */
-    case 0x0090018:     /* Receive status reg */
-    case 0x0090012:     /* log register */
-    case 0x0090013:     /* error register */
-
         /* P8 xscom reset */
     case 0x2020007:     /* ADU stuff, log register */
     case 0x2020009:     /* ADU stuff, error register */
@@ -119,10 +114,6 @@ static bool xscom_write_default(PnvChip *chip, uint32_t pcba, uint64_t val)
     case 0x1010c03:     /* PIBAM FIR MASK */
     case 0x1010c04:     /* PIBAM FIR MASK */
     case 0x1010c05:     /* PIBAM FIR MASK */
-        /* P9 xscom reset */
-    case 0x0090018:     /* Receive status reg */
-    case 0x0090012:     /* log register */
-    case 0x0090013:     /* error register */
 
         /* P8 xscom reset */
     case 0x2020007:     /* ADU stuff, log register */
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index bf29bbfd4b..1f125ce841 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -95,6 +95,10 @@ vof_write(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] \"%s\""
 vof_avail(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
 vof_claimed(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
 
+# pnv_adu.c
+pnv_adu_xscom_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
+pnv_adu_xscom_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
+
 # pnv_chiptod.c
 pnv_chiptod_xscom_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
 pnv_chiptod_xscom_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
diff --git a/include/hw/ppc/pnv_adu.h b/include/hw/ppc/pnv_adu.h
new file mode 100644
index 0000000000..b5f308627b
--- /dev/null
+++ b/include/hw/ppc/pnv_adu.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of some ADU behaviour
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_PNV_ADU_H
+#define PPC_PNV_ADU_H
+
+#include "hw/ppc/pnv.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_PNV_ADU "pnv-adu"
+
+OBJECT_DECLARE_TYPE(PnvADU, PnvADUClass, PNV_ADU)
+
+struct PnvADU {
+    DeviceState xd;
+
+    MemoryRegion xscom_regs;
+};
+
+#endif /* PPC_PNV_ADU_H */
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index a4ed17ac59..4eaa7d3999 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -2,6 +2,7 @@
 #define PPC_PNV_CHIP_H
 
 #include "hw/pci-host/pnv_phb4.h"
+#include "hw/ppc/pnv_adu.h"
 #include "hw/ppc/pnv_chiptod.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
@@ -77,6 +78,7 @@ struct Pnv9Chip {
     PnvChip      parent_obj;
 
     /*< public >*/
+    PnvADU       adu;
     PnvXive      xive;
     Pnv9Psi      psi;
     PnvLpcController lpc;
@@ -110,6 +112,7 @@ struct Pnv10Chip {
     PnvChip      parent_obj;
 
     /*< public >*/
+    PnvADU       adu;
     PnvXive2     xive;
     Pnv9Psi      psi;
     PnvLpcController lpc;
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 6209e18492..e93d310e79 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -82,6 +82,9 @@ struct PnvXScomInterfaceClass {
 #define PNV_XSCOM_PBCQ_SPCI_BASE  0x9013c00
 #define PNV_XSCOM_PBCQ_SPCI_SIZE  0x5
 
+#define PNV9_XSCOM_ADU_BASE       0x0090000
+#define PNV9_XSCOM_ADU_SIZE       0x55
+
 /*
  * Layout of the XSCOM PCB addresses (POWER 9)
  */
@@ -128,6 +131,9 @@ struct PnvXScomInterfaceClass {
 #define PNV9_XSCOM_PEC_PCI_STK1   0x140
 #define PNV9_XSCOM_PEC_PCI_STK2   0x180
 
+#define PNV10_XSCOM_ADU_BASE      0x0090000
+#define PNV10_XSCOM_ADU_SIZE      0x55
+
 /*
  * Layout of the XSCOM PCB addresses (POWER 10)
  */
-- 
2.45.2


