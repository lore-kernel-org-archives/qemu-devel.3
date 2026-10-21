Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C593606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xxXKr6lm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX9f-0004ue-Vg; Wed, 21 Oct 2026 10:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8y-0004aQ-M4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8w-0001ZC-VS
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:16 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1e477fe16so4801795e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592292; x=1793197092; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FhLeqSTFgBhL6CTrpkkGMTM1A7absuCQP5gVpOHI1bE=;
 b=xxXKr6lmOpf9IZFYMd49gWisUaKW3etecT0P49aRL6xrYlqau0AAkPX8GTU6TZJZZ0
 8xY32whxmEjJ0wqVvExuD5jQewe2mo9eHdCGNHkCYbbogtDNfb3n9cMlvomLbWGsK0RG
 82PME8WwDeVxvlF23vj8d3g7Kkzto3atZisvbH2txq6N8mu0iq1Rtd58DkS1HvKGbgXZ
 HfA4rg0aNx3+/Yv3RTf1zA21bZ9ZYTgNcw32t8LBsYuDYAxd4c5Pg9D+RhEOCisNfFBq
 u1vKy4JT7RTmS/7nJlgRsZa5t6LOTjtIVFsGoRnUqTeGnwW2oRdfJPKJLD5+bFGxXiv7
 uOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592292; x=1793197092;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FhLeqSTFgBhL6CTrpkkGMTM1A7absuCQP5gVpOHI1bE=;
 b=OYxRU9b/wPJY6VvHxtITXQlUiEH9aMJUhfT218S60g01nneVZdTbjk1kCGMA2xNU3q
 a6Hrfg3Q/EO5mJNNCVdvuA9wP6IdHYQ4lBG76H7CqNyJe6wcf6jwEojSjoFMvqRNZWjg
 Jx0TeMipWG7ZBgiPWzPfky1NUwcz3zAlmvdIOFiOXrYxKE6aoSTppISDI2nthxDRayWE
 a0djWgi4+kPgeAlk4smDrnN5rKy/BNZds/RQE3UpmqwFY8jv8nchX6TkmN90q5wGG2bX
 bpZrZa1qgeYTbK8/QZN/mIcquM0eQjfLw7l9a0WL3XAM6c46GsCzaJnuEGYYFpPpJoUC
 ir5w==
X-Gm-Message-State: AFq9FYKmlcJQOyckqte8za4UgtBvur4RiTnjH306PnV13VtK0NEbW50w
 +MU6BA7IQJFbfSqyPc4bdemOK5ASkCfLbRb9Wys3naWIH4axmGvMXulR40gUzxy+vs3nwyYtknQ
 lPWf93I4=
X-Gm-Gg: AYBFou1wKgyRrfvbP5scG7ncviHYPjCD5m7r6zzRFAHnzVwr6u9vzPRhJE8wKhoEwb0
 WhRFPUYFpWM8lnIF7WrNZH2oLfNB/rVDCbhQhQ8oJMosORdy5NknvXTdVNBhB2+IGjFr6EUUPGf
 6tfajXv/IaMo21+wsIohREusnSkSiML2pVXRbT0z9uTpey8oFn6gfbmdQTYi+VnXmvAJwncGkFn
 iSV7+r/yNGoyZOWZ3LUvg8A/ZJnJBg5sZYeRZef5/FIikGdJZIQROxQ43bsgJOim6IDyEy+wKrb
 YBpK59wmbyeencd9uVtVRBGNTBzxvOAk8VNyiagHxcHAbb+IUDklCq4uyOG3eSSytrBCr6IJBqc
 uxAcUzDDBWs8vzvMsDFo74qFX5BGyPWIH3/6rMDl2Vfcb9F+ii0upaklRvKfoUtGhsTNcMwx8Zu
 HMoVqupFdQ/G82MRFIHnFyua5K9BqozK7ElStuT6xedpk2OCxQ1m7NzUYlltIxf2B6rhWrGYtWb
 tZfvbsE8nRRTsw+0YxzEb+C0YkoqQaqfljohy2bErnhe9DZW6CHt2bF1OaKgfw0a+4L+v/0QE06
 oB8sg+wAcs8qaNcEoo+XQHMxBIs=
X-Received: by 2002:a05:600c:34c4:b0:4a2:1a:a10a with SMTP id
 5b1f17b1804b1-4a2001aa275mr35138265e9.29.1792592291518; 
 Wed, 21 Oct 2026 07:18:11 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 019/100] tcg: Generic expansion of tcg_gen_shl_*
Date: Wed, 21 Oct 2026 16:15:31 +0200
Message-ID: <20261021141652.363109-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7ff99a7671..e1c59b1915 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -314,7 +313,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ad298b7e30..3e6dd1eaf9 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5a0c7246d1..7cbfcad24a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -409,6 +409,11 @@ void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -500,11 +505,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-- 
2.53.0


