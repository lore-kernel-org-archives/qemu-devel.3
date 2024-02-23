Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCB9C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY22-0007il-QK; Fri, 23 Feb 2024 11:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjr-0006Nh-AT; Fri, 23 Feb 2024 10:45:29 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXje-0006cn-6F; Fri, 23 Feb 2024 10:45:25 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d71cb97937so10855695ad.3; 
 Fri, 23 Feb 2024 07:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703110; x=1709307910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FstwICvvGHScc+3neWLPudxsd19KZI+fUQactKWBV8w=;
 b=ll3RIozOYF9t/jYC3pGvo8WM9Ss2VnDgrR6rLOHAPJhf3KMG1fakJQ8moiYCnrrbBC
 vwyRuT4kVb4f/vtkajufTROoQY/zdtiamUiM0eeggxAzBw3O26aWNLB73cAh76XvHM+T
 VTuxyU/aEFYX47m9ZdFzMuwB8Nf71P0516OqBiF2MTDj5PU2zuprviCPnRruRAVtYjQL
 hUJrRRVJbTMyrJTFvmea6niG3tmECtWOkd6cTAZubyP393yNi5AvIzHbSqPtiEvs0ZkX
 ZskZQB3TO12O6QQUexVEX911jQtIGbPJu85Gg5B0zocU4K604q961ac5MCZExPYLcDTm
 f61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703110; x=1709307910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FstwICvvGHScc+3neWLPudxsd19KZI+fUQactKWBV8w=;
 b=JqsZgfwlW7iq5lldLcTG9J7PDDKBg4A1VFzDBEhae5bX6okT8XIryu6a2XzsxB95X0
 +WwXyHBu59w2dbO2iCX3j8XtKV4ED+ghlHHAgtO+HBEtsns5Yu80UssGAwBWJQUVLHgB
 VJh5K2hk3N9MBsD6OHK04ajRAV6Axxp4a5EcQnqR77Dq6Q481aVz6RJlSUZ7RPCyQrU/
 +9JOK51cA+wbwShMOkvRCJr3+PVI6NCdEmVUqUzEV3TM+gcKDVu4380yYWpDf0P8Kql8
 ZyQCG8XuPONkf/miDoKXQLFC1jY4n1BtovW2kNsXBEgtbFcDA8hKF/GrWXu9aG2EWi1X
 ZT9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqgUoI1j0QzeXybQ4rQhkVZbm30hKMJuJCvLgQQ0kr9EZbdVrPR0z9pVjBWGM/SSytaetIBajFBGSPxHwF8+b5ihEn
X-Gm-Message-State: AOJu0Yy4wU91z/6EtRMhLkMYitF+mFGqtLTUzDoIgukrKRoGnVH6xk1i
 b9V7828ZGEdiDAz/N8G2hERybwSArXdONUtIjKGh7pUJ/zPkkQYbML56e5Rx
X-Google-Smtp-Source: AGHT+IEs+zEpQDq4EUKmjaGMsZSWtbkGakCGPv8/ioLAL8xFiN4Rgm9mJ2tNJ7HD2k4eaZtirHyq7A==
X-Received: by 2002:a17:902:db04:b0:1dc:65ee:38d1 with SMTP id
 m4-20020a170902db0400b001dc65ee38d1mr199856plx.49.1708703109793; 
 Fri, 23 Feb 2024 07:45:09 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:45:09 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PULL 30/47] hw/ppc: Add pnv nest pervasive common chiplet model
Date: Sat, 24 Feb 2024 01:41:49 +1000
Message-ID: <20240223154211.1001692-31-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

A POWER10 chip is divided into logical units called chiplets. Chiplets
are broadly divided into "core chiplets" (with the processor cores) and
"nest chiplets" (with everything else). Each chiplet has an attachment
to the pervasive bus (PIB) and with chiplet-specific registers. All nest
chiplets have a common basic set of registers and This model will provide
the registers functionality for common registers of nest chiplet (Pervasive
Chiplet, PB Chiplet, PCI Chiplets, MC Chiplet, PAU Chiplets)

This commit implement the read/write functions of chiplet control registers.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/meson.build                  |   1 +
 hw/ppc/pnv_nest_pervasive.c         | 208 ++++++++++++++++++++++++++++
 include/hw/ppc/pnv_nest_pervasive.h |  32 +++++
 include/hw/ppc/pnv_xscom.h          |   3 +
 4 files changed, 244 insertions(+)
 create mode 100644 hw/ppc/pnv_nest_pervasive.c
 create mode 100644 include/hw/ppc/pnv_nest_pervasive.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 15d13e649d..960ff52dfe 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -53,6 +53,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_bmc.c',
   'pnv_homer.c',
   'pnv_pnor.c',
+  'pnv_nest_pervasive.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
new file mode 100644
index 0000000000..77476753a4
--- /dev/null
+++ b/hw/ppc/pnv_nest_pervasive.c
@@ -0,0 +1,208 @@
+/*
+ * QEMU PowerPC nest pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_nest_pervasive.h"
+
+/*
+ * Status, configuration, and control units in POWER chips is provided
+ * by the pervasive subsystem, which connects registers to the SCOM bus,
+ * which can be programmed by processor cores, other units on the chip,
+ * BMCs, or other POWER chips.
+ *
+ * A POWER10 chip is divided into logical units called chiplets. Chiplets
+ * are broadly divided into "core chiplets" (with the processor cores) and
+ * "nest chiplets" (with everything else). Each chiplet has an attachment
+ * to the pervasive bus (PIB) and with chiplet-specific registers.
+ * All nest chiplets have a common basic set of registers.
+ *
+ * This model will provide the registers functionality for common registers of
+ * nest unit (PB Chiplet, PCI Chiplets, MC Chiplet, PAU Chiplets)
+ *
+ * Currently this model provide the read/write functionality of chiplet control
+ * scom registers.
+ */
+
+#define CPLT_CONF0               0x08
+#define CPLT_CONF0_OR            0x18
+#define CPLT_CONF0_CLEAR         0x28
+#define CPLT_CONF1               0x09
+#define CPLT_CONF1_OR            0x19
+#define CPLT_CONF1_CLEAR         0x29
+#define CPLT_STAT0               0x100
+#define CPLT_MASK0               0x101
+#define CPLT_PROTECT_MODE        0x3FE
+#define CPLT_ATOMIC_CLOCK        0x3FF
+
+static uint64_t pnv_chiplet_ctrl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_CHIPLET_PERVASIVE(
+                                              opaque);
+    uint32_t reg = addr >> 3;
+    uint64_t val = ~0ull;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i < PNV_CPLT_CTRL_SIZE; i++) {
+        if (reg == i) {
+            return nest_pervasive->control_regs.cplt_ctrl[i];
+        } else if ((reg == (i + 0x10)) || (reg == (i + 0x20))) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                           "xscom read at 0x%" PRIx32 "\n",
+                                           __func__, reg);
+            return val;
+        }
+    }
+
+    switch (reg) {
+    case CPLT_CONF0:
+        val = nest_pervasive->control_regs.cplt_cfg0;
+        break;
+    case CPLT_CONF0_OR:
+    case CPLT_CONF0_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%" PRIx32 "\n",
+                                   __func__, reg);
+        break;
+    case CPLT_CONF1:
+        val = nest_pervasive->control_regs.cplt_cfg1;
+        break;
+    case CPLT_CONF1_OR:
+    case CPLT_CONF1_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%" PRIx32 "\n",
+                                   __func__, reg);
+        break;
+    case CPLT_STAT0:
+        val = nest_pervasive->control_regs.cplt_stat0;
+        break;
+    case CPLT_MASK0:
+        val = nest_pervasive->control_regs.cplt_mask0;
+        break;
+    case CPLT_PROTECT_MODE:
+        val = nest_pervasive->control_regs.ctrl_protect_mode;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        val = nest_pervasive->control_regs.ctrl_atomic_lock;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                 "read at 0x%" PRIx32 "\n", __func__, reg);
+    }
+    return val;
+}
+
+static void pnv_chiplet_ctrl_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_CHIPLET_PERVASIVE(
+                                              opaque);
+    uint32_t reg = addr >> 3;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i < PNV_CPLT_CTRL_SIZE; i++) {
+        if (reg == i) {
+            nest_pervasive->control_regs.cplt_ctrl[i] = val;
+            return;
+        } else if (reg == (i + 0x10)) {
+            nest_pervasive->control_regs.cplt_ctrl[i] |= val;
+            return;
+        } else if (reg == (i + 0x20)) {
+            nest_pervasive->control_regs.cplt_ctrl[i] &= ~val;
+            return;
+        }
+    }
+
+    switch (reg) {
+    case CPLT_CONF0:
+        nest_pervasive->control_regs.cplt_cfg0 = val;
+        break;
+    case CPLT_CONF0_OR:
+        nest_pervasive->control_regs.cplt_cfg0 |= val;
+        break;
+    case CPLT_CONF0_CLEAR:
+        nest_pervasive->control_regs.cplt_cfg0 &= ~val;
+        break;
+    case CPLT_CONF1:
+        nest_pervasive->control_regs.cplt_cfg1 = val;
+        break;
+    case CPLT_CONF1_OR:
+        nest_pervasive->control_regs.cplt_cfg1 |= val;
+        break;
+    case CPLT_CONF1_CLEAR:
+        nest_pervasive->control_regs.cplt_cfg1 &= ~val;
+        break;
+    case CPLT_STAT0:
+        nest_pervasive->control_regs.cplt_stat0 = val;
+        break;
+    case CPLT_MASK0:
+        nest_pervasive->control_regs.cplt_mask0 = val;
+        break;
+    case CPLT_PROTECT_MODE:
+        nest_pervasive->control_regs.ctrl_protect_mode = val;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        nest_pervasive->control_regs.ctrl_atomic_lock = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                                 "write at 0x%" PRIx32 "\n",
+                                 __func__, reg);
+    }
+}
+
+static const MemoryRegionOps pnv_nest_pervasive_control_xscom_ops = {
+    .read = pnv_chiplet_ctrl_read,
+    .write = pnv_chiplet_ctrl_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_nest_pervasive_realize(DeviceState *dev, Error **errp)
+{
+    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_CHIPLET_PERVASIVE(dev);
+
+    /* Chiplet control scoms */
+    pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs_mr,
+                          OBJECT(nest_pervasive),
+                          &pnv_nest_pervasive_control_xscom_ops,
+                          nest_pervasive, "pervasive-control",
+                          PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE);
+}
+
+static void pnv_nest_pervasive_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV nest pervasive chiplet";
+    dc->realize = pnv_nest_pervasive_realize;
+}
+
+static const TypeInfo pnv_nest_pervasive_info = {
+    .name          = TYPE_PNV_NEST_CHIPLET_PERVASIVE,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvNestChipletPervasive),
+    .class_init    = pnv_nest_pervasive_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_nest_pervasive_register_types(void)
+{
+    type_register_static(&pnv_nest_pervasive_info);
+}
+
+type_init(pnv_nest_pervasive_register_types);
diff --git a/include/hw/ppc/pnv_nest_pervasive.h b/include/hw/ppc/pnv_nest_pervasive.h
new file mode 100644
index 0000000000..73cacf3823
--- /dev/null
+++ b/include/hw/ppc/pnv_nest_pervasive.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU PowerPC nest pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_PNV_NEST_CHIPLET_PERVASIVE_H
+#define PPC_PNV_NEST_CHIPLET_PERVASIVE_H
+
+#define TYPE_PNV_NEST_CHIPLET_PERVASIVE "pnv-nest-chiplet-pervasive"
+#define PNV_NEST_CHIPLET_PERVASIVE(obj) OBJECT_CHECK(PnvNestChipletPervasive, (obj), TYPE_PNV_NEST_CHIPLET_PERVASIVE)
+
+typedef struct PnvPervasiveCtrlRegs {
+#define PNV_CPLT_CTRL_SIZE 6
+    uint64_t cplt_ctrl[PNV_CPLT_CTRL_SIZE];
+    uint64_t cplt_cfg0;
+    uint64_t cplt_cfg1;
+    uint64_t cplt_stat0;
+    uint64_t cplt_mask0;
+    uint64_t ctrl_protect_mode;
+    uint64_t ctrl_atomic_lock;
+} PnvPervasiveCtrlRegs;
+
+typedef struct PnvNestChipletPervasive {
+    DeviceState             parent;
+    MemoryRegion            xscom_ctrl_regs_mr;
+    PnvPervasiveCtrlRegs    control_regs;
+} PnvNestChipletPervasive;
+
+#endif /*PPC_PNV_NEST_CHIPLET_PERVASIVE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f5becbab41..3e15706dec 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -170,6 +170,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_XIVE2_BASE     0x2010800
 #define PNV10_XSCOM_XIVE2_SIZE     0x400
 
+#define PNV10_XSCOM_N1_CHIPLET_CTRL_REGS_BASE      0x3000000
+#define PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE         0x400
+
 #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
 #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
 
-- 
2.42.0


