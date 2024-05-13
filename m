Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32BFC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QR7-0005mZ-3v; Mon, 13 May 2024 03:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPU-0002vg-1J
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPO-0001PH-9x
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41ffad242c8so17045325e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586460; x=1716191260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJ2zWrxauyBUqiQFnwtq38MnWD5HOgNqg9osnBJC91k=;
 b=VtCtym0I7ay7cP37UNF0/FRGZutltWTwSu0BjmrhXn4EFLvYDQHoVF0GY22kO0vk2y
 6Aqo7a3sQViTqqU4bn5e3fhHta4ZOybE5WF2AaetryvUOeqgbDIKFnDudnpVPZz/lFK3
 bqcpUsGHqEf1J1miNyKXIv02jG5C9/Vgg2R1qfzrLpk+bp6UctzScLXYlzY+RssgX1uF
 K8VOdWJcULKciItVi9vFFQLizZQXnBO0se6QSa7nCl9i+gCEGr96YFvJ5tpS1uc6xMee
 tzQDgSsc5KabeyGqfcoOwNM8mOXtcB9gBLm8rwziEB9iPRupqmaJLG4ucF0jTEQoiwfB
 Y7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586460; x=1716191260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJ2zWrxauyBUqiQFnwtq38MnWD5HOgNqg9osnBJC91k=;
 b=XZfv8sqEPp8/eoyWaeHJt1gefQpnIHFOZ7IN5JkQiWCxQA49caXE2VtbyfFZYM1jU3
 ZvLj7OD06Ot3pYfxGEy2ZoWOhdfs3694vZ5WG+0vvr1f09rj2KeLesqkDk5S/c4N6szJ
 ptfaSQElQKZ7dYL9Kkwsz8LtfBR1LDRU+44u76CmqFBS7CniDtFUCWiTs5gZ2/xf8gOG
 +k1+823tzIyJodHMpumZ+I3dDsCp0XK5Z1B5Rc0I15Mu13G/0a53vtFLOoHIXuTXlTRS
 ya9mYZUOEa2kPJgw1h6w1WArAD9fPK4KwCd7gqMCpy/0BpQVzb9vKtc0yNWJxFbdVgym
 +p2Q==
X-Gm-Message-State: AOJu0Yz3kL6+0UKpKGOoMXD/v5jNCmBFfnKPfkApCJ0hJiCbXH8PIsvP
 PsOV6QqeBx5imbKTeENVmkmGbEUEEHv4931XAGBwY+WRDYHbazsu3wjlx+XwPdCcOFkd32Lsybw
 /3WY=
X-Google-Smtp-Source: AGHT+IFIWZc87eJnq0n3u8ioOBMGooX3YoC4kx7jtwFydWNTyX1YVqrGIQOzgiiDJkHxcHfYph0CqQ==
X-Received: by 2002:a05:600c:45c5:b0:41b:935:2492 with SMTP id
 5b1f17b1804b1-41fead6443fmr107475565e9.36.1715586459971; 
 Mon, 13 May 2024 00:47:39 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 29/45] target/hppa: Use delay_excp for conditional traps
Date: Mon, 13 May 2024 09:47:01 +0200
Message-Id: <20240513074717.130949-30-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  1 -
 target/hppa/int_helper.c |  2 +-
 target/hppa/op_helper.c  |  7 -------
 target/hppa/translate.c  | 41 ++++++++++++++++++++++++++++++----------
 4 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 5900fd70bc..3d0d143aed 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,6 +1,5 @@
 DEF_HELPER_2(excp, noreturn, env, int)
 DEF_HELPER_FLAGS_2(tsv, TCG_CALL_NO_WG, void, env, tl)
-DEF_HELPER_FLAGS_2(tcond, TCG_CALL_NO_WG, void, env, tl)
 
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index a667ee380d..1aa3e88ef1 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -134,13 +134,13 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         switch (i) {
         case EXCP_ILL:
         case EXCP_BREAK:
+        case EXCP_COND:
         case EXCP_PRIV_REG:
         case EXCP_PRIV_OPR:
             /* IIR set via translate.c.  */
             break;
 
         case EXCP_OVERFLOW:
-        case EXCP_COND:
         case EXCP_ASSIST:
         case EXCP_DTLB_MISS:
         case EXCP_NA_ITLB_MISS:
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 6cf49f33b7..a8b69fd481 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -49,13 +49,6 @@ void HELPER(tsv)(CPUHPPAState *env, target_ulong cond)
     }
 }
 
-void HELPER(tcond)(CPUHPPAState *env, target_ulong cond)
-{
-    if (unlikely(cond)) {
-        hppa_dynamic_excp(env, EXCP_COND, GETPC());
-    }
-}
-
 static void atomic_store_mask32(CPUHPPAState *env, target_ulong addr,
                                 uint32_t val, uint32_t mask, uintptr_t ra)
 {
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e75e7e5b54..7fa0c86a8f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1116,6 +1116,25 @@ static TCGv_i64 do_sub_sv(DisasContext *ctx, TCGv_i64 res,
     return sv;
 }
 
+static void gen_tc(DisasContext *ctx, DisasCond *cond)
+{
+    DisasDelayException *e;
+
+    switch (cond->c) {
+    case TCG_COND_NEVER:
+        break;
+    case TCG_COND_ALWAYS:
+        gen_excp_iir(ctx, EXCP_COND);
+        break;
+    default:
+        e = delay_excp(ctx, EXCP_COND);
+        tcg_gen_brcond_i64(cond->c, cond->a0, cond->a1, e->lab);
+        /* In the non-trap path, the condition is known false. */
+        *cond = cond_make_f();
+        break;
+    }
+}
+
 static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
                    TCGv_i64 in2, unsigned shift, bool is_l,
                    bool is_tsv, bool is_tc, bool is_c, unsigned cf, bool d)
@@ -1174,9 +1193,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
     /* Emit any conditional trap before any writeback.  */
     cond = do_cond(ctx, cf, d, dest, uv, sv);
     if (is_tc) {
-        tmp = tcg_temp_new_i64();
-        tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
-        gen_helper_tcond(tcg_env, tmp);
+        gen_tc(ctx, &cond);
     }
 
     /* Write back the result.  */
@@ -1195,6 +1212,10 @@ static bool do_add_reg(DisasContext *ctx, arg_rrr_cf_d_sh *a,
 {
     TCGv_i64 tcg_r1, tcg_r2;
 
+    if (unlikely(is_tc && a->cf == 1)) {
+        /* Unconditional trap on condition. */
+        return gen_excp_iir(ctx, EXCP_COND);
+    }
     if (a->cf) {
         nullify_over(ctx);
     }
@@ -1210,6 +1231,10 @@ static bool do_add_imm(DisasContext *ctx, arg_rri_cf *a,
 {
     TCGv_i64 tcg_im, tcg_r2;
 
+    if (unlikely(is_tc && a->cf == 1)) {
+        /* Unconditional trap on condition. */
+        return gen_excp_iir(ctx, EXCP_COND);
+    }
     if (a->cf) {
         nullify_over(ctx);
     }
@@ -1224,7 +1249,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
                    TCGv_i64 in2, bool is_tsv, bool is_b,
                    bool is_tc, unsigned cf, bool d)
 {
-    TCGv_i64 dest, sv, cb, cb_msb, tmp;
+    TCGv_i64 dest, sv, cb, cb_msb;
     unsigned c = cf >> 1;
     DisasCond cond;
 
@@ -1272,9 +1297,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
 
     /* Emit any conditional trap before any writeback.  */
     if (is_tc) {
-        tmp = tcg_temp_new_i64();
-        tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
-        gen_helper_tcond(tcg_env, tmp);
+        gen_tc(ctx, &cond);
     }
 
     /* Write back the result.  */
@@ -1440,9 +1463,7 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     }
 
     if (is_tc) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
-        gen_helper_tcond(tcg_env, tmp);
+        gen_tc(ctx, &cond);
     }
     save_gpr(ctx, rt, dest);
 
-- 
2.34.1


