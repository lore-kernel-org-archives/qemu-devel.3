Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DDFEB364A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEFk-0000EE-77; Mon, 02 Mar 2026 20:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFj-0000E3-6y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:47 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFh-00071O-0z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:46 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-827390e8a3cso3289336b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 17:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772500124; x=1773104924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ep4G4BLNwlEA/4u+aLTe3Bc1f2kKgbSUaJgl+b2hJIs=;
 b=sVT8ukjXBuMayAwz6nsSVhmN1j5pWGf+ojXF1VsCVhWywjTI1Dkk5BfXnpKyTtd3vr
 QeuEnsSncITE85/IaFsbrxStXiHo+EVV/KmWeQwKKaXSG8eN/ApkalYjjI/a9gKiBIja
 YeH99jb6LSDSUzCEZyPRkqe5X/H5OB/nKRnkbJza6iJiRRFADteAdBiIO3iptI9I6GBh
 voXl0UL5f6ZsB0/im7C8cgjUx0NGVFLztmxpdgAtUMHmF9VA/giD2gdHn9dH3YcgjQw7
 Jn3TCwKFgN9rx35ecHUaT7bZgjmfNzZcRI41zVoNI1J1xKXD+iXRKU/KzPyHFJHTYoh1
 vacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772500124; x=1773104924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ep4G4BLNwlEA/4u+aLTe3Bc1f2kKgbSUaJgl+b2hJIs=;
 b=aXv7skouCA3rrFbYo+4HBHTDRx4pkFUxYFTmMhWZ3dDZFiM6nByBdVrFCHKmREl72R
 xBFUURjGqksEDx0xzJRe9xQC+XqRGOQK77aMTJm5FJ0Mll1QonGzCj01GspRYMea2qil
 O6eFxp8Vg0kFz8sGqWg/4Iz03TM0Ob5Nl13odGSntKpgtoiVLYvirIA5fxs0tF/Wi92H
 CEct7265XaXe7/lN2TbB8VRs2twqrDAcJwA2Dyl4FZcjh9tCnVRuzipwhoBk4Sy9HU/h
 daV34EYAQw7EE6EVG+nZmM3cp4LjKADhEXABvSzNjRyDOvGKoFcZ/0GMNYekojt5E1bC
 RL9w==
X-Gm-Message-State: AOJu0YygSJdoSJ4wCPhfhJpCay2AzisJ1ccQIwbxkoiNFxBTU1zIO0TY
 Zy5Z6JiSPjJBu/4oJQJ03dsLYpE+4xS2O2wV8e16Ld0l+CvnBgChjJxC9m9tWu6LIUJ+zjJjfXW
 ZEGZIRw8=
X-Gm-Gg: ATEYQzywu6oCf634ZZX22eEW1ks7SgUjRkS7K1rkpvb3WpvqLuupZhGzUCqxL4AklVo
 ouPqyUc3uUqybjzm0UfbKF2a7QwRnVQKzy/zRrC9e/LlP1pr+IEGsUwOXYJ3TrYwVmuKih2RxMV
 sxVW7DlINTu2sxKgJ+sNzcNJCfiCC0J3pZFvCr5o2gPXlPV5vT2502vQVMD78lZ5OZIT+g03ob/
 W/eaBBm/2j7WV1FgeHqYGFD6YhOPEkQPP/Cuj8FXWRFfSEY4G0UXY5HEL4Rz2VlLwitBk5mchfd
 +1K4HzU4GeUNwk57xvT+M/jPNXOMcTwNU66BkOE+ugUy62hqphzOrteAUvaBvJ/oBHnSVbHWWXI
 E4If+pl0fuOIFigU1cPXyTud6dJBfQ+QILBMmBT8LfTDH/GGXomCfNoJF7gr6w8kUb+V3ve6cjk
 JZjbdLr/+nXzzBOwfp0lLfTZMRm2TWBXF8V+D9jlbv
X-Received: by 2002:a05:6a00:9083:b0:824:3ef6:a815 with SMTP id
 d2e1a72fcca58-8295d87b143mr377487b3a.8.1772500123378; 
 Mon, 02 Mar 2026 17:08:43 -0800 (PST)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d94de6sm14484988b3a.24.2026.03.02.17.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 17:08:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	jim.macarthur@linaro.org
Subject: [PATCH v3 2/7] tcg/optimize: Lower unsupported deposit during optimize
Date: Tue,  3 Mar 2026 12:08:27 +1100
Message-ID: <20260303010833.1115741-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303010833.1115741-1-richard.henderson@linaro.org>
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

The expansions that we chose in tcg-op.c may be less than optimial.
Delay lowering until optimize, so that we have propagated constants
and have computed known zero/one masks.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 179 +++++++++++++++++++++++++++++++++++++++++++------
 tcg/tcg-op.c   |  83 ++---------------------
 2 files changed, 163 insertions(+), 99 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 801a0a2c68..42637c12fa 100644
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
index b95b07efb5..96f72ba381 100644
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
2.43.0


