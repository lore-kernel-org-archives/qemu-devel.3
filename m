Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602C9C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqE-0001xG-HI; Wed, 19 Aug 2026 22:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsq6-0001tf-57
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:11 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsq2-0000XN-FM
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:09 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6689f36ae56so2769308d50.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194145; x=1787798945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ygAKHpfEFntgLi2EqDMDtidbEQfQyaObkdNGGpsh9B4=;
 b=Un3KGDXrEn5ahE8LcY7TVfu9g5uOpL/J6fQQonD0T2lBc+NE8RK4J536UXcWf51kZi
 tipCsMMf6b5vq83kUesNTr4DXd/8n/jlTSmrBtpC5+L4rDd5JVwcOa7nJ9TLzfTSLOEi
 F96lXE37E6HUIyoNQuC5sJ1D2fe1C7bOT8oFxUHj7PCDI932FOmM9x8CyQzC5RBuPZk1
 ywSSaSj4YeTYdefHbNjm5aQJe52u/M9L5ICB/gWV13eQngviRNP1Rd1FEYtOb08jbz3p
 BVEKc8HRZgw/SbFPD4UkdVZOBMhqJdOwimrPPALl1ynqJKA8/eBFGmA0AjIAdS66wEl1
 YORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194145; x=1787798945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ygAKHpfEFntgLi2EqDMDtidbEQfQyaObkdNGGpsh9B4=;
 b=RsbVl9G56GF8GxapfNa2wM1PPf7g12TICEB01sWl4jHodS97Muq1eyvL9/lQWg0afP
 BKBfdwfsMysmiK9lMTLuTaKGbfj8fduUkFdi9wXEWE2Ffl0KnzDeA/SdyXOzeR1rvoW0
 mhmAZzYDcE+mzKbJcPBn+NmL+R6QM4rhFQxOlTKMObRwqeX1d/lCufX5tiOhEoG8877G
 wBV/haPjo8BJvzicncK4udlTY5Lfe0DzhxI45dbLBeXeiPRtUL5GhcgQ1vWafv3tYwtw
 YntbFI+8U8VtekkyoKcaYSHTAC8SV0xJixxc/OhHLAxbtYobeSv27XCLTS+4FccgSSdE
 gkoA==
X-Gm-Message-State: AFuF++l8f4991GS+vJZ1BqsRgau40HjnBcG5bOc5q2l/PT7quFOfiEJM
 wDjZDnx8Wo+DRAVaPC/cfzUsQc8hDdkhIgAXRvpwnNa7xbvaqZhlafggcWu3gg==
X-Gm-Gg: AR+sD13Z8trJOk+vUGQ8t5/5x53Sc+G3wLO7ns5AbxTjfGKYCMKu+oQ94aAqjJSX7jM
 ndn71MbAbD4KDfqvVNQeIm5NgE3N7gSjU+G4WdO4flVs9VhUB8lJjCJasZ8booVvNmVeEx+Otdv
 Wf7/e5hiSGLt7Qo3YheSDwXPcfjVuY1B8jsQjcVSkCo3GnMU79EYjWXsmAg8miMF5ih32C8JvIH
 9IeRqH+AekkHBS+THF30DViC3h8OWpw6Otkcq0+drnG6B3iLcULFJ6Ds3b5bfL/KunQy0m3pUYn
 EAP2PM8wGmvPul7ufl/UAJjeYcLBBTIvX8PIGGvRNVTvQHObbdK/k7gEoQ3xgeHkNgVU+RGkMS2
 QKOhBK/XU1+gxMLyh1PtG76kqfATU+Ljxl+Gb0RZx8wwfXKl/VcpeBw7UkpiGz5L5/B1WmCKeJV
 jmAvHAaXRtMfuuc1qJ8ki8q5oob5aRylEi0JNg42hv3axABXnWtN9GDLvRm6GoHyxFKV0m9rIPD
 4VDz1teWUs+/WyknjPDcqKUQ/CJFui+OzVrjOtswJQvF/mzU7eNtUvzjf4=
X-Received: by 2002:a05:690e:4368:b0:66c:7bd2:35a9 with SMTP id
 956f58d0204a3-66ccb798350mr2800808d50.45.1787194144997; 
 Wed, 19 Aug 2026 19:49:04 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:49:03 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:MCIMX95-19X19-EVK...)
Subject: [PATCH 11/16] hw/misc: add i.MX 95 ANATOP/AONMIX/GPC/SRC power and
 clock blocks
Date: Wed, 19 Aug 2026 21:48:29 -0500
Message-Id: <20260820024834.3286721-12-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb12b.google.com
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

The power and clock bring-up blocks that the System Manager firmware
programs before Linux starts: ANATOP (PLL lock / DFS status), SRC
(system reset controller, including the M7 mix-slice release), GPC
(general power controller mode requests) and the AONMIX block-control M7
CPU-WAIT gate (the SM's M7 hold/run control). These are register-level
models that return the lock, ack and status bits the firmware polls.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/misc/Kconfig        |  12 +++
 hw/misc/imx95_anatop.c | 201 ++++++++++++++++++++++++++++++++++++
 hw/misc/imx95_aonmix.c | 160 +++++++++++++++++++++++++++++
 hw/misc/imx95_gpc.c    | 160 +++++++++++++++++++++++++++++
 hw/misc/imx95_src.c    | 228 +++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build    |   4 +
 hw/misc/trace-events   |   8 ++
 7 files changed, 773 insertions(+)
 create mode 100644 hw/misc/imx95_anatop.c
 create mode 100644 hw/misc/imx95_aonmix.c
 create mode 100644 hw/misc/imx95_gpc.c
 create mode 100644 hw/misc/imx95_src.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2bae76b4ec1..1e1cae92f6f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -271,3 +271,15 @@ config IMX95_ELE_SERVER
 
 config IMX95_WDOG
     bool
+
+config IMX95_ANATOP
+    bool
+
+config IMX95_AONMIX
+    bool
+
+config IMX95_GPC
+    bool
+
+config IMX95_SRC
+    bool
diff --git a/hw/misc/imx95_anatop.c b/hw/misc/imx95_anatop.c
new file mode 100644
index 00000000000..b8b18d405d0
--- /dev/null
+++ b/hw/misc/imx95_anatop.c
@@ -0,0 +1,201 @@
+/*
+ * NXP i.MX 95 ANATOP / PLL stub model
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Covers the ANATOP block at 0x44480000. Its PLL instances live at
+ * 0x44481000..0x444819ff, one every 0x100 (SYS_PLL1, AUDIO_PLL1/2,
+ * VIDEO_PLL1, ARM_PLL, DRAM_PLL, HSIO_PLL, LDB_PLL). Each PLL register
+ * uses the i.MX RW/SET/CLR/TOG quad layout (a 16-byte group: write +0 =
+ * assign, +4 = set bits, +8 = clear bits, +C = toggle; reads return the
+ * accumulated value), and each PLL has two read-only status words:
+ * PLL_STATUS (+0xf0, bit0 = PLL_LOCK) and DFS_STATUS (+0xf4, bits[3:0] =
+ * per-DFS clock-ok).
+ *
+ * The System Manager's DVFS path (DEV_SM_PerfA55FreqUpdate via
+ * FRACTPLL_UpdateRate / FRACTPLL_UpdateDfsRate) powers a PLL up by setting
+ * CTRL.POWERUP and then polls PLL_STATUS.PLL_LOCK; it enables a DFS and
+ * polls DFS_STATUS.DFS_OK (an unbounded wait). QEMU has no analog PLLs, so
+ * the transition is instantaneous: PLL_LOCK mirrors CTRL.POWERUP and a
+ * DFS's DFS_OK bit mirrors its DFS_CTRL.ENABLE. Everything else is plain
+ * storage. Same status-mirrors-control idea as the GPC/SRC models.
+ *
+ * Non-PLL parts of ANATOP (e.g. TMPSNS at +0x2000) are plain RAM here -
+ * the quad/status behaviour is confined to the PLL window.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define TYPE_IMX95_ANATOP "imx95.anatop"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX95AnatopState, IMX95_ANATOP)
+
+#define IMX95_ANATOP_REG_SIZE   0x10000
+#define IMX95_ANATOP_NUM_WORDS  (IMX95_ANATOP_REG_SIZE / 4)
+
+/* PLL window within ANATOP: [0x1000, 0x1a00), one PLL every 0x100. */
+#define ANATOP_PLL_START        0x1000
+#define ANATOP_PLL_END          0x1a00
+#define PLL_BLOCK_SIZE          0x100
+
+/* Per-PLL register offsets. */
+#define PLL_CTRL_OFF            0x00    /* RW/SET/CLR/TOG, POWERUP in bit 0 */
+#define PLL_DFS0_OFF            0x70    /* DFS[0] DFS_CTRL; step 0x20 */
+#define PLL_DFS_STEP            0x20
+#define PLL_NUM_DFS             4
+#define PLL_STATUS_OFF          0xf0    /* RO: PLL_LOCK in bit 0 */
+#define PLL_DFS_STATUS_OFF      0xf4    /* RO: DFS_OK in bits [3:0] */
+
+#define PLL_CTRL_POWERUP        0x00000001u
+#define PLL_STATUS_LOCK         0x00000001u
+#define PLL_DFS_CTRL_ENABLE     0x80000000u
+
+struct IMX95AnatopState {
+    SysBusDevice    parent_obj;
+    MemoryRegion    iomem;
+    uint32_t        regs[IMX95_ANATOP_NUM_WORDS];
+};
+
+static bool anatop_in_pll_window(hwaddr offset)
+{
+    return offset >= ANATOP_PLL_START && offset < ANATOP_PLL_END;
+}
+
+static uint64_t imx95_anatop_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX95AnatopState *s = opaque;
+
+    trace_imx95_anatop_read(offset);
+
+    if (anatop_in_pll_window(offset)) {
+        hwaddr blk = offset & ~(hwaddr)(PLL_BLOCK_SIZE - 1);
+        uint32_t reg = offset & (PLL_BLOCK_SIZE - 1);
+
+        if (reg == PLL_STATUS_OFF) {
+            /* PLL_LOCK mirrors CTRL.POWERUP (lock is instantaneous here). */
+            uint32_t ctrl = s->regs[(blk + PLL_CTRL_OFF) / 4];
+            return (ctrl & PLL_CTRL_POWERUP) ? PLL_STATUS_LOCK : 0;
+        }
+        if (reg == PLL_DFS_STATUS_OFF) {
+            /* Each DFS_OK bit mirrors that DFS's DFS_CTRL.ENABLE. */
+            uint32_t ok = 0;
+            for (unsigned n = 0; n < PLL_NUM_DFS; n++) {
+                hwaddr dfs = blk + PLL_DFS0_OFF + n * PLL_DFS_STEP;
+                if (s->regs[dfs / 4] & PLL_DFS_CTRL_ENABLE) {
+                    ok |= (1u << n);
+                }
+            }
+            return ok;
+        }
+    }
+    return s->regs[offset / 4];
+}
+
+static void imx95_anatop_write(void *opaque, hwaddr offset,
+                               uint64_t value, unsigned size)
+{
+    IMX95AnatopState *s = opaque;
+
+    trace_imx95_anatop_write(offset, value);
+
+    if (anatop_in_pll_window(offset)) {
+        uint32_t reg = offset & (PLL_BLOCK_SIZE - 1);
+
+        /* PLL_STATUS / DFS_STATUS are read-only. */
+        if (reg == PLL_STATUS_OFF || reg == PLL_DFS_STATUS_OFF) {
+            return;
+        }
+
+        /* RW/SET/CLR/TOG aliases of one logical register (16-byte group). */
+        hwaddr base = offset & ~(hwaddr)0xc;
+        switch (offset & 0xc) {
+        case 0x0:
+            s->regs[offset / 4] = value;
+            break;
+        case 0x4:
+            s->regs[base / 4] |= value;
+            break;
+        case 0x8:
+            s->regs[base / 4] &= ~(uint32_t)value;
+            break;
+        case 0xc:
+            s->regs[base / 4] ^= value;
+            break;
+        }
+        return;
+    }
+    s->regs[offset / 4] = value;
+}
+
+static const MemoryRegionOps imx95_anatop_ops = {
+    .read = imx95_anatop_read,
+    .write = imx95_anatop_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void imx95_anatop_reset_hold(Object *obj, ResetType type)
+{
+    IMX95AnatopState *s = IMX95_ANATOP(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static void imx95_anatop_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IMX95AnatopState *s = IMX95_ANATOP(obj);
+
+    memory_region_init_io(&s->iomem, obj, &imx95_anatop_ops, s,
+                          TYPE_IMX95_ANATOP, IMX95_ANATOP_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_imx95_anatop = {
+    .name = TYPE_IMX95_ANATOP,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMX95AnatopState, IMX95_ANATOP_NUM_WORDS),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx95_anatop_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_imx95_anatop;
+    rc->phases.hold = imx95_anatop_reset_hold;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "NXP i.MX 95 ANATOP/PLL (stub)";
+}
+
+static const TypeInfo imx95_anatop_info = {
+    .name           = TYPE_IMX95_ANATOP,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(IMX95AnatopState),
+    .instance_init  = imx95_anatop_init,
+    .class_init     = imx95_anatop_class_init,
+};
+
+static void imx95_anatop_register_types(void)
+{
+    type_register_static(&imx95_anatop_info);
+}
+
+type_init(imx95_anatop_register_types)
diff --git a/hw/misc/imx95_aonmix.c b/hw/misc/imx95_aonmix.c
new file mode 100644
index 00000000000..d794440170e
--- /dev/null
+++ b/hw/misc/imx95_aonmix.c
@@ -0,0 +1,160 @@
+/*
+ * NXP i.MX 95 BLK_CTRL_S_AONMIX - minimal model for the M7 CPU-WAIT gate
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Covers BLK_CTRL_S_AONMIX at 0x444f0000. The block is mostly plain
+ * configuration storage, modelled here as a RAM-backed register file (an
+ * improvement over the previous logging stub, which read back as zero).
+ *
+ * The one load-bearing register is M7_CFG (offset 0x124). Its WAIT bit
+ * (bit 4) is the Cortex-M7 hold/run gate the System Manager uses to manage
+ * the M7's lifecycle: CPU_RunModeGet reads it (WAIT set => HOLD, clear =>
+ * START) and CPU_WaitSet sets/clears it. At reset WAIT is set, so the SM
+ * sees the M7 held and runs its full DEV_SM_CpuStart sequence - releasing
+ * CPUWAIT (which we surface as the m7-run gpio) and, crucially, enabling
+ * the CM7_SYSRESETREQ fault IRQ so the SM can later cold-reset the M7 LM.
+ * A WAIT 1->0 transition releases the M7; 0->1 holds it.
+ *
+ * INITVTOR (0x108) - the M7 boot vector the SM programs - is stored but
+ * unused: our M7 boots from its ITCM reset vector (init-svtor = 0).
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define TYPE_IMX95_AONMIX "imx95.aonmix"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX95AonmixState, IMX95_AONMIX)
+
+#define IMX95_AONMIX_REG_SIZE   0x10000
+#define IMX95_AONMIX_NUM_WORDS  (IMX95_AONMIX_REG_SIZE / 4)
+
+#define AONMIX_M7_CFG           0x124       /* M7 configure register */
+#define AONMIX_M7_CFG_WAIT      0x10        /* bit 4: M7 CPU-WAIT (hold) */
+
+struct IMX95AonmixState {
+    SysBusDevice    parent_obj;
+    MemoryRegion    iomem;
+    uint32_t        regs[IMX95_AONMIX_NUM_WORDS];
+
+    /*
+     * M7 run gate, driven by M7_CFG.WAIT (level: 1 = released/run,
+     * 0 = held). The machine wires this to a handler that resets+resumes
+     * the M7 on release and halts it on hold.
+     */
+    qemu_irq        m7_run;
+};
+
+static uint64_t imx95_aonmix_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX95AonmixState *s = opaque;
+
+    trace_imx95_aonmix_read(offset);
+    return s->regs[offset / 4];
+}
+
+static void imx95_aonmix_write(void *opaque, hwaddr offset,
+                               uint64_t value, unsigned size)
+{
+    IMX95AonmixState *s = opaque;
+
+    trace_imx95_aonmix_write(offset, value);
+
+    /*
+     * M7_CFG.WAIT toggling is the SM holding (set) or releasing (clear) the
+     * M7. Surface the released state on the m7-run line so the machine
+     * cycles the core. Only fires on an actual WAIT transition.
+     */
+    if (offset == AONMIX_M7_CFG) {
+        uint32_t old = s->regs[offset / 4];
+        uint32_t new = (uint32_t)value;
+
+        s->regs[offset / 4] = new;
+        if ((old ^ new) & AONMIX_M7_CFG_WAIT) {
+            int run = (new & AONMIX_M7_CFG_WAIT) ? 0 : 1;
+            trace_imx95_aonmix_m7_gate(run);
+            qemu_set_irq(s->m7_run, run);
+        }
+        return;
+    }
+
+    s->regs[offset / 4] = value;
+}
+
+static const MemoryRegionOps imx95_aonmix_ops = {
+    .read = imx95_aonmix_read,
+    .write = imx95_aonmix_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void imx95_aonmix_reset_hold(Object *obj, ResetType type)
+{
+    IMX95AonmixState *s = IMX95_AONMIX(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    /* M7 held at reset: the SM sees HOLD and runs its full CpuStart. */
+    s->regs[AONMIX_M7_CFG / 4] = AONMIX_M7_CFG_WAIT;
+}
+
+static void imx95_aonmix_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IMX95AonmixState *s = IMX95_AONMIX(obj);
+
+    memory_region_init_io(&s->iomem, obj, &imx95_aonmix_ops, s,
+                          TYPE_IMX95_AONMIX, IMX95_AONMIX_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    qdev_init_gpio_out_named(DEVICE(obj), &s->m7_run, "m7-run", 1);
+}
+
+static const VMStateDescription vmstate_imx95_aonmix = {
+    .name = TYPE_IMX95_AONMIX,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMX95AonmixState, IMX95_AONMIX_NUM_WORDS),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx95_aonmix_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_imx95_aonmix;
+    rc->phases.hold = imx95_aonmix_reset_hold;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "NXP i.MX 95 BLK_CTRL_S_AONMIX (M7 CPU-WAIT gate)";
+}
+
+static const TypeInfo imx95_aonmix_info = {
+    .name           = TYPE_IMX95_AONMIX,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(IMX95AonmixState),
+    .instance_init  = imx95_aonmix_init,
+    .class_init     = imx95_aonmix_class_init,
+};
+
+static void imx95_aonmix_register_types(void)
+{
+    type_register_static(&imx95_aonmix_info);
+}
+
+type_init(imx95_aonmix_register_types)
diff --git a/hw/misc/imx95_gpc.c b/hw/misc/imx95_gpc.c
new file mode 100644
index 00000000000..d18b6da13c0
--- /dev/null
+++ b/hw/misc/imx95_gpc.c
@@ -0,0 +1,160 @@
+/*
+ * NXP i.MX 95 GPC (General Power Controller) stub model
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Covers the GPC block at 0x44470000: the per-domain GPC_CPU_CTRL
+ * instances (CM33 @+0x0000, CM7 @+0x0800, CA55_0..5 @+0x1000..+0x3800,
+ * CA55_CLUSTER @+0x4000) and GPC_GLOBAL @+0x4800.
+ *
+ * The System Manager drives CPU power modes by writing CMC_MODE_CTRL
+ * (CPU_MODE_TARGET, offset 0x10 in a CPU_CTRL block) and polling
+ * CMC_MODE_STAT (CPU_MODE_CURRENT, offset 0x14) until the mode settles.
+ * It also uses the CMC_SLEEP_*_CTRL / *_STAT handshake pairs (a *_STAT
+ * at *_CTRL + 4). QEMU has no power hardware, so transitions are
+ * instantaneous: every status register reflects the value last written
+ * to its paired control register. Everything else is plain storage.
+ *
+ * This is the register-class triage used for XCACHE applied to a
+ * control/status block: control bits persist (RAM), status registers
+ * mirror their control so "request X, wait for X" loops converge.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define TYPE_IMX95_GPC "imx95.gpc"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX95GPCState, IMX95_GPC)
+
+#define IMX95_GPC_REG_SIZE      0x10000
+#define IMX95_GPC_NUM_WORDS     (IMX95_GPC_REG_SIZE / 4)
+
+/* GPC_CPU_CTRL per-domain block layout (the GLOBAL block lives at +0x4800). */
+#define GPC_GLOBAL_OFF          0x4800
+#define CPU_CTRL_BLOCK_SIZE     0x800
+#define CMC_MODE_CTRL           0x10    /* CPU_MODE_TARGET in [1:0] */
+#define CMC_MODE_STAT           0x14    /* CPU_MODE_CURRENT in [1:0] */
+
+struct IMX95GPCState {
+    SysBusDevice    parent_obj;
+    MemoryRegion    iomem;
+    uint32_t        regs[IMX95_GPC_NUM_WORDS];
+};
+
+/*
+ * Is `reg` (offset within a CPU_CTRL block) a status register that mirrors
+ * the control register 4 bytes below it? Covers CMC_MODE_STAT (0x14) and
+ * the CMC_SLEEP_*_STAT handshake registers (0x204, 0x20c, ... 0x24c), all
+ * of which sit at their paired *_CTRL + 4.
+ */
+static bool gpc_is_mirror_stat(uint32_t reg)
+{
+    if (reg == CMC_MODE_STAT) {
+        return true;
+    }
+    /* SLEEP/WAKEUP handshake STATs: odd-word in the 0x200..0x2ff range. */
+    if (reg >= 0x204 && reg <= 0x2fc && ((reg & 0x4) != 0)) {
+        return true;
+    }
+    return false;
+}
+
+static uint64_t imx95_gpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX95GPCState *s = opaque;
+
+    if (offset < GPC_GLOBAL_OFF) {
+        uint32_t reg = offset & (CPU_CTRL_BLOCK_SIZE - 1);
+        if (gpc_is_mirror_stat(reg)) {
+            /* Status mirrors the paired control (transition is instant). */
+            return s->regs[(offset - 4) / 4];
+        }
+    }
+    return s->regs[offset / 4];
+}
+
+static void imx95_gpc_write(void *opaque, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+    IMX95GPCState *s = opaque;
+
+    if (offset < GPC_GLOBAL_OFF &&
+        (offset & (CPU_CTRL_BLOCK_SIZE - 1)) == CMC_MODE_CTRL) {
+        trace_imx95_gpc_mode(offset, (uint32_t)value & 0x3);
+    }
+
+    s->regs[offset / 4] = value;
+}
+
+static const MemoryRegionOps imx95_gpc_ops = {
+    .read = imx95_gpc_read,
+    .write = imx95_gpc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void imx95_gpc_reset_hold(Object *obj, ResetType type)
+{
+    IMX95GPCState *s = IMX95_GPC(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static void imx95_gpc_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IMX95GPCState *s = IMX95_GPC(obj);
+
+    memory_region_init_io(&s->iomem, obj, &imx95_gpc_ops, s,
+                          TYPE_IMX95_GPC, IMX95_GPC_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_imx95_gpc = {
+    .name = TYPE_IMX95_GPC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMX95GPCState, IMX95_GPC_NUM_WORDS),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx95_gpc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_imx95_gpc;
+    rc->phases.hold = imx95_gpc_reset_hold;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "NXP i.MX 95 GPC (stub)";
+}
+
+static const TypeInfo imx95_gpc_info = {
+    .name           = TYPE_IMX95_GPC,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(IMX95GPCState),
+    .instance_init  = imx95_gpc_init,
+    .class_init     = imx95_gpc_class_init,
+};
+
+static void imx95_gpc_register_types(void)
+{
+    type_register_static(&imx95_gpc_info);
+}
+
+type_init(imx95_gpc_register_types)
diff --git a/hw/misc/imx95_src.c b/hw/misc/imx95_src.c
new file mode 100644
index 00000000000..8aa1d7d56b4
--- /dev/null
+++ b/hw/misc/imx95_src.c
@@ -0,0 +1,228 @@
+/*
+ * NXP i.MX 95 SRC (System Reset Controller) mix-slice stub model
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Covers the SRC block at 0x44460000: SRC_GEN at offset 0, then the
+ * per-power-domain "mix slice" register blocks (SRC_XSPR) starting at
+ * offset 0x400, one every 0x400 (ANAMIX, AONMIX, ..., CCMSRCGPCMIX, ...).
+ *
+ * The System Manager powers a mix down by setting SLICE_SW_CTRL.PDN_SOFT
+ * (bit 31, slice offset 0x20) and powers it up by clearing it, then polls
+ * the read-only FUNC_STAT (slice offset 0xb4) until the power state
+ * settles. QEMU has no power switches, so the transition is instantaneous:
+ * FUNC_STAT is derived from the slice's SLICE_SW_CTRL.PDN_SOFT -
+ *   powered up   -> RST_STAT released                  (0x00000004)
+ *   powered down -> PSW off, ISO on, handshakes done    (0x00005511)
+ * matching PWR_MIX_FUNC_STAT_PUP / _PDN in the SM's fsl_power.h. Everything
+ * else is plain storage. Same status-mirrors-control idea as the GPC model.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define TYPE_IMX95_SRC "imx95.src"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX95SRCState, IMX95_SRC)
+
+#define IMX95_SRC_REG_SIZE      0x10000
+#define IMX95_SRC_NUM_WORDS     (IMX95_SRC_REG_SIZE / 4)
+
+/* Mix-slice (SRC_XSPR) layout. SRC_GEN occupies the first slice-sized block. */
+#define SRC_SLICE_STRIDE        0x400
+#define SRC_SLICE_SW_CTRL       0x20    /* PDN_SOFT in bit 31 */
+#define SRC_FUNC_STAT           0xb4    /* read-only power/reset status */
+#define SRC_SLICE_SW_CTRL_PDN_SOFT  0x80000000u
+
+/* FUNC_STAT values for the fully-up / fully-down states (SM fsl_power.h). */
+#define SRC_FUNC_STAT_PUP       0x00000004u
+#define SRC_FUNC_STAT_PDN       0x00005511u
+
+/*
+ * SRC_GEN.SCR - the boot-reset-release latch register at offset 0x10
+ * within SRC_GEN (which sits at the SRC block base). Bit 12 is the
+ * M7MIX release; per the i.MX 95 reference manual it is sticky:
+ * "M7MIX will be held under reset until boot core writes this bit to 1.
+ * Once this bit is set to 1, it will be locked." The SM's
+ * DEV_SM_CpuStart(M7) path writes this bit during the LMM_Boot phase;
+ * we use the 0->1 transition as a rising edge on the m7mix_release
+ * gpio-out so the machine wrapper can release the M7 CPU from
+ * start-powered-off (silicon-faithful M7 release).
+ */
+#define SRC_GEN_SCR_OFFSET                      0x10u
+#define SRC_GEN_SCR_BOOT_RESET_RELEASE_M7MIX    (1u << 12)
+
+/*
+ * Per-slice reset line. SLICE_SW_CTRL.RST_RSTR_0 (bit 20) asserts the
+ * slice's core reset; the read-only RSTR_STAT.RSTR_0_RST_STAT (bit 0, slice
+ * offset 0xb8) reports it back. The SM's SRC_MixSetResetLine writes RST_RSTR_0
+ * and SRC_MixGetResetLine polls RSTR_STAT until it matches, so - like
+ * FUNC_STAT mirroring PDN_SOFT - we derive RSTR_STAT from RST_RSTR_0 so the
+ * SM's assert/deassert wait loops converge.
+ */
+#define SRC_RSTR_STAT                           0xb8
+/*
+ * SLICE_SW_CTRL.RST_RSTR[3:0] live in bits [23:20]; RSTR_STAT.RST_STAT[3:0] in
+ * bits [3:0]. The reset lines (M7MIX + sub-resets) each use one of these.
+ */
+#define SRC_SLICE_SW_CTRL_RST_RSTR_SHIFT        20
+
+struct IMX95SRCState {
+    SysBusDevice    parent_obj;
+    MemoryRegion    iomem;
+    uint32_t        regs[IMX95_SRC_NUM_WORDS];
+
+    /*
+     * Rising edge when SRC_GEN.SCR.BOOT_RESET_RELEASE_M7MIX goes 0 -> 1.
+     * Wired by the machine to a handler that releases the M7 CPU,
+     * complementing the existing reset-time release path (which
+     * releases M7 when -device loader has staged firmware into ITCM,
+     * used by tests that boot the M7 standalone without the SM).
+     */
+    qemu_irq        m7mix_release;
+};
+
+static uint64_t imx95_src_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX95SRCState *s = opaque;
+
+    /* FUNC_STAT in a mix slice mirrors that slice's SLICE_SW_CTRL.PDN_SOFT. */
+    if (offset >= SRC_SLICE_STRIDE &&
+        (offset & (SRC_SLICE_STRIDE - 1)) == SRC_FUNC_STAT) {
+        hwaddr slice = offset & ~(hwaddr)(SRC_SLICE_STRIDE - 1);
+        uint32_t ctrl = s->regs[(slice + SRC_SLICE_SW_CTRL) / 4];
+
+        return (ctrl & SRC_SLICE_SW_CTRL_PDN_SOFT) ? SRC_FUNC_STAT_PDN
+                                                   : SRC_FUNC_STAT_PUP;
+    }
+
+    /*
+     * RSTR_STAT mirrors that slice's SLICE_SW_CTRL reset lines: the SM
+     * asserts one of RST_RSTR[3:0] (SLICE_SW_CTRL bits [23:20]) and polls the
+     * matching RST_STAT[3:0] (RSTR_STAT bits [3:0]) until it tracks. The M7 LM
+     * reset walks several reset lines (M7MIX + associated sub-resets), each on
+     * a different RST_RSTR bit, so mirror all four.
+     */
+    if (offset >= SRC_SLICE_STRIDE &&
+        (offset & (SRC_SLICE_STRIDE - 1)) == SRC_RSTR_STAT) {
+        hwaddr slice = offset & ~(hwaddr)(SRC_SLICE_STRIDE - 1);
+        uint32_t ctrl = s->regs[(slice + SRC_SLICE_SW_CTRL) / 4];
+
+        return (ctrl >> SRC_SLICE_SW_CTRL_RST_RSTR_SHIFT) & 0xf;
+    }
+    return s->regs[offset / 4];
+}
+
+static void imx95_src_write(void *opaque, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+    IMX95SRCState *s = opaque;
+
+    /*
+     * SRC_GEN.SCR: bit 12 (M7MIX release) is sticky/locked once set per
+     * the RM. Track the 0->1 transition and pulse the m7mix_release out
+     * so the machine releases the M7 CPU.
+     */
+    if (offset == SRC_GEN_SCR_OFFSET) {
+        uint32_t old = s->regs[offset / 4];
+        uint32_t new = (uint32_t)value;
+
+        /* Lock any bit that was already 1: hardware-sticky behaviour. */
+        new |= old & SRC_GEN_SCR_BOOT_RESET_RELEASE_M7MIX;
+        s->regs[offset / 4] = new;
+
+        if (!(old & SRC_GEN_SCR_BOOT_RESET_RELEASE_M7MIX) &&
+             (new & SRC_GEN_SCR_BOOT_RESET_RELEASE_M7MIX)) {
+            trace_imx95_src_m7mix_release();
+            qemu_irq_raise(s->m7mix_release);
+        }
+        return;
+    }
+
+    if (offset >= SRC_SLICE_STRIDE &&
+        (offset & (SRC_SLICE_STRIDE - 1)) == SRC_SLICE_SW_CTRL) {
+        trace_imx95_src_slice_ctrl(offset, (uint32_t)value);
+    }
+
+    s->regs[offset / 4] = value;
+}
+
+static const MemoryRegionOps imx95_src_ops = {
+    .read = imx95_src_read,
+    .write = imx95_src_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void imx95_src_reset_hold(Object *obj, ResetType type)
+{
+    IMX95SRCState *s = IMX95_SRC(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static void imx95_src_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IMX95SRCState *s = IMX95_SRC(obj);
+
+    memory_region_init_io(&s->iomem, obj, &imx95_src_ops, s,
+                          TYPE_IMX95_SRC, IMX95_SRC_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    /*
+     * Named gpio-out for SRC_GEN.SCR.M7MIX rising edge. Connected by
+     * the machine wrapper to a handler that releases the M7 CPU.
+     */
+    qdev_init_gpio_out_named(DEVICE(obj), &s->m7mix_release,
+                             "m7mix-release", 1);
+}
+
+static const VMStateDescription vmstate_imx95_src = {
+    .name = TYPE_IMX95_SRC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMX95SRCState, IMX95_SRC_NUM_WORDS),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx95_src_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_imx95_src;
+    rc->phases.hold = imx95_src_reset_hold;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "NXP i.MX 95 SRC (stub)";
+}
+
+static const TypeInfo imx95_src_info = {
+    .name           = TYPE_IMX95_SRC,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(IMX95SRCState),
+    .instance_init  = imx95_src_init,
+    .class_init     = imx95_src_class_init,
+};
+
+static void imx95_src_register_types(void)
+{
+    type_register_static(&imx95_src_info);
+}
+
+type_init(imx95_src_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 3f8cd1d825e..0b7f5e4382d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -174,3 +174,7 @@ system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
 system_ss.add(when: 'CONFIG_IMX_MU', if_true: files('imx_mu.c'))
 system_ss.add(when: 'CONFIG_IMX95_ELE_SERVER', if_true: files('imx95_ele_server.c'))
 system_ss.add(when: 'CONFIG_IMX95_WDOG', if_true: files('imx95_wdog.c'))
+system_ss.add(when: 'CONFIG_IMX95_ANATOP', if_true: files('imx95_anatop.c'))
+system_ss.add(when: 'CONFIG_IMX95_AONMIX', if_true: files('imx95_aonmix.c'))
+system_ss.add(when: 'CONFIG_IMX95_GPC', if_true: files('imx95_gpc.c'))
+system_ss.add(when: 'CONFIG_IMX95_SRC', if_true: files('imx95_src.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 584c1f90963..15fab0596c2 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -450,3 +450,11 @@ imx95_ele_msg(uint8_t command, uint8_t tag, uint32_t size) "received cmd 0x%02x
 imx95_ele_response(uint8_t command) "response cmd 0x%02x"
 imx95_wdog_config(uint32_t cs) "CS <- 0x%08x"
 imx95_wdog_unlock(void) "unlock word written"
+imx95_anatop_read(uint64_t offset) "read off 0x%" PRIx64
+imx95_anatop_write(uint64_t offset, uint64_t value) "write off 0x%" PRIx64 " <- 0x%08" PRIx64
+imx95_aonmix_read(uint64_t offset) "read off 0x%" PRIx64
+imx95_aonmix_write(uint64_t offset, uint64_t value) "write off 0x%" PRIx64 " <- 0x%08" PRIx64
+imx95_aonmix_m7_gate(int run) "M7 wait gate -> run=%d"
+imx95_gpc_mode(uint64_t offset, uint32_t target) "CMC_MODE_CTRL off 0x%" PRIx64 " target %u"
+imx95_src_m7mix_release(void) "SRC_GEN.SCR M7MIX reset released"
+imx95_src_slice_ctrl(uint64_t offset, uint32_t value) "SLICE_SW_CTRL off 0x%" PRIx64 " <- 0x%08x"
-- 
2.34.1


