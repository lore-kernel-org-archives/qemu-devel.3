Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8273C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksL-0007K8-DC; Sun, 27 Sep 2026 05:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrh-000365-Ea
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:09 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkre-0008JS-4e
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:09 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398a147688bso1554129a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500085; x=1791104885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qs28EUYot0a0Xuz5/7XpraB5uCTYFj6q2KdLQyr40vY=;
 b=l8ORPqeJ3GS4XYf5p7NE/+E4QtFzTvTc0ST9naUnu1m63Lrf86UookQRkEviYFvFYS
 LA1+SlLKDpZtaB0mq3OvdBL6BNuaye14KnUvsAv7hdhu2mCmxmScgX5nUfxXvFXuPDRs
 K5or+jb5lHNH9PIRhuFmOHVjjFKasWZYIIn0VX/4uhZsV4p7eNwHS8QtRPsQSuhvOAG3
 8fXtWBh7rMDmzVgHa/vOZN0OItYF/vjwxnCV4U1mgvJLtEI5mu9HYQ5//sFRJyY+jhjB
 8Xi4eNGxkau5ilLHylT/5d1bPOaJvy1S+i/MhDCdRH5kmw7aX+rcCT0nY4LZhxclusX+
 rDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500085; x=1791104885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qs28EUYot0a0Xuz5/7XpraB5uCTYFj6q2KdLQyr40vY=;
 b=hCuhWxXe7m4HDUEG99lTSditeXmwgL6WtAOMCPLDtbKPotCMU0tJNOoi4gHMQUT0fQ
 MToWsH2otCgajfkpCMRdTKLMhuZufChM1ihSTck1pfvMon9DIZZHbsusHXTMxSBiRa7c
 8luX9tUyf9CvthieO1fcFnnErB0ADWqEdR5t8KDQIR/NxPhMneuwTAXyQnEHgWDxQe+t
 igwkoK9+iacBB/A6mMliB3ywHjP4Shu37pEGtwFCbz7ZRCV4DQLN/iBAo1f3Khh924//
 IpULQfCHXmrqSXrMMwgnVy/iH3Kf50Rk5wP3xalMW/r2do5LMPlnlvq2IMn1qETpJwSC
 lUTw==
X-Gm-Message-State: AFq9FYKJsgb5UQYf6RiFcg757d7PUq7qHZ6PK5FxjmsRH1RHneU3Ghxj
 B9+oOVlwtb+K88jArt9IWYEg8dir0aKDmxP8DO7dsKcpdTypd1rwEpiGzuGdgy5w2QLh5fn40yt
 cxeEo
X-Gm-Gg: AYBFou0wiOky7GPfcmGgdXK5oeFoeK7sIh0k+69X1P2B1wX4YVQhqhpDwD67pETjqt0
 LN8Ko9+y+bT796xRoh74FCQYHrXUyZhQs9cxZHGuKHXktCFObujvbf+FjEdN1Amnr5+AOT3BQAz
 soSDrRIeO2i8JePoy800ZiHrjt3g4o3gIzjw2KT5VBdQL2Kliw98wr8dX7Hn4c6RCkUeW7w5bFX
 VXgLgCBvS+ESFwcvANapZcOGgUzntbXGSDXrPze94GB3AvvavJctnG/7WF5PmzUl9F8C0DqKSiH
 7jawJWcKCNZlPPAL1YTzLDlnezl+M48taQUE5BJf6Yrqm2Ax61HCdcdl8I2JPRiukbDmPA5vtNv
 pKNhsVsni/KO1E2KmcPkSVpcW1S1n4sE1VXhsawdElGIr1tHUknmcHjLCRTHkVlBzo/+6Ep7LZm
 5yszGnCsKGBJ5hqnQGEb3dLN2AOBg3tG/m5cOE7E5XyBAanYg2Zpltyswm0rSbbGBJmai15Vfb7
 xyg2UoL1PKIOZH9r9c9r9g07/dMMA==
X-Received: by 2002:a17:90b:3d8d:b0:3a0:ddef:3d69 with SMTP id
 98e67ed59e1d1-3a0ddef3f5amr3177960a91.58.1790500084532; 
 Sun, 27 Sep 2026 02:08:04 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:08:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 099/101] tcg: Generic expansion of
 tcg_gen_{non}atomic_qemu_cmpxchg_chk
Date: Sun, 27 Sep 2026 02:00:09 -0700
Message-ID: <20260927090011.10724-100-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  16 +--
 include/tcg/tcg-op-mem.h     |   2 +-
 tcg/tcg-internal.h           |   3 +
 include/tcg/tcg-op-def.h.inc |   3 +
 tcg/tcg-op-ldst.c            | 237 ++++++++++++++---------------------
 tcg/tcg-op.c                 |   8 ++
 6 files changed, 113 insertions(+), 156 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4fec1500d56..9864674f1c2 100644
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
index e8425e10598..935860f1442 100644
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
index bfd34905ee7..da1b9c9bab3 100644
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
index 552f62b7f4f..e0ffd0da678 100644
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
index 7345bdfcc2b..b3143f6311b 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -667,181 +667,125 @@ typedef void (*gen_atomic_op_i128)(TCGv_i128, TCGv_env, TCGv_i64,
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
+                                       MemOp memop)
 {
-    gen_atomic_cx_i32 gen;
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
-        gen_atomic_cx_i64 gen;
+        gen_atomic_cx_i64 gen = ((memop & MO_BSWAP) == MO_LE
+                                 ? gen_helper_atomic_cmpxchgq_le
+                                 : gen_helper_atomic_cmpxchgq_be);
+
+        tcg_debug_assert(type == TCG_TYPE_I64);
 
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
+
+        gen_atomic_cx_i32 gen = table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
+        tcg_debug_assert(gen != NULL);
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
-
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
+            if (memop & MO_SIGN) {
+                tcg_gen_exts(retv_orig, retv);
+            } else {
+                 tcg_gen_extu(retv_orig, retv);
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
@@ -877,7 +821,7 @@ static void tcg_gen_nonatomic_cmpxchg_i128_int(TCGv_i128 retv, TCGTemp *addr,
     tcg_temp_free_i128(oldv);
 }
 
-void tcg_gen_nonatomic_cmpxchg_i128_chk(TCGv_i128 retv, TCGTemp *addr,
+void tcg_gen_nonatomic_cmpxchg_chk_i128(TCGv_i128 retv, TCGTemp *addr,
                                         TCGv_i128 cmpv, TCGv_i128 newv,
                                         TCGArg idx, MemOp memop,
                                         TCGType addr_type)
@@ -887,18 +831,23 @@ void tcg_gen_nonatomic_cmpxchg_i128_chk(TCGv_i128 retv, TCGTemp *addr,
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
@@ -918,14 +867,14 @@ static void tcg_gen_atomic_cmpxchg_i128_int(TCGv_i128 retv, TCGTemp *addr,
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
index c68e9e10501..c8c79356d55 100644
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


