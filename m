Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188EBCC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqh-0005cE-7V; Tue, 13 Oct 2026 23:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqf-0005UK-N5
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:13 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqd-0001c1-RU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:13 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cd5e6f0a22bso234378a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949210; x=1792554010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8X0yxGerdE0RY1WCD8YB2wnCtyi8HfUekHqNKEcpC0A=;
 b=Pk9F1r+UTXSG2i0El+yfOziOF1jJPgQ4lU5S5H+GUqf+Z4de4A7jAY7xpWdWm3BB08
 8dFnf4cnfJkN6Mb+FwCzHgclEbYZ2d9jQQEyf2gR8JQU7PwF6CWlRfvKgJkTTfznt+bX
 unV4rUvcAgLsHbRMDiV5l08PUXmc5Ks/hUDeMHdo307y3q2nUXjvPquzkSuXKhm1QHOh
 4mMsWTG8c7iSlzuXr2Cz7hJi5bypXIarFSUMGzpCHqQs8tqejdhMghfLNHG8K6kYcFeO
 TQM5qAP9NuPlrVOrrnPyeqBt4B9d+gTKpWNIlYFc+Ildn3W+NeaGzME5zXjhFtaFLamj
 1ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949210; x=1792554010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8X0yxGerdE0RY1WCD8YB2wnCtyi8HfUekHqNKEcpC0A=;
 b=bO/faRSKpvkOlmX+w6nEC/30PvQA0HAnd6NYGJ5rOAGsmDFSgqksHvS3awd8bvYCWW
 eUbT4SJJeq86csk+FO1Hs0O/iMyNENzKWD1il/XbD0mo2pNB0hDSV8ePjObhHaQ/aaHW
 LSiMu1AqrjOHmhWH1CpA9S4wHkrDptAzj5aNAJ0Yk/tqOWaGYyRnKxak0JIDGEH9HusW
 TnB5YTUVb9doqoTUIe/YAqfzDKla+2vCNz/v9WmTS4voJqb2lY3TeIOIK4p1WdQyHKsl
 kte72k80rh4AZiWfGuiU5enYQreCtzbQx8FWpG5hiUHGpbKGWkLcCs2R0+VawfIVr8J/
 ql+A==
X-Gm-Message-State: AFq9FYLSlSXx2MJc9L7oRVmXCGcR0YRKuSgj05E9mMU/pEMSr1lakLRk
 AkJvh2aKCrMbtoKJyW+ZxD0ln9ob9tQMRobp7SvIant42RLN2aOltRpgo4WVIQ==
X-Gm-Gg: AYBFou3mSHPvNbO54w2D6eMNTCiyKokHbHr9Zof8f7SSHOfpzyR6lju/zw0ZqQk1sWb
 55FfiKraKSrnX/vrAszT69HWg1f+H3sgGtYXXjQe/HfV3H2q0MXB2Vzkgk6CWp/zh3IJ0t48Pi3
 sgvluwcnlzMBCcYj8MTlo6lLbQStmxgnuldkwPfewZppQ0DxLKtez/LwIoO9XIByJzUVVxqs0oV
 p8yCgI4GSLRlJFsUvzX0D3xIPuKMe4s5l+AzJ1VFSMQZ5Glxj254Exoi65zIbWFVyAWY9i/qCBZ
 K2vr8lDQz0nSNgSgfcUg3wL9Tr1uxxKYmRJ2TThr8RdEAmFa2J5R+hRl9z0Uykb9+Xai+7/4L8D
 3w133YM5ck/4k4/wyKFcLKdEQQQYzzolHTDuqL//rfcwhIMwhu0hvAregWqgH26uQ026kWnyCQC
 jLfPKLZJc0AWHcCTVpRTC95ODPLUh39JqxEKb8HQqvHle78ujDtZqcj8GT9G6hMmFZyP6aV57wO
 nAm3XvzK9b/K+CJ
X-Received: by 2002:a17:90b:384a:b0:3a8:495b:d65f with SMTP id
 98e67ed59e1d1-3ab3a291837mr13473530a91.5.1791949210352; 
 Tue, 13 Oct 2026 20:40:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/52] hw/misc: Add Sophgo CV1800B clock controller
Date: Wed, 14 Oct 2026 13:38:30 +1000
Message-ID: <20261014033907.3332383-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

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
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260927201326.650943-3-visitorckw@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/misc/cv1800b_clk.h | 26 ++++++++++
 hw/misc/cv1800b_clk.c         | 98 +++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig               |  3 ++
 hw/misc/meson.build           |  1 +
 4 files changed, 128 insertions(+)
 create mode 100644 include/hw/misc/cv1800b_clk.h
 create mode 100644 hw/misc/cv1800b_clk.c

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
 
-- 
2.55.0


