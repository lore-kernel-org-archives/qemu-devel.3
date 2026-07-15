Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF902C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzv9-0005cI-7f; Wed, 15 Jul 2026 09:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv3-0005Xu-DJ
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:01 -0400
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv1-0007uq-Ew
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=WPGSZzh
 UIP5yf8j+lp9rVikzwrpbBBx9p+9GPdRnCf7VRaDeVnfD6fo13wMidy12Sqw9u2maU7FBE
 aSNbo5nIPdvnICcZjv0QT2PPK+iTqzAA3XtKDnjn0xG7Al/srv32CvgnlpbqjulXa+aAs3
 I38ZRd71YHmzYVBYFmQsXB9pI3MxT0EeAeCgdnji02EwYkyRqAp5Tg5VYr9L1lQJ3Q68YY
 Hs/mzQzPjFtJ4j/g6SBXCXXynYsRjXODIE142Qzul8V0vJGkgHFgR+f1ZMLBSCo8D/IyS2
 COAPv8hwtngoI6Q7QVJ2NhC6GESVt1VgdR6VlBwm8iPq4ASXqMAvGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=P
 Oyhf9Iunjp2h42Ks9RVFy2rrI6RIYh+DpHMxI4OICM=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=zhTXOglavO82RdyUSUrxaHBmq48hv+v69RVfpyMGOVjd8rJdi2sYK/hZIHsx8YXIR84B
 aNxH8pT8OBpMcForwZGclZdyh42URy2xQS/cIYG8zfreVSS7rrLBbkDzhMctyX4H6Ytjn6
 QdISuce6R65jkuaNbOAcHuV21bOSlUgB7688ZoKbR4xCQuJw39OdcymKlpWt76HPK/kPj4
 g0rw801WX0jBQwyEFfcYu0vEA98f8rMFdCbkyKpEX0PTE1kyqy76tJLzaYfa4DfRB3KLRC
 3xn6b0LaD2OWqHxKbe1aLeZ/IctdwPdDuX1eJcbFMMuynBqvUNSMlOdtI0hs9c7A==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=DxcymHrR; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=dX2I6ata;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=POyhf9Iu
 njp2h42Ks9RVFy2rrI6RIYh+DpHMxI4OICM=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=DxcymHrRyn04We/RBykTsKoJ7qtKljAs+9n
 Qv7/ejSkJmNwjoWU4inQaCETrAyia2ZuM35Oe6GaYjE+ZhG6LqYbjoEw9KgRLrLRmlFyp0
 ZXsoCSa87Uz2zOHafuFcug1LTmrMP8z9ruAXZo8Rz3EEw86dct7Qt1KBQ3U+2lIzEnYWh1
 RxOJMRm9aFMdYIvZN+sSUy+sEkjJ34dtWJLOumC/9HkzhFoU8O3KHEejGAVJs8mmJDTUC0
 sxN2meSMrbub2ZtmU5PcVwtJA8Kbiw2bPaSCkttggiEjJ4xc6/jH7Higt3vyWUehc8fe4G
 tSsF8ro41sdLOke3GiyNoQjAg/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=POyhf9Iunjp2h42Ks9RVFy2rrI6RIYh+DpHMxI4OICM=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=dX2I6atazOFqDucYUO
 jGhbr2PuhJT0FXmDGEY3PptVUakdMn5zmpcvMINWZJamSfwCDSIto6SPMcGJf4BNW/CQ==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id b64b0226
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 15 Jul 2026 15:44:51 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id b42f9560;
 Wed, 15 Jul 2026 15:44:49 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 06/25] target/mips: accept Octeon PageMask encodings
Date: Wed, 15 Jul 2026 15:43:52 +0200
Message-ID: <20260715134447.56007-7-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715134447.56007-1-kirill@korins.ky>
References: <20260715134447.56007-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Octeon firmware programs contiguous PageMask values that do not follow
the generic R4K even maskbits rule.

Keep the generic validation rule for other MIPS CPUs, while allowing
Octeon CPUs to use the contiguous masks accepted by hardware.
---
 target/mips/tcg/system/cp0_helper.c | 15 ++++++++++-----
 target/mips/tcg/system/tlb_helper.c |  2 +-
 target/mips/tcg/tcg-internal.h      |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 1c23d2a525..40a41805fa 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -882,14 +882,19 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-uint32_t compute_pagemask(uint32_t val)
+uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val)
 {
     /* Don't care MASKX as we don't support 1KB page */
-    uint32_t mask = extract32(val, CP0PM_MASK, 16);
+    uint32_t mask = val >> CP0PM_MASK;
     int maskbits = cto32(mask);
 
-    /* Ensure no more set bit after first zero, and maskbits even. */
-    if ((mask >> maskbits) == 0 && maskbits % 2 == 0) {
+    /*
+     * Generic R4K PageMask values use two mask bits per size step.
+     * Octeon accepts contiguous byte masks such as 0x003fffff for
+     * two 2 MiB pages.
+     */
+    if ((mask & (mask + 1)) == 0 &&
+        ((env->insn_flags & INSN_OCTEON) || maskbits % 2 == 0)) {
         return mask << CP0PM_MASK;
     } else {
         /* When invalid, set to default target page size. */
@@ -899,7 +904,7 @@ uint32_t compute_pagemask(uint32_t val)
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
 {
-    env->CP0_PageMask = compute_pagemask(arg1);
+    env->CP0_PageMask = compute_pagemask(env, arg1);
 }
 
 void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 4c0a25e622..ae805bff28 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -877,7 +877,7 @@ refill:
         }
     }
     pw_pagemask = m >> TARGET_PAGE_BITS;
-    pw_pagemask = compute_pagemask(pw_pagemask << CP0PM_MASK);
+    pw_pagemask = compute_pagemask(env, pw_pagemask << CP0PM_MASK);
     pw_entryhi = (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
     {
         target_ulong tmp_entryhi = env->CP0_EntryHi;
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index 950e6afc3f..66ae39551e 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -47,7 +47,7 @@ bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
 void mmu_init(CPUMIPSState *env, const mips_def_t *def);
 
-uint32_t compute_pagemask(uint32_t val);
+uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val);
 
 void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
 uint32_t cpu_mips_get_random(CPUMIPSState *env);
-- 
2.54.0


