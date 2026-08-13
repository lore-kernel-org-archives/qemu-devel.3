Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49531C5DF66
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVwe-0002xV-Ln; Thu, 13 Aug 2026 09:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuVwc-0002x8-Eb
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:58:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuVwa-00020P-8P
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:58:06 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ceb096e675so9579475ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 06:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786629483; x=1787234283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kImMqM9I7Obc8QnqaPPg9PomF+UcCTs/QXeVwz4lXlw=;
 b=h4xBWmc8ins2Z76q9BH1+YIUdV34dG7BtYFM8+8CdSnEfkmy1WubM8TMQg+w7SaLrN
 etbPQZ44Xtjci8BIBMZ1GoTqFDP3oDVSiUAR5CJ5lAlb3Ht75ZWh4LsCEnTqzgWbU6n5
 K+5nyG7TTqtsjnGNbOc0yxdxibQCjFa3St8hmBBoqF13b72zpvY6pS3kZcO6MCMtQtY7
 Wm94s30S7V2zoNDdFgR1JfkLZnaEQS/rylrF4mZz7CJU4I4bvIBjrJs19c3oXC1FjKu0
 FrMmhjXO8BKhU5UAb0yua1WMl+9fAasdQbTBZ4kDtG82HgPmZ/PlFkF42GevMYCwHiWQ
 txZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786629483; x=1787234283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kImMqM9I7Obc8QnqaPPg9PomF+UcCTs/QXeVwz4lXlw=;
 b=FyWmCrwsOu5q5M22HOq8v+RtQX+9LeukkkrGuH1LDwvve4U1hyI/84XGmMO3svsKsT
 u/nT2HUFGTrAAjmxD5WyXww7zWuM+SRFWIx1NPONq37qeiDlLi46A/hWnSXQfd/+ZEEU
 RPKWT9SzdniC1ipH+DTcyxX3HjrbRwmowOzQYhi+fJJZI0CjFMkfCmYq59eRUefP20jR
 N3Q5CfCiNJ+RhMMc3NomJe8oWoWntJFfvYIj9e5Ch2vf2O732vdNlmotxPHjUFXhyJv5
 SrqQQ/DGN7JMFOLysD8gIWvLVwTX94WB3C3v1VUlXmm37SdPfe2IA23TcF85tbFcscrg
 3tKw==
X-Gm-Message-State: AOJu0Yz039k6mreSYW+wcgIcb3yewu/31i9viSqtC3zySUCIiM2FM08N
 G/hxAxz6nBPybkTYk3InCg7cuo53dC7ydp3aUJNT5pGVfqAxnSKAqmDvzKr6TCpxMoM=
X-Gm-Gg: AR+sD12Z2YEG0DoA5/VHJF9t0KCXwPgue0lWAg/Uc4YFiCQYR9xI4pcaI+yIUonX7po
 OfUUOUdzo+WdEd1Djar2KlpWLXG1wJ/uaeKdXbPLrnfJoNwFIlTOTFS5thcFgCmGr+e8p/O5ih6
 3xwoKkAf4CV28BcURE0vSh9/j0oqc65B7mOHrRN8O/dwfBibpl5ji+n7xSnNcvQF4gHN67IY+Ps
 9m1Y9Q/KmS1ETmfG9gVjFsbr+5xy0Ml0pDx32Yme4QFZGEaUrBAbkkfrGpqKHFkVz6WTiqUGjrr
 RPxvPScsubfmd5rF07Flng2r9N1Q8VOHMy0qlwsib18yNRnK04LT0CXbF7JNycupo9EJcNuu0o8
 uubGx+hbCY3+wUZo+Rf0N/DfR6R4nMGy/MUaw1KMRddz0iE0o73WMfmVa8W499hhvWC+WdDSQSG
 W5JpJP0lWootX/SEY+mGUXyADQ1Z0Z9Vl0PhCGacRPxpZj6G5uHrEwCzy7yRa6h5cNonAJonub6
 Kq2Dm0pDg==
X-Received: by 2002:a17:902:d2cc:b0:2ca:d172:7228 with SMTP id
 d9443c01a7336-2d37e855129mr61764005ad.11.1786629482726; 
 Thu, 13 Aug 2026 06:58:02 -0700 (PDT)
Received: from localhost.localdomain ([111.198.227.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d37c486531sm10024395ad.57.2026.08.13.06.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 06:58:02 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Junze Cao <caojunze424@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v3 1/3] hw/misc/k230_iomux: add Kendryte K230 IOMUX model
Date: Thu, 13 Aug 2026 21:57:15 +0800
Message-ID: <20260813135717.2758-2-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813135717.2758-1-flamboyant.h.01@gmail.com>
References: <20260813135717.2758-1-flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pl1-x629.google.com
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

Add a SysBus model for the 64 K230 Function IO configuration
registers documented by the K230 Technical Reference Manual.

Preserve the writable configuration fields across aligned 32-bit
accesses, apply the documented reset values, and ignore writes to
read-only and reserved fields. Offsets outside the documented register
list read as zero and ignore writes.

This provides the register behavior used by the Kendryte SDK U-Boot
pinctrl-single driver and Linux IOMUX configuration code.

Suggested-by: Alistair Francis <Alistair.Francis@wdc.com>
Suggested-by: Chao Liu <chao.liu@processmission.com>
Suggested-by: Junze Cao <caojunze424@gmail.com>
Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 MAINTAINERS                  |   2 +
 hw/misc/Kconfig              |   3 +
 hw/misc/k230_iomux.c         | 125 +++++++++++++++++++++++++++++++++++
 hw/misc/meson.build          |   1 +
 hw/misc/trace-events         |   4 ++
 include/hw/misc/k230_iomux.h |  43 ++++++++++++
 6 files changed, 178 insertions(+)
 create mode 100644 hw/misc/k230_iomux.c
 create mode 100644 include/hw/misc/k230_iomux.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f249be744e..adcff4bbdb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1845,8 +1845,10 @@ S: Maintained
 F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
+F: hw/misc/k230_iomux.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: include/hw/misc/k230_iomux.h
 F: tests/functional/riscv64/test_k230.py
 F: tests/qtest/k230-wdt-test.c
 
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index b8860dd3e7..5011c10c53 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -260,4 +260,7 @@ config XLNX_ZYNQ_DDRC
 config AXIADO_CLK
     bool
 
+config K230_IOMUX
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/k230_iomux.c b/hw/misc/k230_iomux.c
new file mode 100644
index 0000000000..11fcc22a09
--- /dev/null
+++ b/hw/misc/k230_iomux.c
@@ -0,0 +1,125 @@
+/*
+ * Kendryte K230 IOMUX
+ *
+ * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides the Function IO configuration registers documented by the K230
+ * Technical Reference Manual.
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
+#include "trace.h"
+
+/* TRM V0.3.1 section 12.9.2.1 Function IO register list. */
+static const uint32_t k230_iomux_reset_values[K230_IOMUX_NUM_REGS] = {
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
+static uint64_t k230_iomux_read(void *opaque, hwaddr offset, unsigned size)
+{
+    K230IomuxState *s = K230_IOMUX(opaque);
+    uint32_t value = 0;
+
+    if (offset < K230_IOMUX_REGS_SIZE) {
+        value = s->regs[offset >> 2];
+    }
+
+    trace_k230_iomux_read(offset, value);
+    return value;
+}
+
+static void k230_iomux_write(void *opaque, hwaddr offset,
+                             uint64_t value, unsigned size)
+{
+    K230IomuxState *s = K230_IOMUX(opaque);
+
+    trace_k230_iomux_write(offset, value);
+    if (offset < K230_IOMUX_REGS_SIZE) {
+        s->regs[offset >> 2] = value & K230_IOMUX_WRITABLE_MASK;
+    }
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
+static void k230_iomux_enter_reset(Object *obj, ResetType type)
+{
+    K230IomuxState *s = K230_IOMUX(obj);
+
+    memcpy(s->regs, k230_iomux_reset_values,
+           sizeof(k230_iomux_reset_values));
+}
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
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->desc = "Kendryte K230 IOMUX";
+    dc->vmsd = &vmstate_k230_iomux;
+    rc->phases.enter = k230_iomux_enter_reset;
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
index e86d9ad6b3..fab6336c91 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -171,3 +171,4 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
 system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
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
diff --git a/include/hw/misc/k230_iomux.h b/include/hw/misc/k230_iomux.h
new file mode 100644
index 0000000000..0a637c6292
--- /dev/null
+++ b/include/hw/misc/k230_iomux.h
@@ -0,0 +1,43 @@
+/*
+ * Kendryte K230 IOMUX
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
+#define K230_IOMUX_NUM_REGS 64
+#define K230_IOMUX_REGS_SIZE \
+    (K230_IOMUX_NUM_REGS * sizeof(uint32_t))
+
+/*
+ * Register layout (TRM V0.3.1, section 12.9.2.2):
+ *   bit 31     DI: RO, input data from outside the chip to the PAD,
+ *               reads as zero; the model does not simulate external
+ *               pin input
+ *   bits 30-14 RSV: RO, reserved
+ *   bits 13-0  RW configuration fields
+ */
+#define K230_IOMUX_WRITABLE_MASK 0x00003fff
+
+struct K230IomuxState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t regs[K230_IOMUX_NUM_REGS];
+};
+
+#endif /* HW_MISC_K230_IOMUX_H */
-- 
2.43.0


