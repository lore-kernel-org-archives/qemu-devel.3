Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8F2D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgacW-0002Jn-CN; Thu, 15 Jan 2026 22:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacU-00028r-9n
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:30 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacS-0006Ji-63
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:30 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso1387940b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534527; x=1769139327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecDzOzqQ/C38Xzf0BO7uae6DhF/wcxQYsp2ETvYgWSM=;
 b=pT0plUXBfORFAPueD2OrPSQV+phps/aQSOtJTC2O6d0/F187PDFcO4tklEyEVmf1JS
 wRtaWfyHC1AsHQvYo878GI0ulma7n0cBKUb1XWi0bLwgM3J8APQXD/KjykcxDGw0K6rb
 RoAoxzUdf8m819R8v9dTukB/JZcgeJKVXft5W+aOIQwXyTnXGxqSyuErJfwRrTrH2hHq
 xWBPk7XG17tsBg8XXV/lAlnwqUBOPn2VMkPs3hua7bzQ9fnTCfa38rutZKiSBe2fVBZs
 NesRc6H9uNiS11oqBtQxvO+rzML3S5HghGvDN6qmx0hvnPLymjenPeMBwpj8Y1NTPYWw
 uxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534527; x=1769139327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ecDzOzqQ/C38Xzf0BO7uae6DhF/wcxQYsp2ETvYgWSM=;
 b=SlI3AooK+SBArCTklPj1XnimrL8t+BKC5GQe8KSNCG+JdGIGaB8cDcFJ42z+6QLrEl
 kYoJfLkQHVRPThdTUTaD5DlQecjeAuLI02e3wRwKY5TKn/yvtwmz7v5oeyHfxxDwpXhK
 XlmUtHKEK2M5CIpQiQeRzOpf9GDoADfMLPgeQKMoDAnCUYr9H8+yLY203evHnZ3zJvx6
 V+4CMTRaLBTX2XUFWSEMRyduN4rOH+gP8CX8mE74iGY5dh6th4GwEra8YPvTW/OS17dq
 X4cD/VZiwsIrvSWpPg+aBCFI2A+mqxv6a4Ji8sk+/Mhvrw7UCJMVEjtAlKMWhBhR8FNs
 zgSQ==
X-Gm-Message-State: AOJu0Yw/Qk9V62XkfxwMRB7b8g/prj90tESx3/oTRZHyOVC1bNl2wgkO
 0QhXKhq6stQnWZTwRVZ3d6P+r905F/fRXTPUJ3J/LH1S1sQXxQcsYGHXHicXmTj1343dV/bZN3r
 jepnY/3WOQg==
X-Gm-Gg: AY/fxX78oeq94KvL9i4UXNWPsZ/6grTrrnB0S5f6uMUsLLIbr9HEftB0jNZvsfothVw
 n9BrfAMkmug+FMAIsWLwJflhR96tYV/U3PTcb8FvvSX3lElst0h+Sk/d7DYIqcuvZNqR/F1Qppo
 kLc8VLPW4GQEgHJhBo02bnxrZpKERtD82LxVZzOjcEhBxjjKn+fdMpM/4CUWo+Baxme79Xy8avZ
 /fIm7bEiw++sBWXjemvNHNaXQ48l9sF3RH2RaWpmpIlMmkf+wO9tfzh1ccObB662CqqxIQQ4Efk
 53VAVyPQpU96rhktW/oXcs6ZT620XG/7L21jKStqFxeCVJSdeXCNPslHG2vJ6fUklVQn/8siLtl
 5UfOoZdxlih4pgj/dlj5ZQK9rpPXrnRLVuEIzB5fll9iACAKa8f+zrTOPob9V6e2+u1scadCCnw
 4Rdm0QegPNSLY7a/76kA==
X-Received: by 2002:a05:6a00:2883:b0:81f:5fea:c556 with SMTP id
 d2e1a72fcca58-81f9f7faaa6mr1801746b3a.6.1768534526735; 
 Thu, 15 Jan 2026 19:35:26 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:35:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 34/58] tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op-ldst.c
Date: Fri, 16 Jan 2026 14:32:40 +1100
Message-ID: <20260116033305.51162-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-ldst.c | 113 +++++++++++-----------------------------------
 1 file changed, 27 insertions(+), 86 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 7716c3ad7c..55bfbf3a20 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -106,24 +106,12 @@ static void gen_ldst2(TCGOpcode opc, TCGType type, TCGTemp *vl, TCGTemp *vh,
 
 static void gen_ld_i64(TCGv_i64 v, TCGTemp *addr, MemOpIdx oi)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        gen_ldst2(INDEX_op_qemu_ld2, TCG_TYPE_I64,
-                  tcgv_i32_temp(TCGV_LOW(v)), tcgv_i32_temp(TCGV_HIGH(v)),
-                  addr, oi);
-    } else {
-        gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I64, tcgv_i64_temp(v), addr, oi);
-    }
+    gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I64, tcgv_i64_temp(v), addr, oi);
 }
 
 static void gen_st_i64(TCGv_i64 v, TCGTemp *addr, MemOpIdx oi)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        gen_ldst2(INDEX_op_qemu_st2, TCG_TYPE_I64,
-                  tcgv_i32_temp(TCGV_LOW(v)), tcgv_i32_temp(TCGV_HIGH(v)),
-                  addr, oi);
-    } else {
-        gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I64, tcgv_i64_temp(v), addr, oi);
-    }
+    gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I64, tcgv_i64_temp(v), addr, oi);
 }
 
 static void tcg_gen_req_mo(TCGBar type)
@@ -143,7 +131,7 @@ static TCGTemp *tci_extend_addr(TCGTemp *addr)
      * Compare to the extension performed by tcg_out_{ld,st}_helper_args
      * for native code generation.
      */
-    if (TCG_TARGET_REG_BITS == 64 && tcg_ctx->addr_type == TCG_TYPE_I32) {
+    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
         TCGv_i64 temp = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(temp, temp_tcgv_i32(addr));
         return tcgv_i64_temp(temp);
@@ -356,16 +344,6 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
     TCGv_i64 copy_addr;
     TCGTemp *addr_new;
 
-    if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
-        tcg_gen_qemu_ld_i32_int(TCGV_LOW(val), addr, idx, memop);
-        if (memop & MO_SIGN) {
-            tcg_gen_sari_i32(TCGV_HIGH(val), TCGV_LOW(val), 31);
-        } else {
-            tcg_gen_movi_i32(TCGV_HIGH(val), 0);
-        }
-        return;
-    }
-
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     orig_memop = memop = tcg_canonicalize_memop(memop, 1, 0);
     orig_oi = oi = make_memop_idx(memop, idx);
@@ -421,11 +399,6 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
     MemOpIdx orig_oi, oi;
     TCGTemp *addr_new;
 
-    if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
-        tcg_gen_qemu_st_i32_int(TCGV_LOW(val), addr, idx, memop);
-        return;
-    }
-
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 1, 1);
     orig_oi = oi = make_memop_idx(memop, idx);
@@ -577,7 +550,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
     orig_oi = make_memop_idx(memop, idx);
 
     /* TODO: For now, force 32-bit hosts to use the helper. */
-    if (TCG_TARGET_HAS_qemu_ldst_i128 && TCG_TARGET_REG_BITS == 64) {
+    if (TCG_TARGET_HAS_qemu_ldst_i128) {
         TCGv_i64 lo, hi;
         bool need_bswap = false;
         MemOpIdx oi = orig_oi;
@@ -691,7 +664,7 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
 
     /* TODO: For now, force 32-bit hosts to use the helper. */
 
-    if (TCG_TARGET_HAS_qemu_ldst_i128 && TCG_TARGET_REG_BITS == 64) {
+    if (TCG_TARGET_HAS_qemu_ldst_i128) {
         TCGv_i64 lo, hi;
         MemOpIdx oi = orig_oi;
         bool need_bswap = false;
@@ -950,17 +923,6 @@ static void tcg_gen_nonatomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
 {
     TCGv_i64 t1, t2;
 
-    if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
-        tcg_gen_nonatomic_cmpxchg_i32_int(TCGV_LOW(retv), addr, TCGV_LOW(cmpv),
-                                          TCGV_LOW(newv), idx, memop);
-        if (memop & MO_SIGN) {
-            tcg_gen_sari_i32(TCGV_HIGH(retv), TCGV_LOW(retv), 31);
-        } else {
-            tcg_gen_movi_i32(TCGV_HIGH(retv), 0);
-        }
-        return;
-    }
-
     t1 = tcg_temp_ebb_new_i64();
     t2 = tcg_temp_ebb_new_i64();
 
@@ -1019,17 +981,6 @@ static void tcg_gen_atomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
          * is removed.
          */
         tcg_gen_movi_i64(retv, 0);
-        return;
-    }
-
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_atomic_cmpxchg_i32_int(TCGV_LOW(retv), addr, TCGV_LOW(cmpv),
-                                       TCGV_LOW(newv), idx, memop);
-        if (memop & MO_SIGN) {
-            tcg_gen_sari_i32(TCGV_HIGH(retv), TCGV_LOW(retv), 31);
-        } else {
-            tcg_gen_movi_i32(TCGV_HIGH(retv), 0);
-        }
     } else {
         TCGv_i32 c32 = tcg_temp_ebb_new_i32();
         TCGv_i32 n32 = tcg_temp_ebb_new_i32();
@@ -1064,43 +1015,33 @@ static void tcg_gen_nonatomic_cmpxchg_i128_int(TCGv_i128 retv, TCGTemp *addr,
                                                TCGv_i128 cmpv, TCGv_i128 newv,
                                                TCGArg idx, MemOp memop)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* Inline expansion below is simply too large for 32-bit hosts. */
-        MemOpIdx oi = make_memop_idx(memop, idx);
-        TCGv_i64 a64 = maybe_extend_addr64(addr);
+    TCGv_i128 oldv = tcg_temp_ebb_new_i128();
+    TCGv_i128 tmpv = tcg_temp_ebb_new_i128();
+    TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
+    TCGv_i64 z = tcg_constant_i64(0);
 
-        gen_helper_nonatomic_cmpxchgo(retv, tcg_env, a64, cmpv, newv,
-                                      tcg_constant_i32(oi));
-        maybe_free_addr64(a64);
-    } else {
-        TCGv_i128 oldv = tcg_temp_ebb_new_i128();
-        TCGv_i128 tmpv = tcg_temp_ebb_new_i128();
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 z = tcg_constant_i64(0);
+    tcg_gen_qemu_ld_i128_int(oldv, addr, idx, memop);
 
-        tcg_gen_qemu_ld_i128_int(oldv, addr, idx, memop);
+    /* Compare i128 */
+    tcg_gen_xor_i64(t0, TCGV128_LOW(oldv), TCGV128_LOW(cmpv));
+    tcg_gen_xor_i64(t1, TCGV128_HIGH(oldv), TCGV128_HIGH(cmpv));
+    tcg_gen_or_i64(t0, t0, t1);
 
-        /* Compare i128 */
-        tcg_gen_xor_i64(t0, TCGV128_LOW(oldv), TCGV128_LOW(cmpv));
-        tcg_gen_xor_i64(t1, TCGV128_HIGH(oldv), TCGV128_HIGH(cmpv));
-        tcg_gen_or_i64(t0, t0, t1);
+    /* tmpv = equal ? newv : oldv */
+    tcg_gen_movcond_i64(TCG_COND_EQ, TCGV128_LOW(tmpv), t0, z,
+                        TCGV128_LOW(newv), TCGV128_LOW(oldv));
+    tcg_gen_movcond_i64(TCG_COND_EQ, TCGV128_HIGH(tmpv), t0, z,
+                        TCGV128_HIGH(newv), TCGV128_HIGH(oldv));
 
-        /* tmpv = equal ? newv : oldv */
-        tcg_gen_movcond_i64(TCG_COND_EQ, TCGV128_LOW(tmpv), t0, z,
-                            TCGV128_LOW(newv), TCGV128_LOW(oldv));
-        tcg_gen_movcond_i64(TCG_COND_EQ, TCGV128_HIGH(tmpv), t0, z,
-                            TCGV128_HIGH(newv), TCGV128_HIGH(oldv));
+    /* Unconditional writeback. */
+    tcg_gen_qemu_st_i128_int(tmpv, addr, idx, memop);
+    tcg_gen_mov_i128(retv, oldv);
 
-        /* Unconditional writeback. */
-        tcg_gen_qemu_st_i128_int(tmpv, addr, idx, memop);
-        tcg_gen_mov_i128(retv, oldv);
-
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i128(tmpv);
-        tcg_temp_free_i128(oldv);
-    }
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i128(tmpv);
+    tcg_temp_free_i128(oldv);
 }
 
 void tcg_gen_nonatomic_cmpxchg_i128_chk(TCGv_i128 retv, TCGTemp *addr,
-- 
2.43.0


