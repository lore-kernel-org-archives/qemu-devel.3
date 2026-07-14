Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8184C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjaHr-0002Uc-Au; Tue, 14 Jul 2026 06:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wjaHp-0002Ti-H4
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:22:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wjaHn-0007gA-Dc
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:22:49 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cce6a0c9c3so36598525ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 03:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784024566; x=1784629366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tImCMss+EyAVl/qbOct1/xumOzcwCGhwiEJBodVqCX0=;
 b=p5NGBhJeL9Jj2Q26/EP6jHirw7K1gjeorfxHcuN2C3Py37bdOh18Eond2AMqVCwLIZ
 WrFrRp2CmvfBe4Onbq7hjcPJ6hIfqqFsGgdO4HyLniWzkKqi8OaA2ohh5Af5xKOnde1e
 3zPZmXUyhTSZooXRzHqhcnr0uN9GFf1a6UguddAP2anczWqOX5R6bots5cr8IA4BdCjP
 cLRdsfG9HOCEgzv7xMzoDVKEuOI7qLzrTib3yhPp9J9QYoPQAvhbmxcldhvJm/Cf9qmU
 D34x9GjNDnqVxOKqS3KNtwwbeynUO4I0rrbp+h4s4/JrdxeuwlIpUbak+1c1U/aiXnnI
 MXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784024566; x=1784629366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tImCMss+EyAVl/qbOct1/xumOzcwCGhwiEJBodVqCX0=;
 b=dlaO5GT4U+QXb7/17RXndfyrNReoi5L+66oUjn5CNgH62u6DGNosZdpu0g4ZrGrr2q
 OcNnkpJgoRMRSetUR6cDGGFhyGdZi0AaBB97Vgnj1YCWPCB1Wlh56VYF76DVzuPI/a4m
 j3N8uxTwaOD1AHqJDUnOpiYBkWDLG87rnNqRja85DN28B6Y2F1sr0085DkHdiJO2EsGj
 TX4xbKG3EmpNoBWIx/cbl/RSuJ8j85XW/AyO3jFojhxNsdZxWaQ/8eoc6Lw73Knem79Y
 r6RFBpT3eBO3YurKG/8FA1o5uRmYV2wnEeDjeAFh/iGhNYZhBnOVHIHSMA7cPstIkOUm
 OhPA==
X-Gm-Message-State: AOJu0YxNLHTIiiF0MXr4APlJ9vABWx6Iel2zt+SCFsC5WsRIzUJuz97n
 rr95+QPYDywNURa4DOx2jibksJiR7NEPalLCZD44ESf1QGplmjfNjueluJtRtbapbCNzqQ==
X-Gm-Gg: AfdE7clgEQhVLUhJ2baD0bJkt6FP5iZlQXWMvyiE2AKxKkV6IokwUsI3KuarLmTln2O
 jr0KBlfTBAMoF7m+nnudAHSSH1mAE6B4Kx4joeDo9YDncqs3K0pDngAQliSVDNY2z7VYvy3eyvl
 IZbIQ8/eytXPnpDGZ2En7giQn9erIPhIJV3hEHrejBW0/Fdz4l6d+Zks608yE63hV8ZPixTTF4S
 x+AFkRr9CG6WXAZhjlnabyANjBatMS5SoQRJuubfTTi1adWs9WQ2IT6VeOuDu39PvRWaSMCspW1
 U7Gtu40LrY4PXAySY4Xcc/uDe9S83g1401Wqi0e3St7RtiEFgys6bGwf3oI6PGcp6pnTxB9bHCE
 au1pRXfF9UbUvqijOBiSWWyK78ZrmRUvQ38K94kMpAGNmU71km/K5BjqIsniOvUsWZRm4AxW872
 FsSqVHvHcn3x9D4SoHzU8PhnoCmmPX8lPvDfS6qIxEGg==
X-Received: by 2002:a17:903:41cf:b0:2cb:3f5b:6663 with SMTP id
 d9443c01a7336-2cef11cc5eamr18323995ad.11.1784024565889; 
 Tue, 14 Jul 2026 03:22:45 -0700 (PDT)
Received: from LAPTOP-CS7CB8K1.localdomain
 ([2409:8900:9fe:241d:8c09:365b:5b34:d891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc1fsm113824285ad.55.2026.07.14.03.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:22:45 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v2 1/3] hw/misc/k230_iomux: add Kendryte K230 IOMUX model
Date: Tue, 14 Jul 2026 18:22:00 +0800
Message-ID: <42d005d6e530e2cf2c7df8634e8b82c0f77d1702.1784022244.git.flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784022244.git.flamboyant.h.01@gmail.com>
References: <cover.1784022244.git.flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 hw/misc/Kconfig              |   3 +
 hw/misc/k230_iomux.c         | 124 +++++++++++++++++++++++++++++++++++
 hw/misc/meson.build          |   2 +
 hw/misc/trace-events         |   4 ++
 include/hw/misc/k230_iomux.h |  34 ++++++++++
 5 files changed, 167 insertions(+)
 create mode 100644 hw/misc/k230_iomux.c
 create mode 100644 include/hw/misc/k230_iomux.h

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
index 0000000000..cc40dc8ae4
--- /dev/null
+++ b/hw/misc/k230_iomux.c
@@ -0,0 +1,124 @@
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
+static void k230_iomux_reset(DeviceState *dev)
+{
+    K230IomuxState *s = K230_IOMUX(dev);
+
+    memcpy(s->regs, k230_iomux_reset_values,
+           sizeof(k230_iomux_reset_values));
+}
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
diff --git a/include/hw/misc/k230_iomux.h b/include/hw/misc/k230_iomux.h
new file mode 100644
index 0000000000..15a16ef4de
--- /dev/null
+++ b/include/hw/misc/k230_iomux.h
@@ -0,0 +1,34 @@
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


