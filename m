Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F65C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnua-0004vk-QJ; Sun, 16 Feb 2025 18:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntQ-0002zb-9p
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:44 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntN-00065d-C3
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:44 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220f048c038so41422535ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747860; x=1740352660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uqOQIJsBHJXoPWpkGP4ciUd9Xg8vcP1M8atlfwqtORo=;
 b=hX/KJ2d6ApDCwlzSw1tLRDBNr6nYe+EsBGxkbMBG/oV5JEvCtB7Rz9IgKz+kLsB3O2
 y+/a/SBDFb6Ef8QIKQ1dM/bwlu2u9niI1DqbchmO+yK3BVTnUOag63mCKmRvG/tgFTGS
 3SL+JRun1ms5Z2jJRkXkC8wqk8xmYtRud9TtEqru298VDs7Dq/9hv/LKDu0m75qRywol
 uEGLqxHYf4QTZ1N2ou/WcaLN7AcfncVw9II0sPd02UKeL1LuW2bk7zzMOJJt9+tNWb2y
 Gh9ZI3q1HY/N5NvS7vwutx5Wm58Nw0dEqAWwaF1XBwxPp0m7+Kwt8JGpIOYcJstkaHK7
 fMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747860; x=1740352660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uqOQIJsBHJXoPWpkGP4ciUd9Xg8vcP1M8atlfwqtORo=;
 b=p91VkGH1cD6bH6ukPavKFLYleEgSmypQI7bT9mz81AJNa3S/0Px9kmeo8hIyLDoSHn
 Q3uR56r3MGypdBE0YCCaEDquWMk0FiQuFbftIE4misxNLJ+/wSBPcAGq/ClsY9r78ew5
 Ys25BmV4Qg/ezT8Cbg9KVVcqlK0bT3ALZWpp4BRMzPA+jlwnEYqR+hy5i8D7zEkJAv4a
 wrO4u9Cvpu5S8wKEdjSYxnhblJ5IrB/E3J6py0hrWUDrU7DVBB7oBzpnfNv5a3in256F
 RzMn5bBrlxg6T00b1vqg5HS8tLCxLg/kgwbSunKq8I7gxh8vCnYLIX1FEGDm3akpxxQt
 WOiA==
X-Gm-Message-State: AOJu0YxsVoMwFKjm4DN5oZ7QAKzJnnuU32le4ZFDE2JPz69toc2b9mIg
 ASC2Ge4ost4qiDWyKG3PJpsc44bJIk5um2cKqjA1pnWxSHn8VUlhV1TtIqzPMM7jgS3VXEN1mWY
 t
X-Gm-Gg: ASbGnct+MoZ5Jpp0WY8xHCOdw4fOb1dlY5MuvS/xD7Km6eGjjbThh9w8yb0Wi+PMbnh
 +bNxzZVru4JSTLOIe/l3aKqzgLZB4ybYkhjtPcLGHd1aa2sozpXEY2aWYCKmn02ycQXA925Htdw
 8CCTA+zXw9SRVbfeMltd4SneCLyt0gkkHD2g0Rza0g+/7erqvWPF0CSQN1k5TTUkByMuJyfX3gp
 lwGYV6OMT7n0s3O91D8jVzPxx3XqvVjYsXi9L3/ob7nl5ccMVMztEGvnpxxK4yK17NAALgTqj2x
 it9XYtgnm4OXcZjZB1FXwt4k8yIsu9SaGT8rRbccbe1YlGE=
X-Google-Smtp-Source: AGHT+IF9IACT2PlBPLvb6992o2zwjMoWl0gBZLsBxkNlPTnuxRF201k8gdLcq2VGVLRYNoo8iImODw==
X-Received: by 2002:a17:903:2cb:b0:216:55a1:35a with SMTP id
 d9443c01a7336-22104084819mr122246575ad.30.1739747859756; 
 Sun, 16 Feb 2025 15:17:39 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 114/162] tcg/optimize: Handle add/sub with carry opcodes
Date: Sun, 16 Feb 2025 15:09:23 -0800
Message-ID: <20250216231012.2808572-115-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Propagate known carry when possible, and simplify the opcodes
to not require carry-in when known.  The result will be cleaned
up further by the subsequent liveness analysis pass.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 319 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 316 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5a21f8bfd9..1b3d0b5b5d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -66,6 +66,7 @@ typedef struct OptContext {
 
     /* In flight values from optimization. */
     TCGType type;
+    int carry_state;  /* -1 = non-constant, {0,1} = constant carry-in */
 } OptContext;
 
 static inline TempOptInfo *ts_info(TCGTemp *ts)
@@ -1191,8 +1192,10 @@ static bool fold_xx_to_x(OptContext *ctx, TCGOp *op)
  *   3) those that produce information about the result value.
  */
 
+static bool fold_addco(OptContext *ctx, TCGOp *op);
 static bool fold_or(OptContext *ctx, TCGOp *op);
 static bool fold_orc(OptContext *ctx, TCGOp *op);
+static bool fold_subbo(OptContext *ctx, TCGOp *op);
 static bool fold_xor(OptContext *ctx, TCGOp *op);
 
 static bool fold_add(OptContext *ctx, TCGOp *op)
@@ -1214,9 +1217,167 @@ static bool fold_add_vec(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_add_carry(OptContext *ctx, TCGOp *op)
+static void squash_prev_carryout(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t2;
+
+    op = QTAILQ_PREV(op, link);
+    switch (op->opc) {
+    case INDEX_op_addco:
+        op->opc = INDEX_op_add;
+        fold_add(ctx, op);
+        break;
+    case INDEX_op_addcio:
+        op->opc = INDEX_op_addci;
+        break;
+    case INDEX_op_addc1o:
+        op->opc = INDEX_op_add;
+        t2 = arg_info(op->args[2]);
+        if (ti_is_const(t2)) {
+            op->args[2] = arg_new_constant(ctx, ti_const_val(t2) + 1);
+            /* Perform other constant folding, if needed. */
+            fold_add(ctx, op);
+        } else {
+            TCGArg ret = op->args[0];
+            op = tcg_op_insert_after(ctx->tcg, op, INDEX_op_add, 3);
+            op->args[0] = ret;
+            op->args[1] = ret;
+            op->args[2] = arg_new_constant(ctx, 1);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static bool fold_addci(OptContext *ctx, TCGOp *op)
 {
     fold_commutative(ctx, op);
+
+    if (ctx->carry_state < 0) {
+        return finish_folding(ctx, op);
+    }
+
+    squash_prev_carryout(ctx, op);
+    op->opc = INDEX_op_add;
+
+    if (ctx->carry_state > 0) {
+        TempOptInfo *t2 = arg_info(op->args[2]);
+
+        /*
+         * Propagate the known carry-in into a constant, if possible.
+         * Otherwise emit a second add +1.
+         */
+        if (ti_is_const(t2)) {
+            op->args[2] = arg_new_constant(ctx, ti_const_val(t2) + 1);
+        } else {
+            TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_add, 3);
+
+            op2->args[0] = op->args[0];
+            op2->args[1] = op->args[1];
+            op2->args[2] = op->args[2];
+            fold_add(ctx, op2);
+
+            op->args[1] = op->args[0];
+            op->args[2] = arg_new_constant(ctx, 1);
+        }
+    }
+
+    ctx->carry_state = -1;
+    return fold_add(ctx, op);
+}
+
+static bool fold_addcio(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t1, *t2;
+    int carry_out = -1;
+    uint64_t sum, max;
+
+    fold_commutative(ctx, op);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+
+    /*
+     * The z_mask value is >= the maximum value that can be represented
+     * with the known zero bits.  So adding the z_mask values will not
+     * overflow if and only if the true values cannot overflow.
+     */
+    if (!uadd64_overflow(t1->z_mask, t2->z_mask, &sum) &&
+        !uadd64_overflow(sum, ctx->carry_state != 0, &sum)) {
+        carry_out = 0;
+    }
+
+    if (ctx->carry_state < 0) {
+        ctx->carry_state = carry_out;
+        return finish_folding(ctx, op);
+    }
+
+    squash_prev_carryout(ctx, op);
+    if (ctx->carry_state == 0) {
+        goto do_addco;
+    }
+
+    /* Propagate the known carry-in into a constant, if possible. */
+    max = ctx->type == TCG_TYPE_I32 ? UINT32_MAX : UINT64_MAX;
+    if (ti_is_const(t2)) {
+        uint64_t v = ti_const_val(t2) & max;
+        if (v < max) {
+            op->args[2] = arg_new_constant(ctx, v + 1);
+            goto do_addco;
+        }
+        /* max + known carry in produces known carry out. */
+        carry_out = 1;
+    }
+    if (ti_is_const(t1)) {
+        uint64_t v = ti_const_val(t1) & max;
+        if (v < max) {
+            op->args[1] = arg_new_constant(ctx, v + 1);
+            goto do_addco;
+        }
+        carry_out = 1;
+    }
+
+    /* Adjust the opcode to remember the known carry-in. */
+    op->opc = INDEX_op_addc1o;
+    ctx->carry_state = carry_out;
+    return finish_folding(ctx, op);
+
+ do_addco:
+    op->opc = INDEX_op_addco;
+    return fold_addco(ctx, op);
+}
+
+static bool fold_addco(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t1, *t2;
+    int carry_out = -1;
+    uint64_t ign;
+
+    fold_commutative(ctx, op);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+
+    if (ti_is_const(t2)) {
+        uint64_t v2 = ti_const_val(t2);
+
+        if (ti_is_const(t1)) {
+            uint64_t v1 = ti_const_val(t1);
+            /* Given sign-extension of z_mask for I32, we need not truncate. */
+            carry_out = uadd64_overflow(v1, v2, &ign);
+        } else if (v2 == 0) {
+            carry_out = 0;
+        }
+    } else {
+        /*
+         * The z_mask value is >= the maximum value that can be represented
+         * with the known zero bits.  So adding the z_mask values will not
+         * overflow if and only if the true values cannot overflow.
+         */
+        if (!uadd64_overflow(t1->z_mask, t2->z_mask, &ign)) {
+            carry_out = 0;
+        }
+    }
+    ctx->carry_state = carry_out;
     return finish_folding(ctx, op);
 }
 
@@ -2637,6 +2798,145 @@ static bool fold_sub2(OptContext *ctx, TCGOp *op)
     return fold_addsub2(ctx, op, false);
 }
 
+static void squash_prev_borrowout(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t2;
+
+    op = QTAILQ_PREV(op, link);
+    switch (op->opc) {
+    case INDEX_op_subbo:
+        op->opc = INDEX_op_sub;
+        fold_sub(ctx, op);
+        break;
+    case INDEX_op_subbio:
+        op->opc = INDEX_op_subbi;
+        break;
+    case INDEX_op_subb1o:
+        t2 = arg_info(op->args[2]);
+        if (ti_is_const(t2)) {
+            op->opc = INDEX_op_add;
+            op->args[2] = arg_new_constant(ctx, -(ti_const_val(t2) + 1));
+            /* Perform other constant folding, if needed. */
+            fold_add(ctx, op);
+        } else {
+            TCGArg ret = op->args[0];
+            op->opc = INDEX_op_sub;
+            op = tcg_op_insert_after(ctx->tcg, op, INDEX_op_add, 3);
+            op->args[0] = ret;
+            op->args[1] = ret;
+            op->args[2] = arg_new_constant(ctx, -1);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static bool fold_subbi(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t2;
+    int borrow_in = ctx->carry_state;
+
+    if (borrow_in < 0) {
+        return finish_folding(ctx, op);
+    }
+    ctx->carry_state = -1;
+
+    squash_prev_borrowout(ctx, op);
+    if (borrow_in == 0) {
+        op->opc = INDEX_op_sub;
+        return fold_sub(ctx, op);
+    }
+
+    /*
+     * Propagate the known carry-in into any constant, then negate to
+     * transform from sub to add.  If there is no constant, emit a
+     * separate add -1.
+     */
+    t2 = arg_info(op->args[2]);
+    if (ti_is_const(t2)) {
+        op->args[2] = arg_new_constant(ctx, -(ti_const_val(t2) + 1));
+    } else {
+        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_sub, 3);
+
+        op2->args[0] = op->args[0];
+        op2->args[1] = op->args[1];
+        op2->args[2] = op->args[2];
+        fold_sub(ctx, op2);
+
+        op->args[1] = op->args[0];
+        op->args[2] = arg_new_constant(ctx, -1);
+    }
+    op->opc = INDEX_op_add;
+    return fold_add(ctx, op);
+}
+
+static bool fold_subbio(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t1, *t2;
+    int borrow_out = -1;
+
+    if (ctx->carry_state < 0) {
+        return finish_folding(ctx, op);
+    }
+
+    squash_prev_borrowout(ctx, op);
+    if (ctx->carry_state == 0) {
+        goto do_subbo;
+    }
+
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+
+    /* Propagate the known borrow-in into a constant, if possible. */
+    if (ti_is_const(t2)) {
+        uint64_t max = ctx->type == TCG_TYPE_I32 ? UINT32_MAX : UINT64_MAX;
+        uint64_t v = ti_const_val(t2) & max;
+
+        if (v < max) {
+            op->args[2] = arg_new_constant(ctx, v + 1);
+            goto do_subbo;
+        }
+        /* subtracting max + 1 produces known borrow out. */
+        borrow_out = 1;
+    }
+    if (ti_is_const(t1)) {
+        uint64_t v = ti_const_val(t1);
+        if (v != 0) {
+            op->args[2] = arg_new_constant(ctx, v - 1);
+            goto do_subbo;
+        }
+    }
+
+    /* Adjust the opcode to remember the known carry-in. */
+    op->opc = INDEX_op_subb1o;
+    ctx->carry_state = borrow_out;
+    return finish_folding(ctx, op);
+
+ do_subbo:
+    op->opc = INDEX_op_subbo;
+    return fold_subbo(ctx, op);
+}
+
+static bool fold_subbo(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t1 = arg_info(op->args[1]);
+    TempOptInfo *t2 = arg_info(op->args[2]);
+    int borrow_out = -1;
+
+    if (ti_is_const(t2)) {
+        uint64_t v2 = ti_const_val(t2);
+        if (v2 == 0) {
+            borrow_out = 0;
+        } else if (ti_is_const(t1)) {
+            uint64_t v1 = ti_const_val(t1);
+            borrow_out = v1 < v2;
+        }
+    }
+    ctx->carry_state = borrow_out;
+    return finish_folding(ctx, op);
+}
+
 static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask = -1, s_mask = 0;
@@ -2824,9 +3124,13 @@ void tcg_optimize(TCGContext *s)
             done = fold_add_vec(&ctx, op);
             break;
         case INDEX_op_addci:
-        case INDEX_op_addco:
+            done = fold_addci(&ctx, op);
+            break;
         case INDEX_op_addcio:
-            done = fold_add_carry(&ctx, op);
+            done = fold_addcio(&ctx, op);
+            break;
+        case INDEX_op_addco:
+            done = fold_addco(&ctx, op);
             break;
         CASE_OP_32_64(add2):
             done = fold_add2(&ctx, op);
@@ -3008,6 +3312,15 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_sub:
             done = fold_sub(&ctx, op);
             break;
+        case INDEX_op_subbi:
+            done = fold_subbi(&ctx, op);
+            break;
+        case INDEX_op_subbio:
+            done = fold_subbio(&ctx, op);
+            break;
+        case INDEX_op_subbo:
+            done = fold_subbo(&ctx, op);
+            break;
         case INDEX_op_sub_vec:
             done = fold_sub_vec(&ctx, op);
             break;
-- 
2.43.0


