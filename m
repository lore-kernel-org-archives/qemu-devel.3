Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2433C25B7B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QSb-0005Lg-Bn; Mon, 13 May 2024 03:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QSW-0005EQ-Sv
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:50:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QST-0001yh-7L
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:50:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-420180b59b7so2975725e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586651; x=1716191451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3ESvr/sXOwA84Rcs+9ochyQsL6MRRZXhrIHKSJ7IWU=;
 b=eRnIUeTJRIXHINGtD3BQ3TLv+GcWjmMnzpjOg2hPuFk3eAZA3FmwieLEl1hk/RUZjT
 mMc1PdEhn+UAJwMM6jtvBfG7niYx2ldHusfCn2I4iLFiiuYwtlxCYDX94vHqKErYnF5q
 +pQz85GQvZraJzHIJwZQt7sEOp1pa/s2X7/ZLWURWTwouUv3WgYQTICt77C9/HHt/To8
 nDXVArQFR7pcL14BobjDOTGZqjc5Q9rJk08eNnxU81DsUgjc7wUyPlGMl8Xmn057g/Ly
 NegiU7RJSDzecSqkIkniVEtWOq8zwbtzWQKdzGMVGZ26Pm3fsGzypfQ9jHsD+6miur0d
 h5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586651; x=1716191451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3ESvr/sXOwA84Rcs+9ochyQsL6MRRZXhrIHKSJ7IWU=;
 b=QrfSYmorcSEQDmdA27JUzkKJ2sW1DvckylO/UOYquXhDRFzsF/yxvz/EBTrG3KoXI2
 2hbe9hojwSnBQDD38bYlNSJocsK2bxYornWkZhIz9Q+mXEDtH2gTwU3ln1aRu/+sPzdI
 0CzOQe7yxyCqrT+ArIjEp8JBsAN/6bhdMyrKLqogpjKlyZ94H/KtY6XtM1CHX2a6sj4Y
 QWypd4SkN22fi9Y51pOz/hgL/91sqJoVgD2XWTLAayO0LqzI/SIzH2l4SeaWbE9BlMpY
 YvCjKJDiu/3UCRxnvqKLkiMKxgjprXqgD9D9JhkcQjpLRQYAxYsjpxdOL+Gb6evk2rTL
 Depw==
X-Gm-Message-State: AOJu0YyfMoMzzKJLU6ShVqpXpkeXuqCDOIHLrzQoOgGUtUg4sRfF7f3y
 +fBMul/IA5jm0Vg15iTcS4Qu6vTXPPwObSekQ8ZTUleiGRbocKw0Ds5sgdQGl3rWtk4HrsYueEp
 MdJ0=
X-Google-Smtp-Source: AGHT+IFNHR1Kq/yOU7MLs1NLfzGPwUPRDpxlgtRk76CKfac3Y4a9XXygLoMSqy/p9Vz6ATfSw2dvwA==
X-Received: by 2002:a5d:4801:0:b0:34d:2343:b881 with SMTP id
 ffacd0b85a97d-3504a96a343mr6214968f8f.43.1715586650579; 
 Mon, 13 May 2024 00:50:50 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a50sm10374262f8f.30.2024.05.13.00.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:50:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 41/45] target/hppa: Implement CF_PCREL
Date: Mon, 13 May 2024 09:47:13 +0200
Message-Id: <20240513074717.130949-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

Now that the groundwork has been laid, enabling CF_PCREL within the
translator proper is a simple matter of updating copy_iaoq_entry
and install_iaq_entries.

We also need to modify the unwind info, since we no longer have
absolute addresses to install.

As expected, this reduces the runtime overhead of compilation when
running a Linux kernel with address space randomization enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.c       | 19 ++++++------
 target/hppa/translate.c | 68 ++++++++++++++++++++++++++++-------------
 2 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 5f0df0697a..f0507874ce 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -62,10 +62,6 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     *pc = hppa_cpu_get_pc(env_cpu(env));
     flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
 
-    if (hppa_is_pa20(env)) {
-        cs_base = env->iaoq_f & MAKE_64BIT_MASK(32, 32);
-    }
-
     /*
      * The only really interesting case is if IAQ_Back is on the same page
      * as IAQ_Front, so that we can use goto_tb between the blocks.  In all
@@ -113,19 +109,19 @@ static void hppa_restore_state_to_opc(CPUState *cs,
                                       const TranslationBlock *tb,
                                       const uint64_t *data)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = cpu_env(cs);
 
-    cpu->env.iaoq_f = data[0];
-    if (data[1] != (target_ulong)-1) {
-        cpu->env.iaoq_b = data[1];
+    env->iaoq_f = (env->iaoq_f & TARGET_PAGE_MASK) | data[0];
+    if (data[1] != INT32_MIN) {
+        env->iaoq_b = env->iaoq_f + data[1];
     }
-    cpu->env.unwind_breg = data[2];
+    env->unwind_breg = data[2];
     /*
      * Since we were executing the instruction at IAOQ_F, and took some
      * sort of action that provoked the cpu_restore_state, we can infer
      * that the instruction was not nullified.
      */
-    cpu->env.psw_n = 0;
+    env->psw_n = 0;
 }
 
 static bool hppa_cpu_has_work(CPUState *cs)
@@ -191,6 +187,9 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
         hppa_ptlbe(&cpu->env);
     }
 #endif
+
+    /* Use pc-relative instructions always to simplify the translator. */
+    tcg_cflags_set(cs, CF_PCREL);
 }
 
 static void hppa_cpu_initfn(Object *obj)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index fa79116d5b..79e29d722f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -47,7 +47,7 @@ typedef struct DisasIAQE {
     TCGv_i64 space;
     /* IAOQ base; may be null for relative address. */
     TCGv_i64 base;
-    /* IAOQ addend; if base is null, relative to ctx->iaoq_first. */
+    /* IAOQ addend; if base is null, relative to cpu_iaoq_f. */
     int64_t disp;
 } DisasIAQE;
 
@@ -664,11 +664,7 @@ static DisasIAQE iaqe_next_absv(DisasContext *ctx, TCGv_i64 var)
 static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
                             const DisasIAQE *src)
 {
-    if (src->base == NULL) {
-        tcg_gen_movi_i64(dest, ctx->iaoq_first + src->disp);
-    } else {
-        tcg_gen_addi_i64(dest, src->base, src->disp);
-    }
+    tcg_gen_addi_i64(dest, src->base ? : cpu_iaoq_f, src->disp);
 }
 
 static void install_iaq_entries(DisasContext *ctx, const DisasIAQE *f,
@@ -680,8 +676,28 @@ static void install_iaq_entries(DisasContext *ctx, const DisasIAQE *f,
         b_next = iaqe_incr(f, 4);
         b = &b_next;
     }
-    copy_iaoq_entry(ctx, cpu_iaoq_f, f);
-    copy_iaoq_entry(ctx, cpu_iaoq_b, b);
+
+    /*
+     * There is an edge case
+     *    bv   r0(rN)
+     *    b,l  disp,r0
+     * for which F will use cpu_iaoq_b (from the indirect branch),
+     * and B will use cpu_iaoq_f (from the direct branch).
+     * In this case we need an extra temporary.
+     */
+    if (f->base != cpu_iaoq_b) {
+        copy_iaoq_entry(ctx, cpu_iaoq_b, b);
+        copy_iaoq_entry(ctx, cpu_iaoq_f, f);
+    } else if (f->base == b->base) {
+        copy_iaoq_entry(ctx, cpu_iaoq_f, f);
+        tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_f, b->disp - f->disp);
+    } else {
+        TCGv_i64 tmp = tcg_temp_new_i64();
+        copy_iaoq_entry(ctx, tmp, b);
+        copy_iaoq_entry(ctx, cpu_iaoq_f, f);
+        tcg_gen_mov_i64(cpu_iaoq_b, tmp);
+    }
+
     if (f->space) {
         tcg_gen_mov_i64(cpu_iasq_f, f->space);
     }
@@ -3979,9 +3995,8 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         /* Adjust the dest offset for the privilege change from the PTE. */
         TCGv_i64 off = tcg_temp_new_i64();
 
-        gen_helper_b_gate_priv(off, tcg_env,
-                               tcg_constant_i64(ctx->iaoq_first
-                                                + ctx->iaq_f.disp));
+        copy_iaoq_entry(ctx, off, &ctx->iaq_f);
+        gen_helper_b_gate_priv(off, tcg_env, off);
 
         ctx->iaq_j.base = off;
         ctx->iaq_j.disp = disp + 8;
@@ -4602,7 +4617,7 @@ static bool trans_diag_unimp(DisasContext *ctx, arg_diag_unimp *a)
 static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    uint64_t cs_base, iaoq_f, iaoq_b;
+    uint64_t cs_base;
     int bound;
 
     ctx->cs = cs;
@@ -4621,12 +4636,8 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
                     : ctx->tb_flags & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX);
 #endif
 
-    /* Recover the IAOQ values from the GVA + PRIV.  */
     cs_base = ctx->base.tb->cs_base;
-    iaoq_f = cs_base & MAKE_64BIT_MASK(32, 32);
-    iaoq_f |= ctx->base.pc_first & MAKE_64BIT_MASK(2, 30);
-    iaoq_f |= ctx->privilege;
-    ctx->iaoq_first = iaoq_f;
+    ctx->iaoq_first = ctx->base.pc_first + ctx->privilege;
 
     if (unlikely(cs_base & CS_BASE_DIFFSPACE)) {
         ctx->iaq_b.space = cpu_iasq_b;
@@ -4634,8 +4645,9 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     } else if (unlikely(cs_base & CS_BASE_DIFFPAGE)) {
         ctx->iaq_b.base = cpu_iaoq_b;
     } else {
-        iaoq_b = (iaoq_f & TARGET_PAGE_MASK) | (cs_base & ~TARGET_PAGE_MASK);
-        ctx->iaq_b.disp = iaoq_b - iaoq_f;
+        uint64_t iaoq_f_pgofs = ctx->iaoq_first & ~TARGET_PAGE_MASK;
+        uint64_t iaoq_b_pgofs = cs_base & ~TARGET_PAGE_MASK;
+        ctx->iaq_b.disp = iaoq_b_pgofs - iaoq_f_pgofs;
     }
 
     ctx->zero = tcg_constant_i64(0);
@@ -4662,11 +4674,23 @@ static void hppa_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
 static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    uint64_t iaoq_f, iaoq_b;
+    int64_t diff;
 
     tcg_debug_assert(!iaqe_variable(&ctx->iaq_f));
-    tcg_gen_insn_start(ctx->iaoq_first + ctx->iaq_f.disp,
-                       (iaqe_variable(&ctx->iaq_b) ? -1 :
-                        ctx->iaoq_first + ctx->iaq_b.disp), 0);
+
+    iaoq_f = ctx->iaoq_first + ctx->iaq_f.disp;
+    if (iaqe_variable(&ctx->iaq_b)) {
+        diff = INT32_MIN;
+    } else {
+        iaoq_b = ctx->iaoq_first + ctx->iaq_b.disp;
+        diff = iaoq_b - iaoq_f;
+        /* Direct branches can only produce a 24-bit displacement. */
+        tcg_debug_assert(diff == (int32_t)diff);
+        tcg_debug_assert(diff != INT32_MIN);
+    }
+
+    tcg_gen_insn_start(iaoq_f & ~TARGET_PAGE_MASK, diff, 0);
     ctx->insn_start_updated = false;
 }
 
-- 
2.34.1


