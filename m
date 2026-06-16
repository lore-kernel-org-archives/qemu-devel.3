Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E738DCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ3b-0001N7-QR; Tue, 16 Jun 2026 15:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wZZ3F-0001Ip-7W
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:02:23 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wZZ3D-0007Xs-0A
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:02:20 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8423efd76c8so3479678b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781636537; x=1782241337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtZHJYs4y8GGzzuEv2+NJvd5rh17mqoIqozIZanSFuA=;
 b=V7Yi5ilB1vLACKgp13fiFnN23OsCvf0dVEfeus2zglEB8krlxK07KKGxB66wc821v1
 KnjKdg6qnPJG/z1EJ8bByp6Z5xOkMeavbOcQVc86X90/KKrkS6NuvJSrRrvtVH994AxT
 QpAvBXisTOe45in8jqDDUVGxr3/FX/daASRNP7OJ7henpv6tmraCRIsQhBI79uHniEtc
 uin4CInMgdJ6mGkebAw1iopypgsFfuesDjla6E5tmsd6h2YAghf8MnSmX+IkHnPd2AZa
 kIuqXidFXdjeRs7MXy9PdiXErsvg1hAU9faxjy24ujU5GTenJpNfbAfwnM0+RQyA1WYJ
 eENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636537; x=1782241337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FtZHJYs4y8GGzzuEv2+NJvd5rh17mqoIqozIZanSFuA=;
 b=GBpkTMHwjW43tQWfVOUVPp5HgZiEXBk62S0pCqFX7CfIHkFeqYolCyLnuck7p9Ai2/
 ac5zAqxKYCMLuce5+++ZKzxaTNNFDqnTT2mKdJitI9E0t9XYVK2CnsWfcaZeWY3WeUCS
 iGH+zoGVbGZYjHTPmtydBnCgtFOq01GDANeum2X3rmUrKRvttZ0bth53Cd6ukm9PpaLU
 eAeUr2x/vpTADjKtofMbP/myZUFXop+U0EuojdFZE1CAW0b1XNKny6l0h4e3g9sUSw4J
 zIp/yboPQnMxoFeni2izfgj3c3XpCF4pOmi6VMQVBIKd6QeUKGYOkX3qejPzVaUlCMHs
 nUyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9aME52JG5mP8593imxy5Ar4M8ZioB0YYgDPHddXE/a4ENWpAG5cF48wy0Ut8MMgpdWQRcYfWXXVdvy@nongnu.org
X-Gm-Message-State: AOJu0YzrCdoptEfNXin+JAOFZ08rl8U2SMk6jSOTjKIphGkSFwz/YOtH
 ICZC2w+PEZ6k1Yzmnjbyx28AFJNRgq1fcBQqu3Wayhvd0sKkWvzSxr0f
X-Gm-Gg: Acq92OEbrDwSz9brJETF6mnwQe9/bfY4MjQbVH6sNjK6wr4qZkcVmobo5OxbPtU8Ot/
 mVoxGohFSjap6QB4CCLYaNXzkVFTu3cr0yuQ7fc5MZtgMCMu/c3nJnFx48tdKbqc2n+yUR+oZkP
 dmfBFcLrvl/rJpKNCI/TDfhB0pHJDa0c+Wd24nULP8uSq+eOBHd1WvVsj3FOkNKjCAFRIu/bhKX
 mF8+3UIwebTYkYGdVODfFMYJY7eWL9zvL0GQz5QDBP4RN81MbAARhKODhY6BYNTcRakfudxWmWk
 mHABULfH67kuHMzaAFasrpsD79srnJ0U40Uu5aCuRMDmIo83/8KaKL8tYiV6bBBtzS72gKu7ONm
 8+BmHPuc6Jws7A8O6mL3T++LYX73YTLWkDkTVKCL5YzWqG1hneaI+rm8cvUMijBwXdD+YsGf5lO
 Svo4XSub8ciLRYmoWw47b0AJOgVQq3Ub8ktWqrssN2+guP5kMjYOaYH0D7Qd8uqEV0bga2j6nBs
 bKvxnnP0GQh2JQsx51QMAM=
X-Received: by 2002:a05:6a00:138f:b0:842:7867:430b with SMTP id
 d2e1a72fcca58-84524556180mr406435b3a.29.1781636537461; 
 Tue, 16 Jun 2026 12:02:17 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c474sm12671540b3a.2.2026.06.16.12.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:02:16 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair.francis@wdc.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 2/5] hw/misc: Add Sophgo CV1800B clock controller
Date: Tue, 16 Jun 2026 19:01:44 +0000
Message-ID: <20260616190147.1286316-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616190147.1286316-1-visitorckw@gmail.com>
References: <20260616190147.1286316-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x430.google.com
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

Add a stub for the CV1800B clock controller. This is specifically
required for the SDHCI controller to function correctly under Linux.

The Linux 'sophgo,cv1800-clk' driver probes this device to determine
the clock tree configuration. This implementation sets the bypass
registers (CLK_BYP_0 and CLK_BYP_1) to 0xFFFFFFFF during reset,
matching the POR default state. This bypasses the PLLs and allows the
SDHCI and other peripherals to operate using the 25MHz reference clock.

Without this device, the SD card driver fails to initialize, preventing
the system from mounting the root filesystem from the SD card:

[    0.888739] Waiting for root device /dev/mmcblk0...
[   10.727739] mmc0: Timeout waiting for hardware cmd interrupt.
[   10.728042] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[   10.728356] mmc0: sdhci: Sys addr:  0x00000002 | Version:  0x00002402
[   10.728618] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
[   10.728919] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
[   10.729271] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000001
[   10.729591] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[   10.729903] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000000
[   10.730223] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
[   10.730537] mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
[   10.730795] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[   10.731005] mmc0: sdhci: Caps:      0x056900b9 | Caps_1:   0x00000000
[   10.731211] mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x00000000
[   10.731415] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
[   10.731636] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[   10.731851] mmc0: sdhci: Host ctl2: 0x00000000
[   10.732018] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
[   10.732229] mmc0: sdhci: ============================================

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 hw/misc/Kconfig               |  3 ++
 hw/misc/cv1800b_clk.c         | 90 +++++++++++++++++++++++++++++++++++
 hw/misc/meson.build           |  1 +
 include/hw/misc/cv1800b_clk.h | 24 ++++++++++
 4 files changed, 118 insertions(+)
 create mode 100644 hw/misc/cv1800b_clk.c
 create mode 100644 include/hw/misc/cv1800b_clk.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6653..fd56f0a4c5 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -257,4 +257,7 @@ config XLNX_VERSAL_TRNG
 config XLNX_ZYNQ_DDRC
     bool
 
+config SOPHGO_CV1800B_CLK
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/cv1800b_clk.c b/hw/misc/cv1800b_clk.c
new file mode 100644
index 0000000000..db7e626158
--- /dev/null
+++ b/hw/misc/cv1800b_clk.c
@@ -0,0 +1,90 @@
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
+#define REG_BYTE_WIDTH    (4)
+#define REG_CLK_BYP_0     (0x030 / REG_BYTE_WIDTH)
+#define REG_CLK_BYP_1     (0x034 / REG_BYTE_WIDTH)
+
+static uint64_t cv1800b_clk_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    CV1800BClkState *s = opaque;
+    uint32_t val = 0;
+
+    if ((addr / 4) < ARRAY_SIZE(s->regs)) {
+        val = s->regs[addr / 4];
+    }
+
+    return val;
+}
+
+static void cv1800b_clk_write(void *opaque, hwaddr addr, uint64_t val, unsigned int size)
+{
+    CV1800BClkState *s = opaque;
+
+    if ((addr / 4) < ARRAY_SIZE(s->regs)) {
+        s->regs[addr / 4] = val;
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
+                            TYPE_CV1800B_CLK, 0x1000);
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
index 23265f6035..692f290a87 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -36,6 +36,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
+system_ss.add(when: 'CONFIG_SOPHGO_CV1800B_CLK', if_true: files('cv1800b_clk.c'))
 
 subdir('macio')
 
diff --git a/include/hw/misc/cv1800b_clk.h b/include/hw/misc/cv1800b_clk.h
new file mode 100644
index 0000000000..05c0d1ca1b
--- /dev/null
+++ b/include/hw/misc/cv1800b_clk.h
@@ -0,0 +1,24 @@
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
+struct CV1800BClkState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t regs[0x1000 / 4];
+};
+
+#endif
-- 
2.54.0.1136.gdb2ca164c4-goog


