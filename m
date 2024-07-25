Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C1CC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8N9-0005i3-7L; Thu, 25 Jul 2024 19:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mm-0003IS-VJ; Thu, 25 Jul 2024 19:59:26 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ml-0001ke-3H; Thu, 25 Jul 2024 19:59:24 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2cdadce1a57so317210a91.2; 
 Thu, 25 Jul 2024 16:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951961; x=1722556761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cj3Rd/wqAyTIg8EMETm09sD1i676BpPrcld+q2ucZVU=;
 b=Ijlkq+izkYbAgPIv47qi9gllH+7gXhVK+pJ9nhHKaWTgA5kX126s2sgriqgAxRdI67
 7qggzT5+WvCPGMA/p0cq4omgV7ieSTApH9YoxYfq/kdfRGqmv5ee1XdK4UtGdMuoSAv7
 p9y1xkQXYVymU/00bfOQhFELBjm8fs23mnzGjIYa+THSS/0KZksSam7QvrsEAg7x3Iy3
 vtWxqqLXBm70ZK/Q1ZEwgqOmOQbcseW4vfJPRFKsXeMJSJQgsN5VRe3ATfJf41eh9l/Y
 D63ZF4EO9LjIAaFLrTI+9Z9CgCtwlUicbdgTdN3TtAI0MJZlEwJ1kFHarrF2+rTO2rjo
 +sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951961; x=1722556761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cj3Rd/wqAyTIg8EMETm09sD1i676BpPrcld+q2ucZVU=;
 b=r67MkVYwHPbkaU2CLYsMH4k5eNrTizsAYTBrZEL4k8nwhRmuS9Wy2uYgHBx2xr1MUe
 d/6E+rwkVr5+bDYx1FsO59k/Vk0/V2yPTctVkw/slE8vZmSuYj22YvVQpBqh41w2bqKe
 oAP5fHDVoSoDK14aqSaulZUwDbKDqcYNcF5Dt+C9nM6nCTy0I0JY/UbUykCw0g9dh/U2
 98mR6bePIV8pJvAckCCJw2Rsgw0DJpNliLcuhCiMmwSVGn/a8Fw7Po8B11/sv/yRfmnS
 gZxPASuDV3IaOkcrM5jFL7iloE7EKcQbDDRWRS51mJvMF1yXEsqtKHIcb37qICIUdOCh
 BoVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUebH4tSJ2orlUgHDtJBz5mCnWHHb7D5ej8ohB2HMBGD0U1o15DkCDHsyjm5DBmVd0m4misB8yKRw==@nongnu.org
X-Gm-Message-State: AOJu0Yxt1+XvODmqQp85hCoduLXMT0woodcTvsT9EvGl1kYZHwofVsog
 hsEpGli+Cj690DGKj28s3Qn9sJgKvSVJsF49YpoaVoi/dVTPTZIbfCiXlQ==
X-Google-Smtp-Source: AGHT+IHCWEvVLHrYk7Vp5BpI4Y0QFb/rZv0G+YbfCtC9+tc7GOk79BESUk7MUde1X2iINca93YlCkw==
X-Received: by 2002:a17:90b:2dc3:b0:2c9:9fdf:f72e with SMTP id
 98e67ed59e1d1-2cf238cc984mr4838088a91.26.1721951960642; 
 Thu, 25 Jul 2024 16:59:20 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 85/96] target/ppc/mmu_common.c: Remove key field from mmu_ctx_t
Date: Fri, 26 Jul 2024 09:53:58 +1000
Message-ID: <20240725235410.451624-86-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

Pass it as a function parameter and remove it from mmu_ctx_t.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index fe321ab49c..be09c3b1a3 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -41,7 +41,6 @@
 typedef struct {
     hwaddr raddr;      /* Real address             */
     int prot;          /* Protection bits          */
-    int key;           /* Access key               */
 } mmu_ctx_t;
 
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
@@ -95,7 +94,7 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
 static int ppc6xx_tlb_check(CPUPPCState *env,
                             mmu_ctx_t *ctx, target_ulong eaddr,
                             MMUAccessType access_type, target_ulong ptem,
-                            bool nx)
+                            bool key, bool nx)
 {
     ppc6xx_tlb_t *tlb;
     target_ulong *pte1p;
@@ -140,7 +139,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
         /* Keep the matching PTE information */
         best = nr;
         ctx->raddr = tlb->pte1;
-        ctx->prot = ppc_hash32_prot(ctx->key, tlb->pte1 & HPTE32_R_PP, nx);
+        ctx->prot = ppc_hash32_prot(key, tlb->pte1 & HPTE32_R_PP, nx);
         if (check_prot_access_type(ctx->prot, access_type)) {
             qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
             ret = 0;
@@ -295,13 +294,14 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
 }
 
 static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                       target_ulong eaddr, hwaddr *hashp,
+                                       target_ulong eaddr,
+                                       hwaddr *hashp, bool *keyp,
                                        MMUAccessType access_type, int type)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
     target_ulong vsid, sr, pgidx, ptem;
-    bool pr, ds, nx;
+    bool key, pr, ds, nx;
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) == 0) {
@@ -312,7 +312,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     pr = FIELD_EX64(env->msr, MSR, PR);
 
     sr = env->sr[eaddr >> 28];
-    ctx->key = ppc_hash32_key(pr, sr);
+    key = ppc_hash32_key(pr, sr);
+    *keyp = key;
     ds = sr & SR32_T;
     nx = sr & SR32_NX;
     vsid = sr & SR32_VSID;
@@ -329,7 +330,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     ptem = (vsid << 7) | (pgidx >> 10); /* Virtual segment ID | API */
 
     qemu_log_mask(CPU_LOG_MMU, "pte segment: key=%d ds %d nx %d vsid "
-                  TARGET_FMT_lx "\n", ctx->key, ds, nx, vsid);
+                  TARGET_FMT_lx "\n", key, ds, nx, vsid);
     if (!ds) {
         /* Check if instruction fetch is allowed, if needed */
         if (type == ACCESS_CODE && nx) {
@@ -343,7 +344,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         *hashp = hash;
 
         /* Software TLB search */
-        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, nx);
+        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, key, nx);
     }
 
     /* Direct-store segment : absolutely *BUGGY* for now */
@@ -367,8 +368,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     case ACCESS_EXT: /* eciwx or ecowx */
         return -4;
     }
-    if ((access_type == MMU_DATA_STORE || ctx->key != 1) &&
-        (access_type == MMU_DATA_LOAD || ctx->key != 0)) {
+    if ((access_type == MMU_DATA_STORE || !key) &&
+        (access_type == MMU_DATA_LOAD || key)) {
         ctx->raddr = eaddr;
         return 2;
     }
@@ -709,6 +710,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
     CPUPPCState *env = &cpu->env;
     mmu_ctx_t ctx;
     hwaddr hash = 0; /* init to 0 to avoid used uninit warning */
+    bool key;
     int type, ret;
 
     if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
@@ -726,7 +728,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
     }
 
     ctx.prot = 0;
-    ret = mmu6xx_get_physical_address(env, &ctx, eaddr, &hash,
+    ret = mmu6xx_get_physical_address(env, &ctx, eaddr, &hash, &key,
                                       access_type, type);
     if (ret == 0) {
         *raddrp = ctx.raddr;
@@ -778,7 +780,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
             env->spr[SPR_DMISS] = eaddr;
             env->spr[SPR_DCMP] |= 0x80000000;
 tlb_miss:
-            env->error_code |= ctx.key << 19;
+            env->error_code |= key << 19;
             env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
                                   get_pteg_offset32(cpu, hash);
             env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
-- 
2.45.2


