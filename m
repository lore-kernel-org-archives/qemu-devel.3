Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A3DC3DA40
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHbY-0002JD-To; Thu, 23 May 2024 19:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHar-0007P0-QV; Thu, 23 May 2024 19:11:30 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHan-0006Kd-GE; Thu, 23 May 2024 19:11:28 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f4d6b7168eso3009731b3a.2; 
 Thu, 23 May 2024 16:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505880; x=1717110680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEWlLb8MSUwetJk+790M+ZhQqJL6mhNi8qXFxdtpSOk=;
 b=IuTHkm+7/gKmtdNm/rHbS0I5fHhBQq5x1h8Qgj74CLJvD/+t39BHWAR5oKWURYGFXI
 WImIUji1aT8SPsZ92e+xw2cFb3Pl2e0a/UbieOZiv/0VHaDsSDlGqCitsX6UBzVVfpnh
 ytFZkLBxSFZijRh2P1R+yOF+IggaP3UDdAj4j9vUMdVu7TOBJtshQ6br+LEg4VRIaaeH
 OwKOn6TjTWcAbkQRz6CyYsbO6BKTQVAZ+hnELUwcKrcGMHbvQWXR6SE8PwshI1uqJMOP
 4y0siYdFBprAg2R80V3WVUjucLV+XkwxXGASltnAnR5wIZ4tEkNtI075Lq8maAcEeGrg
 kPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505880; x=1717110680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZEWlLb8MSUwetJk+790M+ZhQqJL6mhNi8qXFxdtpSOk=;
 b=ULXvYTMk+YBD1bDJXgFhjiwHLMtjN7Pw1I3h5nOXKyqJsj3A6J5RzhcqgPyo0Vfiq3
 za5tnyOD+PA5dzKUGgXrnRFeYPcYFbYoafMPaJejOqjIX0Y8868aYNG2+ltoI2s0LBjL
 66+PjooWsLu9Kf/0fUgGtRQWLLCzK6HWOaZNOYFdgx+03yC4PN94viOYOAGXWIjMAUQ0
 HETM6BN8ZVgkTAnCDl02lsyimIlBga/1z5lqpNXvfB9YAb96kvfUeVGmrNx46vP7OtMu
 LTi3FoB7YsxGdo6matgbBM5WGC1tVOhZT28IjP5aUMsP9qTBH1WA7+P6bZY4cPZql9ET
 qK0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1tBjeoZVfW+V5ZEg1QB2yNpujWb3W6EvYCPzw49QbuzxTWhXOJUZFI1Vn7kaTTgEC/8k3SyqunLm3UAEKax8bmMp4
X-Gm-Message-State: AOJu0Yx+xWmkJO18SBqlh6eGNmYrXVksN04lu6FsZNRZb3jbVqhpq31/
 QwBMTFKBlqs2mIVoKb/NVDbZ8rBNOJ9QgzqkD5nO6sF5jlJcPH7NXr+eyA==
X-Google-Smtp-Source: AGHT+IGx6Q4Tkbpg+bXl2FvxIB8R3MYG2YUdxLgYPEmov9V2ZXF/rPK+ND/0hSSJdhi4ESssz0L1nw==
X-Received: by 2002:a05:6a20:3d88:b0:1a7:5334:fbf3 with SMTP id
 adf61e73a8af0-1b212e575e3mr1062026637.55.1716505879737; 
 Thu, 23 May 2024 16:11:19 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:11:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 66/72] target/ppc: Remove id_tlbs flag from CPU env
Date: Fri, 24 May 2024 09:07:39 +1000
Message-ID: <20240523230747.45703-67-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
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

This flag for split instruction/data TLBs is only set for 6xx soft TLB
MMU model and not used otherwise so no need to have a separate flag
for that.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pegasos2.c        |  2 +-
 target/ppc/cpu.h         |  5 ++++-
 target/ppc/cpu_init.c    | 19 +++++--------------
 target/ppc/helper_regs.c |  1 -
 target/ppc/mmu_common.c  | 10 ++--------
 target/ppc/mmu_helper.c  | 12 ++----------
 6 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index c22e8b336d..c1bd8dfa21 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -985,7 +985,7 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
                           cpu->env.icache_line_size);
     qemu_fdt_setprop_cell(fdt, cp, "i-cache-line-size",
                           cpu->env.icache_line_size);
-    if (cpu->env.id_tlbs) {
+    if (ppc_is_split_tlb(cpu)) {
         qemu_fdt_setprop_cell(fdt, cp, "i-tlb-sets", cpu->env.nb_ways);
         qemu_fdt_setprop_cell(fdt, cp, "i-tlb-size", cpu->env.tlb_per_way);
         qemu_fdt_setprop_cell(fdt, cp, "d-tlb-sets", cpu->env.nb_ways);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e201b7f6c2..95cc11dff7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1281,7 +1281,6 @@ struct CPUArchState {
     int tlb_per_way; /* Speed-up helper: used to avoid divisions at run time */
     int nb_ways;     /* Number of ways in the TLB set */
     int last_way;    /* Last used way used to allocate TLB in a LRU way */
-    int id_tlbs;     /* If 1, MMU has separated TLBs for instructions & data */
     int nb_pids;     /* Number of available PID registers */
     int tlb_type;    /* Type of TLB we're dealing with */
     ppc_tlb_t tlb;   /* TLB is optional. Allocate them only if needed */
@@ -2897,6 +2896,10 @@ static inline void booke206_fixed_size_tlbn(CPUPPCState *env, const int tlbn,
     tlb->mas1 |= ((uint32_t)tsize) << MAS1_TSIZE_SHIFT;
 }
 
+static inline bool ppc_is_split_tlb(PowerPCCPU *cpu)
+{
+    return cpu->env.tlb_type == TLB_6XX;
+}
 #endif
 
 static inline bool msr_is_64bit(CPUPPCState *env, target_ulong msr)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8cfaee61d9..9401eb28c3 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2137,7 +2137,6 @@ static void init_proc_405(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = 64;
     env->nb_ways = 1;
-    env->id_tlbs = 0;
     env->tlb_type = TLB_EMB;
 #endif
     init_excp_4xx(env);
@@ -2211,7 +2210,6 @@ static void init_proc_440EP(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = 64;
     env->nb_ways = 1;
-    env->id_tlbs = 0;
     env->tlb_type = TLB_EMB;
 #endif
     init_excp_BookE(env);
@@ -2311,7 +2309,6 @@ static void init_proc_440GP(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = 64;
     env->nb_ways = 1;
-    env->id_tlbs = 0;
     env->tlb_type = TLB_EMB;
 #endif
     init_excp_BookE(env);
@@ -2386,7 +2383,6 @@ static void init_proc_440x5(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = 64;
     env->nb_ways = 1;
-    env->id_tlbs = 0;
     env->tlb_type = TLB_EMB;
 #endif
     init_excp_BookE(env);
@@ -2754,7 +2750,6 @@ static void init_proc_e200(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = 64;
     env->nb_ways = 1;
-    env->id_tlbs = 0;
     env->tlb_type = TLB_EMB;
 #endif
     init_excp_e200(env, 0xFFFF0000UL);
@@ -2874,7 +2869,6 @@ static void init_proc_e500(CPUPPCState *env, int version)
     /* Memory management */
     env->nb_pids = 3;
     env->nb_ways = 2;
-    env->id_tlbs = 0;
     switch (version) {
     case fsl_e500v1:
         tlbncfg[0] = register_tlbncfg(2, 1, 1, 0, 256);
@@ -6927,20 +6921,17 @@ static void init_ppc_proc(PowerPCCPU *cpu)
     }
     /* Allocate TLBs buffer when needed */
 #if !defined(CONFIG_USER_ONLY)
-    if (env->nb_tlb != 0) {
-        int nb_tlb = env->nb_tlb;
-        if (env->id_tlbs != 0) {
-            nb_tlb *= 2;
-        }
+    if (env->nb_tlb) {
         switch (env->tlb_type) {
         case TLB_6XX:
-            env->tlb.tlb6 = g_new0(ppc6xx_tlb_t, nb_tlb);
+            /* 6xx has separate TLBs for instructions and data hence times 2 */
+            env->tlb.tlb6 = g_new0(ppc6xx_tlb_t, 2 * env->nb_tlb);
             break;
         case TLB_EMB:
-            env->tlb.tlbe = g_new0(ppcemb_tlb_t, nb_tlb);
+            env->tlb.tlbe = g_new0(ppcemb_tlb_t, env->nb_tlb);
             break;
         case TLB_MAS:
-            env->tlb.tlbm = g_new0(ppcmas_tlb_t, nb_tlb);
+            env->tlb.tlbm = g_new0(ppcmas_tlb_t, env->nb_tlb);
             break;
         }
         /* Pre-compute some useful values */
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 16b43702d5..02076e96fb 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -730,7 +730,6 @@ void register_6xx_7xx_soft_tlb(CPUPPCState *env, int nb_tlbs, int nb_ways)
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = nb_tlbs;
     env->nb_ways = nb_ways;
-    env->id_tlbs = 1;
     env->tlb_type = TLB_6XX;
     spr_register(env, SPR_DMISS, "DMISS",
                  SPR_NOACCESS, SPR_NOACCESS,
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 34200d9cb1..78bdbd506c 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -128,8 +128,8 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
     nr = (eaddr >> TARGET_PAGE_BITS) & (env->tlb_per_way - 1);
     /* Select TLB way */
     nr += env->tlb_per_way * way;
-    /* 6xx have separate TLBs for instructions and data */
-    if (is_code && env->id_tlbs == 1) {
+    /* 6xx has separate TLBs for instructions and data */
+    if (is_code) {
         nr += env->nb_tlb;
     }
 
@@ -1065,13 +1065,7 @@ static void mmu6xx_dump_mmu(CPUPPCState *env)
     mmu6xx_dump_BATs(env, ACCESS_INT);
     mmu6xx_dump_BATs(env, ACCESS_CODE);
 
-    if (env->id_tlbs != 1) {
-        qemu_printf("ERROR: 6xx MMU should have separated TLB"
-                    " for code and data\n");
-    }
-
     qemu_printf("\nTLBs                       [EPN    EPN + SIZE]\n");
-
     for (type = 0; type < 2; type++) {
         for (way = 0; way < env->nb_ways; way++) {
             for (entry = env->nb_tlb * type + env->tlb_per_way * way;
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index d4388e66be..238407a7f1 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -45,14 +45,8 @@
 static inline void ppc6xx_tlb_invalidate_all(CPUPPCState *env)
 {
     ppc6xx_tlb_t *tlb;
-    int nr, max;
+    int nr, max = 2 * env->nb_tlb;
 
-    /* LOG_SWTLB("Invalidate all TLBs\n"); */
-    /* Invalidate all defined software TLB */
-    max = env->nb_tlb;
-    if (env->id_tlbs == 1) {
-        max *= 2;
-    }
     for (nr = 0; nr < max; nr++) {
         tlb = &env->tlb.tlb6[nr];
         pte_invalidate(&tlb->pte0);
@@ -308,9 +302,7 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr)
     switch (env->mmu_model) {
     case POWERPC_MMU_SOFT_6xx:
         ppc6xx_tlb_invalidate_virt(env, addr, 0);
-        if (env->id_tlbs == 1) {
-            ppc6xx_tlb_invalidate_virt(env, addr, 1);
-        }
+        ppc6xx_tlb_invalidate_virt(env, addr, 1);
         break;
     case POWERPC_MMU_32B:
         /*
-- 
2.43.0


