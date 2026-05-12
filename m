Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14838CD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMjhd-0004Qk-H5; Tue, 12 May 2026 05:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wMjhM-0004Ni-Eo
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:46:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wMjhK-000155-M9
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:46:44 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8353ca0f1f1so2707201b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778579201; x=1779184001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLC10TUX2AfE6MDdbm1gzs+WcsKVviC2Px435/4TdUU=;
 b=CfL6p6GSnP6FBHtrj+qz2XZ9NgH4ajqIq8wFwI33r6QEALIlXPryKsLvthVXLQI6eK
 8Tt1PGfp72zftOOs30Ia/Pu+YCaPi7nwm4wY7gml+WoqA2hkTiIggkBkz7zpEH/t8zYm
 bJWwfRmjgsnk4o4ItmoQy1itwrcRg0OwrTk0BcUZCHq6WLa6zQEyxtCcAOVEHwxP+Rj7
 FSceuP+E7DqwMlJShOfyWruv5yx3jOVduY9sNzuy5CbhQOfkGUOMADw+2c/t6p4m+Fca
 IsfgWEZJIwiPK7SMjUFi0TI/DUaDSZ9Vq7hSgYe5/R6pSud64KmsXUe4hQEFCGQ8IkXj
 /jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778579201; x=1779184001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mLC10TUX2AfE6MDdbm1gzs+WcsKVviC2Px435/4TdUU=;
 b=S0tMve2Ae3ykjwYM/GYBCY2aBn7dBBbIpFTER2uXIqePevm6f2Hl2xhkMugMVjBXrf
 Dnnbrm+EdIHH8MH/74I/IznCNAVQM9owtLknbDN6LZJTJfJiahe14uCEbxoHx7L3kr0L
 BoCwTNvOL39BtLA3std31uxYULENIQCy/pjDqpARIGjkgFmjqM3Xfd7wr0vJqqvc5LLr
 LlCzGZwSUoAHjloH1T09/i4E/Hm7+UKEkxj28uWRdz2mLgaqyIvYkgY1h6kIJN9VN0f3
 VP4cY+WGcWb62XEkRyaP2+l2m2yths7JzqWwG8HN+EKiXhfA5hBEfc2pHg03/ukrK1tv
 c1sA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jty3iAZgoQ99BPl7dMx8H2DSCp8fWOL+4AzMBtm9hPdzQ0SaHxULTZ0BVqaoEP8bZ/1dGKGIfR8iU@nongnu.org
X-Gm-Message-State: AOJu0YwkMLZ5bFvUXcEu3WEwezzx7RqamKjKo9pj3HEy39xOhn8+oJLY
 t9kRNw7KtW/1kBJhhRaHr0dfmbyCsIshY6jL7Q9xrIOvl/6+t15KFhao
X-Gm-Gg: Acq92OH0vdUpBkT5i/iQI0RiTOD9ZVR5Bax7WKolM50+cqnk5Cj8V0m3bzkv17HI/NQ
 FnI3a0G3uw9sc+YFYVJT9pP9xCP2TbJAE6alGXQrulHtllYsVsfqfQNBZxrVvsgkOfywdziqqO4
 n2kr1ljaTkJpNKlLWx6Y93fLROuCOZz47gwNmV4F5m0UF13EJxttR3+WX0+l3QkFbHhwmUE92JS
 SPSXSdasmteL2k10ONGx/Psp+8zx+G9CN+yDO/zD7RWh6fsUOsP6EoMtTN0nWBs6vh54B8A96To
 51oWQ+0BsemaCHns+1+Yto0EW70oRVykwBuyK5uxASz6QwvvNmOjK43nFEb1iwKPqSDXEWtp8Co
 you8JXI1ERbSjHJBm1VWHONU8cpDOq3sVI2mOBmIFb73fqcfpd5yvCntoIgPAcNaGXOgaFk/HAE
 cI3PiLmWKo0erY3Aa4XqLPeOMPG34+RWFw0WAxVSox48kSZ99C6u5+KxC0AR2Ba9x9Aj0mnF9VF
 XHX2uLSJbh4oy/79bKhaFypFer43yoDvw==
X-Received: by 2002:a05:6a00:4484:b0:82f:6cb3:645a with SMTP id
 d2e1a72fcca58-83ee840bc04mr3308773b3a.31.1778579201282; 
 Tue, 12 May 2026 02:46:41 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839682aba01sm22960593b3a.55.2026.05.12.02.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:46:40 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, christoph.muellner@vrull.eu
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH RFC 3/5] hw/misc: Add Sophgo CV1800B clock controller
Date: Tue, 12 May 2026 09:46:11 +0000
Message-ID: <20260512094614.3464388-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260512094614.3464388-1-visitorckw@gmail.com>
References: <20260512094614.3464388-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x432.google.com
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
 hw/misc/cv1800b_clk.c         | 89 +++++++++++++++++++++++++++++++++++
 hw/misc/meson.build           |  1 +
 include/hw/misc/cv1800b_clk.h | 24 ++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 hw/misc/cv1800b_clk.c
 create mode 100644 include/hw/misc/cv1800b_clk.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 99bdf09219..42cdf771a4 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -254,4 +254,7 @@ config IOSB
 config XLNX_VERSAL_TRNG
     bool
 
+config SOPHGO_CV1800B_CLK
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/cv1800b_clk.c b/hw/misc/cv1800b_clk.c
new file mode 100644
index 0000000000..738f0910db
--- /dev/null
+++ b/hw/misc/cv1800b_clk.c
@@ -0,0 +1,89 @@
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
+#define REG_CLK_BYP_0  (0x030 / 4)
+#define REG_CLK_BYP_1  (0x034 / 4)
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
index 245ab9b98c..a4c5f90cd8 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -35,6 +35,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
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
2.54.0.563.g4f69b47b94-goog


