Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB3AC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPR-0002uJ-ES; Mon, 13 May 2024 03:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPC-0002mh-EJ
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP8-0001KN-IE
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41fd5dc0480so24482445e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586444; x=1716191244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fqWIFmvD9JUaraiZpom6kTf9G8T11TFsgyyJnV2gt8=;
 b=fmmoYJm9c17ifW+IYsemz3k9nPAIz7prekbEKqrL6VJm7zhX2VovsgHPwZR2p9ShgJ
 VQ7BRG5u9rxpJZLijz8cQk2BBUq60sZhzc1e6a34u6h9n9PdEDQ9Vv8gSFJIux0MZsgt
 i8urBqJPgTyqyD9OrdSeoPvZ0nUs56RZVhX8BBb/LbaqfVrvTiwpT9875oHeqn7a4DvO
 V6CwRYGefT7/w2KKoAUQ6YBhLyaDsijsWWE+Qn9bIBu5aBw8+NsXlG9R+kP43LeHmqjX
 eTqELheyKtIpjteSkUrMZitiSE2GV9zMvKND63OYiH49h0xK6jp88rITfPYy8PFhNStm
 Ey6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586444; x=1716191244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fqWIFmvD9JUaraiZpom6kTf9G8T11TFsgyyJnV2gt8=;
 b=bddkLczLTGjOpU2eNMUpoidai/Sigrnh2sMxrZAZIqqZdwofiGEhhA2ZndbDUM3Kjs
 BrAwYMd2pU7frI8SqGqGLJ4n8Caxh0pKDiRGhno2G+9inu+K+6W8yu++kVyU2L08iG2Y
 7foPtLErGrHmAvDC7Ttcy1NMv6D0lq0pPOvcr5tWdSiupuDZPL42/bXrM9nAw6835u9r
 9n/apNwR89eXXh07L3eZLsHUFSnqcachSKXu8W1yOV2ZEjGoFVmrXbVgl5BCCBTTtyG8
 87TWGtYt4T/sj7b23ebP1YIn9+Decyb4aCsk1fQ9nuT7fC+CYaodzKt7/09x7x1kMrgd
 N8Qw==
X-Gm-Message-State: AOJu0YyaGneC5RnSBA3tEPuTSLI0ZIwqWn2qevgzzT716jaIk5AU7G7e
 sdspvqEG+CXGt04LrUtgqCIjea5i0LC8TGVDw+e6O4o4Y2foTIgOYDcCvzU8QK92n3WKuKCYWR4
 8FTg=
X-Google-Smtp-Source: AGHT+IGw+MUXyr+5kp/dkxVFfsZSEt+sfP3tmbGlr/fpWnExQUCyZHXmRlz0EzGEezYajqGCXz9iZw==
X-Received: by 2002:a05:600c:4513:b0:41f:df08:5ef7 with SMTP id
 5b1f17b1804b1-41feac5a4a7mr66401265e9.28.1715586444197; 
 Mon, 13 May 2024 00:47:24 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 07/45] target/hppa: Add install_iaq_entries
Date: Mon, 13 May 2024 09:46:39 +0200
Message-Id: <20240513074717.130949-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

Instead of two separate cpu_iaoq_entry calls, use one call to update
both IAQ_Front and IAQ_Back.  Simplify with an argument combination
that automatically handles a simple increment from Front to Back.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 64 +++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d272be0e6e..08d5e2a4bc 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -617,6 +617,23 @@ static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
     }
 }
 
+static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
+                                uint64_t ni, TCGv_i64 nv)
+{
+    copy_iaoq_entry(ctx, cpu_iaoq_f, bi, bv);
+
+    /* Allow ni variable, with nv null, to indicate a trivial advance. */
+    if (ni != -1 || nv) {
+        copy_iaoq_entry(ctx, cpu_iaoq_b, ni, nv);
+    } else if (bi != -1) {
+        copy_iaoq_entry(ctx, cpu_iaoq_b, bi + 4, NULL);
+    } else {
+        tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_f, 4);
+        tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
+                         gva_offset_mask(ctx->tb_flags));
+    }
+}
+
 static inline uint64_t iaoq_dest(DisasContext *ctx, int64_t disp)
 {
     return ctx->iaoq_f + disp + 8;
@@ -629,8 +646,7 @@ static void gen_excp_1(int exception)
 
 static void gen_excp(DisasContext *ctx, int exception)
 {
-    copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
-    copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
+    install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
     nullify_save(ctx);
     gen_excp_1(exception);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -684,12 +700,10 @@ static void gen_goto_tb(DisasContext *ctx, int which,
 {
     if (use_goto_tb(ctx, b, n)) {
         tcg_gen_goto_tb(which);
-        copy_iaoq_entry(ctx, cpu_iaoq_f, b, NULL);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, n, NULL);
+        install_iaq_entries(ctx, b, NULL, n, NULL);
         tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, b, cpu_iaoq_b);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, n, ctx->iaoq_n_var);
+        install_iaq_entries(ctx, b, cpu_iaoq_b, n, ctx->iaoq_n_var);
         tcg_gen_lookup_and_goto_ptr();
     }
 }
@@ -1883,9 +1897,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         }
         if (is_n) {
             if (use_nullify_skip(ctx)) {
-                copy_iaoq_entry(ctx, cpu_iaoq_f, -1, next);
-                tcg_gen_addi_i64(next, next, 4);
-                copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
+                install_iaq_entries(ctx, -1, next, -1, NULL);
                 nullify_set(ctx, 0);
                 ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
                 return true;
@@ -1900,14 +1912,10 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
     nullify_over(ctx);
 
     if (is_n && use_nullify_skip(ctx)) {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, dest);
-        next = tcg_temp_new_i64();
-        tcg_gen_addi_i64(next, dest, 4);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
+        install_iaq_entries(ctx, -1, dest, -1, NULL);
         nullify_set(ctx, 0);
     } else {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, dest);
+        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
         nullify_set(ctx, is_n);
     }
     if (link != 0) {
@@ -1998,9 +2006,7 @@ static void do_page_zero(DisasContext *ctx)
         tcg_gen_st_i64(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
         tmp = tcg_temp_new_i64();
         tcg_gen_ori_i64(tmp, cpu_gr[31], 3);
-        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
-        tcg_gen_addi_i64(tmp, tmp, 4);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
+        install_iaq_entries(ctx, -1, tmp, -1, NULL);
         ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
         break;
 
@@ -2744,8 +2750,8 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
             nullify_over(ctx);
 
             /* Advance the instruction queue.  */
-            copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
-            copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
+            install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b,
+                                ctx->iaoq_n, ctx->iaoq_n_var);
             nullify_set(ctx, 0);
 
             /* Tell the qemu main loop to halt until this cpu has work.  */
@@ -3898,18 +3904,15 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
         tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
     }
     if (a->n && use_nullify_skip(ctx)) {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
-        tcg_gen_addi_i64(tmp, tmp, 4);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
+        install_iaq_entries(ctx, -1, tmp, -1, NULL);
         tcg_gen_mov_i64(cpu_iasq_f, new_spc);
         tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
         nullify_set(ctx, 0);
     } else {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, tmp);
         if (ctx->iaoq_b == -1) {
             tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
         }
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
         tcg_gen_mov_i64(cpu_iasq_b, new_spc);
         nullify_set(ctx, a->n);
     }
@@ -4018,11 +4021,10 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
     nullify_over(ctx);
     dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
 
-    copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+    install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
     if (ctx->iaoq_b == -1) {
         tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
     }
-    copy_iaoq_entry(ctx, cpu_iaoq_b, -1, dest);
     tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
     if (a->l) {
         copy_iaoq_entry(ctx, cpu_gr[a->l], ctx->iaoq_n, ctx->iaoq_n_var);
@@ -4721,8 +4723,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     case DISAS_IAQ_N_STALE:
     case DISAS_IAQ_N_STALE_EXIT:
         if (ctx->iaoq_f == -1) {
-            copy_iaoq_entry(ctx, cpu_iaoq_f, -1, cpu_iaoq_b);
-            copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
+            install_iaq_entries(ctx, -1, cpu_iaoq_b,
+                                ctx->iaoq_n, ctx->iaoq_n_var);
 #ifndef CONFIG_USER_ONLY
             tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
 #endif
@@ -4751,8 +4753,8 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     case DISAS_TOO_MANY:
     case DISAS_IAQ_N_STALE:
     case DISAS_IAQ_N_STALE_EXIT:
-        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
+        install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f,
+                            ctx->iaoq_b, cpu_iaoq_b);
         nullify_save(ctx);
         /* FALLTHRU */
     case DISAS_IAQ_N_UPDATED:
-- 
2.34.1


