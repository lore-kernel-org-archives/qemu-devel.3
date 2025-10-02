Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4EACAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HPx-0005dq-CF; Thu, 02 Oct 2025 07:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HPw-0005dV-A6
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:12 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HPg-0005kG-Nd
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:12 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-77636fb28f6so8892737b3.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404229; x=1760009029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLIfkYFDxkPdXbVboV8e++zN4m9LIWXAYhRWq/MINeY=;
 b=CE1D22+P8Q9HnreMDhpUx2+Apti7mpOZgnnHhOuNX68/moOxMd3ImbBZd7D/lJaHmJ
 BmmDAtct8NYdVIJh4BC5/8Mu6vqSlE40bY6wtVGqfSORJzEm62/2vk2QRqedYNXY4INj
 MQOMd51Htvb63e4nikckzsRDKPHDtF9TlbbiCw3DYnshq3WGk1+eGoI+7FOWvDy0YayA
 TeAbONTyCkRYxSfe8Aca/bWlZpkjslyljdgr/JNWRE4Txp5UoEtIaqKGs2Evx/v03i+p
 a54rBIuuHuMnRbQmL267e5CJxQDPwKyv9lOSz0OTpwh+MnDnXLe9d3I6l7S7+95YrOe4
 OObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404229; x=1760009029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLIfkYFDxkPdXbVboV8e++zN4m9LIWXAYhRWq/MINeY=;
 b=oN4uRwVPoFF5ma+RxZd9gdm10nH0xKqXJHMXTNxCmHJkep6iwrw/IpnNsmc1vFN7NR
 ctmqI8hjs27YXgUc8F0Vr0ONLEQ3krPQCR/cH4HX7hQKiKI8XhUQ8vjbbaLt9yH+Pb3h
 FInplABG5dCld0s31GAPyw0cO9vgOjLTI/ztyTw2fVv8juTl6AwdT9zYjtNWJM+liR4F
 PBxgi56VAky10maA6O1cNEXFTtyS6YTa08Wh8/l74JZOpNEYa8+H4gEDtXUMPLjH5c1U
 lANekjbkHXlA3BZTJ3YXBYXZrbx1OLl+liQS2Kg2MMowJu+RKyF7bNaFEHA/yV3gCLhX
 2NcA==
X-Gm-Message-State: AOJu0YzG/hK17RKxELXpv3E4k9ioFzEXFAznak/aXF5HIxax8QJ7ik7B
 m6tETz57TIMpTCyEu+blc3O0ftYEJx6CMCAjE6LJoybnl3jdntQc8lgPLMTr7777dLVSN2oBLkT
 IXCdXlTI=
X-Gm-Gg: ASbGncuLc3QqMt1MiPJaC9LFq1Y9xxS1FNKqzwrCMqZ4xsRTPIzyi9DLs6YEs/ZO56U
 QYSlnxmFjWqjytPYfHLltovanvg/si9GNkEbZUzkp6T8deDS2bwywIPzCuWouxAKHZWJdeOwnID
 Tf7ydz56h96ZVjN+cMLjBWM9okgQ1TTcMcAJ+9JNVzbQCghuSjDMlYNsiMq8Q4JY86zi4MGLXhe
 QouYbW9G8KWfFinSIUZLGMxEjHgtl0E0ua3x1LqUsdqoecNNcZyoqOG6hyr3mnA9FXyN3Qbje5l
 +U9CdCOixlqyX68G8XF1bB2pWUEsbqLZO7pbeTHAlylfVfg513h9Zkh6/C7l7vCLVfzE2PI+//r
 ElAKvQE+cjOkMot2Ou3ahOE8wfr8FAGIYHGQlWVPRCI5V/an62JY9OcyRUM8hOSUO0ChpmPOafq
 8=
X-Google-Smtp-Source: AGHT+IGMHMHI+KwRmmxjwaG4GoNseOvhC2ha9hoUpfd3zAk4oyesngG/MKKtUybhGLDfzZUkNgTFRw==
X-Received: by 2002:a05:690c:6f86:b0:720:58fd:6433 with SMTP id
 00721157ae682-77f6f39e242mr100507217b3.35.1759404228467; 
 Thu, 02 Oct 2025 04:23:48 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:23:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 02/17] hw/riscv: Trace RAM Sink initial impl
Date: Thu,  2 Oct 2025 08:23:20 -0300
Message-ID: <20251002112335.2374517-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Following the effort to implement the basic support for Efficient Trace
(e-trace) in QEMU we'll add a Trace RAM Sink implementation.

Similar to the Trace Encoder, this is inspired in both the Efficient
Trace for RISC-V [1] and  RISC-V Trace Control Interface Specification
[2] specs. It implements a minimal set of features to get started - only
SMEM will be supported for now.

We'll implement the RAM sink logic in the next patches, although most of
the work will be done by the trace encoder.

[1] https://github.com/riscv-non-isa/riscv-trace-spec/releases/download/v2.0-20250616/riscv-trace-spec-asciidoc.pdf
[2] https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/meson.build      |   2 +-
 hw/riscv/trace-events     |   4 +
 hw/riscv/trace-ram-sink.c | 263 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/trace-ram-sink.h |  83 ++++++++++++
 4 files changed, 351 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/trace-ram-sink.c
 create mode 100644 hw/riscv/trace-ram-sink.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index b4a9988a62..2aadbe1e50 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -14,6 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c', 'trace-ram-sink.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 0cbf6ffcb6..14e333fd9e 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -28,3 +28,7 @@ riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx
 # trace-encoder.c
 trencoder_read_error(uint64_t addr) "addr 0x%" PRIx64
 trencoder_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
+
+# trace-ram-sink.c
+tr_ramsink_read_error(uint64_t addr) "addr 0x%" PRIx64
+tr_ramsink_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
diff --git a/hw/riscv/trace-ram-sink.c b/hw/riscv/trace-ram-sink.c
new file mode 100644
index 0000000000..e00de80c04
--- /dev/null
+++ b/hw/riscv/trace-ram-sink.c
@@ -0,0 +1,263 @@
+/*
+ * Emulation of a RISC-V Trace RAM Sink
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "trace-ram-sink.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "system/device_tree.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+
+#define R_TR_RAM_CONTROL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                    R_TR_RAM_CONTROL_RSVP1_MASK | \
+                                    R_TR_RAM_CONTROL_RSVP2_MASK | \
+                                    R_TR_RAM_CONTROL_RSVP3_MASK | \
+                                    R_TR_RAM_CONTROL_RSVP4_MASK)
+
+/* trRamEmpty is the only RO field and reset value */
+#define R_TR_RAM_CONTROL_RESET R_TR_RAM_CONTROL_EMPTY_MASK
+#define R_TR_RAM_CONTROL_RO_BITS R_TR_RAM_CONTROL_EMPTY_MASK
+
+#define R_TR_RAM_IMPL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                 R_TR_RAM_IMPL_RSVP1_MASK)
+
+#define R_TR_RAM_IMPL_RO_BITS (R_TR_RAM_IMPL_VER_MAJOR_MASK | \
+                               R_TR_RAM_IMPL_VER_MINOR_MASK | \
+                               R_TR_RAM_IMPL_COMP_TYPE_MASK | \
+                               R_TR_RAM_IMPL_HAS_SRAM_MASK | \
+                               R_TR_RAM_IMPL_HAS_SMEM_MASK)
+
+#define R_TR_RAM_IMPL_RESET (BIT(0) | 0x9 << 8)
+
+static RegisterAccessInfo tr_ramsink_regs_info[] = {
+    {   .name = "TR_RAM_CONTROL", .addr = A_TR_RAM_CONTROL,
+        .rsvd = R_TR_RAM_CONTROL_RSVP_BITS,
+        .reset = R_TR_RAM_CONTROL_RESET,
+        .ro = R_TR_RAM_CONTROL_RO_BITS,
+    },
+    {   .name = "TR_RAM_IMPL", .addr = A_TR_RAM_IMPL,
+        .rsvd = R_TR_RAM_IMPL_RSVP_BITS,
+        .reset = R_TR_RAM_IMPL_RESET,
+        .ro = R_TR_RAM_IMPL_RO_BITS,
+    },
+    {   .name = "TR_RAM_START_LOW", .addr = A_TR_RAM_START_LOW,
+    },
+    {   .name = "TR_RAM_START_HIGH", .addr = A_TR_RAM_START_HIGH,
+    },
+    {   .name = "TR_RAM_LIMIT_LOW", .addr = A_TR_RAM_LIMIT_LOW,
+    },
+    {   .name = "TR_RAM_LIMIT_HIGH", .addr = A_TR_RAM_LIMIT_HIGH,
+    },
+    {   .name = "TR_RAM_WP_LOW", .addr = A_TR_RAM_WP_LOW,
+    },
+    {   .name = "TR_RAM_WP_HIGH", .addr = A_TR_RAM_WP_HIGH,
+    },
+};
+
+static uint64_t tr_ramsink_regread(void *opaque, hwaddr addr, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+    RegisterInfo *r = &tram->regs_info[addr / 4];
+
+    if (!r->data) {
+        trace_tr_ramsink_read_error(addr);
+        return 0;
+    }
+
+    return register_read(r, ~0, NULL, false);
+}
+
+static void tr_ramsink_regwrite(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+    RegisterInfo *r = &tram->regs_info[addr / 4];
+
+    if (!r->data) {
+        trace_tr_ramsink_write_error(addr, value);
+        return;
+    }
+
+    register_write(r, value, ~0, NULL, false);
+}
+
+static const MemoryRegionOps tr_ramsink_regops = {
+    .read = tr_ramsink_regread,
+    .write = tr_ramsink_regwrite,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t tr_ramsink_msgread(void *opaque, hwaddr addr, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+
+    switch (size) {
+    case 1:
+        return tram->msgs[addr];
+    case 2:
+        return (uint16_t)tram->msgs[addr];
+    case 4:
+        return (uint32_t)tram->msgs[addr];
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tr_ramsink_msgwrite(void *opaque, hwaddr addr,
+                                uint64_t value, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+
+    switch (size) {
+    case 1:
+        tram->msgs[addr] = value;
+        break;
+    case 2:
+        tram->msgs[addr] = extract16(value, 0, 8);
+        tram->msgs[addr + 1] = extract16(value, 8, 8);
+        break;
+    case 4:
+        tram->msgs[addr] = extract32(value, 0, 8);
+        tram->msgs[addr + 1] = extract32(value, 8, 8);
+        tram->msgs[addr + 2] = extract32(value, 16, 8);
+        tram->msgs[addr + 3] = extract32(value, 24, 8);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps tr_ramsink_smemops = {
+    .read = tr_ramsink_msgread,
+    .write = tr_ramsink_msgwrite,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void tr_ramsink_setup_regs(TraceRamSink *tram)
+{
+    hwaddr ramlimit = tram->smemaddr + tram->smemsize;
+
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_START_LOW, ADDR,
+                     extract64(tram->smemaddr, 2, 30));
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_START_HIGH, ADDR,
+                     extract64(tram->smemaddr, 32, 32));
+
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_WP_LOW, ADDR,
+                     extract64(tram->smemaddr, 2, 30));
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_WP_HIGH, ADDR,
+                     extract64(tram->smemaddr, 32, 32));
+
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_LIMIT_LOW, ADDR,
+                     extract64(ramlimit, 2, 30));
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_LIMIT_HIGH, ADDR,
+                     extract64(ramlimit, 32, 32));
+}
+
+static void tr_ramsink_reset(DeviceState *dev)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(dev);
+
+    for (int i = 0; i < ARRAY_SIZE(tram->regs_info); i++) {
+        register_reset(&tram->regs_info[i]);
+    }
+
+    tr_ramsink_setup_regs(tram);
+}
+
+static void tr_ramsink_realize(DeviceState *dev, Error **errp)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(dev);
+
+    memory_region_init_io(&tram->reg_mem, OBJECT(dev),
+                          &tr_ramsink_regops, tram,
+                          "trace-ram-sink-regs",
+                          tram->reg_mem_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(tram), &tram->reg_mem);
+    sysbus_mmio_map(SYS_BUS_DEVICE(tram), 0, tram->baseaddr);
+
+    g_assert(tram->smemsize > 0);
+    tram->msgs = g_malloc0(tram->smemsize);
+
+    memory_region_init_io(&tram->smem, OBJECT(dev),
+                          &tr_ramsink_smemops, tram,
+                          "trace-ram-sink-smem",
+                          tram->smemsize);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &tram->smem);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, tram->smemaddr);
+
+    /* RegisterInfo init taken from hw/dma/xlnx-zdma.c */
+    for (int i = 0; i < ARRAY_SIZE(tr_ramsink_regs_info); i++) {
+        uint32_t reg_idx = tr_ramsink_regs_info[i].addr / 4;
+        RegisterInfo *r = &tram->regs_info[reg_idx];
+
+        *r = (RegisterInfo) {
+            .data = (uint8_t *)&tram->regs[reg_idx],
+            .data_size = sizeof(uint32_t),
+            .access = &tr_ramsink_regs_info[i],
+            .opaque = tram,
+        };
+    }
+}
+
+static const Property tr_ramsink_props[] = {
+    DEFINE_PROP_UINT64("baseaddr", TraceRamSink, baseaddr, 0),
+    DEFINE_PROP_UINT64("smemaddr", TraceRamSink, smemaddr, 0),
+    DEFINE_PROP_UINT32("smemsize", TraceRamSink, smemsize, 0),
+    DEFINE_PROP_UINT32("reg-mem-size", TraceRamSink,
+                       reg_mem_size, TR_DEV_REGMAP_SIZE),
+};
+
+static const VMStateDescription vmstate_tr_ramsink = {
+    .name = TYPE_TRACE_RAM_SINK,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, TraceRamSink, TRACE_R_MAX),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static void tr_ramsink_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, tr_ramsink_reset);
+    device_class_set_props(dc, tr_ramsink_props);
+    dc->realize = tr_ramsink_realize;
+    dc->vmsd = &vmstate_tr_ramsink;
+}
+
+static const TypeInfo tr_ramsink_info = {
+    .name          = TYPE_TRACE_RAM_SINK,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TraceRamSink),
+    .class_init    = tr_ramsink_class_init,
+};
+
+static void tr_ramsink_register_types(void)
+{
+    type_register_static(&tr_ramsink_info);
+}
+
+type_init(tr_ramsink_register_types)
diff --git a/hw/riscv/trace-ram-sink.h b/hw/riscv/trace-ram-sink.h
new file mode 100644
index 0000000000..cd55145669
--- /dev/null
+++ b/hw/riscv/trace-ram-sink.h
@@ -0,0 +1,83 @@
+/*
+ * Emulation of a RISC-V Trace RAM Sink
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_TRACE_RAM_SINK_H
+#define RISCV_TRACE_RAM_SINK_H
+
+#include "hw/register.h"
+#include "hw/sysbus.h"
+#include "system/dma.h"
+#include "qom/object.h"
+
+#define TRACE_R_MAX (0xFFF / 4)
+#define TR_DEV_REGMAP_SIZE 0x1000
+
+/*
+ * The Trace Encoder will read/write those regs so put their
+ * declaration in this header.
+ */
+REG32(TR_RAM_CONTROL, 0x0)
+    FIELD(TR_RAM_CONTROL, ACTIVE, 0, 1)
+    FIELD(TR_RAM_CONTROL, ENABLE, 1, 1)
+    FIELD(TR_RAM_CONTROL, EMPTY, 3, 1)
+    FIELD(TR_RAM_CONTROL, MODE, 4, 1)
+    FIELD(TR_RAM_CONTROL, STOP_ON_WRAP, 8, 1)
+    FIELD(TR_RAM_CONTROL, MEM_FORMAT, 9, 2)
+    /* reserved bits */
+    FIELD(TR_RAM_CONTROL, RSVP1, 2, 1)
+    FIELD(TR_RAM_CONTROL, RSVP2, 5, 2)
+    FIELD(TR_RAM_CONTROL, RSVP3, 11, 1)
+    FIELD(TR_RAM_CONTROL, RSVP4, 15, 16)
+
+REG32(TR_RAM_IMPL, 0x4)
+    FIELD(TR_RAM_IMPL, VER_MAJOR, 0, 4)
+    FIELD(TR_RAM_IMPL, VER_MINOR, 4, 4)
+    FIELD(TR_RAM_IMPL, COMP_TYPE, 8, 4)
+    FIELD(TR_RAM_IMPL, HAS_SRAM, 12, 1)
+    FIELD(TR_RAM_IMPL, HAS_SMEM, 13, 1)
+    /* reserved bits */
+    FIELD(TR_RAM_IMPL, RSVP1, 14, 18)
+
+REG32(TR_RAM_START_LOW, 0x010)
+    FIELD(TR_RAM_START_LOW, ADDR, 2, 30)
+REG32(TR_RAM_START_HIGH, 0x014)
+    FIELD(TR_RAM_START_HIGH, ADDR, 0, 32)
+
+REG32(TR_RAM_LIMIT_LOW, 0x018)
+    FIELD(TR_RAM_LIMIT_LOW, ADDR, 2, 30)
+REG32(TR_RAM_LIMIT_HIGH, 0x01C)
+    FIELD(TR_RAM_LIMIT_HIGH, ADDR, 0, 32)
+
+REG32(TR_RAM_WP_LOW, 0x020)
+    FIELD(TR_RAM_WP_LOW, WRAP, 0, 1)
+    FIELD(TR_RAM_WP_LOW, ADDR, 2, 30)
+REG32(TR_RAM_WP_HIGH, 0x024)
+    FIELD(TR_RAM_WP_HIGH, ADDR, 0, 32)
+
+struct TraceRamSink {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    MemoryRegion reg_mem;
+    uint32_t reg_mem_size;
+
+    hwaddr baseaddr;
+    uint32_t regs[TRACE_R_MAX];
+    RegisterInfo regs_info[TRACE_R_MAX];
+
+    hwaddr smemaddr;
+    MemoryRegion smem;
+    uint32_t smemsize;
+    uint8_t *msgs;
+};
+
+#define TYPE_TRACE_RAM_SINK "trace-ram-sink"
+
+OBJECT_DECLARE_SIMPLE_TYPE(TraceRamSink, TRACE_RAM_SINK)
+
+#endif
-- 
2.51.0


