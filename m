Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3488E606A32C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=oIS3vrtu;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=GE+rteYJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX19-0008Cw-0d; Thu, 29 Oct 2026 16:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0w-00086S-23
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:22 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0s-0007TJ-RE
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=fbTcsco
 t+dNqGaYZBzZULNYBDdG3PXum59Pu8F72Afe+hPJ6VMOGC2v0kWFoFQhnvqxVNO6Zq54WN
 VhpJKg04jYOqiplsl8HcIJFz7sm4t+JhCFUbdoWIwtrXJGjVmyoVxQ8Zr4IXS1jiZ6floa
 YjwRnq39PKTRMvvk/skYjIqBs3eEbfy8TtKgJpnSxqrKMHbTW6dZneHMe/oRp4JVOfRGo5
 z2lFnkiQ9wV6E9sQMjeIULU8aRjRLAaXKD4Gmz9YMHHHmBR8VHMToTRCFn3oBpYYOhdTBI
 XVbLgqSA6tvx5qY/rD/0dOG85hrYAB16xx1a5M2GMaFNZ+A8+kEkqug==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=M
 +Kugc7ox2Sme1cj2c4C2xn69krCAd0C+QbJSmCxABI=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=zJ/hTrfU8bjbDfP4zHxDVr3+5ZMIR82xKXkAMnJu92TM51ROAEMr32BUW2nIqPB19lyZ
 PQxO1+Y+tLqwIGDy7Y5ZynGWbfefoCoxzauWEdMs2o8WNLd/aEe4TiI0ZoRXlSlJPvG6/K
 RHDS92a8apA3dSE7kC1L4E25KLBDpc/zI7YyhmlKcgpo9RzFh0732IV+tsbQqkQwzYTd9m
 0oHCwkXhe8Jrs/hOFF72XNwBQFskOqtIJ480364hCCrWyGIR1uKzww1rjmbxUuxFcbE/LI
 jru7FrG9yRU8Ni8pd4Q2S8ZRez0pQ/GA3+A7/I0iqKcxH7WFlLOuwFOf2hNjkzEQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=oIS3vrtu; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=GE+rteYJ;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=M+Kugc7o
 x2Sme1cj2c4C2xn69krCAd0C+QbJSmCxABI=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=oIS3vrtuUKs9jTCXAV59eWjOkQtGQx7vVD8
 PKfTu2zhIxNQUhL5cpV0+V0UkrUy2z02lVLfZ8fjIDEqurqw2NvUSVNOxs+CJLOOtptsmQ
 xnKMcX+ICQ9XVNabPqjdbHQO8IkqT38+M/Jw22VEfwvU5+2t5Q79lhP2D4x/VrFjM5MLQD
 MpwAYf3WTByng8eUmClMxZP9XWW2vRQ2HJ2M5EY/3tU18cSM6dH6M4g/kosJpqMbrl4eLX
 USy1XJ675vuE/NzrlPjWdWRpEmevWy6v09217AsvzyK2FmRN8X/xQZPjiAFXYVOZodRB2e
 RHiwiD7CdBzn0MzjJ0G3+rb1BCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=M+Kugc7ox2Sme1cj2c4C2xn69krCAd0C+QbJSmCxABI=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=GE+rteYJa176H7BCjE
 eDRiByRUD/3DQfvDH4S7CiFbFASO0Hvqr7Gm3Aw5FAgQ92LBo/DnA7fEZRwIZhDhG+AQ==
Received: by mx2.catap.net (OpenSMTPD) id c02ffc90;
 Thu, 29 Oct 2026 21:46:16 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 4e669965;
 Thu, 29 Oct 2026 21:46:12 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v5 06/26] target/mips: pass env to compute_pagemask
Date: Thu, 29 Oct 2026 21:43:51 +0100
Message-ID: <20261029204609.38989-7-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029204609.38989-1-kirill@korins.ky>
References: <20261029204609.38989-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass the CPU state to compute_pagemask() and update both callers.
This prepares for CPU specific PageMask validation without changing
behavior.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/system/cp0_helper.c | 4 ++--
 target/mips/tcg/system/tlb_helper.c | 2 +-
 target/mips/tcg/tcg-internal.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 33fb7365d7..3fc55314a8 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -882,7 +882,7 @@ void HELPER(mtc0_memorymapid)(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-uint32_t compute_pagemask(uint32_t val)
+uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val)
 {
     /* Don't care MASKX as we don't support 1KB page */
     uint32_t mask = extract32(val, CP0PM_MASK, 16);
@@ -899,7 +899,7 @@ uint32_t compute_pagemask(uint32_t val)
 
 void HELPER(mtc0_pagemask)(CPUMIPSState *env, target_ulong arg1)
 {
-    env->CP0_PageMask = compute_pagemask(arg1);
+    env->CP0_PageMask = compute_pagemask(env, arg1);
 }
 
 void HELPER(mtc0_pagegrain)(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 08b978b3f5..4df557b457 100644
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
index 9f230e757d..8fb96284df 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -45,7 +45,7 @@ bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
 void mmu_init(CPUMIPSState *env, const mips_def_t *def);
 
-uint32_t compute_pagemask(uint32_t val);
+uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val);
 
 void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
 uint32_t cpu_mips_get_random(CPUMIPSState *env);
-- 
2.56.0


