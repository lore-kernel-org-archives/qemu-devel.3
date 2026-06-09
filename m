Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05958CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzPF-00016Q-I0; Tue, 09 Jun 2026 12:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wWzPD-00015K-4V
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:34:23 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wWzP8-00039V-3n
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:34:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=AS+Z+sh
 dj4lFcPH/eC5pCm70ZVUm9tL4nvDumEv7RVRVCFcu8NRGFh9LVT8BWStI780Gvg3rgLfuQ
 apfMtoU0GhaciTrAgeCTZGDXZ8tNFKwFXNr/qWz6bpVJD8gdXgMD7FIm8DhM5ra5bhi2fC
 wx3Uy0iuJnlrhWqlyVWJxA5yWx3ohydxqdcSZbgznadK+rmFt7FjmyRtRPy7ZexS2BJTca
 3SLxlrXdpMqCIqoNniHgAm7NUzQmFGpahrtT2ruChJnqAajDxvMRRJeW3FxtjNl5Z7NGCS
 +bC08ouSfe7tSgQxEQ2ZrwSKR5q6PGMyjae2RyzwTwRR5wTZ8Uy8WVA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=6
 MX545HvzjG16fzHdmRvFu96rcRXl0JevJmNZ1l+QYI=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=moWQHpxxFLNizGL0JQZm1ygymusV57gliVlOuqc7dApW4b+XrWl064FfA8PiFNg09c8n
 m+bJDpefuQgKYDOA6jZxYyAK18EOan8dwOdqF7ysYc2PfLPAS5mKETVNM5NeEeqoHaQ8Xf
 JaPkUuV6oLZHjbkusaaPE7zLnQo9yyDQQ1t1ZMXMZvAhLrRekNpdvRsIHKoNmvcZIJiZpO
 Lsg4d4jdKACs3lIMpes6rDIALpW/lHBGrKS/hiLB61neFXASPThrxW7ZoFVknHVfplD3SF
 IfqkW2LZhiIa3DHOUBYS1Z5geCVOXzXIZT0k40ZcidIYbTxtKu6jYN2ApWGpVUfw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=UnJsUkU+; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=wEd+N7ey;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=6MX545Hv
 zjG16fzHdmRvFu96rcRXl0JevJmNZ1l+QYI=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=UnJsUkU+2JkQF7E/cRUdlcTchw1KuV
 5cNRTisPo+GZ2e/aKrd9+cihH4cTidcBhm2+Oxf2u5g9QcxGVfbk8u06Fyjqw3q2ibNMW/
 UufrG07fb6xQ02wFFpHMXpCZBP9crTY9UgCK7DXT+rHiJ9WFKZ+sBG3cz3jjlhYbD/QRn5
 YOIqb2s3t8ed0dRow4tE6hWQyp2eBuBqBSprTnjE9Tc65hEnh8noF0q1MUJEBfuc3kHvt4
 OqVtl1V4Eod2Rl80p2ia/IdXuuu+vh7Dt0p9r/xq4GsmJPSeTS8DDTIfDk33kHAofYTvQm
 8N4fWq3RSja5SPcOYxrzepakYBvZbE3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=6MX545HvzjG16fzHdmRvFu96rcRXl0JevJmNZ1l+QYI=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=wEd+N7eyPqcCfiMi2Y
 03NYNpiAVDb9HotcXCC22KMsh6+G9nB1hqQU9Ga1fbGh0xxQScasvSSsWgPFynpqvgCA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 90d44106
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 9 Jun 2026 18:34:08 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) with ESMTP id a7220cb7;
 Tue, 9 Jun 2026 18:34:07 +0200 (CEST)
Date: Tue, 09 Jun 2026 18:34:07 +0200
Message-ID: <87y0gnsmf4.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] powernv: boot OpenBSD on POWER9
In-Reply-To: <d041c89f-8484-4405-b208-f2e8830a92a1@oss.qualcomm.com>
References: <20260609021945.73632-1-kirill@korins.ky>
 <8733ywtpgv.wl-kirill@korins.ky>
 <d041c89f-8484-4405-b208-f2e8830a92a1@oss.qualcomm.com>
User-Agent: Wanderlust
Mail-Followup-To: philmd@oss.qualcomm.com, qemu-devel@nongnu.org,
 Kirill A. Korinsky <kirill@korins.ky>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart_Tue_Jun__9_18:34:07_2026-1"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

--Multipart_Tue_Jun__9_18:34:07_2026-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 09 Jun 2026 13:26:09 +0200,
Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> 
> Hi Kirill,
> 
> On 9/6/26 04:30, Kirill A. Korinsky wrote:
> > On Tue, 09 Jun 2026 04:19:45 +0200,
> > "Kirill A. Korinsky" <kirill@korins.ky> wrote:
> >> 
> >> OpenBSD/powernv programs PTCR for LPID 0 with a partition
> >> table size exponent one smaller than QEMU's existing ISA v3.0
> >> interpretation. Try QEMU's existing PATS interpretation first,
> >> then fall back to the OpenBSD LPID 0 form; nonzero LPIDs keep
> >> the old behaviour.
> >> 
> >> The PSI model now exposes POWER9 IRQ level and pending status
> >> registers, and keeps both updated while delivering through the
> >> existing XIVE LSI source. This lets guests that select the
> >> POWER9 PSI LSI IRQ method continue to receive LPC interrupts.
> >> 
> >> The blast radius is probably minimal: the partition table
> >> fallback is limited to bare metal LPID 0 after the original
> >> lookup fails, while the PSI change only touches POWER9 PSI
> >> state and reuses the existing delivery path.
> >> 
> >> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> > 
> > 
> > It was tested as:
> > 
> > qemu-system-ppc64 \
> >      -M powernv9 \
> >      -cpu power9 \
> >      -m 2G \
> >      -nographic \
> >      -kernel pnor.BOOTKERNEL \
> >      -device ich9-ahci,id=sata0,bus=pcie.0,addr=0x0 \
> >      -drive file=miniroot79.img,format=raw,if=none,id=bootdisk,snapshot=on \
> >      -device ide-hd,bus=sata0.0,unit=0,drive=bootdisk,bootindex=1
> 
> Cool. Could you add as a functional test in tests/functional/ppc64/? See
> examples around this directory.
> 

Sure, here I added functional test and I confirm that all old one passed.

I host artifacts for test at my host because I have no idea where to host
them, but feel free to move to the right place.

Miniroot from 7.9 release which is available at:
https://cdn.openbsd.org/pub/OpenBSD/7.9/powerpc64/miniroot79.img
but in few years can be gone.

pnor.BOOTKERNEL from talos-ii-v2.10.pnor which was extracted by my script.

-- 
wbr, Kirill

--Multipart_Tue_Jun__9_18:34:07_2026-1
Content-Type: text/plain; type=patch; name="0001-powernv-boot-OpenBSD-on-POWER9.patch"; charset=US-ASCII
Content-Disposition: attachment; filename="0001-powernv-boot-OpenBSD-on-POWER9.patch"
Content-Transfer-Encoding: 7bit

From f3641d1db5e6a2ec78e89f333b5957064db9bdc6 Mon Sep 17 00:00:00 2001
From: "Kirill A. Korinsky" <kirill@korins.ky>
Date: Tue, 9 Jun 2026 18:29:44 +0200
Subject: [PATCH] powernv: boot OpenBSD on POWER9

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
 hw/ppc/pnv_psi.c                       | 17 ++++-----
 target/ppc/mmu-book3s-v3.c             | 33 +++++++++++++---
 tests/functional/ppc64/meson.build     |  2 +
 tests/functional/ppc64/test_openbsd.py | 52 ++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 14 deletions(-)
 create mode 100755 tests/functional/ppc64/test_openbsd.py

diff --git hw/ppc/pnv_psi.c hw/ppc/pnv_psi.c
index e8701c6100..941540df2d 100644
--- hw/ppc/pnv_psi.c
+++ hw/ppc/pnv_psi.c
@@ -688,6 +688,8 @@ static uint64_t pnv_psi_p9_mmio_read(void *opaque, hwaddr addr, unsigned size)
     case PSIHB9_ESB_CI_BASE:
     case PSIHB9_ESB_NOTIF_ADDR:
     case PSIHB9_IVT_OFFSET:
+    case PSIHB9_IRQ_LEVEL:
+    case PSIHB9_IRQ_STAT:
         val = psi->regs[reg];
         break;
     default:
@@ -817,18 +819,15 @@ static const MemoryRegionOps pnv_psi_p9_xscom_ops = {
 static void pnv_psi_power9_set_irq(void *opaque, int irq, int state)
 {
     PnvPsi *psi = opaque;
-    uint64_t irq_method = psi->regs[PSIHB_REG(PSIHB9_INTERRUPT_CONTROL)];
+    uint64_t irq_bit = PPC_BIT(irq);
 
-    if (irq_method & PSIHB9_IRQ_METHOD) {
-        qemu_log_mask(LOG_GUEST_ERROR, "PSI: LSI IRQ method no supported\n");
-        return;
-    }
-
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
diff --git target/ppc/mmu-book3s-v3.c target/ppc/mmu-book3s-v3.c
index 3865556310..4babe4c536 100644
--- target/ppc/mmu-book3s-v3.c
+++ target/ppc/mmu-book3s-v3.c
@@ -23,19 +23,21 @@
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
 
-bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
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
+    entries = table_size / sizeof(*entry);
+    if (entries <= lpid) {
         return false;
     }
 
@@ -45,3 +47,24 @@ bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
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
+     * uses the PATSIZE value it writes to PTCR as one exponent smaller, and it
+     * only needs that interpretation for the bare metal LPID 0 table.
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
diff --git tests/functional/ppc64/meson.build tests/functional/ppc64/meson.build
index f0f8ab8f61..cb3c745624 100644
--- tests/functional/ppc64/meson.build
+++ tests/functional/ppc64/meson.build
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
diff --git tests/functional/ppc64/test_openbsd.py tests/functional/ppc64/test_openbsd.py
new file mode 100755
index 0000000000..bdbef6bf82
--- /dev/null
+++ tests/functional/ppc64/test_openbsd.py
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


--Multipart_Tue_Jun__9_18:34:07_2026-1--

