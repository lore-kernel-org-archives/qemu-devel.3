Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63FEC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqR-000250-SN; Wed, 19 Aug 2026 22:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsqF-0001xg-QG
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:20 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsq9-0000bD-HK
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:19 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66ca3fc625bso2881249d50.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194152; x=1787798952; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wiN8M3RMC5m8wjnFcWzCGDWBeJxIPTmADuLerRiBxA8=;
 b=V3fXHE7tTEKrgtOdnOWE72cmIPIYD/I+jfCp6ShthCY+bo2JwPMHIWK5YAdtFAj5U1
 vZ/kC9m7kt4TJrEjGNam73eZsr0B85I/b/tBArLIsMT4WHHv8sV5OqIgBwdd5eyEEHgG
 4l7NLgnZOhynrP/XPEYMDE23Rec1v20LJ8hT2QvG2SMadOoIuf+eSR4xXmu0lx1GZp9y
 boDShOf8K407Pd77a2WKBm51dsrYlJ/mGiqcXa7t2X91DJMDtN8VWllMOOAKIKwvxmjI
 7EgmcB0PLfmELYYCjZFjAbPtVMYCYnggDu5LrKaeQCd9Ha+fJDT044exji9mCcS9spmU
 Rj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194152; x=1787798952;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wiN8M3RMC5m8wjnFcWzCGDWBeJxIPTmADuLerRiBxA8=;
 b=EsBxwi3MGvJMpabcoH+iuxiPWxD9g2sXiT1fT/vGPOlPOJddQvNWocFj8KXaHyGreA
 EHGW1DVWnEOEOfOnqIU2mdyi+sjyA2UFiK6lxziXvEGYKVjUNx0QDvM2WBaKiDxaeYlb
 AF8xBR8fWKblswoucKJ4znZFBGdEYrb2/Gk5BbbnEwOnladY303OssPf1jMR5JT3Lflg
 FTpDuauhjn8deqwiK5VGPqcDb5hafj9HNhvb7Q6YsQOwRtOVITTl+mnW08/vobtPxaEV
 JMdYxrPVxNpSoyoMwon+Pwz4NPaGYC5QReNUVKMJZoKNNRj0ZamkLR10uWfIlgTJunV4
 XQpA==
X-Gm-Message-State: AFuF++m9q1wi5UWP+Zhuo9zbheDIQqaG26jO7NA9Wt08aci2ai6Ehan/
 jkIgHd8DOwiAk8XxnA5KHhGzu/FL91Li0ydNIISG3sVBFqzFeCIrezZUrNbymw==
X-Gm-Gg: AR+sD12Ons+lH/veLVUl+ldQtPv247BXg0IyusDV4dSRIqd4XafbdmlL0lUaw3OoRKN
 VaMlUNxs52d2GH1EjCvB32nZSyxEiTors34nHgx0KVuNqAHhceWLDRPa5FdLl9YeDp8ywdSiogi
 4WOXNq5s9kQHNuU+i00zmf1z2TAM4RMbTgUz1gR2EiEBR/h4wHb1fM92ojmqNxTR1RLPo/6dws4
 G7YTLeOutR3OzguU0vMfrDDTJD8pSlB/+LSyDMaetdPjLBshXDeKPYyFoV7Y1zxcCQVUGV3+Ui8
 8b/KtFJI+CI+nffAm/e9K8RG3f02JydNMVpdcgWeHFF1crNc4BGrdquBI1M1TbXNWcm1dz82UMT
 /PY+GkLKDGUmi3wjMgr6U/7ZmSrRM01jYpvIl9r6M4+h/1leicnuNEPGh+H6Nhx3vvvmF01jwnj
 HKqGcm/43qFQDUugW+VaBs8DG5H73bSngHRvaWWvAY6jJqgSUZdV3VcClR4ztWMwTj1SgD6xlVH
 KAdfYCavSS3Db/6jLIQKZ1a9a+UcTtp9eLix63JDsG9cTKQ0QLYFA==
X-Received: by 2002:a53:4208:0:b0:664:b514:a086 with SMTP id
 956f58d0204a3-66ccb730f6dmr2369488d50.52.1787194150186; 
 Wed, 19 Aug 2026 19:49:10 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:49:08 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH 14/16] hw/arm: add i.MX 95 SoC container (fsl-imx95)
Date: Wed, 19 Aug 2026 21:48:32 -0500
Message-Id: <20260820024834.3286721-15-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb12a.google.com
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

The i.MX 95 SoC container. Assembles the six Cortex-A55 application
cores with a GICv3, the Cortex-M33 that runs the System Manager and the
SM-managed Cortex-M7, the MU cross-connects that carry SCMI and rpmsg,
the bring-up peripherals, and the uSDHC used for SD boot; it lays out the
SoC memory map and wires PSCI for the A55 cluster. Blocks that are not on
the boot path are mapped as logging stubs so that enabling their
device-tree nodes degrades gracefully.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/arm/Kconfig             |   19 +
 hw/arm/fsl-imx95.c         | 1646 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build         |    1 +
 include/hw/arm/fsl-imx95.h |  481 +++++++++++
 4 files changed, 2147 insertions(+)
 create mode 100644 hw/arm/fsl-imx95.c
 create mode 100644 include/hw/arm/fsl-imx95.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 260d2f07516..7f1c0723ec0 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -745,3 +745,22 @@ config AXIADO_EVK
     default y
     depends on TCG && ARM
     select AXIADO_SOC
+config FSL_IMX95
+    bool
+    select ARM_GIC
+    select ARM_GICV3
+    select IMX_LPUART
+    select IMX_MU
+    select IMX95_ELE_SERVER
+    select IMX95_WDOG
+    select IMX95_XCACHE
+    select IMX95_PMIC
+    select IMX95_GPC
+    select IMX95_SRC
+    select IMX95_AONMIX
+    select IMX95_ANATOP
+    select IMX95_DPU
+    select IMX95_SYSCTR
+    select IMX_LPI2C
+    select SDHCI
+    select UNIMP
diff --git a/hw/arm/fsl-imx95.c b/hw/arm/fsl-imx95.c
new file mode 100644
index 00000000000..110e70bbce7
--- /dev/null
+++ b/hw/arm/fsl-imx95.c
@@ -0,0 +1,1646 @@
+/*
+ * NXP i.MX 95 SoC container
+ *
+ * Modeled on hw/arm/fsl-imx8mp.c by Bernhard Beschow
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Instantiates the 6x Cortex-A55 cluster, the GIC-600 (GICv3), DDR, the
+ * Cortex-M33 System Manager and Cortex-M7 real-time cores, and the bring-up
+ * peripherals on the Linux + SM critical path (LPUART, MU, System Counter,
+ * ANATOP/SRC/GPC, ELE, LPI2C + PMIC, uSDHC, ...). Peripherals that are not
+ * modelled are backed by create_unimplemented_device() so accesses log
+ * instead of faulting.
+ *
+ * Memory-map addresses and IRQ numbers below come from two sources:
+ *   - Linux DTS for direct-MMIO peripherals (LPUART, GIC, SM mailbox,
+ *     ELE mailbox, OCRAM, watchdogs):
+ *       Linux arch/arm64/boot/dts/freescale/imx95.dtsi
+ *   - NXP U-Boot's imx-regs.h for the SCMI-routed peripherals the SPL
+ *     pokes before SCMI is up (CCM, ANATOP, IOMUXC, SRC, TRDC, the
+ *     BLK_CTRL aggregates):
+ *       U-Boot arch/arm/include/asm/arch-imx9/imx-regs.h
+ *
+ * The SM firmware on the M33 is the SCMI provider at runtime; the
+ * SCMI-routed peripherals above are logging stubs that the SM programs.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "system/address-spaces.h"
+#include "system/cpus.h"
+#include "system/system.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/armv7m.h"
+#include "hw/arm/fsl-imx95.h"
+#include "hw/core/clock.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/i2c/i2c.h"
+#include "hw/core/irq.h"
+#include "hw/intc/arm_gicv3.h"
+#include "hw/misc/unimp.h"
+#include "hw/sd/sdhci.h"
+#include "system/kvm.h"
+#include "system/reset.h"
+#include "target/arm/cpu.h"
+#include "target/arm/cpu-qom.h"
+#include "target/arm/kvm_arm.h"
+#include "qapi/error.h"
+#include "qobject/qlist.h"
+
+/*
+ * Single source of truth for the SoC memory map. Each entry maps a region
+ * ID (from enum FslImx95MemoryRegions) to its physical base address, size,
+ * and a debug name. Values are taken from the NXP BSP device tree at
+ * Linux arch/arm64/boot/dts/freescale/imx95.dtsi unless
+ * otherwise noted.
+ */
+static const struct {
+    hwaddr      addr;
+    size_t      size;
+    const char *name;
+} fsl_imx95_memmap[FSL_IMX95_NUM_REGIONS] = {
+    [FSL_IMX95_RAM]                  = {
+        FSL_IMX95_RAM_START, FSL_IMX95_RAM_SIZE_MAX, "ram"
+    },
+
+    /*
+     * GIC-600. dtsi: interrupt-controller@48000000. dist + redist are the
+     * real GICv3; the its window is a logging stub (no ITS is modelled).
+     */
+    [FSL_IMX95_GIC_DIST]             = { 0x48000000, 64 * KiB,   "gic_dist" },
+    [FSL_IMX95_GIC_REDIST]           = { 0x48060000, 768 * KiB,  "gic_redist" },
+    [FSL_IMX95_GIC_ITS]              = { 0x48040000, 128 * KiB,  "gic_its" },
+
+    /*
+     * On-chip RAM (OCRAM-A). The Linux DTS only declares a 96 KiB
+     * sram1 slice at 0x204C0000, but U-Boot SPL is linked for
+     * CONFIG_SPL_TEXT_BASE=0x20480000 with BSS+stack at 0x204D6000
+     * (see U-Boot configs/imx95_19x19_evk_defconfig).
+     * Cover the full SPL run + stack area as one writable region
+     * spanning 0x20480000-0x204D8000. Linux's sram1 slice sits
+     * inside this range and continues to work unchanged.
+     * 384 KiB covers the region SPL and Linux's sram1 slice use; the
+     * exact OCRAM-A size in the RM "Memory Map" chapter may differ but
+     * does not affect the modelled boot flow.
+     */
+    [FSL_IMX95_OCRAM]                = { 0x20480000, 384 * KiB,  "ocram" },
+
+    /*
+     * System counter. dtsi: timer@44290000 reg = <... 0x30000>.
+     * Logging stub; the ARM generic timer in QEMU's CPU
+     * model already provides time, and U-Boot SPL's timer_init()
+     * reads CNTFRQ_EL0 rather than this MMIO block. Promote to a
+     * real model if any guest write to this region surfaces.
+     */
+    [FSL_IMX95_SYSCNT]               = { 0x44290000, 192 * KiB,  "sysctr" },
+    [FSL_IMX95_BBNSM]                = { 0x44440000, 4 * KiB,    "bbnsm" },
+    [FSL_IMX95_XCACHE_PC]            = { 0x44400000, 0x800,      "xcache_pc" },
+    [FSL_IMX95_XCACHE_PS]            = { 0x44400800, 0x800,      "xcache_ps" },
+    [FSL_IMX95_BLK_CTRL_HSIOMIX]     = { 0x4c010000, 64 * KiB,   "hsiomix" },
+    [FSL_IMX95_GPC]                  = { 0x44470000, 64 * KiB,   "gpc" },
+
+    /*
+     * LPUART block. compatible: "fsl,imx95-lpuart". Each instance is
+     * a 4 KiB MMIO window. LPUART1/2 sit in the AON aips1 bus,
+     * LPUART3-6 in the Wakeup aips2 bus, LPUART7/8 in aips3.
+     * LPUART1 is the 19x19 EVK console (stdout-path = &lpuart1).
+     */
+    [FSL_IMX95_LPUART1]              = { 0x44380000, 4 * KiB,    "lpuart1" },
+    [FSL_IMX95_LPUART2]              = { 0x44390000, 4 * KiB,    "lpuart2" },
+    [FSL_IMX95_LPUART3]              = { 0x42570000, 4 * KiB,    "lpuart3" },
+    [FSL_IMX95_LPUART4]              = { 0x42580000, 4 * KiB,    "lpuart4" },
+    [FSL_IMX95_LPUART5]              = { 0x42590000, 4 * KiB,    "lpuart5" },
+    [FSL_IMX95_LPUART6]              = { 0x425a0000, 4 * KiB,    "lpuart6" },
+    [FSL_IMX95_LPUART7]              = { 0x42690000, 4 * KiB,    "lpuart7" },
+    [FSL_IMX95_LPUART8]              = { 0x426a0000, 4 * KiB,    "lpuart8" },
+
+    /*
+     * SCMI-routed peripherals. Bases from U-Boot imx-regs.h. Logging
+     * stubs only; SPL doesn't reach them through direct MMIO once the
+     * SM is up, but stubs catch any unexpected probing.
+     */
+    [FSL_IMX95_CCM]                  = { 0x44450000, 64 * KiB,   "ccm" },
+    [FSL_IMX95_ANATOP]               = { 0x44480000, 64 * KiB,   "anatop" },
+    [FSL_IMX95_IOMUXC]               = { 0x443c0000, 64 * KiB,   "iomuxc" },
+    [FSL_IMX95_SRC]                  = { 0x44460000, 64 * KiB,   "src" },
+    [FSL_IMX95_TRDC_AON]             = { 0x44270000, 64 * KiB,   "trdc_aon" },
+
+    /*
+     * BLK_CTRL aggregates per power domain. NETCMIX is Linux-visible
+     * (kernel touches it directly per imx95.dtsi:2874); the other three
+     * are SCMI-routed from U-Boot imx-regs.h.
+     */
+    [FSL_IMX95_BLK_CTRL_S_AONMIX]    = { 0x444f0000, 64 * KiB,   "s_aonmix" },
+    [FSL_IMX95_BLK_CTRL_NS_ANOMIX]   = { 0x44210000, 64 * KiB,   "ns_anomix" },
+    [FSL_IMX95_BLK_CTRL_WAKEUPMIX]   = { 0x42420000, 64 * KiB,   "wakeupmix" },
+    [FSL_IMX95_BLK_CTRL_NETCMIX]     = { 0x4c810000, 64 * KiB,   "netcmix" },
+
+    /*
+     * System Manager SCMI channel. dtsi: mu2 mailbox@445b0000 (4 KiB) with
+     * a 1 KiB sram0 child at 0x445b1000 holding the two SCMI A2P/P2A
+     * shared-memory buffers.
+     */
+    [FSL_IMX95_SM_MU]                = { 0x445b0000, 4 * KiB,    "sm_mu" },
+    [FSL_IMX95_SM_SHMEM]             = { 0x445b1000, 1 * KiB,    "sm_shmem" },
+
+    /* EdgeLock Secure Enclave mailboxes. dtsi: mailbox@47520000.. */
+    [FSL_IMX95_ELE_MU]               = { 0x47520000, 64 * KiB,   "elemu0" },
+    [FSL_IMX95_ELE_MU1]              = { 0x47530000, 64 * KiB,   "elemu1" },
+    /* Fuse Shadow Block (MIMX95_FSB.h FSB_BASE). */
+    [FSL_IMX95_FSB]                  = { 0x47510000, 64 * KiB,   "fsb" },
+    /* VFCCU / FCCU fault-control unit (AON_VFCCU). */
+    [FSL_IMX95_VFCCU]                = { 0x446b0000, 64 * KiB,   "vfccu" },
+    /* A1 MU SRAM page; SM keeps the A55 CPU wait-semaphore here (+0x3f8). */
+    [FSL_IMX95_CPU_SEMA]             = { 0x44231000, 4 * KiB,    "cpu-sema" },
+    /* CortexA TMPSNS (CORTEXA__TMPSNS_BASE). */
+    [FSL_IMX95_TMPSNS_CA]            = { 0x4a440000, 64 * KiB,   "tmpsns-ca" },
+    /* AON_VFCCU (FCCU_BASE), AON_ERMA, NOC_SRAMCTL - SM eMcem/fabric init. */
+    [FSL_IMX95_VFCCU_AON]            = { 0x44570000, 64 * KiB,   "vfccu-aon" },
+    [FSL_IMX95_ERMA]                 = { 0x44560000, 64 * KiB,   "erma" },
+    [FSL_IMX95_NOC_SRAMCTL]          = { 0x490a0000, 64 * KiB,   "sramctl" },
+
+    /*
+     * Other MU instances U-Boot proper probes from DT but we don't
+     * model yet (V2X, NETC, etc.). Logging stubs so mu_hal_init's
+     * register accesses don't external-abort.
+     */
+    [FSL_IMX95_MU_47320000] = { 0x47320000, 64 * KiB, "mu@47320000" },
+    [FSL_IMX95_MU_47350000] = { 0x47350000, 64 * KiB, "mu@47350000" },
+    [FSL_IMX95_MU_47540000] = { 0x47540000, 64 * KiB, "mu@47540000" },
+    [FSL_IMX95_MU_47550000] = { 0x47550000, 64 * KiB, "mu@47550000" },
+    [FSL_IMX95_MU_47560000] = { 0x47560000, 64 * KiB, "mu@47560000" },
+    [FSL_IMX95_MU_47570000] = { 0x47570000, 64 * KiB, "mu@47570000" },
+
+    /*
+     * Watchdogs. WDG3 is in the Linux DTS (the kernel sees it); WDG4
+     * and WDG5 are SPL-only - U-Boot's arch_cpu_init() disables all
+     * three. Bases from U-Boot arch/arm/include/asm/
+     * arch-imx9/imx-regs.h.
+     */
+    [FSL_IMX95_WDOG2]                = { 0x442e0000, 64 * KiB,   "wdog2" },
+    [FSL_IMX95_WDOG3]                = { 0x42490000, 64 * KiB,   "wdog3" },
+    [FSL_IMX95_WDOG4]                = { 0x424a0000, 64 * KiB,   "wdog4" },
+    [FSL_IMX95_WDOG5]                = { 0x424b0000, 64 * KiB,   "wdog5" },
+
+    /*
+     * GPIO bases from dtsi (gpio1@47400000) and U-Boot imx-regs.h
+     * (GPIO2-5 at 0x43810000, 0x43820000, 0x43840000, 0x43850000).
+     */
+    [FSL_IMX95_GPIO1]                = { 0x47400000, 64 * KiB,   "gpio1" },
+    [FSL_IMX95_GPIO2]                = { 0x43810000, 64 * KiB,   "gpio2" },
+    [FSL_IMX95_GPIO3]                = { 0x43820000, 64 * KiB,   "gpio3" },
+    [FSL_IMX95_GPIO4]                = { 0x43840000, 64 * KiB,   "gpio4" },
+    [FSL_IMX95_GPIO5]                = { 0x43850000, 64 * KiB,   "gpio5" },
+
+    /*
+     * ARM SMMU-v3 at 0x490d0000 (U-Boot imx-regs.h SMMU_BASE_ADDR).
+     * 128 KiB window covers CR0 / CR0_ACK / GBPA + the SMMU programming
+     * page. Stub returns 0 on read so SPL's disable_smmuv3() sees
+     * CR0.SMMUEN clear and early-exits.
+     */
+    [FSL_IMX95_SMMU]                 = { 0x490d0000, 128 * KiB,  "smmu" },
+
+    /*
+     * uSDHC controllers (compat "fsl,imx95-usdhc"). Bases + IRQs
+     * from imx95.dtsi:1303-1340. Logging stubs; a real fsl-esdhc
+     * model can be added once a backing-storage story exists (FIT
+     * or AHAB container on a disk image).
+     */
+    [FSL_IMX95_USDHC1]               = { 0x42850000, 64 * KiB,   "usdhc1" },
+    [FSL_IMX95_USDHC2]               = { 0x42860000, 64 * KiB,   "usdhc2" },
+    [FSL_IMX95_USDHC3]               = { 0x428b0000, 64 * KiB,   "usdhc3" },
+
+    /* LPI2C1..8 from imx95.dtsi - logging stubs. */
+    [FSL_IMX95_LPI2C1] = { 0x42530000, 64 * KiB, "lpi2c1" },
+    [FSL_IMX95_LPI2C2] = { 0x42540000, 64 * KiB, "lpi2c2" },
+    [FSL_IMX95_LPI2C3] = { 0x426b0000, 64 * KiB, "lpi2c3" },
+    [FSL_IMX95_LPI2C4] = { 0x426c0000, 64 * KiB, "lpi2c4" },
+    [FSL_IMX95_LPI2C5] = { 0x426d0000, 64 * KiB, "lpi2c5" },
+    [FSL_IMX95_LPI2C6] = { 0x426e0000, 64 * KiB, "lpi2c6" },
+    [FSL_IMX95_LPI2C7] = { 0x44340000, 64 * KiB, "lpi2c7" },
+    [FSL_IMX95_LPI2C8] = { 0x44350000, 64 * KiB, "lpi2c8" },
+
+    /* USB PHY + DWC3 controller (autoboot bootcmd touches these). */
+    [FSL_IMX95_USB_PHY]  = { 0x4c1f0000, 64 * KiB, "usb_phy" },
+    [FSL_IMX95_USB_DWC3] = { 0x4c200000, 64 * KiB, "usb_dwc3" },
+};
+
+/*
+ * For every peripheral region we don't yet model, install a stub that
+ * traces accesses but doesn't fault. This lets U-Boot / Linux probe
+ * registers safely while we iterate.
+ */
+/*
+ * NOP tr-write handler for the stub MUs. Its mere presence triggers
+ * the IMX_MU model's "set TSR.TEn after TR write" path - effectively
+ * making the stub mailboxes drop-and-ack on every send.
+ */
+static void fsl_imx95_stub_mu_tr_write(void *opaque, unsigned int idx,
+                                       uint32_t value)
+{
+}
+
+static bool fsl_imx95_install_unimplemented(FslImx95State *s, Error **errp)
+{
+    static const int unimplemented_regions[] = {
+        FSL_IMX95_CCM, FSL_IMX95_IOMUXC,
+        FSL_IMX95_TRDC_AON,
+        /* BLK_CTRL_S_AONMIX has a real model (M7 CPU-WAIT gate) below. */
+        FSL_IMX95_BLK_CTRL_NS_ANOMIX,
+        FSL_IMX95_BLK_CTRL_WAKEUPMIX, FSL_IMX95_BLK_CTRL_NETCMIX,
+        FSL_IMX95_WDOG4, FSL_IMX95_WDOG5,
+        FSL_IMX95_GPIO1, FSL_IMX95_GPIO2, FSL_IMX95_GPIO3,
+        FSL_IMX95_GPIO4, FSL_IMX95_GPIO5,
+        FSL_IMX95_SMMU,
+        FSL_IMX95_LPI2C1, FSL_IMX95_LPI2C2, FSL_IMX95_LPI2C3,
+        FSL_IMX95_LPI2C4, FSL_IMX95_LPI2C5, FSL_IMX95_LPI2C6,
+        /* LPI2C7 (0x44340000) is the SM's PMIC bus - real model below. */
+        FSL_IMX95_LPI2C8,
+        FSL_IMX95_USB_PHY, FSL_IMX95_USB_DWC3,
+        /*
+         * No GIC ITS is modelled (QEMU's GICv3 reports GICD_TYPER.LPIS=0,
+         * so Linux never probes the ITS node in the stock dtb); back its
+         * window with a logging stub rather than leaving it unmapped.
+         */
+        FSL_IMX95_GIC_ITS,
+    };
+
+    for (size_t i = 0; i < ARRAY_SIZE(unimplemented_regions); i++) {
+        int r = unimplemented_regions[i];
+        create_unimplemented_device(fsl_imx95_memmap[r].name,
+                                    fsl_imx95_memmap[r].addr,
+                                    fsl_imx95_memmap[r].size);
+    }
+
+    /*
+     * Bulk MU stubs for every mailbox the Linux imx95.dtsi declares
+     * that we haven't already wired with a real IMX_MU model. Linux's
+     * imx_mu driver probes each in turn (via fsl,imx95-mu /
+     * fsl,imx95-mu-v2x compatibles); without backing devices the
+     * probe takes a synchronous external abort reading PAR at offset
+     * 0x4. mu_hal_init() is safe against zero reads (rr_count=0
+     * skips the drain loop, SR bit 6 stays clear), so an
+     * unimplemented-device stub is enough to clear the abort.
+     *
+     * The addresses + names come from
+     * Linux arch/arm64/boot/dts/freescale/imx95.dtsi
+     * mailbox nodes. We exclude addresses already covered by real
+     * models (sm_mu, ele_mu/elemu0, ele_mu1/elemu1, and the six
+     * stub_mu[] entries at 0x47320000/0x47350000/0x47540000..0x47570000).
+     */
+    {
+        static const struct {
+            uint64_t addr;
+            const char *name;
+        } linux_mus[] = {
+            /* mu7 (0x42430000) is a real cross-connect to the M7, below. */
+            { 0x42730000, "mu8" },
+            { 0x44220000, "mu1" },
+            { 0x445d0000, "mu3" },
+            { 0x445f0000, "mu4" },
+            { 0x44630000, "mu6" },
+            { 0x47300000, "v2x_mu4" },
+            { 0x47330000, "v2x_mu7" },
+            { 0x47340000, "v2x_mu8" },
+            { 0x4ac60000, "cameramix_mu1" },
+            { 0x4ac70000, "cameramix_mu2" },
+            { 0x4ac80000, "cameramix_mu3" },
+            { 0x4ac90000, "cameramix_mu4" },
+            { 0x4aca0000, "cameramix_mu5" },
+            { 0x4acb0000, "cameramix_mu6" },
+            { 0x4acc0000, "cameramix_mu7" },
+            { 0x4acd0000, "cameramix_mu8" },
+            { 0x4ace0000, "cameramix_mu9" },
+        };
+        for (size_t i = 0; i < ARRAY_SIZE(linux_mus); i++) {
+            create_unimplemented_device(linux_mus[i].name,
+                                        linux_mus[i].addr, 64 * KiB);
+        }
+    }
+
+    /*
+     * Bulk stubs for the chip-wide register blocks the SM's config-op blob
+     * (DEV_SM_ExecOp) pokes during DEV_SM_Init: TRDC/RDC and the per-MIX
+     * block-control / clock-reset regions across the SoC. These are almost
+     * all blind writes (a few read-modify-writes whose read value is not
+     * acted on), so logging stubs that accept the accesses are enough to
+     * let DEV_SM_Init complete; none of these subsystems is modelled.
+     * create_unimplemented_device is a low-priority background, so the
+     * cpu-sema RAM at 0x44231000 still overrides inside 0x44230000.
+     * Addresses from the M33_ENUM enumeration of the config-op phase; the
+     * real SCMI MUs (0x445c0000 = sm_mu_b, 0x44620000 = m7_sm_mu_b) are
+     * intentionally absent - the SM's eager LMM_Init touches 0x44620000 as
+     * MU9/MU5_B, so the real MU + its SMT alias at 0x44621000 must own that
+     * window, not a dead logging stub.
+     */
+    {
+        static const uint64_t sm_cfgop_regions[] = {
+            0x42460000, 0x42470000, 0x42810000, 0x44230000, 0x44280000,
+            0x49000000, 0x49010000, 0x49020000, 0x49060000,
+            0x4ac40000, 0x4ac50000, 0x4aff0000, 0x4b040000, 0x4b050000,
+            0x4c040000, 0x4c050000, 0x4c440000, 0x4c450000, 0x4c840000,
+            0x4c850000, 0x4d810000, 0x4d840000, 0x4d850000,
+        };
+        for (size_t i = 0; i < ARRAY_SIZE(sm_cfgop_regions); i++) {
+            g_autofree char *name =
+                g_strdup_printf("sm-cfgop@0x%08" PRIx64, sm_cfgop_regions[i]);
+            create_unimplemented_device(name, sm_cfgop_regions[i], 64 * KiB);
+        }
+    }
+
+    /*
+     * Peripheral MMIO the Linux built-in drivers touch once the SM
+     * powers/clocks their domains. Once the SM answers SCMI they probe and
+     * would take a synchronous external abort on unmapped MMIO, killing
+     * PID 1. The list is the set the SM brings out of "deferred probe
+     * pending" (plus the Neutron NPU). Logging stubs let the probes proceed
+     * without faulting; these subsystems are not yet modelled for real. Low
+     * priority, so the modelled uSDHC / LPUART and the FSB RAM still override
+     * where they overlap.
+     */
+    {
+        static const struct {
+            uint64_t addr;
+            uint64_t size;
+        } linux_periph_regions[] = {
+            /*
+             * eDMA controllers: the driver maps the full DT reg window and
+             * touches the per-channel pages (0x40 channels x 0x8000 stride =
+             * 0x200000), so a 1 MiB stub faults on the high channels. Use the
+             * DT-declared sizes: edma5 = 0x210000, edma3 = 0x200000.
+             */
+            { 0x42000000, 0x210000 }, { 0x42210000, 0x210000 },
+            { 0x44000000, 0x200000 },
+            { 0x42430000, 64 * KiB }, /* cm7 mailbox */
+            { 0x42490000, 64 * KiB }, /* watchdog */
+            { 0x424e0000, 64 * KiB }, { 0x42510000, 64 * KiB }, /* pwm */
+            { 0x42530000, 64 * KiB }, { 0x42540000, 64 * KiB }, /* i2c */
+            { 0x42590000, 64 * KiB }, /* serial */
+            { 0x425e0000, 64 * KiB }, /* spi */
+            { 0x426b0000, 64 * KiB }, { 0x426c0000, 64 * KiB },
+            { 0x426d0000, 64 * KiB }, /* i2c */
+            { 0x42710000, 64 * KiB }, /* spi */
+            { 0x42850000, 64 * KiB }, { 0x42860000, 64 * KiB }, /* mmc */
+            { 0x43810000, 64 * KiB }, { 0x43820000, 64 * KiB },
+            { 0x43840000, 64 * KiB }, { 0x43850000, 64 * KiB }, /* gpio */
+            { 0x44350000, 64 * KiB }, /* i2c */
+            { 0x44530000, 64 * KiB }, /* adc */
+            { 0x4ac10000, 64 * KiB }, /* camera csr (clock provider) */
+            { 0x4ad00000, 64 * KiB }, /* display stream csr (clock provider) */
+            { 0x4ad10000, 64 * KiB }, /* display master csr (mmio-mux) */
+            { 0x4b010000, 64 * KiB }, /* syscon (dispmix csr) */
+            { 0x4b0b0000, 64 * KiB }, /* displaymix irqsteer */
+            { 0x4b0c0000, 64 * KiB }, /* lvds csr / ldb */
+            { 0x4b0d0000, 0x20000 },  /* pixel interleaver bridge */
+            /* 0x4b400000 display-controller (dpu) -> imx95.dpu status stub */
+            { 0x4c010000, 64 * KiB }, /* hsio blk-ctl (clock provider) */
+            { 0x4c100000, 64 * KiB }, /* usb3 dwc3 core */
+            { 0x4c1f0000, 64 * KiB }, /* usb3 phy */
+            { 0x4c200000, 0x100000 }, /* usb2 (chipidea) */
+            { 0x4c300000, 64 * KiB }, { 0x4c380000, 64 * KiB }, /* pcie */
+            { 0x4c410000, 64 * KiB }, /* syscon */
+            { 0x4c480000, 0x40000 },  /* vpu */
+            { 0x4c4c0000, 64 * KiB }, /* vpu-ctrl */
+            { 0x4c810000, 64 * KiB }, /* syscon */
+            { 0x4ca00000, 0x100000 }, /* netc pcie ecam 0 */
+            { 0x4cb00000, 0x100000 }, /* netc pcie ecam 1 */
+            { 0x4cde0000, 64 * KiB }, /* netc-blk-ctrl ierb */
+            { 0x4cdf0000, 64 * KiB }, /* netc-blk-ctrl prb */
+            { 0x4d900000, 0x100000 }, /* gpu */
+            { 0x4ab00000, 0x100000 }, /* neutron npu */
+            /*
+             * Audio (SAI/XCVR/MICFIL) and FlexCAN: not yet modelled. Stub
+             * them so that a board/use case enabling these nodes degrades
+             * gracefully (reads-as-0) instead of taking an unmapped-access
+             * fault on the first MMIO. The default NXP EVK boot does not
+             * probe them; FlexCAN modelling is on the roadmap.
+             */
+            { 0x42650000, 64 * KiB }, /* sai3 */
+            { 0x42660000, 64 * KiB }, /* sai4 */
+            { 0x42670000, 64 * KiB }, /* sai5 */
+            { 0x42680000, 64 * KiB }, /* xcvr (spdif) */
+            { 0x443b0000, 64 * KiB }, /* sai1 */
+            { 0x4c880000, 64 * KiB }, /* sai2 */
+            { 0x44520000, 64 * KiB }, /* micfil (pdm mic) */
+            { 0x425b0000, 64 * KiB }, /* flexcan2 */
+            { 0x42600000, 64 * KiB }, /* flexcan3 */
+            { 0x427c0000, 64 * KiB }, /* flexcan4 */
+            { 0x427d0000, 64 * KiB }, /* flexcan5 */
+            { 0x443a0000, 64 * KiB }, /* flexcan1 */
+            /*
+             * Display (MIPI DSI) and camera (MIPI CSI / ISI / ISP) interface
+             * controllers: not modelled. Stub them so enabling these DT nodes
+             * degrades gracefully (reads-as-0) instead of faulting on the
+             * first MMIO. The display-mix CSRs / LVDS-LDB CSR / DPU are stubbed
+             * elsewhere; real display scanout + camera capture are roadmap
+             * items (see the README).
+             */
+            { 0x4acf0000, 64 * KiB }, /* mipi dsi host + intf syscon */
+            { 0x4ad20000, 64 * KiB }, /* mipi tx phy csr */
+            { 0x4ad30000, 64 * KiB }, /* mipi csi0 */
+            { 0x4ad40000, 64 * KiB }, /* mipi csi1 */
+            { 0x4ad50000, 0x80000 },  /* isi (image sensing interface) */
+            { 0x4ae00000, 64 * KiB }, /* neo isp registers */
+            { 0x4afe0000, 64 * KiB }, /* neo isp stats */
+        };
+        for (size_t i = 0; i < ARRAY_SIZE(linux_periph_regions); i++) {
+            g_autofree char *name =
+                g_strdup_printf("linux-periph@0x%08" PRIx64,
+                                linux_periph_regions[i].addr);
+            create_unimplemented_device(name, linux_periph_regions[i].addr,
+                                        linux_periph_regions[i].size);
+        }
+    }
+
+    /*
+     * DPU (display-controller @0x4b400000). Not modelled, but unlike the bulk
+     * stubs above it cannot be a plain logging stub: Linux's dpu95 blit-engine
+     * probe busy-waits with no timeout on the command-sequencer status
+     * register, so a zero-returning stub hangs the probe kthread forever and
+     * wedges wait_for_device_probe() in kernel_init (userspace never starts).
+     * The imx95.dpu stub reports the sequencer idle with FIFO space so the
+     * polls pass and the probe completes; see hw/misc/imx95_dpu.c.
+     */
+    {
+        DeviceState *dpu = qdev_new("imx95.dpu");
+
+        if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dpu), errp)) {
+            return false;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(dpu), 0, 0x4b400000);
+    }
+
+    return true;
+}
+
+/*
+ * Release the M33 only when SM firmware has actually been loaded into its
+ * ITCM. The SM image's vector table begins with the initial stack
+ * pointer, so a non-zero first ITCM word means firmware is present; a
+ * zeroed ITCM (no -device loader) leaves the M33 powered off, so a plain
+ * A55-only Linux boot does not run the M33 into a HardFault lockup.
+ *
+ * Run from a bottom half scheduled by the reset handler: by the time the
+ * BH executes, the initial system reset has already committed the loaded
+ * image into ITCM, side-stepping the reset-handler ordering problem (the
+ * generic -device loader commits its ROM blob during the reset, after any
+ * reset hook a device could register).
+ */
+/*
+ * Boot-ROM handover. On silicon the boot ROM loads each LM's
+ * image and records it in a handover table the SM reads at startup
+ * (DEV_SM_RomBootCpuGet via LMM_CpuInit) to learn which cores it owns and
+ * their boot vectors - which is what lets the SM boot, manage and
+ * fault-recover them. Our flow loads the M7 image directly (-device loader),
+ * bypassing the ROM, so we fabricate a minimal handover with a single M7
+ * EXEC entry. That makes LMM_CpuInit set s_bootFlags[M7], so the SM boots
+ * the M7 via LMM_CpuStart - releasing CPUWAIT through our AONMIX model and
+ * enabling the CM7_SYSRESETREQ fault IRQ. M7-only by design: the A55 boots
+ * outside the SM's LMM path, so leaving its handover absent doesn't perturb
+ * it (its s_bootFlags stays 0, exactly as before).
+ *
+ * The blob lives at 0x2003dc00 in the M33's DTCM, which is the SM's
+ * __StackTop - reserved DTCM above the stack the SM never writes, exactly
+ * where the ROM places it on hardware. Written here (M33 release time) so it
+ * is in place before the SM runs LMM_CpuInit, and only when M7 firmware was
+ * actually staged.
+ */
+#define M7_HANDOVER_DTCM_OFFSET (0x2003dc00ULL - FSL_IMX95_M33_DTCM_BASE)
+#define M7_HANDOVER_BARKER      0xc0ffee16u
+#define M7_HANDOVER_VER         0x0002u
+#define M7_HANDOVER_SIZE        0x0100u
+/*
+ * img->flags: bits[7:0] = cpu (M7 = CPU_IDX_M7P = 1), [15:8] = type (EXEC = 0).
+ */
+#define M7_HANDOVER_IMG_FLAGS   0x00000001u
+
+static void fsl_imx95_write_m7_handover(FslImx95State *s)
+{
+    uint8_t *dtcm = memory_region_get_ram_ptr(&s->m33_dtcm);
+    uint8_t *h = dtcm + M7_HANDOVER_DTCM_OFFSET;
+    const void *m7_itcm = memory_region_get_ram_ptr(&s->m7_itcm);
+
+    /* Only if M7 firmware was actually staged into its ITCM. */
+    if (ldl_le_p(m7_itcm) == 0) {
+        return;
+    }
+
+    memset(h, 0, M7_HANDOVER_SIZE);
+    stl_le_p(h + 0x00, M7_HANDOVER_BARKER);     /* barker */
+    stw_le_p(h + 0x04, M7_HANDOVER_VER);        /* ver   */
+    stw_le_p(h + 0x06, M7_HANDOVER_SIZE);       /* size  */
+    h[0x08] = 1;                                /* num images */
+    /* img[0] at 0x10: addr(u64), cpu(u16), resv(u16), flags(u32). */
+    stq_le_p(h + 0x10, FSL_IMX95_M7_ITCM_SYSVIEW);
+    stw_le_p(h + 0x18, 1);                      /* cpu = CPU_IDX_M7P */
+    stl_le_p(h + 0x1c, M7_HANDOVER_IMG_FLAGS);
+}
+
+static void fsl_imx95_m33_start_bh(void *opaque)
+{
+    FslImx95State *s = opaque;
+    const void *itcm = memory_region_get_ram_ptr(&s->m33_itcm);
+    uint32_t initial_sp = ldl_le_p(itcm);
+
+    if (initial_sp != 0 && s->m33.cpu) {
+        CPUState *cs = CPU(s->m33.cpu);
+        /* Place the M7 boot-ROM handover before the SM starts. */
+        fsl_imx95_write_m7_handover(s);
+        cs->halted = 0;
+        cpu_resume(cs);
+    }
+}
+
+/*
+ * Same shape as fsl_imx95_m33_start_bh, applied to the M7. Vector[0] in
+ * the M7's ITCM is the initial SP; firmware sets it to a non-zero value
+ * (typically the top of DTCM), so a non-zero first word means a
+ * "-device loader,...,cpu-num=7" actually populated the M7 image. With
+ * no firmware loaded the M7 stays halted and a plain A55+M33 boot is
+ * unaffected.
+ */
+static void fsl_imx95_m7_start_bh(void *opaque)
+{
+    FslImx95State *s = opaque;
+    const void *m7_itcm = memory_region_get_ram_ptr(&s->m7_itcm);
+    const void *m33_itcm = memory_region_get_ram_ptr(&s->m33_itcm);
+    uint32_t initial_sp = ldl_le_p(m7_itcm);
+
+    /*
+     * When the SM (M33 firmware) is loaded it owns the M7 lifecycle: it boots
+     * the M7 via DEV_SM_CpuStart (driven by our boot-ROM handover above),
+     * which our AONMIX M7_CFG.WAIT model turns into the release and which also
+     * enables the M7 fault IRQ. Force-starting the M7 here would race that
+     * managed release, so skip it when the SM is present. This force start is
+     * only for SM-less M7 boots, where nothing else releases
+     * the core.
+     */
+    if (ldl_le_p(m33_itcm) != 0) {
+        return;
+    }
+
+    if (initial_sp != 0 && s->m7.cpu) {
+        CPUState *cs = CPU(s->m7.cpu);
+        cs->halted = 0;
+        cpu_resume(cs);
+    }
+}
+
+/*
+ * System-reset handler: (re-)apply the M33 and M7 auto-start checks. This
+ * runs on the initial reset AND on every guest-triggered reboot, so the SM
+ * core is released again after a reset re-applies its start-powered-off
+ * state - without this a reboot would leave the M33 halted, no SCMI, and
+ * Linux would hang at arm-scmi probe. The releases are deferred to a BH so
+ * they run once the reset (including the -device loader repopulating the
+ * ITCMs and cpu_reset re-applying start-powered-off) has fully completed.
+ */
+static void fsl_imx95_reset(void *opaque)
+{
+    FslImx95State *s = opaque;
+
+    aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                            fsl_imx95_m33_start_bh, s);
+    aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                            fsl_imx95_m7_start_bh, s);
+}
+
+/*
+ * SRC-driven M7 release path. When the SM's
+ * DEV_SM_CpuStart(M7) writes SRC_GEN.SCR.BOOT_RESET_RELEASE_M7MIX
+ * (bit 12) from 0 to 1, hw/misc/imx95_src raises this irq. We defer
+ * the actual cpu_resume to a BH so it runs in the AIO context rather
+ * than inside the M33's TCG block that issued the SCR write. The
+ * underlying fsl_imx95_m7_start_bh's vector[0] guard keeps the release
+ * safe when no M7 firmware is loaded - in that case it's a no-op
+ * (preserves the Linux-only boot path's behaviour). Edge-triggered
+ * so a re-write of the bit (locked, won't change) doesn't repeatedly
+ * fire; the SRC model only raises on the 0 -> 1 transition.
+ */
+static void fsl_imx95_src_m7_release_handler(void *opaque, int n, int level)
+{
+    FslImx95State *s = opaque;
+
+    if (!level) {
+        return;
+    }
+    aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                            fsl_imx95_m7_start_bh, s);
+}
+
+/*
+ * M7 run gate. The SM manages the M7 lifecycle via its CPUWAIT
+ * (AONMIX M7_CFG.WAIT): it releases the M7 on DEV_SM_CpuStart and holds it on
+ * DEV_SM_CpuStop. The fault-recovery path (reaction=lm_reset) does stop then
+ * start, cold-cycling the M7. imx95_aonmix drives the m7-run line with the
+ * released state; we halt the M7 when held and reset+resume it when released.
+ *
+ * Both run as work on the M7 vCPU so the state change is applied with the
+ * core stopped (the WAIT write happens in the M33's TCG block, a different
+ * CPU). On release we cpu_reset the M7 first: for ARMv7-M that reloads SP/PC
+ * from the reset vector in ITCM (which still holds the firmware image - we
+ * don't wipe it), so the M7 re-runs from the top, exactly as after the SM's
+ * real DEV_SM_CpuStart. cpu_reset re-applies start-powered-off (halted = 1),
+ * so we clear halted afterwards to release it.
+ */
+static void fsl_imx95_m7_power_off_work(CPUState *cs, run_on_cpu_data data)
+{
+    cs->halted = 1;
+}
+
+static void fsl_imx95_m7_power_on_work(CPUState *cs, run_on_cpu_data data)
+{
+    cpu_reset(cs);
+    cs->halted = 0;
+}
+
+static void fsl_imx95_m7_power_off_bh(void *opaque)
+{
+    FslImx95State *s = opaque;
+
+    if (s->m7.cpu) {
+        async_run_on_cpu(CPU(s->m7.cpu), fsl_imx95_m7_power_off_work,
+                         RUN_ON_CPU_NULL);
+    }
+}
+
+static void fsl_imx95_m7_power_on_bh(void *opaque)
+{
+    FslImx95State *s = opaque;
+
+    if (s->m7.cpu) {
+        async_run_on_cpu(CPU(s->m7.cpu), fsl_imx95_m7_power_on_work,
+                         RUN_ON_CPU_NULL);
+    }
+}
+
+/*
+ * The M7's NVIC SYSRESETREQ gpio-out (pulsed when firmware writes
+ * AIRCR.SYSRESETREQ) - forward it to the SM as CM7_SYSRESETREQ_IRQn on the
+ * M33's NVIC, the way the SRC routes it on silicon.
+ */
+static void fsl_imx95_m7_sysresetreq_handler(void *opaque, int n, int level)
+{
+    FslImx95State *s = opaque;
+
+    qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->m33),
+                                  FSL_IMX95_M7_SYSRESETREQ_M33_IRQ), level);
+}
+
+static void fsl_imx95_m7_run_handler(void *opaque, int n, int level)
+{
+    FslImx95State *s = opaque;
+
+    /*
+     * Defer to a BH so the cross-CPU async work is queued from the AIO
+     * context rather than inside the M33's TCG block that wrote M7_CFG.
+     * level: 1 = released (start), 0 = held (stop).
+     */
+    aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                            level ? fsl_imx95_m7_power_on_bh
+                                  : fsl_imx95_m7_power_off_bh, s);
+}
+
+static void fsl_imx95_realize(DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    FslImx95State *s = FSL_IMX95(dev);
+    DeviceState *gicdev = DEVICE(&s->gic);
+    const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a55");
+    /*
+     * The 19x19 EVK has a fixed 6-core A55 cluster. The Cortex-M33 SM
+     * core and the Cortex-M7 real-time core are additional, always-present
+     * vCPUs not part of the A55 cluster (each has its own NVIC, not the
+     * GIC), so the A55 wiring below is sized by the fixed cluster count
+     * rather than ms->smp.cpus, which also counts the M33 and M7.
+     */
+    const unsigned n_a55 = FSL_IMX95_NUM_A55_CPUS;
+    int i;
+
+    if (ms->smp.cpus != n_a55 + 2) {
+        error_setg(errp,
+                   "%s: fixed topology is %u A55 + 1 M33 + 1 M7; "
+                   "run with -smp %u (the default) - %d requested",
+                   TYPE_FSL_IMX95, n_a55, n_a55 + 2, (int)ms->smp.cpus);
+        return;
+    }
+
+    /* Instantiate the A55 cluster. */
+    for (i = 0; i < n_a55; i++) {
+        g_autofree char *name = g_strdup_printf("cpu%d", i);
+        object_initialize_child(OBJECT(dev), name, &s->cpu[i], cpu_type);
+    }
+
+    for (i = 0; i < n_a55; i++) {
+        if (n_a55 > 1 &&
+            object_property_find(OBJECT(&s->cpu[i]), "reset-cbar")) {
+            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
+                                    fsl_imx95_memmap[FSL_IMX95_GIC_DIST].addr,
+                                    &error_abort);
+        }
+
+        /*
+         * CNTFRQ for the ARM generic timer. The i.MX 95 system counter
+         * runs at 24 MHz (RM "System Counter" section).
+         */
+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 24000000,
+                                &error_abort);
+
+        /*
+         * MPIDR per-CPU. The Linux DTS (imx95.dtsi cpu@0..cpu@500)
+         * puts each A55 in its own cluster: Aff1 = CPU index, Aff0 = 0.
+         * So cpu[i] gets mp-affinity = i << 8. PSCI CPU_ON from Linux
+         * uses these MPIDR values to identify the target CPU; without
+         * the override QEMU would default to Aff0=i which doesn't match
+         * the DT and PSCI CPU_ON fails for every secondary.
+         * Source: Linux arch/arm64/boot/dts/freescale/imx95.dtsi
+         */
+        object_property_set_uint(OBJECT(&s->cpu[i]), "mp-affinity",
+                                 (uint64_t)i << 8, &error_abort);
+
+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el2")) {
+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el2",
+                                     !kvm_enabled(), &error_abort);
+        }
+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
+                                     !kvm_enabled(), &error_abort);
+        }
+
+        /*
+         * U-Boot proper runs at EL3 (no TF-A below it in our model)
+         * and issues OPTEE/PSCI SMCs assuming firmware will service
+         * them. Without psci-conduit, those SMCs trap to U-Boot's own
+         * EL3 sync vector and crash. Wire QEMU's built-in PSCI handler
+         * to the SMC conduit so PSCI calls return cleanly and the
+         * vendor-OS calls return UNDEFINED, which U-Boot handles as
+         * "no OP-TEE present" and moves on.
+         */
+        object_property_set_int(OBJECT(&s->cpu[i]), "psci-conduit",
+                                QEMU_PSCI_CONDUIT_SMC, &error_abort);
+
+        if (i) {
+            /* Secondary CPUs come up via PSCI / SRC. */
+            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powered-off",
+                                     true, &error_abort);
+        }
+
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
+            return;
+        }
+    }
+
+    /* GIC-600 (GICv3) */
+    {
+        SysBusDevice *gicsbd = SYS_BUS_DEVICE(&s->gic);
+        QList *redist_region_count;
+
+        qdev_prop_set_uint32(gicdev, "num-cpu", n_a55);
+        qdev_prop_set_uint32(gicdev, "num-irq",
+                             FSL_IMX95_NUM_IRQS + GIC_INTERNAL);
+
+        redist_region_count = qlist_new();
+        qlist_append_int(redist_region_count, n_a55);
+        qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
+
+        object_property_set_link(OBJECT(&s->gic), "sysmem",
+                                 OBJECT(get_system_memory()), &error_fatal);
+        if (!sysbus_realize(gicsbd, errp)) {
+            return;
+        }
+        sysbus_mmio_map(gicsbd, 0, fsl_imx95_memmap[FSL_IMX95_GIC_DIST].addr);
+        sysbus_mmio_map(gicsbd, 1, fsl_imx95_memmap[FSL_IMX95_GIC_REDIST].addr);
+
+        /* Wire the per-CPU timer PPIs and IRQ/FIQ lines. */
+        for (i = 0; i < n_a55; i++) {
+            DeviceState *cpudev = DEVICE(&s->cpu[i]);
+            int intidbase = FSL_IMX95_NUM_IRQS + i * GIC_INTERNAL;
+            qemu_irq irq;
+
+            static const int timer_irqs[] = {
+                [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+                [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+                [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+                [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+            };
+            for (size_t j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
+                irq = qdev_get_gpio_in(gicdev, intidbase + timer_irqs[j]);
+                qdev_connect_gpio_out(cpudev, j, irq);
+            }
+
+            sysbus_connect_irq(gicsbd, i,
+                qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+            sysbus_connect_irq(gicsbd, i + n_a55,
+                qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+            sysbus_connect_irq(gicsbd, i + 2 * n_a55,
+                qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+            sysbus_connect_irq(gicsbd, i + 3 * n_a55,
+                qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+        }
+    }
+
+    /* On-chip RAM. */
+    memory_region_init_ram(&s->ocram, NULL, "imx95-ocram",
+                           fsl_imx95_memmap[FSL_IMX95_OCRAM].size,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx95_memmap[FSL_IMX95_OCRAM].addr,
+                                &s->ocram);
+
+    /* LPUARTs. LPUART1 is the 19x19 EVK console. */
+    {
+        static const struct {
+            int region;
+            int irq;
+        } lpuart_table[FSL_IMX95_NUM_LPUARTS] = {
+            { FSL_IMX95_LPUART1, FSL_IMX95_LPUART1_IRQ },
+            { FSL_IMX95_LPUART2, FSL_IMX95_LPUART2_IRQ },
+            { FSL_IMX95_LPUART3, FSL_IMX95_LPUART3_IRQ },
+            { FSL_IMX95_LPUART4, FSL_IMX95_LPUART4_IRQ },
+            { FSL_IMX95_LPUART5, FSL_IMX95_LPUART5_IRQ },
+            { FSL_IMX95_LPUART6, FSL_IMX95_LPUART6_IRQ },
+            { FSL_IMX95_LPUART7, FSL_IMX95_LPUART7_IRQ },
+            { FSL_IMX95_LPUART8, FSL_IMX95_LPUART8_IRQ },
+        };
+
+        for (i = 0; i < FSL_IMX95_NUM_LPUARTS; i++) {
+            SysBusDevice *sbd = SYS_BUS_DEVICE(&s->lpuart[i]);
+
+            qdev_prop_set_chr(DEVICE(&s->lpuart[i]), "chardev",
+                              serial_hd(i));
+            if (!sysbus_realize(sbd, errp)) {
+                return;
+            }
+            sysbus_mmio_map(sbd, 0,
+                            fsl_imx95_memmap[lpuart_table[i].region].addr);
+            sysbus_connect_irq(sbd, 0,
+                qdev_get_gpio_in(gicdev, lpuart_table[i].irq));
+        }
+    }
+
+    /*
+     * System Manager mailbox (MU2) shared memory.
+     *
+     * The Cortex-M33 SM firmware sits on the far side of MU2, talking
+     * SCMI back to whoever is running on the A55s (U-Boot SPL, U-Boot
+     * proper, Linux); it is the only SCMI provider on this machine.
+     *
+     * Convert SM_SHMEM (sram0) from an unimplemented logging stub to
+     * a real RAM region so the SMT shared-memory transport can be
+     * read and written by both sides.
+     */
+    memory_region_init_ram(&s->sm_shmem, OBJECT(dev), "imx95-sm-shmem",
+                           fsl_imx95_memmap[FSL_IMX95_SM_SHMEM].size,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx95_memmap[FSL_IMX95_SM_SHMEM].addr,
+                                &s->sm_shmem);
+
+    /*
+     * System counter (see comment on s->sysctr in fsl-imx95.h): a real
+     * clockevent timer, since it is Linux's tick broadcast device for the
+     * local-timer-stop idle state. Not in the unimplemented-region list.
+     */
+    s->sysctr = qdev_new("imx95.sysctr");
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(s->sysctr), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(s->sysctr), 0,
+                    fsl_imx95_memmap[FSL_IMX95_SYSCNT].addr);
+    sysbus_connect_irq(SYS_BUS_DEVICE(s->sysctr), 0,
+                       qdev_get_gpio_in(gicdev, FSL_IMX95_SYSCNT_IRQ));
+
+    /*
+     * BBNSM region as RAM (see comment on s->bbnsm in fsl-imx95.h). The
+     * M33 SM firmware reaches it via the m33_view alias of system memory.
+     */
+    memory_region_init_ram(&s->bbnsm, OBJECT(dev), "imx95-bbnsm",
+                           fsl_imx95_memmap[FSL_IMX95_BBNSM].size,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx95_memmap[FSL_IMX95_BBNSM].addr,
+                                &s->bbnsm);
+
+    /* HSIO BLK_CTRL (HSIOMIX) as RAM (see comment on s->blk_ctrl_hsiomix). */
+    memory_region_init_ram(&s->blk_ctrl_hsiomix, OBJECT(dev),
+                           "imx95-blk-ctrl-hsiomix",
+                           fsl_imx95_memmap[FSL_IMX95_BLK_CTRL_HSIOMIX].size,
+                           &error_fatal);
+    memory_region_add_subregion(
+        get_system_memory(),
+        fsl_imx95_memmap[FSL_IMX95_BLK_CTRL_HSIOMIX].addr,
+        &s->blk_ctrl_hsiomix);
+
+    /*
+     * Fuse Shadow Block as RAM. On real silicon the ROM/ELE populates it
+     * from OTP before the SM runs; here the SM's DEV_SM_FuseInit just reads
+     * fuse words (FSB->FUSE[]), so a readable region is enough to get past
+     * the read. Fuse values default to zero; populate specific words later
+     * if a DEV_SM_Init consumer needs a non-zero value.
+     */
+    memory_region_init_ram(&s->fsb, OBJECT(dev), "imx95-fsb",
+                           fsl_imx95_memmap[FSL_IMX95_FSB].size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx95_memmap[FSL_IMX95_FSB].addr, &s->fsb);
+
+    /*
+     * VFCCU (fault collection/control) as RAM. The SM's eMcem_Vfccu_InitCVfccu
+     * writes fault config/flags and only re-reads what it wrote (e.g. clears
+     * FHCFG0.FHIDEN and loops until it reads back 0), so a register-file is
+     * enough; no fault-injection or IRQ behaviour is modelled.
+     */
+    memory_region_init_ram(&s->vfccu, OBJECT(dev), "imx95-vfccu",
+                           fsl_imx95_memmap[FSL_IMX95_VFCCU].size,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx95_memmap[FSL_IMX95_VFCCU].addr,
+                                &s->vfccu);
+
+    /*
+     * A55 CPU wait-semaphore SRAM. DEV_SM_CpuInit resets a Peterson-style
+     * semaphore (flag0/flag1/turn) the SM keeps at 0x442313f8 (in the A1 MU
+     * SRAM page); back it with RAM so the writes land.
+     */
+    memory_region_init_ram(&s->cpu_sema, OBJECT(dev), "imx95-cpu-sema",
+                           fsl_imx95_memmap[FSL_IMX95_CPU_SEMA].size,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx95_memmap[FSL_IMX95_CPU_SEMA].addr,
+                                &s->cpu_sema);
+
+    /*
+     * CortexA TMPSNS as RAM. The SM's periodic sensor tick reads CTRL0
+     * (TMPSNS_GetFilterBusy) and the data/threshold registers; with the
+     * region zeroed the filter reads "idle" and the tick is a no-op. No
+     * real thermal model (canned/quiet); enough to keep the post-init
+     * sensor task from faulting on an unmapped read.
+     */
+    memory_region_init_ram(&s->tmpsns_ca, OBJECT(dev), "imx95-tmpsns-ca",
+                           fsl_imx95_memmap[FSL_IMX95_TMPSNS_CA].size,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx95_memmap[FSL_IMX95_TMPSNS_CA].addr,
+                                &s->tmpsns_ca);
+
+    /*
+     * More register-file write targets the SM's eMcem/fabric init touches:
+     * AON_VFCCU (FCCU central, 0x44570000), AON_ERMA (error reporting,
+     * 0x44560000) and NOC_SRAMCTL (0x490a0000). The SM only writes config
+     * and reads back what it wrote, so plain RAM suffices; no fault or
+     * fabric behaviour is modelled.
+     */
+    memory_region_init_ram(&s->vfccu_aon, OBJECT(dev), "imx95-vfccu-aon",
+                           fsl_imx95_memmap[FSL_IMX95_VFCCU_AON].size,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx95_memmap[FSL_IMX95_VFCCU_AON].addr,
+                                &s->vfccu_aon);
+    memory_region_init_ram(&s->erma, OBJECT(dev), "imx95-erma",
+                           fsl_imx95_memmap[FSL_IMX95_ERMA].size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx95_memmap[FSL_IMX95_ERMA].addr,
+                                &s->erma);
+    memory_region_init_ram(&s->noc_sramctl, OBJECT(dev), "imx95-noc-sramctl",
+                           fsl_imx95_memmap[FSL_IMX95_NOC_SRAMCTL].size,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx95_memmap[FSL_IMX95_NOC_SRAMCTL].addr,
+                                &s->noc_sramctl);
+
+    {
+        SysBusDevice *mu_sbd = SYS_BUS_DEVICE(&s->sm_mu);
+
+        if (!sysbus_realize(mu_sbd, errp)) {
+            return;
+        }
+        sysbus_mmio_map(mu_sbd, 0,
+                        fsl_imx95_memmap[FSL_IMX95_SM_MU].addr);
+        sysbus_connect_irq(mu_sbd, 0,
+            qdev_get_gpio_in(gicdev, FSL_IMX95_SM_MU_IRQ));
+    }
+
+    /*
+     * ELE mailbox 1 and its responder stub. The MU is a plain
+     * register file; the ele-server hangs off the MU's TR-write hook
+     * and answers ELE-protocol commands from SPL with stub responses.
+     * The responder only needs ele_get_info() to succeed for U-Boot
+     * SPL's imx9_probe_mu() to complete.
+     */
+    {
+        SysBusDevice *mu_sbd = SYS_BUS_DEVICE(&s->ele_mu1);
+
+        if (!sysbus_realize(mu_sbd, errp)) {
+            return;
+        }
+        sysbus_mmio_map(mu_sbd, 0,
+                        fsl_imx95_memmap[FSL_IMX95_ELE_MU1].addr);
+    }
+
+    /*
+     * Ordering is load-bearing here: the MU must be realised (so its
+     * MMIO + state are valid) BEFORE the responder is realised,
+     * because the responder's realize() calls imx_mu_set_tr_write_handler()
+     * on the MU. The dependency is via a runtime callback registration
+     * inside the responder's realize hook, not via a QOM property, so
+     * a grep for "ele_mu1" won't surface it. If you reorder these
+     * lines, the responder will register its handler on a still-zeroed
+     * MU state and SPL's first ELE TR write will silently no-op.
+     */
+    object_property_set_link(OBJECT(&s->ele_server), "mu",
+                             OBJECT(&s->ele_mu1), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ele_server), errp)) {
+        return;
+    }
+
+    /*
+     * ELE MU 0 (elemu0, 0x47520000) + its responder. This is the EdgeLock
+     * channel the M33 SM uses during DEV_SM_Init (ELE_MuTx). Without a real
+     * MU here the SM's MU_SendMsg spins on TSR.TEn, and without a responder
+     * it then waits forever for an ELE reply. Same MU-then-responder
+     * ordering rule as ele_mu1 above.
+     */
+    {
+        SysBusDevice *mu_sbd = SYS_BUS_DEVICE(&s->ele_mu0);
+
+        if (!sysbus_realize(mu_sbd, errp)) {
+            return;
+        }
+        sysbus_mmio_map(mu_sbd, 0,
+                        fsl_imx95_memmap[FSL_IMX95_ELE_MU].addr);
+    }
+    object_property_set_link(OBJECT(&s->ele_server0), "mu",
+                             OBJECT(&s->ele_mu0), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ele_server0), errp)) {
+        return;
+    }
+
+    /*
+     * Realise the 6 stub MUs. Wiring imx_mu_set_tr_write_handler() to
+     * a NOP makes IMX_MU re-assert TSR.TEn after every TR write, so
+     * U-Boot's TX-empty poll on these unmodeled mailboxes completes
+     * instead of looping. RR stays empty - no responder, no replies -
+     * which matches "the mailbox is here but nothing is listening on
+     * the other end."
+     */
+    {
+        static const int stub_mu_regions[] = {
+            FSL_IMX95_MU_47320000, FSL_IMX95_MU_47350000,
+            FSL_IMX95_MU_47540000, FSL_IMX95_MU_47550000,
+            FSL_IMX95_MU_47560000, FSL_IMX95_MU_47570000,
+        };
+        QEMU_BUILD_BUG_ON(ARRAY_SIZE(stub_mu_regions) !=
+                          ARRAY_SIZE(s->stub_mu));
+        for (i = 0; i < ARRAY_SIZE(s->stub_mu); i++) {
+            SysBusDevice *sbd = SYS_BUS_DEVICE(&s->stub_mu[i]);
+            if (!sysbus_realize(sbd, errp)) {
+                return;
+            }
+            sysbus_mmio_map(sbd, 0,
+                            fsl_imx95_memmap[stub_mu_regions[i]].addr);
+            imx_mu_set_tr_write_handler(&s->stub_mu[i],
+                                        fsl_imx95_stub_mu_tr_write, NULL);
+        }
+    }
+
+    /*
+     * MUI_A5 @0x44610000 - the M7-side MUA of the M7<->SM SCMI channel.
+     * Realised + mapped here so the window exists; its peer (MUB), the
+     * SMT shared-memory page, and both cores' IRQs are wired in one block
+     * after the M33 and M7 are realised (see the M7 cross-connect below).
+     */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->m7_sm_mu), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->m7_sm_mu), 0, 0x44610000);
+
+    /*
+     * Wire the second ELE responder to the stub MU at 0x47550000.
+     * imx9_probe_mu() in U-Boot proper (SCMI variant, arch/arm/
+     * mach-imx/imx9/scmi/soc.c:1953) hard-codes "mailbox@47550000" as
+     * the ELE channel; SPL's matching #if XPL_BUILD branch uses
+     * "mailbox@47530000" (our ele_mu1). Mirror the responder here so
+     * U-Boot proper's ele_get_info() completes instead of timing out.
+     * The realize call below will overwrite the NOP tr-write handler
+     * the stub_mu loop above just installed.
+     *
+     * stub_mu[3] = FSL_IMX95_MU_47550000 (must match stub_mu_regions
+     * ordering above; the QEMU_BUILD_BUG_ON in the loop body anchors
+     * the count but not the order).
+     */
+    object_property_set_link(OBJECT(&s->ele_server2), "mu",
+                             OBJECT(&s->stub_mu[3]), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ele_server2), errp)) {
+        return;
+    }
+
+    /*
+     * Watchdog 3 (the Wakeup-domain wdog the kernel sees). U-Boot SPL
+     * also disables it in arch_cpu_init() before the console comes up.
+     * Stub model is enough to satisfy disable_wdog().
+     */
+    s->wdog3 = qdev_new("imx95.wdog");
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(s->wdog3), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(s->wdog3), 0,
+                    fsl_imx95_memmap[FSL_IMX95_WDOG3].addr);
+
+    /*
+     * WDOG2 is the M33 SM's own watchdog: its reset handler unlocks it
+     * (key 0xD928C520 -> CNT) and configures it before continuing. Same
+     * ULP WDOG IP as wdog3; reuse the model (no timer behaviour, so it
+     * never fires - the SM is free to configure and refresh it).
+     */
+    s->wdog2 = qdev_new("imx95.wdog");
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(s->wdog2), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(s->wdog2), 0,
+                    fsl_imx95_memmap[FSL_IMX95_WDOG2].addr);
+
+    /*
+     * M33 XCACHE controllers. The SM enables + invalidates its caches at
+     * boot (CCR ENCACHE + INVWn + GO, then polls); the model self-clears
+     * the command bits so those polls converge.
+     */
+    s->xcache_pc = qdev_new("imx95.xcache");
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(s->xcache_pc), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(s->xcache_pc), 0,
+                    fsl_imx95_memmap[FSL_IMX95_XCACHE_PC].addr);
+    s->xcache_ps = qdev_new("imx95.xcache");
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(s->xcache_ps), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(s->xcache_ps), 0,
+                    fsl_imx95_memmap[FSL_IMX95_XCACHE_PS].addr);
+
+    /*
+     * LPI2C master the SM uses for the PMIC + IO-expander (SDK LPI2C1 at
+     * 0x44340000 = our FSL_IMX95_LPI2C7). Real model with the serial
+     * devices BRD_SM_SerialDevicesInit probes on its bus, so SM init
+     * completes: PCAL6408A IO-expander (0x20), PF09 main PMIC (0x08), and
+     * the PF5301/PF5302 (PF53) buck regulators (0x2a/0x29). The PCA2131 RTC
+     * (0x53) needs no model - its PCA2131_Init() is a no-op.
+     */
+    s->lpi2c_pmic = qdev_new("imx.lpi2c");
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(s->lpi2c_pmic), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(s->lpi2c_pmic), 0,
+                    fsl_imx95_memmap[FSL_IMX95_LPI2C7].addr);
+    {
+        I2CBus *i2c = I2C_BUS(qdev_get_child_bus(s->lpi2c_pmic, "i2c"));
+        i2c_slave_create_simple(i2c, "pf09-pmic", 0x08);
+        i2c_slave_create_simple(i2c, "pcal6408a", 0x20);
+        i2c_slave_create_simple(i2c, "pf53-pmic", 0x2a);
+        i2c_slave_create_simple(i2c, "pf53-pmic", 0x29);
+    }
+
+    /*
+     * GPC: the SM polls per-domain CMC_MODE_STAT and uses the sleep/wake
+     * handshakes for CPU power-mode control. The model mirrors each status
+     * register to its paired control so the SM's "request mode, wait for
+     * mode" loops converge.
+     */
+    s->gpc = qdev_new("imx95.gpc");
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(s->gpc), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(s->gpc), 0,
+                    fsl_imx95_memmap[FSL_IMX95_GPC].addr);
+
+    /*
+     * SRC: the SM powers mix domains down/up via SLICE_SW_CTRL.PDN_SOFT and
+     * polls each slice's FUNC_STAT until the transition completes. The model
+     * derives FUNC_STAT from PDN_SOFT (instantaneous), so DEV_SM_Init's
+     * power-down/up poll loops converge instead of spinning forever.
+     */
+    s->src = qdev_new("imx95.src");
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(s->src), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(s->src), 0,
+                    fsl_imx95_memmap[FSL_IMX95_SRC].addr);
+    /*
+     * Wire SRC_GEN.SCR.BOOT_RESET_RELEASE_M7MIX rising edge to the M7
+     * release path. This is the silicon-faithful M7 lifecycle handle:
+     * the SM's CpuStart(M7_cpu_id) writes the bit, our SRC model raises
+     * the named gpio-out, the handler schedules fsl_imx95_m7_start_bh.
+     * Complements the existing reset-time release (which serves the
+     * M7-only test boots that have no SM running); fsl_imx95_m7_start_bh
+     * is idempotent so both paths firing for the same M7 boot is safe.
+     */
+    qdev_connect_gpio_out_named(s->src, "m7mix-release", 0,
+        qemu_allocate_irq(fsl_imx95_src_m7_release_handler, s, 0));
+
+    /*
+     * BLK_CTRL_S_AONMIX: real model for the M7 CPU-WAIT gate. Its M7_CFG.WAIT
+     * bit reads as held at reset, so the SM's CPU_RunModeGet sees the M7 in
+     * HOLD and runs the full DEV_SM_CpuStart (releasing CPUWAIT and enabling
+     * the M7 fault IRQ). The m7-run gpio carries the released state (1 = run,
+     * 0 = held); we wire it to the M7 run handler so the SM's stop/start of
+     * the M7 LM (incl. fault-recovery lm_reset) actually cycles the core.
+     */
+    s->aonmix = qdev_new("imx95.aonmix");
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(s->aonmix), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(s->aonmix), 0,
+                    fsl_imx95_memmap[FSL_IMX95_BLK_CTRL_S_AONMIX].addr);
+    qdev_connect_gpio_out_named(s->aonmix, "m7-run", 0,
+        qemu_allocate_irq(fsl_imx95_m7_run_handler, s, 0));
+
+    /*
+     * ANATOP/PLL: the SM's DVFS path powers a PLL up and polls
+     * PLL_STATUS.LOCK, then enables each DFS and polls DFS_STATUS.DFS_OK
+     * (an unbounded wait). The model makes LOCK mirror CTRL.POWERUP and
+     * DFS_OK mirror each DFS's enable, so the A55 perf-level set completes
+     * instead of timing out (-9) or hanging.
+     */
+    s->anatop = qdev_new("imx95.anatop");
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(s->anatop), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(s->anatop), 0,
+                    fsl_imx95_memmap[FSL_IMX95_ANATOP].addr);
+
+    /*
+     * uSDHC1/2/3. Reuses QEMU's TYPE_IMX_USDHC (an SDHCI subclass with
+     * the i.MX MMIO quirks). With no backing -drive the card line
+     * stays unpopulated and SPL fails its MMC1 probe cleanly.
+     * Attach storage with e.g.:
+     *   -drive if=none,format=raw,file=sd.img,id=mmc0
+     *   -device sd-card,drive=mmc0
+     *
+     * Realization order is intentional: we want usdhc1's sd-bus to be
+     * the first one a bare `-device sd-card,drive=...` (no explicit
+     * bus=) picks up, since SPL is hard-wired to boot from MMC1.
+     * QEMU's anonymous-bus matching prefers the most-recently-added
+     * bus of the type, so we realize the array in reverse so that
+     * usdhc1 ends up at the top of the stack.
+     */
+    {
+        static const struct {
+            int region;
+            int irq;
+        } usdhc_table[FSL_IMX95_NUM_USDHCS] = {
+            { FSL_IMX95_USDHC1, FSL_IMX95_USDHC1_IRQ },
+            { FSL_IMX95_USDHC2, FSL_IMX95_USDHC2_IRQ },
+            { FSL_IMX95_USDHC3, FSL_IMX95_USDHC3_IRQ },
+        };
+
+        for (i = FSL_IMX95_NUM_USDHCS - 1; i >= 0; i--) {
+            SysBusDevice *sbd = SYS_BUS_DEVICE(&s->usdhc[i]);
+
+            /*
+             * The i.MX 95 uSDHC has no software SD-clock-enable bit (the card
+             * clock is auto-gated) and its SDMA ignores the SDHCI buffer
+             * boundary. Enable the matching quirks on these instances only, so
+             * other machines using TYPE_IMX_USDHC are unaffected.
+             */
+            s->usdhc[i].quirks |= SDHCI_QUIRK_SDCLK_AUTO_GATE |
+                                  SDHCI_QUIRK_NO_SDMA_BOUNDARY;
+            if (!sysbus_realize(sbd, errp)) {
+                return;
+            }
+            sysbus_mmio_map(sbd, 0,
+                            fsl_imx95_memmap[usdhc_table[i].region].addr);
+            sysbus_connect_irq(sbd, 0,
+                qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
+        }
+    }
+
+    /*
+     * Cortex-M33 System Manager core. Build the M33's 32-bit
+     * address space: its private ITCM/DTCM RAM layered over a
+     * low-priority alias of the A55 system memory (so the M33 can also
+     * reach already-modelled peripherals and DRAM). The SM firmware is
+     * loaded into ITCM separately via -device loader.
+     *
+     * The M33 boots first on real silicon; here the A55 cluster is the
+     * primary boot path and the M33 is an additional core that runs only
+     * when SM firmware is loaded. With no firmware, ITCM reads back zero,
+     * so the M33 takes an early fault and locks up harmlessly without
+     * disturbing the A55s.
+     */
+    memory_region_init(&s->m33_view, OBJECT(s), "imx95-m33-view",
+                       4 * GiB);
+    /* Low-priority window onto the A55 system memory (peripherals, DRAM). */
+    memory_region_init_alias(&s->m33_sysmem_alias, OBJECT(s),
+                             "imx95-m33-sysmem", get_system_memory(),
+                             0, 4 * GiB);
+    memory_region_add_subregion_overlap(&s->m33_view, 0,
+                                        &s->m33_sysmem_alias, -1);
+    /* Private TCM, layered on top. */
+    memory_region_init_ram(&s->m33_itcm, OBJECT(s), "imx95-m33-itcm",
+                           FSL_IMX95_M33_TCM_SIZE, &error_fatal);
+    memory_region_add_subregion(&s->m33_view, FSL_IMX95_M33_ITCM_BASE,
+                                &s->m33_itcm);
+    memory_region_init_ram(&s->m33_dtcm, OBJECT(s), "imx95-m33-dtcm",
+                           FSL_IMX95_M33_TCM_SIZE, &error_fatal);
+    memory_region_add_subregion(&s->m33_view, FSL_IMX95_M33_DTCM_BASE,
+                                &s->m33_dtcm);
+
+    s->m33_cpuclk = clock_new(OBJECT(s), "m33-cpuclk");
+    clock_set_hz(s->m33_cpuclk, FSL_IMX95_M33_CLK_HZ);
+
+    qdev_prop_set_string(DEVICE(&s->m33), "cpu-type",
+                         ARM_CPU_TYPE_NAME("cortex-m33"));
+    qdev_prop_set_uint32(DEVICE(&s->m33), "num-irq", FSL_IMX95_M33_NUM_IRQ);
+    qdev_prop_set_uint32(DEVICE(&s->m33), "init-svtor", FSL_IMX95_M33_SVTOR);
+    /*
+     * Hold the M33 in reset until we know SM firmware was loaded into its
+     * ITCM (released by fsl_imx95_reset). This keeps a plain A55 Linux
+     * boot - which loads no SM image - from running the M33 on a zeroed
+     * ITCM straight into a HardFault lockup.
+     */
+    qdev_prop_set_bit(DEVICE(&s->m33), "start-powered-off", true);
+    qdev_connect_clock_in(DEVICE(&s->m33), "cpuclk", s->m33_cpuclk);
+    object_property_set_link(OBJECT(&s->m33), "memory",
+                             OBJECT(&s->m33_view), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->m33), errp)) {
+        return;
+    }
+
+    /*
+     * MU2 SCMI: instantiate the M33-side (MUB) endpoint of MU2 and peer-link
+     * it to the A55-side MU, so the real SM firmware on the M33 services the
+     * A55's SCMI. Linux's SCMI doorbell on MUA (0x445b0000) latches the
+     * matching GIP on MUB and raises the M33's MU2_B IRQ; the SM's response
+     * doorbell on MUB raises the A55's MU IRQ in turn. The MUB and its sram0
+     * alias sit 0x10000 above their MUA counterparts (A2_MUB = A2_MUA +
+     * 0x10000), and the SM's mb_mu computes its SMT buffer at MUB+0x1000 -
+     * the same backing RAM Linux uses at MUA+0x1000, so both sides exchange
+     * messages through one buffer. Done after the M33 is realized so its NVIC
+     * GPIO inputs exist. (A plain A55 boot with no SM firmware loaded leaves
+     * the M33 halted, so nothing answers SCMI - the SM image is required.)
+     */
+    {
+        IMXMUState *mub = &s->sm_mu_b;
+        hwaddr mub_base = fsl_imx95_memmap[FSL_IMX95_SM_MU].addr + 0x10000;
+        hwaddr shmem_b = fsl_imx95_memmap[FSL_IMX95_SM_SHMEM].addr + 0x10000;
+
+        object_initialize_child(OBJECT(s), "sm_mu_b", mub, TYPE_IMX_MU);
+        if (!sysbus_realize(SYS_BUS_DEVICE(mub), errp)) {
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(mub), 0, mub_base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(mub), 0,
+            qdev_get_gpio_in(DEVICE(&s->m33), FSL_IMX95_SM_MU_B_M33_IRQ));
+        object_property_set_link(OBJECT(&s->sm_mu), "peer", OBJECT(mub),
+                                 &error_abort);
+        object_property_set_link(OBJECT(mub), "peer", OBJECT(&s->sm_mu),
+                                 &error_abort);
+
+        memory_region_init_alias(&s->sm_shmem_b, OBJECT(s), "imx95-sm-shmem-b",
+                                 &s->sm_shmem, 0,
+                                 fsl_imx95_memmap[FSL_IMX95_SM_SHMEM].size);
+        memory_region_add_subregion(get_system_memory(), shmem_b,
+                                    &s->sm_shmem_b);
+    }
+
+    /*
+     * Cortex-M7 real-time core. Mirror of the M33 setup above with
+     * M7-specific addresses: ITCM at M7-view 0x00000000 (the M7 boots
+     * here, so its reset VTOR is 0 - the ARMv7-M default), DTCM at
+     * M7-view 0x20000000. The same TCM RAM is also aliased into the
+     * system view at 0x203c0000 / 0x20400000 per the upstream Linux
+     * imx_rproc_att_imx95_m7 table, so an A55-side loader (Linux
+     * remoteproc, U-Boot) can populate the M7's TCM from there. The
+     * standalone -device loader,...,cpu-num=7 path writes through the
+     * M7's own address space and does not need those aliases, but they
+     * match real silicon and don't get in the way.
+     */
+    memory_region_init(&s->m7_view, OBJECT(s), "imx95-m7-view",
+                       4ULL * GiB);
+    memory_region_init_alias(&s->m7_sysmem_alias, OBJECT(s),
+                             "imx95-m7-sysmem", get_system_memory(),
+                             0, 4ULL * GiB);
+    memory_region_add_subregion_overlap(&s->m7_view, 0,
+                                        &s->m7_sysmem_alias, -1);
+
+    memory_region_init_ram(&s->m7_itcm, OBJECT(s), "imx95-m7-itcm",
+                           FSL_IMX95_M7_TCM_SIZE, &error_fatal);
+    memory_region_add_subregion(&s->m7_view, FSL_IMX95_M7_ITCM_M7VIEW,
+                                &s->m7_itcm);
+    memory_region_init_ram(&s->m7_dtcm, OBJECT(s), "imx95-m7-dtcm",
+                           FSL_IMX95_M7_TCM_SIZE, &error_fatal);
+    memory_region_add_subregion(&s->m7_view, FSL_IMX95_M7_DTCM_M7VIEW,
+                                &s->m7_dtcm);
+
+    /* System-view aliases (A55 sees the same TCM RAM at these addrs). */
+    memory_region_init_alias(&s->m7_itcm_sysalias, OBJECT(s),
+                             "imx95-m7-itcm-sysalias", &s->m7_itcm, 0,
+                             FSL_IMX95_M7_TCM_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                FSL_IMX95_M7_ITCM_SYSVIEW,
+                                &s->m7_itcm_sysalias);
+    memory_region_init_alias(&s->m7_dtcm_sysalias, OBJECT(s),
+                             "imx95-m7-dtcm-sysalias", &s->m7_dtcm, 0,
+                             FSL_IMX95_M7_TCM_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                FSL_IMX95_M7_DTCM_SYSVIEW,
+                                &s->m7_dtcm_sysalias);
+
+    s->m7_cpuclk = clock_new(OBJECT(s), "m7-cpuclk");
+    clock_set_hz(s->m7_cpuclk, FSL_IMX95_M7_CLK_HZ);
+
+    qdev_prop_set_string(DEVICE(&s->m7), "cpu-type",
+                         ARM_CPU_TYPE_NAME("cortex-m7"));
+    qdev_prop_set_uint32(DEVICE(&s->m7), "num-irq", FSL_IMX95_M7_NUM_IRQ);
+    qdev_prop_set_uint32(DEVICE(&s->m7), "init-svtor", 0);
+    qdev_prop_set_bit(DEVICE(&s->m7), "start-powered-off", true);
+    /*
+     * The i.MX 95 RT core (Cortex-M7, ARMv7-M / PMSAv7) SDK firmware programs
+     * an MPU region whose base is not aligned to its region size (e.g. DRBAR
+     * 0x4c800000 with a 512MB size, intended as 0x40000000); align down to
+     * match the silicon instead of dropping the region as UNPREDICTABLE. The
+     * M33 is a v8-M core (PMSAv8) and needs no such quirk.
+     */
+    qdev_prop_set_bit(DEVICE(&s->m7), "pmsav7-rbar-align-down", true);
+    qdev_connect_clock_in(DEVICE(&s->m7), "cpuclk", s->m7_cpuclk);
+    object_property_set_link(OBJECT(&s->m7), "memory",
+                             OBJECT(&s->m7_view), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->m7), errp)) {
+        return;
+    }
+
+    /*
+     * Route the M7's NVIC SYSRESETREQ to the SM. On silicon the
+     * SRC turns an M7 SYSRESETREQ into CM7_SYSRESETREQ_IRQn on the M33; the SM
+     * takes the fault and, for the M7 LM (reaction=lm_reset), cold-resets it
+     * via the SRC M7 mix-slice - which our m7mix-power path then turns into a
+     * real halt+reset+resume of the M7. Without this wire, the NVIC's default
+     * unconnected behaviour would reset the whole machine. Done after both
+     * cores are realised so the M33 NVIC input exists.
+     */
+    qdev_connect_gpio_out_named(DEVICE(&s->m7), "SYSRESETREQ", 0,
+        qemu_allocate_irq(fsl_imx95_m7_sysresetreq_handler, s, 0));
+
+    /*
+     * M7<->SM SCMI channel cross-connect (MUI_A5), the mirror of the MU2
+     * block above. m7_sm_mu (MUA @0x44610000) is already mapped; here we
+     * route its IRQ to the M7's NVIC, instantiate the SM-side MUB
+     * (@0x44620000, = MUA + 0x10000) with its IRQ on the M33's NVIC, peer
+     * the two, and back the SMT shared-memory page. The M7 rings its
+     * doorbell on MUA -> GIP latches on MUB -> M33 MU5_B IRQ -> the SM's
+     * MB_MU_Handler services MU9 and replies on MUB -> GIP on MUA -> M7
+     * MU5_A IRQ. The SM already brought MU9 up in LMM_Init and is waiting.
+     * Done after both cores are realised so their NVIC inputs exist.
+     */
+    {
+        IMXMUState *mub = &s->m7_sm_mu_b;
+        hwaddr mua_base = 0x44610000;
+        hwaddr mub_base = mua_base + 0x10000;     /* 0x44620000 */
+        hwaddr shmem    = mua_base + 0x1000;      /* 0x44611000 */
+        hwaddr shmem_b  = mub_base + 0x1000;      /* 0x44621000 */
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->m7_sm_mu), 0,
+            qdev_get_gpio_in(DEVICE(&s->m7), FSL_IMX95_M7_SM_MU_M7_IRQ));
+
+        object_initialize_child(OBJECT(s), "m7_sm_mu_b", mub, TYPE_IMX_MU);
+        if (!sysbus_realize(SYS_BUS_DEVICE(mub), errp)) {
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(mub), 0, mub_base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(mub), 0,
+            qdev_get_gpio_in(DEVICE(&s->m33), FSL_IMX95_M7_SM_MU_B_M33_IRQ));
+        object_property_set_link(OBJECT(&s->m7_sm_mu), "peer", OBJECT(mub),
+                                 &error_abort);
+        object_property_set_link(OBJECT(mub), "peer", OBJECT(&s->m7_sm_mu),
+                                 &error_abort);
+
+        /*
+         * 1 KiB SMT page at MUA+0x1000, aliased to MUB+0x1000 so both sides
+         * share one buffer. The SM's three MU9 SCMI channels live at
+         * +0x000/+0x080/+0x100 within it (SM_MB_MU_BUF_SIZE = 128), well
+         * inside the page.
+         */
+        memory_region_init_ram(&s->m7_shmem, OBJECT(s), "imx95-m7-shmem",
+                               1 * KiB, &error_fatal);
+        memory_region_add_subregion(get_system_memory(), shmem, &s->m7_shmem);
+        memory_region_init_alias(&s->m7_shmem_b, OBJECT(s), "imx95-m7-shmem-b",
+                                 &s->m7_shmem, 0, 1 * KiB);
+        memory_region_add_subregion(get_system_memory(), shmem_b,
+                                    &s->m7_shmem_b);
+    }
+
+    /*
+     * MU7: the A55<->M7 rpmsg notification mailbox. Linux's cm7 remoteproc
+     * kicks the M7 by writing the virtqueue id into mu7's TR register
+     * (mbox "tx" = <&mu7 0 1>); the M7's rpmsg_lite ISR reads it from RR on
+     * its side and vice-versa. Unlike the SCMI MUs (doorbell + shared SMT
+     * page) this channel carries data in TR/RR, which imx_mu forwards
+     * across the peer link. No tr-write handler here - the peer link is the
+     * consumer. Both endpoints are real IMX_MU: mu7_a (MUA @0x42430000,
+     * Linux side, IRQ -> GIC SPI 234) and mu7_b (MUB @0x42440000, M7 side,
+     * IRQ -> M7 NVIC 207). The vrings/buffers sit in the 0x88000000
+     * carveout, ordinary DRAM both cores already see. Done after the M7 is
+     * realised so its NVIC input exists.
+     */
+    {
+        SysBusDevice *mua = SYS_BUS_DEVICE(&s->mu7_a);
+        SysBusDevice *mub = SYS_BUS_DEVICE(&s->mu7_b);
+
+        if (!sysbus_realize(mua, errp)) {
+            return;
+        }
+        sysbus_mmio_map(mua, 0, 0x42430000);
+        sysbus_connect_irq(mua, 0,
+            qdev_get_gpio_in(gicdev, FSL_IMX95_MU7_A_IRQ));
+
+        if (!sysbus_realize(mub, errp)) {
+            return;
+        }
+        sysbus_mmio_map(mub, 0, 0x42440000);
+        sysbus_connect_irq(mub, 0,
+            qdev_get_gpio_in(DEVICE(&s->m7), FSL_IMX95_MU7_B_M7_IRQ));
+
+        object_property_set_link(OBJECT(&s->mu7_a), "peer",
+                                 OBJECT(&s->mu7_b), &error_abort);
+        object_property_set_link(OBJECT(&s->mu7_b), "peer",
+                                 OBJECT(&s->mu7_a), &error_abort);
+    }
+
+    /*
+     * Register the M33 and M7 auto-start checks as a reset handler so they
+     * re-run on every system reset (initial boot and guest reboot alike),
+     * not just once at startup. The releases themselves are
+     * deferred to a BH (see fsl_imx95_reset), so they run after the generic
+     * -device loader has repopulated the ITCMs.
+     */
+    qemu_register_reset_nosnapshotload(fsl_imx95_reset, s);
+
+    /* All peripherals not yet modeled get logging stubs. */
+    if (!fsl_imx95_install_unimplemented(s, errp)) {
+        return;
+    }
+}
+
+static void fsl_imx95_init(Object *obj)
+{
+    FslImx95State *s = FSL_IMX95(obj);
+    int i;
+
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
+
+    object_initialize_child(obj, "m33", &s->m33, TYPE_ARMV7M);
+    object_initialize_child(obj, "m7", &s->m7, TYPE_ARMV7M);
+
+    for (i = 0; i < FSL_IMX95_NUM_LPUARTS; i++) {
+        g_autofree char *name = g_strdup_printf("lpuart%d", i + 1);
+        object_initialize_child(obj, name, &s->lpuart[i], TYPE_IMX_LPUART);
+    }
+
+    object_initialize_child(obj, "sm_mu", &s->sm_mu, TYPE_IMX_MU);
+    object_initialize_child(obj, "ele_mu0", &s->ele_mu0, TYPE_IMX_MU);
+    object_initialize_child(obj, "ele_mu1", &s->ele_mu1, TYPE_IMX_MU);
+    for (i = 0; i < ARRAY_SIZE(s->stub_mu); i++) {
+        g_autofree char *name = g_strdup_printf("stub_mu%d", i);
+        object_initialize_child(obj, name, &s->stub_mu[i], TYPE_IMX_MU);
+    }
+    object_initialize_child(obj, "m7_sm_mu", &s->m7_sm_mu, TYPE_IMX_MU);
+    object_initialize_child(obj, "mu7_a", &s->mu7_a, TYPE_IMX_MU);
+    object_initialize_child(obj, "mu7_b", &s->mu7_b, TYPE_IMX_MU);
+    object_initialize_child(obj, "ele-server", &s->ele_server,
+                            TYPE_IMX95_ELE_SERVER);
+    object_initialize_child(obj, "ele-server0", &s->ele_server0,
+                            TYPE_IMX95_ELE_SERVER);
+    object_initialize_child(obj, "ele-server2", &s->ele_server2,
+                            TYPE_IMX95_ELE_SERVER);
+
+    for (i = 0; i < FSL_IMX95_NUM_USDHCS; i++) {
+        g_autofree char *name = g_strdup_printf("usdhc%d", i + 1);
+        object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
+    }
+}
+
+static void fsl_imx95_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = fsl_imx95_realize;
+    /* This is an SoC, not user-creatable. */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo fsl_imx95_types[] = {
+    {
+        .name           = TYPE_FSL_IMX95,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(FslImx95State),
+        .instance_init  = fsl_imx95_init,
+        .class_init     = fsl_imx95_class_init,
+    },
+};
+
+DEFINE_TYPES(fsl_imx95_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 8ee5307a919..96fef4c5b5f 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -117,5 +117,6 @@ arm_common_ss.add(when: ['CONFIG_AXIADO_EVK', 'TARGET_AARCH64'], if_true: files(
   'ax3000-evk.c'))
 
 arm_common_ss.add(files('boot.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX95', if_true: files('fsl-imx95.c'))
 
 hw_common_arch += {'arm': arm_common_ss}
diff --git a/include/hw/arm/fsl-imx95.h b/include/hw/arm/fsl-imx95.h
new file mode 100644
index 00000000000..473b1bdf483
--- /dev/null
+++ b/include/hw/arm/fsl-imx95.h
@@ -0,0 +1,481 @@
+/*
+ * NXP i.MX 95 SoC definitions
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * Modeled on hw/arm/fsl-imx8mp.h
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Address and IRQ ground truth comes from two sources:
+ *   - Linux DTS for everything Linux probes directly:
+ *     arch/arm64/boot/dts/freescale/imx95.dtsi
+ *   - NXP U-Boot's RM-derived header for the SCMI-routed peripherals
+ *     U-Boot SPL pokes before SCMI is up:
+ *     arch/arm/include/asm/arch-imx9/imx-regs.h
+ * The latter set (CCM, ANATOP, IOMUXC, SRC, TRDC, the BLK_CTRL
+ * aggregates) is currently logging-stub only - they are not modelled
+ * because the NXP imx95-evk SPL routes all clock/pinmux/power-domain
+ * access through SCMI to the M33 SM, which is the only SCMI provider.
+ */
+
+#ifndef FSL_IMX95_H
+#define FSL_IMX95_H
+
+#include "target/arm/cpu.h"
+#include "hw/arm/armv7m.h"
+#include "hw/char/imx_lpuart.h"
+#include "hw/core/clock.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx95_ele_server.h"
+#include "hw/misc/imx_mu.h"
+#include "hw/sd/sdhci.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "qemu/notify.h"
+#include "qemu/units.h"
+
+#define TYPE_FSL_IMX95 "fsl-imx95"
+OBJECT_DECLARE_SIMPLE_TYPE(FslImx95State, FSL_IMX95)
+
+/*
+ * Main DDR window. i.MX 95 maps DRAM starting at 0x8000_0000 on both
+ * the 19x19 (LPDDR5) and 15x15 (LPDDR4X) EVK variants.
+ */
+#define FSL_IMX95_RAM_START         0x80000000ULL
+#define FSL_IMX95_RAM_SIZE_MAX      (16ULL * GiB)
+/* Enough to hold the board's DTB (+128 MiB) and initrd (+256 MiB) presets. */
+#define FSL_IMX95_RAM_SIZE_MIN      (512ULL * MiB)
+
+/*
+ * Cortex-M33 System Manager (SM) core. The SM firmware is linked to run
+ * from the M33's tightly-coupled memories: code in ITCM, data/bss/stack
+ * in DTCM. Sizes are rounded up to 256 KiB (the real TCM banks are
+ * smaller; the SM image fits well within this). The reset vector table
+ * sits at the ITCM base, so the M33's reset VTOR (init-svtor) points
+ * there. The M33's 32-bit view is otherwise a superset of the A55 view
+ * (it also reaches CCM/ANATOP/SRC/etc. that the A55 cannot) - we give it
+ * the A55 system memory plus its private TCM; unmodelled SM-only
+ * peripherals are backed by logging stubs.
+ */
+#define FSL_IMX95_M33_ITCM_BASE     0x1ffc0000ULL
+#define FSL_IMX95_M33_DTCM_BASE     0x20000000ULL
+#define FSL_IMX95_M33_TCM_SIZE      (256 * KiB)
+#define FSL_IMX95_M33_SVTOR         0x1ffc0000U
+#define FSL_IMX95_M33_NUM_IRQ       256
+#define FSL_IMX95_M33_CLK_HZ        333333333U  /* SM runs the M33 ~333 MHz */
+
+/*
+ * Cortex-M7 real-time core. Memory map matches the upstream Linux
+ * imx_rproc driver's imx_rproc_att_imx95_m7 table: the M7 sees ITCM at
+ * its 0x00000000 (boot reset vector) and DTCM at 0x20000000; the A55
+ * (and any other system-view observer) sees the same TCM RAM at
+ * 0x203c0000 and 0x20400000 respectively, so a system-side firmware
+ * loader (Linux remoteproc, U-Boot, ...) can populate the M7's TCM from
+ * the A55 side. The M7's reset VTOR is 0 - the ARMv7-M default - because
+ * ITCM is at M7-view 0 in this map.
+ */
+#define FSL_IMX95_M7_ITCM_M7VIEW    0x00000000ULL  /* M7's view of ITCM */
+#define FSL_IMX95_M7_DTCM_M7VIEW    0x20000000ULL  /* M7's view of DTCM */
+#define FSL_IMX95_M7_ITCM_SYSVIEW   0x203c0000ULL  /* A55's view of M7 ITCM */
+#define FSL_IMX95_M7_DTCM_SYSVIEW   0x20400000ULL  /* A55's view of M7 DTCM */
+#define FSL_IMX95_M7_TCM_SIZE       (256 * KiB)
+#define FSL_IMX95_M7_NUM_IRQ        256
+#define FSL_IMX95_M7_CLK_HZ         800000000U  /* M7 runs ~800 MHz */
+
+/*
+ * i.MX 95 application processor complex:
+ *   - 6x Cortex-A55 (the main APUs)
+ *   - 1x Cortex-M33 (System Manager, runs real NXP SM firmware)
+ *   - 1x Cortex-M7  (real-time domain, runs an RT/MCUXpresso workload)
+ * All three are instantiated; the M33 and M7 are heterogeneous CPU
+ * contexts in the same QEMU instance, each with its own private TCMs
+ * and ARMv7-M NVIC.
+ */
+enum FslImx95Configuration {
+    FSL_IMX95_NUM_A55_CPUS  = 6,
+    FSL_IMX95_NUM_LPUARTS   = 8,    /* LPUART1..LPUART8 */
+    FSL_IMX95_NUM_USDHCS    = 3,    /* uSDHC1..uSDHC3 */
+    FSL_IMX95_NUM_IRQS      = 320,  /* GIC SPI budget (max is 1020) */
+};
+
+struct FslImx95State {
+    SysBusDevice            parent_obj;
+
+    ARMCPU                  cpu[FSL_IMX95_NUM_A55_CPUS];
+
+    /*
+     * Cortex-M33 System Manager core. Wires the CPU + its private
+     * TCM so the real NXP SM firmware (m33_image.elf) can be loaded and
+     * started; the SM firmware it runs is this machine's only SCMI provider.
+     * m33_view is the M33's 32-bit address space: ITCM + DTCM RAM layered
+     * over a low-priority alias of the A55 system memory.
+     *
+     * The M33 starts powered-off and is released (on every system reset, by
+     * fsl_imx95_reset) only if SM firmware was actually loaded into its ITCM;
+     * without firmware it stays halted, so a plain A55 Linux boot is
+     * unaffected. The same check releases the M7 by its own vector[0] test.
+     */
+    ARMv7MState             m33;
+    MemoryRegion            m33_view;
+    MemoryRegion            m33_sysmem_alias;
+    MemoryRegion            m33_itcm;
+    MemoryRegion            m33_dtcm;
+    Clock                  *m33_cpuclk;
+
+    /*
+     * Cortex-M7 real-time core. Same structural pattern as the
+     * M33: an ARMv7-M instance backed by its own ITCM + DTCM RAM regions
+     * layered over a low-priority alias of the A55 system memory, in an
+     * m7-private 32-bit view. The two *_sysalias regions expose the same
+     * TCM RAM at the system-view addresses (0x203c0000 / 0x20400000) so
+     * an A55-side loader can deposit M7 firmware into TCM from there;
+     * the standalone "-device loader,file=cm7_image.elf,cpu-num=7" path
+     * writes through the M7's own address space and does not need them.
+     * The M7 starts powered-off and is released (on system reset, by
+     * fsl_imx95_reset) alongside the M33, gated on a non-zero vector[0] in
+     * its ITCM (i.e. firmware was actually loaded).
+     */
+    ARMv7MState             m7;
+    MemoryRegion            m7_view;
+    MemoryRegion            m7_sysmem_alias;
+    MemoryRegion            m7_itcm;
+    MemoryRegion            m7_dtcm;
+    MemoryRegion            m7_itcm_sysalias;
+    MemoryRegion            m7_dtcm_sysalias;
+    Clock                  *m7_cpuclk;
+
+    GICv3State              gic;
+    MemoryRegion            ocram;
+    MemoryRegion            sm_shmem;
+    /* Alias of sm_shmem into the MU2 MUB window. */
+    MemoryRegion            sm_shmem_b;
+    /* Fuse Shadow Block (FSB) backing RAM - SM reads fuse words at boot. */
+    MemoryRegion            fsb;
+    /* VFCCU backing RAM - SM eMcem init writes fault config/flags. */
+    MemoryRegion            vfccu;
+    /* A55 CPU wait-semaphore SRAM (A1 MU SRAM page). */
+    MemoryRegion            cpu_sema;
+    /* CortexA TMPSNS backing RAM (SM sensor tick; CTRL0=0 -> filter idle). */
+    MemoryRegion            tmpsns_ca;
+    /* More eMcem/fabric init targets backed by RAM (write-acceptors). */
+    MemoryRegion            vfccu_aon;
+    MemoryRegion            erma;
+    MemoryRegion            noc_sramctl;
+    /*
+     * System counter (timer@44290000): a real clockevent model with a live
+     * counter + compare-match IRQ (hw/timer/imx95_sysctr.c). It is Linux's
+     * tick BROADCAST device - the cpu-pd-wait idle state has local-timer-stop,
+     * so an idling core shuts down its per-CPU arch timer and depends on this
+     * counter's compare interrupt to wake. (The earlier RAM stub gave write-
+     * then-read-back but no live counter / no IRQ, so idle cores never woke
+     * and the boot needed cpuidle.off=1.)
+     */
+    DeviceState            *sysctr;
+    /*
+     * BBNSM (Battery-Backed Non-Secure Module: RTC, tamper, 8 general-
+     * purpose registers) backed by RAM so writes stick. The NXP SM
+     * firmware touches it during early init (brd_sm reset-record GPRs via
+     * BBNSM_GprSetValue, and RTC setup that polls CTRL.RTC_EN back). The
+     * driver only does write-then-read-back on these registers and never
+     * reads VID/FEATURES, so a plain RAM region is sufficient. The A55
+     * Linux side does not currently touch it.
+     */
+    MemoryRegion            bbnsm;
+    /*
+     * HSIO BLK_CTRL (HSIOMIX) backed by RAM. The SM's SystemInit does a
+     * read-modify-write of the LFAST IO register at 0x4c0100c0; RAM gives
+     * the read-back the write expects.
+     */
+    MemoryRegion            blk_ctrl_hsiomix;
+    IMXLPUARTState          lpuart[FSL_IMX95_NUM_LPUARTS];
+    IMXMUState              sm_mu;
+    /* ELE MU the M33 SM uses for its EdgeLock channel (elemu0, 0x47520000). */
+    IMXMUState              ele_mu0;
+    IMXMUState              ele_mu1;
+    /*
+     * M33-side (MUB) endpoint of MU2, peer-linked to sm_mu (the A55-side
+     * MUA @0x445b0000), mapped at 0x445c0000 with its IRQ routed to the M33
+     * NVIC, so the real SM firmware services the A55's SCMI doorbells.
+     */
+    IMXMUState              sm_mu_b;
+    /*
+     * Stub MUs for the V2X / NETC / spare instances the DT references
+     * but nothing in the model talks to. Wired with a NOP tr-write
+     * handler so writes drop and TSR.TEn re-asserts, letting U-Boot
+     * iterate them cleanly without hanging on TX-empty polls.
+     */
+    IMXMUState              stub_mu[6];
+    /*
+     * M7<->SM SCMI-over-SMT channel (MUI_A5), the mirror of the A55<->SM
+     * MU2 cross-connect above for the M7's SCMI agent. m7_sm_mu is the
+     * M7-side MUA @0x44610000; m7_sm_mu_b is the SM-side MUB @0x44620000,
+     * peer-linked to it with its IRQ routed to the M33 NVIC. m7_shmem is
+     * the 1 KiB SMT shared-memory page at MUA+0x1000 (0x44611000), with
+     * m7_shmem_b aliasing the same RAM at MUB+0x1000 (0x44621000) so both
+     * sides exchange messages through one buffer. The SM brings this MU up
+     * eagerly in LMM_Init and waits interrupt-driven for the M7's doorbell.
+     */
+    IMXMUState              m7_sm_mu;
+    IMXMUState              m7_sm_mu_b;
+    MemoryRegion            m7_shmem;
+    MemoryRegion            m7_shmem_b;
+    /*
+     * MU7: the A55<->M7 rpmsg notification mailbox (Linux cm7 remoteproc
+     * kicks through it). mu7_a is the Linux-side MUA @0x42430000 (IRQ ->
+     * GIC SPI 234); mu7_b is the M7-side MUB @0x42440000 (IRQ -> M7 NVIC
+     * 207). Peer-linked so a TR write on one lands in the other's RR and
+     * raises its RX interrupt; the vrings/buffers live in the 0x88000000
+     * carveout (ordinary DRAM, seen by both cores).
+     */
+    IMXMUState              mu7_a;
+    IMXMUState              mu7_b;
+    IMX95ELEServerState     ele_server;
+    /* ELE responder for the SM's elemu0 channel (0x47520000). */
+    IMX95ELEServerState     ele_server0;
+    /*
+     * Second ELE server attached to the stub MU at 0x47550000. The
+     * imx9_probe_mu() SCMI variant in U-Boot proper hardcodes
+     * "mailbox@47550000" as the ELE channel (the SPL variant uses
+     * "mailbox@47530000", which is ele_mu1). Without an ELE responder
+     * at 0x47550000, ele_get_info() times out (-110), board_init_f's
+     * initcall fails, and the boot hangs before serial_init prints.
+     * Mirror the responder so both SPL and U-Boot proper reach it.
+     */
+    IMX95ELEServerState     ele_server2;
+    SDHCIState              usdhc[FSL_IMX95_NUM_USDHCS];
+    DeviceState            *wdog2;
+    DeviceState            *wdog3;
+    /* M33 XCACHE controllers (PC @0x44400000, PS @0x44400800). */
+    DeviceState            *xcache_pc;
+    DeviceState            *xcache_ps;
+    /*
+     * LPI2C the SM uses for the PMIC / IO-expander (SDK "LPI2C1" at
+     * 0x44340000, our memmap FSL_IMX95_LPI2C7). Real master model with a
+     * PF09 PMIC + PCAL6408A on its bus; the other LPI2C instances stay
+     * logging stubs.
+     */
+    DeviceState            *lpi2c_pmic;
+    /* GPC (General Power Controller) - SM power-domain / CPU-mode control. */
+    DeviceState            *gpc;
+    /* SRC (System Reset Controller) - SM mix-slice power-down/up control. */
+    DeviceState            *src;
+    /* BLK_CTRL_S_AONMIX - M7 CPU-WAIT gate (SM-managed M7 lifecycle). */
+    DeviceState            *aonmix;
+    /* ANATOP/PLL - SM DVFS PLL lock + DFS status (A55 perf level). */
+    DeviceState            *anatop;
+
+};
+
+/*
+ * Memory map region identifiers. The actual addresses live in the memmap
+ * table in fsl-imx95.c.
+ */
+enum FslImx95MemoryRegions {
+    FSL_IMX95_RAM,
+
+    /* GIC-600 (GICv3-compatible) */
+    FSL_IMX95_GIC_DIST,
+    FSL_IMX95_GIC_REDIST,
+    FSL_IMX95_GIC_ITS,
+
+    /* On-chip SRAM "sram1" */
+    FSL_IMX95_OCRAM,
+
+    /* System counter (drives the ARM generic timer). */
+    FSL_IMX95_SYSCNT,
+
+    /* BBNSM (RTC / tamper / GPRs) - touched by the M33 SM firmware. */
+    FSL_IMX95_BBNSM,
+
+    /* M33 XCACHE controllers (enabled/invalidated by the SM at boot). */
+    FSL_IMX95_XCACHE_PC,
+    FSL_IMX95_XCACHE_PS,
+
+    /* HSIO BLK_CTRL (HSIOMIX) - SM SystemInit RMWs the LFAST IO reg. */
+    FSL_IMX95_BLK_CTRL_HSIOMIX,
+
+    /* GPC (per-domain CPU_CTRL + GLOBAL) - SM power/CPU-mode control. */
+    FSL_IMX95_GPC,
+
+    /* LPUART block (8 instances; all modelled — TYPE_IMX_LPUART) */
+    FSL_IMX95_LPUART1,
+    FSL_IMX95_LPUART2,
+    FSL_IMX95_LPUART3,
+    FSL_IMX95_LPUART4,
+    FSL_IMX95_LPUART5,
+    FSL_IMX95_LPUART6,
+    FSL_IMX95_LPUART7,
+    FSL_IMX95_LPUART8,
+
+    /*
+     * Clock / reset / pinmux infrastructure. SCMI-routed when M33 SM
+     * is up; SPL touches them only before SCMI, kernel never. Logging
+     * stubs.
+     */
+    FSL_IMX95_CCM,
+    FSL_IMX95_ANATOP,
+    FSL_IMX95_IOMUXC,
+    FSL_IMX95_SRC,
+    FSL_IMX95_TRDC_AON,
+
+    /* BLK_CTRL aggregates per power domain. Logging stubs. */
+    FSL_IMX95_BLK_CTRL_S_AONMIX,
+    FSL_IMX95_BLK_CTRL_NS_ANOMIX,
+    FSL_IMX95_BLK_CTRL_WAKEUPMIX,
+    FSL_IMX95_BLK_CTRL_NETCMIX,
+
+    /* System Manager SCMI: mu2 mailbox + sram0 shared-memory buffer */
+    FSL_IMX95_SM_MU,
+    FSL_IMX95_SM_SHMEM,
+
+    /* EdgeLock Secure Enclave mailboxes (elemu0/elemu1 needed for SPL) */
+    FSL_IMX95_ELE_MU,
+    FSL_IMX95_ELE_MU1,
+
+    /* Fuse Shadow Block - read by the SM's DEV_SM_FuseInit at boot. */
+    FSL_IMX95_FSB,
+
+    /* VFCCU (Fault Collection & Control Unit) - SM eMcem init touches it. */
+    FSL_IMX95_VFCCU,
+    /* A1 MU SRAM page holding the A55 CPU wait-semaphore (DEV_SM_CpuInit). */
+    FSL_IMX95_CPU_SEMA,
+    /* CortexA TMPSNS - SM sensor tick reads it (post-init periodic task). */
+    FSL_IMX95_TMPSNS_CA,
+    /* More SM eMcem/fabric init targets: AON_VFCCU, AON_ERMA, NOC_SRAMCTL. */
+    FSL_IMX95_VFCCU_AON,
+    FSL_IMX95_ERMA,
+    FSL_IMX95_NOC_SRAMCTL,
+
+    /*
+     * Other MU instances U-Boot proper probes from DT (mailbox@*).
+     * Not yet modelled; logging stubs are enough for mu_hal_init to
+     * complete cleanly (it reads PAR, writes RCR/TCR=0, reads SR — all
+     * zeros are accepted and the drain loop is skipped).
+     */
+    FSL_IMX95_MU_47320000,
+    FSL_IMX95_MU_47350000,
+    FSL_IMX95_MU_47540000,
+    FSL_IMX95_MU_47550000,
+    FSL_IMX95_MU_47560000,
+    FSL_IMX95_MU_47570000,
+
+    /*
+     * Watchdogs. SPL disables WDG3/4/5 in arch_cpu_init(). WDOG2 is the
+     * M33 SM's own watchdog (unlocked + configured in its reset handler).
+     */
+    FSL_IMX95_WDOG2,
+    FSL_IMX95_WDOG3,
+    FSL_IMX95_WDOG4,
+    FSL_IMX95_WDOG5,
+
+    /* GPIO controllers (1..5). SPL gpio_reset()s 2..5; #1 added for parity. */
+    FSL_IMX95_GPIO1,
+    FSL_IMX95_GPIO2,
+    FSL_IMX95_GPIO3,
+    FSL_IMX95_GPIO4,
+    FSL_IMX95_GPIO5,
+
+    /* ARM SMMU-v3 - SPL's disable_smmuv3() reads CR0; stub returns 0. */
+    FSL_IMX95_SMMU,
+
+    /*
+     * uSDHC (SD / eMMC) controllers. SPL probes them to find a boot
+     * device; stubbed so we can observe access patterns before
+     * promoting to a real fsl-esdhc model.
+     */
+    FSL_IMX95_USDHC1,
+    FSL_IMX95_USDHC2,
+    FSL_IMX95_USDHC3,
+
+    /*
+     * LPI2C controllers. U-Boot proper probes them during the post-
+     * banner dram_init / board_init phase (PMIC over I2C2 is the
+     * critical one - PCA9450 on the EVK). Logging stubs are enough
+     * to let the I2C transfer time out gracefully and DRAM init
+     * fall back to defaults.
+     */
+    FSL_IMX95_LPI2C1,
+    FSL_IMX95_LPI2C2,
+    FSL_IMX95_LPI2C3,
+    FSL_IMX95_LPI2C4,
+    FSL_IMX95_LPI2C5,
+    FSL_IMX95_LPI2C6,
+    FSL_IMX95_LPI2C7,
+    FSL_IMX95_LPI2C8,
+
+    /*
+     * USB PHY + DWC3 controller. U-Boot autoboot's bootcmd touches
+     * these via dwc3_imx8mp_glue_configure (reads at 0x4c1f0000).
+     * Logging stubs prevent the data abort that otherwise resets
+     * the board mid-autoboot.
+     */
+    FSL_IMX95_USB_PHY,
+    FSL_IMX95_USB_DWC3,
+
+    FSL_IMX95_NUM_REGIONS,
+};
+
+/*
+ * IRQ assignments. All values are GIC SPI numbers extracted from
+ * Linux arch/arm64/boot/dts/freescale/imx95.dtsi.
+ */
+enum FslImx95Irqs {
+    FSL_IMX95_LPUART1_IRQ   = 19,
+    FSL_IMX95_LPUART2_IRQ   = 20,
+    FSL_IMX95_LPUART3_IRQ   = 64,
+    FSL_IMX95_LPUART4_IRQ   = 65,
+    FSL_IMX95_LPUART5_IRQ   = 66,
+    FSL_IMX95_LPUART6_IRQ   = 67,
+    FSL_IMX95_LPUART7_IRQ   = 68,
+    FSL_IMX95_LPUART8_IRQ   = 69,
+    FSL_IMX95_WDOG3_IRQ     = 77,
+    /* uSDHC1/2/3 SPIs (dtsi: usdhc1=86, usdhc2=87, usdhc3=191). */
+    FSL_IMX95_USDHC1_IRQ    = 86,
+    FSL_IMX95_USDHC2_IRQ    = 87,
+    FSL_IMX95_USDHC3_IRQ    = 191,
+    /* system counter compare-match (dtsi: timer@44290000). */
+    FSL_IMX95_SYSCNT_IRQ    = 72,
+    /* mu2 is the SCMI mailbox to the M33 SM (dtsi:1655). */
+    FSL_IMX95_SM_MU_IRQ     = 226,
+};
+
+/*
+ * M33 NVIC external interrupt number for the MU2 B-side (MU2_B_IRQn in the
+ * SM's MIMX95 device header) - the IRQ the SM enables to receive A55 SCMI
+ * doorbells on its side of MU2.
+ */
+#define FSL_IMX95_SM_MU_B_M33_IRQ   227
+
+/*
+ * MUI_A5 (the M7<->SM SCMI channel) interrupt numbers, from the SM's
+ * MIMX95 device header (MIMX95_COMMON.h IRQn enum):
+ *   - MU5_A_IRQn = 205: the M7-side IRQ, raised on the M7's NVIC when the
+ *     SM rings its doorbell back (m7_sm_mu @0x44610000 -> M7).
+ *   - MU5_B_IRQn = 232: the SM-side IRQ, raised on the M33's NVIC when the
+ *     M7 rings its doorbell (m7_sm_mu_b @0x44620000 -> M33). The SM enables
+ *     this in MB_MU_Init for MU9 and dispatches SCMI from its handler.
+ */
+#define FSL_IMX95_M7_SM_MU_M7_IRQ   205
+#define FSL_IMX95_M7_SM_MU_B_M33_IRQ 232
+
+/*
+ * MU7 (A55<->M7 rpmsg) interrupts. MUA is the Linux side: GIC SPI 234
+ * (= MU7_A_IRQn, matching the dtsi mu7 node). MUB is the M7 side: M7 NVIC
+ * 207 (= MU7_B_IRQn in MIMX95_COMMON.h).
+ */
+#define FSL_IMX95_MU7_A_IRQ         234
+#define FSL_IMX95_MU7_B_M7_IRQ      207
+
+/*
+ * M33 NVIC inputs for the Cortex-M7 fault/reset sources the SRC routes to
+ * the System Manager (MIMX95_COMMON.h IRQn enum). When the M7 asserts
+ * SYSRESETREQ (or locks up) the SM takes the fault and, for an LM with
+ * reaction=lm_reset (the M7 LM on mx95evk), cold-resets the M7 LM via the
+ * SRC M7 mix-slice. We wire the M7's NVIC SYSRESETREQ gpio-out to
+ * CM7_SYSRESETREQ_IRQn so the real SM firmware drives the recovery.
+ */
+#define FSL_IMX95_M7_SYSRESETREQ_M33_IRQ 167
+#define FSL_IMX95_M7_LOCKUP_M33_IRQ      168
+
+#endif /* FSL_IMX95_H */
-- 
2.34.1


