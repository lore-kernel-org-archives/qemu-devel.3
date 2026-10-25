Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A5606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YFpIW78a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsa1-0007Pv-Ve; Sun, 25 Oct 2026 03:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZr-0006hL-DB
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZo-00048u-Ke
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so10663525e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913011; x=1793517811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=obXVNxSFFLFNpZFKKysZnl7T/GAgIlUCOGiGiodonVs=;
 b=YFpIW78aVjxReBwDbGIBYY8wtQGHJ0gsy/IQO0xYyxk4pkgEtUJIvlQ1WLxw173enV
 bTcXbWuIUdd2HdVddq5UxCNLCb3Vl12ffXxpG67jgsemqynlDFGf+ary+r2QHrjQ2pFM
 jhtgYcA932Wt6GH5X6B514X/ga+urpv+0uccNm7hxSgIOzDiKVNnBytgYJSJ2AvSVD4M
 U2oSQ/QiEciHe/rtFjs7nV75Z3Xohl+MA2yc5XAgD3uNtaGWL+lAK5bRVH1p92ZKdjT8
 /YOzCLnzc05nfAWXjelU216zOPzqGA2nS6GxFATabNw5CY7t8Pkd+j7Ug3wvhy73B5wA
 ynog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913011; x=1793517811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=obXVNxSFFLFNpZFKKysZnl7T/GAgIlUCOGiGiodonVs=;
 b=lbvHuniPzDhLlaJSlysyy3IXxAaQHKDuDyFuqryIhc8GB7D13jcPnlKby8zUqSKUNN
 5X4EofGt22BLf1ZA4kLcrZNFhndooLZcqNRqB7ROUZhP4san/XNkwa2wh2QfmgxLffJc
 tayKFmkgPgFXYPBbobyRxNRPn2PbbnhmfARZRS5/PbSmHs9LvVaCDEHatB+xtynPwo1B
 khN04JvK2DcSd8g5FxbECEhtG+BoUfHAtRjLmtHJHUr2kt8RrZyw6yKRBmIYBwA73mAr
 SgKwuPBfQqEcjTztq2uEsDK3bBZQP3KEFShyYvG2QVVZZD1YRVleaX05xB5FxvoXMORd
 6LKw==
X-Gm-Message-State: AFq9FYIdfTHFvnR5xb2pp5watkuqu2PeXoPAmEITNU0Zi3prQM1ZpCCm
 W8Ip8CE75LBi03bLa2Iw464Vgm4OitvybXMfgjtom0s+QULzK8Z5y8bKD0lHyUGSSDnWLK0GIt2
 mWCqCUCE=
X-Gm-Gg: AYBFou3C1jB3VCsuqZMh8HA7n4Fhq6HDxILVfKnbbLwnZlTpcXh1+PY/ohTPOQV+InN
 Ncv5rwgjuXxuUW0uuvuPjVfYXPNrr9FcNNp1gugC279kt9dMoSVym4B+PpjsaB8aclVX4gB+axR
 vj20cbaPS1zEzICZoDd1r6OqRouVfK6UEoOyZb9DTtRwZoOygP62+U0/i5hsrXBcxEEuDH/d9Hb
 dsq74jxVxOKailPxi+NkBZGzO2jFLVzZTPFa0b7N0Pq8TPzbmcuyCG4a36vWBpxYFf3xWPTSa6g
 aE6Xf1wkJPqa014nrKvsABewiKTO2Khq5hNvU/47dpnyuxur2pFpLFWxvolkyxvS6NgaVkR/qXE
 IuXhsBsda33N2SwrBi+iew9C/9+ZNiij63KvUzv5HKcKsQ8siKhi8conW5yegxUMqfB62S2917T
 XfRFOrwdJpgdrULJQcP45h2k6o2F4x//bmxjwntM4tGms4mlxAhf/MdQpwvm19cozTwT9Gxmv9Z
 NCoX+i7E+UQYafFEnprVTmQsFJTlgPYfS1o22ENg4cG23HaLVtZblWNFEd0
X-Received: by 2002:a05:600c:8b72:b0:4a1:e284:21a with SMTP id
 5b1f17b1804b1-4a35aca6396mr59667595e9.24.1792913010965; 
 Sun, 25 Oct 2026 00:23:30 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 071/100] tcg: Generic expansion of tcg_gen_smax_*
Date: Sun, 25 Oct 2026 08:18:46 +0100
Message-ID: <20261025071915.1123867-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 54ad54b0da..7214846b81 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -188,7 +187,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1486066728..de3feeabdb 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -55,6 +55,7 @@ DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
+DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 24e7d6da50..c97b0ad64a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1013,6 +1013,15 @@ void tcg_gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_smax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_smax, type, dst, src1, src2);
+    } else {
+        tcg_gen_movcond(type, TCG_COND_GT, dst, src1, src2, src1, src2);
+    }
+}
+
 void tcg_gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_smin, type, 0)) {
@@ -1347,15 +1356,6 @@ void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     }
 }
 
-void tcg_gen_smax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_smax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
@@ -1878,15 +1878,6 @@ void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     }
 }
 
-void tcg_gen_smax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_smax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-- 
2.53.0


