Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC355606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eEGlwu8E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsZw-0006tY-Ev; Sun, 25 Oct 2026 03:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZP-0006Fi-Db
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZN-00043n-1k
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so13148935e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912983; x=1793517783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S5/96miNaeZSIJrtzuPlojnM6kLd4Gzqfk1Vg9T9iU8=;
 b=eEGlwu8EX2Yf8H14o1yRsJKOJ+8tWZXICYdYUqX5pAAJ9aQuaA45j6/Z7JWrtSCfbx
 zfOaS60G7j6Cz4zyrl9262ifV7HU9CYlCC9tYuvtA08XHamgKY7mbxxiE0sQSL33Guue
 SNFmeqnDEeNcm0/5EXMpM/3a6hrarYTKgHxr+D7vgP9UaTA/2v2FyaCeW9fQUvyE0R1H
 0nvIFN7S92+HDI378vwpL6JRJJEsQ9ApAAH7eZflUCfVR3ktu3yEIztX2G/G4ERyxndc
 QseaGjhmlKzyikJyjR+7F6ZPC87RM8osZrmvnySeuZmm6y+ARBb2U6r+dxn+6Z9bvp14
 Ri8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912983; x=1793517783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S5/96miNaeZSIJrtzuPlojnM6kLd4Gzqfk1Vg9T9iU8=;
 b=vGQsUmcufDb0lpWfDpVApkpdRvfm0xs2TNY0uplgjI98BpKYeKKNIeY0ic63AYxae+
 IX5IbhWNfDel4pzu5kZ0IuOXFZHa83eAdqspLHhYu9PT25jfMujWPCp5qq9Nd0r3y/Gc
 eMmjv03LDBP5Xce7EE0UPk///iCD0NpRp25/AyuMu961qpCLZpmduZ6JbB0EnkkeJ1Im
 LFhaDq2kM7A8+TPoEwWxTC6bbVk95oQeWNBOzBgaMI0AeiqdyKyJ+PlKvGDWuAlHdI8P
 mP8mBNxF85mAVUsEKymvUoOPuK/yNkvf1WuZcgfDnOOiYvIV3ReJG/dCR64tJOPBVJJr
 nRTw==
X-Gm-Message-State: AFq9FYL/P8xzlYSGieeFh9/ixF9v//kbaq1fYIFHLjgxO1htQH4nxIht
 HNPvyRJrZuCcaG/WyXP5/swFRHEDADBm6jyXy8Upmn445+MOodVbMXGWhD9cv6NpeAdAaEkO3WF
 8yu8W/ME=
X-Gm-Gg: AYBFou10qWX8Cnu6lK0VEkX5XbiHgynI6c78FgLIHpBrLfLM8PNcuJMkAwxtwE0rH4n
 GvwYuXOhsifiR7nbMi1MkBiOESoq2EU2TUYw6HAENj33dZ2o1p+AQNo1fLIhFlF1ZUza3ExnRm4
 nJMEi7T5hpv6e0IEJfu5O41Ax3GLSYR2JShyCSVtPZwfEMuPPQMKPwmk2fc660WOwlFpYCnsmEe
 LGpEUJWwjodJKQxvNcIVz19RMBqLZtKFxjFkBbwhoKzcPOYwAuq3QCm9Dox7tZAKvKqwa+kYu36
 uFljHiIY1ox2vr3ZLA7AgEE+u9uZy5VTGeTg+jUuhvOOxM9Ty2cXzlAMFOA2Tq+l05TZI5Ozqn0
 d7N4GeL0FBFHo7/YrVigT2kRJyuJk795/xNicon8AWVUve2tnTHhYiQkncYeAc/vBN4EtEz6xS1
 LOnsByzT2G4/kCD/oAmUv5VO3pLwWbu4BXmK9uUnW7mnNGpko+hWohqxVczkVMw/ohs6a5a8RGh
 bQXPT0Kk7dQ2YMs4/tUBESHAx1lV5EYSQayEaE3sRDW9R6VtMJfbZSkrAe4NjQhVBWKuElKG5Ut
 bn1y
X-Received: by 2002:a05:600c:b86:b0:4a1:7ec7:a479 with SMTP id
 5b1f17b1804b1-4a35acc1129mr59472825e9.33.1792912983407; 
 Sun, 25 Oct 2026 00:23:03 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 041/100] tcg: Generic expansion of tcg_gen_brcond_*
Date: Sun, 25 Oct 2026 08:18:16 +0100
Message-ID: <20261025071915.1123867-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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
 include/tcg/tcg-op-common.h  |  5 ++--
 include/tcg/tcg.h            |  1 +
 tcg/tcg-internal.h           |  3 +++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 44 ++++++++++++++++++------------------
 5 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e62459b5f0..ca249b999f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -98,6 +98,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2);
 #define DEF3(NAME, T1, T2, T3) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3);
+#define DEF4(NAME, T1, T2, T3, T4) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4);
 
 #define TCGV  glue(TCGv,TExt)
 #define TExt  _i32
@@ -120,6 +122,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF1
 #undef DEF2
 #undef DEF3
+#undef DEF4
 
 /* 32 bit ops */
 
@@ -143,7 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *);
 void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
@@ -216,7 +218,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *);
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e131345170..09d20064fc 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -97,6 +97,7 @@ struct TCGLabelUse {
 };
 
 typedef struct TCGLabel TCGLabel;
+typedef struct TCGLabel *TCGLabelPtr;
 struct TCGLabel {
     bool present;
     bool has_value;
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 6b65228241..cd481dfd27 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -150,6 +150,8 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2);
 #define DEF3(NAME, T1, T2, T3) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3);
+#define DEF4(NAME, T1, T2, T3, T4) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4);
 
 #define TCGV  TCGTemp *
 #define TINT  int64_t
@@ -162,5 +164,6 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #undef DEF1
 #undef DEF2
 #undef DEF3
+#undef DEF4
 
 #endif /* TCG_INTERNAL_H */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index fa33d41e3d..10ed0438fd 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
+DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8fb04d3c6e..a8752e916a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -307,10 +307,17 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c)               \
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c)); }
 
+#define DEF4(NAME, T1, T2, T3, T4)                                      \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c, T4 d)         \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),              \
+                     glue(C_,T3)(c), glue(C_,T4)(d)); }
+
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
 #define C_int64_t
+#define C_TCGCond
+#define C_TCGLabelPtr
 
 #define TCGV  glue(TCGv,TExt)
 #define TExt  _i32
@@ -338,10 +345,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_TCGv_i64
 #undef C_int32_t
 #undef C_int64_t
+#undef C_TCGCond
+#undef C_TCGLabelPtr
 
 #undef DEF1
 #undef DEF2
 #undef DEF3
+#undef DEF4
 
 /*
  * Generic expansions for templated operations.
@@ -404,6 +414,18 @@ void tcg_gen_andc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
+                    TCGTemp *src2, TCGLabel *l)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_br(l);
+    } else if (cond != TCG_COND_NEVER) {
+        TCGOp *op = tcg_gen_op_ttii(INDEX_op_brcond, type,
+                                    src1, src2, cond, label_arg(l));
+        add_as_label_use(l, op);
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -661,17 +683,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op4ii_i32(INDEX_op_brcond,
-                                      arg1, arg2, cond, label_arg(l));
-        add_as_label_use(l, op);
-    }
-}
-
 void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1471,17 +1482,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op4ii_i64(INDEX_op_brcond, arg1, arg2, cond,
-                                      label_arg(l));
-        add_as_label_use(l, op);
-    }
-}
-
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
 {
     tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-- 
2.53.0


