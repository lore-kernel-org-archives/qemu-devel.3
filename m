Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51691D4A5FA
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgac6-0000io-Bv; Thu, 15 Jan 2026 22:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgac4-0000ed-TG
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:05 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgac2-0005wn-8C
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:04 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f4c0e2b42so882376b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534501; x=1769139301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxGjmvi5stD/pKxpCi2bexDDgM4UjuXeBBR0I0HBVUM=;
 b=RBvPjnjitj9FedwzCqNuo3v9livg+evg2HyUttGJJP5c4CR2aMBCanhZ3sWta52uu/
 hoCSlbyFMwzvTi5r6LpL1ijbe5bm+TuUMwdglApcgfFw4rplRr8OAYJsl1MQLJx+Fn5I
 sxY33l4Cz87rUu9vW5dsNi3bKvw1OKUkge7qZRL0NU12RwL2T43FLIbj80w2IuXo+sYM
 d54hCr2vRwDKUbKJWQtkmrHuv23Z0YrXHoVx03LetmhDZebL7gCIH9JoQtC6VHQ3Bl+z
 oKVgT+7jHQ9G/EVrhy5gwiSMbtE7pMTONzt+Q6L81RxIudmolsWjCTycV6OrvJrr9Ida
 veUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534501; x=1769139301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xxGjmvi5stD/pKxpCi2bexDDgM4UjuXeBBR0I0HBVUM=;
 b=OAWMezei3remTrmeKDIaS6lFGboJ0j2t3ZZGw+e+ueXCCmbZl5BJBDI46ULtgD9eqd
 j2BOOhYnPK9eMTaMx7xv0odU3e8qhox1xgpwmYpqOE5ZAWrbhEGhuMdSuUpackRwGGUq
 iOmcg6OM6XGASNhKd61X/itTfbrmRcarSoE7AnEnNjFuoMaqRcMttICIPUeXQiTwJIZ5
 6CIN0+UIGxBVaZqOsU2ctYbSYjejERrzbX3jvsiwa90lbMXVQoFUzhH0KAGOLRffTBmH
 XOzC1hoTDfJ9KTcSOAbMA1gZTPHedaXowPSUyTBDmW+to8oU4GZlDalA5RObaZUEoWvp
 lQyQ==
X-Gm-Message-State: AOJu0YxKooNmAvXJ3YyFTpd+EYl5ZLbWVfHAd+8FA6EMysrl0dlP0xG+
 NNFDr49UGyTG0PoGq6xGBOXVBSq8i1+/CPVCOxhiqsGBEB/SSMoUt4+4ZtdI+welf4m0ThLw/wh
 jR55fr/1hKw==
X-Gm-Gg: AY/fxX4hObd6Q1QWFBI8xqmxm4CcOR+MCyPLY7/MGoDNYxsfy0fCkM5UylnkQwZg9pM
 wGRJNBtOTktZQ+y3+kQc1VB1o4nglEGL5QFVqbNgK2eheYEbXj8Y39aBGLnBaIucRrsZfUSKkj4
 SgxFkAF/wdLXO//mPJBsqszHZMwpvond5bKSei4MToEL7ikvuUY4qAQ7QyacTN4mVMU1Qxx2Ha5
 LPGcGrTJn/JireUT34RygYhjegzDZpq7KUq5Fim6S0I0lsYkKCDi6QL87yiiNYhpbv5tsU2bCfZ
 4QlZ1Zz48KkKR5X0jklmQElfzLGU/hs53PM9rsT/YTYfjQ+hUtOflU2dhcPzxVH9yTx53fzEDPW
 f9g+BRYrrZiu4/KmB6NhltWVZXy22EFL+HJRK5hUtGyNaUi5sCyiksKkKS4JQwdJoqSrw4xkZwE
 7E3cH9K+5oubNMkYdgeg==
X-Received: by 2002:a05:6a00:1c86:b0:81f:852b:a932 with SMTP id
 d2e1a72fcca58-81f9f6aba80mr1761449b3a.25.1768534500710; 
 Thu, 15 Jan 2026 19:35:00 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:35:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 27/58] tcg: Remove INDEX_op_setcond2_i32
Date: Fri, 16 Jan 2026 14:32:33 +1100
Message-ID: <20260116033305.51162-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

This opcode was exclusively for 32-bit hosts.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |   2 -
 tcg/optimize.c           | 205 ---------------------------------------
 tcg/tcg-op.c             |  47 +--------
 tcg/tcg.c                |  32 ------
 tcg/tci.c                |  10 --
 docs/devel/tcg-ops.rst   |  27 +-----
 tcg/tci/tcg-target.c.inc |  16 ---
 7 files changed, 8 insertions(+), 331 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 55283af326..fc1270f01e 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -103,8 +103,6 @@ DEF(subb1o, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_OUT)
 DEF(subbi, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN)
 DEF(subbio, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN | TCG_OPF_CARRY_OUT)
 
-DEF(setcond2_i32, 1, 4, 1, 0)
-
 /* size changing ops */
 DEF(ext_i32_i64, 1, 1, 0, 0)
 DEF(extu_i32_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index a544c055b8..d845c7eef2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -764,22 +764,6 @@ static bool swap_commutative(TCGArg dest, TCGArg *p1, TCGArg *p2)
     return false;
 }
 
-static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
-{
-    int sum = 0;
-    sum += pref_commutative(arg_info(p1[0]));
-    sum += pref_commutative(arg_info(p1[1]));
-    sum -= pref_commutative(arg_info(p2[0]));
-    sum -= pref_commutative(arg_info(p2[1]));
-    if (sum > 0) {
-        TCGArg t;
-        t = p1[0], p1[0] = p2[0], p2[0] = t;
-        t = p1[1], p1[1] = p2[1], p2[1] = t;
-        return true;
-    }
-    return false;
-}
-
 /*
  * Return -1 if the condition can't be simplified,
  * and the result of the condition (0 or 1) if it can.
@@ -844,108 +828,6 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
     return -1;
 }
 
-static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
-{
-    TCGArg al, ah, bl, bh;
-    TCGCond c;
-    bool swap;
-    int r;
-
-    swap = swap_commutative2(args, args + 2);
-    c = args[4];
-    if (swap) {
-        args[4] = c = tcg_swap_cond(c);
-    }
-
-    al = args[0];
-    ah = args[1];
-    bl = args[2];
-    bh = args[3];
-
-    if (arg_is_const(bl) && arg_is_const(bh)) {
-        tcg_target_ulong blv = arg_const_val(bl);
-        tcg_target_ulong bhv = arg_const_val(bh);
-        uint64_t b = deposit64(blv, 32, 32, bhv);
-
-        if (arg_is_const(al) && arg_is_const(ah)) {
-            tcg_target_ulong alv = arg_const_val(al);
-            tcg_target_ulong ahv = arg_const_val(ah);
-            uint64_t a = deposit64(alv, 32, 32, ahv);
-
-            r = do_constant_folding_cond_64(a, b, c);
-            if (r >= 0) {
-                return r;
-            }
-        }
-
-        if (b == 0) {
-            switch (c) {
-            case TCG_COND_LTU:
-            case TCG_COND_TSTNE:
-                return 0;
-            case TCG_COND_GEU:
-            case TCG_COND_TSTEQ:
-                return 1;
-            default:
-                break;
-            }
-        }
-
-        /* TSTNE x,-1 -> NE x,0 */
-        if (b == -1 && is_tst_cond(c)) {
-            args[3] = args[2] = arg_new_constant(ctx, 0);
-            args[4] = tcg_tst_eqne_cond(c);
-            return -1;
-        }
-
-        /* TSTNE x,sign -> LT x,0 */
-        if (b == INT64_MIN && is_tst_cond(c)) {
-            /* bl must be 0, so copy that to bh */
-            args[3] = bl;
-            args[4] = tcg_tst_ltge_cond(c);
-            return -1;
-        }
-    }
-
-    if (args_are_copies(al, bl) && args_are_copies(ah, bh)) {
-        r = do_constant_folding_cond_eq(c);
-        if (r >= 0) {
-            return r;
-        }
-
-        /* TSTNE x,x -> NE x,0 */
-        if (is_tst_cond(c)) {
-            args[3] = args[2] = arg_new_constant(ctx, 0);
-            args[4] = tcg_tst_eqne_cond(c);
-            return -1;
-        }
-    }
-
-    /* Expand to AND with a temporary if no backend support. */
-    if (!TCG_TARGET_HAS_tst && is_tst_cond(c)) {
-        TCGOp *op1 = opt_insert_before(ctx, op, INDEX_op_and, 3);
-        TCGOp *op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
-        TCGArg t1 = arg_new_temp(ctx);
-        TCGArg t2 = arg_new_temp(ctx);
-
-        op1->args[0] = t1;
-        op1->args[1] = al;
-        op1->args[2] = bl;
-        fold_and(ctx, op1);
-
-        op2->args[0] = t2;
-        op2->args[1] = ah;
-        op2->args[2] = bh;
-        fold_and(ctx, op1);
-
-        args[0] = t1;
-        args[1] = t2;
-        args[3] = args[2] = arg_new_constant(ctx, 0);
-        args[4] = tcg_tst_eqne_cond(c);
-    }
-    return -1;
-}
-
 static void init_arguments(OptContext *ctx, TCGOp *op, int nb_args)
 {
     for (int i = 0; i < nb_args; i++) {
@@ -2503,90 +2385,6 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
     return fold_masks_s(ctx, op, -1);
 }
 
-static bool fold_setcond2(OptContext *ctx, TCGOp *op)
-{
-    TCGCond cond;
-    int i, inv = 0;
-
-    i = do_constant_folding_cond2(ctx, op, &op->args[1]);
-    cond = op->args[5];
-    if (i >= 0) {
-        goto do_setcond_const;
-    }
-
-    switch (cond) {
-    case TCG_COND_LT:
-    case TCG_COND_GE:
-        /*
-         * Simplify LT/GE comparisons vs zero to a single compare
-         * vs the high word of the input.
-         */
-        if (arg_is_const_val(op->args[3], 0) &&
-            arg_is_const_val(op->args[4], 0)) {
-            goto do_setcond_high;
-        }
-        break;
-
-    case TCG_COND_NE:
-        inv = 1;
-        QEMU_FALLTHROUGH;
-    case TCG_COND_EQ:
-        /*
-         * Simplify EQ/NE comparisons where one of the pairs
-         * can be simplified.
-         */
-        i = do_constant_folding_cond(TCG_TYPE_I32, op->args[1],
-                                     op->args[3], cond);
-        switch (i ^ inv) {
-        case 0:
-            goto do_setcond_const;
-        case 1:
-            goto do_setcond_high;
-        }
-
-        i = do_constant_folding_cond(TCG_TYPE_I32, op->args[2],
-                                     op->args[4], cond);
-        switch (i ^ inv) {
-        case 0:
-            goto do_setcond_const;
-        case 1:
-            goto do_setcond_low;
-        }
-        break;
-
-    case TCG_COND_TSTEQ:
-    case TCG_COND_TSTNE:
-        if (arg_is_const_val(op->args[3], 0)) {
-            goto do_setcond_high;
-        }
-        if (arg_is_const_val(op->args[4], 0)) {
-            goto do_setcond_low;
-        }
-        break;
-
-    default:
-        break;
-
-    do_setcond_low:
-        op->args[2] = op->args[3];
-        op->args[3] = cond;
-        op->opc = INDEX_op_setcond;
-        return fold_setcond(ctx, op);
-
-    do_setcond_high:
-        op->args[1] = op->args[2];
-        op->args[2] = op->args[4];
-        op->args[3] = cond;
-        op->opc = INDEX_op_setcond;
-        return fold_setcond(ctx, op);
-    }
-
-    return fold_masks_z(ctx, op, 1);
-
- do_setcond_const:
-    return tcg_opt_gen_movi(ctx, op, op->args[0], i);
-}
-
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, o_mask, s_mask, a_mask;
@@ -3202,9 +3000,6 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_negsetcond:
             done = fold_negsetcond(&ctx, op);
             break;
-        case INDEX_op_setcond2_i32:
-            done = fold_setcond2(&ctx, op);
-            break;
         case INDEX_op_cmp_vec:
             done = fold_cmp_vec(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 61f6fd9095..d20888dd8f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1884,33 +1884,14 @@ void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_movi_i64(ret, 0);
     } else {
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_gen_op6i_i32(INDEX_op_setcond2_i32, TCGV_LOW(ret),
-                             TCGV_LOW(arg1), TCGV_HIGH(arg1),
-                             TCGV_LOW(arg2), TCGV_HIGH(arg2), cond);
-            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-        } else {
-            tcg_gen_op4i_i64(INDEX_op_setcond, ret, arg1, arg2, cond);
-        }
+        tcg_gen_op4i_i64(INDEX_op_setcond, ret, arg1, arg2, cond);
     }
 }
 
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_setcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
-    } else if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op6i_i32(INDEX_op_setcond2_i32, TCGV_LOW(ret),
-                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
-                         tcg_constant_i32(arg2),
-                         tcg_constant_i32(arg2 >> 32), cond);
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-    }
+    tcg_gen_setcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
 }
 
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
@@ -1926,14 +1907,8 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
         tcg_gen_movi_i64(ret, -1);
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_movi_i64(ret, 0);
-    } else if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op4i_i64(INDEX_op_negsetcond, ret, arg1, arg2, cond);
     } else {
-        tcg_gen_op6i_i32(INDEX_op_setcond2_i32, TCGV_LOW(ret),
-                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
-                         TCGV_LOW(arg2), TCGV_HIGH(arg2), cond);
-        tcg_gen_neg_i32(TCGV_LOW(ret), TCGV_LOW(ret));
-        tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_LOW(ret));
+        tcg_gen_op4i_i64(INDEX_op_negsetcond, ret, arg1, arg2, cond);
     }
 }
 
@@ -2777,22 +2752,8 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
         tcg_gen_mov_i64(ret, v1);
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_mov_i64(ret, v2);
-    } else if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op6i_i64(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
     } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-
-        tcg_gen_op6i_i32(INDEX_op_setcond2_i32, t0,
-                         TCGV_LOW(c1), TCGV_HIGH(c1),
-                         TCGV_LOW(c2), TCGV_HIGH(c2), cond);
-
-        tcg_gen_movcond_i32(TCG_COND_NE, TCGV_LOW(ret), t0, zero,
-                            TCGV_LOW(v1), TCGV_LOW(v2));
-        tcg_gen_movcond_i32(TCG_COND_NE, TCGV_HIGH(ret), t0, zero,
-                            TCGV_HIGH(v1), TCGV_HIGH(v2));
-
-        tcg_temp_free_i32(t0);
+        tcg_gen_op6i_i64(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0521767c46..b6a65fe224 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1088,12 +1088,6 @@ typedef struct TCGOutOpSetcond {
                     TCGReg ret, TCGReg a1, tcg_target_long a2);
 } TCGOutOpSetcond;
 
-typedef struct TCGOutOpSetcond2 {
-    TCGOutOp base;
-    void (*out)(TCGContext *s, TCGCond cond, TCGReg ret, TCGReg al, TCGReg ah,
-                TCGArg bl, bool const_bl, TCGArg bh, bool const_bh);
-} TCGOutOpSetcond2;
-
 typedef struct TCGOutOpStore {
     TCGOutOp base;
     void (*out_r)(TCGContext *s, TCGType type, TCGReg data,
@@ -1240,9 +1234,6 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
 
     [INDEX_op_goto_ptr] = &outop_goto_ptr,
 
-#if TCG_TARGET_REG_BITS == 32
-    OUTOP(INDEX_op_setcond2_i32, TCGOutOpSetcond2, outop_setcond2),
-#else
     OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
     OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
     OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
@@ -1251,7 +1242,6 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
     OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
     OUTOP(INDEX_op_st32, TCGOutOpStore, outop_st),
-#endif
 };
 
 #undef OUTOP
@@ -2482,9 +2472,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_xor:
         return has_type;
 
-    case INDEX_op_setcond2_i32:
-        return TCG_TARGET_REG_BITS == 32;
-
     case INDEX_op_ld32u:
     case INDEX_op_ld32s:
     case INDEX_op_st32:
@@ -3013,7 +3000,6 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             case INDEX_op_setcond:
             case INDEX_op_negsetcond:
             case INDEX_op_movcond:
-            case INDEX_op_setcond2_i32:
             case INDEX_op_cmp_vec:
             case INDEX_op_cmpsel_vec:
                 if (op->args[k] < ARRAY_SIZE(cond_name)
@@ -5269,7 +5255,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         op_cond = op->args[3];
         break;
     case INDEX_op_movcond:
-    case INDEX_op_setcond2_i32:
     case INDEX_op_cmpsel_vec:
         op_cond = op->args[5];
         break;
@@ -5869,23 +5854,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-#if TCG_TARGET_REG_BITS == 32
-    case INDEX_op_setcond2_i32:
-        {
-            const TCGOutOpSetcond2 *out = &outop_setcond2;
-            TCGCond cond = new_args[5];
-
-            tcg_debug_assert(!const_args[1]);
-            tcg_debug_assert(!const_args[2]);
-            out->out(s, cond, new_args[0], new_args[1], new_args[2],
-                     new_args[3], const_args[3], new_args[4], const_args[4]);
-        }
-        break;
-#else
-    case INDEX_op_setcond2_i32:
-        g_assert_not_reached();
-#endif
-
     case INDEX_op_goto_ptr:
         tcg_debug_assert(!const_args[0]);
         tcg_out_goto_ptr(s, new_args[0]);
diff --git a/tcg/tci.c b/tcg/tci.c
index e15d4e8e08..7f3ba9b5da 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -418,14 +418,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_l(insn, tb_ptr, &ptr);
             tb_ptr = ptr;
             continue;
-#if TCG_TARGET_REG_BITS == 32
-        case INDEX_op_setcond2_i32:
-            tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
-            regs[r0] = tci_compare64(tci_uint64(regs[r2], regs[r1]),
-                                     tci_uint64(regs[r4], regs[r3]),
-                                     condition);
-            break;
-#elif TCG_TARGET_REG_BITS == 64
         case INDEX_op_setcond:
             tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
             regs[r0] = tci_compare64(regs[r1], regs[r2], condition);
@@ -435,7 +427,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tmp32 = tci_compare64(regs[r1], regs[r2], condition);
             regs[r0] = regs[tmp32 ? r3 : r4];
             break;
-#endif
         case INDEX_op_mov:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = regs[r1];
@@ -1040,7 +1031,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
 
     case INDEX_op_tci_movcond32:
     case INDEX_op_movcond:
-    case INDEX_op_setcond2_i32:
         tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &c);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s, %s, %s",
                            op_name, str_r(r0), str_r(r1), str_r(r2),
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 10d5edb4ca..fd3a50bf4c 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -696,21 +696,6 @@ Memory Barrier support
        | Please see :ref:`atomics-ref` for more information on memory barriers.
 
 
-64-bit guest on 32-bit host support
------------------------------------
-
-The following opcodes are internal to TCG.  Thus they are to be implemented by
-32-bit host code generators, but are not to be emitted by guest translators.
-They are emitted as needed by inline functions within ``tcg-op.h``.
-
-.. list-table::
-
-   * - setcond2_i32 *dest*, *t1_low*, *t1_high*, *t2_low*, *t2_high*, *cond*
-
-     - | Similar to setcond, except that the 64-bit values *t1* and *t2* are
-         formed from two 32-bit arguments. The result is a 32-bit value.
-
-
 QEMU specific operations
 ------------------------
 
@@ -930,15 +915,11 @@ than being a standalone C file.
 Assumptions
 -----------
 
-The target word size (``TCG_TARGET_REG_BITS``) is expected to be 32 bit or
-64 bit. It is expected that the pointer has the same size as the word.
+The target word size (``TCG_TARGET_REG_BITS``) is expected to be 64 bit.
+It is expected that the pointer has the same size as the word.
 
-On a 32 bit target, all 64 bit operations are converted to 32 bits.
-A few specific operations must be implemented to allow it
-(see setcond2_i32).
-
-On a 64 bit target, the values are transferred between 32 and 64-bit
-registers using the following ops:
+Values are transferred between 32 and 64-bit registers using the
+following ops:
 
 - extrl_i64_i32
 - extrh_i64_i32
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 1756ffc59c..8bd8db4401 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1047,22 +1047,6 @@ static const TCGOutOpMovcond outop_movcond = {
     .out = tgen_movcond,
 };
 
-static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
-                          TCGReg al, TCGReg ah,
-                          TCGArg bl, bool const_bl,
-                          TCGArg bh, bool const_bh)
-{
-    tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, ret, al, ah, bl, bh, cond);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpSetcond2 outop_setcond2 = {
-    .base.static_constraint = C_O1_I4(r, r, r, r, r),
-    .out = tgen_setcond2,
-};
-
 static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     tcg_out_op_v(s, INDEX_op_mb);
-- 
2.43.0


