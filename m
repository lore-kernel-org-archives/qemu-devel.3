Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901FEC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nq-0002U3-S8; Thu, 17 Sep 2026 00:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nL-0001V9-M8
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:24 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nH-0007Dd-RA
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:22 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb751so323491a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619538; x=1790224338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uOfMS7qrYhZaWjxyr4L4+3ETjJs54g76uVDGzRGsGoU=;
 b=un5HDpFb4fEF87eN7c3ry2rOYNePo3J0qHPm3EnBc3CWPu1asqb/12hPzSDid6pa13
 ZSvpKws6tZEFcLW1cv8QHUgf6axSUgEQrj+Pcm2oBPwhdI3k6dkRsdSN/3F7a25lIv65
 OyfSFk0Auem2DRu8DxvI4S8WiFc23vc+fJeik8TdrszXmLu9KwOUTHnb25tzkTuBi514
 wt/VF/g1iGUtNqOSPMgZ5uXn4t2bsH0fO8AO+9QLmXr/w5ko5wnQfqW7usKF1OwqwRYx
 G4tZKzCTWRrAdemYe0Nmt6XY0DIA1XE0na1SInk7M1eKadvRDXR/OlKOYiHPDg2Giad8
 rNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619538; x=1790224338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uOfMS7qrYhZaWjxyr4L4+3ETjJs54g76uVDGzRGsGoU=;
 b=Cn7CKh/7ee3GXnt7dpAHYy8Yt9unslRD67BocjUQlISknm5RUiLHeU7wdm+dqRB22P
 RVdNjRfwJ2w5hbd3m0D/0tv3WOlZF/rzQQh+AGUg1EknkJX15aGPQJo/vCiFvU/Bq4r+
 xjjPQUclR8qiPc6bwaY1Zxvx72jeXFvAZBA6qQzfSwEyxQoiGIAkv2UKDF+OL1cZSw7R
 YKRVDZbClhu9A7aZNCVNz42yxQcq4NcMBAw9+ndBFsb9dMo31f/fJSrorLnF1RvQjcca
 Em+TFrNwysEqPvWQXn0wSEDfiScKxMVEzn9HBNW2LrJcez5Js2FtYJR2qEiBuBXxNjsN
 UYfg==
X-Gm-Message-State: AFuF++lrZ4KgmMEU1chTDOb1GfJ+FJQplxBhw3CLcwrvehY/a2nY7R80
 E17Q+ix8GwboYgQvMKduCMcy8Gcifk69mG52PxZjnLSKFsrqOgdIl9EHeC/Q/Ajvwoyvj6f5bK6
 T0REY
X-Gm-Gg: AYBFou3KYAZVL0sDoEIPcAHsEFolO86IFhiDioAoCfU6qJRfSuGgtBVCU3Rh5hUTD1U
 7QiIDbPyZCNneiUEm8IHxNVV11A6dVckyXvWM7PfrnJTuCD576Qrjl4kXsGGMh0+7pgn7j0tlOz
 notz1KEpNp9fffLaQsVO/74o7qhkAdra88usFxY/yJCw/9YIloI00LZ9qZBJo481hNpUnu7Dwf+
 W1EsfL8dulkzdZ56jMmhULEsisHC2Bu7H0H+6+qn5eISxQJGWIuW/G1eKS0MTRFCHHd2ulhEuJU
 5FY/2RqGdOEZxM8tjPFM0y+id6bNo2jMCl1k0uEM765aaJ98JpV7qgawW5/2V08Ia01QY+iUzeV
 jgJ96R38FgyzpBbmzy4JsNNdCB4UV2fhsp4SwBQY+FOCJy1rHwJOBTiqdePyQcdvqiulqrvSquk
 ifg82bcEi3cYbZYNSAHkp/4Wbfz7PnFn459PN0HAzs4Y1xWAYMvs0kMxQem8gkAVMRM7hS2LVfD
 gemBI0=
X-Received: by 2002:a17:90b:2748:b0:39d:f06f:79be with SMTP id
 98e67ed59e1d1-39e1e4649camr16668571a91.15.1789619538326; 
 Wed, 16 Sep 2026 21:32:18 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 049/101] tcg: Generic expansion of tcg_gen_movcond_*
Date: Wed, 16 Sep 2026 18:27:31 -1000
Message-ID: <20260917042823.542588-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  7 ++--
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 70 ++++++++++++++++--------------------
 3 files changed, 34 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9834a70cac9..4d660ca2db8 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -100,6 +100,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4);
+#define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4, T5, T6);
 
 #define TCGV  glue(TCGv,TEXT)
 #define TEXT  _i32
@@ -123,6 +125,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF6
 
 /* 32 bit ops */
 
@@ -146,8 +149,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
-                         TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -209,8 +210,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
-                         TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a620c8ad69a..26583254111 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -13,6 +13,7 @@ DEF3(divu, TCGV, TCGV, TCGV)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 334e5569e09..9cddfd370ff 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -135,6 +135,14 @@ static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                        temp_arg(t3), temp_arg(t4));
 }
 
+static TCGOp *gen_op_ttttti(TCGOpcode opc, TCGType type,
+                            TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                            TCGTemp *t3, TCGTemp *t4, TCGArg a5)
+{
+    return tcg_gen_op6(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2),
+                       temp_arg(t3), temp_arg(t4), a5);
+}
+
 /*
  * With CONFIG_DEBUG_TCG, tcgv_*_tmp via tcgv_*_arg, is an out-of-line
  * assertion check.  Force tail calls to avoid too much code expansion.
@@ -256,22 +264,6 @@ static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4, a5);
 }
 
-static void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                 TCGv_i32 a3, TCGv_i32 a4,
-                                 TCGv_i32 a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5), a6);
-}
-
-static void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                 TCGv_i64 a3, TCGv_i64 a4,
-                                 TCGv_i64 a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -334,6 +326,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4);
+#define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
+    QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
 #define TCGV  TCGTemp *
 #define TINT  int64_t
@@ -347,6 +341,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF6
 
 /*
  * Templated operations.
@@ -369,6 +364,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),                  \
                  glue(C_,T3)(c), glue(C_,T4)(d)); }
 
+#define DEF6(NAME, T1, T2, T3, T4, T5, T6)                              \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f) \
+    { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c),  \
+                 glue(C_,T4)(d), glue(C_,T5)(e), glue(C_,T6)(f)); }
+
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
@@ -408,6 +408,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF1
 #undef DEF2
 #undef DEF3
+#undef DEF4
+#undef DEF6
 
 /*
  * Generic expansions for templated operations.
@@ -544,6 +546,18 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+static void gen_movcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                        TCGTemp *c1, TCGTemp *c2, TCGTemp *v1, TCGTemp *v2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        gen_mov(type, dst, v1);
+    } else if (cond == TCG_COND_NEVER) {
+        gen_mov(type, dst, v2);
+    } else {
+        gen_op_ttttti(INDEX_op_movcond, type, dst, c1, c2, v1, v2, cond);
+    }
+}
+
 static void gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
@@ -1092,18 +1106,6 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
     }
 }
 
-void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
-                         TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_mov_i32(ret, v1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_mov_i32(ret, v2);
-    } else {
-        tcg_gen_op6i_i32(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
-    }
-}
-
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -2017,18 +2019,6 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
     }
 }
 
-void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
-                         TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_mov_i64(ret, v1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_mov_i64(ret, v2);
-    } else {
-        tcg_gen_op6i_i64(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
-    }
-}
-
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.53.0


