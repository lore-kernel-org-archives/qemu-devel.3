Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC20606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aerfUQNL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsf8-0003su-4B; Sun, 25 Oct 2026 03:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsdC-00004w-4w
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:27:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd9-0004ce-L3
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:27:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so1826875e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913218; x=1793518018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AfWt6u1TNDgobQWDBpZNiDzdmIp5zwVhUELrzFJYCdQ=;
 b=aerfUQNLgNNP3U1EDZw65EC4TdRQVn3qG3cmPc1aWwO6Hdh9ID/1+9YlE5Z4k0AWHF
 UFxtg2zrOIbIpp4/UUUWiZiv0qms7mAMjVlASNztQT+BWbxbCGrwvHl/SXCg/qos/sqI
 Q3kKwlDVQO7YQhdyxAR+fOTmlsKwMnzQi+B64DFBbCRpwrVJG0DZSLBK0ngYqFrT17YY
 KtMIjCkn2CRL/T3Er0zKwjxwnAzjhx1Vm/wUhdk6FTEzWZG3tBYcNpmI2a80t40UTbOD
 6nGZE0C1Xa4D84GdQVUy39I4VhlYxyNhW2t+r/vPyWs23UV7Tbcr8Ag9JMVBpssxmEJM
 8WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913218; x=1793518018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AfWt6u1TNDgobQWDBpZNiDzdmIp5zwVhUELrzFJYCdQ=;
 b=iaccV8cv9vrkNmt46KaUK+mlktq+laCowlJCalF2rvkBvG4HdTeUvPN3VrLcMoYoKw
 IAwqHyGVTFMssDZ3C8RSL/zDo8sxIJiVzilnJUmORmy7K7OJnE7rnNSAKTsjr9Gyb9it
 2MGo36wfZ8FOexxfj7Idkia3a5v8eF2/1GXqOwa6S/24KoVOSpIq2enHLpRhCK34V2bk
 YWqj766OiZhM27YR8fdMjyssA8wnxi0udzs46eWY6KdfuTScHL//5Wi/XLFQ1CnS2d+f
 YpS6J/4MEkuC5a79TrjjxY/u+w7wh3GglzCLxfvc9Eq/GrcHGE4bIdLc6cZEWGECcrex
 jlpQ==
X-Gm-Message-State: AFq9FYIUdUFqlMCmsJv4H7HYv3+RvHGD5f0Qp4eQFH9uoafzZ2MEFKPq
 P2Xb5gmyb3k/C9aP7e8Tmgffg9EasEflhwHlEA38WLGU4C4FBmXjQPrcpFWW3EhHHddZxmoFj+6
 1JeDHyBo=
X-Gm-Gg: AYBFou2PQALOQrYD6I9PZcXjCAkv+dFUXIcZ4/MbLt42kS4hUYDNty4sGRmt5J796tl
 r0/f19tg8UGPmI/U6rMngIz25C6o4FTvcAZGpr/D7NdybX3uhr0BztK2f28QwNZn1JlXJEJz8+Z
 U2+02K21XYKwt5deJHaaU1mu54zbVWIlAbVgESKQ32I8vRwokBa1R/KL9zXgSrtkoU92ZEwpZFD
 I2oGUjMJoXbMTq5gY48mzs0Gyj+t2hgrHwK00cXToWkx1ODOseQjd2aGNoZMstUarNG+Q21tsH8
 JIuIGYu/1XDF2tEchDCEyMzfMdLfQ2awg6t3ZtWauxmYYWMzvoJ5csnTpX3aXsKMOu5qcMijn1N
 dthFQdwAgz5O7CcsAPypjlNc5TbtU4MD+B7Qu4yR+8EAR+ULLIgbSi1MBRYgiUPb57FlaTUly/S
 a6YMIn3UzNHIoQLxyqgZseEJCWWeduSpbSkG2AwiL+iBdsiLyji1eHDCVtb3rHDqSM5kMo/u8Un
 3d0zvHPJ167GVQ90kZ8Kgm+Dv42I/oMfKfYsQDIff0qSLMUkT3tf6aAubQPyqt+/sfXz0RSGkkl
 AZHd
X-Received: by 2002:a05:600c:4e4d:b0:4a2:526b:d40f with SMTP id
 5b1f17b1804b1-4a35ac9f1f9mr60598855e9.0.1792913218211; 
 Sun, 25 Oct 2026 00:26:58 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 096/100] tcg: Generic expansion of tcg_gen_qemu_ld_chk
Date: Sun, 25 Oct 2026 08:19:11 +0100
Message-ID: <20261025071915.1123867-97-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
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
index 031c5ce926..e67beb7586 100644
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
+        unsigned flags = (orig_memop & MO_SIGN
+                          ? TCG_BSWAP_IZ | TCG_BSWAP_OS
+                          : TCG_BSWAP_IZ | TCG_BSWAP_OZ);
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
index cb40ed7ca8..379c3e4d65 100644
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


