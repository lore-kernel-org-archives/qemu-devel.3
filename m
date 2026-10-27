Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1A606A324
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=b4+PK2h2;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=mVfKuzHJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLej9-0001Z1-T6; Tue, 27 Oct 2026 06:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeg0-0005My-9P
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:11 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLefy-0007qu-6I
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=XufaZBx
 rn5LZdN6YRAbFB0wKbOXNFlXgApHMcoTPDi4vskUl4NLrFR95m6T/nDO+l2bCqmlf0g1AR
 B2U0yP5sq+XvEopdXTzAUECcCPGeLT/XjtTsTH+QdwgiFAxno0VIyQxS5r5YvVX+qUjMMn
 BnD0VhlsYxmcxjJ/PzRcsIRFzhYnUeW6i3h2VOQT7w16M5AF/6jyNzb0jZ4pKejpu/eEKY
 sfV3BfTPYeSyOKmJ96CUOlEFA/SRZZuMKmnGiAwI/Oi+lsl1WZbqHe64yRrA3mVh/OiaHM
 kt1fCuUapBmbO8iDQNKC5sc+w/6rzJyHT6ERjgHotCmUub3pLnjUkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=7
 IF3/S8K5m18hBQXC1sXwJEnUKYYXY5Pl2gXWazyr6Q=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=uIvTpiQru1EdpjsiWuEwsNVohO/VDN8AFSAtxpsBvMAOszTo5FTG5Uf2zurrpIqazjtT
 2XDb1NYoGG3sMRhdG3oD88S0QT2HlIEeRs103AD987z1JUvsRgUPvUkpn9i63wLLJKJobM
 ia+2O+QU/wmM4+VNzQHAAQeUwdP8LGO0ODgxgpMrp9NHtF7Ff18nHzN4YqXWvO5pIO/UiS
 SA+EQ+fIUAis4lEjVck+V1U8tPxjTaL1YE9cJAYwk+TY0GaYLwDiLh4a0Okn3XvQPEGfhn
 TY1W15ml6nI1mfJmF4eS6ccT6g+OJJoX5mUlmoq6t25bpVui2qXGatsX52vNBm/Q==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=b4+PK2h2; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=mVfKuzHJ;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=7IF3/S8K
 5m18hBQXC1sXwJEnUKYYXY5Pl2gXWazyr6Q=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=b4+PK2h2ZkUNC/w0ABgXp4zAa2Tvt7DIQk/
 JCiupIQEeRh3UcYg6xhLkEEFPnW8JDr7Nt9T2pGoyX/iwBfbcCAT3kdBPQYUDinp1FHNzb
 yxcIYG5qmMMwNVZZVCnR8GIEEyy4eP8eXuzV2J+c1LlBxVWTV5PRGG5zMiRvu5k0/pz8fB
 tZY8Hf1qZmZeTaIqzwhRng84cy6SPr7PE5eNFxWj9k7vvt5DddMCFrr04OVKV+0iD5p21f
 Z9XXVJS/jzynews6Za3uToo5/7ENbKa8ReMbZ0dvTbQoyqFOk5P+xRlLUV9bg1KuOI1Mjc
 yljpsIummXk1+r8BKVzOXFy0hsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=7IF3/S8K5m18hBQXC1sXwJEnUKYYXY5Pl2gXWazyr6Q=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=mVfKuzHJXmXUuQkGzO
 lT97XoUxgLdginq0tqeqQ8eFyr0aPBFcgIAGc+gszVYLyCU6SbUyyqBfkvD6pe41CECw==
Received: by mx2.catap.net (OpenSMTPD) id 3b10f47b;
 Tue, 27 Oct 2026 11:44:55 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 3f217a6e;
 Tue, 27 Oct 2026 11:44:51 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v4 06/25] target/mips: accept Octeon PageMask encodings
Date: Tue, 27 Oct 2026 11:41:30 +0100
Message-ID: <20261027104433.25720-7-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027104433.25720-1-kirill@korins.ky>
References: <20261027104433.25720-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
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
index 33fb7365d7..046fea6234 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -882,14 +882,19 @@ void HELPER(mtc0_memorymapid)(CPUMIPSState *env, target_ulong arg1)
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


