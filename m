Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A079D606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pZ7pG8OV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsda-000092-Nn; Sun, 25 Oct 2026 03:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZx-00070R-9a
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZv-0004AO-6t
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so3119005e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913018; x=1793517818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0DDcCw3cEBI16s74i8VXjatipq9ziv4PMD3fAB52srU=;
 b=pZ7pG8OVpxqQQfXaPTxZBcUPjeGr96chBEe/EpooZZKT2XfRdKFEHBQp7G+QJJY+BI
 K8QdVmD42J8UEWJWzOqtRKkU9QkxrnliRfmSGrKfHkyWNNwTyhAbqmvRJha9ehAlxJ98
 AfD8CzoFT+sYGQrMm69gJlzYTvYCbjdL/Bms4vDRgbo3sQDvhm8mI+g83KeZuezYnA7r
 DmeAMjr3darpt/qpih/Ryt9uVrQll4QCCAe8WdtDWiFg4pTotZdy2RNcs3vY1UAGRkXx
 01MLQ90tFJKAWsFDq6P9PAgW/SB3CIePiXvNhvJnh0QlNEwXEKJwZP0t3jpYLGM6L9H2
 Gtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913018; x=1793517818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0DDcCw3cEBI16s74i8VXjatipq9ziv4PMD3fAB52srU=;
 b=ThrIkuxcJxt+4nMub6CXQBw0clDp4BtYU/I+80JK7UrzMGKXiz3x1xbAjd64newJ7V
 DyG3McGPa29TcPwg/gObDwMfAsdd4ZttyQnYSQmJSJPbsuLidUtXZs7Q2Q+NVf1T/nbH
 UovkTtDZFPjKcVkVokEwcAzJSejY574RT2IrIf3HBzAIqsydnTM+eyyAaSZO87VPspRv
 +CAG1DO/pJczM8IENQuZSObP2nP94N8xAueEtk8BpBSuu+ywGywCVY5wwDDWEDyASDNc
 lT4s2af0/GkqU2JFByM8Ad97+O2BC+oaNOlc2Wpa5ro8Lvc7mS7aCvBQ/zzxaB9zYyWk
 9LRg==
X-Gm-Message-State: AFq9FYKsmHx/udt4ne2LVe/ykoURdBJM6KPfiz7uX+GCNyVKlfSoRnEG
 E+1Wha/Z360Y5othi/1Xjyt2Ul4JKepaOOnVdf9lfxfPDwZARTz0Opo9xil/m1fnU60jNAq5Kcm
 cc5j13n0=
X-Gm-Gg: AYBFou3Y8O6pSjbSQv817Pm4BqvWfyEtlo7H06pZBuqfsVRYKxrpzTVjBsjTmn9hxzF
 7xkaHjsFEsjye8Bhr8hKQcGKpP2xDKOyKeulkI2SdTTLCdiGlmLgmtOVhSlF/tjWe6tuXK1pEpU
 9L9HpFJlELyPv1umXrpLWuAYpgTEaGnamVwngYkOukAu7oasTiypwGLsKw1qS7iRhS19KRvOVp1
 g/W2T9tcIVWgz861qaO0RR58Z7SvgXjLslXjy0kes9AYoboJRphKGwAlZUiIwtkAwtMR7rcAoLg
 otHugyaOTxg+tN6HhE4iBRrC1/BelNpUMYvC1VE09EG7PGYQQfuyUDvzdnHGV5cUuuvvPMZZvVS
 mcKQPDduwqAK/bnCq7zXFaknUSbyz/d09pTccpPqub2X1SZOZxpGlhgpd3Zea1WU7u/oqfoafT4
 fc+wBxsqjPH/J0zNXtSOnMSTqAMQV6Sl9LuUZFSd1aQnyZyWDBpMPfk9ragWD2pHSKJg4OVR+oN
 R1LHaelWM3jr7ttBP2Pf2nfO5bIn519lmr9wJ6gZAdN4B6oYBQmPt7X3BE=
X-Received: by 2002:a05:600c:4e87:b0:4a3:59c9:a758 with SMTP id
 5b1f17b1804b1-4a35acb1cb7mr58983605e9.32.1792913017734; 
 Sun, 25 Oct 2026 00:23:37 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 078/100] tcg: Generic expansion of tcg_gen_addcio_*
Date: Sun, 25 Oct 2026 08:18:53 +0100
Message-ID: <20261025071915.1123867-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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
 include/tcg/tcg-op-common.h  |  4 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 77 +++++++++++-------------------------
 3 files changed, 24 insertions(+), 58 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c1c41a03f3..84fdadc63b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -136,8 +136,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
-void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
-                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -166,8 +164,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
-void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
-                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a237ccd0c5..003384b65d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -4,6 +4,7 @@
 DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF5(addcio, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ecb6abb0ac..1f8c8d57e8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -345,6 +345,29 @@ void tcg_gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
+                    TCGTemp *a, TCGTemp *b, TCGTemp *ci)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        TCGTemp *mone = tcg_constant_internal(type, -1);
+
+        tcg_gen_op_ttt(INDEX_op_addco, type, t0, ci, mone);
+        tcg_gen_op_ttt(INDEX_op_addcio, type, r, a, b);
+        tcg_gen_op_ttt(INDEX_op_addci, type, co, zero, zero);
+    } else {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        tcg_gen_add(type, t0, a, b);
+        tcg_gen_setcond(type, TCG_COND_LTU, t1, t0, a);
+        tcg_gen_add(type, r, t0, ci);
+        tcg_gen_setcond(type, TCG_COND_LTU, t0, r, t0);
+        tcg_gen_or(type, co, t0, t1);
+    }
+}
+
 void tcg_gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
@@ -1145,33 +1168,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     }
 }
 
-void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
-                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        TCGv_i32 mone = tcg_constant_i32(-1);
-
-        tcg_gen_op3_i32(INDEX_op_addco, t0, ci, mone);
-        tcg_gen_op3_i32(INDEX_op_addcio, r, a, b);
-        tcg_gen_op3_i32(INDEX_op_addci, co, zero, zero);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-
-        tcg_gen_add_i32(t0, a, b);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, a);
-        tcg_gen_add_i32(r, t0, ci);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t0, r, t0);
-        tcg_gen_or_i32(co, t0, t1);
-
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1682,33 +1678,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
     }
 }
 
-void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
-                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
-        TCGv_i64 discard = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        TCGv_i64 mone = tcg_constant_i64(-1);
-
-        tcg_gen_op3_i64(INDEX_op_addco, discard, ci, mone);
-        tcg_gen_op3_i64(INDEX_op_addcio, r, a, b);
-        tcg_gen_op3_i64(INDEX_op_addci, co, zero, zero);
-        tcg_temp_free_i64(discard);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_add_i64(t0, a, b);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, a);
-        tcg_gen_add_i64(r, t0, ci);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t0, r, t0);
-        tcg_gen_or_i64(co, t0, t1);
-
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
 {
     tcg_debug_assert(n > 2);
-- 
2.53.0


