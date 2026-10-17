Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F03CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB6s-0000jl-5q; Sat, 17 Oct 2026 16:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB56-00059g-J9; Sat, 17 Oct 2026 16:32:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB52-0004bC-Ee; Sat, 17 Oct 2026 16:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268888; bh=wbO0jCxWd4ZwNU4HiubblS0ITDO+2nTSKnTM3UG8NIY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H63ZaTsLr7/Uj40TOBIHcwOIK46yVbfe/vZ+bbE8Ec6zld+GAr2RCa4Aob6BRb84E
 l9aDdA378tU01Yb6OuRWFlbqJXL6EguNa0EvxSePJPsGrcxvRpzIboLyPn69EAkVcK
 XTFylAcjK4e3cQBUDyLO9UD+64z+27CZ0rrJtz8ap4WAd/bVllwdHWV4+BbEmnJmIw
 WChHK1I+zAG1BtU5L0fYm6qfjgmv3ALTcfikOj+SdMGQ5BZ5LVKW+Xef8ra41bam11
 tImgS9vzGLrlDN39B0xw0ML6UZkuy+VLNZuR+laxXFo9hRpeUQkv8260JeuqUzcoOd
 v0VcTWmmJtcbA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5DD8C1DE77A;
 Sat, 17 Oct 2026 23:28:08 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 74A6E44344D;
 Sat, 17 Oct 2026 23:28:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fuad Tabba <fuad.tabba@linux.dev>,
 Gustavo Romero <gromero@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 59/73] tests/tcg/aarch64: Add a test for a two-entry
 52-bit TTBR table
Date: Sat, 17 Oct 2026 23:26:17 +0300
Message-ID: <20261017202638.728621-59-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Fuad Tabba <fuad.tabba@linux.dev>

Add a test checking that, with a 52-bit OA, TTBR[4] of a two-entry
level 0 table is taken only as base address bit 50, not also as bit 4.

Reviewed-by: Gustavo Romero <gromero@redhat.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Message-id: 20261009115728.1299384-3-fuad.tabba@linux.dev
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit bb79850255c885fa91e6c095b4e0d967ce6c98ca)
(Mjt: adjust test for before make=>meson conversion)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 4b92a2ffe4..2e90c9e532 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -85,6 +85,8 @@ run-gpc3-test: QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
 
 run-wfxt: QEMU_OPTS=-M virt,virtualization=on,gic-version=2 -cpu max -smp 1 -semihosting-config enable=on,arg=2 -kernel
 
+run-ttbr-baddr: QEMU_OPTS=-M virt,virtualization=on -cpu max -semihosting-config enable=on,arg=2 -kernel
+
 # Simple Record/Replay Test
 .PHONY: memory-record
 run-memory-record: memory-record memory
diff --git a/tests/tcg/aarch64/system/ttbr-baddr.c b/tests/tcg/aarch64/system/ttbr-baddr.c
new file mode 100644
index 0000000000..b29c9e1ab0
--- /dev/null
+++ b/tests/tcg/aarch64/system/ttbr-baddr.c
@@ -0,0 +1,153 @@
+/*
+ * TTBR base address with a 52-bit layout and a small initial lookup table
+ *
+ * With a 52-bit OA, walk a two-entry level 0 table through an IPA with
+ * bit 50 set, which stage 2 maps back onto the table, so the walk
+ * succeeds only if TTBR[4] is cleared from bit 4 of the base address.
+ *
+ * Copyright (c) 2026 Google LLC
+ * Author: Fuad Tabba <fuad.tabba@linux.dev>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <minilib.h>
+
+/* from Linux's include/linux/stringify.h */
+#define __stringify_1(x...) #x
+#define __stringify(x...)   __stringify_1(x)
+
+#define read_sysreg(r) ({                                           \
+            uint64_t __val;                                         \
+            asm volatile("mrs %0, " __stringify(r) : "=r" (__val)); \
+            __val;                                                  \
+})
+
+#define write_sysreg(r, v) do {                     \
+        uint64_t __val = (uint64_t)(v);             \
+        asm volatile("msr " __stringify(r) ", %x0"  \
+                 : : "rZ" (__val));                 \
+} while (0)
+
+/*
+ * kernel.ld links the test at 1GB, so the tables below lie within the
+ * blocks mapped at RAM_BASE.
+ */
+#define RAM_BASE    0x40000000UL
+#define HIGH_IPA    (1UL << 50)
+#define TEST_VA     (0xffff000000000000UL | RAM_BASE)
+
+/*
+ * Stage 1: 16KB granule, 48-bit VA, so level 0 has two entries.
+ * Stage 2: 64KB granule, 52-bit IPA, mapping RAM at its own address and
+ * again at HIGH_IPA.
+ */
+static uint64_t s1_l0[2048] __attribute__((aligned(16384)));
+static uint64_t s1_l1[2048] __attribute__((aligned(16384)));
+static uint64_t s1_l2[2048] __attribute__((aligned(16384)));
+static uint64_t s2_l1[1024] __attribute__((aligned(65536)));
+static uint64_t s2_l2[8192] __attribute__((aligned(65536)));
+static uint64_t s2_l2_high[8192] __attribute__((aligned(65536)));
+
+#define TCR_T0SZ(x)     ((uint64_t)(x) << 0)
+#define TCR_T1SZ(x)     ((uint64_t)(x) << 16)
+#define TCR_TG0_16K     (2UL << 14)
+#define TCR_TG1_16K     (1UL << 30)
+#define TCR_IPS_52      (6UL << 32)
+#define TCR_DS          (1UL << 59)
+
+#define VTCR_T0SZ(x)    ((uint64_t)(x) << 0)
+#define VTCR_SL0_L1     (2UL << 6)
+#define VTCR_TG0_64K    (1UL << 14)
+#define VTCR_PS_52      (6UL << 16)
+#define VTCR_RES1       (1UL << 31)
+
+#define HCR_VM          (1UL << 0)
+#define HCR_RW          (1UL << 31)
+
+#define PAR_F           (1UL << 0)
+#define PAR_PA(par)     ((par) & 0xfffffffff000UL)
+#define S2_BLOCK        ((1 << 10) | (3 << 6) | (0xf << 2) | 1)
+
+static void tlb_flush(void)
+{
+    asm volatile("dsb sy; tlbi alle1; dsb sy; isb" : : : "memory");
+}
+
+static uint64_t at(uint64_t ttbr1)
+{
+    uint64_t par;
+
+    write_sysreg(ttbr1_el1, ttbr1);
+    tlb_flush();
+    asm volatile("at s12e1r, %1; isb; mrs %0, par_el1"
+                 : "=r" (par) : "r" (TEST_VA));
+    return par;
+}
+
+static void setup_tables(void)
+{
+    /* Stage 1: TEST_VA -> RAM_BASE, 32MB block, AF */
+    s1_l0[0] = (uint64_t)s1_l1 | 3;
+    s1_l1[0] = (uint64_t)s1_l2 | 3;
+    s1_l2[(RAM_BASE >> 25) & 0x7ff] = RAM_BASE | (1 << 10) | 1;
+
+    /* Stage 2: 512MB blocks at RAM_BASE and HIGH_IPA | RAM_BASE, AF, RW */
+    s2_l1[0] = (uint64_t)s2_l2 | 3;
+    s2_l1[HIGH_IPA >> 42] = (uint64_t)s2_l2_high | 3;
+    s2_l2[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK;
+    s2_l2_high[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK;
+}
+
+static int check(const char *name, uint64_t par)
+{
+    int ok = !(par & PAR_F) && PAR_PA(par) == RAM_BASE;
+
+    ml_printf("%s: PAR_EL1=%lx %s\n", name, par, ok ? "ok" : "FAIL");
+    return !ok;
+}
+
+int main(void)
+{
+    uint64_t mmfr0 = read_sysreg(id_aa64mmfr0_el1);
+    uint64_t tcr = TCR_T0SZ(16) | TCR_T1SZ(16) | TCR_TG0_16K | TCR_TG1_16K |
+                   TCR_DS;
+    uint64_t base = (uint64_t)s1_l0;
+    int ret = 0;
+
+    ml_printf("TTBR base address test\n");
+
+    /*
+     * PARange 52 bits (FEAT_LPA) and TGran16 with 52-bit addresses
+     * (FEAT_LPA2)
+     */
+    if ((mmfr0 & 0xf) != 6 || ((mmfr0 >> 20) & 0xf) != 2) {
+        ml_printf("SKIP: no 52-bit PA or no FEAT_LPA2 with 16KB\n");
+        return ret;
+    }
+
+    /*
+     * The test runs at EL2 (arg=2) and walks the EL1&0 regime with AT, so
+     * the EL1 MMU settings below only affect those walks.
+     */
+    setup_tables();
+    write_sysreg(mair_el1, 0xff);
+    write_sysreg(sctlr_el1, read_sysreg(sctlr_el1) | 1);
+
+    /*
+     * 52-bit OA: TTBR[4] is base address bit 50, so with it set the
+     * level 0 table is at IPA HIGH_IPA | s1_l0. Stage 2 maps that IPA
+     * onto s1_l0 (through s2_l2_high), so the walk succeeds only if
+     * TTBR[4] does not also offset the two-entry table by 0x10.
+     */
+    write_sysreg(vtcr_el2, VTCR_T0SZ(12) | VTCR_SL0_L1 | VTCR_TG0_64K |
+                 VTCR_PS_52 | VTCR_RES1);
+    write_sysreg(vttbr_el2, (uint64_t)s2_l1);
+    write_sysreg(hcr_el2, HCR_RW | HCR_VM);
+    write_sysreg(tcr_el1, tcr | TCR_IPS_52);
+    ret |= check("ips52", at(base));
+    ret |= check("ips52 ttbr[4]", at(base | (1 << 4)));
+
+    return ret;
+}
-- 
2.47.3


