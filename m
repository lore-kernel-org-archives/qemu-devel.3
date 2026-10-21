Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD2606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E+KaC8pi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAj-0007nw-QB; Wed, 21 Oct 2026 10:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9y-0005Gj-GG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9w-0001km-B8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so6418425e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592354; x=1793197154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b+wrN6Sewwxfpc5YBT9F/mi8GB6jOlgO5bAbH5EN/zs=;
 b=E+KaC8piJuxdrkVw8UJ8z+/MGp+mD37ke6Iu4KfTNprLScokfMmzxN2rekOc30o86E
 VgDevGgc9U3iKL81RsqCRh3Z5zMv9qK/Lvnj0hKQWQs7wKjo+XSFbmNJEL653ccxPN0r
 OA32iJGb2b79iDyg/zECbjhGKRR66DdhQ309+cFuDzz4i7MhYq0HMPj7GZWNgxeIevZz
 kY12kV3Kfek+eXKFQ6h6kgLULB1gf6p0waiVXUwVBOpPwzaqS8N1kgDy6HRRqEeyPg6K
 7qiWwbCdJ988D5mM0xIq+uGUXLGjBmbRbfc0dlZ6cwQzkxjwRYMTkQKlvbq0TKjvJ9hy
 Hicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592354; x=1793197154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b+wrN6Sewwxfpc5YBT9F/mi8GB6jOlgO5bAbH5EN/zs=;
 b=vcVndWZlls5WHAz4zNQPu/bSE+1g2HMWdOnfpH4jZCVkPanklGahskNdL9WQDGM7Mw
 PH0CfdPSlj68yVdUTrTk72SriqdhFoTPhL623H5AqUn2IphobpAJuw/WGCo5HtIa4nTL
 BIZUE6jji0thBm5tgD/NzQfexL9UTiaBXe1AHrp2UlWVh3qupwT4IDfJjTWZWS5dFeAd
 d2NlgNmdpr7sUWLJwckXm9CxuiK0hfqn3W+FibgzbOyOFy6rcAohyLLkZGoJyCbqe9if
 AD9c2mgtqyNQnkxVyL2nfBST+AWFP9fRQ87ocPeszjlhs6uTGnKEqcqJURFt8gmK81k/
 E79w==
X-Gm-Message-State: AFq9FYKTEz7IWx9zbHzNixoH/y3n62gmwKTbBggtV0a7Bh8VPwTYC+jq
 YZhXXJwR8mjSkWtq3bnXM239yIieuElQK3LpB9t3LZQ9iMWGlPfgU61PI54JjznJWitQ5HnunXd
 PGunJCCo=
X-Gm-Gg: AYBFou1Azo8oFwuaSiK4u8H6Nx/Hwq4ZBGaDU7amSfQzI61COeR2o1LvKr5gUoWpffu
 ue05yeK+yXjfoG6RZKM4t31Lq8FETwfw0Zf85v070zaVn2ddPJg5g/8xskAh6aB0kQAehe8BNK7
 CJbzIWSFpabDMVMmP8n3mBguSY07qTmL6O7DpPZwTbsBfU/qaMcLIkYLDyXdgKHuz54vDKhrZDt
 QZSD35nQoc2oTQ+isjXabRgv8FucxVxkyO6nskF3o7pN06Kh8FXgcOQcrys07ISgTiKCxGoB5ut
 sTvARgmZiS3PKptUyEmHm2/0ZX6296R6d85k91V6Ch7dsA+8rlJ7iG7KuVrTCtjiuqO1V6IoD1J
 eovIpBEZTZ5nNb/VFv8Czx8sJwArp57klV78UNsv98a5XEM745nhAQ5Fz73+bRUVsaHDkbHYdEP
 HOhZugqzDQob+XM7PT1hyq43njoaZpjeDRySHinN0BPAgtFw/UVmozXiwqt86QJ7IHSZQwzetwk
 KMrqEnQaIcMkJsDFpNyoXEQFRdvI+PfD+b/GNgq4XkCDki8YhZFr6gZkExSiwEl8mb9CCK+AAwV
 pXcInd/BFwSEQQDMtkc8I/ZezQw=
X-Received: by 2002:a05:600c:46d3:b0:4a0:5b:7bc0 with SMTP id
 5b1f17b1804b1-4a1fdd19e23mr47434685e9.21.1792592354025; 
 Wed, 21 Oct 2026 07:19:14 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:19:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 038/100] tcg: Generic expansion of tcg_gen_nand_*
Date: Wed, 21 Oct 2026 16:15:50 +0200
Message-ID: <20261021141652.363109-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4eb35775a0..2d9b0704a0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -199,7 +198,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 6a4d726b79..fc40bca553 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c38accac75..587fe0d280 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -475,6 +475,16 @@ void tcg_gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nand, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_nand, type, dst, src1, src2);
+    } else {
+        tcg_gen_and(type, dst, src1, src2);
+        tcg_gen_not(type, dst, dst);
+    }
+}
+
 void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -685,16 +695,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nand, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
@@ -1722,16 +1722,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nand, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-- 
2.53.0


