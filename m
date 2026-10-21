Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06F606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RYHu5+qB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXJU-0001EN-FA; Wed, 21 Oct 2026 10:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGp-0006eS-5c
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:26 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGl-0002Zs-Cd
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:22 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso512174f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592778; x=1793197578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ypz06w1EORJFZkqvpnT5iPOQzdJAwHMVWz9pF2jqVL8=;
 b=RYHu5+qB1BZ0CNcWDOMKSYswfu3WiWcbE9szZfIINfbfQBgaSGrRNg/b18gjxP7WUC
 ow33duGlfBj4JDky6h9492Qt/iMkWX5PvmvDoqki1NROPs2xyQihCxxoR7nQ8qz+Yi5Z
 MSqMwAdJ3IFa02F+lx/QdtVGdGaaqItxV4p+0Pyo4FXsQbLczfGzgvpzxEF3ofsYyyZH
 kzXhZQDV5kVtcsXf0axLeci0oM8FkbQa9Xma9OP6CgOMxK5ukjjGI2gWWOEVnY9667Fc
 EpL+HNtoQeUawx+9gUcJGnZxf63wtIdDm/CMEmGmHVpc0mPgXwkFoBF2ceF73JJ5VWEQ
 FoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592778; x=1793197578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ypz06w1EORJFZkqvpnT5iPOQzdJAwHMVWz9pF2jqVL8=;
 b=ldbbGDwlnJVOOMp5M4JQogFKoGLETDIPwxeaxsT7Hc8gORpfJVltFal9K2BIGv3uxA
 Ot9neEtwVpWWGtn+Vwj01K4Ks/Bm6dOi4V7igLfMKlMAMNAaQdBMurE27hc95+QAPZtU
 oK1mmMlAUbqhOccKMxC9b1xhbPiHYqCUNetcWF8RAvHNGGJuvCsERWByl2REY//AobWm
 lL5qqaI0Er0jpZqFFDHPf0NsmcRhPpOARib5IBCRXCwbaqoq8XKbPy9T/HuDzHnoTuvr
 SbkYYdz3J/cxZVtTpMlIICb3zp6KQUB61itOMfnTyBK5KVeJJVH80yspKPU7mR+ZLu8L
 HjmA==
X-Gm-Message-State: AFq9FYInw11f3sn/Zalr5Jcmzk+88YSQh7EjsA8tyzQCiuZ28kbS7DbI
 ouw/5O+dUXTt0HtvzE+l75NE+xBd+pbXAgumlFKn6Fs/vU1dvXBZk88QL72c1maqNQU6xczkGlv
 P3Fp/npc=
X-Gm-Gg: AYBFou0lMyWzzKZwQlk/1WYN13E3KyIHUo6nP7wo0sDbZLdHuP8JDzWZAuFOneZK2H3
 o38czSrcgMFDJGOLwhWrFkpAjph2C6L9sahJWXQc50iFR2nfEKiiteEVGDyXJQkPDn2pFTePqx+
 PKQvQcCchCVH0aIaZHT1pJvSarYwQ5FrCw49V6N3aZfW31OYaMTQEYFsAABkkwswk9xpchViHWj
 20lucr0gf4wYcHN/XD0Gx9ifQ/txGR8mvqiNwTN/Huujjkevd1xOScc1t2MYGgjjChck7x4+xOx
 EoI8b4BWpLl39SUeRVGm0CM1+keDj3XAoWaatUv5ncq0bVYfutpRsJsop50m6lOLSxmE30kay4e
 E4BZsohQn3G6NEAj5C4Q+mJ0sIInJbwnXDr/gZ+YiNxbPvVo8wHMD2XZF4T6ihfZeRsvb2hXtJ7
 PZJv9Y7n4l4+X0YUO9ft9Xopz/wvmvHwkPbR57U+EpK8zOhdusAOsZsq0G67eXUKdyV/RL/JHRd
 tVzlWu9saqnatQnxAPe8WHZ93nmPeRrWG4eFrNPkiJ6MA1MEbO6xrjB7yoxRwKhOnX6BT6Ug4Yd
 49dkwPMUlhMR+6VoxW2pd9QL2wlS
X-Received: by 2002:a05:6000:178d:b0:48e:b8f:f7d9 with SMTP id
 ffacd0b85a97d-48e2644eba3mr5323709f8f.6.1792592777625; 
 Wed, 21 Oct 2026 07:26:17 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 096/100] tcg: Generic expansion of tcg_gen_qemu_ld_chk
Date: Wed, 21 Oct 2026 16:16:48 +0200
Message-ID: <20261021141652.363109-97-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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
 include/tcg/tcg-op-common.h  |   4 +-
 include/tcg/tcg-op-mem.h     |   6 +-
 include/tcg/tcg.h            |   2 +
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op-ldst.c            | 164 ++++++++++++++---------------------
 tcg/tcg-op.c                 |   4 +
 6 files changed, 75 insertions(+), 106 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 75194c1906..ce47bebb2b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -177,11 +177,9 @@ void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
 
 /* Local load/store bit ops */
 
-void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
+void tcg_gen_qemu_ld_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 void tcg_gen_qemu_st_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_ld_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType);
 void tcg_gen_qemu_st_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_ld_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 void tcg_gen_qemu_st_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 
 /* Atomic ops */
diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index 29e7c02f25..76955d27c1 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -31,7 +31,7 @@ typedef TCGv_i64 TCGv_va;
 QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 {
-    tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+    tcg_gen_qemu_ld_chk_i32(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 QEMU_ARG_NONNULL static inline void
@@ -43,7 +43,7 @@ tcg_gen_qemu_st_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 {
-    tcg_gen_qemu_ld_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+    tcg_gen_qemu_ld_chk_i64(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 QEMU_ARG_NONNULL static inline void
@@ -55,7 +55,7 @@ tcg_gen_qemu_st_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 {
-    tcg_gen_qemu_ld_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+    tcg_gen_qemu_ld_chk_i128(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 QEMU_ARG_NONNULL static inline void
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 09d20064fc..8f409b23b7 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -304,6 +304,8 @@ typedef struct TCGTemp {
     void *state_ptr;
 } TCGTemp;
 
+typedef TCGTemp *TCGTempPtr;
+
 typedef struct TCGContext TCGContext;
 
 typedef struct TCGTempSet {
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 556f7470cd..e2da3ddef6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -53,6 +53,7 @@ DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
+DEF5(qemu_ld_chk, TCGV, TCGTempPtr, unsigned, MemOp, TCGType)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF2(revbit8, TCGV, TCGV)
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 031c5ce926..7d3fe60d89 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -191,33 +191,37 @@ plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
 #endif
 
 static void
-plugin_gen_mem_callbacks_i32(TCGv_i32 val,
+plugin_gen_mem_callbacks_tmp(TCGType type, TCGTemp *val,
                              TCGv_i64 copy_addr, TCGTemp *orig_addr,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
 #ifdef CONFIG_PLUGIN
     if (tcg_ctx->plugin_insn != NULL) {
-        tcg_gen_st_i32(val, tcg_env,
-                       offsetof(CPUState, neg.plugin_mem_value_low) -
-                       sizeof(CPUState) + (HOST_BIG_ENDIAN * 4));
+        tcg_gen_st(type, val, tcgv_ptr_temp(tcg_env),
+                   offsetof(CPUState, neg.plugin_mem_value_low)
+                   - sizeof(CPUState)
+                   + (HOST_BIG_ENDIAN && type == TCG_TYPE_I32 ? 4 : 0));
         plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
     }
 #endif
 }
 
+static void
+plugin_gen_mem_callbacks_i32(TCGv_i32 val,
+                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
+{
+    plugin_gen_mem_callbacks_tmp(TCG_TYPE_I32, tcgv_i32_temp(val), copy_addr,
+                                 orig_addr, oi, rw);
+}
+
 static void
 plugin_gen_mem_callbacks_i64(TCGv_i64 val,
                              TCGv_i64 copy_addr, TCGTemp *orig_addr,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
-#ifdef CONFIG_PLUGIN
-    if (tcg_ctx->plugin_insn != NULL) {
-        tcg_gen_st_i64(val, tcg_env,
-                       offsetof(CPUState, neg.plugin_mem_value_low) -
-                       sizeof(CPUState));
-        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
-    }
-#endif
+    plugin_gen_mem_callbacks_tmp(TCG_TYPE_I64, tcgv_i64_temp(val), copy_addr,
+                                 orig_addr, oi, rw);
 }
 
 static void
@@ -238,8 +242,31 @@ plugin_gen_mem_callbacks_i128(TCGv_i128 val,
 #endif
 }
 
-static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
-                                    TCGArg idx, MemOp memop)
+static void tcg_gen_bswap(TCGType type, TCGTemp *dst,
+                          TCGTemp *src, unsigned flags, MemOp memop)
+{
+    switch (memop & MO_SIZE) {
+    case MO_16:
+        tcg_gen_bswap16(type, dst, src, flags);
+        break;
+    case MO_32:
+        if (type == TCG_TYPE_I32) {
+            tcg_gen_bswap32_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+        } else {
+            tcg_gen_bswap32_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src), flags);
+        }
+        break;
+    case MO_64:
+        tcg_debug_assert(type == TCG_TYPE_I64);
+        tcg_gen_bswap64_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_gen_qemu_ld_int(TCGType type, TCGTemp *val,
+                                TCGTemp *addr, TCGArg idx, MemOp memop)
 {
     MemOp orig_memop;
     MemOpIdx orig_oi, oi;
@@ -247,48 +274,40 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
     TCGTemp *addr_new;
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    orig_memop = memop = tcg_canonicalize_memop(memop, 0, 0);
+    memop = tcg_canonicalize_memop(memop, type != TCG_TYPE_I32, 0);
+    orig_memop = memop;
     orig_oi = oi = make_memop_idx(memop, idx);
 
     if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-        memop &= ~MO_BSWAP;
         /* The bswap primitive benefits from zero-extended input.  */
-        if ((memop & MO_SSIZE) == MO_SW) {
-            memop &= ~MO_SIGN;
-        }
+        memop &= ~(MO_BSWAP | MO_SIGN);
         oi = make_memop_idx(memop, idx);
     }
 
     addr_new = tci_extend_addr(addr);
     copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
+    tcg_gen_op_tti(INDEX_op_qemu_ld, type, val, addr_new, oi);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
-        switch (orig_memop & MO_SIZE) {
-        case MO_16:
-            tcg_gen_bswap16_i32(val, val, (orig_memop & MO_SIGN
-                                           ? TCG_BSWAP_IZ | TCG_BSWAP_OS
-                                           : TCG_BSWAP_IZ | TCG_BSWAP_OZ));
-            break;
-        case MO_32:
-            tcg_gen_bswap32_i32(val, val);
-            break;
-        default:
-            g_assert_not_reached();
-        }
+        int flags = (orig_memop & MO_SIGN
+                     ? TCG_BSWAP_IZ | TCG_BSWAP_OS
+                     : TCG_BSWAP_IZ | TCG_BSWAP_OZ);
+        tcg_gen_bswap(type, val, val, flags, orig_memop);
     }
 
-    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks_tmp(type, val, copy_addr, addr,
+                                 orig_oi, QEMU_PLUGIN_MEM_R);
     maybe_free_addr(addr, addr_new);
 }
 
-void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
-                             MemOp memop, TCGType addr_type)
+void tcg_gen_qemu_ld_chk(TCGType val_type, TCGTemp *val, TCGTemp *addr,
+                         unsigned idx, MemOp memop, TCGType addr_type)
 {
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);
-    tcg_debug_assert((memop & MO_SIZE) <= MO_32);
-    tcg_gen_qemu_ld_i32_int(val, addr, idx, memop);
+    tcg_debug_assert(memop_size(memop) <= tcg_type_size(val_type));
+    tcg_debug_assert(idx < NB_MMU_MODES);
+
+    tcg_gen_qemu_ld_int(val_type, val, addr, idx, memop);
 }
 
 static void tcg_gen_qemu_st_i32_int(TCGv_i32 orig_val, TCGTemp *addr,
@@ -337,63 +356,6 @@ void tcg_gen_qemu_st_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
     tcg_gen_qemu_st_i32_int(val, addr, idx, memop);
 }
 
-static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
-                                    TCGArg idx, MemOp memop)
-{
-    MemOp orig_memop;
-    MemOpIdx orig_oi, oi;
-    TCGv_i64 copy_addr;
-    TCGTemp *addr_new;
-
-    tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    orig_memop = memop = tcg_canonicalize_memop(memop, 1, 0);
-    orig_oi = oi = make_memop_idx(memop, idx);
-
-    if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-        memop &= ~MO_BSWAP;
-        /* The bswap primitive benefits from zero-extended input.  */
-        if ((memop & MO_SIGN) && (memop & MO_SIZE) < MO_64) {
-            memop &= ~MO_SIGN;
-        }
-        oi = make_memop_idx(memop, idx);
-    }
-
-    addr_new = tci_extend_addr(addr);
-    copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ld_i64(val, addr_new, oi);
-
-    if ((orig_memop ^ memop) & MO_BSWAP) {
-        int flags = (orig_memop & MO_SIGN
-                     ? TCG_BSWAP_IZ | TCG_BSWAP_OS
-                     : TCG_BSWAP_IZ | TCG_BSWAP_OZ);
-        switch (orig_memop & MO_SIZE) {
-        case MO_16:
-            tcg_gen_bswap16_i64(val, val, flags);
-            break;
-        case MO_32:
-            tcg_gen_bswap32_i64(val, val, flags);
-            break;
-        case MO_64:
-            tcg_gen_bswap64_i64(val, val);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    }
-
-    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_R);
-    maybe_free_addr(addr, addr_new);
-}
-
-void tcg_gen_qemu_ld_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
-                             MemOp memop, TCGType addr_type)
-{
-    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
-    tcg_debug_assert((memop & MO_SIZE) <= MO_64);
-    tcg_gen_qemu_ld_i64_int(val, addr, idx, memop);
-}
-
 static void tcg_gen_qemu_st_i64_int(TCGv_i64 orig_val, TCGTemp *addr,
                                     TCGArg idx, MemOp memop)
 {
@@ -638,7 +600,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
                                   QEMU_PLUGIN_MEM_R);
 }
 
-void tcg_gen_qemu_ld_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
+void tcg_gen_qemu_ld_chk_i128(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
                               MemOp memop, TCGType addr_type)
 {
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);
@@ -800,7 +762,8 @@ static void tcg_gen_nonatomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
 
     tcg_gen_ext_i32(t2, cmpv, memop & MO_SIZE);
 
-    tcg_gen_qemu_ld_i32_int(t1, addr, idx, memop & ~MO_SIGN);
+    tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1),
+                        addr, idx, memop & ~MO_SIGN);
     tcg_gen_movcond_i32(TCG_COND_EQ, t2, t1, t2, newv, t1);
     tcg_gen_qemu_st_i32_int(t2, addr, idx, memop);
     tcg_temp_free_i32(t2);
@@ -871,7 +834,8 @@ static void tcg_gen_nonatomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
 
     tcg_gen_ext_i64(t2, cmpv, memop & MO_SIZE);
 
-    tcg_gen_qemu_ld_i64_int(t1, addr, idx, memop & ~MO_SIGN);
+    tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1),
+                        addr, idx, memop & ~MO_SIGN);
     tcg_gen_movcond_i64(TCG_COND_EQ, t2, t1, t2, newv, t1);
     tcg_gen_qemu_st_i64_int(t2, addr, idx, memop);
     tcg_temp_free_i64(t2);
@@ -1047,7 +1011,7 @@ static void do_nonatomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
 
     memop = tcg_canonicalize_memop(memop, 0, 0);
 
-    tcg_gen_qemu_ld_i32_int(t1, addr, idx, memop);
+    tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1), addr, idx, memop);
     tcg_gen_ext_i32(t2, val, memop);
     gen(t2, t1, t2);
     tcg_gen_qemu_st_i32_int(t2, addr, idx, memop);
@@ -1088,7 +1052,7 @@ static void do_nonatomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
 
     memop = tcg_canonicalize_memop(memop, 1, 0);
 
-    tcg_gen_qemu_ld_i64_int(t1, addr, idx, memop);
+    tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1), addr, idx, memop);
     tcg_gen_ext_i64(t2, val, memop);
     gen(t2, t1, t2);
     tcg_gen_qemu_st_i64_int(t2, addr, idx, memop);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index df769dd975..679cf87995 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -239,6 +239,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define C_MemOp
 #define C_TCGCond
 #define C_TCGLabelPtr
+#define C_TCGTempPtr
+#define C_TCGType
 #define C_tcg_target_long
 #define C_unsigned
 
@@ -272,6 +274,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_MemOp
 #undef C_TCGCond
 #undef C_TCGLabelPtr
+#undef C_TCGTempPtr
+#undef C_TCGType
 #undef C_tcg_target_long
 #undef C_unsigned
 
-- 
2.53.0


