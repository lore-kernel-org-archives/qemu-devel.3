Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD87C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 04:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi329-000256-C3; Fri, 10 Jul 2026 00:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wi2hi-0003Fj-KI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 00:19:10 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wi2hf-0003uH-Kl
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 00:19:10 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso705957a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 21:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783657146; x=1784261946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PqR2Adrlq8cmoHwf9HRrLT5wH9/8x3Kgy4Z3hqQKy9k=;
 b=e/ixYeWW0WLal9NWn3NoLdZH2p7vrYQ7217BcEVhXdIibMyswWmUl2ra3exS6rnO3L
 QWqtmpTb30/7YJTTynxDrv1I0lN8PgsDvHxmZmyrW2FnhWoTrE8H+LbtesZxOxm+wyuR
 tosOrh2vebGjC2TCKZxNWwIzsUQRvq+ENcgFfi80QPmnJtzsdCFNasWtStlr8bh32wUv
 AQXK150aKifh8pa2es97KmRYm565IKUkFC5/chwfTq0aHw/B40lpAwUpZ4bjhOphmb04
 7/0o23KH2BPJCGrXfDxSqycoegZ0isRm8N3L/c2FelW2HXd7Uq1g6CLI0DiyqKgEKRaf
 iaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783657146; x=1784261946;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PqR2Adrlq8cmoHwf9HRrLT5wH9/8x3Kgy4Z3hqQKy9k=;
 b=M+LaFwBWpTA9lWmzeYM1BmAPKTWr6XAVozh5rxlg58RihfJy2Z00sEeimUXLFX/h4B
 4nGps2u88nKCvh9HtccTlL2A6X6419WJd7xWLJq9J74cP4+ea7nt7BsZVBMffzhfg9og
 /iUSVXmDy4e0R6dNrXvjPxShL4vrxZfQA3X9CK6x7eTd1VF6WD0UsBT8iKGu9SzkXKVI
 4iapcqGlTzklxW+zC43w5z+tu8m2el+8ag182+kbfIMmiwMbTo1fJkMI+ncg6vRiiUVQ
 k37nkWdOjl9og892MyZzbG3aRnSrHqz0OFqwYl9GRtTM11Ty+uba4aBSK78WFlIzWckK
 6iHg==
X-Gm-Message-State: AOJu0Yw2MbuyZoM/8E9mBB9UodvB/tSFAJwiVIWDUAsk1tyH1NKk2qrM
 RlzHZMKHMajG0FYpSyWnSbr224RvNKWyKv8HwiA3yyAnMn/c/tDt7QCz+UAEoq302ge320Ad
X-Gm-Gg: AfdE7cmdtlpW14aaCo2qhQl//rNC9H6+MeVbNnmiE9Q1ZWGJ/TZl+RLnKZfSbYQoMKC
 dr/mPyk9B4z9//6NMRWQ1gvzNOVQ1p/SM9SRpxx54P2IbDZhdoHwsh40P28aDVq1yRM0WUhYMFa
 XuriG1IIl+JmQJUzjiWXMzGLplHDD9T3FtcxuYDyWrO10CGLdTUGaBsTOUTR2oC2IPAUb3TiZS3
 p9uo+Mh55TuRKswvxZVSHt7d6+6nfYvu+ESVP5VQo0zjLeapFc5Cus0H6r19fwEILD5ZKOLH7gZ
 AhlxoyY8JGjCPC8sUbJ6dak0px4djbXeMKUXK2CeVMuxLb54PxCJBZbnJUPdjxbWjOgT5ZHbKWS
 NvWa3e1kzu3Xzuhqj8jsxYnm/286XdNS5+hBb8Q9eOS8Q7PVhZpj/7WuVB4FPp/3WMKU3o55lC4
 phXw1Dpz1SHBHTms4cWSreK3PQJ9B1AzChdTVliA==
X-Received: by 2002:a17:90b:45:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-38940631bfcmr9428779a91.17.1783657145704; 
 Thu, 09 Jul 2026 21:19:05 -0700 (PDT)
Received: from LAPTOP-CS7CB8K1.localdomain
 ([2409:8900:98e:d38:8d7f:b05:d4a0:a4b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38d2fdd777csm321895a91.1.2026.07.09.21.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 21:19:04 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kangjie Huang <flamboyant.h.01@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 qemu-riscv@nongnu.org (open list:K230 Machines)
Subject: [PATCH RFC 1/1] hw/riscv/k230: add IOMUX register block model
Date: Fri, 10 Jul 2026 12:18:44 +0800
Message-ID: <20260710041845.67170-1-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 00:40:15 -0400
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

Add a sysbus model for the K230 IOMUX MMIO range at
0x91105000-0x911057ff. The model exposes the Function IO registers with
the reset defaults documented by the K230 Technical Reference Manual and
keeps 32-bit guest writes visible to firmware and the operating system.

This is enough for SDK U-Boot's pinctrl-single driver, which programs
the board pin configuration with 32-bit read-modify-write accesses.

Wire the device into the K230 SoC and add qtest coverage for reset
values, read/write storage and system reset.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
RFC notes:
- This is my first QEMU upstream submission; feedback on patch structure
  and modelling boundaries would be appreciated.
- The model covers the IOMUX MMIO range 0x91105000-0x911057ff.
- It is intended to satisfy SDK U-Boot pinctrl-single register accesses.
- PMU IOMUX and physical pin routing are intentionally not modeled.
- Tested with qtest and SDK U-Boot smoke test.

 docs/system/riscv/k230.rst    |   1 +
 hw/misc/Kconfig               |   3 +
 hw/misc/k230_iomux.c          | 138 ++++++++++++++++++++++++++++++++++
 hw/misc/meson.build           |   2 +
 hw/misc/trace-events          |   4 +
 hw/riscv/Kconfig              |   1 +
 hw/riscv/k230.c               |  11 ++-
 include/hw/misc/k230_iomux.h  |  34 +++++++++
 include/hw/riscv/k230.h       |   2 +
 tests/qtest/k230-iomux-test.c | 107 ++++++++++++++++++++++++++
 tests/qtest/meson.build       |   5 +-
 11 files changed, 304 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/k230_iomux.c
 create mode 100644 include/hw/misc/k230_iomux.h
 create mode 100644 tests/qtest/k230-iomux-test.c

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202e55..b160c401fd 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -20,6 +20,7 @@ The ``k230`` machine supports the following devices:
 * Platform-Level Interrupt Controller (PLIC)
 * 2 K230 Watchdog Timer
 * 5 UART
+* K230 IOMUX register block
 
 Boot options
 ------------
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6653..573d24a9df 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -257,4 +257,7 @@ config XLNX_VERSAL_TRNG
 config XLNX_ZYNQ_DDRC
     bool
 
+config K230_IOMUX
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/k230_iomux.c b/hw/misc/k230_iomux.c
new file mode 100644
index 0000000000..5f5e2aac51
--- /dev/null
+++ b/hw/misc/k230_iomux.c
@@ -0,0 +1,138 @@
+/*
+ * K230 IOMUX register block compatible with Kendryte K230 SDK
+ *
+ * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides the low IOMUX register block at 0x91105000 with the reset
+ * defaults documented by the K230 Technical Reference Manual. The model keeps
+ * guest 32-bit register writes visible to firmware and the operating system,
+ * but does not model physical pin routing, pad electrical effects, or the
+ * separate PMU IOMUX block.
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/k230_iomux.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "qemu/log.h"
+#include "trace.h"
+
+/* TRM V0.3.1 section 12.9.2.1 Function IO register list. */
+static const uint32_t k230_iomux_reset_values[] = {
+    0x944, 0x944, 0x929, 0x908, 0x888, 0x908, 0x948, 0x890,
+    0x890, 0x890, 0x910, 0x890, 0x890, 0x8a9, 0xa9e, 0xabf,
+    0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e,
+    0xb1e, 0xa90, 0xabf, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e,
+    0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0x890, 0x910,
+    0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x890, 0x910,
+    0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x89e, 0x89f,
+    0x99e, 0x99e, 0x99e, 0x99e, 0x890, 0x890, 0x8a9, 0x8a9,
+};
+
+static void k230_iomux_reset(DeviceState *dev)
+{
+    K230IomuxState *s = K230_IOMUX(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    memcpy(s->regs, k230_iomux_reset_values,
+           sizeof(k230_iomux_reset_values));
+}
+
+static uint64_t k230_iomux_read(void *opaque, hwaddr offset, unsigned size)
+{
+    K230IomuxState *s = K230_IOMUX(opaque);
+    uint32_t value;
+
+    if (offset + size > K230_IOMUX_MMIO_SIZE || (offset & 3)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid access offset 0x%" HWADDR_PRIx
+                      " size %u\n", __func__, offset, size);
+        return 0;
+    }
+
+    value = s->regs[offset >> 2];
+    trace_k230_iomux_read(offset, value);
+    return value;
+}
+
+static void k230_iomux_write(void *opaque, hwaddr offset,
+                             uint64_t value, unsigned size)
+{
+    K230IomuxState *s = K230_IOMUX(opaque);
+
+    if (offset + size > K230_IOMUX_MMIO_SIZE || (offset & 3)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid access offset 0x%" HWADDR_PRIx
+                      " size %u\n", __func__, offset, size);
+        return;
+    }
+
+    trace_k230_iomux_write(offset, value);
+    s->regs[offset >> 2] = value;
+}
+
+static const MemoryRegionOps k230_iomux_ops = {
+    .read = k230_iomux_read,
+    .write = k230_iomux_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void k230_iomux_init(Object *obj)
+{
+    K230IomuxState *s = K230_IOMUX(obj);
+
+    memory_region_init_io(&s->mmio, obj, &k230_iomux_ops, s,
+                          TYPE_K230_IOMUX, K230_IOMUX_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static const VMStateDescription vmstate_k230_iomux = {
+    .name = "k230.iomux",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, K230IomuxState, K230_IOMUX_NUM_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void k230_iomux_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Kendryte K230 IOMUX";
+    dc->vmsd = &vmstate_k230_iomux;
+    device_class_set_legacy_reset(dc, k230_iomux_reset);
+}
+
+static const TypeInfo k230_iomux_info = {
+    .name          = TYPE_K230_IOMUX,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230IomuxState),
+    .instance_init = k230_iomux_init,
+    .class_init    = k230_iomux_class_init,
+};
+
+static void k230_iomux_register_types(void)
+{
+    type_register_static(&k230_iomux_info);
+}
+
+type_init(k230_iomux_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6035..31e5145a35 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -168,3 +168,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
 # HPPA devices
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
+
+system_ss.add(when: 'CONFIG_K230_IOMUX', if_true: files('k230_iomux.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c9a868b3ef..388967c9e1 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -405,6 +405,10 @@ djmemc_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRI
 iosb_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
 iosb_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
 
+# k230_iomux.c
+k230_iomux_read(uint64_t offset, uint32_t value) "offset=0x%" PRIx64 " value=0x%" PRIx32
+k230_iomux_write(uint64_t offset, uint64_t value) "offset=0x%" PRIx64 " value=0x%" PRIx64
+
 # aspeed_sli.c
 aspeed_sli_write(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 aspeed_sli_read(uint64_t offset, unsigned int size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..4c9fc3e7ad 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -162,3 +162,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select K230_IOMUX
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..430c1646b5 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-iomux", &s->iomux, TYPE_K230_IOMUX);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -198,6 +199,11 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* IOMUX */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->iomux), errp)) {
+        return;
+    }
+
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[0]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT0_IRQ));
@@ -206,6 +212,8 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
 
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->iomux), 0, memmap[K230_DEV_IOMUX].base);
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -280,9 +288,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("ipcm", memmap[K230_DEV_MAILBOX].base,
                                 memmap[K230_DEV_MAILBOX].size);
 
-    create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
-                                memmap[K230_DEV_IOMUX].size);
-
     create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
                                 memmap[K230_DEV_TIMER].size);
 
diff --git a/include/hw/misc/k230_iomux.h b/include/hw/misc/k230_iomux.h
new file mode 100644
index 0000000000..15e4bb339d
--- /dev/null
+++ b/include/hw/misc/k230_iomux.h
@@ -0,0 +1,34 @@
+/*
+ * Kendryte K230 IOMUX register block
+ *
+ * This models the low IOMUX register block. Physical pin routing, pad
+ * electrical effects, and the separate PMU IOMUX block are out of scope.
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_K230_IOMUX_H
+#define HW_MISC_K230_IOMUX_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_K230_IOMUX "riscv.k230.iomux"
+OBJECT_DECLARE_SIMPLE_TYPE(K230IomuxState, K230_IOMUX)
+
+#define K230_IOMUX_MMIO_SIZE 0x800
+#define K230_IOMUX_NUM_REGS (K230_IOMUX_MMIO_SIZE / sizeof(uint32_t))
+
+struct K230IomuxState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t regs[K230_IOMUX_NUM_REGS];
+};
+
+#endif /* HW_MISC_K230_IOMUX_H */
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..223e76b420 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,6 +18,7 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/misc/k230_iomux.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -33,6 +34,7 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
+    K230IomuxState iomux;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
diff --git a/tests/qtest/k230-iomux-test.c b/tests/qtest/k230-iomux-test.c
new file mode 100644
index 0000000000..ca2d557955
--- /dev/null
+++ b/tests/qtest/k230-iomux-test.c
@@ -0,0 +1,107 @@
+/*
+ * QTest testcase for K230 IOMUX
+ *
+ * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides test coverage for the low IOMUX register block compatible with the
+ * Kendryte K230 SDK.
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/misc/k230_iomux.h"
+
+#define K230_IOMUX_BASE 0x91105000
+#define K230_IOMUX_IO0  (K230_IOMUX_BASE + 0x00)
+#define K230_IOMUX_IO1  (K230_IOMUX_BASE + 0x04)
+#define K230_IOMUX_LAST (K230_IOMUX_BASE + K230_IOMUX_MMIO_SIZE - 4)
+
+static const uint32_t k230_iomux_reset_values[] = {
+    0x944, 0x944, 0x929, 0x908, 0x888, 0x908, 0x948, 0x890,
+    0x890, 0x890, 0x910, 0x890, 0x890, 0x8a9, 0xa9e, 0xabf,
+    0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e,
+    0xb1e, 0xa90, 0xabf, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e,
+    0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0x890, 0x910,
+    0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x890, 0x910,
+    0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x89e, 0x89f,
+    0x99e, 0x99e, 0x99e, 0x99e, 0x890, 0x890, 0x8a9, 0x8a9,
+};
+
+static void test_reset_values(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    for (size_t i = 0; i < G_N_ELEMENTS(k230_iomux_reset_values); i++) {
+        g_assert_cmphex(qtest_readl(qts, K230_IOMUX_BASE +
+                                    i * sizeof(uint32_t)), ==,
+                        k230_iomux_reset_values[i]);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_rw(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_IOMUX_IO0, 0x12345678);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==, 0x12345678);
+
+    qtest_writel(qts, K230_IOMUX_IO1, 0xa5a5a5a5);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO1), ==, 0xa5a5a5a5);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==, 0x12345678);
+
+    qtest_quit(qts);
+}
+
+static void test_last_reg_rw(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_IOMUX_LAST, 0x00000abc);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_LAST), ==, 0x00000abc);
+
+    qtest_quit(qts);
+}
+
+static void test_reset_after_write(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_IOMUX_IO0, 0x12345678);
+    qtest_writel(qts, K230_IOMUX_IO1, 0xa5a5a5a5);
+    qtest_writel(qts, K230_IOMUX_LAST, 0x00000abc);
+
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==, 0x12345678);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO1), ==, 0xa5a5a5a5);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_LAST), ==, 0x00000abc);
+
+    qtest_system_reset(qts);
+
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO0), ==,
+                    k230_iomux_reset_values[0]);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_IO1), ==,
+                    k230_iomux_reset_values[1]);
+    g_assert_cmphex(qtest_readl(qts, K230_IOMUX_LAST), ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-iomux/reset", test_reset_values);
+    qtest_add_func("/k230-iomux/rw", test_rw);
+    qtest_add_func("/k230-iomux/last-reg-rw", test_last_reg_rw);
+    qtest_add_func("/k230-iomux/reset-after-write", test_reset_after_write);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..cb8001ecbf 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,10 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? [
+    'k230-wdt-test',
+    'k230-iomux-test',
+  ] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.43.0


