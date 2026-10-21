Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F285606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JzEQcV7Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXIM-0008JT-CM; Wed, 21 Oct 2026 10:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGw-0006gi-Ql
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGo-0002aE-Ux
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:30 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so649462f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592780; x=1793197580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XxNeUVy579aliX01IkpWVJ1r3IdXrrWfSmnqr8/64HM=;
 b=JzEQcV7QTjUCZ8NrgD8TxxPwZ0LUZbGPqBJUsFukP6DC67wpNPhwZIjp8j3aOtVSLG
 h1eyqn7o0bjgV5n1c3NbECMlG0DcHbOg/eX8Me1v+VYTiU+Wb1vmpAB2ItC6Ri6cKV/N
 yBgFAbrS4lT5ohgBdgKBs0hObWDXNy4x1nsxZJX9y5FyL74Gakh8VpiVGOVynjqbW+5R
 d0IfswiJyRv9mf75L0c7RObBB3NsAyCyuP2F/EoCBLlGRXIqW4ciLpd9pa12D7Oxs90o
 JvgynQpgkSlRRW/XfQ72EiEussApTJG3rjJAz+9kRWHl5jCX59kWmmIeK+Lv4TE6lSB+
 ehzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592780; x=1793197580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XxNeUVy579aliX01IkpWVJ1r3IdXrrWfSmnqr8/64HM=;
 b=uMEA0XtFTAWgS7IuYsGbTYwn5sMqAhP48FqjrDmGJVQXdnkvLqj4hPhm9Gzxvrx9YK
 vcyLCz2M8RBLRIaRI0vzkG7VJxRgpsmvrol3rlTVjHaALnz8hzk+Vz6hga5W/fcqvzr2
 jD+t7RB0VpP907T3h4utN+URobKNCiQCU5cRNHhanm86ibCiGekYB8tfA+4gvYXoqIFz
 Y+zF2FWdds8JXd4ka0fW1c17Wh7VAlwHLc9baWrR8RPRz62ioxrEgpNeD/Z2kJlKWoLc
 a75nO8MBBv9Zc+FvDsp6s55pemQyAo+GIIhn8o+x+T/+uO/WOdGrICo0UhbAIX5+Ghnr
 ZEDQ==
X-Gm-Message-State: AFq9FYIVZVOMJ4A2pXwVj6F4y+gBG4UsZ0wCKArVhLi4CtiMFIlZPvKd
 59z/FAT6bgPE4LgaTAVGi8gy6gVxegu+zACFOLhPebuABIg5Eit9meGCNEGDRG5XhFQ9jIZmpbu
 x1kpoELo=
X-Gm-Gg: AYBFou1fZ1+VA0Jxb1ZGcp3iMYwPnQnR7pivJ1Ob3Fck/F00cA0s+48tQHex41DaTNX
 Yw0n2NtasamfBxfFOLI7IO6oTtb0xQNZhcW966PLagT6I/gOKKeR0i5jtPdq8+wyOdR3UGOsPtH
 e8qlb32QvXpvFPumlx1xlBRKvGx84iRwroJ6QQ17lRaWoDYCGpkVzADof0uHXxcmMr/cY1yQYBl
 ZQVH+Ns38F4B0ii86mvAcckHO33qv5YC68kFJ2bT9i0g2klZ6dg/lA4k61XA1cb4xACt1ZKbJjS
 e65mBFYSUKCzlIVzm6gJZj+fMqmaN9EmAMujdI++7Rzhfo4UF1hkiCC47hQuIR541giINVuDlkP
 mqO9nbaORdLOoBufb0gT3BmeLzGfnUjZj7Sbd0JUY/yyYke1AVthHrkPQ2LFmWXnKAnOp/iAUSp
 x+Ry3snKpgdPT4QEFPDi4g4TxSrJlpIEtOLXFUSbGTzjk8LcTzWyqDShwznAjx7DLCVL+NOl2ya
 kW74/NVUAcyb6kt+e3KTqNYjls1ON8g4wixrzggeJmdLrFLH1H/eIN7VR8CRqp7FIfCGpjMr4Ht
 5K5N9aRcm5lHZ2dZ6/kcct+klk30
X-Received: by 2002:a05:6000:41c7:b0:48d:f3ec:e818 with SMTP id
 ffacd0b85a97d-48e1e7a7aeemr13620858f8f.7.1792592779635; 
 Wed, 21 Oct 2026 07:26:19 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 098/100] tcg: Generic expansion of
 tcg_gen_{non}atomic_qemu_cmpxchg_chk
Date: Wed, 21 Oct 2026 16:16:50 +0200
Message-ID: <20261021141652.363109-99-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  16 +--
 include/tcg/tcg-op-mem.h     |   2 +-
 tcg/tcg-internal.h           |   3 +
 include/tcg/tcg-op-def.h.inc |   3 +
 tcg/tcg-op-ldst.c            | 237 ++++++++++++++---------------------
 tcg/tcg-op.c                 |   8 ++
 6 files changed, 115 insertions(+), 154 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 711eb96a86..06991b9fa3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -104,6 +104,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4, T5);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4, T5, T6);
+#define DEF7(NAME, T1, T2, T3, T4, T5, T6, T7) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4, T5, T6, T7);
 
 #define TCGV  glue(TCGv,TExt)
 #define TExt  _i32
@@ -129,6 +131,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF4
 #undef DEF5
 #undef DEF6
+#undef DEF7
 
 /* 32 bit ops */
 
@@ -180,18 +183,9 @@ void tcg_gen_qemu_st_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 
 /* Atomic ops */
 
-void tcg_gen_atomic_cmpxchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32, TCGv_i32,
-                                    TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_cmpxchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64, TCGv_i64,
-                                    TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_cmpxchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
+void tcg_gen_atomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                      TCGv_i128, TCGArg, MemOp, TCGType);
-
-void tcg_gen_nonatomic_cmpxchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_nonatomic_cmpxchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_nonatomic_cmpxchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
+void tcg_gen_nonatomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                         TCGv_i128, TCGArg, MemOp, TCGType);
 
 void tcg_gen_atomic_xchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index e8425e1059..935860f144 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -72,7 +72,7 @@ tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 #define DEF_ATOMIC3(N, S)                                               \
     QEMU_ARG_NONNULL static inline void                                 \
     N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S o, TCGv_##S n, TCGArg i, MemOp m) \
-    { N##_##S##_chk(r, tcgv_va_temp(a), o, n, i, m, TCG_TYPE_VA); }
+    { N##_chk_##S(r, tcgv_va_temp(a), o, n, i, m, TCG_TYPE_VA); }
 
 DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i32)
 DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i64)
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index bfd34905ee..da1b9c9bab 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -190,6 +190,8 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
+#define DEF7(NAME, T1, T2, T3, T4, T5, T6, T7) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6, T7);
 
 #define TCGV      TCGTemp *
 #define TINT      int64_t
@@ -207,6 +209,7 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #undef DEF4
 #undef DEF5
 #undef DEF6
+#undef DEF7
 
 static inline void tcg_gen_extrh(TCGTemp *dst, TCGTemp *src)
 {
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 552f62b7f4..e0ffd0da67 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -85,3 +85,6 @@ DEF3(umin, TCGV, TCGV, TCGV)
 DEF3(ussub, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
+
+DEF7(atomic_cmpxchg_chk, TCGV, TCGTempPtr, TCGV, TCGV, unsigned, MemOp, TCGType)
+DEF7(nonatomic_cmpxchg_chk, TCGV, TCGTempPtr, TCGV, TCGV, unsigned, MemOp, TCGType)
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index d9133e611e..886d632f75 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -667,181 +667,129 @@ typedef void (*gen_atomic_op_i128)(TCGv_i128, TCGv_env, TCGv_i64,
 # define WITH_ATOMIC128(X)
 #endif
 
-static void * const table_cmpxchg[(MO_SIZE | MO_BSWAP) + 1] = {
-    [MO_8] = gen_helper_atomic_cmpxchgb,
-    [MO_16 | MO_LE] = gen_helper_atomic_cmpxchgw_le,
-    [MO_16 | MO_BE] = gen_helper_atomic_cmpxchgw_be,
-    [MO_32 | MO_LE] = gen_helper_atomic_cmpxchgl_le,
-    [MO_32 | MO_BE] = gen_helper_atomic_cmpxchgl_be,
-    [MO_64 | MO_LE] = gen_helper_atomic_cmpxchgq_le,
-    [MO_64 | MO_BE] = gen_helper_atomic_cmpxchgq_be,
-    WITH_ATOMIC128([MO_128 | MO_LE] = gen_helper_atomic_cmpxchgo_le)
-    WITH_ATOMIC128([MO_128 | MO_BE] = gen_helper_atomic_cmpxchgo_be)
-};
-
-static void tcg_gen_nonatomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
-                                              TCGv_i32 cmpv, TCGv_i32 newv,
-                                              TCGArg idx, MemOp memop)
+static void tcg_gen_nonatomic_cmpxchg_int(TCGType type, TCGTemp *retv,
+                                          TCGTemp *addr, TCGTemp *cmpv,
+                                          TCGTemp *newv, unsigned idx,
+                                          MemOp memop)
 {
-    TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-    TCGv_i32 t2 = tcg_temp_ebb_new_i32();
+    g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+    g_autoptr(TCGTemp) t2 = tcg_temp_new_ebb(type);
 
-    tcg_gen_ext_i32(t2, cmpv, memop & MO_SIZE);
+    tcg_gen_ext(type, t2, cmpv, memop & MO_SIZE);
 
-    tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1),
-                        addr, idx, memop & ~MO_SIGN);
-    tcg_gen_movcond_i32(TCG_COND_EQ, t2, t1, t2, newv, t1);
-    tcg_gen_qemu_st_int(TCG_TYPE_I32, tcgv_i32_temp(t2), addr, idx, memop);
-    tcg_temp_free_i32(t2);
+    tcg_gen_qemu_ld_int(type, t1, addr, idx, memop & ~MO_SIGN);
+    tcg_gen_movcond(type, TCG_COND_EQ, t2, t1, t2, newv, t1);
+    tcg_gen_qemu_st_int(type, t2, addr, idx, memop);
 
     if (memop & MO_SIGN) {
-        tcg_gen_ext_i32(retv, t1, memop);
+        tcg_gen_ext(type, retv, t1, memop);
     } else {
-        tcg_gen_mov_i32(retv, t1);
+        tcg_gen_mov(type, retv, t1);
     }
-    tcg_temp_free_i32(t1);
 }
 
-void tcg_gen_nonatomic_cmpxchg_i32_chk(TCGv_i32 retv, TCGTemp *addr,
-                                       TCGv_i32 cmpv, TCGv_i32 newv,
-                                       TCGArg idx, MemOp memop,
-                                       TCGType addr_type)
+void tcg_gen_nonatomic_cmpxchg_chk(TCGType val_type, TCGTemp *retv,
+                                   TCGTemp *addr, TCGTemp *cmpv, TCGTemp *newv,
+                                   unsigned idx, MemOp memop, TCGType addr_type)
 {
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);
-    tcg_debug_assert((memop & MO_SIZE) <= MO_32);
-    tcg_gen_nonatomic_cmpxchg_i32_int(retv, addr, cmpv, newv, idx, memop);
+    tcg_debug_assert(memop_size(memop) <= tcg_type_size(val_type));
+    tcg_debug_assert(idx < NB_MMU_MODES);
+
+    tcg_gen_nonatomic_cmpxchg_int(val_type, retv, addr, cmpv, newv, idx, memop);
 }
 
-static void tcg_gen_atomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
-                                           TCGv_i32 cmpv, TCGv_i32 newv,
-                                           TCGArg idx, MemOp memop)
+static void tcg_gen_atomic_cmpxchg_int(TCGType type, TCGTemp *retv,
+                                       TCGTemp *addr, TCGTemp *cmpv,
+                                       TCGTemp *newv, unsigned idx,
+                                       MemOp orig_memop)
 {
-    gen_atomic_cx_i32 gen;
+    MemOp memop = orig_memop;
     TCGv_i64 a64;
     MemOpIdx oi;
 
     if (!(tcg_ctx->gen_tb->cflags & CF_PARALLEL)) {
-        tcg_gen_nonatomic_cmpxchg_i32_int(retv, addr, cmpv, newv, idx, memop);
+        tcg_gen_nonatomic_cmpxchg_int(type, retv, addr, cmpv,
+                                      newv, idx, memop);
         return;
     }
 
-    memop = tcg_canonicalize_memop(memop, 0, 0);
-    gen = table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
-    tcg_debug_assert(gen != NULL);
-
-    oi = make_memop_idx(memop & ~MO_SIGN, idx);
     a64 = maybe_extend_addr64(addr);
-    gen(retv, tcg_env, a64, cmpv, newv, tcg_constant_i32(oi));
-    maybe_free_addr64(a64);
-
-    if (memop & MO_SIGN) {
-        tcg_gen_ext_i32(retv, retv, memop);
-    }
-}
-
-void tcg_gen_atomic_cmpxchg_i32_chk(TCGv_i32 retv, TCGTemp *addr,
-                                    TCGv_i32 cmpv, TCGv_i32 newv,
-                                    TCGArg idx, MemOp memop,
-                                    TCGType addr_type)
-{
-    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
-    tcg_debug_assert((memop & MO_SIZE) <= MO_32);
-    tcg_gen_atomic_cmpxchg_i32_int(retv, addr, cmpv, newv, idx, memop);
-}
-
-static void tcg_gen_nonatomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
-                                              TCGv_i64 cmpv, TCGv_i64 newv,
-                                              TCGArg idx, MemOp memop)
-{
-    TCGv_i64 t1, t2;
-
-    t1 = tcg_temp_ebb_new_i64();
-    t2 = tcg_temp_ebb_new_i64();
-
-    tcg_gen_ext_i64(t2, cmpv, memop & MO_SIZE);
-
-    tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1),
-                        addr, idx, memop & ~MO_SIGN);
-    tcg_gen_movcond_i64(TCG_COND_EQ, t2, t1, t2, newv, t1);
-    tcg_gen_qemu_st_int(TCG_TYPE_I64, tcgv_i64_temp(t2), addr, idx, memop);
-    tcg_temp_free_i64(t2);
-
-    if (memop & MO_SIGN) {
-        tcg_gen_ext_i64(retv, t1, memop);
-    } else {
-        tcg_gen_mov_i64(retv, t1);
-    }
-    tcg_temp_free_i64(t1);
-}
-
-void tcg_gen_nonatomic_cmpxchg_i64_chk(TCGv_i64 retv, TCGTemp *addr,
-                                       TCGv_i64 cmpv, TCGv_i64 newv,
-                                       TCGArg idx, MemOp memop,
-                                       TCGType addr_type)
-{
-    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
-    tcg_debug_assert((memop & MO_SIZE) <= MO_64);
-    tcg_gen_nonatomic_cmpxchg_i64_int(retv, addr, cmpv, newv, idx, memop);
-}
-
-static void tcg_gen_atomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
-                                           TCGv_i64 cmpv, TCGv_i64 newv,
-                                           TCGArg idx, MemOp memop)
-{
-    if (!(tcg_ctx->gen_tb->cflags & CF_PARALLEL)) {
-        tcg_gen_nonatomic_cmpxchg_i64_int(retv, addr, cmpv, newv, idx, memop);
-        return;
-    }
 
     if ((memop & MO_SIZE) == MO_64) {
         gen_atomic_cx_i64 gen;
 
+        tcg_debug_assert(type == TCG_TYPE_I64);
+
         memop = tcg_canonicalize_memop(memop, 1, 0);
-        gen = table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
-        if (gen) {
-            MemOpIdx oi = make_memop_idx(memop, idx);
-            TCGv_i64 a64 = maybe_extend_addr64(addr);
-            gen(retv, tcg_env, a64, cmpv, newv, tcg_constant_i32(oi));
-            maybe_free_addr64(a64);
-            return;
+        oi = make_memop_idx(memop & ~MO_SIGN, idx);
+
+        gen = ((memop & MO_BSWAP) == MO_LE
+               ? gen_helper_atomic_cmpxchgq_le
+               : gen_helper_atomic_cmpxchgq_be);
+
+        gen(temp_tcgv_i64(retv), tcg_env, a64, temp_tcgv_i64(cmpv),
+            temp_tcgv_i64(newv), tcg_constant_i32(oi));
+    } else {
+        static gen_atomic_cx_i32 const table_cmpxchg[(MO_SIZE | MO_BSWAP) + 1] = {
+            [MO_8] = gen_helper_atomic_cmpxchgb,
+            [MO_16 | MO_LE] = gen_helper_atomic_cmpxchgw_le,
+            [MO_16 | MO_BE] = gen_helper_atomic_cmpxchgw_be,
+            [MO_32 | MO_LE] = gen_helper_atomic_cmpxchgl_le,
+            [MO_32 | MO_BE] = gen_helper_atomic_cmpxchgl_be,
+        };
+
+        g_autoptr(TCGTemp) c32 = NULL;
+        g_autoptr(TCGTemp) n32 = NULL;
+        g_autoptr(TCGTemp) r32 = NULL;
+        TCGTemp *retv_orig = retv;
+        gen_atomic_cx_i32 gen;
+
+        if (type == TCG_TYPE_I64) {
+            c32 = tcg_temp_new_ebb(TCG_TYPE_I32);
+            n32 = tcg_temp_new_ebb(TCG_TYPE_I32);
+            r32 = tcg_temp_new_ebb(TCG_TYPE_I32);
+
+            tcg_gen_extrl(c32, cmpv);
+            tcg_gen_extrl(n32, newv);
+
+            cmpv = c32;
+            newv = n32;
+            retv = r32;
         }
 
-        gen_helper_exit_atomic(tcg_env);
+        memop = tcg_canonicalize_memop(memop, 0, 0);
+        oi = make_memop_idx(memop & ~MO_SIGN, idx);
 
-        /*
-         * Produce a result for a well-formed opcode stream.  This satisfies
-         * liveness for set before used, which happens before this dead code
-         * is removed.
-         */
-        tcg_gen_movi_i64(retv, 0);
-    } else {
-        TCGv_i32 c32 = tcg_temp_ebb_new_i32();
-        TCGv_i32 n32 = tcg_temp_ebb_new_i32();
-        TCGv_i32 r32 = tcg_temp_ebb_new_i32();
+        gen = table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
+        tcg_debug_assert(gen != NULL);
 
-        tcg_gen_extrl_i64_i32(c32, cmpv);
-        tcg_gen_extrl_i64_i32(n32, newv);
-        tcg_gen_atomic_cmpxchg_i32_int(r32, addr, c32, n32,
-                                       idx, memop & ~MO_SIGN);
-        tcg_temp_free_i32(c32);
-        tcg_temp_free_i32(n32);
-
-        tcg_gen_extu_i32_i64(retv, r32);
-        tcg_temp_free_i32(r32);
+        gen(temp_tcgv_i32(retv), tcg_env, a64, temp_tcgv_i32(cmpv),
+            temp_tcgv_i32(newv), tcg_constant_i32(oi));
 
         if (memop & MO_SIGN) {
-            tcg_gen_ext_i64(retv, retv, memop);
+            tcg_gen_ext(TCG_TYPE_I32, retv, retv, memop);
+        }
+        if (retv != retv_orig) {
+            if (orig_memop & MO_SIGN) {
+                tcg_gen_exts(retv_orig, retv);
+            } else {
+                tcg_gen_extu(retv_orig, retv);
+            }
         }
     }
+    maybe_free_addr64(a64);
 }
 
-void tcg_gen_atomic_cmpxchg_i64_chk(TCGv_i64 retv, TCGTemp *addr,
-                                    TCGv_i64 cmpv, TCGv_i64 newv,
-                                    TCGArg idx, MemOp memop, TCGType addr_type)
+void tcg_gen_atomic_cmpxchg_chk(TCGType val_type, TCGTemp *retv, TCGTemp *addr,
+                                TCGTemp *cmpv, TCGTemp *newv,
+                                unsigned idx, MemOp memop, TCGType addr_type)
 {
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);
-    tcg_debug_assert((memop & MO_SIZE) <= MO_64);
-    tcg_gen_atomic_cmpxchg_i64_int(retv, addr, cmpv, newv, idx, memop);
+    tcg_debug_assert(memop_size(memop) <= tcg_type_size(val_type));
+    tcg_debug_assert(idx < NB_MMU_MODES);
+
+    tcg_gen_atomic_cmpxchg_int(val_type, retv, addr, cmpv, newv, idx, memop);
 }
 
 static void tcg_gen_nonatomic_cmpxchg_i128_int(TCGv_i128 retv, TCGTemp *addr,
@@ -877,7 +825,7 @@ static void tcg_gen_nonatomic_cmpxchg_i128_int(TCGv_i128 retv, TCGTemp *addr,
     tcg_temp_free_i128(oldv);
 }
 
-void tcg_gen_nonatomic_cmpxchg_i128_chk(TCGv_i128 retv, TCGTemp *addr,
+void tcg_gen_nonatomic_cmpxchg_chk_i128(TCGv_i128 retv, TCGTemp *addr,
                                         TCGv_i128 cmpv, TCGv_i128 newv,
                                         TCGArg idx, MemOp memop,
                                         TCGType addr_type)
@@ -887,18 +835,23 @@ void tcg_gen_nonatomic_cmpxchg_i128_chk(TCGv_i128 retv, TCGTemp *addr,
     tcg_gen_nonatomic_cmpxchg_i128_int(retv, addr, cmpv, newv, idx, memop);
 }
 
-static void tcg_gen_atomic_cmpxchg_i128_int(TCGv_i128 retv, TCGTemp *addr,
+static void tcg_gen_atomic_cmpxchg_int_i128(TCGv_i128 retv, TCGTemp *addr,
                                             TCGv_i128 cmpv, TCGv_i128 newv,
                                             TCGArg idx, MemOp memop)
 {
-    gen_atomic_cx_i128 gen;
+    gen_atomic_cx_i128 gen = NULL;
 
     if (!(tcg_ctx->gen_tb->cflags & CF_PARALLEL)) {
         tcg_gen_nonatomic_cmpxchg_i128_int(retv, addr, cmpv, newv, idx, memop);
         return;
     }
 
-    gen = table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
+#if HAVE_CMPXCHG128
+    gen = ((memop & MO_BSWAP) == MO_LE
+           ? gen_helper_atomic_cmpxchgo_le
+           : gen_helper_atomic_cmpxchgo_be);
+#endif
+
     if (gen) {
         MemOpIdx oi = make_memop_idx(memop, idx);
         TCGv_i64 a64 = maybe_extend_addr64(addr);
@@ -918,14 +871,14 @@ static void tcg_gen_atomic_cmpxchg_i128_int(TCGv_i128 retv, TCGTemp *addr,
     tcg_gen_movi_i64(TCGV128_HIGH(retv), 0);
 }
 
-void tcg_gen_atomic_cmpxchg_i128_chk(TCGv_i128 retv, TCGTemp *addr,
+void tcg_gen_atomic_cmpxchg_chk_i128(TCGv_i128 retv, TCGTemp *addr,
                                      TCGv_i128 cmpv, TCGv_i128 newv,
                                      TCGArg idx, MemOp memop,
                                      TCGType addr_type)
 {
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);
     tcg_debug_assert((memop & (MO_SIZE | MO_SIGN)) == MO_128);
-    tcg_gen_atomic_cmpxchg_i128_int(retv, addr, cmpv, newv, idx, memop);
+    tcg_gen_atomic_cmpxchg_int_i128(retv, addr, cmpv, newv, idx, memop);
 }
 
 static void do_nonatomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 679cf87995..0a0597968e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -231,6 +231,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c),  \
                      glue(C_,T4)(d), glue(C_,T5)(e), glue(C_,T6)(f)); }
 
+#define DEF7(NAME, T1, T2, T3, T4, T5, T6, T7)                          \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c, T4 d, T5 e,   \
+                                        T6 f, T7 g)                     \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),              \
+                     glue(C_,T3)(c), glue(C_,T4)(d), glue(C_,T5)(e),    \
+                     glue(C_,T6)(f), glue(C_,T7)(g)); }
+
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_TCGv_ptr      tcgv_ptr_temp
@@ -285,6 +292,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF4
 #undef DEF5
 #undef DEF6
+#undef DEF7
 
 /*
  * Internal helper for bit and byte reversal.
-- 
2.53.0


