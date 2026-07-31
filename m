Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86828C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFg-0002hZ-56; Fri, 31 Jul 2026 01:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM7-0005u1-Oe; Thu, 30 Jul 2026 23:56:19 -0400
Received: from [115.124.30.99] (helo=out30-99.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM0-0002IR-ED; Thu, 30 Jul 2026 23:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470165; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=dPDYKHG01bvX3ps8+/geGQfs9dBDTNN+rHrp9+MeVIA=;
 b=v8HvEqPna0eE6v/N5DVEfzdNvXhSBdz+EvSiQUtkiBomiNmoVWRAPTccZQTBm6hpaRlcRCCQYrQej9SAvFdqpl6Rjgd8LmxEyMiU548jsePHpYLa4z3SUlb8xge/Ofa4AfrP9n6kBdyYXEaJ4Ou0sNKg+O81kjm14TMiBeWzszY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R311e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwT7_1785469852; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwT7_1785469852 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:53 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 07/17] hw/riscv: adapt the device tree of a CoVE guest
Date: Fri, 31 Jul 2026 11:50:01 +0800
Message-Id: <20260731035011.4178103-8-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.99 (deferred)
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=blduan@linux.alibaba.com; helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:32 -0400
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

A CoVE guest has neither wired interrupts nor a virtio-mmio transport,
and the TSM does not expose Zicboz to it, so drop the corresponding
device tree properties and nodes.

The kernel command line has to be added here as well: a CoVE guest does
not use the generic riscv_load_kernel() path that normally does it, and
the command line has to be in the device tree before it is measured.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 hw/riscv/fdt-common.c |  4 ++-
 hw/riscv/virt.c       | 62 +++++++++++++++++++++++++++++++------------
 2 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index aa143a618b..c065724be4 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -11,6 +11,7 @@
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
 #include "hw/core/boards.h"
+#include "hw/riscv/cove.h"
 #include "hw/riscv/fdt-common.h"
 #include "target/riscv/cpu_bits.h"
 
@@ -132,7 +133,8 @@ create_fdt_socket_cpu_internal(void *fdt, char *clust_name, RISCVCPU *cpu_ptr,
                                   cpu_ptr->cfg.cbom_blocksize);
         }
 
-        if (cpu_ptr->cfg.ext_zicboz) {
+        /* The TSM does not expose Zicboz to a CoVE guest. */
+        if (cpu_ptr->cfg.ext_zicboz && !riscv_cove_vm_active()) {
             qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cboz-block-size",
                                   cpu_ptr->cfg.cboz_blocksize);
         }
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c15d8859ce..777859baa2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -225,12 +225,15 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
         }
     }
 
-    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
-                     PCI_NUM_PINS * PCI_NUM_PINS *
-                     irq_map_stride * sizeof(uint32_t));
-
-    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
-                           0x1800, 0, 0, 0x7);
+    /* A CoVE guest only supports MSIs, so it has no interrupt map. */
+    if (!s->cove_vm) {
+        qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
+                         PCI_NUM_PINS * PCI_NUM_PINS *
+                         irq_map_stride * sizeof(uint32_t));
+
+        qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
+                               0x1800, 0, 0, 0x7);
+    }
 }
 
 static void create_fdt_socket_aclint(RISCVVirtState *s,
@@ -697,6 +700,14 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
     MachineState *ms = MACHINE(s);
     hwaddr virtio_base = s->memmap[VIRT_VIRTIO].base;
 
+    /*
+     * A CoVE guest has no virtio-mmio transport, its virtio devices are
+     * attached to the PCIe host bridge instead.
+     */
+    if (s->cove_vm) {
+        return;
+    }
+
     for (i = 0; i < VIRTIO_COUNT; i++) {
         g_autofree char *name = NULL;
         uint64_t size = s->memmap[VIRT_VIRTIO].size;
@@ -819,11 +830,15 @@ static void create_fdt_uart(RISCVVirtState *s,
                                  2, s->memmap[VIRT_UART0].base,
                                  2, s->memmap[VIRT_UART0].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
-    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
-    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", UART0_IRQ);
-    } else {
-        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", UART0_IRQ, 0x4);
+    /* A CoVE guest has no wired interrupts, the UART is polled. */
+    if (!s->cove_vm) {
+        qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
+                              irq_mmio_phandle);
+        if (s->aia_type == VIRT_AIA_TYPE_NONE) {
+            qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", UART0_IRQ);
+        } else {
+            qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", UART0_IRQ, 0x4);
+        }
     }
 
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
@@ -844,12 +859,15 @@ static void create_fdt_rtc(RISCVVirtState *s,
     qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
                                  2, s->memmap[VIRT_RTC].base,
                                  2, s->memmap[VIRT_RTC].size);
-    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
-        irq_mmio_phandle);
-    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", RTC_IRQ);
-    } else {
-        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", RTC_IRQ, 0x4);
+    /* A CoVE guest has no wired interrupts, the RTC is polled. */
+    if (!s->cove_vm) {
+        qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
+            irq_mmio_phandle);
+        if (s->aia_type == VIRT_AIA_TYPE_NONE) {
+            qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", RTC_IRQ);
+        } else {
+            qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", RTC_IRQ, 0x4);
+        }
     }
 }
 
@@ -1021,6 +1039,16 @@ static void create_fdt(RISCVVirtState *s)
 
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
 
+    /*
+     * The kernel command line of a CoVE guest has to be part of the device
+     * tree before it is measured, so it cannot be added by the generic
+     * riscv_load_kernel() path.
+     */
+    if (s->cove_vm && ms->kernel_cmdline && *ms->kernel_cmdline) {
+        qemu_fdt_setprop_string(ms->fdt, "/chosen", "bootargs",
+                                ms->kernel_cmdline);
+    }
+
     /* Pass seed to RNG */
     qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
     qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
-- 
2.34.1


