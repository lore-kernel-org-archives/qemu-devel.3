Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37BA606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=V5fdVceP;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=LQahFd57
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWYv-0008LE-Nt; Sun, 01 Nov 2026 09:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX7-0006ab-DY
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:42 -0500
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX4-00084I-Iy
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=h05pLce
 z9t4Z5KWk01C/afoeEQZEw2H2bOPfRTKtTJN3MFSGl5N44CXT0qsKSM4PPUp4DGqZ9sGXQ
 JjRs+4X5INur9UmR+3V06yzk6JxW3YiqLq9MxMupvyq1R7r4K180/1IzuruMrfhUzlqLAp
 aoNjrDEzDroJ3tuJMryxR2cVEi/yh29eJDtlsHjk/+kSP14xEqAchFcp1PC2ZgMifqqn/b
 KeH2MjgzXGNn4yc5ZGfMY5aXJqDLstom9UZBiqJdJnmCWe5Tp+aiKz+vnIVLQ+Ac+j2Zg2
 XpOeNxY/s3ujgkwICMbLNZbyAQKH+Rl9oh4Y1yBdBYyqQu0FkgLygQw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=M
 +Kugc7ox2Sme1cj2c4C2xn69krCAd0C+QbJSmCxABI=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=HnL0ExaqCFy5THVFq55PdeRh0sshM4EbyEUqrcx96g/Wn8TnsX0CTW6AaMGtnwjB7rX9
 DZ/h/wamddLKSZl02e+/KQGYjgRkyDELgD1qT/kqtyrkxc1jDw3Py6+r767rXuJWCIq4Zz
 BrQul6gc6V08ozXSx76cViAO0e3ox2sYHwKDrhftTENflt0SktnGm1O9YJgoITli6QSUnR
 EPZH/3TM8CKp1ae5rEW1HXwHdNofDULfziddYdcx+9TTkG00GuDEeMpWmS8CuDWOw0neVV
 cw3RP/hSGU2NEgxP0+wXB4fY7c/YgmseWtr1KXqV18A5W/E5JiP96b9NJ0GiBdsw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=V5fdVceP; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=LQahFd57;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=M+Kugc7o
 x2Sme1cj2c4C2xn69krCAd0C+QbJSmCxABI=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=V5fdVcePMWK+BxC+NmNZfp3A20tbD4KoJqn
 uIU9f/XYs04ypVbUrWdG+cGsJhGMGXxSFofQi7hEaLZx7uggmg6Tr1t64lk1CFn5V8oZ3y
 tHLdowJ5j/yfWXhywucwSEQSt0ONcxEUCEHLKwV+oCG1U82jM4+rKS8WA9quEw6XUDMn6h
 IV6TR+7sm5kxnVe7z+EvDEGa6iMdBswTRhd4QHYp8Rt7umBXUtrmpqAuDGA2x3dTOHhdL/
 z9OTM2FE6DEwBqboLr/BMjiOR29vJIMEuH1ReLwmTY2xqYKiUbkmN9eXQKn4LxJWI/EVh7
 nj3J2iGcjyVeY1j9PU1/HcUO/Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=M+Kugc7ox2Sme1cj2c4C2xn69krCAd0C+QbJSmCxABI=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=LQahFd57RltEeodvG8
 zQc2F2ywDTQmmBfWbK/0TYgPEACewznGlHzSNphIE0j7T9PQNYElSHsA1ruYKxUBX8CQ==
Received: by mx2.catap.net (OpenSMTPD) id 8562dead;
 Sun, 1 Nov 2026 15:27:34 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 010b431b;
 Sun, 1 Nov 2026 15:27:30 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 06/26] target/mips: pass env to compute_pagemask
Date: Sun,  1 Nov 2026 15:23:22 +0100
Message-ID: <20261101142723.41346-7-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101142723.41346-1-kirill@korins.ky>
References: <20261101142723.41346-1-kirill@korins.ky>
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


