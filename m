Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADB9C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkse-0000dJ-6F; Sun, 27 Sep 2026 05:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkre-0002tc-TS
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:07 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrc-0008J5-GR
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:06 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0df0bb2d6so608615a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500083; x=1791104883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dBIjDYY79CgoKWUaAAEhezmCwtYmRAV3YKyHd1W8VXA=;
 b=lLQ7ik/8/4icuz7k4LMePbJ2U/e1AZzClFS2pUbiD046XVFkkZkpPn7taQex2zrEAd
 uGhdFjTtkDStvE+85JL7ZIjyQVdyUgYW+6wG3mNiN1hu5I3oG1NsradRwZlSwQcInNFL
 4vrIliHeZBf+OYc/x4VgvVtO3t19MAZC204sdSIlWpse2BcjdYaf0tq9O3/7q/oIpyiB
 0isvG52mdFo3aPjiJiuwKhsVSEP5AydduBPWqFxAn0UpkeWNrqR0nYgSVHdeibHsAxIJ
 rs5TcvDoBvNJIcXXsx/8ob11p8gaa2WkjnPvSvMozImtbN3r6teIMFhPwSK6/VgIJ4vZ
 y9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500083; x=1791104883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dBIjDYY79CgoKWUaAAEhezmCwtYmRAV3YKyHd1W8VXA=;
 b=qJSxY+smIiwJEwnLb5RzIIN3CP8k8TP6ij3msneh3tMpnscBsEkj10NBgeCC2gibAU
 xA8QwvXOJmWjjR9o6OJ8sYHAoLViUSHr7nTlahz7glwWa0fWBOmIOFYD48FFnhSdhecM
 KK44hcP+f0svYc0JZlcc4pnqEnr/L79fqoEawjVTJxJHMZ/4UmelM7htfoJjK7e+xjeU
 kDBFByxLl94jo95EimVJmhzo718Ppy5SgjoD1MS6mYzDqjlZYwN6cHvtDOgzcWJKPqAP
 9oMu3847mz7FGFQ+cmBkREa8elDe8xVMfV97EsMLgRb1eAgeVo4fcBFrEohJ728GZEUE
 IE+A==
X-Gm-Message-State: AFq9FYLArur0ZIz1LLz6CNG769wu2ns9dSt5NC92P640MLBCf+oKell+
 Lsbn7MxY+vuyXN0+sOmCNty2U8H0m+ZWQVR0rjYWmqJSsepJdf2gUB/ur4/Lckxp2tUgZR3XHh5
 hFskx
X-Gm-Gg: AYBFou3+HT0p41B7ZEyuHS65AQp51ZqDNDfK730OMUzNTsz2Pdk0lRRTBz+VqcvvgnD
 RFJHFBjuFsjTy+DlX+94huIJfuGlpAMpTawiaBTPZk/01xQTDudVrI5Iwh1EGGi9cFiS4bFx7FY
 qOl37J/sq5oUIcvynBfrPXnTgkRgbBg8t/PIqG/HalLHTarrF+UhxgUFuXe/thsCiy8HiyKoap8
 xuMgsu+duw5kNE1Lts7i+Ts9hj9B6DSpV7cSSJj5f2YTOsvXAnza+mCWE9ohZ4dcPCyyyzziYIQ
 xIeYqmkG0RQZr6as53H0QZ5MJr0+Yn8dt+cClOGpmSlsggoD2U6WAlkXHJFOUv8wyq2Lx7x1+sB
 ZSdL6ci+oXgDdnSl4QE9YtwFUw1js0y0NZFOskr/8mob8YcV6dn+GH5h8PPzFduHSIrlgk20ugv
 8/NTjKSWGeXWGizcL+7j8RMWXfLb1BGTJgrFZNtBzseIDHHN6cYX6VaKNH2QgXxcmTAhIhFRO7N
 0mGl1fv1ZNfXfyWdqXsp0NE41FxDPc=
X-Received: by 2002:a17:90b:2e8c:b0:3a2:b09e:784d with SMTP id
 98e67ed59e1d1-3a2b09e7a74mr417000a91.45.1790500082660; 
 Sun, 27 Sep 2026 02:08:02 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:08:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 098/101] tcg: Generic expansion of tcg_gen_qemu_st_chk
Date: Sun, 27 Sep 2026 02:00:08 -0700
Message-ID: <20260927090011.10724-99-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
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
 include/tcg/tcg-op-common.h  |   6 +-
 include/tcg/tcg-op-mem.h     |   6 +-
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op-ldst.c            | 114 ++++++-----------------------------
 4 files changed, 25 insertions(+), 102 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index fcbaae3def5..4fec1500d56 100644
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
index 76955d27c1f..e8425e10598 100644
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
index e2da3ddef66..552f62b7f4f 100644
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
index c48b8c0e3d1..7345bdfcc2b 100644
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


