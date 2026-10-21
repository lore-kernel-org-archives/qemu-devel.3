Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039A606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gLCFy7OL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXI7-0007e0-Sh; Wed, 21 Oct 2026 10:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGq-0006ew-Sy
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:28 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGo-0002a7-IT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e011d370dso636899f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592779; x=1793197579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2G/gOammIWZjVjY+ETHCWEZ7fcjmZCLkHg7K1uPHkgo=;
 b=gLCFy7OLRUMvqmWKbAaGswCne/L+R19Yjk/y7oSnIx8Cs/0L0Z44WrWYV7EkmsEE60
 FYXA3+q7wGvczjhfYB0BzEYsvPr97HjpmqGXVNBE2XQL7D5G697Da5N5bWkWfH2ygy9l
 kieg9eY5YgYaa73jl1StO3xE6rtPcHE1plgQC0pDPS/uVkJGDCsBgF8ax/8XifLroLf2
 j8gUz/fVnU0ZrV+swO11KTvy3AYo6EarzYcfRl+8uNqNbNvI04SZMTwRz5962Asf5pxE
 iff15DXolIYHpFxw9E9Qv640ttijKKbwrXNz2EP9NQpb0MbipAHGPqr1P1pnr0Al4Xfe
 HwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592779; x=1793197579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2G/gOammIWZjVjY+ETHCWEZ7fcjmZCLkHg7K1uPHkgo=;
 b=1KOdzRbgBD7gpSz42t6/ovNFfMH+q3uPQ36qJWPfou/7W4Q1oANOgd4mSDHhHDuOxX
 iPZw2TFhnhsl2w5E/nTwPKHv1iT4G6olkDOO/x71FCUHnn1BvEDPdwV5PVOk85xtmqUn
 bzkKmoOokBne8Zvx2GIjQA7mgJVrL9W6ooiTqbrT1Vbd0+ZLq3kegrFav6CAWixgUX8n
 2GKkuB2rS9gVq3Unz8GnuuNH2LKVlt9dsaD0SfxTHpwXG72pQCBc2kiJyBxfw5Ow+EwS
 QLqQQ+jZHONvorqHBwAVumHpYPa2RGuQj+lLDXxcVthK3SU3sYWFaQH/wOdotxNnXhwZ
 FzMw==
X-Gm-Message-State: AFq9FYLNUiNVCCH4sxB0KITsf3Zn8GMttEp2NI2JAloNDX05KxHNBUxK
 dhnUgvq5hzSKFlAwexeuPZOdvCUQO0cS2EsrOit9HGPXwhbmOG9cN8ValKFFTaD6CZz3R74uz4r
 0/KHcro8=
X-Gm-Gg: AYBFou36lQ9XWXAHEPtxHGP5PL+QPeygSJyAAz+zaDuxdgXlkVmnANggIiw986igXk4
 /DdWUYsONsm8IugCL3+jmF5KPk6zwyUeEe74lczu9guZf+Vq8lpwrULRT3gALW4t7s6PzD+Kl9X
 lXsjZ66C2uP5kYAK2gUkq4kfUKJlnBfBfFWPj87hxLS8Rp8EJIP9qpZW3cB4reO3xCyoVjEApGn
 95pIZhnz8XO5O6PtZI19+5yhwWBAQp+2VSljZPiijzrlH8AKp+5ZMgJyn1VPQJPADGomhWe5rPt
 ojfIQLrLuY/UvvLHYp34S4jhIwscSuCOp+KAwir2PqNdHRJQk/GrIpKmnpp3S3JDeZoBB1TkYmC
 7dYMHqIvw6zH0vu+cPr0ijwkH+0IrZ/Jabx70wwZM0oTpzYoebkzs/NfS1ilNBUfwDdrN1hHxeW
 Y0gHxD47AaP01OfENLVCKcqQFWkHF5xMvjXe2M0Bq3AwxTBT0l9y3TCsuEjXh1Wo4EDhEp2r8DP
 /GUzvb7pN+dC0jwKLD5Hex8Mc9K/0pbkpJp5Gasutv7mbNjnN4XY0pR0c1JcAjwLNYqmMLA6s/6
 vPvVfNcmaOjd40D/rs+3ef5f75tr/Kj64S/lwxfXVMe23bsP
X-Received: by 2002:a05:6000:26c5:b0:48c:8126:a260 with SMTP id
 ffacd0b85a97d-48e26427bd6mr5207722f8f.6.1792592778609; 
 Wed, 21 Oct 2026 07:26:18 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 097/100] tcg: Generic expansion of tcg_gen_qemu_st_chk
Date: Wed, 21 Oct 2026 16:16:49 +0200
Message-ID: <20261021141652.363109-98-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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
 include/tcg/tcg-op-common.h  |   6 +-
 include/tcg/tcg-op-mem.h     |   6 +-
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op-ldst.c            | 114 ++++++-----------------------------
 4 files changed, 25 insertions(+), 102 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ce47bebb2b..711eb96a86 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -175,12 +175,8 @@ void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
 void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
 void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
 
-/* Local load/store bit ops */
-
 void tcg_gen_qemu_ld_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_st_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_st_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_st_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
+void tcg_gen_qemu_st_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 
 /* Atomic ops */
 
diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index 76955d27c1..e8425e1059 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -37,7 +37,7 @@ tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 {
-    tcg_gen_qemu_st_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+    tcg_gen_qemu_st_chk_i32(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 QEMU_ARG_NONNULL static inline void
@@ -49,7 +49,7 @@ tcg_gen_qemu_ld_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 {
-    tcg_gen_qemu_st_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+    tcg_gen_qemu_st_chk_i64(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 QEMU_ARG_NONNULL static inline void
@@ -61,7 +61,7 @@ tcg_gen_qemu_ld_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 {
-    tcg_gen_qemu_st_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+    tcg_gen_qemu_st_chk_i128(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 #define DEF_ATOMIC2(N, S)                                               \
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e2da3ddef6..552f62b7f4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -54,6 +54,7 @@ DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
 DEF5(qemu_ld_chk, TCGV, TCGTempPtr, unsigned, MemOp, TCGType)
+DEF5(qemu_st_chk, TCGV, TCGTempPtr, unsigned, MemOp, TCGType)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF2(revbit8, TCGV, TCGV)
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 7d3fe60d89..d9133e611e 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -206,24 +206,6 @@ plugin_gen_mem_callbacks_tmp(TCGType type, TCGTemp *val,
 #endif
 }
 
-static void
-plugin_gen_mem_callbacks_i32(TCGv_i32 val,
-                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
-                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
-{
-    plugin_gen_mem_callbacks_tmp(TCG_TYPE_I32, tcgv_i32_temp(val), copy_addr,
-                                 orig_addr, oi, rw);
-}
-
-static void
-plugin_gen_mem_callbacks_i64(TCGv_i64 val,
-                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
-                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
-{
-    plugin_gen_mem_callbacks_tmp(TCG_TYPE_I64, tcgv_i64_temp(val), copy_addr,
-                                 orig_addr, oi, rw);
-}
-
 static void
 plugin_gen_mem_callbacks_i128(TCGv_i128 val,
                              TCGv_i64 copy_addr, TCGTemp *orig_addr,
@@ -310,99 +292,43 @@ void tcg_gen_qemu_ld_chk(TCGType val_type, TCGTemp *val, TCGTemp *addr,
     tcg_gen_qemu_ld_int(val_type, val, addr, idx, memop);
 }
 
-static void tcg_gen_qemu_st_i32_int(TCGv_i32 orig_val, TCGTemp *addr,
-                                    TCGArg idx, MemOp memop)
+static void tcg_gen_qemu_st_int(TCGType type, TCGTemp *orig_val,
+                                TCGTemp *addr, unsigned idx, MemOp memop)
 {
-    TCGv_i32 val = orig_val;
+    TCGTemp *val = orig_val;
     MemOpIdx orig_oi, oi;
     TCGTemp *addr_new;
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    memop = tcg_canonicalize_memop(memop, 0, 1);
+    memop = tcg_canonicalize_memop(memop, type != TCG_TYPE_I32, 1);
     orig_oi = oi = make_memop_idx(memop, idx);
 
     if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-        val = tcg_temp_ebb_new_i32();
-        switch (memop & MO_SIZE) {
-        case MO_16:
-            tcg_gen_bswap16_i32(val, orig_val, 0);
-            break;
-        case MO_32:
-            tcg_gen_bswap32_i32(val, orig_val);
-            break;
-        default:
-            g_assert_not_reached();
-        }
+        val = tcg_temp_new_ebb(type);
+        tcg_gen_bswap(type, val, orig_val, 0, memop);
         memop &= ~MO_BSWAP;
         oi = make_memop_idx(memop, idx);
     }
 
     addr_new = tci_extend_addr(addr);
-    gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
-    plugin_gen_mem_callbacks_i32(orig_val, NULL, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_W);
+    tcg_gen_op_tti(INDEX_op_qemu_st, type, val, addr_new, oi);
+    plugin_gen_mem_callbacks_tmp(type, orig_val, NULL, addr,
+                                 orig_oi, QEMU_PLUGIN_MEM_W);
     maybe_free_addr(addr, addr_new);
 
     if (val != orig_val) {
-        tcg_temp_free_i32(val);
+        tcg_temp_free_internal(val);
     }
 }
 
-void tcg_gen_qemu_st_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
-                             MemOp memop, TCGType addr_type)
+void tcg_gen_qemu_st_chk(TCGType val_type, TCGTemp *val, TCGTemp *addr,
+                         unsigned idx, MemOp memop, TCGType addr_type)
 {
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);
-    tcg_debug_assert((memop & MO_SIZE) <= MO_32);
-    tcg_gen_qemu_st_i32_int(val, addr, idx, memop);
-}
+    tcg_debug_assert(memop_size(memop) <= tcg_type_size(val_type));
+    tcg_debug_assert(idx < NB_MMU_MODES);
 
-static void tcg_gen_qemu_st_i64_int(TCGv_i64 orig_val, TCGTemp *addr,
-                                    TCGArg idx, MemOp memop)
-{
-    TCGv_i64 val = orig_val;
-    MemOpIdx orig_oi, oi;
-    TCGTemp *addr_new;
-
-    tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    memop = tcg_canonicalize_memop(memop, 1, 1);
-    orig_oi = oi = make_memop_idx(memop, idx);
-
-    if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-        val = tcg_temp_ebb_new_i64();
-        switch (memop & MO_SIZE) {
-        case MO_16:
-            tcg_gen_bswap16_i64(val, orig_val, 0);
-            break;
-        case MO_32:
-            tcg_gen_bswap32_i64(val, orig_val, 0);
-            break;
-        case MO_64:
-            tcg_gen_bswap64_i64(val, orig_val);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        memop &= ~MO_BSWAP;
-        oi = make_memop_idx(memop, idx);
-    }
-
-    addr_new = tci_extend_addr(addr);
-    gen_st_i64(val, addr_new, oi);
-    plugin_gen_mem_callbacks_i64(orig_val, NULL, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_W);
-    maybe_free_addr(addr, addr_new);
-
-    if (val != orig_val) {
-        tcg_temp_free_i64(val);
-    }
-}
-
-void tcg_gen_qemu_st_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
-                             MemOp memop, TCGType addr_type)
-{
-    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
-    tcg_debug_assert((memop & MO_SIZE) <= MO_64);
-    tcg_gen_qemu_st_i64_int(val, addr, idx, memop);
+    tcg_gen_qemu_st_int(val_type, val, addr, idx, memop);
 }
 
 /*
@@ -713,7 +639,7 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
                                   QEMU_PLUGIN_MEM_W);
 }
 
-void tcg_gen_qemu_st_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
+void tcg_gen_qemu_st_chk_i128(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
                               MemOp memop, TCGType addr_type)
 {
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);
@@ -765,7 +691,7 @@ static void tcg_gen_nonatomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
     tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1),
                         addr, idx, memop & ~MO_SIGN);
     tcg_gen_movcond_i32(TCG_COND_EQ, t2, t1, t2, newv, t1);
-    tcg_gen_qemu_st_i32_int(t2, addr, idx, memop);
+    tcg_gen_qemu_st_int(TCG_TYPE_I32, tcgv_i32_temp(t2), addr, idx, memop);
     tcg_temp_free_i32(t2);
 
     if (memop & MO_SIGN) {
@@ -837,7 +763,7 @@ static void tcg_gen_nonatomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
     tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1),
                         addr, idx, memop & ~MO_SIGN);
     tcg_gen_movcond_i64(TCG_COND_EQ, t2, t1, t2, newv, t1);
-    tcg_gen_qemu_st_i64_int(t2, addr, idx, memop);
+    tcg_gen_qemu_st_int(TCG_TYPE_I64, tcgv_i64_temp(t2), addr, idx, memop);
     tcg_temp_free_i64(t2);
 
     if (memop & MO_SIGN) {
@@ -1014,7 +940,7 @@ static void do_nonatomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
     tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1), addr, idx, memop);
     tcg_gen_ext_i32(t2, val, memop);
     gen(t2, t1, t2);
-    tcg_gen_qemu_st_i32_int(t2, addr, idx, memop);
+    tcg_gen_qemu_st_int(TCG_TYPE_I32, tcgv_i32_temp(t2), addr, idx, memop);
 
     tcg_gen_ext_i32(ret, (new_val ? t2 : t1), memop);
     tcg_temp_free_i32(t1);
@@ -1055,7 +981,7 @@ static void do_nonatomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
     tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1), addr, idx, memop);
     tcg_gen_ext_i64(t2, val, memop);
     gen(t2, t1, t2);
-    tcg_gen_qemu_st_i64_int(t2, addr, idx, memop);
+    tcg_gen_qemu_st_int(TCG_TYPE_I64, tcgv_i64_temp(t2), addr, idx, memop);
 
     tcg_gen_ext_i64(ret, (new_val ? t2 : t1), memop);
     tcg_temp_free_i64(t1);
-- 
2.53.0


