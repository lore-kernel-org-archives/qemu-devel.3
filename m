Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E33C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73ou-0004QM-Jv; Thu, 17 Sep 2026 00:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nQ-0001dU-Bz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:37 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nM-0007FO-L0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:26 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6b1ae7089c0so181313eaf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619543; x=1790224343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zK1r2cuJJiWvu9d/rixHsngXqn1PHxcTW+M441x+7hw=;
 b=wSE/2i94x5NrkSWjY+ZR8aTkSjBvBEsriu0F3lSkt6ym74pzf91G+spGuO5m1eRwns
 RbBH5paljvQd/qnCUbpR0TvADTRLpncvDaogMQyTpaQ8fFGlDWP60IsaTRskoQh3o+cx
 ytZqzOZxcQw6lC4lxxF/buhrM09SCiSWuChLeuu+FBfnbaD7gfJJXZsSZCipvFN8zq/F
 wVKYs4/nGNCAOR/ugfSonr3qqaoB29MYRMOQNqFB773JJ1WoKh/BRNKNj8MkJwznFklE
 I6aRCRt3ce93cSJZaamEV3vixCxvIfz8al1N/hTjA54Yvr38i+LJwwnoHP6Ea8a/x/tB
 deJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619543; x=1790224343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zK1r2cuJJiWvu9d/rixHsngXqn1PHxcTW+M441x+7hw=;
 b=YZu39UGWYiiIf7PVFYjYKXUfw5Qq4PCKiMNuJJZyVp8uOD/pl9p8ELD2+1l5FOnXk5
 rkjPDXmrYpiEMik63011qb0TkBe0Iwy7BV6T6zfJDwA1+Dtqs5yc7cCZ04sQsay4XbR9
 FYteeLJSRrJOSVVWgs3TZYN1tNFrhqd+t6bY3SRygo9f1q02dJ9KhaA4rzyNDXaZDBwR
 usouEhCu6+MppZfZSsbPpsYzIiLyc5wUPjaNy0JAX/dfgWHZCoPpzgAWpLOpMl7zNydl
 YesgSJHkHNf6JKvk4FG4WexU+2HC4QkckNJPAYeKwI5UdxoMCGtKwmun3XtVAR3/SpOP
 /hgw==
X-Gm-Message-State: AFuF++lrTt9hjHMk5X0a9r8O+Zhx/eXnwG0RuAiCJeLiaAS7uJ0SAQaK
 3aURV90I5kEXKaqeoeaZIW+HNnH2kZXrNrZMv0Hnur2DW7ZUt0/rZ9aN1BBW7QyJyRKnLOyOOA5
 xQ5CyBVk=
X-Gm-Gg: AYBFou0r0zLLZGuuZNlZ0oGvn2jxs8nq6evVJBQuicaTQDy2zUESM1FWkuujW/yccwA
 dJfAK39H+JFMisGmKmv9mG29RXxDW/djM6t/V8aC8X5NqUaEKGOespu3vol9D2har2JcYeXEiJP
 lPapGuwaqeP0Q2bwSbByV1/NCLNyvtxf2RuKKiXqOQLB6IigIZhS+VH2YTninxOcrIcZNFoZXcC
 1uVIq5rf3rR0GVjbXnyPIYGpEdogBuNWWgwmWmZiDuzM6fqTzIkVu0/uRMVbgj6Ss9DTnDQSJLa
 iG/B5sNRCwt7eRdZNyxZNAHQoUT9Q4sv3DFno9dwjLTD+aZhpvVf9shRdMg0+KQdMgRCxMnVUHe
 xXMMn9lLAut9WPYS6kSx+MU3MCKg1jpL9lRGMsssLGCzo9Dh6U5L4H6TEajfx1QAAwbUfsFKqof
 FOTawr3qbFBqiMzYzL7hH71PqOlFfSKyaA9w2l/8v2EPX6d5FrDFWOx0yL33tFBha8S7IFEmPZe
 IfqyYQ=
X-Received: by 2002:a05:6820:4c8b:b0:6b7:8396:f3d6 with SMTP id
 006d021491bc7-6c7d42e49ecmr5213044eaf.56.1789619543043; 
 Wed, 16 Sep 2026 21:32:23 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 054/101] tcg: Generic expansion of tcg_gen_clz_*
Date: Wed, 16 Sep 2026 18:27:36 -1000
Message-ID: <20260917042823.542588-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0c.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 52 ++++++++++++++++--------------------
 3 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4d660ca2db8..d882bf5d0fc 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
@@ -190,7 +189,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 26583254111..202df7a62a8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF3(clz, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3453fa97b45..50d1b07d667 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -495,6 +495,29 @@ static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+static void gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_clz, type, 0)) {
+        gen_op_ttt(INDEX_op_clz, type, dst, src1, src2);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_clz_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src1),
+                           temp_tcgv_i64(src2));
+    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(TCG_TYPE_I64);
+        g_autoptr(TCGTemp) t2 = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        gen_extu_i32_i64(t1, src1);
+        gen_extu_i32_i64(t2, src2);
+        gen_addi(TCG_TYPE_I64, t2, t2, 32);
+        gen_op_ttt(INDEX_op_clz, TCG_TYPE_I64, t1, t1, t2);
+        gen_extrl_i64_i32(dst, t1);
+        gen_subi(TCG_TYPE_I32, dst, dst, 32);
+    } else {
+        gen_helper_clz_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src1),
+                           temp_tcgv_i32(src2));
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -822,26 +845,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_clz, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t1, arg1);
-        tcg_gen_extu_i32_i64(t2, arg2);
-        tcg_gen_addi_i64(t2, t2, 32);
-        tcg_gen_clz_i64(t1, t1, t2);
-        tcg_gen_extrl_i64_i32(ret, t1);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
-        tcg_gen_subi_i32(ret, ret, 32);
-    } else {
-        gen_helper_clz_i32(ret, arg1, arg2);
-    }
-}
-
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
     tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
@@ -1763,15 +1766,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_clz, ret, arg1, arg2);
-    } else {
-        gen_helper_clz_i64(ret, arg1, arg2);
-    }
-}
-
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
     tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
-- 
2.53.0


