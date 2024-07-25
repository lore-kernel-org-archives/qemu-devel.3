Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229F6C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Mb-0002Xn-48; Thu, 25 Jul 2024 19:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MW-0002K0-OP; Thu, 25 Jul 2024 19:59:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MU-0001hG-Sz; Thu, 25 Jul 2024 19:59:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70d1dadd5e9so422512b3a.2; 
 Thu, 25 Jul 2024 16:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951945; x=1722556745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=No4XG6t6wkH9PxiFN/jhvxdmpl9tgi1IP4LVoGa+/Y8=;
 b=IOyEJvzRuBnY56U+hPige7Ue7sZ/4VinCcb2ZefCewp8tUx8IFjaVCOuClaqEdlGJh
 oRhnSgF1aTz8PMEtkRoXWhOr4UXv79BdMaaCYTJ48Yz8dxhhwJqC+8eAmR0MUbb8K61D
 k1IwzAvrM47TjLGe7Avn5nEuVl9zLDXwUKAmPzbqxWpqaaHQ5crZ7Uj5vnqGntSO0Q/Z
 8l6Syn70d04oHsxzArvKo/hCEUK5r5x6tTHAgSfVRZn94DELc0qr466tg+uQR3Y0JaNZ
 jt4HzuPFaIF/3nB8DsuzyvfuHQqu/U4hwDLKtCUiuP0MY1nDd72oZXwwuasJvhhsbKj5
 V3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951945; x=1722556745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=No4XG6t6wkH9PxiFN/jhvxdmpl9tgi1IP4LVoGa+/Y8=;
 b=xC6WH5/2/EvFX0BqAnv8oQrHt9nFMzmBMA8ILaQtyp6xQAMaFcciakZ4YKrPuLBuVF
 TAaB9ZERDajC4wKzFGvMCfoPi+LTugxlyg5p95YWxc5e13XpOwboiseG5XYs4R4Ir+0q
 ciBbdwLRSFHVsttqH1N5ySudjbgGjxw578o/26EPJD3DWlrmpymj/r6dvCBSG49GoI1k
 p5aA/uYb+RyZdZoCAz8WxQGdtusNpmsZixA6j1dax/dN8PjSTTFJ87H+O21FPbXCyZ2q
 Rbzz3zaDhUx+WwMjHu9EdKPHpvPjZvWTtOEV4JFBHIWuSZBVRKBNTnFNNN1L8zpBTk99
 F2bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzAjuWa0ffr84/znhSPc3r5QKeITwj775GTZh7ze4koW1XvJ7zU6uWfPGgirUD23ZLeFY2Y0FUAxgdlbGetXzFD9Eb
X-Gm-Message-State: AOJu0YwN4VseO1rL4j7lI5DP/cUi3tAZZrvEg/Z0q4vns2HW4+dwcmvn
 bY4amuDCP8uqUeRGu9JIWGMYKwK/Szp3DsVf6sLOfZZit4yb6/lmwb3xlg==
X-Google-Smtp-Source: AGHT+IF5zh+8aNpU6OpGKgOyeG0Oj9yqRdBNZmZ0cKbNK5q2K9XuYqH4/4YmgZjTDVP9Bj/A7BEk5Q==
X-Received: by 2002:a05:6a20:3504:b0:1be:c262:9c0d with SMTP id
 adf61e73a8af0-1c47b475d0emr3142405637.44.1721951944987; 
 Thu, 25 Jul 2024 16:59:04 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 80/96] target/ppc/mmu_common.c: Inline and remove
 ppc6xx_tlb_pte_check()
Date: Fri, 26 Jul 2024 09:53:53 +1000
Message-ID: <20240725235410.451624-81-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

This function is only called once and we can make the caller simpler
by inlining it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 71 +++++++++++++----------------------------
 1 file changed, 22 insertions(+), 49 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index b2993e8563..784e833ff2 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -91,33 +91,6 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
     return nr;
 }
 
-static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
-                                target_ulong pte1, int pteh,
-                                MMUAccessType access_type, bool nx)
-{
-    /* Check validity and table match */
-    if (!pte_is_valid(pte0) || ((pte0 >> 6) & 1) != pteh ||
-        (pte0 & PTE_PTEM_MASK) != ctx->ptem) {
-        return -1;
-    }
-    /* all matches should have equal RPN, WIMG & PP */
-    if (ctx->raddr != (hwaddr)-1ULL &&
-        (ctx->raddr & PTE_CHECK_MASK) != (pte1 & PTE_CHECK_MASK)) {
-        qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
-        return -3;
-    }
-    /* Keep the matching PTE information */
-    ctx->raddr = pte1;
-    ctx->prot = ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, nx);
-    if (check_prot_access_type(ctx->prot, access_type)) {
-        qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
-        return 0;
-    } else {
-        qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
-        return -2;
-    }
-}
-
 /* Software driven TLB helpers */
 
 static int ppc6xx_tlb_check(CPUPPCState *env,
@@ -149,32 +122,32 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
                       tlb->EPN, eaddr, tlb->pte1,
                       access_type == MMU_DATA_STORE ? 'S' : 'L',
                       access_type == MMU_INST_FETCH ? 'I' : 'D');
-        switch (ppc6xx_tlb_pte_check(ctx, tlb->pte0, tlb->pte1,
-                                     0, access_type, nx)) {
-        case -2:
-            /* Access violation */
-            ret = -2;
-            best = nr;
-            break;
-        case -1: /* No match */
-        case -3: /* TLB inconsistency */
-        default:
-            break;
-        case 0:
-            /* access granted */
-            /*
-             * XXX: we should go on looping to check all TLBs
-             *      consistency but we can speed-up the whole thing as
-             *      the result would be undefined if TLBs are not
-             *      consistent.
-             */
+        /* Check validity and table match */
+        if (!pte_is_valid(tlb->pte0) || ((tlb->pte0 >> 6) & 1) != 0 ||
+            (tlb->pte0 & PTE_PTEM_MASK) != ctx->ptem) {
+            continue;
+        }
+        /* all matches should have equal RPN, WIMG & PP */
+        if (ctx->raddr != (hwaddr)-1ULL &&
+            (ctx->raddr & PTE_CHECK_MASK) != (tlb->pte1 & PTE_CHECK_MASK)) {
+            qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
+            /* TLB inconsistency */
+            continue;
+        }
+        /* Keep the matching PTE information */
+        best = nr;
+        ctx->raddr = tlb->pte1;
+        ctx->prot = ppc_hash32_prot(ctx->key, tlb->pte1 & HPTE32_R_PP, nx);
+        if (check_prot_access_type(ctx->prot, access_type)) {
+            qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
             ret = 0;
-            best = nr;
-            goto done;
+            break;
+        } else {
+            qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
+            ret = -2;
         }
     }
     if (best != -1) {
-done:
         qemu_log_mask(CPU_LOG_MMU, "found TLB at addr " HWADDR_FMT_plx
                       " prot=%01x ret=%d\n",
                       ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
-- 
2.45.2


