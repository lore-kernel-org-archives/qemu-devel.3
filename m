Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83EBC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPN-0002rq-IO; Mon, 13 May 2024 03:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPF-0002na-Qf
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPC-0001Lu-K0
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41fd5dc0439so26310265e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586449; x=1716191249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xp3g9SWSbwoRWLnfVTrOPQ81mic5NN+NsyJ7n/6Ty/A=;
 b=jMqIdoqI9X3KtvOB9maGN3jmpDPUFeou8NdbZJM6oqNgt/RtXmQw1eS5MxqpGLRV0V
 p1U+7jsQar0Uh3kiVUnQbm4BHkrpF895sWF9nZajwmvh15CdOc/jLnH56VrkDcRW5KdI
 C1Ond9OIxJJJMvlERo0o7Jw2P9heQtGbCsUZVcdhTb32Nmz/WcS9uQKdESU1+ROfaimA
 T7TXKEKpdERvxyXKqVLjBKhvZnHefiscTRFtDOhRED7ebN5Tg9sVQWVrCt+WsMMLhHzt
 zqPt6gNgOHOM7vgM0qaDlnKjr47fpsFYsRAysEnJf7wlF+rlP88qDW6F+/zCz44XaaeB
 ZA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586449; x=1716191249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xp3g9SWSbwoRWLnfVTrOPQ81mic5NN+NsyJ7n/6Ty/A=;
 b=ZFyeCi7TQJwfC/aEzV6ur9zXrNrqHcdwxyk2aqCv3R5kBBABXtSqZVpPrWdzUxj5mr
 EtaglFzlhfT88T3lWQTnxrk+QiB17NT8Ev6N5kwV1I9eSARwjgmdrpsSr1LNmjl1GSPR
 oCgBpGMfGcrPOEMyJY9oysJLcIU1bDQYL2cjTCDIo0NVz92mjBMB/8c83J+M3EzCtMey
 Me3KMtbFA9u+ueuDB1kAQu9Di5Nu3k8qfZrTKidqtZEQH/T7lErTBoKyKvjgAj7d98xK
 /qsOHEvbMRMOcZmy8eDtUHiTi2soVYbzwpcHfpGuoTW36Mjioo5aJmk91XpunQqRKEL2
 1gSA==
X-Gm-Message-State: AOJu0YzfBRyJf/tU0UIQmicDMPgDE+v8AJLFr6MDEhkHaKdhDt97/YkS
 TXGCYXlxYbigTMJkh8ak3EX/wIM/g4MuAix2Sbho07w3MzPBtPwWwAt99RyGzCTeKV3JaT4HY9M
 dqQ8=
X-Google-Smtp-Source: AGHT+IFlnaBBxXaeJT+ZyHS+M6y2tAbC9Nc2TfByGHxQacvnjJyK51mEwGaDtVL/iMS+cQoHk0JP6Q==
X-Received: by 2002:a05:600c:470d:b0:420:e4b:d9df with SMTP id
 5b1f17b1804b1-4200e4bdcf6mr46792625e9.13.1715586449301; 
 Mon, 13 May 2024 00:47:29 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 14/45] target/hppa: Add space argument to do_ibranch
Date: Mon, 13 May 2024 09:46:46 +0200
Message-Id: <20240513074717.130949-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

This allows unification of BE, BLR, BV, BVE with a common helper.
Since we can now track space with IAQ_Next, we can now let the
TranslationBlock continue across the delay slot with BE, BVE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 76 ++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 50 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 05383dcd04..ae66068123 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1913,8 +1913,8 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 
 /* Emit an unconditional branch to an indirect target.  This handles
    nullification of the branch itself.  */
-static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
-                       unsigned link, bool is_n)
+static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 dspc,
+                       unsigned link, bool with_sr0, bool is_n)
 {
     TCGv_i64 next;
 
@@ -1922,10 +1922,10 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         next = tcg_temp_new_i64();
         tcg_gen_mov_i64(next, dest);
 
-        install_link(ctx, link, false);
+        install_link(ctx, link, with_sr0);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
-                install_iaq_entries(ctx, -1, next, NULL, -1, NULL, NULL);
+                install_iaq_entries(ctx, -1, next, dspc, -1, NULL, NULL);
                 nullify_set(ctx, 0);
                 ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
                 return true;
@@ -1934,6 +1934,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         }
         ctx->iaoq_n = -1;
         ctx->iaoq_n_var = next;
+        ctx->iasq_n = dspc;
         return true;
     }
 
@@ -1942,13 +1943,13 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
     next = tcg_temp_new_i64();
     tcg_gen_mov_i64(next, dest);
 
-    install_link(ctx, link, false);
+    install_link(ctx, link, with_sr0);
     if (is_n && use_nullify_skip(ctx)) {
-        install_iaq_entries(ctx, -1, next, NULL, -1, NULL, NULL);
+        install_iaq_entries(ctx, -1, next, dspc, -1, NULL, NULL);
         nullify_set(ctx, 0);
     } else {
         install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
-                            -1, next, NULL);
+                            -1, next, dspc);
         nullify_set(ctx, is_n);
     }
 
@@ -3915,33 +3916,18 @@ static bool trans_depi_sar(DisasContext *ctx, arg_depi_sar *a)
 
 static bool trans_be(DisasContext *ctx, arg_be *a)
 {
-    TCGv_i64 tmp;
+    TCGv_i64 dest = tcg_temp_new_i64();
+    TCGv_i64 space = NULL;
 
-    tmp = tcg_temp_new_i64();
-    tcg_gen_addi_i64(tmp, load_gpr(ctx, a->b), a->disp);
-    tmp = do_ibranch_priv(ctx, tmp);
+    tcg_gen_addi_i64(dest, load_gpr(ctx, a->b), a->disp);
+    dest = do_ibranch_priv(ctx, dest);
 
-#ifdef CONFIG_USER_ONLY
-    return do_ibranch(ctx, tmp, a->l, a->n);
-#else
-    TCGv_i64 new_spc = tcg_temp_new_i64();
-
-    nullify_over(ctx);
-
-    load_spr(ctx, new_spc, a->sp);
-    install_link(ctx, a->l, true);
-    if (a->n && use_nullify_skip(ctx)) {
-        install_iaq_entries(ctx, -1, tmp, new_spc, -1, NULL, new_spc);
-        nullify_set(ctx, 0);
-    } else {
-        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
-                            -1, tmp, new_spc);
-        nullify_set(ctx, a->n);
-    }
-    tcg_gen_lookup_and_goto_ptr();
-    ctx->base.is_jmp = DISAS_NORETURN;
-    return nullify_end(ctx);
+#ifndef CONFIG_USER_ONLY
+    space = tcg_temp_new_i64();
+    load_spr(ctx, space, a->sp);
 #endif
+
+    return do_ibranch(ctx, dest, space, a->l, true, a->n);
 }
 
 static bool trans_bl(DisasContext *ctx, arg_bl *a)
@@ -4010,7 +3996,7 @@ static bool trans_blr(DisasContext *ctx, arg_blr *a)
         tcg_gen_shli_i64(tmp, load_gpr(ctx, a->x), 3);
         tcg_gen_addi_i64(tmp, tmp, ctx->iaoq_f + 8);
         /* The computation here never changes privilege level.  */
-        return do_ibranch(ctx, tmp, a->l, a->n);
+        return do_ibranch(ctx, tmp, NULL, a->l, false, a->n);
     } else {
         /* BLR R0,RX is a good way to load PC+8 into RX.  */
         return do_dbranch(ctx, 0, a->l, a->n);
@@ -4029,30 +4015,20 @@ static bool trans_bv(DisasContext *ctx, arg_bv *a)
         tcg_gen_add_i64(dest, dest, load_gpr(ctx, a->b));
     }
     dest = do_ibranch_priv(ctx, dest);
-    return do_ibranch(ctx, dest, 0, a->n);
+    return do_ibranch(ctx, dest, NULL, 0, false, a->n);
 }
 
 static bool trans_bve(DisasContext *ctx, arg_bve *a)
 {
-    TCGv_i64 dest;
+    TCGv_i64 b = load_gpr(ctx, a->b);
+    TCGv_i64 dest = do_ibranch_priv(ctx, b);
+    TCGv_i64 space = NULL;
 
-#ifdef CONFIG_USER_ONLY
-    dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
-    return do_ibranch(ctx, dest, a->l, a->n);
-#else
-    nullify_over(ctx);
-    dest = tcg_temp_new_i64();
-    tcg_gen_mov_i64(dest, load_gpr(ctx, a->b));
-    dest = do_ibranch_priv(ctx, dest);
-
-    install_link(ctx, a->l, false);
-    install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
-                        -1, dest, space_select(ctx, 0, dest));
-    nullify_set(ctx, a->n);
-    tcg_gen_lookup_and_goto_ptr();
-    ctx->base.is_jmp = DISAS_NORETURN;
-    return nullify_end(ctx);
+#ifndef CONFIG_USER_ONLY
+    space = space_select(ctx, 0, b);
 #endif
+
+    return do_ibranch(ctx, dest, space, a->l, false, a->n);
 }
 
 static bool trans_nopbts(DisasContext *ctx, arg_nopbts *a)
-- 
2.34.1


