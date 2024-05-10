Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B187DC25B5F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 14:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5R1o-0003qW-8c; Fri, 10 May 2024 10:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s5R1b-0003Zg-1r; Fri, 10 May 2024 10:15:04 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s5R1Y-0000gU-QB; Fri, 10 May 2024 10:15:02 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-36c947ff642so9451085ab.2; 
 Fri, 10 May 2024 07:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715350499; x=1715955299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLcRad/UaY7WQoH8kVriTBOM/SGuqjjEI6ImDFW9HH4=;
 b=MwIpksjfkKP0JK+VpT1xBrR6sOUvylrj+77hAlLrHabBhrCwY80Hri6nrUFzf4u2lj
 UGr2agyl14GIRueAu+yTLug1ELVtYZSjI3c6a37Hujtiq9GtZ5KuiRXdFZhs0LAdI3jJ
 ry6Aj5r5dw1CEUUCXPzcnK5N7nvAY5vBU5/aVdL6td33sQngbh9Te7GHs8oMCfOUDbV3
 us/O1yxWP+qk0QXPQwaW49EsavQfN2BW+3PUjJe6nDbjUZCU9cUdR8BsKtYMOFOgzfy1
 yOrKxlO4S2dCNFehLugOp2QczJprrPsdGjKjl5143WaVXTzTKXVa4XA72x+iLHJ9SK0H
 /zeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715350499; x=1715955299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLcRad/UaY7WQoH8kVriTBOM/SGuqjjEI6ImDFW9HH4=;
 b=L297v2bDQUsPSNB3MrU9w1cTU1P9XBKuQ7NcINPyq1IQtwszRoqHEDpm5Vge7g5UIB
 aXUfZYsK95HktQk6Z4Z7dhNex8uxZbNgpJYxJQsRyGEywJNg6SHS6OtlvlVY1n8Io655
 ZydHpMvdugXLKgawie98CZ2RyL9NI3jJdk5b93tjsDLHRKE+traySPVm4AHdGphpqSNp
 Z99DUjbHHgKUa08gLNUE3JRlzEVbKjc0wtVrf1AjCxzV6C3zwe2TNeXnEL4ssCYA9WHf
 OfNChWzNTLjOH7Gz/xAWqRPT635Yyzp5luLr3tK0ecMkgNLLnrv62sdqv53fXQDVewe8
 J/rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7OdfzTqAx3umIVszdJLZ2AlJu8oF0yRhT9mREdAuM95Y4w5g7IT0PvX2TAdazbvJXVNi8VfgIF2AIXtYIHv9oZFIlHXg=
X-Gm-Message-State: AOJu0Yy0n3RP5v2U8p3tuBtKM/AN7vq2Je5kUI83Wr46xDmAtTF6Kv3k
 MURxxKitKXw4uqL5oDbcfsLAuolVYcbHX1QiAqWo0RNk876gnAFauAEODg==
X-Google-Smtp-Source: AGHT+IEP0RJq+EIJ/DfZluIKE/RbJgmGKreX2as+P0KoBBW1OWTBlcE33hczjHCZP9GsZ3Ngn9RdUQ==
X-Received: by 2002:a05:6e02:1c84:b0:36c:f0b:4f54 with SMTP id
 e9e14a558f8ab-36cc14e788cmr32173305ab.21.1715350498660; 
 Fri, 10 May 2024 07:14:58 -0700 (PDT)
Received: from wheely.local0.net (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340a632725sm2691453a12.12.2024.05.10.07.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 07:14:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v2 1/2] ppc/pnv: Begin a more complete ADU LPC model for
 POWER9/10
Date: Sat, 11 May 2024 00:14:44 +1000
Message-ID: <20240510141446.108360-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510141446.108360-1-npiggin@gmail.com>
References: <20240510141446.108360-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12c.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_adu.h   |  25 +++++++++
 include/hw/ppc/pnv_chip.h  |   3 +
 include/hw/ppc/pnv_xscom.h |   6 ++
 hw/ppc/pnv.c               |  16 ++++++
 hw/ppc/pnv_adu.c           | 111 +++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_xscom.c         |   9 ---
 hw/ppc/meson.build         |   1 +
 hw/ppc/trace-events        |   4 ++
 8 files changed, 166 insertions(+), 9 deletions(-)
 create mode 100644 include/hw/ppc/pnv_adu.h
 create mode 100644 hw/ppc/pnv_adu.c

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
index 8589f3291e..96e50a2983 100644
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6e3a5ccdec..5869aac89a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1530,6 +1530,7 @@ static void pnv_chip_power9_instance_init(Object *obj)
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
     int i;
 
+    object_initialize_child(obj, "adu",  &chip9->adu, TYPE_PNV_ADU);
     object_initialize_child(obj, "xive", &chip9->xive, TYPE_PNV_XIVE);
     object_property_add_alias(obj, "xive-fabric", OBJECT(&chip9->xive),
                               "xive-fabric");
@@ -1640,6 +1641,13 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
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
@@ -1806,6 +1814,7 @@ static void pnv_chip_power10_instance_init(Object *obj)
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
     int i;
 
+    object_initialize_child(obj, "adu",  &chip10->adu, TYPE_PNV_ADU);
     object_initialize_child(obj, "xive", &chip10->xive, TYPE_PNV_XIVE2);
     object_property_add_alias(obj, "xive-fabric", OBJECT(&chip10->xive),
                               "xive-fabric");
@@ -1898,6 +1907,13 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
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
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index d096636ee7..932ade7b21 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -44,6 +44,7 @@ endif
 ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv.c',
   'pnv_xscom.c',
+  'pnv_adu.c',
   'pnv_core.c',
   'pnv_i2c.c',
   'pnv_lpc.c',
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
-- 
2.43.0


