Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD9606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XWum64Ze
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKseQ-0002qZ-7x; Sun, 25 Oct 2026 03:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKscv-0008N4-6C
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsct-0004aF-2M
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso13004615e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913201; x=1793518001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HoIttCgyS9AHw81iYjdjYdcvqx1XthhIiKwGzYyXgew=;
 b=XWum64ZexdmKhlwn0cO1+kDiHEL7HkN8vQwxWiy4NOIfYw6EmkHrS5YXPxxMoEm2Gi
 C28K0WfX1as/Eop/7pfffW+1iE379isb0xa9HBVq1+b64xAiqgqQmTtOdFHwfz9kEV6z
 wV5Wtq9Tgk5Was4ILLWi36cN/dGfxd6FzaAG95Hi2zFe5+YyYSMb9YQuXxR+DcQEiiIN
 NGD78BWJwR0A+gIWwx1L4eI5r2pJzy0wBfx9NqeZxYIqVJK3tKQufDpsnlrTZFQ01RBT
 Q5OQ/P/couw2ZIUbXZveNtdXD+ij9H7IJ5WT1BGAadp3musIldujcYgqa/nMe9NbZ6sa
 JOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913201; x=1793518001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HoIttCgyS9AHw81iYjdjYdcvqx1XthhIiKwGzYyXgew=;
 b=imz2x/x7ggQOSTMjd67uh3NFu11dz7ohgLoxwNSXuO31Du86ofE78WRbEH+3RHHDCj
 2mpz3zXfUzM0XnbFlWiDIGl1AqegQf1pr6o6PZgmSjwMXOcRPbKqf4DTlFLh+GW+8BoR
 D58B1+p4T4kbN/YP5VAtypFuoJNszUx/y2sTZqKs+tdPP0LtTODzc8OSFrrppcS1p/Yy
 M0rLB1r9P6DOIaUk1j+qF09UNLrgTqnHPQfXsDBoKIRpudpkoDECWo29QpkIcA2y7keZ
 T0Nyr1eq5m4pRvH8y2iZENZvoh1PJ3X7i+u8dvUKYlMs6ndtpGPMaW/a+S4YNkAtgpqX
 pl4w==
X-Gm-Message-State: AFq9FYLOup1qnIUlmmoK2WCyGOVpb6y0/NygBvWdbFcwWU1IKTnt+rP9
 b4fB5cNuVblPxuHai09osAZQATBZ48KG22PdAW8ONlBgAPFZwYUY6RQ14BdUTSy+0ti3BcTeVd2
 meYwLfTY=
X-Gm-Gg: AYBFou0WpDn5BS71DXZRFRgXX6h/6kZcMxo+Q4CfmsQ14y9O5EzcNXEviImVh6rwQTg
 YjnsCpgxhfHFqoVtxkc2JuPvwwKOcFuBLwFheZwKk9xAJ30TstqcKy3ztDL9N0Bo9+Z94h38+Ds
 wMFMalNpVwdOzK4QfLBbN/nU+sdTDLdCymXWp1NC+W9Io+0GKj75irN1tuRnKTo1iTHpCixf0KM
 xdZjcuucndCxlccEePhoL4XybPm5QdyKw/P6T6Q8wL+2SubbfJEacdqxgJvlVusitunCy3LDkCX
 ZWJd/bLpQbwSckzFAm8qA+6Jd9J4d683pJXDatb4TGEG2JgwGlRzFLZ+V4DMUI6gL0FW/Ak2UbD
 4aBcNA1gEiS1cxRyOT+i5XZ7DwP04Q/qV6gceVptgl9ZEPp3WmtZN5acsnWRDkzy21w9bVtCVFv
 4N3EJU1n8dPXYAFznMg2J9J9heAc1S/muXhMY7Jfqsym8fbHmxWK83FmSbbPHNSuFKJ+iHM08GU
 uDgDM/7XDk38idQDVJP39VIwxU/+IMDTMk4v2MxruZhdLKtxpikUee7RvM=
X-Received: by 2002:a05:600c:3b02:b0:4a3:18ca:806 with SMTP id
 5b1f17b1804b1-4a35acb234emr59891195e9.20.1792913201059; 
 Sun, 25 Oct 2026 00:26:41 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 081/100] tcg: Generic expansion of tcg_gen_mulu2_*
Date: Sun, 25 Oct 2026 08:18:56 +0100
Message-ID: <20261025071915.1123867-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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
 include/tcg/tcg-op-common.h  |  2 -
 tcg/tcg-internal.h           |  7 ++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 72 ++++++++++++++++--------------------
 4 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 036b3de920..cd30395c70 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -157,7 +156,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
-void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 13c4be5a5c..09899cb309 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -126,6 +126,13 @@ static inline void tcg_gen_op_ttti(TCGOpcode opc, TCGType type, TCGTemp *t0,
     tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
 }
 
+static inline void tcg_gen_op_tttt(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                                   TCGTemp *t1, TCGTemp *t2, TCGTemp *t3)
+{
+    tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1),
+                temp_arg(t2), temp_arg(t3));
+}
+
 static inline void tcg_gen_op_tttii(TCGOpcode opc, TCGType type,
                                     TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                                     TCGArg a3, TCGArg a4)
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 14bdabb2f1..b24122173a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF4(mulu2, TCGV, TCGV, TCGV, TCGV)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5cdba463dc..cd947486ab 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -777,6 +777,37 @@ void tcg_gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
+                   TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_mulu2, type, 0)) {
+        tcg_gen_op_tttt(INDEX_op_mulu2, type, rl, rh, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_muluh, type, 0)) {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+        tcg_gen_mul(type, t, src1, src2);
+        tcg_gen_op_ttt(INDEX_op_muluh, type, rh, src1, src2);
+        tcg_gen_mov(type, rl, t);
+    } else if (type == TCG_TYPE_I32) {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(TCG_TYPE_I64);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        /* Simply extend and use host 64-bit multiply. */
+        tcg_gen_extu(t0, src1);
+        tcg_gen_extu(t1, src2);
+        tcg_gen_mul(TCG_TYPE_I64, t0, t0, t1);
+        tcg_gen_extrl(rl, t0);
+        tcg_gen_extrh(rh, t0);
+    } else {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+        tcg_gen_mul(TCG_TYPE_I64, t, src1, src2);
+        gen_helper_muluh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
+                             temp_tcgv_i64(src2));
+        tcg_gen_mov(TCG_TYPE_I64, rl, t);
+    }
+}
+
 void tcg_gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nand, type, 0)) {
@@ -1184,28 +1215,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_mulu2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_muluh, rh, arg1, arg2);
-        tcg_gen_mov_i32(rl, t);
-        tcg_temp_free_i32(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t0, arg1);
-        tcg_gen_extu_i32_i64(t1, arg2);
-        tcg_gen_mul_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I32, 0)) {
@@ -1691,25 +1700,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_mulu2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_muluh, rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t);
-        tcg_temp_free_i64(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_mul_i64(t0, arg1, arg2);
-        gen_helper_muluh_i64(rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I64, 0)) {
-- 
2.53.0


