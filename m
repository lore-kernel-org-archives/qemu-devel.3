Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D360A2603
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uwexEWyU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXI2-0007Qd-Ky; Wed, 21 Oct 2026 10:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGX-0006F3-O8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGV-0002X6-Ea
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1ec92f655so9115245e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592762; x=1793197562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H9pJfPaNudvP7s7gWr/Hi1/jtmgblX9T5+QufP2SN4o=;
 b=uwexEWyUFd/MRnNXepsuZj2BBuef9XDJ9S2bOXBwpgvjNyfSKu17h67X0kNA1mM58J
 0W2z3Qxy67SdnlX4EMLaqyR0Ft5TFEtQEmvOtBCloFLid8vHGcts1RE6293UXJp2dwHr
 yZXU+WYBdYwe8gzIpD7MKwIpUZ7aHtcKDoLZBOlETfi8uLwrWIuok3y8xH57CYhd8TGY
 T4WhtA90+SMC5QUD5ZljctK+k76rNtUdHCDwhRG9Wgf8U3gMTbY8TJqU2o1VzrlhUWyl
 +JTJKMYTcv9optxkJpBtCn4u1OibuB8OMe3VaztnTAI2cpXo2M1qKi0USFSEq7s5uLiN
 ysow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592762; x=1793197562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H9pJfPaNudvP7s7gWr/Hi1/jtmgblX9T5+QufP2SN4o=;
 b=TQlxEoERFUZksRTejhWOJsCpuqptzzqyQ/R0mXUDCZl2ETuwp3Pd5ygahm/8C3pp8D
 gwR2u8uqFofMJrrl2PYE6jR26oSzWMzoqOwy8X1glOpzjb7JULwVJvWCLEM7uDk9LCTL
 RF5PJzs1te6iHDUwrUrT5FRaOPN8l4cXGLMDCGXkpXJsBUhVxE330RIHuIFOS/XZgtA6
 auaLDEJGaUGTkrta+xv0hB6n/mGutfoVJ8ivKUbhNXYy9GQAzWVjMsQceI/Ej+5oOxU9
 TOvCuUKmYas+SWdez2XzaPwbB6H/6kyv/0ndDxXOdr2Yvcz9wtlt4toKqmrmTCCdJ1s7
 njTQ==
X-Gm-Message-State: AFq9FYIL13OpefYTMKCK1ame8PH4VRCE2Wv6st7o7qwoBJdILW0hDgt6
 6gU2Wop3bVotRObujAjRiLkDMWHxGkvJ51mrQTMANAjE9a917q+VSsXkeF6ZWwFry1M346poOyB
 56SW95fQ=
X-Gm-Gg: AYBFou1Gz+cZVuZigoghX4Q/LnF4T8+oSFxMZcxHBIZC0Ti4RibzAwTZhJEa1VyDYhp
 /MWSFN4V7ffVeuhFhS0sfS0aeRV3+2zzdt0dTrnmMjgeJKDDWEokNj04LBSAaEioPLbl3ESfijO
 u/3+qiD/OSWmwsYz03QOlVTUbypau8iC46IU8g/dsvnOPMgtSh9wgkHXbg0gHXMAV/Wa2q3Ty3K
 EWvGpe7oE48L74kgPZlUEt4+JbpJVcYx5motU9nJIRCpC6yuzqsfGl4Bde80UhtWAI64sYjkFap
 W9uraXzLSfZqSTuGuguCYR1t3zae0+gfJE54/BU6MZiFIQRDbETTbBWcVZUuWt09q1JCmE1KPDl
 0rL7gqAgXF9HGb6ramBVCbu1+hbxhoyYQlcSaHCoDbj3OzUaasow4806F0N/yxJAgc6y6H0QbqT
 wEHdWruDdHygSzyX3n1x5GRjruPiVYFdk4vbqYO6ISoCp//rBSDnqD1DoGTh/iXAbge3pG0bUaA
 T/i0Iuz5WkCRQov7snjCYs9L8iXMy1Lh1bq8BYMG3qWTsAEc1gwr1tacP8gU/OFIHTG1guu5ge3
 qNuvmVlQmTtp8BKVsHkqIYDPAhk=
X-Received: by 2002:a05:600c:a0b:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4a1fdd2443bmr47156635e9.12.1792592761614; 
 Wed, 21 Oct 2026 07:26:01 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 081/100] tcg: Generic expansion of tcg_gen_mulu2_*
Date: Wed, 21 Oct 2026 16:16:33 +0200
Message-ID: <20261021141652.363109-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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
index aaf18b58f7..822ac56c08 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -776,6 +776,37 @@ void tcg_gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
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
@@ -1183,28 +1214,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1690,25 +1699,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
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


