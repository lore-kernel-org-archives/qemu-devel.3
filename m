Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C2BC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8MP-0001o1-K9; Thu, 25 Jul 2024 19:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MH-0001MZ-V0; Thu, 25 Jul 2024 19:58:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MF-0001eb-Dw; Thu, 25 Jul 2024 19:58:52 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2cb5b783c15so306298a91.2; 
 Thu, 25 Jul 2024 16:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951929; x=1722556729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nX6Lsm4o6dTs9bwPh6BsVax+d/K0njHWy4wuZsxBu9o=;
 b=HpqsXZotx6D/YyQSTR4usU+kqGRwV65mVtJ6qrtNGOzS54M7LwINJY4TysQOLrsd0e
 Kd5wvR/0iT88k+vtByDhVImob+pgN0eW/jpJlUuOo9OwxqU17s/qM999SnXvK9vdsxYd
 BgvBX3hbuMr9yF3TeXJK81gVUB7b0zn+FJgYcnaVciFW/c66iOT6XwKSMzByHW1I/oGX
 nM2+2szrN1zH6d98AXrVVJjZF0k/GytBHeAEm9TlXimS5WHoXa154yfA39fUmozlh93q
 FqSUTIJlA2EV4948XHY8UExhj5RYKhjma65ECntK+wrx2YwAvZTmpfqtrq6NjBDcv259
 LehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951929; x=1722556729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nX6Lsm4o6dTs9bwPh6BsVax+d/K0njHWy4wuZsxBu9o=;
 b=FA/2mbw6Jt1Lxl30hHB90Y+wzn2hD6tdNFXBt3ZhqpqfbLF60INtGLI2SnzKDyj1jh
 4fZzSwsWKAwxYp0NH3c5un9GhYuo/GkWne72dfRK+FSx2wdJWRBZaB8XzkK5sy4UrPtg
 tpYrr0++HnxNPBQX6nHbmtn4iPCYWx0oogpmXjzo4K+1tcZnGIJcGDE262hIA2uBa75E
 hFH0jaM4TAgtVdBD6noBRr06bENQVOHb9AUwVx11uNjPrF7K4ZgN/CEVe23w2BzFkAW/
 YGviUXr/Jlr8Nc+XEJXxEyB+ZqkluO4Ri0P5/KBMv3SD/MEm3y9TGWkPhT+1ykIsEyYC
 DPBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyxWhDSMPfbfDQiB97v5FVasScMJJVFgI0U4plHTL5Il5Ei5c4arbpqywXulfHDGM/rQrw3ztkHezL9aE4K4wVIB0N
X-Gm-Message-State: AOJu0YwLBV7tsnI+UrrbmOT8WZO/pTLA9EzO7EbZTBpNk3JgujmFrAgV
 3ZMT1PdKN1QRbFHr4ygQ//83B0h4BRGIfx6hQCN5M5xMcTwwBJ7NKygR4A==
X-Google-Smtp-Source: AGHT+IGOhcIi8u9pkOADy4h4ZS+v2swJ2HprnKNRZ16yt7f3oV9wabSaI+q+TGj5fb8ZsjauSHNc/g==
X-Received: by 2002:a17:90b:3810:b0:2c9:6d07:18f4 with SMTP id
 98e67ed59e1d1-2cf239063c4mr5296152a91.35.1721951929549; 
 Thu, 25 Jul 2024 16:58:49 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 75/96] target/ppc/mmu_common.c: Remove pte_update_flags()
Date: Fri, 26 Jul 2024 09:53:48 +1000
Message-ID: <20240725235410.451624-76-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: BALATON Zoltan <balaton@eik.bme.hu>

This function is used only once, its return value is ignored and one
of its parameter is a return value from a previous call. It is better
to inline it in the caller and remove it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index e3537c63c0..c4902b7632 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -119,39 +119,14 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
     }
 }
 
-static int pte_update_flags(mmu_ctx_t *ctx, target_ulong *pte1p,
-                            int ret, MMUAccessType access_type)
-{
-    int store = 0;
-
-    /* Update page flags */
-    if (!(*pte1p & 0x00000100)) {
-        /* Update accessed flag */
-        *pte1p |= 0x00000100;
-        store = 1;
-    }
-    if (!(*pte1p & 0x00000080)) {
-        if (access_type == MMU_DATA_STORE && ret == 0) {
-            /* Update changed flag */
-            *pte1p |= 0x00000080;
-            store = 1;
-        } else {
-            /* Force page fault for first write access */
-            ctx->prot &= ~PAGE_WRITE;
-        }
-    }
-
-    return store;
-}
-
 /* Software driven TLB helpers */
 
 static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
                             target_ulong eaddr, MMUAccessType access_type)
 {
     ppc6xx_tlb_t *tlb;
-    int nr, best, way;
-    int ret;
+    target_ulong *pte1p;
+    int nr, best, way, ret;
 
     best = -1;
     ret = -1; /* No TLB found */
@@ -204,7 +179,17 @@ done:
                       " prot=%01x ret=%d\n",
                       ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
         /* Update page flags */
-        pte_update_flags(ctx, &env->tlb.tlb6[best].pte1, ret, access_type);
+        pte1p = &env->tlb.tlb6[best].pte1;
+        *pte1p |= 0x00000100; /* Update accessed flag */
+        if (!(*pte1p & 0x00000080)) {
+            if (access_type == MMU_DATA_STORE && ret == 0) {
+                /* Update changed flag */
+                *pte1p |= 0x00000080;
+            } else {
+                /* Force page fault for first write access */
+                ctx->prot &= ~PAGE_WRITE;
+            }
+        }
     }
 #if defined(DUMP_PAGE_TABLES)
     if (qemu_loglevel_mask(CPU_LOG_MMU)) {
-- 
2.45.2


