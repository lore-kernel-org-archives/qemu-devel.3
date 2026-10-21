Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA0606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uTOFoRnb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXE0-0002Ux-1w; Wed, 21 Oct 2026 10:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDQ-0001aq-Ed
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDM-0002AK-IZ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:51 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so601419f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592561; x=1793197361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xlmVSTIWx1lx39cDmqOs7HGfKjuwyo3MbRYV7YJTUCE=;
 b=uTOFoRnb4VK3Pte9wNpGg6mo7L/TKOkJNj/bsNbn0ibFe/rNToAdTXrFdD+LC4w/eD
 0nkQ7oYPA+syuVL3Fph9wrpyJMQ6hjtVr/tb674r4wo25PfXdiHzCEG/faOS6pothu89
 BzI/Xai0UXu9xc5e1IfEYieQ9q94QthwzJt2zfeZtzMaDVa6Se4JNMwetEo6SYHvMxPv
 cCzdTLbssqOP0crpqIgGzRm0JPND4qIwnOBjBBsvA5AiVT1NJIG4DLza2E0GhVwlY9Hv
 TRa+iFgRePzS7lVM3f5KRO+4hmhvbnR1tF7T3/7WWpNi12GFgUn/CCfwWLN7zYh85F3c
 7z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592561; x=1793197361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xlmVSTIWx1lx39cDmqOs7HGfKjuwyo3MbRYV7YJTUCE=;
 b=s6DSBrxibgiZRIoQx/oQzdJ/N8XeHIVgdnEjTk6g3EwjEW7Y0lwnZxnwrdD0xmiOYV
 7cXbMnvhoGW63uxQkVu7E7updVVi5V/zA6bzuIONcabb7XDxBaDJPbnfiA3AM9cSF0oD
 Qpy7s5uFB1PcXPzEMQ8JP7pSW9FfManOn0mM6LE4lb30oaAC4TleVxzp1JSmlW14cyvi
 kvx1jj9mv9yUJ11wO+cwUlBZwRTwQhwgNSp8eSD9N62Mt7UzLMv4kSSvH2CmG/O7ud0/
 yZlps0/xv9dzL3h+UHPMeMnOXFYreJH/Pqp4c+SKQwSO4z7Hcq+z7IN2eXahCaKOVR/y
 od5Q==
X-Gm-Message-State: AFq9FYIZPAQuVLntXQvMR2BuuxwBxh6z+lsTMarLIFCedpidDx35+NwZ
 Q/9jbDsDrKWq9fOTHQdPTcxf0zALA+2p8u7TEYDOFS/vU5OD30kVNZ2gV/1GaImVAVEx2kEXA6A
 kRu4uF7E=
X-Gm-Gg: AYBFou2zMVJ1EsJ64+OBPb4qJO2IaRxSw7uQHkdLsH2sA+75FPCd8kej8l0QOKg3fG5
 mJGqGzRfRb2jdCZe7/qLlcXdOA7ayOM4XlRTMr+Y9fL8UCjYBr/rzFENvMWNTNx7UHA8u8S/KN0
 JMZ+ShQdVDxSYvxu8K36efjdFZhk7WVYeAgG7tFrCF2T8e0CsP+tqZwsKkO1Kev4sfl3uMYCMO0
 4a/2fg2xHIOLD4sozklFpbDLPvrVJMBjG0VvB1A8NzvwJzgYVltlBtliPsk5tPusuXDJKr6m66U
 8K6j5jkdlmRPhmFrFELMLj+KiomT8pRubdplnlBCxEl6Y6+MLUVe1zg+YlS+89a6BX4/1e6/01/
 snBm5ljaPmywIURSSnD/LslNYJy6SS+Q3YFaGbOzmBz3IJhPRwN5x1qWXkNE+wt1qmiwkoPjc3V
 +LtjZidCfsS+Z4aOYORPy2XmDSz6rpuSoRzH4g1cSABdVeSKs088wl1TFSnO4sKoklyeN9rjDxP
 M0Erp5DHPOuZM/vQXBbUVPdTFYxVdH6vJ93uAhqpC6/Z2vIvDDXkCa9pvFTgudI3Af2psI6n4Ht
 r3qLbU0puJ738TQ9kteKft20FR5qUXKRkiWxG+PWWiXYE+rC
X-Received: by 2002:a05:6000:611:b0:48e:476:99fb with SMTP id
 ffacd0b85a97d-48e264a7333mr4383340f8f.22.1792592560648; 
 Wed, 21 Oct 2026 07:22:40 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 061/100] tcg: Generic expansion of tcg_gen_deposit_*
Date: Wed, 21 Oct 2026 16:16:13 +0200
Message-ID: <20261021141652.363109-62-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  7 ++---
 tcg/tcg-internal.h           | 10 +++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 55 ++++++++++++++++--------------------
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d20ac150e4..7cb1a4de52 100644
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
index a0edf11292..13c4be5a5c 100644
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
index 9b88373ff2..95885d28d8 100644
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
index 536095683f..62c2186d0c 100644
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
+    unsigned width = tcg_type_bits(type);
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
@@ -919,21 +944,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1681,21 +1691,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


