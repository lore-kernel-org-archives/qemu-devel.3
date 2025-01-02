Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429BBE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbW-00071x-AO; Thu, 02 Jan 2025 13:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb5-0006w0-TF
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:05 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb1-000575-QC
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:01 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21670dce0a7so76203075ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841218; x=1736446018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=soe1rsCscQbZ/ZkLrhEkpkk1lHQAKgCug8phwx5O9Fo=;
 b=Dp0iK0+ySUHS1lnC84B3B4Rid06x16HsxFIsuk5/+5rYKyee/FF12GBDDeFaDcBDne
 0wUAZgRysivfQq3GJmMi3Jb2KZLJGcSzsb7QC9tA4gWmcgiuUs2Cjn7Fe+tFwwF7GwYs
 WTtF6wn1otw1cr/i+z/MiFgkTHWGKciHgWnge7p7ijTQmtWwWDslifZXD6g51f9YVM25
 XtKQupUFB1VHk9Spd02RdAxsG7vsd7lS/HLLd6PCUJYX6LYYTV6OkvtVNVbqGywSrtm3
 x/xZp6BUFbrEK3puP92/XqRXBMFfjyHbDaMoMe4UVyPpgoCAEhxuJczylHJ/pAWtMWTu
 bRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841218; x=1736446018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=soe1rsCscQbZ/ZkLrhEkpkk1lHQAKgCug8phwx5O9Fo=;
 b=maxQSUWwzEZP5uiz14qC6DcGGE7GeuK2FxEM0KgYUGPE9OYk6HRxLi9vJlcQ6psnMr
 s5Mk8DsMMiSLTOSP/0nSVpOizfek5wPk7txudjSpwtdFiuuL8rCb+x8psY2EdkDtBXoz
 3cLaMuqM48sBF508qa3z00XiORuRdOd5kvkpKgcYWII8IY6n1VNdaNINEt3k79/Yn3tK
 aoKiVycVs9nIduD32uuZwuPA2rCZ5X/glNTE6BY9ygmExW5rWASUzwNtReXMu8RVUYHW
 57yA2O6CLaymchcIoaNVuFB4qPi/QNFpjKkPinoKGwSxzQtVpY+eFnqOgrYF/Y86vWAr
 cPKg==
X-Gm-Message-State: AOJu0YwIIOVY6SWDGedueMYw5E3pWLdy1nSYxY5ONX8YzGqPJ7tAsDBI
 s+igVhltNmk6IPmjooCsubmP04NAamaryKAz6muNeNyJvcAfQHTshaZtu8Cm713g37kTMMU/9/Y
 i
X-Gm-Gg: ASbGncsWTQHUlhI6gnQ/0MUX85j6kncfGIb1n7xdcwEZQiDExHxBcunoXt/1AwXwOvy
 7GiZM20xciIMGqJT9FLYXZWBi1nfATGZftu93g6AJ/H9dlAhOlgYnNkUcstETHVbeu3U1z8FZJW
 WkGGwjIkJPaDbXAatxInJ0pE1A5E2vfrpQ7t8JUV+tTHiLkTXyazWviTTI0V5uWywst50iknrLT
 GVYksv511ni7X7TviSJS0RwCU/wgaXmafIb9TDiBqcKBDlZTCfX0shN5eZCgw==
X-Google-Smtp-Source: AGHT+IEIitwp16TYAXWVFcuk9oArCmPWHsPIwJdC8FyFliUHpoCRRZQnesqwg+yzgaE4HeotvTDbpQ==
X-Received: by 2002:a05:6a20:9c8d:b0:1e1:f281:8cec with SMTP id
 adf61e73a8af0-1e5e0481434mr69641649637.10.1735841218146; 
 Thu, 02 Jan 2025 10:06:58 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.06.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:06:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/73] tcg: Add TCGType argument to tcg_emit_op,
 tcg_op_insert_*
Date: Thu,  2 Jan 2025 10:05:43 -0800
Message-ID: <20250102180654.1420056-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

In some places we have a ready type to give.
In others, like tcg-op.c, simply pass 0 for now.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h |  8 +++++---
 include/tcg/tcg.h    |  6 +++---
 tcg/optimize.c       | 20 +++++++++++---------
 tcg/tcg-op-vec.c     |  8 ++++----
 tcg/tcg-op.c         | 12 ++++++------
 tcg/tcg.c            | 28 ++++++++++++++++------------
 6 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index a02850583b..50d29e2f97 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -25,13 +25,14 @@
 #ifndef TARGET_INSN_START_EXTRA_WORDS
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 64 / TCG_TARGET_REG_BITS);
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 0, 64 / TCG_TARGET_REG_BITS);
     tcg_set_insn_start_param(op, 0, pc);
 }
 #elif TARGET_INSN_START_EXTRA_WORDS == 1
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 2 * 64 / TCG_TARGET_REG_BITS);
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 0,
+                            2 * 64 / TCG_TARGET_REG_BITS);
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
 }
@@ -39,7 +40,8 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
                                       target_ulong a2)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 3 * 64 / TCG_TARGET_REG_BITS);
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 0,
+                            3 * 64 / TCG_TARGET_REG_BITS);
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
     tcg_set_insn_start_param(op, 2, a2);
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index f2ffb69c0c..901d89bbfe 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -850,12 +850,12 @@ void tcg_gen_call7(void *func, TCGHelperInfo *, TCGTemp *ret,
                    TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *,
                    TCGTemp *, TCGTemp *, TCGTemp *);
 
-TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs);
+TCGOp *tcg_emit_op(TCGOpcode opc, TCGType type, unsigned nargs);
 void tcg_op_remove(TCGContext *s, TCGOp *op);
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
-                            TCGOpcode opc, unsigned nargs);
+                            TCGOpcode opc, TCGType type, unsigned nargs);
 TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
-                           TCGOpcode opc, unsigned nargs);
+                           TCGOpcode opc, TCGType type, unsigned nargs);
 
 /**
  * tcg_remove_ops_after:
diff --git a/tcg/optimize.c b/tcg/optimize.c
index c23f0d1392..5298597b80 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -804,7 +804,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
     if (!TCG_TARGET_HAS_tst) {
         TCGOpcode and_opc = (ctx->type == TCG_TYPE_I32
                              ? INDEX_op_and_i32 : INDEX_op_and_i64);
-        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
+        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, op->type, 3);
         TCGArg tmp = arg_new_temp(ctx);
 
         op2->args[0] = tmp;
@@ -897,8 +897,10 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
 
     /* Expand to AND with a temporary if no backend support. */
     if (!TCG_TARGET_HAS_tst && is_tst_cond(c)) {
-        TCGOp *op1 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and_i32, 3);
-        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and_i32, 3);
+        TCGOp *op1 = tcg_op_insert_before(ctx->tcg, op,
+                                          INDEX_op_and_i32, TCG_TYPE_I32, 3);
+        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op,
+                                          INDEX_op_and_i32, TCG_TYPE_I32, 3);
         TCGArg t1 = arg_new_temp(ctx);
         TCGArg t2 = arg_new_temp(ctx);
 
@@ -1259,7 +1261,7 @@ static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
         rh = op->args[1];
 
         /* The proper opcode is supplied by tcg_opt_gen_mov. */
-        op2 = tcg_op_insert_before(ctx->tcg, op, 0, 2);
+        op2 = tcg_op_insert_before(ctx->tcg, op, 0, op->type, 2);
 
         tcg_opt_gen_movi(ctx, op, rl, al);
         tcg_opt_gen_movi(ctx, op2, rh, ah);
@@ -2092,7 +2094,7 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
         rh = op->args[1];
 
         /* The proper opcode is supplied by tcg_opt_gen_mov. */
-        op2 = tcg_op_insert_before(ctx->tcg, op, 0, 2);
+        op2 = tcg_op_insert_before(ctx->tcg, op, 0, op->type, 2);
 
         tcg_opt_gen_movi(ctx, op, rl, l);
         tcg_opt_gen_movi(ctx, op2, rh, h);
@@ -2398,7 +2400,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op->args[3] = 1;
     } else {
         if (sh) {
-            op2 = tcg_op_insert_before(ctx->tcg, op, shr_opc, 3);
+            op2 = tcg_op_insert_before(ctx->tcg, op, shr_opc, op->type, 3);
             op2->args[0] = ret;
             op2->args[1] = src1;
             op2->args[2] = arg_new_constant(ctx, sh);
@@ -2410,17 +2412,17 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     }
 
     if (neg && inv) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, sub_opc, 3);
+        op2 = tcg_op_insert_after(ctx->tcg, op, sub_opc, op->type, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, 1);
     } else if (inv) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, xor_opc, 3);
+        op2 = tcg_op_insert_after(ctx->tcg, op, xor_opc, op->type, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, 1);
     } else if (neg) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, neg_opc, 2);
+        op2 = tcg_op_insert_after(ctx->tcg, op, neg_opc, op->type, 2);
         op2->args[0] = ret;
         op2->args[1] = ret;
     }
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index d4bb4aee74..6ade58da54 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -142,7 +142,7 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
 
 void vec_gen_2(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r, TCGArg a)
 {
-    TCGOp *op = tcg_emit_op(opc, 2);
+    TCGOp *op = tcg_emit_op(opc, type, 2);
     TCGOP_VECL(op) = type - TCG_TYPE_V64;
     TCGOP_VECE(op) = vece;
     op->args[0] = r;
@@ -152,7 +152,7 @@ void vec_gen_2(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r, TCGArg a)
 void vec_gen_3(TCGOpcode opc, TCGType type, unsigned vece,
                TCGArg r, TCGArg a, TCGArg b)
 {
-    TCGOp *op = tcg_emit_op(opc, 3);
+    TCGOp *op = tcg_emit_op(opc, type, 3);
     TCGOP_VECL(op) = type - TCG_TYPE_V64;
     TCGOP_VECE(op) = vece;
     op->args[0] = r;
@@ -163,7 +163,7 @@ void vec_gen_3(TCGOpcode opc, TCGType type, unsigned vece,
 void vec_gen_4(TCGOpcode opc, TCGType type, unsigned vece,
                TCGArg r, TCGArg a, TCGArg b, TCGArg c)
 {
-    TCGOp *op = tcg_emit_op(opc, 4);
+    TCGOp *op = tcg_emit_op(opc, type, 4);
     TCGOP_VECL(op) = type - TCG_TYPE_V64;
     TCGOP_VECE(op) = vece;
     op->args[0] = r;
@@ -175,7 +175,7 @@ void vec_gen_4(TCGOpcode opc, TCGType type, unsigned vece,
 void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
                TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e)
 {
-    TCGOp *op = tcg_emit_op(opc, 6);
+    TCGOp *op = tcg_emit_op(opc, type, 6);
     TCGOP_VECL(op) = type - TCG_TYPE_V64;
     TCGOP_VECE(op) = vece;
     op->args[0] = r;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4a7e705367..44ab916a4d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -39,14 +39,14 @@
 
 TCGOp * NI tcg_gen_op1(TCGOpcode opc, TCGArg a1)
 {
-    TCGOp *op = tcg_emit_op(opc, 1);
+    TCGOp *op = tcg_emit_op(opc, 0, 1);
     op->args[0] = a1;
     return op;
 }
 
 TCGOp * NI tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
 {
-    TCGOp *op = tcg_emit_op(opc, 2);
+    TCGOp *op = tcg_emit_op(opc, 0, 2);
     op->args[0] = a1;
     op->args[1] = a2;
     return op;
@@ -54,7 +54,7 @@ TCGOp * NI tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
 
 TCGOp * NI tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
 {
-    TCGOp *op = tcg_emit_op(opc, 3);
+    TCGOp *op = tcg_emit_op(opc, 0, 3);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
@@ -64,7 +64,7 @@ TCGOp * NI tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
 TCGOp * NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2,
                        TCGArg a3, TCGArg a4)
 {
-    TCGOp *op = tcg_emit_op(opc, 4);
+    TCGOp *op = tcg_emit_op(opc, 0, 4);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
@@ -75,7 +75,7 @@ TCGOp * NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2,
 TCGOp * NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2,
                        TCGArg a3, TCGArg a4, TCGArg a5)
 {
-    TCGOp *op = tcg_emit_op(opc, 5);
+    TCGOp *op = tcg_emit_op(opc, 0, 5);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
@@ -87,7 +87,7 @@ TCGOp * NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2,
 TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
                        TCGArg a4, TCGArg a5, TCGArg a6)
 {
-    TCGOp *op = tcg_emit_op(opc, 6);
+    TCGOp *op = tcg_emit_op(opc, 0, 6);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 9a1e85ba41..717c313b33 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2252,7 +2252,7 @@ bool tcg_op_supported(TCGOpcode op)
     }
 }
 
-static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs);
+static TCGOp *tcg_op_alloc(TCGOpcode opc, TCGType type, unsigned nargs);
 
 static void tcg_gen_callN(void *func, TCGHelperInfo *info,
                           TCGTemp *ret, TCGTemp **args)
@@ -2268,7 +2268,7 @@ static void tcg_gen_callN(void *func, TCGHelperInfo *info,
     }
 
     total_args = info->nr_out + info->nr_in + 2;
-    op = tcg_op_alloc(INDEX_op_call, total_args);
+    op = tcg_op_alloc(INDEX_op_call, info->out_type, total_args);
 
 #ifdef CONFIG_PLUGIN
     /* Flag helpers that may affect guest state */
@@ -3217,7 +3217,7 @@ void tcg_remove_ops_after(TCGOp *op)
     }
 }
 
-static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs)
+static TCGOp *tcg_op_alloc(TCGOpcode opc, TCGType type, unsigned nargs)
 {
     TCGContext *s = tcg_ctx;
     TCGOp *op = NULL;
@@ -3239,6 +3239,7 @@ static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs)
  found:
     memset(op, 0, offsetof(TCGOp, link));
     op->opc = opc;
+    op->type = type;
     op->nargs = nargs;
 
     /* Check for bitfield overflow. */
@@ -3248,9 +3249,9 @@ static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs)
     return op;
 }
 
-TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs)
+TCGOp *tcg_emit_op(TCGOpcode opc, TCGType type, unsigned nargs)
 {
-    TCGOp *op = tcg_op_alloc(opc, nargs);
+    TCGOp *op = tcg_op_alloc(opc, type, nargs);
 
     if (tcg_ctx->emit_before_op) {
         QTAILQ_INSERT_BEFORE(tcg_ctx->emit_before_op, op, link);
@@ -3261,17 +3262,17 @@ TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs)
 }
 
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *old_op,
-                            TCGOpcode opc, unsigned nargs)
+                            TCGOpcode opc, TCGType type, unsigned nargs)
 {
-    TCGOp *new_op = tcg_op_alloc(opc, nargs);
+    TCGOp *new_op = tcg_op_alloc(opc, type, nargs);
     QTAILQ_INSERT_BEFORE(old_op, new_op, link);
     return new_op;
 }
 
 TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *old_op,
-                           TCGOpcode opc, unsigned nargs)
+                           TCGOpcode opc, TCGType type, unsigned nargs)
 {
-    TCGOp *new_op = tcg_op_alloc(opc, nargs);
+    TCGOp *new_op = tcg_op_alloc(opc, type, nargs);
     QTAILQ_INSERT_AFTER(&s->ops, old_op, new_op, link);
     return new_op;
 }
@@ -4020,7 +4021,8 @@ liveness_pass_2(TCGContext *s)
                 TCGOpcode lopc = (arg_ts->type == TCG_TYPE_I32
                                   ? INDEX_op_ld_i32
                                   : INDEX_op_ld_i64);
-                TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
+                TCGOp *lop = tcg_op_insert_before(s, op, lopc,
+                                                  arg_ts->type, 3);
 
                 lop->args[0] = temp_arg(dir_ts);
                 lop->args[1] = temp_arg(arg_ts->mem_base);
@@ -4083,7 +4085,8 @@ liveness_pass_2(TCGContext *s)
                     TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
                                       ? INDEX_op_st_i32
                                       : INDEX_op_st_i64);
-                    TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
+                    TCGOp *sop = tcg_op_insert_after(s, op, sopc,
+                                                     arg_ts->type, 3);
                     TCGTemp *out_ts = dir_ts;
 
                     if (IS_DEAD_ARG(0)) {
@@ -4119,7 +4122,8 @@ liveness_pass_2(TCGContext *s)
                     TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
                                       ? INDEX_op_st_i32
                                       : INDEX_op_st_i64);
-                    TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
+                    TCGOp *sop = tcg_op_insert_after(s, op, sopc,
+                                                     arg_ts->type, 3);
 
                     sop->args[0] = temp_arg(dir_ts);
                     sop->args[1] = temp_arg(arg_ts->mem_base);
-- 
2.43.0


