Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5E3C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqR-00024v-Sm; Wed, 19 Aug 2026 22:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsqA-0001w3-Uy
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:15 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsq8-0000at-Tx
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:14 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-836c4474028so22776387b3.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194152; x=1787798952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sn+x+uKMH7j7KOVVPKrmPvWpinOYdrhztY6mwQ/cHDA=;
 b=KtRCi2dhNwNppuJgTzcVYX/cg8I3tRSMEKnuVIe28BiCaQTGCGFkFysjfHZ6YkDiY8
 SrsPDVDG/LK4d0BLuENoFxnPhlCdtdcnTUkzwENp1Pqr61iKfdA5te6eFCsAyTGY3ulu
 uvguezXj4dK6sy/dDpzBFEjmoL1ota4BAQdtC9KUaSK1P6deTPSWVGrVugiRZdek9XZd
 cEPiz+iadvTcFl2LHmwwxqz7I6a7dZJrErxQZGqtPuFPI0k1bFjbz68zZCuoK2bzItbe
 CvHXqfnmkXsjrBMLLQD+bBqjOLCiKVK44nsnZDSh2jJiPjkopJsW4f2vqlkKAu/fbc8R
 /rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194152; x=1787798952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sn+x+uKMH7j7KOVVPKrmPvWpinOYdrhztY6mwQ/cHDA=;
 b=LM2UwjpCSrJ+Fc1PXczr6dD5CcSVOjfAIgFNcwwX/GWAJcubm8K+lxBbOEBcuuE2L8
 6FMNejOcrGM4p6leZEqek8jqDPDUPq5InIrYljlb4I2L/gdWTk7OoBeEUOu4wnE11Kuk
 srWy1uZvgr1279TxQ/VaLfNKjwUFZiKqdqKc3ivTQ3v6SGokOM6kkB8kHmg5LgM9k5IW
 12uynSOEts22GjYGyTePvVdnpzyEcotYv+ort7jmvJhHc6TOIzJk3rTZQg2Vc+SwBSdB
 Jzv+B1oLodbQ9p34cn3GUi7LmcMBKbak6H9lLRtxvfjyAOWK6p5hd2DEjXNJTCMA58ks
 XQ9A==
X-Gm-Message-State: AFuF++mSsZc382TPU7XzfUXgFvZMBwJwee/fRMe829Apy+4o5+dptc4l
 Tk57KX6fAo8gcF4TSoXGAadI+sEVLGZ9VCp2lAiIEGCOC5sLcZpDF05SCWJIHA==
X-Gm-Gg: AR+sD12wSyYhvLejlBr4JCVx+O0ODhzBjWvII6ji6ctp9MjH3QHNyWQ1cRh8AgjDY+h
 OfEHeMkG5R7YT3+zrCzwN2RuvIF6CAd5VB7fPYbiCi3q+DSIVC110DrR6jeLa5HolJ2FHtsIuTT
 bZhL5SuCNmSju5Tn381NbY2sIP7z399sNPuW0OUyLzE7Ep0lxFfBRtCqHPgEXAVYoEzTI4+MQFc
 TKTf/6q4sDPADKSNtDcytX/khNczmy6+o/fmCm425RyTcUik+Whxs/Q/lqFmPuPnxbv0jfDWIk1
 KzNfK+KgMhRX/j500S877DlQZbAyfEr3WEoWNlOFMF1J4fvnztz/qUkzDBDrQ/FEpcwFH5fr/Nz
 h2MJUuYFwHLttwNl/BYM4BJaProfN6PQeKwLvu82AjqR4wl3mlU9F/zhcVNN964+12+H4Kgd7lo
 RUlklRIblx+xXY7rWF2+fVtRdBa4Q87AMsK49GKIXz2XgzPM99PJIb2+NZpSh7gSVZTkT3KoM+B
 rRjvIsmWC5kIGW9FTsxlETGnomFmX0LLopPj08Vs0oJV9+uPLkO1A==
X-Received: by 2002:a05:690e:2669:b0:66c:d36f:d2ef with SMTP id
 956f58d0204a3-66cd36fd386mr1346477d50.32.1787194151717; 
 Wed, 19 Aug 2026 19:49:11 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:49:10 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH 15/16] hw/arm: add i.MX 95 19x19 EVK board
Date: Wed, 19 Aug 2026 21:48:33 -0500
Message-Id: <20260820024834.3286721-16-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yw1-x112d.google.com
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

The i.MX 95 19x19 EVK board (machine type imx95-19x19-evk).
Instantiates the SoC, sets up the LPDDR5 DRAM, and provides the direct
-kernel/-dtb/-initrd Linux boot path alongside the System Manager
firmware loaded on the M33. This is the user-facing machine type.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/arm/Kconfig     |   7 +++
 hw/arm/imx95-evk.c | 136 +++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build |   1 +
 3 files changed, 144 insertions(+)
 create mode 100644 hw/arm/imx95-evk.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7f1c0723ec0..d93808a48ee 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -764,3 +764,10 @@ config FSL_IMX95
     select IMX_LPI2C
     select SDHCI
     select UNIMP
+
+config FSL_IMX95_EVK
+    bool
+    default y
+    depends on AARCH64
+    depends on TCG
+    select FSL_IMX95
diff --git a/hw/arm/imx95-evk.c b/hw/arm/imx95-evk.c
new file mode 100644
index 00000000000..470ca112376
--- /dev/null
+++ b/hw/arm/imx95-evk.c
@@ -0,0 +1,136 @@
+/*
+ * NXP i.MX 95 19x19 Evaluation Kit (LPDDR5) - QEMU machine
+ *
+ * Modeled on hw/arm/imx8mp-evk.c by Bernhard Beschow
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Instantiates the SoC, attaches DDR, and hands control to
+ * arm_load_kernel() so -kernel works.
+ */
+
+#include "qemu/osdep.h"
+#include "system/address-spaces.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/fsl-imx95.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev-properties.h"
+#include "system/kvm.h"
+#include "system/qtest.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+
+static void imx95_evk_init(MachineState *machine)
+{
+    static struct arm_boot_info boot_info;
+    FslImx95State *s;
+
+    if (kvm_enabled()) {
+        error_report("The imx95-19x19-evk machine requires TCG: it emulates "
+                     "Cortex-M33 and Cortex-M7 cores that KVM cannot run");
+        exit(1);
+    }
+
+    if (machine->ram_size > FSL_IMX95_RAM_SIZE_MAX) {
+        error_report("RAM size " RAM_ADDR_FMT
+                     " above max supported (0x%" PRIx64 ")",
+                     machine->ram_size, (uint64_t)FSL_IMX95_RAM_SIZE_MAX);
+        exit(1);
+    }
+
+    /*
+     * The board presets the DTB at RAM_START + 128 MiB and the initrd at
+     * RAM_START + 256 MiB (see below), so require enough RAM to hold them.
+     */
+    if (machine->ram_size < FSL_IMX95_RAM_SIZE_MIN) {
+        error_report("RAM size " RAM_ADDR_FMT
+                     " below min supported (0x%" PRIx64 ")",
+                     machine->ram_size, (uint64_t)FSL_IMX95_RAM_SIZE_MIN);
+        exit(1);
+    }
+
+    boot_info = (struct arm_boot_info) {
+        .loader_start = FSL_IMX95_RAM_START,
+        .board_id     = -1,
+        .ram_size     = machine->ram_size,
+        .psci_conduit = QEMU_PSCI_CONDUIT_SMC,
+        /*
+         * The default arm_load_kernel() heuristic lands the initrd (and the
+         * DTB right after it) at loader_start + 128 MiB == 0x88000000. That
+         * is exactly where the NXP BSP device tree places the Cortex-M7
+         * remoteproc carveout (vdev vrings + rsc-table @0x88220000). The
+         * collision makes Linux reserve those pages for the initrd/FDT, so
+         * the later reserved-memory no-map pass fails (-EBUSY) and imx-rproc
+         * cannot ioremap the rsc-table (probe fails with -ENOMEM). Force the
+         * initrd/DTB up to 0x90000000, in the free gap above the M7 carveout
+         * and below the GPU/VPU carveouts at 0xa0000000.
+         */
+        .initrd_start = FSL_IMX95_RAM_START + 256 * MiB,
+    };
+
+    s = FSL_IMX95(object_new(TYPE_FSL_IMX95));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
+
+    memory_region_add_subregion(get_system_memory(), FSL_IMX95_RAM_START,
+                                machine->ram);
+
+    if (!qtest_enabled()) {
+        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+
+        /*
+         * arm_load_kernel() registers its boot reset hook on every CPU in
+         * the system and treats all non-boot cores as A-profile PSCI
+         * secondaries. That is correct for the five A55 secondaries, but
+         * the Cortex-M33 SM core and the Cortex-M7 RT core are not part of
+         * the A55 boot flow - each boots from its own ITCM vector table.
+         * Detach them from the A-profile boot machinery so their reset just
+         * runs the normal M-profile vector-table reset. Whether each then
+         * actually runs is decided by the SoC's M33/M7 reset hooks (only if
+         * firmware was loaded into the respective ITCM).
+         */
+        if (s->m33.cpu) {
+            s->m33.cpu->env.boot_info = NULL;
+        }
+        if (s->m7.cpu) {
+            s->m7.cpu->env.boot_info = NULL;
+        }
+    }
+}
+
+static const char *imx95_evk_get_default_cpu_type(const MachineState *ms)
+{
+    return ARM_CPU_TYPE_NAME("cortex-a55");
+}
+
+static const char * const imx95_evk_valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-a55"),
+    NULL
+};
+
+static void imx95_19x19_evk_machine_init(MachineClass *mc)
+{
+    mc->desc                  = "NXP i.MX 95 19x19 EVK (LPDDR5)";
+    mc->init                  = imx95_evk_init;
+    /*
+     * Total vCPUs = 6 A55 + 1 Cortex-M33 System Manager core + 1 Cortex-M7
+     * real-time core that the SoC always instantiates. TCG sizes its
+     * per-CPU context table from the resolved smp.max_cpus, which defaults
+     * to smp.cpus when -smp is not given - so both the default and the
+     * max must include the M33 and the M7, otherwise the 8th CPU's
+     * tcg_register_thread() asserts. The A55 cluster size is fixed in
+     * the SoC regardless of -smp; this count is really "A55 cluster +
+     * SM core + RT core".
+     */
+    mc->default_cpus          = FSL_IMX95_NUM_A55_CPUS + 2;
+    mc->max_cpus              = FSL_IMX95_NUM_A55_CPUS + 2;
+    mc->default_ram_id        = "imx95-19x19-evk.ram";
+    mc->default_ram_size      = 8 * GiB;   /* 19x19 EVK has 8 GiB LPDDR5 */
+    mc->get_default_cpu_type  = imx95_evk_get_default_cpu_type;
+    mc->valid_cpu_types       = imx95_evk_valid_cpu_types;
+}
+
+DEFINE_MACHINE_AARCH64("imx95-19x19-evk", imx95_19x19_evk_machine_init)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 96fef4c5b5f..cdb61fa1612 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -118,5 +118,6 @@ arm_common_ss.add(when: ['CONFIG_AXIADO_EVK', 'TARGET_AARCH64'], if_true: files(
 
 arm_common_ss.add(files('boot.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX95', if_true: files('fsl-imx95.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX95_EVK', if_true: files('imx95-evk.c'))
 
 hw_common_arch += {'arm': arm_common_ss}
-- 
2.34.1


