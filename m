Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B284DC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkoa-0006AU-IA; Sun, 27 Sep 2026 05:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAko4-000512-6n
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:26 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAko1-0007fb-Lc
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:23 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc797656e36so457639a12.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499860; x=1791104660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ize1mUlRPveWGTOE9mSnk4f2htHfkqtn1cDj0e3BVzo=;
 b=SSpQADfCadKsXQM0SQZGyCmpGP5vqR1lqbftHjYt5+KzG+CaakplshJz3aGAciNF4H
 i1/Un84t32eRKg8vkk9Sr/1YfoXpKGVMVI9j5S1JoawRvMlTviUK3xmF1BvhfNmJkAsx
 s1a8UMHMMS+mw1bVL6ubVPp+M4DmGGuswR8JkHbB6WOBYMsO+LuXUr7pfvz2wMzS3Qla
 sNWdgzZS5l3+h7oJkfKkGHkmwnwuDcdwn/xybNCixk2heJvI3PorGROUmdxyX8CL6Cb3
 Qj2SpPAhlAFsYZe1RrcCtm6oavV/FDDfZTF1U92WLjSsWNyRcYgUr3d2v8zfESfGRdIt
 OgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499860; x=1791104660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ize1mUlRPveWGTOE9mSnk4f2htHfkqtn1cDj0e3BVzo=;
 b=Dp17Za//E3UxM6SGz12pt2ZB4EcX455Vx0WBRK3/zmtSsx/F/6JTTaXO3h6uFZMLsR
 /PooRRoNOxgKXDX2a8KnkhENNFaORgJhtjT4hRZ0J5VrtJ1KPzrfXSi8MKVkgZmxugKt
 Xt72Q5VQaqt0yPK1S0qU8kRvsqsqAbVnCFd4cT93yFiMSGYtTI+r8i1Zr0mtOHTV0WyP
 WUy8kCSp2aDk0Sf+oLlPmbCuI+R6UmqPZlywY5nwqrd6q7WuMA60ZV6y+7hpnjsgrvZ1
 wFitSZbwqKz86FhizzSbYdP+pTHFJWjv5RZkCS+QrJPrKP9erve456EOIg94y0+f6TsB
 q5Ew==
X-Gm-Message-State: AFq9FYLKQZpFKNXOcYKiKXQZ5qzoY0mPOaEr8vcRhhuWgT+WiyE4rywJ
 q8iRFvqbzTqtomHJaRhmBa4t7zsBZdDBU0GVq4Q0MxttPDoGvJucC+PCyrQxndEQVwBEfQ/Rm0z
 KVErp
X-Gm-Gg: AYBFou1KnpxxBX73iDy9tn/KbhalIHO1DPR0pQpsb7/FZUfsEZlPfokJO2pk32V51Fo
 JZ2388z8QjHtTFnWvy8GI1VsPBzqwzQqS1ePp5vbvGdMV4Babzyz9PWeMsAyVuEjHkbAgCZ4/n1
 wT7yKiXXPMrX/hsk/Kieoouk52VaE3PTH4k7F4fxsV8U+Nlyyi0gs8pLquPMKQUTXfNZIjzI6Su
 h4qEZP3OCOGKsjUWprj3vtsX/NeuLWzhGlNwIZW/AsN7GUFdKp/RXCIxU3LXM348UXrxpOhYQbs
 npZoqffIAaleX8ATe+aeQhQ26gZQil7e+x9N1CxV7hqFZWxbfEn3p6etRsSS+ZM9JitjEWgUX5s
 3MLU4O9XOmY3ql8jO2Kp89eEUZgAebRyiQJnkGcgJTGP4qrazNzZ+W4rbgNDDEldVWlhr7xLPXT
 CmmFocBF5FtuB79mHPMlKItI9ys2CQvcw7QsQqGcZjEfAKRc0xpcaAqDqmB88+1C2z/XKeXF/Ts
 RCqk4P+E4cqSMVtiw/t1Pxi7qL5oQ==
X-Received: by 2002:a17:90b:4cc2:b0:3a0:e22b:1b2a with SMTP id
 98e67ed59e1d1-3a0e22b1d7fmr2201739a91.32.1790499860082; 
 Sun, 27 Sep 2026 02:04:20 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 062/101] tcg: Generic expansion of tcg_gen_deposit_*
Date: Sun, 27 Sep 2026 01:59:32 -0700
Message-ID: <20260927090011.10724-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
 include/tcg/tcg-op-common.h  |  7 ++---
 tcg/tcg-internal.h           | 10 +++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 55 ++++++++++++++++--------------------
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3eed9e6c2ed..e3d6c9bfd8c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -100,6 +100,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4);
+#define DEF5(NAME, T1, T2, T3, T4, T5) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4, T5);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4, T5, T6);
 
@@ -125,12 +127,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF5
 #undef DEF6
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
 void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -180,8 +181,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
 void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index a0edf112927..13c4be5a5c7 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -126,6 +126,13 @@ static inline void tcg_gen_op_ttti(TCGOpcode opc, TCGType type, TCGTemp *t0,
     tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
 }
 
+static inline void tcg_gen_op_tttii(TCGOpcode opc, TCGType type,
+                                    TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                                    TCGArg a3, TCGArg a4)
+{
+    tcg_gen_op5(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3, a4);
+}
+
 static inline void tcg_gen_op_ttttt(TCGOpcode opc, TCGType type,
                                     TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                                     TCGTemp *t3, TCGTemp *t4)
@@ -166,6 +173,8 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4);
+#define DEF5(NAME, T1, T2, T3, T4, T5) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
@@ -181,6 +190,7 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF5
 #undef DEF6
 
 static inline void tcg_gen_extrh(TCGTemp *dst, TCGTemp *src)
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 9b88373ff23..95885d28d83 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
 DEF3(ctzi, TCGV, TCGV, TINT)
+DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index dc6079a9e45..f5771240803 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -296,6 +296,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),              \
                      glue(C_,T3)(c), glue(C_,T4)(d)); }
 
+#define DEF5(NAME, T1, T2, T3, T4, T5)                                  \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c, T4 d, T5 e)   \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),              \
+                     glue(C_,T3)(c), glue(C_,T4)(d), glue(C_,T5)(e)); }
+
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6)                              \
     void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f) \
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c),  \
@@ -307,6 +312,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define C_int64_t
 #define C_TCGCond
 #define C_TCGLabelPtr
+#define C_unsigned
 
 #define TCGV  glue(TCGv,TExt)
 #define TExt  _i32
@@ -336,11 +342,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_int64_t
 #undef C_TCGCond
 #undef C_TCGLabelPtr
+#undef C_unsigned
 
 #undef DEF1
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF5
 #undef DEF6
 
 /*
@@ -539,6 +547,23 @@ void tcg_gen_ctzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     tcg_gen_ctz(type, dst, src1, tcg_constant_internal(type, src2));
 }
 
+void tcg_gen_deposit(TCGType type, TCGTemp *dst, TCGTemp *src1,
+                     TCGTemp *src2, unsigned ofs, unsigned len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    if (len == width) {
+        tcg_gen_mov(type, dst, src2);
+    } else {
+        tcg_gen_op_tttii(INDEX_op_deposit, type, dst, src1, src2, ofs, len);
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -921,21 +946,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
-                         unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    if (len == 32) {
-        tcg_gen_mov_i32(ret, arg2);
-    } else {
-        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-    }
-}
-
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len)
 {
@@ -1683,21 +1693,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-                         unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    if (len == 64) {
-        tcg_gen_mov_i64(ret, arg2);
-    } else {
-        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-    }
-}
-
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


