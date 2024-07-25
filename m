Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76AAC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Nm-0000s6-5G; Thu, 25 Jul 2024 20:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8N4-0005Ub-ML; Thu, 25 Jul 2024 19:59:42 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8N3-0001th-1U; Thu, 25 Jul 2024 19:59:42 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7a1215dd114so299289a12.1; 
 Thu, 25 Jul 2024 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951979; x=1722556779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=up67YIHO8e/Pd+K2v5gwq+p55WvdPMk2HgGr2s+CwP8=;
 b=Knqxn32NqG1gKxl29IDNM8a6kx0MfH5nlLZSicZtN7cCWRW1lcbIq5JqRopRX7zShk
 tUdPn0U0piYyMjowZsjSLNhtoxg6eEntGaLzmlrXBU/1YSUz2uKYKMjYYQNcGTq2wJp8
 NwsSCDalUi6chnvi9oi/ABBCj8bICRUzz0NUAU7jkJwZkVLdLWkzqpo1+Ppj7N7C+P+z
 dWikNoVugedrPsRcLPH9snbsHW0SU+FNuJTwcPUrxLf7rxXN6V7QruaZDub1WsfWhTRg
 DbaJbxIaGTTWWxthUDQ6273ZijmRUeQgeMg9WuDzH4D+k/1uoSRuLLr0sU+Yyuq8QizK
 pRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951979; x=1722556779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=up67YIHO8e/Pd+K2v5gwq+p55WvdPMk2HgGr2s+CwP8=;
 b=uDjMEnm4ZlVm/iQBs6kNN5JKgJmwnmMDX3mfI2HbfQ3RSUJ39nQqmouZsO7KK/4Sx5
 A2jY+aOo1r+cr/Ql80ejIDXB1gFbaUinZLFY1+BHjzvdG9xppr2IKOjK5Y5HmFlIXswc
 8Kchwu7p7qZyYIFjbnGu6VSvL3/nt3Ec/ZFTWT9vc/Izui7Q90Zf4Yvz7oMapTmnLkzd
 lIPRX4blhYVIqu5wuS1y8sUI2VVEv2uz/J8vShBJpZnFEnQEv/CHxdTEz/IMzT/DCH20
 ULTjQHMxauHuQ+bAPdIdDLhh2CB33O7lUVwbU4yjoZIUh9qxl92fDH5RW5oVypquoL/y
 1Dvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6OqqFD4YtrzQVNxgQrepcHer+UmvqnNxSRKKiiaBqcC53drOhyDSoj28ZxCghltSICRWy4+Zitdb5Key4RipbZ0KX
X-Gm-Message-State: AOJu0YwqbqgH3lwFfQNy+tEHNYNI11o1Vb3CRJak29lky5Hh8SMEDOYU
 DkVvd7Vl1aQcjEZNC7lG/FqOhWKJ+X9VOFvObcWVb1XQcblZPKxb8BB33g==
X-Google-Smtp-Source: AGHT+IHRuAHGqaVy040s/HSHD3DXwlLaB4e4ZJWWE87kwE/d4cWTaSxlqozYcYfQMsADngiDA4zuTA==
X-Received: by 2002:a17:90b:4d8b:b0:2c9:5a8b:ff7e with SMTP id
 98e67ed59e1d1-2cf2ea2f2cbmr4357357a91.25.1721951978963; 
 Thu, 25 Jul 2024 16:59:38 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 91/96] target/ppc/mmu_common.c: Remove mmu_ctx_t
Date: Fri, 26 Jul 2024 09:54:04 +1000
Message-ID: <20240725235410.451624-92-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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

Completely get rid of mmu_ctx_t after converting the remaining
functions to pass raddr and prot without the context struct.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 4770b43630..60f8736210 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -37,12 +37,6 @@
 
 /* #define DUMP_PAGE_TABLES */
 
-/* Context used internally during MMU translations */
-typedef struct {
-    hwaddr raddr;      /* Real address             */
-    int prot;          /* Protection bits          */
-} mmu_ctx_t;
-
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = env_archcpu(env);
@@ -264,8 +258,8 @@ static int get_bat_6xx_tlb(CPUPPCState *env, hwaddr *raddr, int *prot,
     return ret;
 }
 
-static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                       target_ulong eaddr,
+static int mmu6xx_get_physical_address(CPUPPCState *env, hwaddr *raddr,
+                                       int *prot, target_ulong eaddr,
                                        hwaddr *hashp, bool *keyp,
                                        MMUAccessType access_type, int type)
 {
@@ -277,8 +271,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs &&
-        get_bat_6xx_tlb(env, &ctx->raddr, &ctx->prot, eaddr,
-                        access_type, pr) == 0) {
+        get_bat_6xx_tlb(env, raddr, prot, eaddr, access_type, pr) == 0) {
         return 0;
     }
 
@@ -316,7 +309,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         *hashp = hash;
 
         /* Software TLB search */
-        return ppc6xx_tlb_check(env, &ctx->raddr, &ctx->prot, eaddr,
+        return ppc6xx_tlb_check(env, raddr, prot, eaddr,
                                 access_type, ptem, key, nx);
     }
 
@@ -333,7 +326,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
          * Should make the instruction do no-op.  As it already do
          * no-op, it's quite easy :-)
          */
-        ctx->raddr = eaddr;
+        *raddr = eaddr;
         return 0;
     case ACCESS_CODE: /* No code fetch is allowed in direct-store areas */
     case ACCESS_FLOAT: /* Floating point load/store */
@@ -343,7 +336,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     }
     if ((access_type == MMU_DATA_STORE || !key) &&
         (access_type == MMU_DATA_LOAD || key)) {
-        ctx->raddr = eaddr;
+        *raddr = eaddr;
         return 2;
     }
     return -2;
@@ -681,7 +674,6 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    mmu_ctx_t ctx;
     hwaddr hash = 0; /* init to 0 to avoid used uninit warning */
     bool key;
     int type, ret;
@@ -700,12 +692,9 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
         type = ACCESS_INT;
     }
 
-    ctx.prot = 0;
-    ret = mmu6xx_get_physical_address(env, &ctx, eaddr, &hash, &key,
+    ret = mmu6xx_get_physical_address(env, raddrp, protp, eaddr, &hash, &key,
                                       access_type, type);
     if (ret == 0) {
-        *raddrp = ctx.raddr;
-        *protp = ctx.prot;
         *psizep = TARGET_PAGE_BITS;
         return true;
     } else if (!guest_visible) {
-- 
2.45.2


