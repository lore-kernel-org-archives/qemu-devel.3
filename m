Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BCE606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C2QO9TnH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6rW-0008HF-6z; Wed, 28 Oct 2026 12:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6rJ-0008G9-SK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:50:43 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6rF-0001Ae-VM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:50:40 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-706113e92f9so786964eaf.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793206236; x=1793811036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=znhc5os+SCwClFeSRk6JeDDYPG9rs1MD2FqXqqmrPXM=;
 b=C2QO9TnHmg5FIA7Ek64Fhz6MLL5Kr77qqSSrvFouRPlgSqqQFs5bt+cN408qrfn3Hj
 2OfeuLxBTRi6V6XO/h+4511XgtapZUXEOpA6MOp9XhwxRCWJbeQnEWoHhp6PbhOb7YDr
 /rZ3WMxnhI94eShELnt1HwDb/qzqFNYswcYjwYlLebHKFrArl4b+/9QKIjyag8MN/8fc
 tPlAvrp+3RMebCYdi0zvBF7485r4mztXtae+5zB72f3LtdgVLY/VOG4znP5vNAHr//1B
 q2WmJJY/L/aJcUzln5OzUn2Zhs4geTOZveEtkHN8Q+d/Dro9wsOcZDZ8rau1Ct3ggwjz
 GHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793206236; x=1793811036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=znhc5os+SCwClFeSRk6JeDDYPG9rs1MD2FqXqqmrPXM=;
 b=rUOmvzv425gynCM0n+oxhZ4ZGkY1NCdwnBXolYADeBg1VaYRZW4QIFJZ62osBu1g1v
 UHCcOgMIX0v4Z66e6bdo/MdvyQ+9YeYHAKYyIVklwvMvhQszuK/69KxMPhTk3M6x0doS
 scTXQ+m92jNrQncd0FMbUj+SoKlp8t5UBd/l5m9LaopI9VPq0AvUJJ4S/IoPB3JTkw6f
 C4xlOKhbDMEqNJ+78PCyQkeduruzouXkAuCehN8/bK/jXEj5XDcWK508QMJzs6X9KAVg
 Xz66daCM9/SCev1gMD7cxLOCYZUcoVdufrXBXl9Ft3dOIV53GZfKqduSt12FNT5ouDTG
 7Law==
X-Gm-Message-State: AFq9FYLYa3/Pr3FuF3DRKSqV4lkaqehIlmVQ1c2XJm0NZPtLM8kV3Xt7
 XdgZ0GkmYCGgUkJaRdfz9WjACAiBnDF4LXS1yV5Rbj9z4b9FhOTMudTEPsK5woov9FVnVCLMGZv
 Wcggn
X-Gm-Gg: AYBFou3WtXISL8vuCSdVJ1W6sS1bscEAQd2/rUHoeiZvqmXSZ2Pip/wb6GlcXHPxNbp
 7cgLBLnVL00QzxZTN8hmbDyXWTVNITHESEML2G+SlG+PbCFEtcCyJCsnjE8Tn4EQnvm7HFtKaD9
 JtZ+tGG0mYgy2FXKbhiei/7sHF6YAcjfl/UbSt2qCyZ4mHn1uRuGGo2fTEIip7ZTSUvcE1dWhdb
 PfZWH8iguiW4etar4CRuj9xcgB6HCLEnp49Pm1E7kxObSoxTfZoyBVBdBVZiX/2Prz8AGL6qrR4
 ZiSCNscQdg3sxd4IMnG3QZfYNQdqQLrTrsroBDpbVIoRSF1Bq41r7zp4lVbHnsFfakoSf4kPmf6
 v1CULHCeie7NhmLB6PhuWJ+GjXOtn6mF18YKVddG8ZZyLtAeyw+bPzkavSgUnnuxkBhQS4TEaW6
 9nH/kiBkwy05m6ZxQO/NsCU40Ky5kpnNa67UprnSK60ohsdJfldzXEQYzD0yuACLHG4wLeAQQZZ
 WN2SbsxVec1F17KOfS8neRGYCodzc6uPVTwAgUejabOMJmPwqNfwldVyfrmoaeAn0kh0gBXrS2K
 ImMZ9d778Q9CRjlc9kcGEBNfvhPyzs8NnKs=
X-Received: by 2002:a05:6820:3503:10b0:70a:4053:52d5 with SMTP id
 006d021491bc7-713ee85de8amr1148129eaf.10.1793206235392; 
 Wed, 28 Oct 2026 09:50:35 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1d457eb5sm2169304a34.2.2026.10.28.09.50.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:50:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg: Expand missing mulu2_i64 during liveness
Date: Wed, 28 Oct 2026 11:50:33 -0500
Message-ID: <20261028165033.1173291-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 tcg/tcg-op.c            |  32 +++---
 tcg/tcg.c               | 213 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 219 insertions(+), 43 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 003c963bc7..0dda2079fd 100644
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
index 77c4024148..44b48a1ea7 100644
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
index 4814a493c0..58bcdc9a9f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -881,8 +881,7 @@ void tcg_gen_muls2(TCGType type, TCGTemp *rl, TCGTemp *rh,
         tcg_gen_mul(TCG_TYPE_I64, t0, t0, t1);
         tcg_gen_extrl(rl, t0);
         tcg_gen_extrh(rh, t0);
-    } else if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0) ||
-               tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
+    } else {
         g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
         g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
         g_autoptr(TCGTemp) t2 = NULL;
@@ -900,28 +899,28 @@ void tcg_gen_muls2(TCGType type, TCGTemp *rl, TCGTemp *rh,
         tcg_gen_sub(TCG_TYPE_I64, rh, t1, t2);
         tcg_gen_sub(TCG_TYPE_I64, rh, rh, t3);
         tcg_gen_mov(TCG_TYPE_I64, rl, t0);
-    } else {
-        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
-
-        tcg_gen_mul(TCG_TYPE_I64, t, src1, src2);
-        gen_helper_mulsh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
-                             temp_tcgv_i64(src2));
-        tcg_gen_mov(TCG_TYPE_I64, rl, t);
     }
 }
 
 void tcg_gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
                    TCGTemp *src1, TCGTemp *src2)
 {
-    if (tcg_op_supported(INDEX_op_mulu2, type, 0)) {
-        tcg_gen_op_tttt(INDEX_op_mulu2, type, rl, rh, src1, src2);
-    } else if (tcg_op_supported(INDEX_op_muluh, type, 0)) {
+    bool has_u2 = tcg_op_supported(INDEX_op_mulu2, type, 0);
+    bool has_uh = tcg_op_supported(INDEX_op_muluh, type, 0);
+
+    if (has_uh && !has_u2) {
         g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
 
         tcg_gen_mul(type, t, src1, src2);
         tcg_gen_op_ttt(INDEX_op_muluh, type, rh, src1, src2);
         tcg_gen_mov(type, rl, t);
-    } else if (type == TCG_TYPE_I32) {
+    } else if (has_u2 || type == TCG_TYPE_I64) {
+        /*
+         * Unsupported mulu2_i64 is expanded after liveness analysis
+         * has a chance to discard an unused high-part.
+         */
+        tcg_gen_op_tttt(INDEX_op_mulu2, type, rl, rh, src1, src2);
+    } else {
         g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(TCG_TYPE_I64);
         g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(TCG_TYPE_I64);
 
@@ -931,13 +930,6 @@ void tcg_gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
         tcg_gen_mul(TCG_TYPE_I64, t0, t0, t1);
         tcg_gen_extrl(rl, t0);
         tcg_gen_extrh(rh, t0);
-    } else {
-        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
-
-        tcg_gen_mul(TCG_TYPE_I64, t, src1, src2);
-        gen_helper_muluh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
-                             temp_tcgv_i64(src2));
-        tcg_gen_mov(TCG_TYPE_I64, rl, t);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1cd6d41d31..640eba295c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3694,6 +3694,32 @@ static inline void la_reset_pref(TCGTemp *ts)
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
@@ -3897,9 +3923,180 @@ static void assert_carry_dead(TCGContext *s)
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
+    g_autoptr(TCGTemp) l0 = NULL;
+    g_autoptr(TCGTemp) l1 = NULL;
+    g_autoptr(TCGTemp) h0 = NULL;
+    g_autoptr(TCGTemp) h1 = NULL;
+    g_autoptr(TCGTemp) m0 = NULL;
+    g_autoptr(TCGTemp) m1 = NULL;
+    g_autoptr(TCGTemp) t0 = NULL;
+    g_autoptr(TCGTemp) t1 = NULL;
+    /* o0/o1 will equal one of the inputs or another autoptr temp. */
+    TCGTemp *o0, *o1;
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
@@ -4074,10 +4271,11 @@ liveness_pass_1(TCGContext *s)
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
@@ -6619,6 +6817,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
 
     tcg_optimize(s);
 
+    /* Do not reuse any EBB that may be allocated within the TB. */
+    tcg_temp_ebb_reset_freed(s);
+
     reachable_code_pass(s);
     liveness_pass_0(s);
     liveness_pass_1(s);
-- 
2.53.0


