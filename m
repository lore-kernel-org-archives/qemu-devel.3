Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C37C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklE-00035Z-9f; Sun, 27 Sep 2026 05:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkR-0002UA-7A
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:39 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkO-0007Rt-DD
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:38 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0d31bda43so887478a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499635; x=1791104435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BJ57psSYHWNWI6fj8S3dJ22ZiJkk9GpcWBSEPb21LyE=;
 b=edilv/W2uaj1g7fAtmvvKHWo75rbNKK3d9IwEqV3dEzde4oEMUgyZY/AkB1xO/tcXy
 uu32R2pQ2wg2ODZPhxxRATAKeTAOME/cigaxD5zoivK5QW/Dr0RI4qnAWD0IU/zFemGD
 c3fZM3GPiZAvwxWlhA3dNQ/nIR0BlRLVhQnCpOq8SOOH3c5CqlkJyfTQugBZzSbY8wia
 OLsYg5s9GIljB5CPOQmVwZNXwbegMg2amk8qZSLwdJJA9LhctAEG/7gTYFW/EppG73Ba
 fO6u2EmfYcLhkzyEg3Bb+NX5N3c7cGdIdezSHyOHZdg6IO3jBV9xD8ZLa3DRQfDGQ+jQ
 coWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499635; x=1791104435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BJ57psSYHWNWI6fj8S3dJ22ZiJkk9GpcWBSEPb21LyE=;
 b=P32xstDfrmdbHX3nMaXtQa9gDb75sf8gvY4grbm/1muwIgfb/2boV8+/9bWmo5RF9K
 vUmY6umZ+ptv1p2qky6OVm7iLWyG5RbC1dw9BeHysHEYIyCa1kyoqZfEEMXk+rFAks5R
 0y75vkYMzNlRqdHa1t11heRRbhf3QHt6VtfxdDaeOeDXDJTg+rLmkpJ2/N9C72INzHnO
 cUn6Tx64xLAO1eJhBO+BqMKtXK8ibCgRDh6aJZIXA2bPpcgNcwuEID+0D3417P5m/NQK
 /DQdytG4nH+4nK96yV16WvbnjbspQ8ZaDc2I1YGGVQDZ+O1ZiENx1Y+QjIR/81kRSlzj
 r6Sw==
X-Gm-Message-State: AFq9FYJpJ0KEf02Kpgxn42qWbMNpOJjzDh603qWKQr05/MJQVYJi+9uA
 eU5xIiCy5Gf3xZbN6CGBYt9DbudWsvSntiwnqChEk9cszygQ6Pu6T97drxxPnCfvmiUHpaGyx1I
 nA0DC
X-Gm-Gg: AYBFou2rpwximaNR713UapQxX3n2XoPTQh5mBNnM76jrthDr/OypZKVJq21cSfJ15X1
 mCCVkfyDJvu8ophtySTnHje/oFGl67cm3a5PZSkW5eqhrwlcOFmnj3mwKtSJZvq3Ib0XGfXmHKH
 c8skWp/pZ7IBEYuAO+z/fFEaFNAN0Y0aJXP36kybIXqT3pglbWT3ypUx1S+P9ZcM0n2theYGFWe
 b/aV3bP7Nw1ojXM6yeiM9cflafSLO2gZEwK9bvaKFEgvS+sSCYD+zUIFI5jLDtLwmVpjX1FAA3e
 KKKaEMSKhnUvuc2Q41tzJfnFYSv8Y2dXwNP9WQjho3FUMKuHEjfKexPU8cGop+1t5JiCFTUBg1P
 hILHO0P0/WxBw1toBcijISwlmVq+TQbu2E3zXHHH0lx5yTPk3FFYriMnEwHprGPRjsQAakhKtyV
 B26dQXtLty7iFJ6XToieZJqltNMAMGcXoniPB33Cm7+vSqjnQVgV25p0U2Muyb/ROqN1e+S8T4W
 foERgB7OY+f+7AK0rDDLMJFQGxSuA==
X-Received: by 2002:a17:90b:3843:b0:3a0:e4ce:31fd with SMTP id
 98e67ed59e1d1-3a0e4ce57f5mr2913226a91.10.1790499634946; 
 Sun, 27 Sep 2026 02:00:34 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 023/101] tcg: Generic expansion of tcg_gen_sar_*
Date: Sun, 27 Sep 2026 01:58:53 -0700
Message-ID: <20260927090011.10724-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 5d72c92534d..a78752e0427 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -312,7 +311,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 /* Size changing operations.  */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 573a4963b4f..96bd6abd74d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index dc1734b7584..065e37b34f7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -409,6 +409,11 @@ void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
+}
+
 void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -530,11 +535,6 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_sar, ret, arg1, arg2);
-}
-
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
-}
-
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-- 
2.53.0


