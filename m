Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0079C606B2D7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n7S7txrG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQlTt-0007qF-Lt; Tue, 10 Nov 2026 08:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xQlTW-0007kQ-O0
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:01:24 -0500
Received: from mail-pj2-x07.google.com ([2607:f8b0:4864:39::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xQlTU-0001NW-K7
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:01:22 -0500
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-3ac749e0719so573380a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 05:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794315678; x=1794920478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iXI8O+stOJ+dDPjGwpwkhNJcK272rCOzlgHLqkUEFk4=;
 b=n7S7txrGi4c5IMGLuN/MtJf3+ghJ6BtHPkWNQSlKcwCx+49OYSd0NY3+Q2tyiV9el/
 2iWNdtm7RwvmR5Ga2Lqf4I7veMvfZwJfWKOEh/VNP+bj97jYce8bopmdYPdMmchX/GFc
 wvnCxypmRKO3487Bn5aS4TCjqhyszz0XxbQV4V+PlLEquW1C534LJ3DAfmJPiGnwkzK6
 LcDITd09GshPaQmlihFI+PzbbfanfoQEh5R/hfiiCmyekssi8XbT1m3o3GhBvTlMsiPT
 as1IHiMEEdWw3Io+ixK5jYHTFaHe3E3ASB/a5+FxNWANE4khGTxq63BFnT6/ZnORThK0
 4XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794315678; x=1794920478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iXI8O+stOJ+dDPjGwpwkhNJcK272rCOzlgHLqkUEFk4=;
 b=ABAMG1lc9RkaWn0WV5rXWEM9yIVTwpXvuiIDWKNHt9mct263nHv8wX0gbELc/Py8VP
 zZYxedHlo1cjTawzX+aStOxHlqhzuSgm07brKlzvw8J+Qq3Y8M2gxdkdWyOgCvQ87jOi
 gmNZ/qMymViOhMH5XcA5duzmHmILL/QWZDM5Haa9rX8/MLwJYF6gsakGMEBg3C9PkERy
 14Yu5H7tCvBbYMSZPQidR3v4UC2nD24/l2R2kI2D93s11XjrzJpsM9edk58HsLKINzjX
 LdygIQMbzXNdXLSx+9R0Q9/rXXVn8sQ3Rs5NzxZmccweYIk/OisysRdZadnbTwXHClby
 fOMg==
X-Gm-Message-State: APuU4Z8Zvo42m/WUO7a+L2E/kIdsaMU/6tLkNgpITQGS3f9z00I3KAYm
 3kNbeoRYIu/H90VSK8o0sI2XLLVLGkyV7X6u5VRt178FBKc/mb02I9mwnW54FWiR
X-Gm-Gg: AYBFou1GIp0NhoHisrsTXaPwihSNYiR9BQ2Y8SLu4lC0u2rZ1JiHzPgOsTAzhoqis77
 Rb/R5Z3afPEtxQKXbfPc02+bn6Owf7yRocTikFQWcStMbKNeHu3sUHvj2icr99ZI+mka8/UL38r
 i64HpGlrC1CG8RBB3F0AIkIdGKbQkzoPrB0pi++qislWK57Jpz25pFPIo6kDK6aD23c/Ze4VKia
 6nE6q3Gjeg2Yn+kQLicrPm2UOCi6BG1Xy0HHBbHn/9C4MH+ueW1zPDpuZ44pCWommylkk7+Ne5J
 Patjv58MJwPUV2RAUlVi6mz7AOm4ydcrUjV25xXgAZ5X7/BHfCOsWoxFtTNcJiudvUwRXTEpROq
 beLFFGmabLVx97vTtJ9yS4/M1P6n0mTCdSYP2JcprOIsSdEMFicWIAcp8OHFGbKZkQO6mbG6xYl
 tjHZRVeWu5AaOa4nkVwbPseBsoT8zHY9+X7+UKFs8biL4DWOkj6E8hiZJlm5KMmUgMu6o+P5kDP
 pUhNyMWayYmPh4ayhMnQv0cZMM2IFsO6pzQaMIXTWb9xxKsXOpGPN1m60saT5sIje8OIKb8npOV
 XKQgdbW160KP26DHTu84suk9zgpmRTk=
X-Received: by 2002:a17:90b:5805:b0:3b0:9183:23ef with SMTP id
 98e67ed59e1d1-3b166ad22f7mr2921932a91.3.1794315677635; 
 Tue, 10 Nov 2026 05:01:17 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:e939:4613:1d28:dfcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b16769b589sm3765567a91.5.2026.11.10.05.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:01:17 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH 1/4] target/i386: mask the PML5 table address taken from CR3
Date: Tue, 10 Nov 2026 13:01:05 +0000
Message-ID: <20261110130108.706228-2-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110130108.706228-1-mdspan.github@gmail.com>
References: <20261110130108.706228-1-mdspan.github@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::7;
 envelope-from=mdspan.github@gmail.com; helo=mail-pj2-x07.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 5-level page walks in mmu_translate() and
x86_cpu_translate_for_debug() take the PML5 table address from CR3
with ~0xfff, which keeps CR3 bits 63:52.  The 4-level walks already
use PG_ADDRESS_MASK.  Use PG_ADDRESS_MASK for the 5-level walks as
well, so that CR3 control bits above the physical address width, such
as the LAM bits 61 and 62, do not become part of the table address.

Signed-off-by: Tim <mdspan.github@gmail.com>
---
 target/i386/helper.c                 | 2 +-
 target/i386/tcg/system/excp_helper.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index cb25018..723e87f 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -297,7 +297,7 @@ bool x86_cpu_translate_for_debug(CPUState *cs, vaddr addr,
             }
 
             if (la57) {
-                pml5e_addr = ((env->cr[3] & ~0xfff) +
+                pml5e_addr = ((env->cr[3] & PG_ADDRESS_MASK) +
                         (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
                 pml5e = x86_ldq_phys(cs, pml5e_addr);
                 if (!(pml5e & PG_PRESENT_MASK)) {
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index 44be98a..6c48ccb 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -173,7 +173,8 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                 /*
                  * Page table level 5
                  */
-                pte_addr = (in->cr3 & ~0xfff) + (((addr >> 48) & 0x1ff) << 3);
+                pte_addr = (in->cr3 & PG_ADDRESS_MASK) +
+                           (((addr >> 48) & 0x1ff) << 3);
                 if (!ptw_translate(&pte_trans, pte_addr)) {
                     return false;
                 }
-- 
2.47.3


