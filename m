Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB38CC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26CE-0002sN-0J; Thu, 03 Sep 2026 08:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26CB-0002mI-6u
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:31 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26C9-0005Ja-C0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=QWICf3s
 pWUu8XLh4/BsjIGRXRHFXGPokzVb1SyI4T3OLRdPibD4hK1PBPjVo03okES3f4MPhSjxnE
 uC/D1JUiqhK045QSVu2PEXNECd5roThAD0KDaYjcMT3MtM1ka4wdc3aE0WTDWpAZhU/avJ
 m4cdyLE6wtEUYWFXGz+PJMY/VPwQUCLc+GBKthiQEtiK4CoyITqqQEyDITp9fxzkQlX2Gj
 KvdqHEx0E3ztZFc4pAjKcuHRPWqZDhNCoavR0+O/neEObuNyQfruX5gsnATryYOdeQ3kPo
 me7XEMZM37RErPyTxFF0C4E4efJZVlIwGtl3qfPDkw5f4OZHNssjp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=r
 qLyOejlQcL4jEeF3YZ9AxaUoEhdFLilYAK4VajrGMA=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=bky4EToxAQk21Wc1QbhCwplnn4Jvcvvy4Q9z+Wd7SxhDIb+nLalmFPGsJW9PXVQhQg+u
 IibqOY9IPCXd5AYGgjJVicrpSt4ze8DyaBrU0CX6oqLx0Y2Fdf+MJjw6obpbMhBIRViEq+
 grh1tUybS30EWdDQNFK5VkPOqe/N//NS/xV3HaK9TPjLbHZY9+COS9K21wYQ2s20Iog7kN
 3n8GL14QP/2+mq8a8c33xk6VdVuXdN3Av/Yhu9eOmiFT3JTrwdy2G+fdM8SE2dOIFhIGCE
 Nokm6AZOHWLO4mcUIg1VqdqWSfal/MTHqu8suPJ0gRokd0HJ/j4cmD0OwyvY0iGQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=h45MgYhx; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=LOk/zEUw;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=rqLyOejl
 QcL4jEeF3YZ9AxaUoEhdFLilYAK4VajrGMA=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=h45MgYhxxwvQd9VmLdsiw26tw5pf2VCWhDL
 aqS6/jL2/rzk3sPGraTD1ba8nef1Hj8RDtrZ/iQ6fmLUVUPpY68kptJTwF2W2BRPAeJ+w9
 GfLHxatHRBAhHoseOLeEajCe1IBQRoOSJqQ1SLl+3bd9sdOlX9j0he6jIGmaOKqXoNgn4V
 RVvEh8huHker4ibnYYUNrYyFzwMmzqo+IA8qpNMpCWUlkGGqjDwyhq5pf+9p/ORdRuuQ0L
 RK9esP75C5SCND9QbiII8ch6WywYTCcyAh5oecQv+bk8ybuw9gy4GGpbO/VTP+/nhu5qhe
 CIqpY3SIHs2V9I3+WVPnzBaP96A==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=rqLyOejlQcL4jEeF3YZ9AxaUoEhdFLilYAK4VajrGMA=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=LOk/zEUwZjAUrHXmAs
 r+fLD1nh+SUbcHT2QndAhMG2w+Tgy2zPUfpkobPH0m6oVdJkHixp2zhlmo3/iNdyKXAQ==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id ff5ed5d4
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 14:05:23 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id fa0c73ed;
 Thu, 3 Sep 2026 14:05:15 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 06/25] target/mips: accept Octeon PageMask encodings
Date: Thu,  3 Sep 2026 14:01:54 +0200
Message-ID: <20260903120510.34876-7-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903120510.34876-1-kirill@korins.ky>
References: <20260903120510.34876-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
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
2.55.0


