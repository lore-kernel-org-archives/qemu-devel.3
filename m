Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB2CC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3Hn-0003Zk-HG; Tue, 12 Mar 2024 10:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3Hi-0003Yp-92
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HZ-0007lc-8j
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ddc7e45c47so1132175ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254345; x=1710859145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ICGHco8N2bsqwCEhCf7Urzzd713nkLezWtvD//1fvW4=;
 b=Vu7pLF/IKm0mSCmPwcwTT0jROBJGjREm86dOkIWyTZntrAidZ3xagSSPOkzbX4ETTu
 kx9m3a7S0Sp2W35Fj1rG8Sdj6VcUoyPtveEBggVz97tCbQpuUamOmwfowz2Xe37uSaaR
 IpVChmo5jlbZQwJx3lSjy2+2yDaHNGYJnQWRRJ0cw+dde/ECmTqYrmlsTVORmp5JXPYl
 QYIKZpsDoWsPhilEWlKiRCFBIFBhgJFDSQ8cT+YEMi4A2jZ89UvZp25ROMOT9MWYfaIU
 1dBYggbskmXI/4ryOezwQKjdNSUmgOs/T1az7s6ZBkKm1o+MrV2PaRDS6J5PZdNzwWFh
 tpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254345; x=1710859145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICGHco8N2bsqwCEhCf7Urzzd713nkLezWtvD//1fvW4=;
 b=w+T8ppHqozCg1g83oyiIrgWuz84f0ggVEfhq6c3QHWmtHEHM4NzXWlYho+9JcSmLcj
 zVSOUBKsGYGVR29FH7hP/gbYWrWZBmUFPOofCO+IcSyGs5jC7fKUeuyBfwFgbteoL8yy
 lE97ZXd6DO4yw/h2Gk+srMEY7dPekvXG7cw1ItCwXzBTiPnUtg5NI/8PY82QuaOAehan
 ZxCed/RHfgx2NIykiLUyKeiL1LECzp79+k/Y4Sy5JuzI917p9Okme/r1/uDx6dreSjaf
 /Wwf1rMxgU++XWjF4iA0Qoe0xCYco+GbQTTrm008xGDULQEMorOe5qhQyL44htGhn3rr
 jskA==
X-Gm-Message-State: AOJu0YzllmSBhEcYbckjSotHgU/ThruW973gAmI7CQKds30nN4SYVGLl
 MuX1J1Uj2KSol6W4g+tuexzd6+lus02jlpHDjYFma/CMH2+nBkN/vwhno3l8Ft516pS2ZWP9+iU
 s
X-Google-Smtp-Source: AGHT+IHfhKKZiG4v7KFSPrkcc4bFM18xw8OrgWQndElMJgpfVFk1eoFFVNEoxJsSIr6L0o0S3owLcA==
X-Received: by 2002:a17:90a:c695:b0:29b:3106:7f24 with SMTP id
 n21-20020a17090ac69500b0029b31067f24mr525828pjt.37.1710254344976; 
 Tue, 12 Mar 2024 07:39:04 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.39.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:39:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/15] tcg/optimize: Lower unsupported deposit during optimize
Date: Tue, 12 Mar 2024 04:38:39 -1000
Message-Id: <20240312143839.136408-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The expansions that we chose in tcg-op.c may be less than optimial.
Delay lowering until optimize, so that we have propagated constants
and have computed known zero masks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 231 +++++++++++++++++++++++++++++++++++++++++-----
 tcg/tcg-op.c   | 244 ++++++++++++-------------------------------------
 2 files changed, 266 insertions(+), 209 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f3867ce9e6..ce1dbab097 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1632,51 +1632,234 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
 {
-    TCGOpcode and_opc;
+    TCGOpcode and_opc, or_opc, ex2_opc, shl_opc, rotl_opc;
+    TCGOp *op2;
+    TCGArg ret = op->args[0];
+    TCGArg arg1 = op->args[1];
+    TCGArg arg2 = op->args[2];
+    int ofs = op->args[3];
+    int len = op->args[4];
+    int width;
+    uint64_t type_mask;
+    bool valid;
 
-    if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-        uint64_t t1 = arg_info(op->args[1])->val;
-        uint64_t t2 = arg_info(op->args[2])->val;
+    if (arg_is_const(arg1) && arg_is_const(arg2)) {
+        uint64_t t1 = arg_info(arg1)->val;
+        uint64_t t2 = arg_info(arg2)->val;
 
-        t1 = deposit64(t1, op->args[3], op->args[4], t2);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t1);
+        t1 = deposit64(t1, ofs, len, t2);
+        return tcg_opt_gen_movi(ctx, op, ret, t1);
     }
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
         and_opc = INDEX_op_and_i32;
+        or_opc = INDEX_op_or_i32;
+        shl_opc = INDEX_op_shl_i32;
+        ex2_opc = TCG_TARGET_HAS_extract2_i32 ? INDEX_op_extract2_i32 : 0;
+        rotl_opc = TCG_TARGET_HAS_rot_i32 ? INDEX_op_rotl_i32 : 0;
+        valid = (TCG_TARGET_HAS_deposit_i32 &&
+                 TCG_TARGET_deposit_i32_valid(ofs, len));
+        width = 32;
+        type_mask = UINT32_MAX;
         break;
     case TCG_TYPE_I64:
         and_opc = INDEX_op_and_i64;
+        or_opc = INDEX_op_or_i64;
+        shl_opc = INDEX_op_shl_i64;
+        ex2_opc = TCG_TARGET_HAS_extract2_i64 ? INDEX_op_extract2_i64 : 0;
+        rotl_opc = TCG_TARGET_HAS_rot_i64 ? INDEX_op_rotl_i64 : 0;
+        valid = (TCG_TARGET_HAS_deposit_i64 &&
+                 TCG_TARGET_deposit_i64_valid(ofs, len));
+        width = 64;
+        type_mask = UINT64_MAX;
         break;
     default:
         g_assert_not_reached();
     }
 
-    /* Inserting a value into zero at offset 0. */
-    if (arg_is_const_val(op->args[1], 0) && op->args[3] == 0) {
-        uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);
+    if (arg_is_const(arg2)) {
+        uint64_t val = arg_info(arg2)->val;
+        uint64_t mask = MAKE_64BIT_MASK(0, len);
 
-        op->opc = and_opc;
-        op->args[1] = op->args[2];
-        op->args[2] = arg_new_constant(ctx, mask);
-        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
-        return false;
+        /* Inserting all-zero into a value. */
+        if ((val & mask) == 0) {
+            op->opc = and_opc;
+            op->args[2] = arg_new_constant(ctx, ~(mask << ofs));
+            return fold_and(ctx, op);
+        }
+
+        /* Inserting all-one into a value. */
+        if ((val & mask) == mask) {
+            op->opc = or_opc;
+            op->args[2] = arg_new_constant(ctx, mask << ofs);
+            goto done;
+        }
+
+        /* Lower invalid deposit of constant as AND + OR. */
+        if (!valid) {
+            op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
+            op2->args[0] = ret;
+            op2->args[1] = arg1;
+            op2->args[2] = arg_new_constant(ctx, ~(mask << ofs));
+            fold_and(ctx, op2); /* fold to ext*u */
+
+            op->opc = or_opc;
+            op->args[1] = ret;
+            op->args[2] = arg_new_constant(ctx, (val & mask) << ofs);
+            goto done;
+        }
     }
 
-    /* Inserting zero into a value. */
-    if (arg_is_const_val(op->args[2], 0)) {
-        uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
+    /* Inserting a value into zero. */
+    if (arg_is_const_val(arg1, 0)) {
+        uint64_t mask = MAKE_64BIT_MASK(0, len);
+        uint64_t need_mask = arg_info(arg2)->z_mask & ~mask & type_mask;
 
-        op->opc = and_opc;
-        op->args[2] = arg_new_constant(ctx, mask);
-        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
-        return false;
+        /* Always lower deposit into zero at 0 as AND. */
+        if (ofs == 0) {
+            if (!need_mask) {
+                return tcg_opt_gen_mov(ctx, op, ret, arg2);
+            }
+            op->opc = and_opc;
+            op->args[1] = arg2;
+            op->args[2] = arg_new_constant(ctx, mask);
+            return fold_and(ctx, op);
+        }
+
+        /* If no mask required, fold as SHL. */
+        if (!((need_mask << ofs) & type_mask)) {
+            op->opc = shl_opc;
+            op->args[1] = arg2;
+            op->args[2] = arg_new_constant(ctx, ofs);
+            goto done;
+        }
+
+        /* Lower invalid deposit into zero as AND + SHL. */
+        if (!valid) {
+            /*
+             * ret = arg2 & mask
+             * ret = ret << ofs
+             */
+            TCGOpcode ext_second_opc = 0;
+
+            switch (ofs + len) {
+            case 8:
+                ext_second_opc =
+                    (ctx->type == TCG_TYPE_I32
+                     ? (TCG_TARGET_HAS_ext8u_i32 ? INDEX_op_ext8u_i32 : 0)
+                     : (TCG_TARGET_HAS_ext8u_i64 ? INDEX_op_ext8u_i64 : 0));
+                break;
+            case 16:
+                ext_second_opc =
+                    (ctx->type == TCG_TYPE_I32
+                     ? (TCG_TARGET_HAS_ext16u_i32 ? INDEX_op_ext16u_i32 : 0)
+                     : (TCG_TARGET_HAS_ext16u_i64 ? INDEX_op_ext16u_i64 : 0));
+                break;
+            case 32:
+                ext_second_opc =
+                    TCG_TARGET_HAS_ext32u_i64 ? INDEX_op_ext32u_i64 : 0;
+                break;
+            }
+
+            if (ext_second_opc) {
+                op2 = tcg_op_insert_before(ctx->tcg, op, shl_opc, 3);
+                op2->args[0] = ret;
+                op2->args[1] = arg2;
+                op2->args[2] = arg_new_constant(ctx, ofs);
+
+                op->opc = ext_second_opc;
+                op->args[1] = ret;
+            } else {
+                op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
+                op2->args[0] = ret;
+                op2->args[1] = arg2;
+                op2->args[2] = arg_new_constant(ctx, mask);
+                fold_and(ctx, op2);
+
+                op->opc = shl_opc;
+                op->args[1] = ret;
+                op->args[2] = arg_new_constant(ctx, ofs);
+            }
+            goto done;
+        }
     }
 
-    ctx->z_mask = deposit64(arg_info(op->args[1])->z_mask,
-                            op->args[3], op->args[4],
-                            arg_info(op->args[2])->z_mask);
+    /* After special cases, lower invalid deposit. */
+    if (!valid) {
+        uint64_t mask = MAKE_64BIT_MASK(0, len);
+        TCGArg tmp;
+
+        /*
+         * ret = arg2:arg1 >> len
+         * ret = rotl(ret, len)
+         */
+        if (ex2_opc && rotl_opc && ofs == 0) {
+            op2 = tcg_op_insert_before(ctx->tcg, op, ex2_opc, 4);
+            op2->args[0] = ret;
+            op2->args[1] = arg1;
+            op2->args[2] = arg2;
+            op2->args[3] = len;
+
+            op->opc = rotl_opc;
+            op->args[1] = ret;
+            op->args[2] = arg_new_constant(ctx, len);
+            goto done;
+        }
+
+        /*
+         * tmp = arg1 << len
+         * ret = arg2:tmp >> len
+         */
+        if (ex2_opc && ofs + len == width) {
+            tmp = ret == arg2 ? arg_new_temp(ctx) : ret;
+
+            op2 = tcg_op_insert_before(ctx->tcg, op, shl_opc, 4);
+            op2->args[0] = tmp;
+            op2->args[1] = arg1;
+            op2->args[2] = arg_new_constant(ctx, len);
+
+            op->opc = ex2_opc;
+            op->args[0] = ret;
+            op->args[1] = tmp;
+            op->args[2] = arg2;
+            op->args[3] = len;
+            goto done;
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
+        op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
+        op2->args[0] = tmp;
+        op2->args[1] = arg2;
+        op2->args[2] = arg_new_constant(ctx, mask);
+        fold_and(ctx, op2);
+
+        op2 = tcg_op_insert_before(ctx->tcg, op, shl_opc, 3);
+        op2->args[0] = tmp;
+        op2->args[1] = tmp;
+        op2->args[2] = arg_new_constant(ctx, ofs);
+
+        op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
+        op2->args[0] = ret;
+        op2->args[1] = arg1;
+        op2->args[2] = arg_new_constant(ctx, ~(mask << ofs));
+        fold_and(ctx, op2);
+
+        op->opc = or_opc;
+        op->args[1] = ret;
+        op->args[2] = tmp;
+    }
+
+ done:
+    ctx->z_mask = deposit64(arg_info(arg1)->z_mask, ofs, len,
+                            arg_info(arg2)->z_mask);
     return false;
 }
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index aa6bc6f57d..76a1f5e296 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -874,9 +874,6 @@ void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
-    uint32_t mask;
-    TCGv_i32 t1;
-
     tcg_debug_assert(ofs < 32);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 32);
@@ -886,37 +883,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
         tcg_gen_mov_i32(ret, arg2);
         return;
     }
-    if (TCG_TARGET_HAS_deposit_i32 && TCG_TARGET_deposit_i32_valid(ofs, len)) {
-        tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, arg1, arg2, ofs, len);
-        return;
-    }
-
-    t1 = tcg_temp_ebb_new_i32();
-
-    if (TCG_TARGET_HAS_extract2_i32) {
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
-    } else {
-        tcg_gen_shli_i32(t1, arg2, ofs);
-    }
-    tcg_gen_andi_i32(ret, arg1, ~(mask << ofs));
-    tcg_gen_or_i32(ret, ret, t1);
- done:
-    tcg_temp_free_i32(t1);
+    tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, arg1, arg2, ofs, len);
 }
 
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -931,48 +898,9 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_shli_i32(ret, arg, ofs);
     } else if (ofs == 0) {
         tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-    } else if (TCG_TARGET_HAS_deposit_i32
-               && TCG_TARGET_deposit_i32_valid(ofs, len)) {
+    } else {
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len);
-    } else {
-        /* To help two-operand hosts we prefer to zero-extend first,
-           which allows ARG to stay live.  */
-        switch (len) {
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i32) {
-                tcg_gen_ext16u_i32(ret, arg);
-                tcg_gen_shli_i32(ret, ret, ofs);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i32) {
-                tcg_gen_ext8u_i32(ret, arg);
-                tcg_gen_shli_i32(ret, ret, ofs);
-                return;
-            }
-            break;
-        }
-        /* Otherwise prefer zero-extension over AND for code size.  */
-        switch (ofs + len) {
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i32) {
-                tcg_gen_shli_i32(ret, arg, ofs);
-                tcg_gen_ext16u_i32(ret, ret);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i32) {
-                tcg_gen_shli_i32(ret, arg, ofs);
-                tcg_gen_ext8u_i32(ret, ret);
-                return;
-            }
-            break;
-        }
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-        tcg_gen_shli_i32(ret, ret, ofs);
     }
 }
 
@@ -2611,9 +2539,6 @@ void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-    uint64_t mask;
-    TCGv_i64 t1;
-
     tcg_debug_assert(ofs < 64);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 64);
@@ -2623,52 +2548,41 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
         tcg_gen_mov_i64(ret, arg2);
         return;
     }
-    if (TCG_TARGET_HAS_deposit_i64 && TCG_TARGET_deposit_i64_valid(ofs, len)) {
+
+    if (TCG_TARGET_REG_BITS == 64) {
         tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, arg1, arg2, ofs, len);
-        return;
-    }
-
-    if (TCG_TARGET_REG_BITS == 32) {
-        if (ofs >= 32) {
-            tcg_gen_deposit_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1),
-                                TCGV_LOW(arg2), ofs - 32, len);
-            tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
-            return;
-        }
-        if (ofs + len <= 32) {
-            tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(arg1),
-                                TCGV_LOW(arg2), ofs, len);
-            tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
-            return;
-        }
-    }
-
-    t1 = tcg_temp_ebb_new_i64();
-
-    if (TCG_TARGET_HAS_extract2_i64) {
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
+    } else if (ofs >= 32) {
+        tcg_gen_deposit_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1),
+                            TCGV_LOW(arg2), ofs - 32, len);
+        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
+    } else if (ofs + len <= 32) {
+        tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(arg1),
+                            TCGV_LOW(arg2), ofs, len);
+        tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
+    } else if (ofs == 0) {
+        tcg_gen_deposit_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1),
+                            TCGV_HIGH(arg2), 0, len - 32);
+        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg2));
     } else {
-        tcg_gen_shli_i64(t1, arg2, ofs);
+        /* The 64-bit deposit is split across the 32-bit halves. */
+        unsigned lo_len = 32 - ofs;
+        unsigned hi_len = len - lo_len;
+        TCGv_i32 tl = tcg_temp_ebb_new_i32();
+        TCGv_i32 th = tcg_temp_ebb_new_i32();
+
+        tcg_gen_deposit_i32(tl, TCGV_LOW(arg1), TCGV_LOW(arg2), ofs, lo_len);
+        if (len <= 32) {
+            tcg_gen_shri_i32(th, TCGV_LOW(arg2), lo_len);
+        } else {
+            tcg_gen_extract2_i32(th, TCGV_LOW(arg2), TCGV_HIGH(arg2), lo_len);
+        }
+        tcg_gen_deposit_i32(th, TCGV_HIGH(arg1), th, 0, hi_len);
+
+        tcg_gen_mov_i32(TCGV_LOW(ret), tl);
+        tcg_gen_mov_i32(TCGV_HIGH(ret), th);
+        tcg_temp_free_i32(tl);
+        tcg_temp_free_i32(th);
     }
-    tcg_gen_andi_i64(ret, arg1, ~(mask << ofs));
-    tcg_gen_or_i64(ret, ret, t1);
- done:
-    tcg_temp_free_i64(t1);
 }
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
@@ -2683,75 +2597,35 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_shli_i64(ret, arg, ofs);
     } else if (ofs == 0) {
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-    } else if (TCG_TARGET_HAS_deposit_i64
-               && TCG_TARGET_deposit_i64_valid(ofs, len)) {
+    } else if (TCG_TARGET_REG_BITS == 64) {
         TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, zero, arg, ofs, len);
+    } else if (ofs >= 32) {
+        tcg_gen_deposit_z_i32(TCGV_HIGH(ret), TCGV_LOW(arg), ofs - 32, len);
+        tcg_gen_movi_i32(TCGV_LOW(ret), 0);
+    } else if (ofs + len <= 32) {
+        tcg_gen_deposit_z_i32(TCGV_LOW(ret), TCGV_LOW(arg), ofs, len);
+        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    } else if (ofs == 0) {
+        tcg_gen_deposit_z_i32(TCGV_HIGH(ret), TCGV_HIGH(arg), 0, len - 32);
+        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
     } else {
-        if (TCG_TARGET_REG_BITS == 32) {
-            if (ofs >= 32) {
-                tcg_gen_deposit_z_i32(TCGV_HIGH(ret), TCGV_LOW(arg),
-                                      ofs - 32, len);
-                tcg_gen_movi_i32(TCGV_LOW(ret), 0);
-                return;
-            }
-            if (ofs + len <= 32) {
-                tcg_gen_deposit_z_i32(TCGV_LOW(ret), TCGV_LOW(arg), ofs, len);
-                tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-                return;
-            }
+        /* The 64-bit deposit is split across the 32-bit halves. */
+        unsigned lo_len = 32 - ofs;
+        unsigned hi_len = len - lo_len;
+        TCGv_i32 tl = tcg_temp_ebb_new_i32();
+        TCGv_i32 th = TCGV_HIGH(ret);
+
+        tcg_gen_deposit_z_i32(tl, TCGV_LOW(arg), ofs, lo_len);
+        if (len <= 32) {
+            tcg_gen_shri_i32(th, TCGV_LOW(arg), lo_len);
+        } else {
+            tcg_gen_extract2_i32(th, TCGV_LOW(arg), TCGV_HIGH(arg), lo_len);
         }
-        /* To help two-operand hosts we prefer to zero-extend first,
-           which allows ARG to stay live.  */
-        switch (len) {
-        case 32:
-            if (TCG_TARGET_HAS_ext32u_i64) {
-                tcg_gen_ext32u_i64(ret, arg);
-                tcg_gen_shli_i64(ret, ret, ofs);
-                return;
-            }
-            break;
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i64) {
-                tcg_gen_ext16u_i64(ret, arg);
-                tcg_gen_shli_i64(ret, ret, ofs);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i64) {
-                tcg_gen_ext8u_i64(ret, arg);
-                tcg_gen_shli_i64(ret, ret, ofs);
-                return;
-            }
-            break;
-        }
-        /* Otherwise prefer zero-extension over AND for code size.  */
-        switch (ofs + len) {
-        case 32:
-            if (TCG_TARGET_HAS_ext32u_i64) {
-                tcg_gen_shli_i64(ret, arg, ofs);
-                tcg_gen_ext32u_i64(ret, ret);
-                return;
-            }
-            break;
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i64) {
-                tcg_gen_shli_i64(ret, arg, ofs);
-                tcg_gen_ext16u_i64(ret, ret);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i64) {
-                tcg_gen_shli_i64(ret, arg, ofs);
-                tcg_gen_ext8u_i64(ret, ret);
-                return;
-            }
-            break;
-        }
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-        tcg_gen_shli_i64(ret, ret, ofs);
+        tcg_gen_deposit_z_i32(th, th, 0, hi_len);
+
+        tcg_gen_mov_i32(TCGV_LOW(ret), tl);
+        tcg_temp_free_i32(tl);
     }
 }
 
-- 
2.34.1


