Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36958C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8NL-0006p1-Qz; Thu, 25 Jul 2024 19:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mq-0003bi-0T; Thu, 25 Jul 2024 19:59:29 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mn-0001l5-Te; Thu, 25 Jul 2024 19:59:27 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7a115c427f1so300856a12.0; 
 Thu, 25 Jul 2024 16:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951964; x=1722556764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63+3E/0oBj6PGrvM9EJeZ7dvuilgClcZhcpKClL7IZg=;
 b=MOUSVjfU59zNMizCdscJ4jkPT4F8RlwHScFRO02JeUnITanJv82mIKg4B2legpB524
 edZX50Eder6MHYCRd8TLDdlRotB9To9Yu0YOMH3xcOTsPQWOWrK1XcCQNo6NNs8YiBO5
 YzTzZI6pK4VdANZywa5sCvH0jwpl71sJJHO3fSlarDPYDPK4ANpUVTsC0eb5RoOATc/X
 DJg9Lg3YY/Ww+8NUjlEZPV7xt+xX4uzqEuXHh9oTyqqHwpovpGfPxqARtZM4x1RSkzmp
 gPXnOXqJHZI3osCzMXsSFJt2OKURk7DrvfQuIkevCbkduEPy4ca8J5yqAaW87S/DmDpf
 IGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951964; x=1722556764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=63+3E/0oBj6PGrvM9EJeZ7dvuilgClcZhcpKClL7IZg=;
 b=qYHbd4MNZ5G+XsoPwo7vEFN/2uZulsZS9m21HjUPLmtPrAikbcuD1wCP4SoiGY3S9p
 hotoP29EWHOCp6JWQm7dKv/4UX7wtQQCkHvBBvSbGpk2YKQ4JzjISJ8dHB6lb4CxU6F6
 Xp+BrnnkEt0bdKh2dvKxtDyHOftK/jS6KdTf2E/IaBhrGL0SqZudliRjShQ8SXl/fKrg
 ajvXJhBJlE46Jp+mu+S1tGij8qTu6u2fhmWfP6psXy1jgnVsF5IjmYNV6eeauowExDSC
 VnB5xBQGwEkv9ChAbtitlKO0HP1DXFWsKabj+2TeaceSa4QxXpzeVYsCTeEl86+C0KcR
 a6Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMbb/2kLYa+g9h2jFuIhVgvSSYmB86MJ3RE8Fx1RqoSZXX/BVMdeBzet1UK+xWvWKnDcprlU4djjhTIKKPogv74SiO
X-Gm-Message-State: AOJu0Yyy1aCCJ17/qx+ymBMMSEHeu1zm1fQrewWbQI8su5e6AaDcZs+H
 z02WEFlrglwk/IOAVtx9Bj3A6LDF08YYH9TbfPieY/BQAwR030Hq/Wnnrw==
X-Google-Smtp-Source: AGHT+IHMWiSQA2QJv7F+WemYQdgDGCTN6iUEw9+z90oZKalIT+Q0QsBBKZSbn9N8J5lbzd/YajqxjA==
X-Received: by 2002:a17:90b:4c50:b0:2c4:dfa6:df00 with SMTP id
 98e67ed59e1d1-2cf2e9ab13dmr3992944a91.8.1721951963682; 
 Thu, 25 Jul 2024 16:59:23 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 86/96] target/ppc/mmu_common.c: Stop using ctx in
 ppc6xx_tlb_check()
Date: Fri, 26 Jul 2024 09:53:59 +1000
Message-ID: <20240725235410.451624-87-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
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

Pass raddr and prot in function parameters instead.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index be09c3b1a3..ede409eb99 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -91,10 +91,9 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
 
 /* Software driven TLB helpers */
 
-static int ppc6xx_tlb_check(CPUPPCState *env,
-                            mmu_ctx_t *ctx, target_ulong eaddr,
-                            MMUAccessType access_type, target_ulong ptem,
-                            bool key, bool nx)
+static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr *raddr, int *prot,
+                            target_ulong eaddr, MMUAccessType access_type,
+                            target_ulong ptem, bool key, bool nx)
 {
     ppc6xx_tlb_t *tlb;
     target_ulong *pte1p;
@@ -102,7 +101,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
     bool is_code = (access_type == MMU_INST_FETCH);
 
     /* Initialize real address with an invalid value */
-    ctx->raddr = (hwaddr)-1ULL;
+    *raddr = (hwaddr)-1ULL;
     best = -1;
     ret = -1; /* No TLB found */
     for (way = 0; way < env->nb_ways; way++) {
@@ -130,17 +129,17 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
             continue;
         }
         /* all matches should have equal RPN, WIMG & PP */
-        if (ctx->raddr != (hwaddr)-1ULL &&
-            (ctx->raddr & PTE_CHECK_MASK) != (tlb->pte1 & PTE_CHECK_MASK)) {
+        if (*raddr != (hwaddr)-1ULL &&
+            (*raddr & PTE_CHECK_MASK) != (tlb->pte1 & PTE_CHECK_MASK)) {
             qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
             /* TLB inconsistency */
             continue;
         }
         /* Keep the matching PTE information */
         best = nr;
-        ctx->raddr = tlb->pte1;
-        ctx->prot = ppc_hash32_prot(key, tlb->pte1 & HPTE32_R_PP, nx);
-        if (check_prot_access_type(ctx->prot, access_type)) {
+        *raddr = tlb->pte1;
+        *prot = ppc_hash32_prot(key, tlb->pte1 & HPTE32_R_PP, nx);
+        if (check_prot_access_type(*prot, access_type)) {
             qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
             ret = 0;
             break;
@@ -152,7 +151,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
     if (best != -1) {
         qemu_log_mask(CPU_LOG_MMU, "found TLB at addr " HWADDR_FMT_plx
                       " prot=%01x ret=%d\n",
-                      ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
+                      *raddr & TARGET_PAGE_MASK, *prot, ret);
         /* Update page flags */
         pte1p = &env->tlb.tlb6[best].pte1;
         *pte1p |= 0x00000100; /* Update accessed flag */
@@ -162,7 +161,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
                 *pte1p |= 0x00000080;
             } else {
                 /* Force page fault for first write access */
-                ctx->prot &= ~PAGE_WRITE;
+                *prot &= ~PAGE_WRITE;
             }
         }
     }
@@ -344,7 +343,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         *hashp = hash;
 
         /* Software TLB search */
-        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, key, nx);
+        return ppc6xx_tlb_check(env, &ctx->raddr, &ctx->prot, eaddr,
+                                access_type, ptem, key, nx);
     }
 
     /* Direct-store segment : absolutely *BUGGY* for now */
-- 
2.45.2


