Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C8606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=aN5n3fBn;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=ZaDWhvWn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLeiJ-0007u5-1x; Tue, 27 Oct 2026 06:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeg2-0005N4-G4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:11 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLefz-0007wK-Vo
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=fpNdO20
 d82fPGIWBwbk4xc8UIjoFVmgoaKoIjxO9O3x3A/Sju7RCoZq+5NrpEzXN4OotwLLh1rhf9
 OqudqHvUjBG+ryMDzh57liEVCuzSAjD9zdggJpc/po+2wGtZNQkhzyage8CKvWdB58/g0w
 qRJUhOp0Btb2oRIzts6zU3lr4zAm8SM7S+kcSve0aQqW623OPyXuhcP5Hkh7/zkvYl3sCN
 GuPNQbWSy+In8rb49/5YhhSCOIMexMmGHkRmWK2BDoALR4xkNYgHBgAIuR8Jy4ABeIXUBd
 vYWYB3LFjoVhtLIvuyx5fWf0NuKN+wDGXxnUopgoExh0Pu+FVW0D8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=y
 jDrqRnG8Lmek8zEPfag9dmnoPZIZoamPPxiyil0VbI=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=G5ezDRr4Iurmf7RJCDXVikfJkfHFU/sGctruYeyJYOPWQS3+Y2IpxrBRDx8wb5fvfJ09
 JDJmR1qdan9jLaE8Xv8XjNjpRv1vAyVQacxH43fSBUX2162SKL5aDTMoFUkpZvVxeYkrqO
 L9kGfCs8AarA1cnJsGOhHB1vnSrBOrUDipaSZhexptu4dfK3LJjFT4Fs19UEI0mKc2/6HC
 IAbhmsvd3TGFHZKO1kHtubut7nU0iQWObPTUPhLmQriRV701FhYU75gljgK5iiAaQRhqre
 pADySHPL9g+pXtcYMQ7wl2c1wHKNS0i2b/3r28EzwjsqH3mvKen0nKSQ6q7yRrpA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=aN5n3fBn; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=ZaDWhvWn;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=yjDrqRnG
 8Lmek8zEPfag9dmnoPZIZoamPPxiyil0VbI=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=aN5n3fBnf+8D3DwLRISNdgWWWpnqg3+nuyt
 SxjIwcSMrack2HA9sdwj972TB78Vzcke9DBhUipz8z2d8QHezo/cpPnANrVX6oN5l+E+gv
 Rdu88hW4P/XjHa6bFfGrXHb+pR8CNj/lMdjf7/IpmTuElVFzYIxBsVkaH5vwnv/n3XgZNq
 TLHDaJtuVou271cP3jwZsfRlxYAff1+mDB1p1VQpdtZgcxREtPYjxEq+z5h9XO9z2aeB9z
 KiNZimZY0WrBFpsj7pkRkTDc1/8L9xIyWAWEa93S2oLPhB+vwmYgf/r9hIMAQM65/obyRP
 V6vRKO0vf4a7VJVsBha784BafBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=yjDrqRnG8Lmek8zEPfag9dmnoPZIZoamPPxiyil0VbI=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=ZaDWhvWn4dfsEdtDNA
 lcw/ZHsliu3+jRXY/hGPdr6TX7ZoYLZCjkkRlijhzXxWHylRHlbS+wt9Psf01a0dp5Dg==
Received: by mx1.catap.net (OpenSMTPD) id 53543ead;
 Tue, 27 Oct 2026 11:45:03 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id b0cd5456;
 Tue, 27 Oct 2026 11:44:52 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v4 20/25] hw/mips: add Octeon LMC controllers
Date: Tue, 27 Oct 2026 11:41:44 +0100
Message-ID: <20261027104433.25720-21-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027104433.25720-1-kirill@korins.ky>
References: <20261027104433.25720-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add four Octeon LMC register banks with the DDR training completion,
leveling, MPR and clock responses used by firmware. Each LMC owns and
resets its mutable register state.
---
 hw/mips/octeon.c          | 184 ++++++++++++++++++++++++++++++++++++++
 hw/mips/octeon_internal.h |   3 +
 2 files changed, 187 insertions(+)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index f3f8a74cbe..0553f8ea05 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -10,6 +10,7 @@
 #include "qemu/units.h"
 #include "qemu/datadir.h"
 #include "qemu/host-utils.h"
+#include "qemu/timer.h"
 #include "qapi/error.h"
 #include "hw/char/serial-mm.h"
 #include "hw/core/clock.h"
@@ -49,6 +50,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonEmmState, OCTEON_EMM)
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonRstState, OCTEON_RST)
 #define TYPE_OCTEON_INTC "octeon-intc"
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonIntcState, OCTEON_INTC)
+#define TYPE_OCTEON_LMC "octeon-lmc"
+OBJECT_DECLARE_SIMPLE_TYPE(OcteonLmcState, OCTEON_LMC)
 #define TYPE_OCTEON_CSR_BANK "octeon-csr-bank"
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 
@@ -243,6 +246,24 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_RST_SOFT_RST         0x6001680
 /* U-Boot uses the reset controller to park and release secondary cores. */
 #define OCTEON_RST_PP_POWER         0x6001700
+#define OCTEON_LMC_BASE             0x88000000
+#define OCTEON_LMC_SEQ_CTL          0x48
+#define OCTEON_LMC_SEQ_COMPLETE     (1ULL << 5)
+#define OCTEON_LMC_MPR_DATA0        0x70
+#define OCTEON_LMC_MPR_DATA1        0x78
+#define OCTEON_LMC_DCLK_CNT         0x1e0
+#define OCTEON_LMC_PHY_CTL          0x210
+#define OCTEON_LMC_PHY_DSK_COMPLETE (1ULL << 49)
+#define OCTEON_LMC_RLEVEL_RANK      0x280
+#define OCTEON_LMC_RLEVEL_STATUS    (3ULL << 54)
+#define OCTEON_LMC_RLEVEL_DBG       0x2a8
+#define OCTEON_LMC_RLEVEL_MASK      0x3f0
+#define OCTEON_LMC_WLEVEL_RANK      0x2c0
+#define OCTEON_LMC_RANK_COUNT       4
+#define OCTEON_LMC_WLEVEL_STATUS    (3ULL << 45)
+#define OCTEON_LMC_WLEVEL_DBG       0x308
+#define OCTEON_LMC_WLEVEL_MASK      (0x0fULL << 4)
+#define OCTEON_LMC_STRIDE           0x1000000
 #define OCTEON_RST_BOOT_C_MUL_SHIFT 30
 #define OCTEON_RST_BOOT_PNR_MUL_SHIFT 24
 
@@ -351,6 +372,11 @@ struct OcteonIntcState {
     uint8_t ciu3_irq_line[OCTEON_MAX_CPUS][OCTEON_CIU3_CP0_IRQ_COUNT];
 };
 
+struct OcteonLmcState {
+    OcteonPeripheralState parent_obj;
+    GHashTable *regs;
+};
+
 struct OcteonCsrBankState {
     OcteonPeripheralState parent_obj;
     MemoryRegion csr;
@@ -416,6 +442,13 @@ static uint64_t octeon_atomic_write64(uint64_t *ptr, hwaddr addr,
     return new;
 }
 
+static uint64_t octeon_clock_count(uint64_t hz)
+{
+    uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    return muldiv64(now, hz, NANOSECONDS_PER_SECOND);
+}
+
 static void octeon_validate_clocks(OcteonMachineState *oms)
 {
     if (!oms->cpu_hz || !oms->ref_hz || !oms->io_hz || !oms->ddr_hz) {
@@ -884,6 +917,94 @@ static void octeon_mio_emm_write(OcteonState *s, hwaddr reg,
     }
 }
 
+static bool octeon_lmc_decode(hwaddr reg, OcteonLmcState **lmc, hwaddr *lreg,
+                              OcteonState *s)
+{
+    hwaddr offset;
+    unsigned int index;
+
+    if (reg < OCTEON_LMC_BASE) {
+        return false;
+    }
+
+    offset = reg - OCTEON_LMC_BASE;
+    index = offset / OCTEON_LMC_STRIDE;
+    if (index >= OCTEON_LMC_COUNT) {
+        return false;
+    }
+
+    *lmc = s->lmc[index];
+    *lreg = offset % OCTEON_LMC_STRIDE;
+    return true;
+}
+
+static uint64_t octeon_lmc_get(OcteonLmcState *lmc, hwaddr reg)
+{
+    uint64_t value;
+
+    if (!octeon_reg_lookup(lmc->regs, reg, &value)) {
+        return 0;
+    }
+    return value;
+}
+
+static bool octeon_lmc_rank_reg(hwaddr reg, hwaddr base)
+{
+    return reg >= base &&
+           reg < base + OCTEON_LMC_RANK_COUNT * 8 &&
+           ((reg - base) & 7) == 0;
+}
+
+static uint64_t octeon_lmc_read(OcteonState *s, OcteonLmcState *lmc,
+                                hwaddr reg, hwaddr addr, unsigned size)
+{
+    uint64_t value;
+
+    switch (reg) {
+    case OCTEON_LMC_SEQ_CTL:
+        value = octeon_lmc_get(lmc, reg) | OCTEON_LMC_SEQ_COMPLETE;
+        break;
+    case OCTEON_LMC_MPR_DATA0:
+        value = ~0ULL;
+        break;
+    case OCTEON_LMC_MPR_DATA1:
+        value = 0xff;
+        break;
+    case OCTEON_LMC_DCLK_CNT:
+        value = octeon_clock_count(s->ddr_hz);
+        break;
+    case OCTEON_LMC_PHY_CTL:
+        value = octeon_lmc_get(lmc, reg) | OCTEON_LMC_PHY_DSK_COMPLETE;
+        break;
+    case OCTEON_LMC_RLEVEL_DBG:
+        value = OCTEON_LMC_RLEVEL_MASK;
+        break;
+    case OCTEON_LMC_WLEVEL_DBG:
+        value = OCTEON_LMC_WLEVEL_MASK;
+        break;
+    default:
+        if (octeon_lmc_rank_reg(reg, OCTEON_LMC_RLEVEL_RANK)) {
+            value = octeon_lmc_get(lmc, reg) | OCTEON_LMC_RLEVEL_STATUS;
+        } else if (octeon_lmc_rank_reg(reg, OCTEON_LMC_WLEVEL_RANK)) {
+            value = octeon_lmc_get(lmc, reg) | OCTEON_LMC_WLEVEL_STATUS;
+        } else {
+            value = octeon_lmc_get(lmc, reg);
+        }
+        break;
+    }
+
+    return octeon_read64(value, addr, size);
+}
+
+static void octeon_lmc_write(OcteonLmcState *lmc, hwaddr reg,
+                             hwaddr addr, uint64_t value, unsigned size)
+{
+    uint64_t old = octeon_lmc_get(lmc, reg);
+
+    value = octeon_write64(old, addr, value, size);
+    octeon_reg_store(lmc->regs, reg, value);
+}
+
 static bool octeon_ciu3_source_from_intsn(uint32_t intsn,
                                           unsigned int *source)
 {
@@ -1688,7 +1809,9 @@ static const MemoryRegionOps octeon_ciu3_ops = {
 static uint64_t octeon_csr_read(void *opaque, hwaddr addr, unsigned size)
 {
     OcteonState *s = opaque;
+    OcteonLmcState *lmc;
     hwaddr reg = addr & ~7ULL;
+    hwaddr lreg;
     hwaddr ereg;
     uint64_t value;
 
@@ -1726,6 +1849,10 @@ static uint64_t octeon_csr_read(void *opaque, hwaddr addr, unsigned size)
         break;
     }
 
+    if (octeon_lmc_decode(reg, &lmc, &lreg, s)) {
+        return octeon_lmc_read(s, lmc, lreg, addr, size);
+    }
+
     if (octeon_mio_emm_decode(reg, &ereg)) {
         return octeon_mio_emm_read(s, ereg, addr, size);
     }
@@ -1740,10 +1867,17 @@ static void octeon_csr_write(void *opaque, hwaddr addr,
                              uint64_t value, unsigned size)
 {
     OcteonState *s = opaque;
+    OcteonLmcState *lmc;
     hwaddr reg = addr & ~7ULL;
+    hwaddr lreg;
     hwaddr ereg;
     uint64_t old;
 
+    if (octeon_lmc_decode(reg, &lmc, &lreg, s)) {
+        octeon_lmc_write(lmc, lreg, addr, value, size);
+        return;
+    }
+
     if (octeon_mio_emm_decode(reg, &ereg)) {
         octeon_mio_emm_write(s, ereg, addr, value, size);
         return;
@@ -2209,6 +2343,18 @@ static void octeon_intc_reset_hold(Object *obj, ResetType type)
     octeon_intc_update_all_cpus(s);
 }
 
+static void octeon_lmc_reset_hold(Object *obj, ResetType type)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_GET_CLASS(obj);
+    OcteonLmcState *lmc = OCTEON_LMC(obj);
+
+    if (opc->parent_phases.hold) {
+        opc->parent_phases.hold(obj, type);
+    }
+
+    g_hash_table_remove_all(lmc->regs);
+}
+
 static void octeon_csr_bank_reset_hold(Object *obj, ResetType type)
 {
     OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_GET_CLASS(obj);
@@ -2256,6 +2402,16 @@ static void octeon_rst_finalize(Object *obj)
     g_hash_table_destroy(OCTEON_RST(obj)->regs);
 }
 
+static void octeon_lmc_init(Object *obj)
+{
+    OCTEON_LMC(obj)->regs = octeon_reg_table_new();
+}
+
+static void octeon_lmc_finalize(Object *obj)
+{
+    g_hash_table_destroy(OCTEON_LMC(obj)->regs);
+}
+
 static void octeon_csr_bank_init(Object *obj)
 {
     OCTEON_CSR_BANK(obj)->values = octeon_reg_table_new();
@@ -2302,6 +2458,15 @@ static void octeon_intc_class_init(ObjectClass *klass, const void *data)
                                        NULL, &opc->parent_phases);
 }
 
+static void octeon_lmc_class_init(ObjectClass *klass, const void *data)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    resettable_class_set_parent_phases(rc, NULL, octeon_lmc_reset_hold,
+                                       NULL, &opc->parent_phases);
+}
+
 static void octeon_csr_bank_class_init(ObjectClass *klass, const void *data)
 {
     OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_CLASS(klass);
@@ -2326,10 +2491,16 @@ static OcteonPeripheralState *octeon_new_peripheral(OcteonState *s,
 
 static void octeon_create_peripherals(OcteonState *s)
 {
+    unsigned int i;
+
     s->mio = OCTEON_MIO(octeon_new_peripheral(s, TYPE_OCTEON_MIO, 0));
     s->emm = OCTEON_EMM(octeon_new_peripheral(s, TYPE_OCTEON_EMM, 0));
     s->rst = OCTEON_RST(octeon_new_peripheral(s, TYPE_OCTEON_RST, 0));
     s->intc = OCTEON_INTC(octeon_new_peripheral(s, TYPE_OCTEON_INTC, 0));
+    for (i = 0; i < OCTEON_LMC_COUNT; i++) {
+        s->lmc[i] = OCTEON_LMC(octeon_new_peripheral(s, TYPE_OCTEON_LMC,
+                                                      i));
+    }
     s->csr_bank = OCTEON_CSR_BANK(octeon_new_peripheral(
                                       s, TYPE_OCTEON_CSR_BANK, 0));
 }
@@ -2341,7 +2512,12 @@ static void octeon_realize_peripheral(OcteonPeripheralState *dev)
 
 static void octeon_realize_peripherals(OcteonState *s)
 {
+    int i;
+
     octeon_realize_peripheral(&s->csr_bank->parent_obj);
+    for (i = OCTEON_LMC_COUNT - 1; i >= 0; i--) {
+        octeon_realize_peripheral(&s->lmc[i]->parent_obj);
+    }
     octeon_realize_peripheral(&s->intc->parent_obj);
     octeon_realize_peripheral(&s->rst->parent_obj);
     octeon_realize_peripheral(&s->emm->parent_obj);
@@ -2491,6 +2667,14 @@ static const TypeInfo octeon_machine_types[] = {
         .instance_size = sizeof(OcteonIntcState),
         .class_init = octeon_intc_class_init,
     },
+    {
+        .name = TYPE_OCTEON_LMC,
+        .parent = TYPE_OCTEON_PERIPHERAL,
+        .instance_size = sizeof(OcteonLmcState),
+        .instance_init = octeon_lmc_init,
+        .instance_finalize = octeon_lmc_finalize,
+        .class_init = octeon_lmc_class_init,
+    },
     {
         .name = TYPE_OCTEON_CSR_BANK,
         .parent = TYPE_OCTEON_PERIPHERAL,
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index a262107b54..96443a9d64 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -21,6 +21,7 @@
 #define OCTEON_MIO_BOOT_REG_CFG_COUNT 8
 #define OCTEON_MIO_BOOT_LOC_SIZE    0x100
 #define OCTEON_MIO_EMM_BUF_SIZE     512
+#define OCTEON_LMC_COUNT            4
 #define OCTEON_TWSI_COUNT           2
 #define OCTEON_TWSI_STAT_IDLE       0xf8
 #define OCTEON_SPD_EEPROM_SIZE      139
@@ -42,6 +43,7 @@ typedef struct OcteonMioState OcteonMioState;
 typedef struct OcteonEmmState OcteonEmmState;
 typedef struct OcteonRstState OcteonRstState;
 typedef struct OcteonIntcState OcteonIntcState;
+typedef struct OcteonLmcState OcteonLmcState;
 typedef struct OcteonCsrBankState OcteonCsrBankState;
 
 typedef struct OcteonCPUState {
@@ -73,6 +75,7 @@ struct OcteonState {
     OcteonEmmState *emm;
     OcteonRstState *rst;
     OcteonIntcState *intc;
+    OcteonLmcState *lmc[OCTEON_LMC_COUNT];
     OcteonCsrBankState *csr_bank;
     OcteonSpdEepromState *spd[OCTEON_SPD_EEPROM_COUNT];
     SerialMM *uart;
-- 
2.56.0


