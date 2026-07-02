Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF33CC43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfH3P-0005LB-Bv; Thu, 02 Jul 2026 09:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wfH3E-0005IW-Ql
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:02:05 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wfH3B-0002zm-F8
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:01:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=MChIAcK
 EQvzoBsl8vXVnQ0sSdtF1j2sCWN3YzYyPPLxOdsgVY4bIJlkLZMtE4korMeTaU4C8GaWk5
 jk7TqgKzJA2P/0feB6qUD4a6j4Z4/9zyMlvI87xRjy9NWFDNGaHhoZHUzbiK5xTyopsFam
 k9ZkrrJ5RkiYyQDp7YeH6J1O8/vAKmUD8z2R1cY5VaEiEPb9i5kTD5otNdEgIwkOY5m+qv
 wCwsznkNmy8GosL7B+c0UmBfxE4mTN/KWi8OxKNqm4QMwGA2qnmh2/RDamDddfPyWm2q48
 NAMPXpqRFKFhGpPN7XyUEeWyXzczfJ5T6+EGRoQGpmtcDCzlPr/dCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=j
 ojVjXqSi9y8Z+JInfRj97f82T+mwWHFqcrYQjs5j2w=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=hdU9+vMHROkFMQX8
 DpAEcdeFB6dVs1mXEaKjWSK9m7tCwslYPFxEqLF8DHXqRga9Bd+yWb+VFLlb9ZFbeZ6MLG
 Rav6JFSxRSUvH7l2Y4KYo/nOYzaxqnyvXkZTpEvk9eBWr8GTmX3IRyI7HLqVV1fQHObV86
 t4w1SElKL+gsJnT83WkuK0qFOspKIORD9hUAWHDuL1hUV2Crquj9+0eXe2LbU6Q3w6XZ4T
 2tac/r7YhIQwtPDCXSQ5LHi82xQqwsX+QtHGvEWvZzfJeKhUH2/pooNrTk52kN79aX2uB6
 n0StPNQFWPUIpW3MiCZlHJQ4wD5Gzif8f7eBmUtSJ77pAg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=ak9CNxXX; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=jD/pBSZ5;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=jojVjXqS
 i9y8Z+JInfRj97f82T+mwWHFqcrYQjs5j2w=; h=date:subject:cc:to:from;
 d=korins.ky; b=ak9CNxXXAXos4v93Rk+DCNsteZTjRBhK4ItS1GbHgtZM5EfMh5jtfx0
 9De9V1AowmyD8DqN3SJLvYUT1X/yPcnSeg58p1QcukiRg7k6u/5x8B9wE2iIxOF3IaCwV4
 IFuqN6IRruuFo899/HG4/yRtAFviZDlE9fkcqHsVhXPp2vRNe6LpTGRsx28NldF1vgl+bl
 /TdbjBn5Yqy6mByDPZeVwmRTmDZLxeJDW5e1RzzIjOzCM9JsaHqZ8BmxPT8824ZdwP2/0N
 oJthy5NPaUQMZk9KyvZqjy1E1d686vVGoorQ98TldeR+mR6cBHI8sqM/ou4GHKz0bBq0t3
 3M/RWPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=jojVjXqSi9y8Z+JInfRj97f82T+mwWHFqcrYQjs5j2w=; h=date:subject:cc:to:
 from; d=korins.ky; b=jD/pBSZ5NFzuaT0U4kC//x+djRaBlg7jTEORiCEaC6yrq+Z8q
 O0MWGyfUbakGZJirx5quVitdj3Yh1KJJaEvDQ==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 57118cf1
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 2 Jul 2026 15:01:49 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id ba30b2c7;
 Thu, 2 Jul 2026 15:01:49 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH] powernv: boot OpenBSD on POWER9
Date: Thu,  2 Jul 2026 15:01:45 +0200
Message-ID: <20260702130145.23111-1-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

OpenBSD/powernv programs PTCR for LPID 0 with a partition
table size exponent one smaller than QEMU's existing ISA v3.0
interpretation. Try QEMU's existing PATS interpretation first,
then fall back to the OpenBSD LPID 0 form; nonzero LPIDs keep
the old behaviour.

The PSI model now exposes POWER9 IRQ level and pending status
registers, and keeps both updated while delivering through the
existing XIVE LSI source. This lets guests that select the
POWER9 PSI LSI IRQ method continue to receive LPC interrupts.

The blast radius is probably minimal: the partition table
fallback is limited to bare metal LPID 0 after the original
lookup fails, while the PSI change only touches POWER9 PSI
state and reuses the existing delivery path.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/ppc/pnv_psi.c                       | 11 ++++--
 target/ppc/mmu-book3s-v3.c             | 38 ++++++++++++++++---
 tests/functional/ppc64/meson.build     |  2 +
 tests/functional/ppc64/test_openbsd.py | 52 ++++++++++++++++++++++++++
 4 files changed, 94 insertions(+), 9 deletions(-)
 create mode 100755 tests/functional/ppc64/test_openbsd.py

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index e8701c6100..39ec448f3c 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -688,6 +688,8 @@ static uint64_t pnv_psi_p9_mmio_read(void *opaque, hwaddr addr, unsigned size)
     case PSIHB9_ESB_CI_BASE:
     case PSIHB9_ESB_NOTIF_ADDR:
     case PSIHB9_IVT_OFFSET:
+    case PSIHB9_IRQ_LEVEL:
+    case PSIHB9_IRQ_STAT:
         val = psi->regs[reg];
         break;
     default:
@@ -818,17 +820,20 @@ static void pnv_psi_power9_set_irq(void *opaque, int irq, int state)
 {
     PnvPsi *psi = opaque;
     uint64_t irq_method = psi->regs[PSIHB_REG(PSIHB9_INTERRUPT_CONTROL)];
+    uint64_t irq_bit = PPC_BIT(irq);
 
     if (irq_method & PSIHB9_IRQ_METHOD) {
         qemu_log_mask(LOG_GUEST_ERROR, "PSI: LSI IRQ method no supported\n");
         return;
     }
 
-    /* Update LSI levels */
+    /* Update LSI levels and pending status */
     if (state) {
-        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] |= PPC_BIT(irq);
+        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] |= irq_bit;
+        psi->regs[PSIHB_REG(PSIHB9_IRQ_STAT)] |= irq_bit;
     } else {
-        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] &= ~PPC_BIT(irq);
+        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] &= ~irq_bit;
+        psi->regs[PSIHB_REG(PSIHB9_IRQ_STAT)] &= ~irq_bit;
     }
 
     qemu_set_irq(psi->qirqs[irq], state);
diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index 3865556310..36b0733b6a 100644
--- a/target/ppc/mmu-book3s-v3.c
+++ b/target/ppc/mmu-book3s-v3.c
@@ -23,25 +23,51 @@
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
 
-bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
+#define PPC64_V3_PATE_SIZE 16 /* two 64-bit words */
+
+static bool ppc64_v3_get_pate_from_size(PowerPCCPU *cpu, target_ulong lpid,
+                                        ppc_v3_pate_t *entry,
+                                        uint64_t table_size)
 {
     uint64_t patb = cpu->env.spr[SPR_PTCR] & PTCR_PATB;
-    uint64_t pats = cpu->env.spr[SPR_PTCR] & PTCR_PATS;
+    uint64_t entries;
 
     /* Check if partition table is properly aligned */
-    if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
+    if (patb & (table_size - 1)) {
         return false;
     }
 
     /* Calculate number of entries */
-    pats = 1ull << (pats + 12 - 4);
-    if (pats <= lpid) {
+    entries = table_size / PPC64_V3_PATE_SIZE;
+    if (entries <= lpid) {
         return false;
     }
 
     /* Grab entry */
-    patb += 16 * lpid;
+    patb += PPC64_V3_PATE_SIZE * lpid;
     entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
     entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
     return true;
 }
+
+bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    uint64_t pats = cpu->env.spr[SPR_PTCR] & PTCR_PATS;
+
+    /*
+     * Keep the existing ISA v3.0 PATS interpretation first.  OpenBSD/powernv
+     * computes the value written to PTCR as ffs(PATMEMSZ) - 12, which writes 5
+     * for its 64KiB LPID 0 partition table. If the existing interpretation
+     * fails, accept that form only for the bare metal LPID 0 table.
+     */
+    if (ppc64_v3_get_pate_from_size(cpu, lpid, entry, 1ull << (pats + 12))) {
+        return true;
+    }
+
+    if (lpid == 0) {
+        return ppc64_v3_get_pate_from_size(cpu, lpid, entry,
+                                           1ull << (pats + 11));
+    }
+
+    return false;
+}
diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
index f0f8ab8f61..cb3c745624 100644
--- a/tests/functional/ppc64/meson.build
+++ b/tests/functional/ppc64/meson.build
@@ -4,6 +4,7 @@ test_ppc64_timeouts = {
   'fadump' : 480,
   'hv' : 1000,
   'mac99' : 120,
+  'openbsd' : 240,
   'powernv' : 480,
   'pseries' : 480,
   'replay' : 210,
@@ -20,6 +21,7 @@ tests_ppc64_system_thorough = [
   'fadump',
   'hv',
   'mac99',
+  'openbsd',
   'powernv',
   'pseries',
   'replay',
diff --git a/tests/functional/ppc64/test_openbsd.py b/tests/functional/ppc64/test_openbsd.py
new file mode 100755
index 0000000000..bdbef6bf82
--- /dev/null
+++ b/tests/functional/ppc64/test_openbsd.py
@@ -0,0 +1,52 @@
+#!/usr/bin/env python3
+#
+# Test that OpenBSD boots on a ppc powernv machine and reaches the installer.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class OpenBSDPowerNV(QemuSystemTest):
+
+    ASSET_MINIROOT = Asset(
+        'https://kirill.korins.ky/pub/qemu-powerpc64-openbsd/miniroot79.img',
+        '7829e42b75d81cafd732038b9d63228b79c1f5828d8375872a4bb655e1d6b13c')
+
+    ASSET_BOOTKERNEL = Asset(
+        'https://kirill.korins.ky/pub/qemu-powerpc64-openbsd/pnor.BOOTKERNEL',
+        '397ce43ce61910e1a2c4f13d301f957e61513a9ec5371bc3e87d3095411fae7b')
+
+    def test_powernv9_openbsd_installer(self):
+        self.set_machine('powernv9')
+        self.require_accelerator('tcg')
+
+        miniroot_path = self.ASSET_MINIROOT.fetch()
+        bootkernel_path = self.ASSET_BOOTKERNEL.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-cpu', 'power9',
+                         '-accel', 'tcg,thread=single',
+                         '-smp', '1,cores=1,threads=1',
+                         '-m', '2g',
+                         '-kernel', bootkernel_path,
+                         '-device',
+                         'ich9-ahci,id=sata0,bus=pcie.0,addr=0x0',
+                         '-drive',
+                         f'file={miniroot_path},format=raw,if=none,'
+                         'id=bootdisk,snapshot=on',
+                         '-device',
+                         'ide-hd,bus=sata0.0,unit=0,drive=bootdisk,'
+                         'bootindex=1')
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'OpenBSD 7.9 (RAMDISK)', 'panic:')
+        wait_for_console_pattern(
+            self,
+            '(I)nstall, (U)pgrade, (A)utoinstall or (S)hell?',
+            'panic:')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.54.0


