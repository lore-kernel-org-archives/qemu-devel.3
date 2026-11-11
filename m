Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA6D606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=pOu0FKLj;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=14b7D7zu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR9R8-00010P-3w; Wed, 11 Nov 2026 09:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qu-0000re-73
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:16 -0500
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qs-0002OU-8v
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=c+CgE9y
 H2s+26sZPciEeEceq7zBsCphUfsuW4gx9GGq+FGDuyvXu/jOfwnTWai4wEKfkdigtAyT/3
 dK/ItPbG5JKaaVizH3eIBqLTC6HggLeSoAvlTmohgW92K01x4SKZoclZ6U6sRU8RkEnAIm
 YtWs+0/hwBgSK24HaiAxzStZl+EWQEXYlJoEEy70xNjKhNAba4o728Y/oDcMg5YtuH97vx
 CO4eVXsCRD8RlE5EJl2o0PAGUQ4z+OsTZjJNiEpa+RcZNJk4i9IR8OMp1NXK0N6LlzTcWM
 7hNZIFCJxs0DbyMbx/IP9tMKnh+Xc8ibTJiDt7B88D83JWuv4V3bgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=H
 Ofjfz98VEeodyhCVEgejepl4nM6Yin3luYS1i3y+os=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=lPh5a7SEMC/BNrmA4nVmOJflUYgKNUGIA7kvPgR4aG2wpEds4KFEtmD5/UGRsJ7ts+Q8
 WTtTBka+aXe+2a7Cop6C9hbKDLYRrH8D0Y2SE12IYzVW1RnjF/2skC6G2hTa0MPnFLaj1p
 LheFYGp22DBDsVSFdeDOMDn8XSXDcNkbHOOF4tEYQeAuWhdOS61sHAidOrCG9H9rUtsQ+O
 k4K8FvwI3Q0Ke1kyWZONsfRh6tBDIHdxVSuYk08N55ogECoK5xqU1uH/nyYMi6CtgPmOlk
 FNI1b1/Su/tsnOHudUw1PDEo/p6JbCxHn6wR1+zTHEBQylKtM42inc3BkE7nQmxw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=pOu0FKLj; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=14b7D7zu;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=HOfjfz98
 VEeodyhCVEgejepl4nM6Yin3luYS1i3y+os=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=pOu0FKLjJnvFKIr2jlk3tiWPnzFVigKcRsV
 RdWGuWlH67lxOhCYYqynS5eSHCy1ApFAe5d7Gh0qkqI4FWTUkvGR5vfMoJn4//h6ozevrG
 6zOEFCvCojvNCp/cBzcsTwx4cG3gxkErDX5WiWoIC5lHXXKbs5aG9kIZW3TvXUqXaBNDF8
 0gvm+DMgdBU8uTxyexKU4sQbgBcY06Q45iG6LYIxOCMrTndQCZyS00z1z8TOM9O//eYe/V
 CRjySYGTo1Vy1YEwm3V7/KlqebjAbLbw5DqKfcDw0Fs+6WwCbD15gihaXK55rZLrYsbwJB
 FZ+QdzshKEqTCGEfZX2XDe+JdZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=HOfjfz98VEeodyhCVEgejepl4nM6Yin3luYS1i3y+os=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=14b7D7zu3ZDAS5e869
 02hhwReSfYDV874RXRQtX8FiUvsor5U5iA0RCE7crF3hUKN2yUAhdakQGDf1EAccjkDQ==
Received: by mx2.catap.net (OpenSMTPD) id cb28390f;
 Wed, 11 Nov 2026 15:36:05 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 48ebfa9d;
 Wed, 11 Nov 2026 15:35:54 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 06/26] target/mips: pass env to compute_pagemask
Date: Wed, 11 Nov 2026 15:32:06 +0100
Message-ID: <20261111143533.1775-7-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111143533.1775-1-kirill@korins.ky>
References: <20261111143533.1775-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:3b:5410::2;
 envelope-from=kirill@korins.ky; helo=mx2.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

Pass the CPU state to compute_pagemask() and update both callers.
This prepares for CPU specific PageMask validation without changing
behavior.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/system/cp0_helper.c | 4 ++--
 target/mips/tcg/system/tlb_helper.c | 2 +-
 target/mips/tcg/tcg-internal.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 5c040837e0..dd4f06bd8e 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -882,7 +882,7 @@ void HELPER(mtc0_memorymapid)(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-uint32_t compute_pagemask(uint32_t val)
+uint32_t compute_pagemask(const CPUMIPSState *env, uint32_t val)
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
index e9416d93a4..b3c0b58ac7 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -878,7 +878,7 @@ refill:
         }
     }
     pw_pagemask = m >> TARGET_PAGE_BITS;
-    pw_pagemask = compute_pagemask(pw_pagemask << CP0PM_MASK);
+    pw_pagemask = compute_pagemask(env, pw_pagemask << CP0PM_MASK);
     pw_entryhi = (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
     {
         target_ulong tmp_entryhi = env->CP0_EntryHi;
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index e055040b09..5e4341003a 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -45,7 +45,7 @@ bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
 void mmu_init(CPUMIPSState *env, const mips_def_t *def);
 
-uint32_t compute_pagemask(uint32_t val);
+uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val);
 
 void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
 uint32_t cpu_mips_get_random(const CPUMIPSState *env);
-- 
2.56.0


