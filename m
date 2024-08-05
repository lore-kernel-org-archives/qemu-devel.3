Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D730EC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49k-0005co-NW; Mon, 05 Aug 2024 16:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3djOxZgUKCt0S9UHOFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--tavip.bounces.google.com>)
 id 1sb49e-0004kR-FJ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:18:07 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3djOxZgUKCt0S9UHOFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--tavip.bounces.google.com>)
 id 1sb49a-0001Xd-Ue
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:18:06 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2cd2c7904dcso10970947a91.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889080; x=1723493880; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=u4G3+QfEQuPGYkcQf8AOgE2UDxpBxkJrxB1kWGdX9cU=;
 b=ez+dIN6o0yfY+RQX3vua/ge+lTOQ3I095HhrufQmI3cW1wXip0gLTiH65Vs3XbQ67H
 YirHe/M8H9eEfekVjtsI9DlNws6DWBdkgaShHvhd4sC6pPV7rkARZ+mmh/g8X7ZWYC7T
 gsiKmttveQOFb67G+6jdvwG1ao9JagpRI2s1RwpA4A/qYNSHbDtRT8G4YJcH8uJbBrz0
 0OLXqhEpNEd0E8Fm3lEWUrfgGthYMKNKZSess28958ZCwNGr16ldiTOQBL/YmaLbY7a6
 hjxADkP+Wnu8iY/yLcH/B4ZyPczPMBYBKqAjMbwQxtkH4xGIubKmy2AGYSJpcpjeM6sI
 8r7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889080; x=1723493880;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u4G3+QfEQuPGYkcQf8AOgE2UDxpBxkJrxB1kWGdX9cU=;
 b=N+NdQj+y67MzWenynRKjtimHAxleZq8TYp5ycw2Pa/SE7zolY/TlwH0D55LWoX1r7n
 0T5Clm0NO3RSYF21ZOVOkrfvLg6AXNw644112P9l0p+SI1RHWjK0EPFa58WEZx9XV1+H
 ByWYntBI8J90wL6+WauaJdLiPXcnbcVqNGxz8+b0RBDai7mStAjlVp6W95lM2biFGlPn
 X9CWvA2E5JL2Jm9IfigVDfJm7VJBMAi81npZ9TdsUu2pnsJFuOpsmti8uu433cR4VTCj
 a9jLuCusyr43Nl1zNzMzkjWqnNbQ4igpH89zszY7hE+DATWTGIL2KcjvaGFkc02KegN8
 taUA==
X-Gm-Message-State: AOJu0YxRPov8UUJ/0QAcwEWpR44GMJ7kEYS8Fi12RdwXKnG1sltvPu3J
 pJfucrzQ3xpHHPVEzdQ/kRrUMYxLgVAnnn2fuBC4vjQng+pjlD0r/CPRYyy50wZYgNoqBVEuFHN
 hUT1sqLd0MPvSMDe58SA9Cr9lmaZWCrVxvTRzNCznxXWKmXQCXsfr+El7DNji2dSlozHJrAUXXy
 wkAVbkdbnJFDdYAAVzcjRrIve47g==
X-Google-Smtp-Source: AGHT+IFou9H80QB90t2SGEHQlrSm6cRFXg4Q/BYZGtoq36SYjaPwpS566HoPuRH/kcQrZnxxlae98b/Ryw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90a:6042:b0:2c3:1985:e9c3
 with SMTP id
 98e67ed59e1d1-2cff95243c6mr34825a91.3.1722889078446; Mon, 05 Aug 2024
 13:17:58 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:16 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-22-tavip@google.com>
Subject: [RFC PATCH 21/23] hw/misc: add support for RT500 reset controller
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3djOxZgUKCt0S9UHOFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--tavip.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The RT500 reset controller has two instances that have the same
register layout but with different fields for some registers.

The model only provides set and clear functionality for the various
reset lines which is common for both instances. Because of that only
one type is implemented for both controllers.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 hw/arm/svd/meson.build         |   8 ++
 hw/misc/Kconfig                |   3 +
 hw/misc/meson.build            |   1 +
 hw/misc/rt500_rstctl.c         | 219 +++++++++++++++++++++++++++++++++
 hw/misc/trace-events           |   4 +
 include/hw/misc/rt500_rstctl.h |  38 ++++++
 6 files changed, 273 insertions(+)
 create mode 100644 hw/misc/rt500_rstctl.c
 create mode 100644 include/hw/misc/rt500_rstctl.h

diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
index 22f75880f5..72a7421c6f 100644
--- a/hw/arm/svd/meson.build
+++ b/hw/arm/svd/meson.build
@@ -26,3 +26,11 @@ genh += custom_target('flexspi.h',
                       output: 'flexspi.h',
                       input: 'MIMXRT595S_cm33.xml',
                       command: [ svd_gen_header, '-i', '@INPUT@', '-o', '@OUTPUT@', '-p', 'FLEXSPI0', '-t', 'FLEXSPI'])
+genh += custom_target('rt500_rstctl0.h',
+                      output: 'rt500_rstctl0.h',
+                      input: 'MIMXRT595S_cm33.xml',
+                      command: [ svd_gen_header, '-i', '@INPUT@', '-o', '@OUTPUT@', '-p', 'RSTCTL0', '-t', 'RT500_RSTCTL0'])
+genh += custom_target('rt500_rstctl1.h',
+                      output: 'rt500_rstctl1.h',
+                      input: 'MIMXRT595S_cm33.xml',
+                      command: [ svd_gen_header, '-i', '@INPUT@', '-o', '@OUTPUT@', '-p', 'RSTCTL1', '-t', 'RT500_RSTCTL1'])
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 392ae9e84f..70a2a269ac 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -222,4 +222,7 @@ config RT500_CLKCTL0
 config RT500_CLKCTL1
     bool
 
+config RT500_RSTCTL
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 68929949a6..5e2728e982 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -160,3 +160,4 @@ system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
 system_ss.add(when: 'CONFIG_RT500_CLKCTL0', if_true: files('rt500_clkctl0.c'))
 system_ss.add(when: 'CONFIG_RT500_CLKCTL1', if_true: files('rt500_clkctl1.c'))
+system_ss.add(when: 'CONFIG_RT500_RSTCTL', if_true: files('rt500_rstctl.c'))
diff --git a/hw/misc/rt500_rstctl.c b/hw/misc/rt500_rstctl.c
new file mode 100644
index 0000000000..2806a94150
--- /dev/null
+++ b/hw/misc/rt500_rstctl.c
@@ -0,0 +1,219 @@
+/*
+ * QEMU model for RT500 Reset Controller
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
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "exec/address-spaces.h"
+#include "hw/regs.h"
+#include "hw/misc/rt500_rstctl.h"
+
+#include "trace.h"
+
+/*
+ * There are two intances for RSTCTL with the same register names but
+ * with different fields.
+ */
+#define reg(field) offsetof(RT500_RSTCTL0_Type, field)
+#define regi(x) (reg(x) / sizeof(uint32_t))
+#define REG_NO (sizeof(RT500_RSTCTL0_Type) / sizeof(uint32_t))
+
+#define RSTCTL_SYSRSTSTAT_WMASK (BITS(7, 4) | BIT(0))
+#define RSTCL0_PRSCTL0_WMASK (BITS(30, 26) | BITS(24, 20) | BIT(18) | \
+                              BIT(16) | BITS(12, 8) | BIT(3) | BIT(1))
+#define RSTCL0_PRSCTL1_WMASK (BIT(24) | BITS(16, 15) | BITS(3, 2))
+#define RSTCL0_PRSCTL2_WMASK (BITS(1, 0))
+#define RSTCL1_PRSCTL0_WMASK (BIT(29) | BIT(27) |  BITS(25, 8))
+#define RSTCL1_PRSCTL1_WMASK (BIT(31) | BITS(29, 28) | BITS(24, 23) | \
+                              BIT(16) | BITS(7, 0))
+#define RSTCL1_PRSCTL2_WMASK (BITS(31, 30) | BITS(17, 16) | BIT(10) | \
+                              BIT(8) | BITS(4, 0))
+
+static RT500_RSTCTL0_REGISTER_NAMES_ARRAY(reg_names);
+
+static MemTxResult rt500_rstctl_read(void *opaque, hwaddr addr,
+                                     uint64_t *data, unsigned size,
+                                     MemTxAttrs attrs)
+{
+    RT500RstCtlState *s = opaque;
+    MemTxResult ret = MEMTX_OK;
+
+    if (s->num > 1 || !reg32_aligned_access(addr, size)) {
+        ret = MEMTX_ERROR;
+        goto out;
+    }
+
+    switch (addr) {
+    case reg(SYSRSTSTAT):
+    case reg(PRSTCTL0):
+    case reg(PRSTCTL1):
+    case reg(PRSTCTL2):
+        *data = reg32_read(&s->regs.ctl0, addr);
+        break;
+    default:
+        ret = MEMTX_ERROR;
+    }
+
+out:
+    trace_rt500_rstctl_reg_read(DEVICE(s)->id, reg_names[addr], addr, *data);
+    return ret;
+}
+
+static MemTxResult rt500_rstctl_write(void *opaque, hwaddr addr,
+                                      uint64_t value, unsigned size,
+                                      MemTxAttrs attrs)
+{
+    RT500RstCtlState *s = opaque;
+    static uint32_t mask0[REG_NO] = {
+        [regi(SYSRSTSTAT)] = RSTCTL_SYSRSTSTAT_WMASK,
+        [regi(PRSTCTL0)] = RSTCL0_PRSCTL0_WMASK,
+        [regi(PRSTCTL1)] = RSTCL0_PRSCTL1_WMASK,
+        [regi(PRSTCTL2)] = RSTCL0_PRSCTL2_WMASK,
+        [regi(PRSTCTL0_SET)] = RSTCL0_PRSCTL0_WMASK,
+        [regi(PRSTCTL1_SET)] = RSTCL0_PRSCTL1_WMASK,
+        [regi(PRSTCTL2_SET)] = RSTCL0_PRSCTL2_WMASK,
+        [regi(PRSTCTL0_CLR)] = RSTCL0_PRSCTL0_WMASK,
+        [regi(PRSTCTL1_CLR)] = RSTCL0_PRSCTL1_WMASK,
+        [regi(PRSTCTL2_CLR)] = RSTCL0_PRSCTL2_WMASK,
+    };
+    static uint32_t mask1[REG_NO] = {
+        [regi(SYSRSTSTAT)] = RSTCTL_SYSRSTSTAT_WMASK,
+        [regi(PRSTCTL0)] = RSTCL1_PRSCTL0_WMASK,
+        [regi(PRSTCTL1)] = RSTCL1_PRSCTL1_WMASK,
+        [regi(PRSTCTL2)] = RSTCL1_PRSCTL2_WMASK,
+        [regi(PRSTCTL0_SET)] = RSTCL1_PRSCTL0_WMASK,
+        [regi(PRSTCTL1_SET)] = RSTCL1_PRSCTL1_WMASK,
+        [regi(PRSTCTL2_SET)] = RSTCL1_PRSCTL2_WMASK,
+        [regi(PRSTCTL0_CLR)] = RSTCL1_PRSCTL0_WMASK,
+        [regi(PRSTCTL1_CLR)] = RSTCL1_PRSCTL1_WMASK,
+        [regi(PRSTCTL2_CLR)] = RSTCL1_PRSCTL2_WMASK,
+    };
+    uint32_t mask;
+
+    trace_rt500_rstctl_reg_write(DEVICE(s)->id, reg_names[addr], addr, value);
+
+    if (s->num > 1 || !reg32_aligned_access(addr, size)) {
+        return MEMTX_ERROR;
+    }
+
+    if (s->num == 0) {
+        mask = mask0[addr / sizeof(uint32_t)];
+    } else {
+        mask = mask1[addr / sizeof(uint32_t)];
+    }
+
+    switch (addr) {
+    case reg(SYSRSTSTAT):
+    {
+        /* write 1 to clear bits */
+        s->regs.ctl0.SYSRSTSTAT &= ~(value & mask);
+        break;
+    }
+    case reg(PRSTCTL0):
+    case reg(PRSTCTL1):
+    case reg(PRSTCTL2):
+    {
+        uint32_t idx = addr / sizeof(uint32_t);
+
+        s->regs.raw[idx] = (value & mask);
+        break;
+    }
+    case reg(PRSTCTL0_SET):
+    case reg(PRSTCTL1_SET):
+    case reg(PRSTCTL2_SET):
+    {
+        uint32_t idx;
+
+        idx = (reg(PRSTCTL0) + (addr - reg(PRSTCTL0_SET))) / sizeof(uint32_t);
+        s->regs.raw[idx] |= (value & mask);
+        break;
+    }
+    case reg(PRSTCTL0_CLR):
+    case reg(PRSTCTL1_CLR):
+    case reg(PRSTCTL2_CLR):
+    {
+        uint32_t idx;
+
+        idx = (reg(PRSTCTL0) + (addr - reg(PRSTCTL0_CLR))) / sizeof(uint32_t);
+        s->regs.raw[idx] &= ~(value & mask);
+        break;
+    }
+    }
+
+    return MEMTX_OK;
+}
+
+
+static const MemoryRegionOps rt500_rstctl_ops = {
+    .read_with_attrs = rt500_rstctl_read,
+    .write_with_attrs = rt500_rstctl_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static Property rt500_rstctl_properties[] = {
+    DEFINE_PROP_UINT32("num", RT500RstCtlState, num, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rt500_rstctl_reset(DeviceState *dev)
+{
+    RT500RstCtlState *s = RT500_RSTCTL(dev);
+
+    memset(&s->regs, 0, sizeof(s->regs));
+
+    switch (s->num) {
+    case 0:
+        rt500_rstctl0_reset_registers(&s->regs.ctl0);
+        break;
+    case 1:
+        rt500_rstctl1_reset_registers(&s->regs.ctl1);
+        break;
+    }
+}
+
+static void rt500_rstctl_init(Object *obj)
+{
+    RT500RstCtlState *s = RT500_RSTCTL(obj);
+
+    memory_region_init_io(&s->mmio, obj, &rt500_rstctl_ops, s,
+                          TYPE_RT500_RSTCTL, sizeof(s->regs));
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void rt500_rstctl_realize(DeviceState *dev, Error **errp)
+{
+}
+
+static void rt500_rstctl_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = rt500_rstctl_reset;
+    device_class_set_props(dc, rt500_rstctl_properties);
+    dc->realize = rt500_rstctl_realize;
+}
+
+static const TypeInfo rt500_rstctl_info = {
+    .name          = TYPE_RT500_RSTCTL,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RT500RstCtlState),
+    .instance_init = rt500_rstctl_init,
+    .class_init    = rt500_rstctl_class_init,
+};
+
+static void rt500_rstctl_register_types(void)
+{
+    type_register_static(&rt500_rstctl_info);
+}
+
+type_init(rt500_rstctl_register_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index e65fcfa613..41a94d5ef6 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -365,3 +365,7 @@ rt500_clkctl0_reg_write(const char *regname, uint32_t addr, uint32_t val) "%s[0x
 # rt500_clkctl1.c
 rt500_clkctl1_reg_read(const char *regname, uint32_t addr, uint32_t val) "%s[0x%04x] -> 0x%08x"
 rt500_clkctl1_reg_write(const char *regname, uint32_t addr, uint32_t val) "%s[0x%04x] <- 0x%08x"
+
+# rt500_rstctl.c
+rt500_rstctl_reg_read(const char *id, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] -> 0x%08x"
+rt500_rstctl_reg_write(const char *id, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
diff --git a/include/hw/misc/rt500_rstctl.h b/include/hw/misc/rt500_rstctl.h
new file mode 100644
index 0000000000..d9726df5f6
--- /dev/null
+++ b/include/hw/misc/rt500_rstctl.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU model for RT500 Reset Controller
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_MISC_RT500_RSTCTL_H
+#define HW_MISC_RT500_RSTCTL_H
+
+#include "hw/arm/svd/rt500_rstctl0.h"
+#include "hw/arm/svd/rt500_rstctl1.h"
+#include "hw/sysbus.h"
+
+#define RSTCTL_Type RSTCTL0_Type
+
+#define TYPE_RT500_RSTCTL "rt500-rstctl"
+#define RT500_RSTCTL(o) OBJECT_CHECK(RT500RstCtlState, o, TYPE_RT500_RSTCTL)
+
+typedef struct {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion mmio;
+    uint32_t num;
+    union {
+        RT500_RSTCTL0_Type ctl0;
+        RT500_RSTCTL1_Type ctl1;
+        uint32_t raw[sizeof(RT500_RSTCTL0_Type) / sizeof(uint32_t)];
+    } regs;
+} RT500RstCtlState;
+
+#endif /* HW_MISC_RT500_RSTCTL_H */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


