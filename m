Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01661606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=o0y1TNVq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsef-0003EC-8u; Sun, 25 Oct 2026 03:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKscx-0008O7-DX
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKscv-0004aS-Cr
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so971095e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913204; x=1793518004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qw0Xycu427D15u0nUvVV1va3VQFI+VlJSe46tEBuiWk=;
 b=o0y1TNVqlddGyPRnEQ2ZLnK0JRzxxuQ2wj3ctFRHEYsbocnkDcd9y9iBqga34JUTpm
 LliVKumatQHD9RPQoST6lqkxOxCCtrx2dBjExc3/G7KNCSGT/0yFoPrnKZJ15eQdylQ9
 zORyIl0lvaw9girPjiGbzr1tge7L01Uue1X+SUpBjCK7E4yKlsnzq4wLI5fnLc7pfU3L
 BP11Zq+otb0tZknofqFpv26xjbvvpQePUbWqoHXM1Xnx8YVdWxn9RnDQiz6qNXS9ynOb
 YeAKp/p9je1Idb6e8GwcD1bhqOhwc1reB4ULhidOSB9gJssdWD825u4DBkR4PSWvQKsm
 3DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913204; x=1793518004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qw0Xycu427D15u0nUvVV1va3VQFI+VlJSe46tEBuiWk=;
 b=17kKvmgIzyj09uVD3TqAo8KwaF7up28o9576RVdGPxQ4zN+cYkyu18iND34yl/omRH
 GYCXCytyCJ/8KR7XJBWjb54tGrUDlCLKbadRbTijH8KxoSzBssEIijaiLrZQgtu9Dhr3
 /4piKZrlLfXqtogR3EoZVlNEA3UKrmr2mVyrtAkpDLanQLn0ZirWDNI0iR3IvYx1E6Mb
 QhIbVd+X2ZZlAJMW9L1bw3Apj0Q462DLcdhzlBed0nqyB+195+TRh1X/i2G1XoHMTkUg
 3m0veJef038oBClCg8qYt086zTgWN7m4Yb7BvKUEsgDXrx9SeUogkpGGLfxVT36gp2tk
 3ZMA==
X-Gm-Message-State: AFq9FYKkWOXEWquft6yCDLpkqAwEZo7IgchHRy7LAkCvCrcjDaeeGTa6
 v146uxD/2yBdx7UiO3Z0tsadR2VE8lwAaSSfCfR2FUISJn3dXNcPrZF72GCXrcWSWTv9bJpmt4a
 Evsv8wOk=
X-Gm-Gg: AYBFou391G2QrPHFye8FgLdW1KtJixQbFKmdzpSI4OoGkHEd1JgCEiXge8DZrNuUgp3
 hL1L62FJ+x7DK/5zCk6DJF/YLLRf1zjsqpL9KwdYdbgfAtHqOFLtmYMTYgCVFmDF7t2xoiQIFGO
 ufTz1ernPGcgb2IccwtUPY5reB7XqAVTZP/QCkQlaWkFD5qohz6TYGTLzYDsHfeAIy4Zppqqfco
 md2WAPEblnHb1rhn8kqhnvdsy2og6HOSGB0uDsY+8wdCoXIZt2t65JHHj8zZxpYU/RE1o+EsnCN
 /ac1g/pnvKHW0G9qQ8ZRWLybhzI8j5imqBMWCbAJdFW3iR4O82aVZTJdClICOeIPnKY56OLUVCV
 gJ9WEuzZmbsh6OxmLNRcENOBdSZtXW20LfzRN6dMcOcLW0dkcu8smdQVYy7Vmcb2cPFue4W7/g4
 oDx96WgMmVrowm4zqg7ghdwrMU63zpUTetWZbewNRUatyiaSSU8UcWRxxj5VMHhgORVw7Y9q5TK
 ykZKrUopgl1Cr6AhLzysQ4zkxCFcIX2kEDE5pHBnB6nAvQSlAxtHp0h1h4=
X-Received: by 2002:a05:600c:4704:b0:4a2:967:dfb8 with SMTP id
 5b1f17b1804b1-4a35acb115cmr63877185e9.20.1792913204002; 
 Sun, 25 Oct 2026 00:26:44 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 084/100] tcg: Generic expansion of tcg_gen_bswap16_*
Date: Sun, 25 Oct 2026 08:18:59 +0100
Message-ID: <20261025071915.1123867-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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
 include/tcg/tcg-op-common.h  |   2 -
 tcg/tcg-internal.h           |   6 ++
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 120 ++++++++++-------------------------
 4 files changed, 41 insertions(+), 88 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9f5cae36c5..8f8560023a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -133,7 +133,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -158,7 +157,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 09899cb309..d6ea11d8fc 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -108,6 +108,12 @@ static inline void tcg_gen_op_tt(TCGOpcode opc, TCGType type,
     tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
 }
 
+static inline void tcg_gen_op_tti(TCGOpcode opc, TCGType type,
+                                  TCGTemp *t0, TCGTemp *t1, TCGArg a2)
+{
+    tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), a2);
+}
+
 static inline void tcg_gen_op_ttt(TCGOpcode opc, TCGType type,
                                   TCGTemp *t0, TCGTemp *t1, TCGTemp *t2)
 {
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b606aaab12..2ebcf4a066 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF3(bswap16, TCGV, TCGV, unsigned)
 DEF2(clrsb, TCGV, TCGV)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d4c15b39d4..b0be44d499 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -425,6 +425,40 @@ void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+void tcg_gen_bswap16(TCGType type, TCGTemp *dst, TCGTemp *src, unsigned flags)
+{
+    /* Only one extension flag may be present. */
+    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
+
+    if (tcg_op_supported(INDEX_op_bswap16, type, 0)) {
+        tcg_gen_op_tti(INDEX_op_bswap16, type, dst, src, flags);
+    } else {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+        int width = tcg_type_bits(type);
+
+        if (flags & TCG_BSWAP_IZ) {                     /* t0 = ...a */
+            tcg_gen_shri(type, t0, src, 8);
+        } else {
+            tcg_gen_extract(type, t0, src, 8, 8);
+        }
+
+        if (flags & TCG_BSWAP_OS) {
+            tcg_gen_shli(type, t1, src, width - 8);     /* t1 = b... */
+            tcg_gen_sari(type, t1, t1, width - 16);     /* t1 = ssb. */
+        } else if (flags & TCG_BSWAP_OZ) {
+            tcg_gen_ext8u(type, t1, src);               /* t1 = ...b */
+            tcg_gen_shli(type, t1, t1, 8);              /* t1 = ..b. */
+        } else {
+            tcg_gen_shli(type, t1, src, 8);             /* t1 = xab. */
+        }
+
+        tcg_gen_or(type, dst, t0, t1);                  /* ret = ..ba (OZ) */
+                                                        /*     = ssba (OS) */
+                                                        /*     = xaba (0)  */
+    }
+}
+
 void tcg_gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
@@ -1295,49 +1329,6 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
     tcg_temp_free_i64(t1);
 }
 
-/*
- * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
- *
- * Byte pattern: xxab -> yyba
- *
- * With TCG_BSWAP_IZ, x == zero, else undefined.
- * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
- */
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags)
-{
-    /* Only one extension flag may be present. */
-    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-
-    if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3i_i32(INDEX_op_bswap16, ret, arg, flags);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-
-                                            /* arg = ..ab (IZ) xxab (!IZ) */
-        tcg_gen_shri_i32(t0, arg, 8);       /*  t0 = ...a (IZ) .xxa (!IZ) */
-        if (!(flags & TCG_BSWAP_IZ)) {
-            tcg_gen_ext8u_i32(t0, t0);      /*  t0 = ...a */
-        }
-
-        if (flags & TCG_BSWAP_OS) {
-            tcg_gen_shli_i32(t1, arg, 24);  /*  t1 = b... */
-            tcg_gen_sari_i32(t1, t1, 16);   /*  t1 = ssb. */
-        } else if (flags & TCG_BSWAP_OZ) {
-            tcg_gen_ext8u_i32(t1, arg);     /*  t1 = ...b */
-            tcg_gen_shli_i32(t1, t1, 8);    /*  t1 = ..b. */
-        } else {
-            tcg_gen_shli_i32(t1, arg, 8);   /*  t1 = xab. */
-        }
-
-        tcg_gen_or_i32(ret, t0, t1);        /* ret = ..ba (OZ) */
-                                            /*     = ssba (OS) */
-                                            /*     = xaba (no flag) */
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 /*
  * bswap32_i32: 32-bit byte swap on a 32-bit value.
  *
@@ -1496,49 +1487,6 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_extract_i64(ret, arg, 0, 32);
 }
 
-/*
- * bswap16_i64: 16-bit byte swap on the low bits of a 64-bit value.
- *
- * Byte pattern: xxxxxxxxab -> yyyyyyyyba
- *
- * With TCG_BSWAP_IZ, x == zero, else undefined.
- * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
- */
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
-{
-    /* Only one extension flag may be present. */
-    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-
-    if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3i_i64(INDEX_op_bswap16, ret, arg, flags);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-
-                                            /* arg = ......ab or xxxxxxab */
-        tcg_gen_shri_i64(t0, arg, 8);       /*  t0 = .......a or .xxxxxxa */
-        if (!(flags & TCG_BSWAP_IZ)) {
-            tcg_gen_ext8u_i64(t0, t0);      /*  t0 = .......a */
-        }
-
-        if (flags & TCG_BSWAP_OS) {
-            tcg_gen_shli_i64(t1, arg, 56);  /*  t1 = b....... */
-            tcg_gen_sari_i64(t1, t1, 48);   /*  t1 = ssssssb. */
-        } else if (flags & TCG_BSWAP_OZ) {
-            tcg_gen_ext8u_i64(t1, arg);     /*  t1 = .......b */
-            tcg_gen_shli_i64(t1, t1, 8);    /*  t1 = ......b. */
-        } else {
-            tcg_gen_shli_i64(t1, arg, 8);   /*  t1 = xxxxxab. */
-        }
-
-        tcg_gen_or_i64(ret, t0, t1);        /* ret = ......ba (OZ) */
-                                            /*       ssssssba (OS) */
-                                            /*       xxxxxaba (no flag) */
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 /*
  * bswap32_i64: 32-bit byte swap on the low bits of a 64-bit value.
  *
-- 
2.53.0


