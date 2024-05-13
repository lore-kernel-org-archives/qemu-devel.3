Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB2AC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QQ0-0003KK-4P; Mon, 13 May 2024 03:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPC-0002mj-Fg
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:30 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP9-0001L1-M6
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:30 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2dfb4ea2bbfso46219841fa.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586446; x=1716191246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKPKqoJyvGy1vMUAPJNKmuXb3GsYUFhU8QNMCUCZlFY=;
 b=cs8+DM+epqTnfRXHdEfzFGfp1CTT02EcInoRAVX/R0af2JV7eUPCJOQnUZUE7PrDWJ
 +K0JTilhUp0aWNNe5HH9+yvuVBozCblUINwURiujhm22ql+bVMHneBTWAz7ZPHq9Nh7A
 oq1x89jXP3XGRsYuzxKcCYU+mLTuoCDMpEz0sHk7ASpcrBfwtardOJPtIa317IVC5Ji+
 eIZR7LAO0344CWHJsf1+OLBy0BCYleRbPeu10fJ/RyF9fgMHk2wWpx1cdK9oNQlOOI0o
 sDk3YeAuecqW6F+nlBmymEIMYS4NB+JJ4dtvhxI96+xCYguYX+JjEvfADhTm9yFwZlyz
 XCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586446; x=1716191246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKPKqoJyvGy1vMUAPJNKmuXb3GsYUFhU8QNMCUCZlFY=;
 b=KSgM6hDQCzOpsMIPrtBLU3/OLtQrgVLBww8BuqS2PuwPA/aVQ3w8kOPx4XTTAcVMSx
 GddafGoKc/sfE3Xns0MKTysecLREqxIkc+K3GRy8TBB302RlOgAcwUnC9jFhyMWs/+2Z
 l5it6YSCKynE/+C2QhkhUJfatIixDMBwI4EyQqjOabKLTHQgqR8IH6h4/bjcSRzfDl53
 HxcOV1dj3tfHO8JAlJeCAWVTy9BekFXTKJmcXJIC0FRZJTODMTsLBrk+73qqjGHZv3I4
 rRT5sico7qYMs047wpqk4Zjh94Y/TO+U/1KfWKvvdQYhO8EhWSIPcgx7cesu+/EZgZhc
 d0CQ==
X-Gm-Message-State: AOJu0YyrPfY6JUq5hNYSHJAFmnVGS6wDQs3io22UkUwvElez3Ryk+Qvx
 s+ejBZ04TgdeDqSVEusrcndSmUvOLNiOBpe8XPnCMM4cY3f6tR5XfHel8JpgJs66AC0DHqsPScm
 kG0I=
X-Google-Smtp-Source: AGHT+IF3tbWxEVHSLbDklIm7mn76WGBNXinqSXuakNB/MYBmXrAnuLtYMZ0rr85nrq+t1i69nOc5tg==
X-Received: by 2002:a2e:b01a:0:b0:2e6:a0b3:24a3 with SMTP id
 38308e7fff4ca-2e6a0b326fdmr10299631fa.4.1715586445704; 
 Mon, 13 May 2024 00:47:25 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 09/45] target/hppa: Delay computation of IAQ_Next
Date: Mon, 13 May 2024 09:46:41 +0200
Message-Id: <20240513074717.130949-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
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

We no longer have to allocate a temp and perform an
addition before translation of the rest of the insn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f816b337ee..a9196050dc 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1806,6 +1806,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         install_link(ctx, link, false);
         ctx->iaoq_n = dest;
+        ctx->iaoq_n_var = NULL;
         if (is_n) {
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
@@ -1862,11 +1863,6 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
             ctx->null_lab = NULL;
         }
         nullify_set(ctx, n);
-        if (ctx->iaoq_n == -1) {
-            /* The temporary iaoq_n_var died at the branch above.
-               Regenerate it here instead of saving it.  */
-            tcg_gen_addi_i64(ctx->iaoq_n_var, cpu_iaoq_b, 4);
-        }
         gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
     }
 
@@ -4630,8 +4626,6 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->iaoq_f = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
     ctx->iaoq_b = (diff ? ctx->iaoq_f + diff : -1);
 #endif
-    ctx->iaoq_n = -1;
-    ctx->iaoq_n_var = NULL;
 
     ctx->zero = tcg_constant_i64(0);
 
@@ -4683,14 +4677,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
-        if (ctx->iaoq_b == -1) {
-            ctx->iaoq_n = -1;
-            ctx->iaoq_n_var = tcg_temp_new_i64();
-            tcg_gen_addi_i64(ctx->iaoq_n_var, cpu_iaoq_b, 4);
-        } else {
-            ctx->iaoq_n = ctx->iaoq_b + 4;
-            ctx->iaoq_n_var = NULL;
-        }
+        ctx->iaoq_n_var = NULL;
+        ctx->iaoq_n = ctx->iaoq_b == -1 ? -1 : ctx->iaoq_b + 4;
 
         if (unlikely(ctx->null_cond.c == TCG_COND_ALWAYS)) {
             ctx->null_cond.c = TCG_COND_NEVER;
@@ -4741,7 +4729,13 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
                                 ? DISAS_EXIT
                                 : DISAS_IAQ_N_UPDATED);
         } else if (ctx->iaoq_b == -1) {
-            copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
+            if (ctx->iaoq_n_var) {
+                copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
+            } else {
+                tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_b, 4);
+                tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
+                                 gva_offset_mask(ctx->tb_flags));
+            }
         }
         break;
 
-- 
2.34.1


