Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751ADC25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZF-0001Gh-VP; Thu, 23 May 2024 19:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYr-0000Ff-Jp; Thu, 23 May 2024 19:09:33 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYh-0005m6-3K; Thu, 23 May 2024 19:09:23 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f8e98784b3so291208b3a.1; 
 Thu, 23 May 2024 16:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505751; x=1717110551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ot11TpVpbkasVokRcxJIe/oLFQV+xcPxI0fDUvpSNfw=;
 b=FVAW6kxVds6kYuMsB36/1W4qwbx3mPvyasYltEOi+epKYD30gSnTLDenhZN8F+IlA2
 uHyIEOHOZQOM+nVXxOB+bXvKJJz52SDjwPeIQP+ZCjtQidUphHJDFET8QKmH7ABUPxIx
 rilRFW6dHykBZlIsUGSNswFwlwXRTv55D5wlmi2g1Ib70SNxxoQJ5luUaspRU8yLe0pr
 DSQOBHXpeurPR8VhuhU88zIkt5pTrLfMTkMB4kGVFcHbTp8n9P0S2y+Y6HAPlVNfOJpc
 e15gewEwhP+Z5CxffF/Z43PuL3lIOXaLhjMXJcR8WxkkaGEcCli2Xf58BMbRm84lCSyd
 jvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505751; x=1717110551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ot11TpVpbkasVokRcxJIe/oLFQV+xcPxI0fDUvpSNfw=;
 b=ccspooubvp7dHjy1hClG782+JaPQMbRzDkVCk7blx/0+gEgnsSFeF6GSTeTdlAKuqr
 BEmVDbHF7yP+5fTfiLBHeyU+ZWSAp5udw/s2C04B4j+jXGwLCeux7X0x2eHDTGeCSYW/
 SD6az6ZPGfXpd4Xp4K+9rnvTRiOVISRuTlW4t5IWkGO40aM9o09VGClZixnfQS0terhG
 M8Kh79gG3upRaFIBm6T2iu/E65ZoObzWkeVbznLfGfi3buuyQxEEyXFODOwDoo2jCFqY
 lqpd0tuYo9PtFQ8n66vpKuIPc7g1dxgKWcJLFfhc2kdc0r6M/1Eq79OW5isAIaeRHYZT
 wWyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUQexhgqvHRBoElMn8phxwUe12wK6qS8FKXyUpvbddnfMdNZw3CjOoyHYQV3ppREBz9w2aZU2I2AGRMw2YPVB5E37T
X-Gm-Message-State: AOJu0YwyglecSkLdXIm85Cew8+sTQHoWg+4lD76JEmEneax7breclwGf
 3+ZMWUPpQTppKo/h5S6kdCinkPZxbPBi0ljQYST8Nnj4/0ctbU9BJ0Wt3A==
X-Google-Smtp-Source: AGHT+IHk7L0X9lRKIwSJzDSnT0N3jiSy3dNYd74R9tOkGpeEFKsHLVO1ma+7PidWR/EM/2OhwkNfMg==
X-Received: by 2002:a05:6a20:96d3:b0:1ad:3d93:b71e with SMTP id
 adf61e73a8af0-1b212f873b6mr868780637.59.1716505750965; 
 Thu, 23 May 2024 16:09:10 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 23/72] This commit continues adding support for the Branch
 History Rolling Buffer (BHRB) as is provided starting with the P8 processor
 and continuing with its successors. This commit is limited to the recording
 and filtering of taken branches.
Date: Fri, 24 May 2024 09:06:56 +1000
Message-ID: <20240523230747.45703-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

The following changes were made:

  - Enabled functionality on P10 processors only due to
    performance impact seen with P8 and P9 where it is not
    disabled for non problem state branches.
  - Added a BHRB buffer for storing branch instruction and
    target addresses for taken branches
  - Renamed gen_update_cfar to gen_update_branch_history and
    added a 'target' parameter to hold the branch target
    address and 'inst_type' parameter to use for filtering
  - Added TCG code to gen_update_branch_history that stores
    data to the BHRB and updates the BHRB offset.
  - Added BHRB resource initialization and reset functions

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h                       | 17 +++++
 target/ppc/cpu_init.c                  | 37 +++++++++-
 target/ppc/power8-pmu.c                | 33 +++++++++
 target/ppc/power8-pmu.h                |  7 ++
 target/ppc/translate.c                 | 97 ++++++++++++++++++++++++--
 target/ppc/translate/branch-impl.c.inc |  2 +-
 6 files changed, 185 insertions(+), 8 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 195d4be2b7..2f91d7dc33 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -548,6 +548,8 @@ FIELD(MSR, LE, MSR_LE, 1)
                          MMCR2_FC4P0 | MMCR2_FC5P0 | MMCR2_FC6P0)
 
 #define MMCRA_BHRBRD    PPC_BIT(26)         /* BHRB Recording Disable */
+#define MMCRA_IFM_MASK  PPC_BITMASK(32, 33) /* BHRB Instruction Filtering */
+#define MMCRA_IFM_SHIFT PPC_BIT_NR(33)
 
 #define MMCR1_EVT_SIZE 8
 /* extract64() does a right shift before extracting */
@@ -774,6 +776,8 @@ enum {
     POWERPC_FLAG_SMT      = 0x00400000,
     /* Using "LPAR per core" mode  (as opposed to per-thread)                */
     POWERPC_FLAG_SMT_1LPAR = 0x00800000,
+    /* Has BHRB */
+    POWERPC_FLAG_BHRB      = 0x01000000,
 };
 
 /*
@@ -1215,6 +1219,9 @@ struct pnv_tod_tbst {
 #define PPC_CPU_OPCODES_LEN          0x40
 #define PPC_CPU_INDIRECT_OPCODES_LEN 0x20
 
+#define BHRB_MAX_NUM_ENTRIES_LOG2 (5)
+#define BHRB_MAX_NUM_ENTRIES      (1 << BHRB_MAX_NUM_ENTRIES_LOG2)
+
 struct CPUArchState {
     /* Most commonly used resources during translated code execution first */
     target_ulong gpr[32];  /* general purpose registers */
@@ -1311,6 +1318,16 @@ struct CPUArchState {
     int dcache_line_size;
     int icache_line_size;
 
+#ifdef TARGET_PPC64
+    /* Branch History Rolling Buffer (BHRB) resources */
+    target_ulong bhrb_num_entries;
+    intptr_t     bhrb_base;
+    target_ulong bhrb_filter;
+    target_ulong bhrb_offset;
+    target_ulong bhrb_offset_mask;
+    uint64_t bhrb[BHRB_MAX_NUM_ENTRIES];
+#endif
+
     /* These resources are used during exception processing */
     /* CPU model definition */
     target_ulong msr_mask;
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 366ea8568b..1ec84b5ddc 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6142,6 +6142,28 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x8000;
 }
 
+static void bhrb_init_state(CPUPPCState *env, target_long num_entries_log2)
+{
+    if (env->flags & POWERPC_FLAG_BHRB) {
+        if (num_entries_log2 > BHRB_MAX_NUM_ENTRIES_LOG2) {
+            num_entries_log2 = BHRB_MAX_NUM_ENTRIES_LOG2;
+        }
+        env->bhrb_num_entries = 1 << num_entries_log2;
+        env->bhrb_base = (intptr_t)&env->bhrb[0];
+        env->bhrb_offset_mask = (env->bhrb_num_entries * sizeof(uint64_t)) - 1;
+    }
+}
+
+static void bhrb_reset_state(CPUPPCState *env)
+{
+    if (env->flags & POWERPC_FLAG_BHRB) {
+        env->bhrb_offset = 0;
+        env->bhrb_filter = 0;
+        memset(env->bhrb, 0, sizeof(env->bhrb));
+    }
+}
+
+#define POWER8_BHRB_ENTRIES_LOG2 5
 static void init_proc_POWER8(CPUPPCState *env)
 {
     /* Common Registers */
@@ -6183,6 +6205,8 @@ static void init_proc_POWER8(CPUPPCState *env)
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
+    bhrb_init_state(env, POWER8_BHRB_ENTRIES_LOG2);
+
     /* Allocate hardware IRQ controller */
     init_excp_POWER8(env);
     ppcPOWER7_irq_init(env_archcpu(env));
@@ -6307,6 +6331,7 @@ static struct ppc_radix_page_info POWER9_radix_page_info = {
 };
 #endif /* CONFIG_USER_ONLY */
 
+#define POWER9_BHRB_ENTRIES_LOG2 5
 static void init_proc_POWER9(CPUPPCState *env)
 {
     /* Common Registers */
@@ -6357,6 +6382,8 @@ static void init_proc_POWER9(CPUPPCState *env)
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
+    bhrb_init_state(env, POWER9_BHRB_ENTRIES_LOG2);
+
     /* Allocate hardware IRQ controller */
     init_excp_POWER9(env);
     ppcPOWER9_irq_init(env_archcpu(env));
@@ -6497,6 +6524,7 @@ static struct ppc_radix_page_info POWER10_radix_page_info = {
 };
 #endif /* !CONFIG_USER_ONLY */
 
+#define POWER10_BHRB_ENTRIES_LOG2 5
 static void init_proc_POWER10(CPUPPCState *env)
 {
     /* Common Registers */
@@ -6546,6 +6574,8 @@ static void init_proc_POWER10(CPUPPCState *env)
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
+    bhrb_init_state(env, POWER10_BHRB_ENTRIES_LOG2);
+
     /* Allocate hardware IRQ controller */
     init_excp_POWER10(env);
     ppcPOWER9_irq_init(env_archcpu(env));
@@ -6650,7 +6680,8 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
                  POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
                  POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV;
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV |
+                 POWERPC_FLAG_BHRB;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
@@ -7222,6 +7253,10 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
         }
         env->spr[i] = spr->default_value;
     }
+
+#if defined(TARGET_PPC64)
+    bhrb_reset_state(env);
+#endif
 }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index 6f5d4e1256..db9ee8e96b 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -82,6 +82,37 @@ static void pmu_update_summaries(CPUPPCState *env)
     env->pmc_cyc_cnt = cyc_cnt;
 }
 
+static void hreg_bhrb_filter_update(CPUPPCState *env)
+{
+    target_long ifm;
+
+    if (!(env->spr[SPR_POWER_MMCR0] & MMCR0_PMAE)) {
+        /* disable recording to BHRB */
+        env->bhrb_filter = BHRB_TYPE_NORECORD;
+        return;
+    }
+
+    ifm = (env->spr[SPR_POWER_MMCRA] & MMCRA_IFM_MASK) >> MMCRA_IFM_SHIFT;
+    switch (ifm) {
+    case 0:
+        /* record all branches */
+        env->bhrb_filter = -1;
+        break;
+    case 1:
+        /* only record calls (LK = 1) */
+        env->bhrb_filter = BHRB_TYPE_CALL;
+        break;
+    case 2:
+        /* only record indirect branches */
+        env->bhrb_filter = BHRB_TYPE_INDIRECT;
+        break;
+    case 3:
+        /* only record conditional branches */
+        env->bhrb_filter = BHRB_TYPE_COND;
+        break;
+    }
+}
+
 void pmu_mmcr01a_updated(CPUPPCState *env)
 {
     PowerPCCPU *cpu = env_archcpu(env);
@@ -95,6 +126,8 @@ void pmu_mmcr01a_updated(CPUPPCState *env)
         ppc_set_irq(cpu, PPC_INTERRUPT_PERFM, 0);
     }
 
+    hreg_bhrb_filter_update(env);
+
     /*
      * Should this update overflow timers (if mmcr0 is updated) so they
      * get set in cpu_post_load?
diff --git a/target/ppc/power8-pmu.h b/target/ppc/power8-pmu.h
index 87fa8c9334..3f79cfc45b 100644
--- a/target/ppc/power8-pmu.h
+++ b/target/ppc/power8-pmu.h
@@ -13,6 +13,13 @@
 #ifndef POWER8_PMU_H
 #define POWER8_PMU_H
 
+#define BHRB_TYPE_NORECORD      0x00
+#define BHRB_TYPE_CALL          0x01
+#define BHRB_TYPE_INDIRECT      0x02
+#define BHRB_TYPE_COND          0x04
+#define BHRB_TYPE_OTHER         0x08
+#define BHRB_TYPE_XL_FORM       0x10
+
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 
 #define PMC_COUNTER_NEGATIVE_VAL 0x80000000UL
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a85f596d65..8aa2439700 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -180,6 +180,7 @@ struct DisasContext {
 #if defined(TARGET_PPC64)
     bool sf_mode;
     bool has_cfar;
+    bool has_bhrb;
 #endif
     bool fpu_enabled;
     bool altivec_enabled;
@@ -3371,14 +3372,85 @@ static void gen_rvwinkle(DisasContext *ctx)
     gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
+
+static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv mask, TCGv value)
+{
+    TCGv_ptr tmp = tcg_temp_new_ptr();
+
+    /* add base and offset to get address of bhrb entry */
+    tcg_gen_add_ptr(tmp, base, (TCGv_ptr)offset);
+
+    /* store value into bhrb at bhrb_offset */
+    tcg_gen_st_i64(value, tmp, 0);
+
+    /* add 8 to current bhrb_offset */
+    tcg_gen_addi_tl(offset, offset, 8);
+
+    /* apply offset mask */
+    tcg_gen_and_tl(offset, offset, mask);
+
+    return offset;
+}
 #endif /* #if defined(TARGET_PPC64) */
 
-static inline void gen_update_cfar(DisasContext *ctx, target_ulong nip)
+static inline void gen_update_branch_history(DisasContext *ctx,
+                                             target_ulong nip,
+                                             TCGv target,
+                                             target_long inst_type)
 {
 #if defined(TARGET_PPC64)
+    TCGv_ptr base;
+    TCGv tmp;
+    TCGv offset;
+    TCGv mask;
+    TCGLabel *no_update;
+
     if (ctx->has_cfar) {
         tcg_gen_movi_tl(cpu_cfar, nip);
     }
+
+    if (!ctx->has_bhrb ||
+        !ctx->bhrb_enable ||
+        inst_type == BHRB_TYPE_NORECORD) {
+        return;
+    }
+
+    tmp = tcg_temp_new();
+    no_update = gen_new_label();
+
+    /* check for bhrb filtering */
+    tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPUPPCState, bhrb_filter));
+    tcg_gen_andi_tl(tmp, tmp, inst_type);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, 0, no_update);
+
+    base = tcg_temp_new_ptr();
+    offset = tcg_temp_new();
+    mask = tcg_temp_new();
+
+    /* load bhrb base address */
+    tcg_gen_ld_ptr(base, tcg_env, offsetof(CPUPPCState, bhrb_base));
+
+    /* load current bhrb_offset */
+    tcg_gen_ld_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
+
+    /* load a BHRB offset mask */
+    tcg_gen_ld_tl(mask, tcg_env, offsetof(CPUPPCState, bhrb_offset_mask));
+
+    offset = gen_write_bhrb(base, offset, mask, tcg_constant_i64(nip));
+
+    /* Also record the target address for XL-Form branches */
+    if (inst_type & BHRB_TYPE_XL_FORM) {
+
+        /* Set the 'T' bit for target entries */
+        tcg_gen_ori_tl(tmp, target, 0x2);
+
+        offset = gen_write_bhrb(base, offset, mask, tmp);
+    }
+
+    /* save updated bhrb_offset for next time */
+    tcg_gen_st_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
+
+    gen_set_label(no_update);
 #endif
 }
 
@@ -3508,8 +3580,10 @@ static void gen_b(DisasContext *ctx)
     }
     if (LK(ctx->opcode)) {
         gen_setlr(ctx, ctx->base.pc_next);
+        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_CALL);
+    } else {
+        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_OTHER);
     }
-    gen_update_cfar(ctx, ctx->cia);
     gen_goto_tb(ctx, 0, target);
     ctx->base.is_jmp = DISAS_NORETURN;
 }
@@ -3524,6 +3598,7 @@ static void gen_bcond(DisasContext *ctx, int type)
     uint32_t bo = BO(ctx->opcode);
     TCGLabel *l1;
     TCGv target;
+    target_long bhrb_type = BHRB_TYPE_OTHER;
 
     if (type == BCOND_LR || type == BCOND_CTR || type == BCOND_TAR) {
         target = tcg_temp_new();
@@ -3534,11 +3609,16 @@ static void gen_bcond(DisasContext *ctx, int type)
         } else {
             tcg_gen_mov_tl(target, cpu_lr);
         }
+        if (!LK(ctx->opcode)) {
+            bhrb_type |= BHRB_TYPE_INDIRECT;
+        }
+        bhrb_type |= BHRB_TYPE_XL_FORM;
     } else {
         target = NULL;
     }
     if (LK(ctx->opcode)) {
         gen_setlr(ctx, ctx->base.pc_next);
+        bhrb_type |= BHRB_TYPE_CALL;
     }
     l1 = gen_new_label();
     if ((bo & 0x4) == 0) {
@@ -3589,6 +3669,7 @@ static void gen_bcond(DisasContext *ctx, int type)
                 tcg_gen_brcondi_tl(TCG_COND_EQ, temp, 0, l1);
             }
         }
+        bhrb_type |= BHRB_TYPE_COND;
     }
     if ((bo & 0x10) == 0) {
         /* Test CR */
@@ -3603,8 +3684,11 @@ static void gen_bcond(DisasContext *ctx, int type)
             tcg_gen_andi_i32(temp, cpu_crf[bi >> 2], mask);
             tcg_gen_brcondi_i32(TCG_COND_NE, temp, 0, l1);
         }
+        bhrb_type |= BHRB_TYPE_COND;
     }
-    gen_update_cfar(ctx, ctx->cia);
+
+    gen_update_branch_history(ctx, ctx->cia, target, bhrb_type);
+
     if (type == BCOND_IM) {
         target_ulong li = (target_long)((int16_t)(BD(ctx->opcode)));
         if (likely(AA(ctx->opcode) == 0)) {
@@ -3720,7 +3804,7 @@ static void gen_rfi(DisasContext *ctx)
     /* Restore CPU state */
     CHK_SV(ctx);
     translator_io_start(&ctx->base);
-    gen_update_cfar(ctx, ctx->cia);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
     gen_helper_rfi(tcg_env);
     ctx->base.is_jmp = DISAS_EXIT;
 #endif
@@ -3735,7 +3819,7 @@ static void gen_rfid(DisasContext *ctx)
     /* Restore CPU state */
     CHK_SV(ctx);
     translator_io_start(&ctx->base);
-    gen_update_cfar(ctx, ctx->cia);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
     gen_helper_rfid(tcg_env);
     ctx->base.is_jmp = DISAS_EXIT;
 #endif
@@ -3750,7 +3834,7 @@ static void gen_rfscv(DisasContext *ctx)
     /* Restore CPU state */
     CHK_SV(ctx);
     translator_io_start(&ctx->base);
-    gen_update_cfar(ctx, ctx->cia);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
     gen_helper_rfscv(tcg_env);
     ctx->base.is_jmp = DISAS_EXIT;
 #endif
@@ -6330,6 +6414,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #if defined(TARGET_PPC64)
     ctx->sf_mode = (hflags >> HFLAGS_64) & 1;
     ctx->has_cfar = !!(env->flags & POWERPC_FLAG_CFAR);
+    ctx->has_bhrb = !!(env->flags & POWERPC_FLAG_BHRB);
 #endif
     ctx->lazy_tlb_flush = env->mmu_model == POWERPC_MMU_32B
         || env->mmu_model & POWERPC_MMU_64;
diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
index fb0fcf30cc..9ade0c659a 100644
--- a/target/ppc/translate/branch-impl.c.inc
+++ b/target/ppc/translate/branch-impl.c.inc
@@ -17,7 +17,7 @@ static bool trans_RFEBB(DisasContext *ctx, arg_XL_s *arg)
     REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
 
     translator_io_start(&ctx->base);
-    gen_update_cfar(ctx, ctx->cia);
+    gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
     gen_helper_rfebb(tcg_env, cpu_gpr[arg->s]);
 
     ctx->base.is_jmp = DISAS_CHAIN;
-- 
2.43.0


