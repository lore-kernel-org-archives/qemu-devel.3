Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67541C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L53-0000Rp-VV; Sat, 12 Sep 2026 06:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4v-0008OG-So
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:26 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4p-0008Jz-6q
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:23 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747f0135fso3532375ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209315; x=1789814115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0KddhULANJ4WqNTJtfE7QeDxVaaRiDfRvEfe9LeQwBY=;
 b=VmlPRcXCT6dTlJdkBJKd/C+LtsBfogOpUvGrX9+8bXgp6KqujWH5LbFTZPoE/+Kbg2
 Lep1KWr8iUXuS/UaL2NCQ13pKkgK3UoByqroJlcQwpQN5bOBhB3FbPWQzydfV+d1VsO3
 c4/+X+rNn8kwt0AQfnTWktPSEWzKCyxqbjZvKWb8EEJOwdv9oN5NTX9z5fIrDxh7pJxF
 UOWY0y5sICPmXeEntvyv4+MG2DqJ8FF0TokaXqY8DQkzlDhkCPA7xY3fHLLBGuBud0CV
 A3ODeTm9aueG4hQn1W1CCm7CSjXwZYL5eYNk/RCr/bu5VyqlUHL2ytVVV+C5BFtvUYwG
 x9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209315; x=1789814115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0KddhULANJ4WqNTJtfE7QeDxVaaRiDfRvEfe9LeQwBY=;
 b=KnAtszaVfakLbyhX4Z76l3mKKnyN6F5w0DsDvumw+j1lDSqf39wgwsdkKgQwojwZ0h
 pkOaY39ZypytheSvXJ1T+YiCrmVjtVDyVUokiZS5fM3PHLPwb3mkAUYV90K2kVc5lP9f
 SZG5JV5//URTv5csdX3AQc111h+Z3cXC16AYna+SpSmOXk0PLoSlyw7fkAxzy/Lc1Nbw
 Q/0rmOl23QtOQR84JpdmS0U/8ccHa+CrQLZ0Dq+ZKG2uWYaqNnBscbQhWf0tv63Bf0d2
 MKIb+Ec/edSnKOLb1QEw8bZjE5uX3CwpSJDoU2Y8dFhC6pLvx5mKfY5AV1uf2mRhalxy
 9iew==
X-Gm-Message-State: AFuF++muOneLy7t9jblCL1bw/GDvJ6T/5we0dTwdOMH8zgbPTYNXtGRL
 i20XwC9NaeacCobqyTCrE6JUcTNviI/LkPWOyOKmghhZKrzruB8CVWADhjbf0wjm81TeF6XBSqu
 SX1IRauQ=
X-Gm-Gg: AYBFou0taEohx2KfjzsACFUPL5MaX914hcFlI8wgzmOKFOQVgNNqnCNvgZqrrdgMOf5
 fsvfvmamuONuq5my7DboLG/Nzqx2+PBmf2bSCp5tlL4VMaVIbLFYeREkNUdCbqC2mlvE/DWsQ9i
 TqEl6TnREGHLk8MGUaaQIVXs/Q3qck0UCpmurgw17bArm6MiHS7J6A5anaQRizEF5Y3YYODDc4H
 oE21aZezpxkb7NjTHnQPBbTtC1UiU/6kpuufi6gMe75hlcg+9SmhF6xCJ7wvETx3LKdBs6IaXFx
 uaUQIXVs+UglXaY8VMglhMZ7/upiYJqXG+pSZGLMitZ8yuyR9osYvdDTUWXVPRbiRt6yzFbszPO
 eMOYbo3n9tK2aA5cACi1GMzZZtyHuqmwjggeofp2H2LMVC0KsvPBgbccMQ7p5T69b3EmqZs1uDA
 ywfB8Yi6+BJTPqdy+PDo9/hirVg2lbawyACawE4vtR4GqSmmvyFzhLZjcQCPrTSqyH6RaQvyWe5
 g2HuXo=
X-Received: by 2002:a17:903:19e8:b0:2d9:599e:df95 with SMTP id
 d9443c01a7336-2dd4bc27c98mr37119605ad.3.1789209315326; 
 Sat, 12 Sep 2026 03:35:15 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 48/82] tcg: Generic expansion of tcg_gen_clz_*
Date: Sat, 12 Sep 2026 00:30:52 -1000
Message-ID: <20260912103126.598030-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 54 ++++++++++++++++-------------------
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 04fe772c1e0..62b8a579691 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -142,7 +142,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
@@ -203,7 +202,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index cbaaba72ffa..8538f7350aa 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -25,6 +25,7 @@ DEF_RRI(xori)
 DEF_RRR(add)
 DEF_RRR(and)
 DEF_RRR(andc)
+DEF_RRR(clz)
 DEF_RRR(div)
 DEF_RRR(divu)
 DEF_RRR(eqv)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 14bec6053db..217dc3409b8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -451,6 +451,31 @@ static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
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
+        TCGTemp *t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        TCGTemp *t2 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        gen_extu_i32_i64(t1, src1);
+        gen_extu_i32_i64(t2, src2);
+        gen_addi(TCG_TYPE_I64, t2, t2, 32);
+        gen_op_ttt(INDEX_op_clz, TCG_TYPE_I64, t1, t1, t2);
+        gen_extrl_i64_i32(dst, t1);
+        tcg_temp_free_internal(t1);
+        tcg_temp_free_internal(t2);
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
@@ -848,26 +873,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1789,15 +1794,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


