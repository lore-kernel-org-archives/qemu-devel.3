Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284F5C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQs-0007nw-VE; Wed, 16 Sep 2026 09:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQo-0007Jo-1W
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:10 -0400
Received: from mail-oo2-x0e.google.com ([2607:f8b0:4864:31::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQl-000214-GE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:09 -0400
Received: by mail-oo2-x0e.google.com with SMTP id
 006d021491bc7-6b1ae6a9960so812484eaf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564326; x=1790169126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xRsQmFDwHhDojWxumr8osIy07oDRi66+ow38sPhZ0SM=;
 b=UqbrWumGZYTOStrDyWPo2E3PdzfUSeistwX0SC5ldrS9yeDR9/g/KFwDVPYlBiKWIv
 bsLh+k2E9wyC2tIGdnjgfm7h8p1d7L9A6j+w2j5QL9hln7h84ZbOakNyjeGIxfNXmagp
 RLXGEfeXu/jW8GIdzsxvREMgLLBU+kq8HhHrDX5QxWDNPyUJrgmpd4cS0xtkA4uYQvh7
 oJYnGpBrRQUG8DZvezqF+zuexRs9MfVS5cNCl8IxVn4bI0OgmY5iERieHpXqQcDZsHLN
 L5hyxeKosZ2FllAtG4TJNO8jdWKzazSH2tjM3zXk3DZJ5Zi3lRuvQ9ZDqBJnR7M0Cffr
 xvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564326; x=1790169126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xRsQmFDwHhDojWxumr8osIy07oDRi66+ow38sPhZ0SM=;
 b=eSqhLdV1zbud98getWMlwwZG1SCOk0W63lLEkxfZod/zZhC5+GwWr+dnyom7RUfNlP
 MI13lPzYYsHsixhsB5eA4ohTtgtT2p7lWvIeJEll+RH6P/7FgZTEZSa1hHS8M2YaWP79
 3mLUpvEyhEnNVA0VIr3RXpct/gqI/3vdyPmWiYqdpiHnwqPFkfAuF7AHhS/AUo2M3uNi
 uoikXoFqBsybUfue87r8dhf84mTlbxYLc2z9B1B9avdP4Iaztrc4cEcHph3Oaf261+Ga
 DTzg7LeJY5WqwZBU10eSFmgitYqz4vvbPdHscfhyys7vcqCPYbpdlXNa7j3vSzvyMLg/
 FRNg==
X-Gm-Message-State: AFuF++lvMrdWTyWkWefa5pkCrhPWtAisIsLhb5xX9fKf3UNnPRW045Hc
 Y7leY/uYu8w6QJjDpmgJvk8J+gBYghD6WnE7nLbCQUVy94mT6ymxN91feSgeZihSDKWOiExy752
 uZCvJHNA=
X-Gm-Gg: AYBFou2fImtuc2ACiXOQ5j/WD6oN5YYB23pk5BChd6J+SXlko+TfDUFePsvjcHVma31
 Afldcxf+14tI3+cA2g1WCqnv3eAbthLgxQfJ6At7HUIoEYKUWz0ieBkzN8Ag/P8QQ21AaLmsEEH
 gXCS7nwYmZky+Xs9leYIBq+FrCKjsLEYOWQ/x9w8fcrba3QJLFddkN8E16aGRVsvVvmNhcqhudE
 koKo1otpSw4dt9i9kZom0PEAqXhisVumU+oCIt73Afi66S4KZCVKDW/nZUCwirq1DtPybSuat/w
 lB+Q+5Exoe2Z8ilmPKLzBfDPo+U8PScuSq+zfpZ/7aIpyLUb4+UpcCD9ssHCT0/X67ACa+Z3LTE
 SDEo/9g4tYyeAmWt8m2yhZeaUfPZMXX1GUjOJ0QyOSH+aj+asHhG3TOGSqGmscSzK3RZO+26e+K
 4qjsTrGR42FuE1XYp3jvDKgWT7+dTMr7BUDo4I3xhbuBJx5F0Yig186D7055G3NeGK+HgppcrQk
 CP4Lp0=
X-Received: by 2002:a4a:e841:0:b0:6aa:de29:651 with SMTP id
 006d021491bc7-6c7d1ad0793mr2983126eaf.16.1789564324833; 
 Wed, 16 Sep 2026 06:12:04 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.12.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:12:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 89/92] tcg: Expand missing mulu2_i64 during liveness
Date: Wed, 16 Sep 2026 03:04:04 -1000
Message-ID: <20260916130409.3382710-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0e.google.com
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

During liveness, we finally know whether the high part
of the double-word multiply is actually used.  If we were
to decompose the operation earlier, we would prevent the
removal of the unused value.  This is fairly common with
translated x86 code, where the high part of the multiply
may only be used for condition codes, which may easily be
dead code eliminated.

Once we know the computation is required, expand the multiply
by parts for hosts without ISA support.  At present this is
older s390x and sparc64.  This is far more efficient than the
out-of-line helper.

Since this is after the normal tcg_optmize pass, do some
minimal constant decomposition and value propagation for
the subexpressions within the double-word multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h |   3 -
 accel/tcg/tcg-runtime.c |  14 ---
 tcg/tcg-op.c            |  34 ++-----
 tcg/tcg.c               | 214 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 218 insertions(+), 47 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 003c963bc7d..0dda2079fd0 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -1,6 +1,3 @@
-DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-
 DEF_HELPER_FLAGS_2(clz_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_2(ctz_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_2(clz_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 77c4024148f..44b48a1ea79 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -32,20 +32,6 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-uint64_t HELPER(muluh_i64)(uint64_t arg1, uint64_t arg2)
-{
-    uint64_t l, h;
-    mulu64(&l, &h, arg1, arg2);
-    return h;
-}
-
-int64_t HELPER(mulsh_i64)(int64_t arg1, int64_t arg2)
-{
-    uint64_t l, h;
-    muls64(&l, &h, arg1, arg2);
-    return h;
-}
-
 uint32_t HELPER(clz_i32)(uint32_t arg, uint32_t zero_val)
 {
     return arg ? clz32(arg) : zero_val;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 555af3cf24b..0fff27a4e60 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -973,8 +973,7 @@ static void gen_muls2(TCGType type, TCGTemp *rl, TCGTemp *rh,
 
         tcg_temp_free_internal(t0);
         tcg_temp_free_internal(t1);
-    } else if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0) ||
-               tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
+    } else {
         TCGTemp *t0 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
         TCGTemp *t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
         TCGTemp *t2 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
@@ -995,24 +994,13 @@ static void gen_muls2(TCGType type, TCGTemp *rl, TCGTemp *rh,
         tcg_temp_free_internal(t1);
         tcg_temp_free_internal(t2);
         tcg_temp_free_internal(t3);
-    } else {
-        TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
-
-        gen_mul(TCG_TYPE_I64, t, src1, src2);
-        gen_helper_mulsh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
-                             temp_tcgv_i64(src2));
-        gen_mov(TCG_TYPE_I64, rl, t);
-
-        tcg_temp_free_internal(t);
     }
 }
 
 static void gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
                       TCGTemp *src1, TCGTemp *src2)
 {
-    if (tcg_op_supported(INDEX_op_mulu2, type, 0)) {
-        gen_op_tttt(INDEX_op_mulu2, type, rl, rh, src1, src2);
-    } else if (tcg_op_supported(INDEX_op_muluh, type, 0)) {
+    if (tcg_op_supported(INDEX_op_muluh, type, 0)) {
         TCGTemp *t = tcg_temp_new_internal(type, TEMP_EBB);
 
         gen_mul(type, t, src1, src2);
@@ -1020,7 +1008,14 @@ static void gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
         gen_mov(type, rl, t);
 
         tcg_temp_free_internal(t);
-    } else if (type == TCG_TYPE_I32) {
+    } if (type == TCG_TYPE_I64 ||
+          tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
+        /*
+         * Unsupported mulu2_i64 is expanded after liveness analysis
+         * has a chance to discard an unused high-part.
+         */
+        gen_op_tttt(INDEX_op_mulu2, type, rl, rh, src1, src2);
+    } else {
         TCGTemp *t0 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
         TCGTemp *t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
 
@@ -1033,15 +1028,6 @@ static void gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
 
         tcg_temp_free_internal(t0);
         tcg_temp_free_internal(t1);
-    } else {
-        TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
-
-        gen_mul(TCG_TYPE_I64, t, src1, src2);
-        gen_helper_muluh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
-                             temp_tcgv_i64(src2));
-        gen_mov(TCG_TYPE_I64, rl, t);
-
-        tcg_temp_free_internal(t);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 489df0e7386..8cdca81ceb2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3687,6 +3687,32 @@ static inline void la_reset_pref(TCGTemp *ts)
         = (ts->state == TS_DEAD ? 0 : tcg_target_available_regs[ts->type]);
 }
 
+/* For liveness_pass_1, allocate a new dead temporary. */
+static TCGTemp *la_temp_new(TCGType type)
+{
+    TCGTemp *t = tcg_temp_new_internal(type, TEMP_EBB);
+
+    t->state_ptr = tcg_malloc(sizeof(TCGRegSet));
+    t->state = TS_DEAD;
+    la_reset_pref(t);
+
+    return t;
+}
+
+/* For liveness_pass_1, allocate a new constant. */
+static TCGTemp *la_const_new(TCGType type, int64_t val)
+{
+    TCGTemp *t = tcg_constant_internal(type, val);
+
+    /* This constant may already be live within the TB. */
+    if (!t->state_ptr) {
+        t->state_ptr = tcg_malloc(sizeof(TCGRegSet));
+        t->state = TS_DEAD;
+        la_reset_pref(t);
+    }
+    return t;
+}
+
 /* liveness analysis: end of function: all temps are dead, and globals
    should be in memory. */
 static void la_func_end(TCGContext *s, int ng, int nt)
@@ -3890,9 +3916,184 @@ static void assert_carry_dead(TCGContext *s)
     tcg_debug_assert(!s->carry_live);
 }
 
-/* Liveness analysis : update the opc_arg_life array to tell if a
-   given input arguments is dead. Instructions updating dead
-   temporaries are removed. */
+/*
+ * Expand missing mulu2.  This is delayed until liveness because x86
+ * translation generates double-word multiplies which may turn out to
+ * be dead with condition codes, and we may be able to simplify to
+ * just a single-word multiply.
+ */
+
+static TCGTemp *la_mulu2_ext32u(TCGContext *ctx, TCGOp *op,
+                                TCGTemp *dst, TCGTemp *src)
+{
+    TCGOp *op2 = tcg_op_insert_before(ctx, op, INDEX_op_extract,
+                                      TCG_TYPE_I64, 4);
+
+    op2->args[0] = temp_arg(dst);
+    op2->args[1] = temp_arg(src);
+    op2->args[2] = 0;
+    op2->args[3] = 32;
+    return dst;
+}
+
+static TCGTemp *la_mulu2_mov(TCGContext *ctx, TCGOp *op,
+                             TCGTemp *dst, TCGTemp *src)
+{
+    TCGOp *op2 = tcg_op_insert_before(ctx, op, INDEX_op_mov, TCG_TYPE_I64, 2);
+
+    op2->args[0] = temp_arg(dst);
+    op2->args[1] = temp_arg(src);
+    return dst;
+}
+
+static TCGTemp *la_mulu2_op3(TCGContext *ctx, TCGOp *op, TCGOpcode opc,
+                             TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    TCGOp *op2 = tcg_op_insert_before(ctx, op, opc, TCG_TYPE_I64, 3);
+
+    op2->args[0] = temp_arg(dst);
+    op2->args[1] = temp_arg(src1);
+    op2->args[2] = temp_arg(src2);
+    return dst;
+}
+
+static TCGTemp *la_mulu2_op3c(TCGContext *ctx, TCGOp *op, TCGOpcode opc,
+                              TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (src2->kind != TEMP_CONST && (src1->kind == TEMP_CONST || dst == src2)) {
+        TCGTemp *t = src1;
+        src1 = src2;
+        src2 = t;
+    }
+    return la_mulu2_op3(ctx, op, opc, dst, src1, src2);
+}
+
+static TCGOp *la_expand_mulu2_i64(TCGContext *s, TCGOp *op)
+{
+    TCGTemp *o0_orig = arg_temp(op->args[0]);
+    TCGTemp *o1_orig = arg_temp(op->args[1]);
+    TCGTemp *i0 = arg_temp(op->args[2]);
+    TCGTemp *i1 = arg_temp(op->args[3]);
+    TCGTemp *o0, *o1, *l0, *l1, *h0, *h1, *m0, *m1, *t0 = NULL, *t1 = NULL;
+    TCGTemp *t32 = la_const_new(TCG_TYPE_I64, 32);
+    TCGTemp *tzero = la_const_new(TCG_TYPE_I64, 0);
+    TCGOp *ret;
+
+    /*
+     * At present, the only two hosts missing some form of double-word or
+     * high-part multiply are s390x without misc-insn-ext-2 (before z14)
+     * or sparc64 without vis3 (before ultrasparc t3).
+     * Both of these have ext32u and addci.
+     */
+    tcg_debug_assert(op->opc == INDEX_op_mulu2);
+    tcg_debug_assert(TCGOP_TYPE(op) == TCG_TYPE_I64);
+    tcg_debug_assert(TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, 32));
+    tcg_debug_assert(tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0));
+
+    /*
+     * Split the two 64-bit multiplicands into unsigned halves.
+     * Via fold_multiply2, i0 must be non-constant.
+     */
+    l0 = la_mulu2_ext32u(s, op, la_temp_new(TCG_TYPE_I64), i0);
+    h0 = la_mulu2_op3(s, op, INDEX_op_shr, la_temp_new(TCG_TYPE_I64), i0, t32);
+
+    if (i1->kind == TEMP_CONST) {
+        l1 = la_const_new(TCG_TYPE_I64, extract64(i1->val, 0, 32));
+        h1 = la_const_new(TCG_TYPE_I64, extract64(i1->val, 32, 32));
+    } else {
+        l1 = la_mulu2_ext32u(s, op, la_temp_new(TCG_TYPE_I64), i1);
+        h1 = la_mulu2_op3(s, op, INDEX_op_shr,
+                          la_temp_new(TCG_TYPE_I64), i1, t32);
+    }
+
+    /*
+     * Compute partial products.
+     */
+    if (l1 == tzero) {
+        o0 = tzero;
+        m0 = tzero;
+    } else {
+        o0 = la_mulu2_op3c(s, op, INDEX_op_mul, o0_orig, l0, l1);
+        m0 = la_mulu2_op3c(s, op, INDEX_op_mul,
+                           la_temp_new(TCG_TYPE_I64), h0, l1);
+    }
+    if (h1 == tzero) {
+        m1 = tzero;
+        o1 = tzero;
+    } else {
+        m1 = la_mulu2_op3c(s, op, INDEX_op_mul,
+                           la_temp_new(TCG_TYPE_I64), l0, h1);
+        o1 = la_mulu2_op3c(s, op, INDEX_op_mul, o1_orig, h0, h1);
+    }
+
+    /*
+     * The middle partial products need shifting up by 32, producing
+     * bits within [63:32] and [95:64].
+     */
+    if (m0 != tzero) {
+        t0 = la_mulu2_op3(s, op, INDEX_op_shr,
+                          la_temp_new(TCG_TYPE_I64), m0, t32);
+        la_mulu2_op3(s, op, INDEX_op_shl, m0, m0, t32);
+        if (o0 == tzero) {
+            o0 = m0;
+            if (o1 == tzero) {
+                o1 = t0;
+            } else {
+                o1 = la_mulu2_op3c(s, op, INDEX_op_add, o0_orig, o1, t0);
+            }
+        } else {
+            o0 = la_mulu2_op3c(s, op, INDEX_op_addco, o0_orig, o0, m0);
+            o1 = la_mulu2_op3c(s, op, INDEX_op_addci, o1_orig, o1, t0);
+        }
+    }
+    if (m1 != tzero) {
+        t1 = la_mulu2_op3(s, op, INDEX_op_shr,
+                          la_temp_new(TCG_TYPE_I64), m1, t32);
+        la_mulu2_op3(s, op, INDEX_op_shl, m1, m1, t32);
+        if (o0 == tzero) {
+            o0 = m1;
+            if (o1 == tzero) {
+                o1 = t1;
+            } else {
+                o1 = la_mulu2_op3c(s, op, INDEX_op_add, o0_orig, o1, t1);
+            }
+        } else {
+            o0 = la_mulu2_op3c(s, op, INDEX_op_addco, o0_orig, o0, m1);
+            o1 = la_mulu2_op3c(s, op, INDEX_op_addci, o1_orig, o1, t1);
+        }
+    }
+
+    /* Final write-back, if necessary. */
+    if (o0 != o0_orig) {
+        la_mulu2_mov(s, op, o0_orig, o0);
+    }
+    if (o1 != o1_orig) {
+        la_mulu2_mov(s, op, o1_orig, o1);
+    }
+
+    tcg_temp_free_internal(l0);
+    tcg_temp_free_internal(l1);
+    tcg_temp_free_internal(h0);
+    tcg_temp_free_internal(h1);
+    tcg_temp_free_internal(m0);
+    tcg_temp_free_internal(m1);
+    if (t0) {
+        tcg_temp_free_internal(t0);
+    }
+    if (t1) {
+        tcg_temp_free_internal(t1);
+    }
+
+    ret = QTAILQ_PREV(op, link);
+    tcg_op_remove(s, op);
+    return ret;
+}
+
+/*
+ * Liveness analysis : update the opc_arg_life array to tell if a
+ * given input arguments is dead. Instructions updating dead
+ * temporaries are removed.
+ */
 static void __attribute__((noinline))
 liveness_pass_1(TCGContext *s)
 {
@@ -4067,10 +4268,11 @@ liveness_pass_1(TCGContext *s)
                 op->args[0] = op->args[1];
                 op->args[1] = op->args[2];
                 op->args[2] = op->args[3];
-            } else {
-                goto do_not_remove;
+            } else if (!tcg_op_supported(opc, TCGOP_TYPE(op), 0)) {
+                op = la_expand_mulu2_i64(s, op);
+                op_prev = QTAILQ_PREV(op, link);
+                opc = op->opc;
             }
-            /* Mark the single-word operation live.  */
             goto do_not_remove;
 
         case INDEX_op_addco:
-- 
2.53.0


