Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7A1C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 08:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnDr7-0004mc-RW; Thu, 21 Mar 2024 04:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rnDr5-0004lm-9y; Thu, 21 Mar 2024 04:32:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rnDr3-0008VT-FT; Thu, 21 Mar 2024 04:32:55 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e740fff1d8so607746b3a.1; 
 Thu, 21 Mar 2024 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711009971; x=1711614771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CUUx1lzhsvpVEEQyG7T45YA3v+loYAcCkpS9kUu6u9w=;
 b=Ucy8hzFYC4kpz1ptkrBd8LRzIsZo0tT95j4QkqlD/5eku+9PcZABspUqsvBQFa9Q7L
 /JKPiXK5SP1RZBXM0PxM0U9/K/USj+awyWFSiia0uqyfT7/DW82dDvQrkZtdbuCTcKMQ
 CFAu9bGGdoQ5ZkPWKkB4A9tVO3GDuyC+WkCmI5l+XfHnmDqf81L9IzYMNkPpEjtJkQzM
 GuVaL5szmSS57phcBpYWKFcSreapevKA8v8zSbqg2byudT360Rc4jQxgNTLPBdFVsxOR
 IZrAsWBDA8SJuvXBfQ9xP5/t5yJPJg1vp9NKa9wde3oeKZORI7CDnNWrvGiGwD+i+xwQ
 QQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711009971; x=1711614771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CUUx1lzhsvpVEEQyG7T45YA3v+loYAcCkpS9kUu6u9w=;
 b=I74e+VyeDj7Y4O/IzyVJPy8xg7P3XZGXyZLrqY6CfjZb2uDjrlpFmUxmVyfF5+uG0d
 C2tarwkBImuRVyLjJLB7gBLyBUc1JFEgHgButUp+Io8V8dtBV6uXWnRILK2YPxfGoITP
 jBI7dQXyh+ZzsLNiVJCQbM4soTKrsqi+CAl3+fg0EM8J2Xxl66erGE+ZrWW92wbWn+01
 A60Jj0awOUIP2FjV9UfkpKOssPW+js5iMHJkR317dMSAn3Z1GyCHg5BwuNP8goTtcTaB
 hAlgPJsQwEMCQQedcmXhrlb2BN75lOTzh8aKLhkNXWnbbUVGkNwk6QY13sWs9DVm/A1x
 TAbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVILFg3Sa8Nf2JXr5U61LBbRf+N7K0AfuQTIPA1CjrTxIkCHYbg34ZyzGA8OSsaHXEAqKfts+uMSpoQ/57hkOdmlLFnOD4=
X-Gm-Message-State: AOJu0Yw+vXvTvIuTm3IsJPDcT/Nw7KyBe9t4saesXusJzNcomv4NY5Co
 80H1ht9yOgemG/BMlRH1fjZKiE5NFXqNn80DorGOTXAcRLlR2jWY9RSgAy+yU+Q=
X-Google-Smtp-Source: AGHT+IFmKwTjZmRATqGZXmiJe48aETN/vY5rtbDMoh+cyU5nZW8ld3UZmevvEPvImkyiZzzAUyT57w==
X-Received: by 2002:a05:6a20:1715:b0:1a1:878d:d3f6 with SMTP id
 bn21-20020a056a20171500b001a1878dd3f6mr1096741pzb.26.1711009505634; 
 Thu, 21 Mar 2024 01:25:05 -0700 (PDT)
Received: from wheely.local0.net ([1.146.27.241])
 by smtp.gmail.com with ESMTPSA id
 so15-20020a17090b1f8f00b002a0187d84f0sm1081995pjb.20.2024.03.21.01.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 01:25:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH] target/ppc: Fix TCG PMC5 instruction counting
Date: Thu, 21 Mar 2024 18:24:57 +1000
Message-ID: <20240321082457.2462866-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PMC5 does not count instructions when single stepping (with gdb,
haven't tried single stepping inside the target), or when taking
exceptions. At least the single-steppig is a bit of a landmine for
replay.

I don't quite understand the logic of the approach taken for
counting now. AFAIKS instructions must be counted whenever leaving
the current TB whether it is exiting or going to the next TB
directly.

This patch fixes up at least the ss and syscall/synchronous exception
cases, and doesn't seem to break anything. I don't know if there
is a better or more consistent way to do it though.

Thanks,
Nick

---
 target/ppc/translate.c | 146 +++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 79 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 93ffec787c..4e4648e02d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -296,11 +296,73 @@ static inline void gen_update_nip(DisasContext *ctx, target_ulong nip)
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
+    return;
+}
+#endif /* #if defined(TARGET_PPC64) */
+
 static void gen_exception_err_nip(DisasContext *ctx, uint32_t excp,
                                   uint32_t error, target_ulong nip)
 {
     TCGv_i32 t0, t1;
 
+    pmu_count_insns(ctx);
     gen_update_nip(ctx, nip);
     t0 = tcg_constant_i32(excp);
     t1 = tcg_constant_i32(error);
@@ -323,6 +385,7 @@ static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
 {
     TCGv_i32 t0;
 
+    pmu_count_insns(ctx);
     gen_update_nip(ctx, nip);
     t0 = tcg_constant_i32(excp);
     gen_helper_raise_exception(tcg_env, t0);
@@ -4082,67 +4145,6 @@ static inline void gen_update_cfar(DisasContext *ctx, target_ulong nip)
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
@@ -4153,17 +4155,10 @@ static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 
 static void gen_lookup_and_goto_ptr(DisasContext *ctx)
 {
+    pmu_count_insns(ctx);
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
@@ -4497,6 +4492,7 @@ static void gen_scv(DisasContext *ctx)
     uint32_t lev = (ctx->opcode >> 5) & 0x7F;
 
     /* Set the PC back to the faulting instruction. */
+    pmu_count_insns(ctx);
     gen_update_nip(ctx, ctx->cia);
     gen_helper_scv(tcg_env, tcg_constant_i32(lev));
 
@@ -7339,6 +7335,8 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         return;
     }
 
+    pmu_count_insns(ctx);
+
     /* Honor single stepping. */
     if (unlikely(ctx->singlestep_enabled & CPU_SINGLE_STEP)) {
         bool rfi_type = false;
@@ -7370,7 +7368,6 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     switch (is_jmp) {
     case DISAS_TOO_MANY:
         if (use_goto_tb(ctx, nip)) {
-            pmu_count_insns(ctx);
             tcg_gen_goto_tb(0);
             gen_update_nip(ctx, nip);
             tcg_gen_exit_tb(ctx->base.tb, 0);
@@ -7381,14 +7378,6 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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
 
@@ -7396,7 +7385,6 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         gen_update_nip(ctx, nip);
         /* fall through */
     case DISAS_EXIT:
-        pmu_count_insns(ctx);
         tcg_gen_exit_tb(NULL, 0);
         break;
 
-- 
2.42.0


