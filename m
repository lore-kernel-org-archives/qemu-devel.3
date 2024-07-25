Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B356C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Mc-0002fd-VV; Thu, 25 Jul 2024 19:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ma-0002ZV-IQ; Thu, 25 Jul 2024 19:59:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MY-0001hc-90; Thu, 25 Jul 2024 19:59:12 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d23caf8ddso385925b3a.0; 
 Thu, 25 Jul 2024 16:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951948; x=1722556748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaO08R+8F39gfoSuZ4CkZ1qLHXPlBgrMMgGX8DGwSNw=;
 b=WRBd3zRi4WRLQicsrSrHceV09aUvH7A+m6MlEecujBaFKwitziRi21pmq3QViqC0Lk
 jC/AMMvpyoQYc/Du9NvX8RlNMLa/cU8GzfstUhQvCsQOcGGX/lj92XixKc9ggxPr+nqT
 1DCvE8kgAO3XuzFAARDTNUD11gx27jF9pL5dosjuNZvyBybAc3kRlgNfj+1ODo53t5T4
 1NJFIcqVwuVwn9wJUD6sYqEB/uOwOvdWaMp0X+Js4QKRXku0hsKjQX6JtMnZKq8Tp/Xr
 rGHoNp6z7JIOlNyVqEoRX96aas/dooZQZJIDNpvIMUfalzHWlEVETldI7H3zfkviR5OO
 vCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951948; x=1722556748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iaO08R+8F39gfoSuZ4CkZ1qLHXPlBgrMMgGX8DGwSNw=;
 b=Oc1DFoUTJ/+VmJWXPFC/NfwzORro9EZpoBFd51+zVrU5pXizKu7j4w/GAR9N31aynj
 NWGs5qQpy5uNvMkVmmMX28ZjbYSAVp+TGdbHKe9npGzaMoZ359QDTtDPmCZjqEO5IhX9
 xyV+HWRUZ58hT1Vf+92/PRkChWSnHDyJZ+XidkP0VtEfo1RWnnjvbJ16Ys8BqlyqMjFC
 0LeinVF5BvkNwt19MOQTXITFoCQbRPQv7jJdFQonpCzkENILL6V04oOeXrdwYOMroEAO
 Whb9QI0EK/Hj+n412isGHz7KVnURFnsxS5MQGgy401GHkasgqZktO1UzG3W+gR7T9Fdj
 HOnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJqYt5W/D4A9htZsw43W8DH9l1nJqVBW235q5NBnZxI4vD2KEK8rHKx6kNha6ymJ9AQuwND+5rDcWrXUE7DMZNNjoW
X-Gm-Message-State: AOJu0YysoBlfIPiM/Iz64oOiTwEBCXPaidhak27ekwnXXy8g9PadkfDI
 FTTlsOZ7FKzepYk+SJ7wmJd7pHSNIBPgoCrBYjWwzkV6gyViWBSiIJYLPA==
X-Google-Smtp-Source: AGHT+IHvsNbXZf6+oXH01fO10VXzmUmBuEYieHTmcPrCFhEc51kbbWjBDmv0KKNJM2dsQhBZmDT6/g==
X-Received: by 2002:a05:6a20:9148:b0:1c0:f23b:d35a with SMTP id
 adf61e73a8af0-1c47b140b46mr4595635637.5.1721951948038; 
 Thu, 25 Jul 2024 16:59:08 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 81/96] target/ppc/mmu_common.c: Remove ptem field from mmu_ctx_t
Date: Fri, 26 Jul 2024 09:53:54 +1000
Message-ID: <20240725235410.451624-82-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

Instead of passing around ptem in context use it once in the same
function so it can be removed from mmu_ctx_t.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 784e833ff2..339df377e8 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -41,7 +41,6 @@
 typedef struct {
     hwaddr raddr;      /* Real address             */
     int prot;          /* Protection bits          */
-    target_ulong ptem; /* Virtual segment ID | API */
     int key;           /* Access key               */
 } mmu_ctx_t;
 
@@ -95,16 +94,18 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
 
 static int ppc6xx_tlb_check(CPUPPCState *env,
                             mmu_ctx_t *ctx, target_ulong eaddr,
-                            MMUAccessType access_type, bool nx)
+                            MMUAccessType access_type, target_ulong ptem,
+                            bool nx)
 {
     ppc6xx_tlb_t *tlb;
     target_ulong *pte1p;
     int nr, best, way, ret;
+    bool is_code = (access_type == MMU_INST_FETCH);
 
     best = -1;
     ret = -1; /* No TLB found */
     for (way = 0; way < env->nb_ways; way++) {
-        nr = ppc6xx_tlb_getnum(env, eaddr, way, access_type == MMU_INST_FETCH);
+        nr = ppc6xx_tlb_getnum(env, eaddr, way, is_code);
         tlb = &env->tlb.tlb6[nr];
         /* This test "emulates" the PTE index match for hardware TLBs */
         if ((eaddr & TARGET_PAGE_MASK) != tlb->EPN) {
@@ -124,7 +125,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
                       access_type == MMU_INST_FETCH ? 'I' : 'D');
         /* Check validity and table match */
         if (!pte_is_valid(tlb->pte0) || ((tlb->pte0 >> 6) & 1) != 0 ||
-            (tlb->pte0 & PTE_PTEM_MASK) != ctx->ptem) {
+            (tlb->pte0 & PTE_PTEM_MASK) != ptem) {
             continue;
         }
         /* all matches should have equal RPN, WIMG & PP */
@@ -164,6 +165,10 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
             }
         }
     }
+    if (ret == -1) {
+        int r = is_code ? SPR_ICMP : SPR_DCMP;
+        env->spr[r] = ptem;
+    }
 #if defined(DUMP_PAGE_TABLES)
     if (qemu_loglevel_mask(CPU_LOG_MMU)) {
         CPUState *cs = env_cpu(env);
@@ -293,7 +298,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 {
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
-    target_ulong vsid, sr, pgidx;
+    target_ulong vsid, sr, pgidx, ptem;
     bool pr, ds, nx;
 
     /* First try to find a BAT entry if there are any */
@@ -320,7 +325,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
                   access_type == MMU_DATA_STORE, type);
     pgidx = (eaddr & ~SEGMENT_MASK_256M) >> TARGET_PAGE_BITS;
     hash = vsid ^ pgidx;
-    ctx->ptem = (vsid << 7) | (pgidx >> 10);
+    ptem = (vsid << 7) | (pgidx >> 10); /* Virtual segment ID | API */
 
     qemu_log_mask(CPU_LOG_MMU, "pte segment: key=%d ds %d nx %d vsid "
                   TARGET_FMT_lx "\n", ctx->key, ds, nx, vsid);
@@ -339,7 +344,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         /* Initialize real address with an invalid value */
         ctx->raddr = (hwaddr)-1ULL;
         /* Software TLB search */
-        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, nx);
+        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, nx);
     }
 
     /* Direct-store segment : absolutely *BUGGY* for now */
@@ -741,7 +746,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
             cs->exception_index = POWERPC_EXCP_IFTLB;
             env->error_code = 1 << 18;
             env->spr[SPR_IMISS] = eaddr;
-            env->spr[SPR_ICMP] = 0x80000000 | ctx.ptem;
+            env->spr[SPR_ICMP] |= 0x80000000;
             goto tlb_miss;
         case -2:
             /* Access rights violation */
@@ -772,7 +777,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
                 env->error_code = 0;
             }
             env->spr[SPR_DMISS] = eaddr;
-            env->spr[SPR_DCMP] = 0x80000000 | ctx.ptem;
+            env->spr[SPR_DCMP] |= 0x80000000;
 tlb_miss:
             env->error_code |= ctx.key << 19;
             env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
-- 
2.45.2


