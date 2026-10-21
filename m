Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FD1606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nywQkDA8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXDw-0002L0-Iu; Wed, 21 Oct 2026 10:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDO-0001a3-VY
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:52 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDI-00029j-9q
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:49 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso564507f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592555; x=1793197355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2aLWdxF9M/H4ymWy+D50HLcFuENLQhrbVkmGtwhLneA=;
 b=nywQkDA8DQ1Q47/Afx+/yFM9jW4FtbXIM2KZrVffGfRYVh+pDTqlceeuk3Phj6mnKM
 mFBkl3caVUz3cg865zeQh0bg0ObV8cGKQJgDMRtgfyRhz8WxVIelYf1v16GsLFmPe9fs
 9v4ixPU+07nc9Xu6UuwIOYUcEY9NUzfj/ERZqYTpqmKlAAYLL3S5y+sSEXJNvmihgx89
 /RgtD52P3S98fpDsmxgkWKbPrzpcLYirG8LZ/DunBGvSkKGOeLKfDOv8jTfI2D/e2BM+
 bT+THNcRdepvnM/IFzHjHo5ZWbvv+hu3G8H/c/6tU+GwL84F3d/oCpNOtwauoec2MkCS
 9mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592555; x=1793197355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2aLWdxF9M/H4ymWy+D50HLcFuENLQhrbVkmGtwhLneA=;
 b=xY8bojfI8yOUYuT7kvvcOpinsi2i/UhvVPyGxGqyrhWnBlt7SQj8OkLtqv0LOgYFk0
 bF8PNpgCx1TSm4WHzTrBvtRono0PXrTKvVT1MXlRvq+7/YBHrIN2MdadDq1XpYoFUy3k
 B+ulv3Ppa/AcbdFmVvrx/rxQJoBPCiXsOG8E4rPA/AFb824zF2YKE156rU8EpP04HYgD
 k0Zfk1Yy87dH88GMbUFAfVeaAai2UJAZq/Aq1YSddD9xmlR443st65NRjfRU/ZJZ59gb
 A9Daht1KNnp7AZv3gLIIPcRrjArOlPLHKqUb9nAp+vbRwvuFTDxTdR+e9r5shu0No4Es
 NGJA==
X-Gm-Message-State: AFq9FYLDmV4DaGmBdSruNOOQmto3p0UxROUFwkWc8F+tm3Nk8lJx/5k8
 gJh48CmWJgHVZjNGAnUNwgb/Mz/V1lFogvG0dJrEZug4pxxWBF9m0Xo3cd0h0Q/+bowgx0s89nQ
 WXYIfi0g=
X-Gm-Gg: AYBFou048MZKHyyFbRglFXY5N9N9RicnuQ06VdTpizfhlHGA3lb3I3lySZ60aP7hRV5
 0sH9R9Id0q+b9eci+QI2feeMGDuCyDfnu+1OdXOHh3i+7ynHbpTywt4XbFpIIyKY0xT9U4SRWXg
 mXN3x4lQPcJceC7ULQDvBFGy2qUmd8W9SEgOrG41IONCEkmSR0nU3L50kEHh7RkAsqIO9GmTZH7
 8bzsxRehMruYPUGKsnvaYUEH9MTT4wR3eNBWXbtALiTYt5oRnRP37+/s5DkkP1YqOdDHzkY6S2P
 mv6MpJTlMm0w4XYDYwXhvKatVQ6dyhj34elzASNAN1bbxOcZEVE7y2qKd0zzvtY5kim9Oyfrmyx
 S8V2x0Ok9nsfVx4qM7t5wf5MJJkrXW0bVYldBjqk2DI7NooH7C4CT2VdzuwAhvQ/q63HNYmf/40
 n3M8wTAM+n12rl6biWH2mYidFuNAPUL7WH7QlSGJ4xI/H+QgmO3UBRXuzwOY6FMQvR/pKTSM25n
 nYnRjYWtyJ9MnKQWJGN/O/zar4hsgZ+DTJJQIUr8SX64OFjqWrkqmSnE27acbbbvXY6glTZFJLr
 Ahfr5bWgBu+f1QSc/yx94antXn0=
X-Received: by 2002:a05:6000:2f8a:b0:485:8c17:9764 with SMTP id
 ffacd0b85a97d-48e264d3f83mr4381829f8f.38.1792592554922; 
 Wed, 21 Oct 2026 07:22:34 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 056/100] tcg: Generic expansion of tcg_gen_clrsb_*
Date: Wed, 21 Oct 2026 16:16:08 +0200
Message-ID: <20261021141652.363109-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 45 ++++++++++++++----------------------
 3 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b1a66149b5..b1448f8c08 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -185,7 +184,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7ee00c9d53..ef0ac5aece 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF2(clrsb, TCGV, TCGV)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 476b8bbdfa..97673524d1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -422,6 +422,23 @@ void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+void tcg_gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+        int width = tcg_type_bits(type);
+
+        tcg_gen_sari(type, tmp, src, width - 1);
+        tcg_gen_xor(type, tmp, tmp, src);
+        tcg_gen_clzi(type, tmp, tmp, width);
+        tcg_gen_addi(type, dst, tmp, -1);
+    } else if (type == TCG_TYPE_I32) {
+        gen_helper_clrsb_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    } else {
+        gen_helper_clrsb_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    }
+}
+
 void tcg_gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_clz, type, 0)) {
@@ -828,20 +845,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t, arg, 31);
-        tcg_gen_xor_i32(t, t, arg);
-        tcg_gen_clzi_i32(t, t, 32);
-        tcg_gen_subi_i32(ret, t, 1);
-        tcg_temp_free_i32(t);
-    } else {
-        gen_helper_clrsb_i32(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1673,20 +1676,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t, arg, 63);
-        tcg_gen_xor_i64(t, t, arg);
-        tcg_gen_clzi_i64(t, t, 64);
-        tcg_gen_subi_i64(ret, t, 1);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_clrsb_i64(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


