Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892E6C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPR-0002uB-EQ; Mon, 13 May 2024 03:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPA-0002lm-3r
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP8-0001Kc-Es
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-420180b58c5so2777935e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586445; x=1716191245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXFpuVHpxKbMUJ9pV2dQPsLv9dNGE0YAs5T7H/TUn1I=;
 b=Jdh8UeR3l5zbMMygcvJu/q42TJH14+wXZN6U/HLhL/k8Pt5OOeO8lYWpPgTiMP5FLf
 SLe70u+m//+54xOz0hxOsHE8qhUS3Rnf5e6B1/yoG/OImQV1753lnKrDI+RUmy0GG2g+
 OyxS2Myz4zFnVxdrwkWG0dBVFlDDTM5bllwbfz1DpTmrho6RmaziiTghPmn6BbTAJosm
 DMFwqUPfBGzbGMpJzi2LH0q9J9LWU3rKIIJ9rlvjCZnIh1A3UeOTcomNyGq6C/gLFID1
 XQ/pz9/OfnKmdI4E/T14mqI6AsO4nR0MMleVj3+1+eESh/7mag7mfppy2lCbY3/NkKS5
 mU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586445; x=1716191245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXFpuVHpxKbMUJ9pV2dQPsLv9dNGE0YAs5T7H/TUn1I=;
 b=mg7vcmpO2PHW47D/iVnnRHIIQgJxow9yuLj4SKil44KR3VOK3qg1a5t8eVI58QI2fZ
 Ofzb/eduUJOof5wdT+G8/ecG9bQQeQF3taErfuaXHc5pF9vK2XX23FLEjGLrEUpWAdWh
 zQkhqMSHsovqOe6jlVpK2AQbpaPmuJuxb2l1POebe0q4ag4+ylAFcr0e//rj+Lil9Iww
 cJMus+jzlXrV4+xQUATBj2doAu2QPk+qGXSSjulHaaYDtZdhbq+UNkkQOnksdrFi2UvW
 BFlg5oS+06aQBHC4QgDMRaerKfx4undHZ0hmSmDzrkxlKfI/FnGujpwtQ3VGp0KdmvLn
 Oagw==
X-Gm-Message-State: AOJu0Yw+/NjgT4bk0o784wKx+3Bn8p7Kv5rDVzrbDv4zkbtr7sBTUkNy
 nAnreMUoVoK1G+4p7qBNVVwVOfZQCaOOws4kdJWxSEcmHX8GxXVU7c4w0QCKrwocA3BTGip1uhP
 7eKY=
X-Google-Smtp-Source: AGHT+IESW9pwJLP+NuMrYV11aAZpqdaCaax6uxkv2tzt9qTJ6C8q24sCa+d83YWeuzkZNjiVvxTx9g==
X-Received: by 2002:a05:600c:3b23:b0:41b:f3b6:e5da with SMTP id
 5b1f17b1804b1-41fead61b59mr82069875e9.36.1715586444799; 
 Mon, 13 May 2024 00:47:24 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 08/45] target/hppa: Add install_link
Date: Mon, 13 May 2024 09:46:40 +0200
Message-Id: <20240513074717.130949-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

Add a common routine for writing the return address.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 54 +++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 08d5e2a4bc..f816b337ee 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -634,6 +634,23 @@ static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
     }
 }
 
+static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
+{
+    tcg_debug_assert(ctx->null_cond.c == TCG_COND_NEVER);
+    if (link) {
+        if (ctx->iaoq_b == -1) {
+            tcg_gen_addi_i64(cpu_gr[link], cpu_iaoq_b, 4);
+        } else {
+            tcg_gen_movi_i64(cpu_gr[link], ctx->iaoq_b + 4);
+        }
+#ifndef CONFIG_USER_ONLY
+        if (with_sr0) {
+            tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
+        }
+#endif
+    }
+}
+
 static inline uint64_t iaoq_dest(DisasContext *ctx, int64_t disp)
 {
     return ctx->iaoq_f + disp + 8;
@@ -1787,9 +1804,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
     uint64_t dest = iaoq_dest(ctx, disp);
 
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
-        if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-        }
+        install_link(ctx, link, false);
         ctx->iaoq_n = dest;
         if (is_n) {
             ctx->null_cond.c = TCG_COND_ALWAYS;
@@ -1797,10 +1812,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
     } else {
         nullify_over(ctx);
 
-        if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-        }
-
+        install_link(ctx, link, false);
         if (is_n && use_nullify_skip(ctx)) {
             nullify_set(ctx, 0);
             gen_goto_tb(ctx, 0, dest, dest + 4);
@@ -1892,9 +1904,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         next = tcg_temp_new_i64();
         tcg_gen_mov_i64(next, dest);
 
-        if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-        }
+        install_link(ctx, link, false);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
                 install_iaq_entries(ctx, -1, next, -1, NULL);
@@ -1911,16 +1921,17 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
 
     nullify_over(ctx);
 
+    next = tcg_temp_new_i64();
+    tcg_gen_mov_i64(next, dest);
+
+    install_link(ctx, link, false);
     if (is_n && use_nullify_skip(ctx)) {
-        install_iaq_entries(ctx, -1, dest, -1, NULL);
+        install_iaq_entries(ctx, -1, next, -1, NULL);
         nullify_set(ctx, 0);
     } else {
-        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
+        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, next);
         nullify_set(ctx, is_n);
     }
-    if (link != 0) {
-        copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-    }
 
     tcg_gen_lookup_and_goto_ptr();
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -3899,10 +3910,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     nullify_over(ctx);
 
     load_spr(ctx, new_spc, a->sp);
-    if (a->l) {
-        copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
-        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
-    }
+    install_link(ctx, a->l, true);
     if (a->n && use_nullify_skip(ctx)) {
         install_iaq_entries(ctx, -1, tmp, -1, NULL);
         tcg_gen_mov_i64(cpu_iasq_f, new_spc);
@@ -4019,16 +4027,16 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
     return do_ibranch(ctx, dest, a->l, a->n);
 #else
     nullify_over(ctx);
-    dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
+    dest = tcg_temp_new_i64();
+    tcg_gen_mov_i64(dest, load_gpr(ctx, a->b));
+    dest = do_ibranch_priv(ctx, dest);
 
+    install_link(ctx, a->l, false);
     install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
     if (ctx->iaoq_b == -1) {
         tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
     }
     tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
-    if (a->l) {
-        copy_iaoq_entry(ctx, cpu_gr[a->l], ctx->iaoq_n, ctx->iaoq_n_var);
-    }
     nullify_set(ctx, a->n);
     tcg_gen_lookup_and_goto_ptr();
     ctx->base.is_jmp = DISAS_NORETURN;
-- 
2.34.1


