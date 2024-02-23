Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B0BC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXuQ-0004aV-7O; Fri, 23 Feb 2024 10:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjs-0006No-PD; Fri, 23 Feb 2024 10:45:29 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjn-0006dD-CW; Fri, 23 Feb 2024 10:45:28 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d731314e67so6538865ad.1; 
 Fri, 23 Feb 2024 07:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703113; x=1709307913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tR7VHudZ+KVZ9cANgf/arvpv21I2fheZnaGBvs2/zEo=;
 b=fx/rZgi7TD9HACRfPmg5l85+Sh6rd53OZL1Z1x8Q66zBLIwankk2cHj3DMFO2pKKwi
 Hj3KevcuIWkYI6Z851pYbflnjrQxEL7pb3KaLqpLWIdq+z57D1JlAUuJ4ZR5MHyujPPW
 BMWA776DfhkIlzAJXm3/7SwxK7pGOFsAZZPNK2v8CYyUZX4RnmmQkaYnVsxXVthVkYm3
 yKzjQ2/+Yz5G46k5aNuy6ZFtUtMdeAztMKHdB3oEolm1kTOg3aZR6Qz6g0iMmeUqqWhg
 ZqFEhnJll27hhMaICd+mcFzLdeMJjwM1FwqENWwZr2D7OiE2mEw3e8ouoxnIRadUb/DN
 BIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703113; x=1709307913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tR7VHudZ+KVZ9cANgf/arvpv21I2fheZnaGBvs2/zEo=;
 b=vMr5Yo2UhrF+kP6U8QqBWG3JJ16/5s5asc12vbKy6NZVYQ/qnZfdxpoBQUCpd0J4Bm
 +5RSOMbM+yHDReOHHdEjrs7goj3noqTlbgv/VffAshglAdj61rZsPmrUhsRfobV/lzEf
 /yhx0JUmMhvxjHRPQ8Wlxb2WdA+/yRVuIDAApuNWtGD9PU2ownfk4HwWC9TU2DodBv3j
 O7lM9n+Z18bjkG9+GPcYYb5gp9QYHldmrD81pxseHcJYM80J42pghTNHFnaWdG8qDUfZ
 26EugwDn0ewhsBRSXmYq5J6fn8x73QCphj1iWXP8yh0UQAM81cUrcs0hFQ4AikyMzs6E
 JjPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8wPsTmDWsrgjD8B5k4YAoNuZM7DP4jO3okizZ6JKD84uyabmxZ7XV/Nkf7sTka31ZkJPdrkWf2FBft0kjRod+OrUI
X-Gm-Message-State: AOJu0YylRxhVNTMOEUB4d7xmiu/8r6dC4aa1ygIODuuIfNYtC17Ug5t1
 SmA6C9bGF/h4Q+9ZlL2BmSa5kHn1kDAuDFmuiJnKuwimQ38rhcPSiCwhFNfV
X-Google-Smtp-Source: AGHT+IFRFFvYI/aEXzt7LxtRlk1vtW1dHKVjkIrd4k1TqBdEznL3X8N3cPXJeE1r7SFpmEo+Nc4iqw==
X-Received: by 2002:a17:902:f54e:b0:1db:e41f:bc0 with SMTP id
 h14-20020a170902f54e00b001dbe41f0bc0mr198588plf.30.1708703113536; 
 Fri, 23 Feb 2024 07:45:13 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:45:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PULL 31/47] hw/ppc: Add N1 chiplet model
Date: Sat, 24 Feb 2024 01:41:50 +1000
Message-ID: <20240223154211.1001692-32-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

The N1 chiplet handle the high speed i/o traffic over PCIe and others.
The N1 chiplet consists of PowerBus Fabric controller,
nest Memory Management Unit, chiplet control unit and more.

This commit creates a N1 chiplet model and initialize and realize the
pervasive chiplet model where chiplet control registers are implemented.

This commit also implement the read/write method for the powerbus scom
registers

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/meson.build              |   1 +
 hw/ppc/pnv_n1_chiplet.c         | 173 ++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_n1_chiplet.h |  32 ++++++
 include/hw/ppc/pnv_xscom.h      |   6 ++
 4 files changed, 212 insertions(+)
 create mode 100644 hw/ppc/pnv_n1_chiplet.c
 create mode 100644 include/hw/ppc/pnv_n1_chiplet.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 960ff52dfe..3717d74760 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -54,6 +54,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_homer.c',
   'pnv_pnor.c',
   'pnv_nest_pervasive.c',
+  'pnv_n1_chiplet.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
diff --git a/hw/ppc/pnv_n1_chiplet.c b/hw/ppc/pnv_n1_chiplet.c
new file mode 100644
index 0000000000..03ff9fbad0
--- /dev/null
+++ b/hw/ppc/pnv_n1_chiplet.c
@@ -0,0 +1,173 @@
+/*
+ * QEMU PowerPC N1 chiplet model
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
+#include "hw/ppc/pnv_n1_chiplet.h"
+#include "hw/ppc/pnv_nest_pervasive.h"
+
+/*
+ * The n1 chiplet contains chiplet control unit,
+ * PowerBus/RaceTrack/Bridge logic, nest Memory Management Unit(nMMU)
+ * and more.
+ *
+ * In this model Nest1 chiplet control registers are modelled via common
+ * nest pervasive model and few PowerBus racetrack registers are modelled.
+ */
+
+#define PB_SCOM_EQ0_HP_MODE2_CURR      0xe
+#define PB_SCOM_ES3_MODE               0x8a
+
+static uint64_t pnv_n1_chiplet_pb_scom_eq_read(void *opaque, hwaddr addr,
+                                                  unsigned size)
+{
+    PnvN1Chiplet *n1_chiplet = PNV_N1_CHIPLET(opaque);
+    uint32_t reg = addr >> 3;
+    uint64_t val = ~0ull;
+
+    switch (reg) {
+    case PB_SCOM_EQ0_HP_MODE2_CURR:
+        val = n1_chiplet->eq[0].hp_mode2_curr;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom read at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+    return val;
+}
+
+static void pnv_n1_chiplet_pb_scom_eq_write(void *opaque, hwaddr addr,
+                                               uint64_t val, unsigned size)
+{
+    PnvN1Chiplet *n1_chiplet = PNV_N1_CHIPLET(opaque);
+    uint32_t reg = addr >> 3;
+
+    switch (reg) {
+    case PB_SCOM_EQ0_HP_MODE2_CURR:
+        n1_chiplet->eq[0].hp_mode2_curr = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom write at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+}
+
+static const MemoryRegionOps pnv_n1_chiplet_pb_scom_eq_ops = {
+    .read = pnv_n1_chiplet_pb_scom_eq_read,
+    .write = pnv_n1_chiplet_pb_scom_eq_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static uint64_t pnv_n1_chiplet_pb_scom_es_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    PnvN1Chiplet *n1_chiplet = PNV_N1_CHIPLET(opaque);
+    uint32_t reg = addr >> 3;
+    uint64_t val = ~0ull;
+
+    switch (reg) {
+    case PB_SCOM_ES3_MODE:
+        val = n1_chiplet->es[3].mode;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom read at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+    return val;
+}
+
+static void pnv_n1_chiplet_pb_scom_es_write(void *opaque, hwaddr addr,
+                                               uint64_t val, unsigned size)
+{
+    PnvN1Chiplet *n1_chiplet = PNV_N1_CHIPLET(opaque);
+    uint32_t reg = addr >> 3;
+
+    switch (reg) {
+    case PB_SCOM_ES3_MODE:
+        n1_chiplet->es[3].mode = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom write at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+}
+
+static const MemoryRegionOps pnv_n1_chiplet_pb_scom_es_ops = {
+    .read = pnv_n1_chiplet_pb_scom_es_read,
+    .write = pnv_n1_chiplet_pb_scom_es_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_n1_chiplet_realize(DeviceState *dev, Error **errp)
+{
+    PnvN1Chiplet *n1_chiplet = PNV_N1_CHIPLET(dev);
+
+    /* Realize nest pervasive common chiplet model */
+    if (!qdev_realize(DEVICE(&n1_chiplet->nest_pervasive), NULL, errp)) {
+        return;
+    }
+
+    /* Nest1 chiplet power bus EQ xscom region */
+    pnv_xscom_region_init(&n1_chiplet->xscom_pb_eq_mr, OBJECT(n1_chiplet),
+                          &pnv_n1_chiplet_pb_scom_eq_ops, n1_chiplet,
+                          "xscom-n1-chiplet-pb-scom-eq",
+                          PNV10_XSCOM_N1_PB_SCOM_EQ_SIZE);
+
+    /* Nest1 chiplet power bus ES xscom region */
+    pnv_xscom_region_init(&n1_chiplet->xscom_pb_es_mr, OBJECT(n1_chiplet),
+                          &pnv_n1_chiplet_pb_scom_es_ops, n1_chiplet,
+                          "xscom-n1-chiplet-pb-scom-es",
+                          PNV10_XSCOM_N1_PB_SCOM_ES_SIZE);
+}
+
+static void pnv_n1_chiplet_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV n1 chiplet";
+    dc->realize = pnv_n1_chiplet_realize;
+}
+
+static void pnv_n1_chiplet_instance_init(Object *obj)
+{
+    PnvN1Chiplet *n1_chiplet = PNV_N1_CHIPLET(obj);
+
+    object_initialize_child(OBJECT(n1_chiplet), "nest-pervasive-common",
+                            &n1_chiplet->nest_pervasive,
+                            TYPE_PNV_NEST_CHIPLET_PERVASIVE);
+}
+
+static const TypeInfo pnv_n1_chiplet_info = {
+    .name          = TYPE_PNV_N1_CHIPLET,
+    .parent        = TYPE_DEVICE,
+    .instance_init = pnv_n1_chiplet_instance_init,
+    .instance_size = sizeof(PnvN1Chiplet),
+    .class_init    = pnv_n1_chiplet_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_n1_chiplet_register_types(void)
+{
+    type_register_static(&pnv_n1_chiplet_info);
+}
+
+type_init(pnv_n1_chiplet_register_types);
diff --git a/include/hw/ppc/pnv_n1_chiplet.h b/include/hw/ppc/pnv_n1_chiplet.h
new file mode 100644
index 0000000000..a7ad039668
--- /dev/null
+++ b/include/hw/ppc/pnv_n1_chiplet.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU PowerPC N1 chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_PNV_N1_CHIPLET_H
+#define PPC_PNV_N1_CHIPLET_H
+
+#include "hw/ppc/pnv_nest_pervasive.h"
+
+#define TYPE_PNV_N1_CHIPLET "pnv-N1-chiplet"
+#define PNV_N1_CHIPLET(obj) OBJECT_CHECK(PnvN1Chiplet, (obj), TYPE_PNV_N1_CHIPLET)
+
+typedef struct PnvPbScom {
+    uint64_t mode;
+    uint64_t hp_mode2_curr;
+} PnvPbScom;
+
+typedef struct PnvN1Chiplet {
+    DeviceState  parent;
+    MemoryRegion xscom_pb_eq_mr;
+    MemoryRegion xscom_pb_es_mr;
+    PnvNestChipletPervasive nest_pervasive; /* common pervasive chiplet unit */
+#define PNV_PB_SCOM_EQ_SIZE 8
+    PnvPbScom eq[PNV_PB_SCOM_EQ_SIZE];
+#define PNV_PB_SCOM_ES_SIZE 4
+    PnvPbScom es[PNV_PB_SCOM_ES_SIZE];
+} PnvN1Chiplet;
+#endif /*PPC_PNV_N1_CHIPLET_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 3e15706dec..535ae1dab0 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -173,6 +173,12 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_N1_CHIPLET_CTRL_REGS_BASE      0x3000000
 #define PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE         0x400
 
+#define PNV10_XSCOM_N1_PB_SCOM_EQ_BASE      0x3011000
+#define PNV10_XSCOM_N1_PB_SCOM_EQ_SIZE      0x200
+
+#define PNV10_XSCOM_N1_PB_SCOM_ES_BASE      0x3011300
+#define PNV10_XSCOM_N1_PB_SCOM_ES_SIZE      0x100
+
 #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
 #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
 
-- 
2.42.0


