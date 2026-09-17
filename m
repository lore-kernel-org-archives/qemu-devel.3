Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3851DC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kO-0003J4-Or; Thu, 17 Sep 2026 00:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0003Bn-RZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:00 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jm-0006n5-7u
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:46 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so356577a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619320; x=1790224120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SyocRgG0UfzspRA+5PY08nnvLtfyxVlX/4MO3LYTw6M=;
 b=CRE6VYEnNtjrvRwA2WJofDM//tWtT3CT3miR24NGIAtPKGFZtytwBe4JF0CemZwhtZ
 y28qIu1wXF37GDEmSYa3kQn8DHAGw8xQeHSjW81GPGaD2yaZ5QbgoQlxiYxs294iFt3u
 ragma83+5Te3UB6Fxhyxofs8kbUk7zvRzmeVinMQUghwsqi/uen1r8ujqlWH2pW8aZhV
 cT9K3/pQPBvtSflugSN7ogTGVS6dHThBWMBeVFToDSxewFoRj2EqEuP2hdpo9w3Wpysu
 2IL2+v8molpLYfL9AwrcTDUOg1lUngaw4wE33NSgQhhzqeRP7S6qjcThMPTPa3ML4iRO
 suVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619320; x=1790224120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SyocRgG0UfzspRA+5PY08nnvLtfyxVlX/4MO3LYTw6M=;
 b=2M9vIM+AOwO1Tg+0+X3UTmy+4u16yyUJjAVQg7AoLHqXKS/GUII7HRsb2r0vGctd5K
 /e+FaDLb1Y+3+IhZfGVZcmQ2iDO9JjCtiMQoGpSzQVwDhGprszH1zWXhnvIB9J1F+4o7
 5iZ8+qJPz4t72zjlQdjIxuxhfAKAGM7rFQ0vIH3l0TNIiZmoYKBya6eCtrCKlvnwoODl
 Px3/yID30XJXCg5+1+ArCo9D3zx+WOY/MKvlVOM9fT31qLXe6V0CaVpjyZ60D88E+zky
 SeQyhYH9yI2isckC99uX9S4hABvlYtdrFDDixf3hJpv6L+oMRXBdD/Q/GJ0pb2jG6WtZ
 VR9Q==
X-Gm-Message-State: AFuF++mSI9o5SSgcEutI2fevbZgU0GO5XHaCj4aMXWmA9QfV+y4v5X6R
 vZ/oiWK7s7u6jSzv22ld/21crbOHfWYZ6vleUb0fiXiPohmaRTOoEsV85nlDd3OkfgE6oUIbOK+
 AaFDimI0=
X-Gm-Gg: AYBFou2/mwAOUWKOudsQXhUc/Hf3RKH66eVTSf6He5pIKHJS/jB0lfzpXYq2ZXC7PEb
 Yk/+R8QnCm4qXA5SV4I2//x/s36x3LqXKpCdR90txCet3aKYnDFu53yeKZnKoMQzLse6/M0u0no
 /S4Cl2Wk2BeYFlBeelZR66kQydmyKlURihoKUt5IcpxEaLLxlUevONO9ZO5uNnYPMIn+rSeSMW/
 9yw9Xd7/fqXobgSGcTvt68su20JkWHO8HBz5Yzozl4SILsm+v9nCBrjHwskyI9yrqov3MOxYqPY
 EIW+/RB1yFfrnIrj2qkPVUhiuqEPDshBqSfrBtCF35nHslxgnYvEY1/y2ZGq3KbSF0rRAxQ08nG
 zHgu3IdupYzb3rTQFKHHqIESpP/7ljZKJm9x9XZi7pL6sSICr1pL3j1OZflN1pcB342/XsguRGq
 E2/Zyx63991Xy9soDS0Crb4TKJAfjvCtQt3XRWTWeOWxM61dojR/EhT13tiACiEnpjlfbu5HOQo
 QnGkyM=
X-Received: by 2002:a17:90b:510a:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-39e1e23d5efmr12266442a91.2.1789619319810; 
 Wed, 16 Sep 2026 21:28:39 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 012/101] tcg: Generic expansion of tcg_gen_add_*
Date: Wed, 16 Sep 2026 18:26:54 -1000
Message-ID: <20260917042823.542588-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
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
 include/tcg/tcg-op-common.h  |  5 +++--
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 29 +++++++++++++++++++----------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e1c87792a69..f1dfa4011b0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -96,6 +96,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2);
+#define DEF3(NAME, T1, T2, T3) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3);
 
 #define TCGV  glue(TCGv,TEXT)
 #define TEXT  _i32
@@ -117,6 +119,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 #undef DEF1
 #undef DEF2
+#undef DEF3
 
 /* 32 bit ops */
 
@@ -210,7 +213,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,7 +317,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 6ff97260dc6..deb3484fc60 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 
+DEF3(add, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a6072f362e3..9846cb13331 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -109,6 +109,12 @@ static void gen_op_tt(TCGOpcode opc, TCGType type, TCGTemp *t0, TCGTemp *t1)
     tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
 }
 
+static TCGOp *gen_op_ttt(TCGOpcode opc, TCGType type,
+                         TCGTemp *t0, TCGTemp *t1, TCGTemp *t2)
+{
+    return tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2));
+}
+
 /*
  * With CONFIG_DEBUG_TCG, tcgv_*_tmp via tcgv_*_arg, is an out-of-line
  * assertion check.  Force tail calls to avoid too much code expansion.
@@ -318,6 +324,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2);
+#define DEF3(NAME, T1, T2, T3) \
+    QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3);
 
 #define TCGV  TCGTemp *
 #define TINT  int64_t
@@ -329,6 +337,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #undef DEF1
 #undef DEF2
+#undef DEF3
 
 /*
  * Templated operations.
@@ -342,6 +351,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b)                     \
     { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b)); }
 
+#define DEF3(NAME, T1, T2, T3)                                          \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b, T3 c)               \
+    { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c)); }
+
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
@@ -376,6 +389,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #undef DEF1
 #undef DEF2
+#undef DEF3
 
 /*
  * Generic expansions for templated operations.
@@ -383,6 +397,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * are of the proper type.
  */
 
+static void gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -402,11 +421,6 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
-}
-
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* some cases can be optimized here */
@@ -1514,11 +1528,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_add, ret, arg1, arg2);
-}
-
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
-- 
2.53.0


