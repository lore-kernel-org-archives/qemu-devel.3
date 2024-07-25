Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83243C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ne-00088w-KT; Thu, 25 Jul 2024 20:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mz-00051v-Nq; Thu, 25 Jul 2024 19:59:37 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mx-0001mZ-8r; Thu, 25 Jul 2024 19:59:37 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c9e37bdd6fso304972a91.3; 
 Thu, 25 Jul 2024 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951973; x=1722556773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xm7xCiVZJc1RmG5wDe0/nq3lcVF87IASN6Us99i7PjI=;
 b=b/tba3TX0x++SwgLir8w6Yjna/YgbeKm2RHev62nb1J1enMdd05njuOW22YslTLSH9
 opLom8H8rMVdzihqCE/LsZpsnk8/GWN126eLmsXc/F9aAW6X6NPXm4zuE9V4rVlPA2sx
 a0Mkyvsg6uqtjWjFFMLBnJQM5ITgboH0yvaXpqU4yK0hXIMOuy+ZAPt49MAQKenxkphc
 9qv1b0WsOjSEfOB4CHnIt89lmNzfL9RFyFyVr8WmNm3LvJvKB8ay83g+FepYZrdxYaUA
 +dADba95m4EHZbBuvOclUIiQ1ac+a6+46AnZn3BFxnHzXWgAwpaIDbKEjBgn/Qtf07L7
 qKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951973; x=1722556773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xm7xCiVZJc1RmG5wDe0/nq3lcVF87IASN6Us99i7PjI=;
 b=KgvmDeK1UyQYgY89SO7NWAI7Z0LaD1khjI1xNLX+9euK4c+NbuvjDurE1zEHQmQMsf
 2VlrEgXBXWt37VGdmvkkmS6eNxPH6uvCZ6p81BWpbcGugn1hdsCGkeqNPMFbLFBH52Ew
 1leP1kgeaxqRue3cC9D9gYBWfmpMELvcW9Y34eDQvv0+85EWO5WgayOWoCIZY3MzA9ol
 Ok41MDNBi9ZNHnD6n7dR5ohj5hWo4E/6a4t1N4/2wyQOnp77DrATYe1cuowhrJAWHfy4
 oXNgwwLaqW4Nh8Rfnq3W7dhF9GsVMrhkqZgfoPQzVWSFltUHqR8o2U9tckPpSEXW2xkl
 ucFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFKv7d1LjklDpZSeTj/qdSalSiICMAbxAsu4KZO+XjJ7pcxR+Sa7xCFbiH9iemy6JTjyNCI/CaZeQV08Xuxrl2SFqn
X-Gm-Message-State: AOJu0YxWwQHyIAXiGH7nO7W7RS6pvToubnkmqttrTtacudRo/4XeWudW
 CFTeKTiSsgBD7AvEGZ+Kw2uGlYLzbvxp6kF4P6N+4hQWx4hnl+Hv47a+YQ==
X-Google-Smtp-Source: AGHT+IELd7OKmdjygW5+Y21pyxFPtvIdWwGFHjq98WEzM1hpdMbYWzGzaC3Kx6WkO8D8HYcVVfvlrA==
X-Received: by 2002:a17:90b:3b41:b0:2c9:96fc:ac52 with SMTP id
 98e67ed59e1d1-2cf2eb84d1amr4003754a91.26.1721951972854; 
 Thu, 25 Jul 2024 16:59:32 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 89/96] target/ppc: Remove bat_size_prot()
Date: Fri, 26 Jul 2024 09:54:02 +1000
Message-ID: <20240725235410.451624-90-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
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

There is already a hash32_bat_prot() function that does most if this
and the rest can be inlined. Export hash32_bat_prot() and rename it to
ppc_hash32_bat_prot() to match other functions and use it in
get_bat_6xx_tlb().

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash32.c | 18 +-------------
 target/ppc/mmu-hash32.h | 14 +++++++++++
 target/ppc/mmu_common.c | 52 ++++++++++-------------------------------
 3 files changed, 27 insertions(+), 57 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 160311de87..6f0f0bbb00 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -48,22 +48,6 @@ static target_ulong hash32_bat_size(int mmu_idx,
     return BATU32_BEPI & ~((batu & BATU32_BL) << 15);
 }
 
-static int hash32_bat_prot(PowerPCCPU *cpu,
-                           target_ulong batu, target_ulong batl)
-{
-    int pp, prot;
-
-    prot = 0;
-    pp = batl & BATL32_PP;
-    if (pp != 0) {
-        prot = PAGE_READ | PAGE_EXEC;
-        if (pp == 0x2) {
-            prot |= PAGE_WRITE;
-        }
-    }
-    return prot;
-}
-
 static hwaddr ppc_hash32_bat_lookup(PowerPCCPU *cpu, target_ulong ea,
                                     MMUAccessType access_type, int *prot,
                                     int mmu_idx)
@@ -95,7 +79,7 @@ static hwaddr ppc_hash32_bat_lookup(PowerPCCPU *cpu, target_ulong ea,
         if (mask && ((ea & mask) == (batu & BATU32_BEPI))) {
             hwaddr raddr = (batl & mask) | (ea & ~mask);
 
-            *prot = hash32_bat_prot(cpu, batu, batl);
+            *prot = ppc_hash32_bat_prot(batu, batl);
 
             return raddr & TARGET_PAGE_MASK;
         }
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 5902cf8333..bd75f7d647 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -143,6 +143,20 @@ static inline int ppc_hash32_prot(bool key, int pp, bool nx)
     return nx ? prot : prot | PAGE_EXEC;
 }
 
+static inline int ppc_hash32_bat_prot(target_ulong batu, target_ulong batl)
+{
+    int prot = 0;
+    int pp = batl & BATL32_PP;
+
+    if (pp) {
+        prot = PAGE_READ | PAGE_EXEC;
+        if (pp == 0x2) {
+            prot |= PAGE_WRITE;
+        }
+    }
+    return prot;
+}
+
 typedef struct {
     uint32_t pte0, pte1;
 } ppc_hash_pte32_t;
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index aa002bba35..624ed51a92 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -193,40 +193,13 @@ static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr *raddr, int *prot,
     return ret;
 }
 
-/* Perform BAT hit & translation */
-static inline void bat_size_prot(CPUPPCState *env, target_ulong *blp,
-                                 int *validp, int *protp, target_ulong *BATu,
-                                 target_ulong *BATl)
-{
-    target_ulong bl;
-    int pp, valid, prot;
-
-    bl = (*BATu & BATU32_BL) << 15;
-    valid = 0;
-    prot = 0;
-    if ((!FIELD_EX64(env->msr, MSR, PR) && (*BATu & 0x00000002)) ||
-        (FIELD_EX64(env->msr, MSR, PR) && (*BATu & 0x00000001))) {
-        valid = 1;
-        pp = *BATl & 0x00000003;
-        if (pp != 0) {
-            prot = PAGE_READ | PAGE_EXEC;
-            if (pp == 0x2) {
-                prot |= PAGE_WRITE;
-            }
-        }
-    }
-    *blp = bl;
-    *validp = valid;
-    *protp = prot;
-}
-
 static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                           target_ulong eaddr, MMUAccessType access_type)
+                           target_ulong eaddr, MMUAccessType access_type,
+                           bool pr)
 {
     target_ulong *BATlt, *BATut, *BATu, *BATl;
     target_ulong BEPIl, BEPIu, bl;
-    int i, valid, prot;
-    int ret = -1;
+    int i, ret = -1;
     bool ifetch = access_type == MMU_INST_FETCH;
 
     qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT v " TARGET_FMT_lx "\n", __func__,
@@ -243,20 +216,19 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
         BATl = &BATlt[i];
         BEPIu = *BATu & BATU32_BEPIU;
         BEPIl = *BATu & BATU32_BEPIL;
-        bat_size_prot(env, &bl, &valid, &prot, BATu, BATl);
         qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu "
                       TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func__,
                       ifetch ? 'I' : 'D', i, eaddr, *BATu, *BATl);
-        if ((eaddr & BATU32_BEPIU) == BEPIu &&
-            ((eaddr & BATU32_BEPIL) & ~bl) == BEPIl) {
-            /* BAT matches */
-            if (valid != 0) {
+        bl = (*BATu & BATU32_BL) << 15;
+        if ((!pr && (*BATu & BATU32_VS)) || (pr && (*BATu & BATU32_VP))) {
+            if ((eaddr & BATU32_BEPIU) == BEPIu &&
+                ((eaddr & BATU32_BEPIL) & ~bl) == BEPIl) {
                 /* Get physical address */
                 ctx->raddr = (*BATl & BATU32_BEPIU) |
                     ((eaddr & BATU32_BEPIL & bl) | (*BATl & BATU32_BEPIL)) |
                     (eaddr & 0x0001F000);
                 /* Compute access rights */
-                ctx->prot = prot;
+                ctx->prot = ppc_hash32_bat_prot(*BATu, *BATl);
                 if (check_prot_access_type(ctx->prot, access_type)) {
                     qemu_log_mask(CPU_LOG_MMU, "BAT %d match: r " HWADDR_FMT_plx
                                   " prot=%c%c\n", i, ctx->raddr,
@@ -300,16 +272,16 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
     target_ulong vsid, sr, pgidx, ptem;
-    bool key, pr, ds, nx;
+    bool key, ds, nx;
+    bool pr = FIELD_EX64(env->msr, MSR, PR);
 
     /* First try to find a BAT entry if there are any */
-    if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) == 0) {
+    if (env->nb_BATs &&
+        get_bat_6xx_tlb(env, ctx, eaddr, access_type, pr) == 0) {
         return 0;
     }
 
     /* Perform segment based translation when no BATs matched */
-    pr = FIELD_EX64(env->msr, MSR, PR);
-
     sr = env->sr[eaddr >> 28];
     key = ppc_hash32_key(pr, sr);
     *keyp = key;
-- 
2.45.2


