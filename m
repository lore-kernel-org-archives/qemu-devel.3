Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B3DC52D71
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49j-0005Mp-EP; Mon, 05 Aug 2024 16:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3dDOxZgUKCtsQ7SFMDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--tavip.bounces.google.com>)
 id 1sb49c-0004XP-TA
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:18:05 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3dDOxZgUKCtsQ7SFMDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--tavip.bounces.google.com>)
 id 1sb49Y-0001X1-6h
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:18:04 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e0bfd36cda0so4034171276.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889077; x=1723493877; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=uWXVZOdEqjXdKO04u4G3py2UIxHgdgvpM9yktaFqR4s=;
 b=TyNyglI0Wm0hq600I5vrTma3NUxb3X1E4DY3LNGV01r3WzvnQBheevL9RhYLvwEcr6
 S4xbu7NjEd+C6HyifnD8dJTyzElbqZaULqpD+pAIq8HCDMnAlfSe5RcysVyKkBM4Aezl
 9spGypb/XTkSRmgQIRc4izUWmf+qFRFNW+75UXbo7FHuEV7X5cuYshUTOLud6H8uDIRP
 kZX4an4GZRzR7LcftLnrAfKPWsGHAjf3ZWW+jazzfoAgOFA0PPUzlCHy2BeI2dp5o9C2
 G4sD7qN7klwdvNV0mBMVTWZXGyP3OLPS2O87GzYwrBZ9aFjKm+OucZlP2dznv7iszOw3
 eYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889077; x=1723493877;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uWXVZOdEqjXdKO04u4G3py2UIxHgdgvpM9yktaFqR4s=;
 b=mVV8l4kst3bBR9IxuX7Iwr+ZPn69NReUnB/eu/m1s3aJPPiQFrAoG0Pn9/iX9j4yRQ
 ESulF6RkYjRGh5c1LfidsUkQcWWz57TyqIgbCFNozDdaOw4PM9b2k8tJZkwQmPDnN7LK
 9Pv+O3olGX5oKQ5D6xxtbnMcveoXlPqUgctYHMDOX5dA4Il1cil4LzL3QNVyyd48a1kW
 UprIBKHOacHDqWPiTWi/Pz9zqTN/usJ3WR1wwvqJB88mi/LOGp/2KIE1WoLyH2QZwjW8
 uabuYgCeaPXgtQrZDLCAgoX2VPKoH+0pGCFfMRXFWIjwGINTXcAhaufRcV3tsMqTTPcs
 ghJw==
X-Gm-Message-State: AOJu0YxIKL1hFOtV8wR+eZ7Yj/9mYQfqZkoGaYVEyG9DIdIypD/T/Iq7
 Hr+Q9QgWqXbUgIBfES1J3JQbBURHka5g7XDPmTJRBd6W2gV337mG85pm+G0u2fppHWgg1IhqOr3
 h9ElrUiI1v6IqMB1QZYtIo29Rrg0zrHWsY4Tm7icalwenuh98u4qCifQZl6Lo8owAh+drmx4lIj
 wJzuK3qz5KmpgsXQrDQRJiCASOkQ==
X-Google-Smtp-Source: AGHT+IF6ad53oY6Byn5ycWISeZ4CH5DfNX2AzNIngdoOEtPty6mxbdGKKGCvTPgplaEx4QLHEjhsPUrOdQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:ce54:0:b0:e0b:e23a:9713 with
 SMTP id
 3f1490d57ef6-e0be23a97a3mr31090276.1.1722889076722; Mon, 05 Aug 2024 13:17:56
 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:15 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-21-tavip@google.com>
Subject: [RFC PATCH 20/23] hw/ssi: add support for flexspi
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3dDOxZgUKCtsQ7SFMDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This is mostly a stub which completes SPI transactions as noops
by masking out the error interrupts and never clearing the IPCMDDONE
interrupt.

Although incomplete, this allows software that uses NXP's mcuxpresso
SDK to run the SDK board initialization functions.

It also supports AHB memory access, aka XIP, for now as simple RAM
memory regions.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 hw/arm/svd/meson.build   |   4 +
 hw/ssi/Kconfig           |   4 +
 hw/ssi/flexspi.c         | 216 +++++++++++++++++++++++++++++++++++++++
 hw/ssi/meson.build       |   1 +
 hw/ssi/trace-events      |   4 +
 include/hw/ssi/flexspi.h |  34 ++++++
 6 files changed, 263 insertions(+)
 create mode 100644 hw/ssi/flexspi.c
 create mode 100644 include/hw/ssi/flexspi.h

diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 6ab13f8757..22f75880f5 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -22,3 +22,7 @@ genh += custom_target('rt500_clkctl1.h',
                       output: 'rt500_clkctl1.h',
                       input: 'MIMXRT595S_cm33.xml',
                       command: [ svd_gen_header, '-i', '@INPUT@', '-o', '@OUTPUT@', '-p', 'CLKCTL1', '-t', 'RT500_CLKCTL1'])
+genh += custom_target('flexspi.h',
+                      output: 'flexspi.h',
+                      input: 'MIMXRT595S_cm33.xml',
+                      command: [ svd_gen_header, '-i', '@INPUT@', '-o', '@OUTPUT@', '-p', 'FLEXSPI0', '-t', 'FLEXSPI'])
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 83ee53c1d0..fb8feeb024 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -24,3 +24,7 @@ config STM32F2XX_SPI
 config BCM2835_SPI
     bool
     select SSI
+
+config FLEXSPI
+    bool
+    select SSI
diff --git a/hw/ssi/flexspi.c b/hw/ssi/flexspi.c
new file mode 100644
index 0000000000..305d1a5bac
--- /dev/null
+++ b/hw/ssi/flexspi.c
@@ -0,0 +1,216 @@
+/*
+ * QEMU model for FLEXSPI
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/mmap-alloc.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "exec/address-spaces.h"
+#include "hw/regs.h"
+#include "hw/ssi/flexspi.h"
+#include "hw/arm/svd/flexspi.h"
+
+#include "trace.h"
+
+#define reg(field) offsetof(FLEXSPI_Type, field)
+#define regi(x) (reg(x) / sizeof(uint32_t))
+#define REG_NO (sizeof(FLEXSPI_Type) / sizeof(uint32_t))
+
+static FLEXSPI_REGISTER_NAMES_ARRAY(reg_names);
+
+static void flexspi_reset(DeviceState *dev)
+{
+    FlexSpiState *s = FLEXSPI(dev);
+
+    memset(&s->regs, 0, sizeof(s->regs));
+
+    flexspi_reset_registers(&s->regs);
+
+    /* idle immediately after reset */
+    s->regs.STS0_b.SEQIDLE = 1;
+}
+
+static MemTxResult flexspi_read(void *opaque, hwaddr addr,
+                                     uint64_t *data, unsigned size,
+                                     MemTxAttrs attrs)
+{
+    FlexSpiState *s = opaque;
+    MemTxResult ret = MEMTX_OK;
+
+    if (!reg32_aligned_access(addr, size)) {
+        ret = MEMTX_ERROR;
+        goto out;
+    }
+
+    switch (addr) {
+    default:
+        *data = reg32_read(&s->regs, addr);
+        break;
+    }
+
+out:
+    trace_flexspi_reg_read(DEVICE(s)->id, reg_names[addr], addr, *data);
+    return ret;
+}
+
+static uint32_t wr_mask[REG_NO] = {
+    [regi(MCR0)] = BITS(31, 14) | BITS(12, 8) | BITS(5, 4) | BITS(1, 0),
+    [regi(MCR1)] = BITS(31, 0),
+    [regi(MCR2)] = BITS(31, 24) | BIT(11),
+    [regi(AHBCR)] = BIT(10) | BITS(7, 2) | BIT(0),
+    [regi(INTEN)] = BITS(13, 0),
+    /*
+     * TODO: once SPI transfers are implemented restore mask to:
+     *
+     * [regi(INTR)] = BIT(16) | BITS(12, 0).
+     *
+     * In the meantime this INTR mask allows for fake SPI transfers.
+     */
+    [regi(INTR)] = BIT(0),
+    [regi(LUTKEY)] = BITS(31, 0),
+    [regi(LUTCR)] = BITS(1, 0),
+    [regi(AHBRXBUF0CR0)] = BIT(31) | BITS(26, 24) | BITS(19, 16) | BITS(7, 0),
+    [regi(AHBRXBUF1CR0)] = BIT(31) | BITS(26, 24) | BITS(19, 16) | BITS(7, 0),
+    [regi(AHBRXBUF2CR0)] = BIT(31) | BITS(26, 24) | BITS(19, 16) | BITS(7, 0),
+    [regi(AHBRXBUF3CR0)] = BIT(31) | BITS(26, 24) | BITS(19, 16) | BITS(7, 0),
+    [regi(AHBRXBUF4CR0)] = BIT(31) | BITS(26, 24) | BITS(19, 16) | BITS(7, 0),
+    [regi(AHBRXBUF5CR0)] = BIT(31) | BITS(26, 24) | BITS(19, 16) | BITS(7, 0),
+    [regi(AHBRXBUF6CR0)] = BIT(31) | BITS(26, 24) | BITS(19, 16) | BITS(7, 0),
+    [regi(AHBRXBUF7CR0)] = BIT(31) | BITS(26, 24) | BITS(19, 16) | BITS(7, 0),
+    [regi(FLSHA1CR0)] = BITS(22, 0),
+    [regi(FLSHA2CR0)] = BITS(22, 0),
+    [regi(FLSHB1CR0)] = BITS(22, 0),
+    [regi(FLSHB2CR0)] = BITS(22, 0),
+    [regi(FLSHCR1A1)] = BITS(31, 0),
+    [regi(FLSHCR1A2)] = BITS(31, 0),
+    [regi(FLSHCR1B1)] = BITS(31, 0),
+    [regi(FLSHCR1B2)] = BITS(31, 0),
+    [regi(FLSHCR2A1)] = BITS(30, 13) | BITS(11, 5) | BITS(3, 0),
+    [regi(FLSHCR2A2)] = BITS(30, 13) | BITS(11, 5) | BITS(3, 0),
+    [regi(FLSHCR2B1)] = BITS(30, 13) | BITS(11, 5) | BITS(3, 0),
+    [regi(FLSHCR2B2)] = BITS(30, 13) | BITS(11, 5) | BITS(3, 0),
+    [regi(FLSHCR4)] = BITS(3, 2) | BIT(0),
+    [regi(IPCR0)] = BITS(31, 0),
+    [regi(IPCR1)] = BIT(31) | BITS(26, 24) | BITS(19, 0),
+    [regi(IPCMD)] = BIT(1),
+    [regi(DLPR)] = BITS(31, 0),
+    [regi(IPRXFCR)] = BITS(8, 0),
+    [regi(IPTXFCR)] = BITS(8, 0),
+    [regi(DLLCRA)] = BITS(14, 8) | BITS(6, 3) | BITS(1, 0),
+    [regi(DLLCRB)] = BITS(14, 8) | BITS(6, 3) | BITS(1, 0),
+    [regi(HADDRSTART)] = BITS(31, 12) | BIT(0),
+    [regi(HADDREND)] = BITS(31, 12),
+    [regi(HADDROFFSET)] = BITS(31, 12),
+};
+
+static MemTxResult flexspi_write(void *opaque, hwaddr addr,
+                                      uint64_t value, unsigned size,
+                                      MemTxAttrs attrs)
+{
+    FlexSpiState *s = opaque;
+    MemTxResult ret = MEMTX_OK;
+
+    trace_flexspi_reg_write(DEVICE(s)->id, reg_names[addr], addr, value);
+
+    if (!reg32_aligned_access(addr, size)) {
+        ret = MEMTX_ERROR;
+        goto out;
+    }
+
+    switch (addr) {
+    case reg(MCR0):
+    {
+        reg32_write(&s->regs, addr, value, wr_mask);
+
+        if (s->regs.MCR0_b.SWRESET) {
+            s->regs.MCR0_b.SWRESET = 0;
+        }
+        break;
+    }
+
+    default:
+        reg32_write(&s->regs, addr, value, wr_mask);
+        break;
+    }
+
+out:
+    return ret;
+}
+
+static const MemoryRegionOps flexspi_ops = {
+    .read_with_attrs = flexspi_read,
+    .write_with_attrs = flexspi_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static Property flexspi_properties[] = {
+    DEFINE_PROP_UINT32("mmap_base", FlexSpiState, mmap_base, 0),
+    DEFINE_PROP_UINT32("mmap_size", FlexSpiState, mmap_size, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void flexspi_init(Object *obj)
+{
+    FlexSpiState *s = FLEXSPI(obj);
+
+    memory_region_init_io(&s->mmio, obj, &flexspi_ops, s, TYPE_FLEXSPI,
+                          sizeof(FLEXSPI_Type));
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void flexspi_realize(DeviceState *dev, Error **errp)
+{
+    FlexSpiState *s = FLEXSPI(dev);
+
+    if (s->mmap_size) {
+        memory_region_init_ram(&s->mem, OBJECT(s), DEVICE(s)->id, s->mmap_size,
+                               NULL);
+        memory_region_add_subregion(get_system_memory(), s->mmap_base, &s->mem);
+    }
+}
+
+static void flexspi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = flexspi_reset;
+    dc->realize = flexspi_realize;
+    device_class_set_props(dc, flexspi_properties);
+}
+
+static const TypeInfo flexspi_info = {
+    .name          = TYPE_FLEXSPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(FlexSpiState),
+    .instance_init = flexspi_init,
+    .class_init    = flexspi_class_init,
+};
+
+static void flexspi_register_types(void)
+{
+    int i;
+
+    for (i = 0; i < 32; i++) {
+        wr_mask[regi(TFDR[i])] = BITS(31, 0);
+    }
+    for (i = 0; i < 64; i++) {
+        wr_mask[regi(LUT[i])] = BITS(31, 0);
+    }
+
+    type_register_static(&flexspi_info);
+}
+
+type_init(flexspi_register_types)
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 57d3e14727..c5b7e0a6e2 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm_spi.c'))
+system_ss.add(when: 'CONFIG_FLEXSPI', if_true: files('flexspi.c'))
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 5caa1c17ac..d623022a79 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -40,3 +40,7 @@ flexcomm_spi_fifostat(const char *id, uint32_t fifostat, uint32_t fifoinstat) "%
 flexcomm_spi_irq(const char *id, bool irq, bool fifoirqs, bool perirqs, bool enabled) "%s: %d %d %d %d"
 flexcomm_spi_chr_rx_space(const char *id, uint32_t rx) "%s: %d"
 flexcomm_spi_chr_rx(const char *id) "%s"
+
+# flexspi.c
+flexspi_reg_read(const char *id, const char *reg_name, uint32_t addr, uint32_t val) " %s: %s[0x%04x] -> 0x%08x"
+flexspi_reg_write(const char *id, const char *reg_name, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
diff --git a/include/hw/ssi/flexspi.h b/include/hw/ssi/flexspi.h
new file mode 100644
index 0000000000..f5fea9dee9
--- /dev/null
+++ b/include/hw/ssi/flexspi.h
@@ -0,0 +1,34 @@
+/*
+ * QEMU model for FLEXSPI
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_RT500_FLEXSPI_H
+#define HW_RT500_FLEXSPI_H
+
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "hw/arm/svd/flexspi.h"
+
+#define TYPE_FLEXSPI "flexspi"
+#define FLEXSPI(obj) OBJECT_CHECK(FlexSpiState, (obj), TYPE_FLEXSPI)
+
+typedef struct {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion mmio;
+    FLEXSPI_Type regs;
+    MemoryRegion mem;
+    uint32_t mmap_base;
+    uint32_t mmap_size;
+} FlexSpiState;
+
+#endif /* HW_RT500_FLEXSPI_H */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


