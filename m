Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAECEB104B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzuai-00071n-9u; Tue, 10 Mar 2026 06:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuah-00071P-5z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:31 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuaf-0005mE-2r
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:30 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439af7d77f0so8193318f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139527; x=1773744327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9SiM0aZpYgVuME72hfnbrWV6wSdRgMqhdwAij3V3ZC4=;
 b=BSxIScmz6e1nJksB2ZgqUWZ4fKLs2avRbsEVWmpHt/s+BrOMSsvf80hx3sO7RiXCTI
 mFLHmuWqiNL+5cZGvuDnlRm0ABuIdXEVwmD7F5PKFmQmGy9tBUnXUvP+MTSYy5WJNUtH
 sim45tbBXSdTnTiYJoPCwofDBzs9OFOKLk14o+uJESzUvwJWBfsRwQH9GjYMyXLaLuWZ
 MDB9FFYTHhk9bghXOlsiMwSzQFTcE3koxmSAnRiuOpfOZzZ/hFa0KhXNoaeO6NO4m5uO
 6g5lwHS+gLA9CVhvKwN2FaPKwyIPt5NcomPcf8o4GAWPFmWXY69p7d1cqsPtGI9e5F1d
 D/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139527; x=1773744327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9SiM0aZpYgVuME72hfnbrWV6wSdRgMqhdwAij3V3ZC4=;
 b=ZFwQUQoZR0NLY4xN4cX7oI5cAHzqDZk2eQd4wH4rknX+6cGVPdF1qguotHry+2xqQq
 BLBIFrIJonzYoys9BW7HWKVqPbzpEc6vv0H3iR5jUrgSi8b2kW8PiXNytpdIgC/EYVtJ
 WHp13UoXw9kZ6TTBdNA597fe/X0DjpE+ptd8i8lV6qXmnu0hNHeNY4zeFpsXEJtpjYyl
 1hUbpw1ii8fZb4+sBfgdWfjQLfOfu1732iefp1r7aiKkC4ufDq0Zpk9xWFl9IFzr+9P3
 BtGgvh6SN1a8813rTnZJ9ByJgsFrSN/HjAUsW99+4DLfYaKUhZzkFByYLi7WAsu5Ejnk
 dJgA==
X-Gm-Message-State: AOJu0Yz8jTSAatmiMxM3DiQXWmdwTVR654LMehlUcoskvtf4l0/8RVPl
 I7ZNrwCWUShurCCKyP8dO4lKT5wMAJ2W2TL06wyg14Of9NaltPcDhQXjN3gvXaeseWQU0qNT5Gs
 cRKJtxdE=
X-Gm-Gg: ATEYQzyJ0q1Sr98IbpGGMeXiLQtwJEiO2loUTlscA1IqCks3hkz8w0sXDn/V7LnZjjl
 2c6wZZyCGrbXAYBchYigL2a47lubMSFgiiE9zYC1uZ1tvjok//nFkSYBLf8qBn6I2vIqta9f4/n
 sd/zOuKo2O9hGtLeRN0DRujAQk0X876uPTdoeL+yV6qt0R/MvMDiKFlh9ijj69HMESowE3OjXtW
 jkzCzoUJnWZITmsPnc+OBHeAdO1ky+JyBtmKpc1lTabKBzese1ZCZ3rnCwjBtpLojvUnzG2ypmk
 Ypss5R0ldWvMKUyqJaj9gcXqRjxofPv/6ZjU1zngQJBnry8SFiwSrBxYJUt5pRve7KUfz81Oc+i
 NrP/TF2Rkqbei5KNyqLE/K3W+N6+0dmLX0pbndv4divzpHT0UsDI/9EYD9DEfLrUhtW24isNovk
 ovYkiPjhVyAMuhnX5RDmleYGml6n2WpebIghKA2A+Odfy2jihOTQY+I/4Tf4qK8TcTlD0/Vgpx
X-Received: by 2002:a05:6000:290d:b0:439:d74f:da94 with SMTP id
 ffacd0b85a97d-439da354a39mr25542512f8f.5.1773139527026; 
 Tue, 10 Mar 2026 03:45:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb85b8sm35307969f8f.17.2026.03.10.03.45.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:45:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] tcg/optimize: Lower unsupported deposit during optimize
Date: Tue, 10 Mar 2026 11:44:57 +0100
Message-ID: <20260310104511.12670-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

The expansions that we chose in tcg-op.c may be less than optimal.
Delay lowering until optimize, so that we have propagated constants
and have computed known zero/one masks.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260303010833.1115741-3-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/optimize.c | 179 +++++++++++++++++++++++++++++++++++++++++++------
 tcg/tcg-op.c   |  83 ++---------------------
 2 files changed, 163 insertions(+), 99 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 801a0a2c686..42637c12fa1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1652,12 +1652,17 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
 {
-    TempOptInfo *t1 = arg_info(op->args[1]);
-    TempOptInfo *t2 = arg_info(op->args[2]);
+    TCGArg ret = op->args[0];
+    TCGArg arg1 = op->args[1];
+    TCGArg arg2 = op->args[2];
     int ofs = op->args[3];
     int len = op->args[4];
-    int width = 8 * tcg_type_size(ctx->type);
-    uint64_t z_mask, o_mask, s_mask;
+    TempOptInfo *t1 = arg_info(arg1);
+    TempOptInfo *t2 = arg_info(arg2);
+    int width;
+    uint64_t z_mask, o_mask, s_mask, type_mask, len_mask;
+    TCGOp *op2;
+    bool valid;
 
     if (ti_is_const(t1) && ti_is_const(t2)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0],
@@ -1665,35 +1670,167 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
                                           ti_const_val(t2)));
     }
 
-    /* Inserting a value into zero at offset 0. */
-    if (ti_is_const_val(t1, 0) && ofs == 0) {
-        uint64_t mask = MAKE_64BIT_MASK(0, len);
+    width = 8 * tcg_type_size(ctx->type);
+    type_mask = MAKE_64BIT_MASK(0, width);
+    len_mask = MAKE_64BIT_MASK(0, len);
 
+    /* Inserting all-zero into a value. */
+    if ((t2->z_mask & len_mask) == 0) {
         op->opc = INDEX_op_and;
-        op->args[1] = op->args[2];
-        op->args[2] = arg_new_constant(ctx, mask);
+        op->args[2] = arg_new_constant(ctx, ~(len_mask << ofs));
         return fold_and(ctx, op);
     }
 
-    /* Inserting zero into a value. */
-    if (ti_is_const_val(t2, 0)) {
-        uint64_t mask = deposit64(-1, ofs, len, 0);
-
-        op->opc = INDEX_op_and;
-        op->args[2] = arg_new_constant(ctx, mask);
-        return fold_and(ctx, op);
+    /* Inserting all-one into a value. */
+    if ((t2->o_mask & len_mask) == len_mask) {
+        op->opc = INDEX_op_or;
+        op->args[2] = arg_new_constant(ctx, len_mask << ofs);
+        return fold_or(ctx, op);
     }
 
-    /* The s_mask from the top portion of the deposit is still valid. */
-    if (ofs + len == width) {
-        s_mask = t2->s_mask << ofs;
-    } else {
-        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
+    valid = TCG_TARGET_deposit_valid(ctx->type, ofs, len);
+
+    /* Lower invalid deposit of constant as AND + OR. */
+    if (!valid && ti_is_const(t2)) {
+        uint64_t ins_val = (ti_const_val(t2) & len_mask) << ofs;
+
+        op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
+        op2->args[0] = ret;
+        op2->args[1] = arg1;
+        op2->args[2] = arg_new_constant(ctx, ~(len_mask << ofs));
+        fold_and(ctx, op2);
+
+        op->opc = INDEX_op_or;
+        op->args[1] = ret;
+        op->args[2] = arg_new_constant(ctx, ins_val);
+        return fold_or(ctx, op);
     }
 
+    /*
+     * Compute result masks before calling other fold_* subroutines
+     * which could modify the masks of our inputs.
+     */
     z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
     o_mask = deposit64(t1->o_mask, ofs, len, t2->o_mask);
+    if (ofs + len < width) {
+        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
+    } else {
+        s_mask = t2->s_mask << ofs;
+    }
 
+    /* Inserting a value into zero. */
+    if (ti_is_const_val(t1, 0)) {
+        uint64_t need_mask;
+
+        /* Always lower deposit into zero at 0 as AND. */
+        if (ofs == 0) {
+            op->opc = INDEX_op_and;
+            op->args[1] = arg2;
+            op->args[2] = arg_new_constant(ctx, len_mask);
+            return fold_and(ctx, op);
+        }
+
+        /*
+         * If the portion of the value outside len that remains after
+         * shifting is zero, we can elide the mask and just shift.
+         */
+        need_mask = t2->z_mask & ~len_mask;
+        need_mask = (need_mask << ofs) & type_mask;
+        if (!need_mask) {
+            op->opc = INDEX_op_shl;
+            op->args[1] = arg2;
+            op->args[2] = arg_new_constant(ctx, ofs);
+            goto done;
+        }
+
+        /* Lower invalid deposit into zero as AND + SHL. */
+        if (!valid) {
+            op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
+            op2->args[0] = ret;
+            op2->args[1] = arg2;
+            op2->args[2] = arg_new_constant(ctx, len_mask);
+            fold_and(ctx, op2);
+
+            op->opc = INDEX_op_shl;
+            op->args[1] = ret;
+            op->args[2] = arg_new_constant(ctx, ofs);
+            goto done;
+        }
+    }
+
+    /* After special cases, lower invalid deposit. */
+    if (!valid) {
+        TCGArg tmp;
+
+        if (tcg_op_supported(INDEX_op_extract2, ctx->type, 0)) {
+            if (ofs == 0 && tcg_op_supported(INDEX_op_rotl, ctx->type, 0)) {
+                /*
+                 * ret = arg2:arg1 >> len
+                 * ret = rotl(ret, len)
+                 */
+                op2 = opt_insert_before(ctx, op, INDEX_op_extract2, 4);
+                op2->args[0] = ret;
+                op2->args[1] = arg1;
+                op2->args[2] = arg2;
+                op2->args[3] = len;
+
+                op->opc = INDEX_op_rotl;
+                op->args[1] = ret;
+                op->args[2] = arg_new_constant(ctx, len);
+                goto done;
+            }
+            if (ofs + len == width) {
+                /*
+                 * tmp = arg1 << len
+                 * ret = arg2:tmp >> len
+                 */
+                tmp = ret == arg2 ? arg_new_temp(ctx) : ret;
+
+                op2 = opt_insert_before(ctx, op, INDEX_op_shl, 4);
+                op2->args[0] = tmp;
+                op2->args[1] = arg1;
+                op2->args[2] = arg_new_constant(ctx, len);
+
+                op->opc = INDEX_op_extract2;
+                op->args[0] = ret;
+                op->args[1] = tmp;
+                op->args[2] = arg2;
+                op->args[3] = len;
+                goto done;
+            }
+        }
+
+        /*
+         * tmp = arg2 & mask
+         * ret = arg1 & ~(mask << ofs)
+         * tmp = tmp << ofs
+         * ret = ret | tmp
+         */
+        tmp = arg_new_temp(ctx);
+
+        op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
+        op2->args[0] = tmp;
+        op2->args[1] = arg2;
+        op2->args[2] = arg_new_constant(ctx, len_mask);
+        fold_and(ctx, op2);
+
+        op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
+        op2->args[0] = tmp;
+        op2->args[1] = tmp;
+        op2->args[2] = arg_new_constant(ctx, ofs);
+
+        op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
+        op2->args[0] = ret;
+        op2->args[1] = arg1;
+        op2->args[2] = arg_new_constant(ctx, ~(len_mask << ofs));
+        fold_and(ctx, op2);
+
+        op->opc = INDEX_op_or;
+        op->args[1] = ret;
+        op->args[2] = tmp;
+    }
+
+ done:
     return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b95b07efb57..96f72ba381c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -876,9 +876,6 @@ void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
-    uint32_t mask;
-    TCGv_i32 t1;
-
     tcg_debug_assert(ofs < 32);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 32);
@@ -886,39 +883,9 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
 
     if (len == 32) {
         tcg_gen_mov_i32(ret, arg2);
-        return;
-    }
-    if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-        return;
-    }
-
-    t1 = tcg_temp_ebb_new_i32();
-
-    if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
-        if (ofs + len == 32) {
-            tcg_gen_shli_i32(t1, arg1, len);
-            tcg_gen_extract2_i32(ret, t1, arg2, len);
-            goto done;
-        }
-        if (ofs == 0) {
-            tcg_gen_extract2_i32(ret, arg1, arg2, len);
-            tcg_gen_rotli_i32(ret, ret, len);
-            goto done;
-        }
-    }
-
-    mask = (1u << len) - 1;
-    if (ofs + len < 32) {
-        tcg_gen_andi_i32(t1, arg2, mask);
-        tcg_gen_shli_i32(t1, t1, ofs);
     } else {
-        tcg_gen_shli_i32(t1, arg2, ofs);
+        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
     }
-    tcg_gen_andi_i32(ret, arg1, ~(mask << ofs));
-    tcg_gen_or_i32(ret, ret, t1);
- done:
-    tcg_temp_free_i32(t1);
 }
 
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -932,13 +899,10 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
     if (ofs + len == 32) {
         tcg_gen_shli_i32(ret, arg, ofs);
     } else if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-    } else if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
+        tcg_gen_extract_i32(ret, arg, 0, len);
+    } else {
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5ii_i32(INDEX_op_deposit, ret, zero, arg, ofs, len);
-    } else {
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-        tcg_gen_shli_i32(ret, ret, ofs);
     }
 }
 
@@ -2133,9 +2097,6 @@ void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-    uint64_t mask;
-    TCGv_i64 t1;
-
     tcg_debug_assert(ofs < 64);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 64);
@@ -2143,40 +2104,9 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
 
     if (len == 64) {
         tcg_gen_mov_i64(ret, arg2);
-        return;
-    }
-
-    if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-        return;
-    }
-
-    t1 = tcg_temp_ebb_new_i64();
-
-    if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
-        if (ofs + len == 64) {
-            tcg_gen_shli_i64(t1, arg1, len);
-            tcg_gen_extract2_i64(ret, t1, arg2, len);
-            goto done;
-        }
-        if (ofs == 0) {
-            tcg_gen_extract2_i64(ret, arg1, arg2, len);
-            tcg_gen_rotli_i64(ret, ret, len);
-            goto done;
-        }
-    }
-
-    mask = (1ull << len) - 1;
-    if (ofs + len < 64) {
-        tcg_gen_andi_i64(t1, arg2, mask);
-        tcg_gen_shli_i64(t1, t1, ofs);
     } else {
-        tcg_gen_shli_i64(t1, arg2, ofs);
+        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
     }
-    tcg_gen_andi_i64(ret, arg1, ~(mask << ofs));
-    tcg_gen_or_i64(ret, ret, t1);
- done:
-    tcg_temp_free_i64(t1);
 }
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
@@ -2191,12 +2121,9 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_shli_i64(ret, arg, ofs);
     } else if (ofs == 0) {
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-    } else if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
+    } else {
         TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
-    } else {
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-        tcg_gen_shli_i64(ret, ret, ofs);
     }
 }
 
-- 
2.53.0


