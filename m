Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942C5C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9dDP-0005ZK-BP; Wed, 22 May 2024 00:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9dDI-0005W3-3O; Wed, 22 May 2024 00:04:29 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9dDG-0007xa-0F; Wed, 22 May 2024 00:04:27 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c99501317bso2175832b6e.3; 
 Tue, 21 May 2024 21:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716350663; x=1716955463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Grhxpg/OTSwdL/95q4CcI2WVhTC/yE8uBZuXwQz2yYs=;
 b=e1kRZiwdud8/9jAz6zn1EYqFm4kl5pt9SiO8BRUGP20a3H3mnunxDilDwEBMf3BCae
 dTFtXlIVKhfxJK1ZjeK0Wu1puxgn67VmhlxbY9FX9jMEP/1mwqL2W3cwy9kuIkmr0JpI
 7TlDBLyM37jW3Ds8e1iMoMsQSKIYufm+zXqyv+PDCFbzNwwY0rowFOmFg5VTAByrUNol
 FO2mDNVEmB6NOpelbAhHKi9Lt1X+p+oQ+MaDK2k0FVUtxvxF8Dq5oHwyjUqJNdWqy7eF
 gb/a+8dhMR6PpzLQLBIAORGqY7FBT7I7hJlNxyzeziv5FDhFyxdfnF2tvPEfnGjTm1/D
 Vvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716350663; x=1716955463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Grhxpg/OTSwdL/95q4CcI2WVhTC/yE8uBZuXwQz2yYs=;
 b=WW3u7uLx4I/KQpBfOU2yw4HRoemJ5tDstJzc6M0vVl6MvN9jMKSASLGRZR1T85UTy+
 40gv43ihtzZAmByGT7nBMyYYK7tAEWbCjN9jHprMKOAzUfF9IETKRFZ/jHaHW52v5X2B
 VzAfw2u28hvX/Xlorg1RpP9obHffpsrVzlPKIv/ARizdJ0Y/1fcyrnar4RWhNpl9vKg/
 ikBwzFnBFLNFCVHneFqG0VWmD+C1qoQe4hwZezKNo8KtC5sqS5FxmqcG54wCZgA3ykir
 FZOjWLpVE1BuMeTCvfJ/uOKQR/jTnW1CEqT5H2U6fQIaoAw3gygeBgEWGvsTYJ0RGA75
 xzdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1lHayVgSMfvvOs3LJf3RGjEjjyhmmWeiuD5i77i3pQEsn6njB2WvauuTDetGXkUv1AhDSAt6pzlYxHzP55kBGVjLWKUg=
X-Gm-Message-State: AOJu0YyyOh4A4wC8IKkxonDGrOTe6kEiYlcud25pzDBayp9BT72v8Luh
 854K6Y4xt6BmYsr8yVhVRP5ZQgUKNZWlKm+76mf/l6E3lzHODBTl8auy2A==
X-Google-Smtp-Source: AGHT+IFu+68JiCgYWYO8CSuixp4yb99tANNOV/fVjHIic3WbcpAJgUwWdHFTMVbbmDHlbJxFOBcE4Q==
X-Received: by 2002:a05:6359:3183:b0:186:26e2:62b6 with SMTP id
 e5c5f4694b2df-19791b78bc7mr68547655d.19.1716350663095; 
 Tue, 21 May 2024 21:04:23 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6589645bbefsm10197158a12.55.2024.05.21.21.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 21:04:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/2] target/ppc: Fix PMC5 instruction counting
Date: Wed, 22 May 2024 14:04:10 +1000
Message-ID: <20240522040411.90655-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240522040411.90655-1-npiggin@gmail.com>
References: <20240522040411.90655-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22d.google.com
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

PMC5 does not count instructions correctly when single stepping the
target with gdb, or when taking exceptions. The single-stepping
inaccuracy is a problem for reverse debugging (because the PMC5
value can go out of sync between executions of the same trace).

AFAIKS the current instruction count should be accumulated whenever
leaving the current TB by any means. This is a particular problem for
memory operations that can raise exceptions in the back-end and so the
translator can't count previously executed instructions.

This patch limits the translation block size to 1 instruction when
counting is enabled, which fixes the memory operation faulting problem.

It also counts syscall instructions as being executed despite causing
exceptions (which is unlike some other causes of instruction faults)
and moves the counting for DISAS_NORETURN paths into the callers
which I thought was a bit clearer but objections welcome.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 162 +++++++++++++++++++++--------------------
 1 file changed, 82 insertions(+), 80 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 49dee6cab0..344e78843c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -295,6 +295,66 @@ static inline void gen_update_nip(DisasContext *ctx, target_ulong nip)
     tcg_gen_movi_tl(cpu_nip, nip);
 }
 
+#if defined(TARGET_PPC64)
+static void pmu_count_insns(DisasContext *ctx)
+{
+    /*
+     * Do not bother calling the helper if the PMU isn't counting
+     * instructions.
+     */
+    if (!ctx->pmu_insn_cnt) {
+        return;
+    }
+
+ #if !defined(CONFIG_USER_ONLY)
+    TCGLabel *l;
+    TCGv t0;
+
+    /*
+     * The PMU insns_inc() helper stops the internal PMU timer if a
+     * counter overflows happens. In that case, if the guest is
+     * running with icount and we do not handle it beforehand,
+     * the helper can trigger a 'bad icount read'.
+     */
+    translator_io_start(&ctx->base);
+
+    /* Avoid helper calls when only PMC5-6 are enabled. */
+    if (!ctx->pmc_other) {
+        l = gen_new_label();
+        t0 = tcg_temp_new();
+
+        gen_load_spr(t0, SPR_POWER_PMC5);
+        tcg_gen_addi_tl(t0, t0, ctx->base.num_insns);
+        gen_store_spr(SPR_POWER_PMC5, t0);
+        /* Check for overflow, if it's enabled */
+        if (ctx->mmcr0_pmcjce) {
+            tcg_gen_brcondi_tl(TCG_COND_LT, t0, PMC_COUNTER_NEGATIVE_VAL, l);
+            gen_helper_handle_pmc5_overflow(tcg_env);
+        }
+
+        gen_set_label(l);
+    } else {
+        gen_helper_insns_inc(tcg_env, tcg_constant_i32(ctx->base.num_insns));
+    }
+  #else
+    /*
+     * User mode can read (but not write) PMC5 and start/stop
+     * the PMU via MMCR0_FC. In this case just increment
+     * PMC5 with base.num_insns.
+     */
+    TCGv t0 = tcg_temp_new();
+
+    gen_load_spr(t0, SPR_POWER_PMC5);
+    tcg_gen_addi_tl(t0, t0, ctx->base.num_insns);
+    gen_store_spr(SPR_POWER_PMC5, t0);
+  #endif /* #if !defined(CONFIG_USER_ONLY) */
+}
+#else
+static void pmu_count_insns(DisasContext *ctx)
+{
+}
+#endif /* #if defined(TARGET_PPC64) */
+
 static void gen_exception_err_nip(DisasContext *ctx, uint32_t excp,
                                   uint32_t error, target_ulong nip)
 {
@@ -4081,67 +4141,6 @@ static inline void gen_update_cfar(DisasContext *ctx, target_ulong nip)
 #endif
 }
 
-#if defined(TARGET_PPC64)
-static void pmu_count_insns(DisasContext *ctx)
-{
-    /*
-     * Do not bother calling the helper if the PMU isn't counting
-     * instructions.
-     */
-    if (!ctx->pmu_insn_cnt) {
-        return;
-    }
-
- #if !defined(CONFIG_USER_ONLY)
-    TCGLabel *l;
-    TCGv t0;
-
-    /*
-     * The PMU insns_inc() helper stops the internal PMU timer if a
-     * counter overflows happens. In that case, if the guest is
-     * running with icount and we do not handle it beforehand,
-     * the helper can trigger a 'bad icount read'.
-     */
-    translator_io_start(&ctx->base);
-
-    /* Avoid helper calls when only PMC5-6 are enabled. */
-    if (!ctx->pmc_other) {
-        l = gen_new_label();
-        t0 = tcg_temp_new();
-
-        gen_load_spr(t0, SPR_POWER_PMC5);
-        tcg_gen_addi_tl(t0, t0, ctx->base.num_insns);
-        gen_store_spr(SPR_POWER_PMC5, t0);
-        /* Check for overflow, if it's enabled */
-        if (ctx->mmcr0_pmcjce) {
-            tcg_gen_brcondi_tl(TCG_COND_LT, t0, PMC_COUNTER_NEGATIVE_VAL, l);
-            gen_helper_handle_pmc5_overflow(tcg_env);
-        }
-
-        gen_set_label(l);
-    } else {
-        gen_helper_insns_inc(tcg_env, tcg_constant_i32(ctx->base.num_insns));
-    }
-  #else
-    /*
-     * User mode can read (but not write) PMC5 and start/stop
-     * the PMU via MMCR0_FC. In this case just increment
-     * PMC5 with base.num_insns.
-     */
-    TCGv t0 = tcg_temp_new();
-
-    gen_load_spr(t0, SPR_POWER_PMC5);
-    tcg_gen_addi_tl(t0, t0, ctx->base.num_insns);
-    gen_store_spr(SPR_POWER_PMC5, t0);
-  #endif /* #if !defined(CONFIG_USER_ONLY) */
-}
-#else
-static void pmu_count_insns(DisasContext *ctx)
-{
-    return;
-}
-#endif /* #if defined(TARGET_PPC64) */
-
 static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
     if (unlikely(ctx->singlestep_enabled)) {
@@ -4155,14 +4154,6 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
     if (unlikely(ctx->singlestep_enabled)) {
         gen_debug_exception(ctx, false);
     } else {
-        /*
-         * tcg_gen_lookup_and_goto_ptr will exit the TB if
-         * CF_NO_GOTO_PTR is set. Count insns now.
-         */
-        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
-            pmu_count_insns(ctx);
-        }
-
         tcg_gen_lookup_and_goto_ptr();
     }
 }
@@ -4174,7 +4165,6 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
         dest = (uint32_t) dest;
     }
     if (use_goto_tb(ctx, dest)) {
-        pmu_count_insns(ctx);
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(cpu_nip, dest & ~3);
         tcg_gen_exit_tb(ctx->base.tb, n);
@@ -4197,6 +4187,8 @@ static void gen_b(DisasContext *ctx)
 {
     target_ulong li, target;
 
+    pmu_count_insns(ctx);
+
     /* sign extend LI */
     li = LI(ctx->opcode);
     li = (li ^ 0x02000000) - 0x02000000;
@@ -4224,6 +4216,8 @@ static void gen_bcond(DisasContext *ctx, int type)
     TCGLabel *l1;
     TCGv target;
 
+    pmu_count_insns(ctx);
+
     if (type == BCOND_LR || type == BCOND_CTR || type == BCOND_TAR) {
         target = tcg_temp_new();
         if (type == BCOND_CTR) {
@@ -4480,6 +4474,9 @@ static void gen_sc(DisasContext *ctx)
 {
     uint32_t lev;
 
+    /* sc instructions complete when causing the exception */
+    pmu_count_insns(ctx);
+
     /*
      * LEV is a 7-bit field, but the top 6 bits are treated as a reserved
      * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but that is
@@ -4495,6 +4492,9 @@ static void gen_scv(DisasContext *ctx)
 {
     uint32_t lev = (ctx->opcode >> 5) & 0x7F;
 
+    /* scv instructions complete when causing the exception */
+    pmu_count_insns(ctx);
+
     /* Set the PC back to the faulting instruction. */
     gen_update_nip(ctx, ctx->cia);
     gen_helper_scv(tcg_env, tcg_constant_i32(lev));
@@ -7266,6 +7266,16 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     if ((hflags >> HFLAGS_BE) & 1) {
         ctx->singlestep_enabled |= CPU_BRANCH_STEP;
     }
+
+    /*
+     * Counting instructions is difficult with memory operations that can
+     * cause faults in the middle of a TB without a way for the translator
+     * to insert any instruction counting. Work around this by forcing all
+     * TBs to 1 instruction.
+     */
+    if (ctx->pmu_insn_cnt) {
+        ctx->base.max_insns = 1;
+    }
 }
 
 static void ppc_tr_tb_start(DisasContextBase *db, CPUState *cs)
@@ -7338,6 +7348,8 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         return;
     }
 
+    pmu_count_insns(ctx);
+
     /* Honor single stepping. */
     if (unlikely(ctx->singlestep_enabled & CPU_SINGLE_STEP)) {
         bool rfi_type = false;
@@ -7369,7 +7381,6 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     switch (is_jmp) {
     case DISAS_TOO_MANY:
         if (use_goto_tb(ctx, nip)) {
-            pmu_count_insns(ctx);
             tcg_gen_goto_tb(0);
             gen_update_nip(ctx, nip);
             tcg_gen_exit_tb(ctx->base.tb, 0);
@@ -7380,14 +7391,6 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         gen_update_nip(ctx, nip);
         /* fall through */
     case DISAS_CHAIN:
-        /*
-         * tcg_gen_lookup_and_goto_ptr will exit the TB if
-         * CF_NO_GOTO_PTR is set. Count insns now.
-         */
-        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
-            pmu_count_insns(ctx);
-        }
-
         tcg_gen_lookup_and_goto_ptr();
         break;
 
@@ -7395,7 +7398,6 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         gen_update_nip(ctx, nip);
         /* fall through */
     case DISAS_EXIT:
-        pmu_count_insns(ctx);
         tcg_gen_exit_tb(NULL, 0);
         break;
 
-- 
2.43.0


