Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41A8C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 15:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3HUC-00025T-VQ; Sat, 04 May 2024 11:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HUB-00024d-IT
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:39 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU9-0006FT-MV
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:39 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ec69e3dbcfso4591375ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714837176; x=1715441976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWL0Ke+Jw6QzfCzbT3Y2xG1VsHYECu3YiFT2GS703uA=;
 b=PZhR3wv5PKdhPjG1nlhi7rmgPT8fVobamOaXatYSr7N2papdTW90+3jMBBpFldf/Y1
 Qa1Al77P7b8hae9wtIFaLLlFrT3g3e8CElHRUSAReH5qAM9uMy6ebR8amQjgO8Q9i8wu
 zzOmlXSqR/teF9T/+2m7GiKTPaasmoA8rfJerQq2HlKSzdSjbdAMoPSTzzpxSXUdPnOK
 SwxP5jPn0VlTwNbC7jDz+5dMO+VBfWlaW1c9+s+MpH336ClJEq6TfIpages9M2V47R1n
 1hd2nqdzwOPJ1BqHy/7Xxs24BWnRN1yXaCBIAIHU1cvtyOUbOnZgkt4B3vdiTQCn7Bqm
 nH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714837176; x=1715441976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MWL0Ke+Jw6QzfCzbT3Y2xG1VsHYECu3YiFT2GS703uA=;
 b=BPZaNx3QM8bEYx6oDLw1l1ty/BebhQrpsH1KFhGBBVcyZxXB9mcqLin8f0Y1dVhx6J
 pIKaftkWTuBttTxgcEdEr96mKoTosFL2X1pbPR0Z9x9qDGLxRw/v0+zGmp4zYRvzBzhx
 431FcpnJZRmPB96c1HV6eKvOCaONuOwB9DQ6ExkxQYo1yz5LCwQeFoyGHXasJS54G5lm
 pGGY1OCpibtHj3CVfie4qkU7Z8uwS1agzPK3SSLQP/TD8W0dlSdE/hrDDQf+UxpImwjc
 8XEIj4u2srnMoRAlx6Yr1n55uUed2Td+Fudie+Dn/Jq6wuMdukovAsql3ZfhzAKpzH5U
 n2ug==
X-Gm-Message-State: AOJu0YxGJqNTQkKEUmTFKqwGfvLxiweGR5QqbjKVtJ7kerN9VLRf0mG2
 Z3Oq/+yVMwECMRSfY8QL9pTjk4QsBYiUBe0EwpLhWYPK8UPliEX7vILSJyBHfbEg6p0Yh6X+uQA
 V
X-Google-Smtp-Source: AGHT+IGkBsFt3l6KcPPa1IN/eZwLHpSi+psnnFFYDPbIf5X7+x3aSG0jLFiIIAeS8U4/MIOrc7kS9A==
X-Received: by 2002:a17:903:234b:b0:1ec:a65a:e4ad with SMTP id
 c11-20020a170903234b00b001eca65ae4admr6419420plh.66.1714837176291; 
 Sat, 04 May 2024 08:39:36 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902e54f00b001e4d22f828fsm5197859plf.33.2024.05.04.08.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 08:39:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 9/9] target/alpha: Implement CF_PCREL
Date: Sat,  4 May 2024 08:39:26 -0700
Message-Id: <20240504153926.357845-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240504153926.357845-1-richard.henderson@linaro.org>
References: <20240504153926.357845-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240503072014.24751-10-philmd@linaro.org>
---
 target/alpha/cpu.c       | 23 ++++++++++++++++++++++-
 target/alpha/translate.c | 29 +++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index f98d022671..0e2fbcb397 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -38,12 +38,27 @@ static vaddr alpha_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
+static void alpha_cpu_synchronize_from_tb(CPUState *cs,
+                                          const TranslationBlock *tb)
+{
+    /* The program counter is always up to date with CF_PCREL. */
+    if (!(tb_cflags(tb) & CF_PCREL)) {
+        CPUAlphaState *env = cpu_env(cs);
+        env->pc = tb->pc;
+    }
+}
+
 static void alpha_restore_state_to_opc(CPUState *cs,
                                        const TranslationBlock *tb,
                                        const uint64_t *data)
 {
     CPUAlphaState *env = cpu_env(cs);
-    env->pc = data[0];
+
+    if (tb_cflags(tb) & CF_PCREL) {
+        env->pc = (env->pc & TARGET_PAGE_MASK) | data[0];
+    } else {
+        env->pc = data[0];
+    }
 }
 
 static bool alpha_cpu_has_work(CPUState *cs)
@@ -78,6 +93,11 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
     AlphaCPUClass *acc = ALPHA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+#ifndef CONFIG_USER_ONLY
+    /* Use pc-relative instructions in system-mode */
+    cs->tcg_cflags |= CF_PCREL;
+#endif
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -190,6 +210,7 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 
 static const TCGCPUOps alpha_tcg_ops = {
     .initialize = alpha_translate_init,
+    .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 86402d96d5..db847e7a23 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -54,6 +54,9 @@ struct DisasContext {
     uint32_t tbflags;
     int mem_idx;
 
+    /* True if generating pc-relative code.  */
+    bool pcrel;
+
     /* implver and amask values for this CPU.  */
     int implver;
     int amask;
@@ -254,7 +257,12 @@ static void st_flag_byte(TCGv val, unsigned shift)
 
 static void gen_pc_disp(DisasContext *ctx, TCGv dest, int32_t disp)
 {
-    tcg_gen_movi_i64(dest, ctx->base.pc_next + disp);
+    uint64_t addr = ctx->base.pc_next + disp;
+    if (ctx->pcrel) {
+        tcg_gen_addi_i64(dest, cpu_pc, addr - ctx->base.pc_first);
+    } else {
+        tcg_gen_movi_i64(dest, addr);
+    }
 }
 
 static void gen_excp_1(int exception, int error_code)
@@ -433,8 +441,14 @@ static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int rb,
 static void gen_goto_tb(DisasContext *ctx, int idx, int32_t disp)
 {
     if (translator_use_goto_tb(&ctx->base, ctx->base.pc_next + disp)) {
-        tcg_gen_goto_tb(idx);
-        gen_pc_disp(ctx, cpu_pc, disp);
+        /* With PCREL, PC must always be up-to-date. */
+        if (ctx->pcrel) {
+            gen_pc_disp(ctx, cpu_pc, disp);
+            tcg_gen_goto_tb(idx);
+        } else {
+            tcg_gen_goto_tb(idx);
+            gen_pc_disp(ctx, cpu_pc, disp);
+        }
         tcg_gen_exit_tb(ctx->base.tb, idx);
     } else {
         gen_pc_disp(ctx, cpu_pc, disp);
@@ -2852,6 +2866,7 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 
     ctx->tbflags = ctx->base.tb->flags;
     ctx->mem_idx = alpha_env_mmu_index(env);
+    ctx->pcrel = ctx->base.tb->cflags & CF_PCREL;
     ctx->implver = env->implver;
     ctx->amask = env->amask;
 
@@ -2887,7 +2902,13 @@ static void alpha_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 
 static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
-    tcg_gen_insn_start(dcbase->pc_next);
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    if (ctx->pcrel) {
+        tcg_gen_insn_start(dcbase->pc_next & ~TARGET_PAGE_MASK);
+    } else {
+        tcg_gen_insn_start(dcbase->pc_next);
+    }
 }
 
 static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.34.1


