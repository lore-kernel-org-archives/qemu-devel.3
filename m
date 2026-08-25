Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB10C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysXK-0007jW-04; Tue, 25 Aug 2026 10:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wysXI-0007j8-EA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:54:00 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wysXF-0001XD-QY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:54:00 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a157f90752so8172052a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787669636; x=1788274436; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3IQr885EL1Y9Z+2gfA0Gs15Nor/ucudTGCA5cK6mgkY=;
 b=el+KjIVk8cJoIGEflSxDuFpL/JGiLYzaOm5cnM9MXFT58ZgnFbqM60qbjDVUUcdwxn
 WpxoQnKDW0YmZeixcBOy9SZTA0MVx0gzbJIXw/1wgqSAce0bXJCl5At/+IzjTemTRGo8
 eqGtxm2X7MV0KpN/iiGd0SCmKv3KHdQJKQRIBmGhp2006OnPQFhO9yS8UbNbOqbGxGV0
 vspbH8ZdpHp5jYoiNd+L1AtQbD8b91MXi08Fw1stfCzIZsyD1XxY+arIoj1a2MZlv4dn
 hYKK7w1NYt+jGp7/d2mfISAcQGCwEHZqgrnQHidT/PQ23bugJ2hbELPeAsjw9Y9TSOB7
 x0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787669636; x=1788274436;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3IQr885EL1Y9Z+2gfA0Gs15Nor/ucudTGCA5cK6mgkY=;
 b=RnFxtI0H6O8N6xcH1q/4e1Di2bUes/J4XZnJWB5gTxaq3TRVIFJfd9FDOXFvRmu8p7
 9R2ZUTR6zf5xid3AtPt1wbxusL+70ZQbg4jGCmaeinoDX8A+b5YiorGd7JG7IfOIb8wQ
 kS67GMCIVO9wBLe0anqhbunIHtvW0sFPc2yDw/t8oHwTJyJmYASzY/E7LMNtEBcKuIaQ
 7zsLxnsATND8ZsIIBKuFM4oRoFTkOdojcmKavHWv4eio68Bnvlbh4/bkkKlrnHcW0Cz2
 JXs6LhlcGqjSy4+guqElwCfr6bsIQ2uJ4Nq19vrLsnHOn10nVMPq0ktV/sCD/miF2oXs
 z09A==
X-Gm-Message-State: AFuF++lQvksBnFfwyIJ2jaQ7BOLOTi/F2A0XFsOwcE1f6yl7iI6FoSNJ
 6deph0MLwZUbr1/xtGRs50INeoEczw44OU6CVINxDlSaHgw5ci0NRXrBVwacvwQrorKKY3nm8pl
 AO4H3how=
X-Gm-Gg: AR+sD117/5CgPhYugyllXCyYLqbsXl6XkWNSDm5/iPzDq69jAJ6N1+ebOsIXjJuVSyp
 HpC0lRoxrAc0hfpL86gFola9hDQSl6769uhY1GdfiFnaPYF/mRGsdxCs9MgBpgDFrzXY2C3pzIQ
 gMbMsT5cdfVbz6qAAET+QYctzSod6dQ4HOdTNweJKmixhqfbFt8rDOEi9BJ8uPDOLe77h0IIjKS
 aiKCm53CmkGD5/nPuKYGNqOKeVW67FiCnqvhXf5SEYbQeb/hxgcHC5nzQQlSCEBtDkqacvIb4mh
 L+lem6+zGoVcdbD2+nPPhPK+1tCIkUazsZQztJi9LIvXiBLx99OKP9G4pjjk9vd15SDLWe4SOk2
 tKPHFXzXqi8e9e1an8v0g+HLuEXLk9qXDg8oQKGSUIJDcUb3VY/ETaVUFGL/jP6Y59dQ0fMeLgd
 eLnxH2HjFt8ZK1gVxrQj48OS+P+PykhmtdzHBr5WEvntwwJ7yZu7ehd+aGwTw2
X-Received: by 2002:a17:907:9451:b0:c25:5d2:acf0 with SMTP id
 a640c23a62f3a-c2505d2b360mr177834766b.8.1787669635186; 
 Tue, 25 Aug 2026 07:53:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24962bbea6sm1725921766b.27.2026.08.25.07.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:53:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 042E25F86C;
 Tue, 25 Aug 2026 15:53:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH] target/arm: re-order ARMFault_Domain check for v5/v6 ptw
Date: Tue, 25 Aug 2026 15:53:50 +0100
Message-ID: <20260825145350.3726466-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In the Armv7 ARM (DDI0406C) any walk of the short descriptor
table (TranslationTableWalkSD()) which has a second stage has the
opportunity to fault with a translation fault in
SecondStageTranslate() before a potential domain checking fault.

Moving the check down and lightly re-factoring setting level = 2 we
can more closely match the architectural behaviour.

Reported-by: Karl Mehltretter (@kmehltretter)
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4233
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
I've only checked the get_phys_addr_v6 change against the Arm ARM but
I've fairly confident the v5 one is the same. I've bundled everything
together for review but this patch can't be merged as is because it
does too much in one commit. Some open questions:

  - should we properly factor out a boot_v6.S and share with other tests
  - could the ptw code better match the psuedocode (e.g. case l1desc<1:0>)
  - which Arm ARM should be checked for get_phys_addr_v5
---
 target/arm/ptw.c                              |  31 ++--
 tests/tcg/arm/system/test-domainfault.c       | 148 ++++++++++++++++++
 tests/tcg/arm/Makefile.softmmu-target         |  23 ++-
 tests/tcg/arm/system/test-domainfault-start.S |  62 ++++++++
 tests/tcg/arm/system/test-domainfault.ld      |  17 ++
 5 files changed, 264 insertions(+), 17 deletions(-)
 create mode 100644 tests/tcg/arm/system/test-domainfault.c
 create mode 100644 tests/tcg/arm/system/test-domainfault-start.S
 create mode 100644 tests/tcg/arm/system/test-domainfault.ld

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a29de0385f4..ddfbb79beb6 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1172,19 +1172,13 @@ static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
         fi->type = ARMFault_Translation;
         goto do_fault;
     }
-    if (type != 2) {
-        level = 2;
-    }
-    if (domain_prot == 0 || domain_prot == 2) {
-        fi->type = ARMFault_Domain;
-        goto do_fault;
-    }
     if (type == 2) {
         /* 1Mb section.  */
         phys_addr = (desc & 0xfff00000) | (address & 0x000fffff);
         ap = (desc >> 10) & 3;
         result->f.lg_page_size = 20; /* 1MB */
     } else {
+        level = 2;
         /* Lookup l2 entry.  */
         if (type == 1) {
             /* Coarse pagetable.  */
@@ -1239,6 +1233,10 @@ static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
             g_assert_not_reached();
         }
     }
+    if (domain_prot == 0 || domain_prot == 2) {
+        fi->type = ARMFault_Domain;
+        goto do_fault;
+    }
     result->f.prot = ap_to_rw_prot(env, ptw->in_mmu_idx, ap, domain_prot);
     result->f.prot |= result->f.prot ? PAGE_EXEC : 0;
     if (ptw->in_prot_check & ~result->f.prot) {
@@ -1254,6 +1252,7 @@ do_fault:
     return false;
 }
 
+/* See TranslationTableWalkSD() in Armv7 ARM (DDI0406C) */
 static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
                              uint32_t address, MMUAccessType access_type,
                              GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
@@ -1288,6 +1287,7 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
     if (fi->type != ARMFault_None) {
         goto do_fault;
     }
+    /* l1desc<1:0> */
     type = (desc & 3);
     if (type == 0 || (type == 3 && !cpu_isar_feature(aa32_pxn, cpu))) {
         /* Section translation fault, or attempt to use the encoding
@@ -1305,15 +1305,6 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
     } else {
         dacr = env->cp15.dacr_s;
     }
-    if (type == 1) {
-        level = 2;
-    }
-    domain_prot = (dacr >> (domain * 2)) & 3;
-    if (domain_prot == 0 || domain_prot == 2) {
-        /* Section or Page domain fault */
-        fi->type = ARMFault_Domain;
-        goto do_fault;
-    }
     if (type != 1) {
         if (desc & (1 << 18)) {
             /* Supersection.  */
@@ -1331,6 +1322,7 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
         pxn = desc & 1;
         ns = extract32(desc, 19, 1);
     } else {
+        level = 2;
         if (cpu_isar_feature(aa32_pxn, cpu)) {
             pxn = (desc >> 2) & 1;
         }
@@ -1373,6 +1365,13 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
          */
         out_space = ARMSS_NonSecure;
     }
+    /* Extract from DACR indexed by domain */
+    domain_prot = (dacr >> (domain * 2)) & 3;
+    if (domain_prot == 0 || domain_prot == 2) {
+        /* Section or Page domain fault */
+        fi->type = ARMFault_Domain;
+        goto do_fault;
+    }
     if (domain_prot == 3) {
         result->f.prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     } else {
diff --git a/tests/tcg/arm/system/test-domainfault.c b/tests/tcg/arm/system/test-domainfault.c
new file mode 100644
index 00000000000..3b2593b0107
--- /dev/null
+++ b/tests/tcg/arm/system/test-domainfault.c
@@ -0,0 +1,148 @@
+/*
+ * Test short-descriptor domain fault vs. L2-descriptor validity ordering.
+ * (GitLab issue #4233)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Sets up a non-LPAE (short-descriptor) page table:
+ *  - L1[0]       section, identity map of the low 1MB (our own code/data),
+ *                domain 0.
+ *  - L1[4]       coarse (page-table) entry for VA 0x00400000, domain 1,
+ *                pointing at an L2 table that is left entirely zeroed
+ *                (every L2 entry therefore decodes as "invalid").
+ *  - DACR: domain 0 = Client (viable), domain 1 = No Access.
+ *
+ * Then reads VA 0x00400000. Spec (ARM DDI 0100I/E, Figure B4-2 and
+ * ARM DDI 0406C): the domain is checked only after a valid second-level
+ * descriptor is returned. Since the L2 entry is invalid (0), a spec-faithful
+ * walker must report a page Translation Fault (DFSR[3:0] = 0x7),
+ * independent of DACR[1].
+ *
+ * QEMU previously checked the domain from the L1 descriptor before fetching
+ * L2, incorrectly reporting a Domain Fault (DFSR[3:0] = 0xb).
+ */
+
+#include <stdint.h>
+
+#define VICTIM_VA 0x00400000u
+
+#ifdef V6_SHORT_DESC_TEST
+#define L1_SECTION_EXEC_FLAGS ((3u << 10) | 0x2u)
+#define SCTLR_TEST_FORMAT_BIT (1u << 23) /* XP: use v6 short descriptors */
+#else
+#define L1_SECTION_EXEC_FLAGS ((3u << 10) | (1u << 4) | 0x2u)
+#define SCTLR_TEST_FORMAT_BIT 0u
+#endif
+
+static inline void semihost_write0(const char *str)
+{
+    register uint32_t r0 __asm__("r0") = 0x04; /* SYS_WRITE0 */
+    register uint32_t r1 __asm__("r1") = (uint32_t)(uintptr_t)str;
+    __asm__ volatile ("svc 0x123456" : : "r"(r0), "r"(r1) : "memory");
+}
+
+static inline void semihost_exit(int status)
+{
+    register uint32_t r0 __asm__("r0") = 0x18; /* SYS_EXIT */
+    register uint32_t r1 __asm__("r1") = status ? 0x20024 : 0x20026;
+    __asm__ volatile ("svc 0x123456" : : "r"(r0), "r"(r1) : "memory");
+}
+
+static void puthex32(uint32_t v)
+{
+    static const char hex[] = "0123456789abcdef";
+    char buf[9];
+    int i;
+
+    for (i = 7; i >= 0; i--) {
+        buf[i] = hex[v & 0xf];
+        v >>= 4;
+    }
+    buf[8] = '\0';
+    semihost_write0(buf);
+}
+
+static void report(const char *label, uint32_t v)
+{
+    semihost_write0(label);
+    puthex32(v);
+    semihost_write0("\n");
+}
+
+/* L1: 4096 entries, 16KB, 16KB-aligned. L2: 256 entries, 1KB, 1KB-aligned. */
+static uint32_t l1_table[4096] __attribute__((aligned(16384)));
+static uint32_t l2_table[256] __attribute__((aligned(1024)));
+
+void c_main(void)
+{
+    uint32_t i;
+    uint32_t l2_phys = (uint32_t)(uintptr_t)l2_table;
+    uint32_t sctlr;
+
+    semihost_write0("=== Domain fault ordering test ===\n");
+
+    for (i = 0; i < 4096; i++) {
+        l1_table[i] = 0;
+    }
+    for (i = 0; i < 256; i++) {
+        l2_table[i] = 0;
+    }
+
+    /* L1[0]: identity section for our code/data/stack, domain 0. */
+    l1_table[0] = 0x00000000u | (0u << 5) | L1_SECTION_EXEC_FLAGS;
+
+    /* L1[4]: coarse entry for VICTIM_VA, domain 1, L2 all-invalid. */
+    l1_table[VICTIM_VA >> 20] =
+        (l2_phys & 0xfffffc00u) | (1u << 5) | (1u << 4) | 0x1u;
+
+    report("L1 table @ 0x", (uint32_t)(uintptr_t)l1_table);
+    report("L2 table @ 0x", l2_phys);
+    report("L1[victim] = 0x", l1_table[VICTIM_VA >> 20]);
+
+    /* DACR: domain0 = Client (0b01), domain1 = No Access (0b00). */
+    __asm__ volatile ("mcr p15, 0, %0, c3, c0, 0" : : "r"(0x00000001u));
+
+    /* TTBR0 */
+    __asm__ volatile ("mcr p15, 0, %0, c2, c0, 0"
+                      : : "r"((uint32_t)(uintptr_t)l1_table));
+
+    /* Invalidate unified TLB */
+    __asm__ volatile ("mcr p15, 0, %0, c8, c7, 0" : : "r"(0));
+
+    __asm__ volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r"(sctlr));
+    report("SCTLR before MMU on = 0x", sctlr);
+    sctlr |= 1u | SCTLR_TEST_FORMAT_BIT;
+    __asm__ volatile (
+        "mcr p15, 0, %0, c1, c0, 0\n"
+        "nop\n\tnop\n\tnop\n\tnop\n"
+        : : "r"(sctlr));
+
+    semihost_write0("MMU enabled, reading victim VA (expect abort)...\n");
+    {
+        /* Trigger data abort at VICTIM_VA */
+        volatile uint32_t *victim = (volatile uint32_t *)VICTIM_VA;
+        uint32_t v = *victim;
+        report("UNEXPECTED: read succeeded, value = 0x", v);
+        semihost_exit(1);
+    }
+}
+
+void report_fault(uint32_t dfsr, uint32_t dfar)
+{
+    uint32_t fs = dfsr & 0xfu;
+
+    report("DFAR = 0x", dfar);
+    report("DFSR = 0x", dfsr);
+    report("DFSR[3:0] = 0x", fs);
+
+    if (dfar == VICTIM_VA && fs == 0x7) {
+        semihost_write0("PASS: level-2 translation fault (0x7)\n");
+        semihost_exit(0);
+    } else {
+        semihost_write0("FAIL: expected translation fault (0x7), "
+                        "got fault status 0x");
+        puthex32(fs);
+        semihost_write0("\n");
+        semihost_exit(1);
+    }
+}
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index b66074b0b43..3fda4d41689 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -20,10 +20,31 @@ run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,cha
 
 ARM_TESTS+=test-armv6m-undef
 
+# Domain fault ordering tests (GitLab issue #4233)
+test-armv5-domainfault: test-domainfault-start.S test-domainfault.c
+	$(CC) -march=armv5te -marm -mfloat-abi=soft \
+		-ffreestanding -fno-builtin -nostdlib -static \
+		-Wl,--build-id=none -Wl,--no-warn-rwx-segments \
+		$< $(ARM_SRC)/test-domainfault.c -o $@ \
+		-T $(ARM_SRC)/test-domainfault.ld
+
+run-test-armv5-domainfault: QEMU_OPTS=-audio none -semihosting-config enable=on,target=native,chardev=output -M versatilepb -cpu arm926 -kernel
+
+test-armv6-domainfault: test-domainfault-start.S test-domainfault.c
+	$(CC) -march=armv6k -marm -mfloat-abi=soft -DV6_SHORT_DESC_TEST \
+		-ffreestanding -fno-builtin -nostdlib -static \
+		-Wl,--build-id=none -Wl,--no-warn-rwx-segments \
+		$< $(ARM_SRC)/test-domainfault.c -o $@ \
+		-T $(ARM_SRC)/test-domainfault.ld
+
+run-test-armv6-domainfault: QEMU_OPTS=-audio none -semihosting-config enable=on,target=native,chardev=output -M versatilepb -cpu arm11mpcore -kernel
+
+ARM_TESTS+=test-armv5-domainfault test-armv6-domainfault
+
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
 
-ARM_TEST_SRCS=$(wildcard $(ARM_SRC)/*.c)
+ARM_TEST_SRCS=$(filter-out $(ARM_SRC)/test-domainfault.c, $(wildcard $(ARM_SRC)/*.c))
 ARM_TESTS+=$(patsubst $(ARM_SRC)/%.c, %, $(ARM_TEST_SRCS))
 
 CRT_PATH=$(ARM_SRC)
diff --git a/tests/tcg/arm/system/test-domainfault-start.S b/tests/tcg/arm/system/test-domainfault-start.S
new file mode 100644
index 00000000000..8d024c822d6
--- /dev/null
+++ b/tests/tcg/arm/system/test-domainfault-start.S
@@ -0,0 +1,62 @@
+/*
+ * Vector table + minimal mode/stack init for domain-fault-ordering test.
+ * (GitLab issue #4233)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+.syntax unified
+.arm
+
+.equ MODE_UND, 0x1B
+.equ MODE_ABT, 0x17
+.equ MODE_IRQ, 0x12
+.equ MODE_FIQ, 0x11
+.equ MODE_SVC, 0x13
+.equ NOINT,    0xC0   /* IRQ+FIQ disabled */
+
+.section .vectors, "ax"
+.global _vectors
+_vectors:
+    b reset_handler
+    b hang            /* undefined instruction */
+    b hang            /* swi */
+    b hang            /* prefetch abort */
+    b data_abort_handler
+    b hang            /* reserved */
+    b hang            /* irq */
+    b hang            /* fiq */
+
+.section .text
+reset_handler:
+    msr cpsr_c, #(MODE_UND | NOINT)
+    ldr sp, =und_stack_top
+    msr cpsr_c, #(MODE_ABT | NOINT)
+    ldr sp, =abt_stack_top
+    msr cpsr_c, #(MODE_IRQ | NOINT)
+    ldr sp, =irq_stack_top
+    msr cpsr_c, #(MODE_FIQ | NOINT)
+    ldr sp, =fiq_stack_top
+    msr cpsr_c, #(MODE_SVC | NOINT)
+    ldr sp, =svc_stack_top
+    bl c_main
+hang:
+    b hang
+
+data_abort_handler:
+    mrc p15, 0, r0, c5, c0, 0   /* DFSR */
+    mrc p15, 0, r1, c6, c0, 0   /* DFAR */
+    bl report_fault
+    b hang
+
+.section .bss
+.align 4
+und_stack: .space 256
+und_stack_top:
+abt_stack: .space 256
+abt_stack_top:
+irq_stack: .space 256
+irq_stack_top:
+fiq_stack: .space 256
+fiq_stack_top:
+svc_stack: .space 4096
+svc_stack_top:
diff --git a/tests/tcg/arm/system/test-domainfault.ld b/tests/tcg/arm/system/test-domainfault.ld
new file mode 100644
index 00000000000..4d1809ddb8f
--- /dev/null
+++ b/tests/tcg/arm/system/test-domainfault.ld
@@ -0,0 +1,17 @@
+/*
+ * Linker script for domain-fault-ordering test.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+ENTRY(_vectors)
+
+SECTIONS
+{
+    . = 0x00000000;
+    .vectors : { *(.vectors) }
+    .text : { *(.text*) }
+    .rodata : { *(.rodata*) }
+    .data : { *(.data*) }
+    .bss : { *(.bss*) *(COMMON) }
+    /DISCARD/ : { *(.comment) *(.ARM.attributes) }
+}
-- 
2.47.3


