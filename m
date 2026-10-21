Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10DA606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K5Mag+g4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXFy-00050P-7F; Wed, 21 Oct 2026 10:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDO-0001a4-WD
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:52 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDM-00029v-8y
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:50 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so5923345e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592558; x=1793197358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xrDgB4CJo9L1swHUB3PEV8QUImMjLOeS5km/HzXeaDg=;
 b=K5Mag+g4kOoB9jP7IMj63JC1z4knaSfsmFM28BHoy6viz/kJNH0tNk7xiMyO6f3iDx
 Iv/We7VLNtxSfZjUr/Juqe3lKANa3BJeYwiSg+FMtKPZCuLE2hmPW//PkHrPm/GD3DZy
 aEHGiFpCpd0EhTZQZTSKdRtrMFXQCHpjbSqAaF3xdwlBZaD+/UtZPHENKmNHjvivYOQR
 /RRfxb0gIcrfEdxmjsfto2IBy8tkXFdu+V65mlBo5OZUHZZZqKVhgV6sldEo/wbqnHY5
 9w656EDafS6fzOjiyvC67jI8ZsY5iO0AorPvOd34kqTD2DQ8+ZCd6sQiAlHgzANVfZXb
 /mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592558; x=1793197358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xrDgB4CJo9L1swHUB3PEV8QUImMjLOeS5km/HzXeaDg=;
 b=BIyb5G/1JzN4aUXCObSJB9cYkFdkUXUQUk9LYC37AbUeoDAhIVLWI4rAKY6q/cM4Jt
 5sLHPimVyn6OcWIbJoNQ4PZwjOSjNfA3tuwKhGDsS25hjhWChzmM6123fmAK3LAu1Jy7
 iI4Rg7lQkCjxXhrSZiNw0rjK00XikJZp8B9jKxlsSG6IvcNqdNwp0Dzvj35IZyQHsIqC
 QHQxvM2paEngzXK2wHBT9I837iB+VdPi9qWWKK6WTYSWTCWm/suJzMYssQDHY2PXcyzH
 zycIw2zMke0fvMsFosk+d/D1k8kGShdt+yIBiCUuCmXtxl2YAA2brHXRyYXlTpQYvSBF
 SNXw==
X-Gm-Message-State: AFq9FYJpBzJY8kmTcp0oKKg4lgbW3wC5yHVRQPJppv/KlTAYREelQIKh
 A/gKMkJvWDNudn8pG5G7boqzqcim9UCYj/wwzHSCo0ZXhaj0FYVZhdk7XYDU4aiuU60ZpdKPmTQ
 FLxtfxuM=
X-Gm-Gg: AYBFou0HNOnQlxExdgHEoWzzCrZrwS07cEJnqnf7JtUURubkPuSety7yJQxyEHdzz+u
 NAEIX6qqsRjBMyVY075mOh7hUS0zDPvxgjo42quPaV3XIPQMTk9khvv4eZw1Myz68GWm3JsqD5z
 dOWLLQ3kpf/J4vUGbq6z8kNDNxoS2iQtXaPmQ5kqYGLfh1Io4fhIe0Xkile0oyoCiFY0yv0KwoV
 JJZWcdg2EzF56GCo4OyIvJBik/HerE5cM2OOyc5lq4ETniS1qyp/N2B7Wj0D3CA7GZ6IrtGp2eT
 y0tPMSr7vZTX49AnFyxuOfH3Vz4UFKws2NjKY/f5xfN3QvhxpfD/tPiTz16P7zRpVor5u5yyoV+
 c7UNOwGPtz34gXPhY37OCbyYYKreYyAS7M5ICh1JtCDjiPeqDT94BK3Xu5pSUlhFqHfm1yP3sdA
 zX9/ZK2dkd01FN4oiyU9pOhNV79YjAyTQUJHwW6pucf6Nu7TanMrjiqJ3eQB76y+njblQ1Tf7VZ
 jA9kK9JtN7Yx48w7Mdnzb+tnrFcaPPkLhAQyQAH0SGj2gTbvD7XlTOUjINXmG4W8h3tLPeN0wXG
 sv8h8rjXE19l45LH4CLxEYkPLhyf
X-Received: by 2002:a05:600d:102:b0:4a0:1efa:c74a with SMTP id
 5b1f17b1804b1-4a1fdd23439mr28659105e9.20.1792592557889; 
 Wed, 21 Oct 2026 07:22:37 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 058/100] tcg: Generic expansion of tcg_gen_rotr_*
Date: Wed, 21 Oct 2026 16:16:10 +0200
Message-ID: <20261021141652.363109-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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
 tcg/tcg-op.c                 | 62 ++++++++++++------------------------
 3 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e653c12a18..2d05728a88 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,7 +130,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
@@ -184,7 +183,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f832e286ab..84ef1d5378 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
+DEF3(rotr, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 97acd9ebc8..5a85dfbf70 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -764,6 +764,26 @@ void tcg_gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_rotr, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_neg(type, tmp, src2);
+        tcg_gen_op_ttt(INDEX_op_rotl, type, dst, src1, tmp);
+    } else {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        tcg_gen_shr(type, t0, src1, src2);
+        tcg_gen_neg(type, t1, src2);
+        tcg_gen_shl(type, t1, src1, t1);
+        tcg_gen_or(type, dst, t0, t1);
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -877,27 +897,6 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t0, arg2);
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shr_i32(t0, arg1, arg2);
-        tcg_gen_neg_i32(t1, arg2);
-        tcg_gen_shl_i32(t1, arg1, t1);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1687,27 +1686,6 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t0, arg2);
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shr_i64(t0, arg1, arg2);
-        tcg_gen_neg_i64(t1, arg2);
-        tcg_gen_shl_i64(t1, arg1, t1);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


