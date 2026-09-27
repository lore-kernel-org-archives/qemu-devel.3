Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4B1C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 20:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAvG1-0008Jb-V1; Sun, 27 Sep 2026 16:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xAvG0-0008JG-NK
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:13:56 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xAvFy-0003YE-Vv
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:13:56 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc78e1a94b8so1267772a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 13:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790540033; x=1791144833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O+o0QDQs82pEiMq4tWdLNS83nyp2jAr6qiX3oWOkdxY=;
 b=se43B9EDe3arP/sn+QmFP0Yc2y2cAmf2wQXTmA/uXDm+uXhuKEcSDHTgTSKOmdAHKh
 r/Z6SzDH4I4RG453DOxq3xFNhN8Sfx95bdNZ2Mryk/vQ5s1kI52l5x/rOg06FJNV7Z1p
 TXlYpJoGbFgD1mzwAAn4ExcM/yUvloc1ElyQ16yGcxy06l4SG5wcXgOiNnmnyS0cs14d
 vcYbmmWIGWJxeRPzOsNShQTrem3/w2XU1T7IZLzAtWsGiNZQT+u0Ip91uXoOR5svYh4K
 SKdfT2TkTcq5TuB6wPXAP3O4yN6rAiPaNiYrRxpjzCxxsPGr9AEQnZTbLwQpY6/WGHKY
 2Bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790540033; x=1791144833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O+o0QDQs82pEiMq4tWdLNS83nyp2jAr6qiX3oWOkdxY=;
 b=hailVzQmHry7RJSJQnc1TICa3Cefm9dHLxPZzgSmCLPeLb2RDCh2yB0ipNU6lUpM++
 HVbAMECGS8RhG1wlirLWVBf5OZNRSyUrKgf5ajK5zy9K5BmxnQIoMutwWdzm/2fVGC/i
 Ol54o7mZo5K65CDIruixm1k9m5tAtUWsZO/quAa4agryAx8WcxO1a0qntJZBns6T0AkR
 XFKAcBFOJIPjK9ltY2sff4DqBM9U3pMTHeXCkCGP76PZwF/BP+bS/J7qP84S4fFbKbDR
 RXjJb49DML7O+YJY0j/SgOIblPbLtMOsEhXgy7Py+9cV4r5HaThw5FdB4gfmKsI6KU83
 qBYA==
X-Forwarded-Encrypted: i=1;
 AKwUvByuoglgbXna9EuNlj2OSKdiwTPD/4lgnIQlZjQ+CPAsQ9csXbCIJikSo76/tHC8NtessadNfH8FEXM/@nongnu.org
X-Gm-Message-State: AFq9FYIGVQcVHOOG5lhERhf3YFfZfJJG0YkhrVgfyryO0I8BlcJ9XN/A
 e9Dj4RoHoxsH7fWYVLQXXjsiaego6xfTVOlS7ddnbqwLSfqsj6fFJN16
X-Gm-Gg: AYBFou3PtZIkUha4xARX5cMVqKrTHLiqXRsrFQ3YdjBjF6phCGHRMB0SakTG9wRe8sB
 VvmIhjH9DAAOdNnKMkfst60uQf6AAZu8MQ+9vfWdSJ45vOyM7S3R+pNo6r9onQHCBmw3gB66A00
 LycZijjaFrq/EXR7dDcjGVm4t9OEOkRWInw8eLapvlH0nVbX4t7gfVNRXozFGzjODx4YjCRZuMY
 bM9+H8r/BrYDj4+LLZLgya8Q9/ca34d35tqQ9frZpitATJXREl7QjB2bSX1fiGj6wNWPAWQlfO2
 LHM7mlIC5YxMHtp9yPEye84wWnLB+uHdx3jZGkpGGdyWfPHedXMJ6FyL8TdiBJs2DFUxzrDV5H7
 eBnLILvYkpswNVskwU7c1xE4AGzL62OEiQP91ciAR/zcjtVzDvkag/8fuqffGN5EVU1IPEWbHLQ
 RX65gjmTymKaOfI4Km0Uy4XG7I1dKwRhcLowaWI2Z3kBpdIyia6Rcavy/Td/duUe7k9sED/GVMl
 0Z0MKc4bc4zzZ1SyKIGQvs1wnSGLviL3HSKZKiW3gPZCADjYlQHPAsoWV0v0r7bKzRN9jzNiw==
X-Received: by 2002:a17:90b:4a45:b0:39e:6c68:c77c with SMTP id
 98e67ed59e1d1-3a098e07a64mr9844412a91.50.1790540033490; 
 Sun, 27 Sep 2026 13:13:53 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0c719f86fsm13932737a91.7.2026.09.27.13.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 13:13:53 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 portias@oss.tenstorrent.com, wxchen0913@gmail.com, jserv@ccns.ncku.edu.tw,
 marscheng@google.com, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 2/7] hw/misc: Add Sophgo CV1800B clock controller
Date: Sun, 27 Sep 2026 20:13:21 +0000
Message-ID: <20260927201326.650943-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260927201326.650943-1-visitorckw@gmail.com>
References: <20260927201326.650943-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=visitorckw@gmail.com; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a stub for the CV1800B clock controller. This is specifically
required for the SDHCI controller to function correctly under Linux.

The Linux 'sophgo,cv1800-clk' driver probes this device to determine
the clock tree configuration. This implementation sets the bypass
registers (CLK_BYP_0 and CLK_BYP_1) to 0xFFFFFFFF during reset,
matching the POR default state. This bypasses the PLLs and allows the
SDHCI and other peripherals to operate using the 25MHz reference clock.

Without this device, the SD card driver fails to initialize, preventing
the system from mounting the root filesystem from the SD card.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 hw/misc/Kconfig               |  3 ++
 hw/misc/cv1800b_clk.c         | 98 +++++++++++++++++++++++++++++++++++
 hw/misc/meson.build           |  1 +
 include/hw/misc/cv1800b_clk.h | 26 ++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 hw/misc/cv1800b_clk.c
 create mode 100644 include/hw/misc/cv1800b_clk.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 46e3c03cc8..7abd22869a 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -263,4 +263,7 @@ config AXIADO_CLK
 config K230_DECOMP_GZIP
     bool
 
+config SOPHGO_CV1800B_CLK
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/cv1800b_clk.c b/hw/misc/cv1800b_clk.c
new file mode 100644
index 0000000000..38807995ac
--- /dev/null
+++ b/hw/misc/cv1800b_clk.c
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Sophgo CV1800B Clock Controller
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/misc/cv1800b_clk.h"
+
+#define REG_BYTE_WIDTH    (sizeof(uint32_t))
+#define REG_CLK_BYP_0     (0x030 / REG_BYTE_WIDTH)
+#define REG_CLK_BYP_1     (0x034 / REG_BYTE_WIDTH)
+
+static uint64_t cv1800b_clk_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    CV1800BClkState *s = opaque;
+    uint32_t val = 0;
+
+    if (addr < CV1800B_CLK_IOSIZE) {
+        val = s->regs[addr / REG_BYTE_WIDTH];
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+    }
+
+    return val;
+}
+
+static void cv1800b_clk_write(void *opaque, hwaddr addr, uint64_t val, unsigned int size)
+{
+    CV1800BClkState *s = opaque;
+
+    if (addr < CV1800B_CLK_IOSIZE) {
+        s->regs[addr / REG_BYTE_WIDTH] = val;
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+    }
+}
+
+static const MemoryRegionOps cv1800b_clk_ops = {
+    .read = cv1800b_clk_read,
+    .write = cv1800b_clk_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void cv1800b_clk_reset_hold(Object *obj, ResetType type)
+{
+    CV1800BClkState *s = CV1800B_CLK(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    /*
+     * TODO: Implement proper PLL state machines.
+     * For now, use POR default to bypass PLLs and boot via 25MHz XTAL.
+     */
+    s->regs[REG_CLK_BYP_0] = 0xFFFFFFFF;
+    s->regs[REG_CLK_BYP_1] = 0xFFFFFFFF;
+}
+
+static void cv1800b_clk_init(Object *obj)
+{
+    CV1800BClkState *s = CV1800B_CLK(obj);
+
+    memory_region_init_io(&s->iomem, obj, &cv1800b_clk_ops, s,
+                            TYPE_CV1800B_CLK, CV1800B_CLK_IOSIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void cv1800b_clk_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = cv1800b_clk_reset_hold;
+}
+
+static const TypeInfo cv1800b_clk_info = {
+    .name = TYPE_CV1800B_CLK,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(CV1800BClkState),
+    .instance_init = cv1800b_clk_init,
+    .class_init = cv1800b_clk_class_init,
+};
+
+static void cv1800b_clk_register_types(void)
+{
+    type_register_static(&cv1800b_clk_info);
+}
+
+type_init(cv1800b_clk_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 9790afa104..244bf278a9 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -39,6 +39,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 system_ss.add(when: 'CONFIG_K230_DECOMP_GZIP', if_true: files('k230_decomp_gzip.c'))
+system_ss.add(when: 'CONFIG_SOPHGO_CV1800B_CLK', if_true: files('cv1800b_clk.c'))
 
 subdir('macio')
 
diff --git a/include/hw/misc/cv1800b_clk.h b/include/hw/misc/cv1800b_clk.h
new file mode 100644
index 0000000000..4d03d887c6
--- /dev/null
+++ b/include/hw/misc/cv1800b_clk.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Sophgo CV1800B Clock Controller
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef HW_MISC_CV1800B_CLK_H
+#define HW_MISC_CV1800B_CLK_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_CV1800B_CLK "cv1800b-clk"
+OBJECT_DECLARE_SIMPLE_TYPE(CV1800BClkState, CV1800B_CLK)
+
+#define CV1800B_CLK_IOSIZE 0x1000
+
+struct CV1800BClkState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t regs[CV1800B_CLK_IOSIZE / sizeof(uint32_t)];
+};
+
+#endif
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


