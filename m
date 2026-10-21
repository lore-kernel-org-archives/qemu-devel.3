Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB460A2600
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=buD9xY9x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAM-0006fi-6f; Wed, 21 Oct 2026 10:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9z-0005H9-Ti
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9y-0001lj-8d
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so5998465e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592356; x=1793197156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I78FIZH+xdZEk2NPjxmgzYXxLjZgDudgNOzURm6L55M=;
 b=buD9xY9xUPpUf6F5llsLHJsXkWw5Npogl+vka75RlN9GhMBTeW/vIYb9XFN6/rtw6L
 DqJ0ZKXy10W73HqonHIAcwrG1SPX1PBKq8QV9rXzRIMsyhVg3IvyyLUMouwSPJ8BypIG
 D4S4UdmQO6A35X4DgzlaFlfoxg3aFHm+90tmBz1FXjHZ4fs4C1yg8LwR5xt3EzDmSywC
 Fapktc4Eewm6rVjxw51idrn74EGR3OGXp5qH1p8dyHjP7xRzPdBcKKzTa5ivn8VSgQEr
 27ZCTAcImXnTvwXMznv9i1//o9wwhfH9djs92ZA3C4R6Xc3l+w2Dl7zaxfa4z44QrtqX
 epWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592356; x=1793197156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I78FIZH+xdZEk2NPjxmgzYXxLjZgDudgNOzURm6L55M=;
 b=2gO6Tr/I+YWy8JLcqoEioju7Z6ykLClSCNP0X5mNWYq9pJWhC1/ecb9aSQuyOOH1nY
 EWHMQzdl+YgLu5mHlfXysvHX6K1Ed8VvtUbzl12glK6JYzJO5HO8qgs4anidiiVj3Eoy
 K6ApLv0DtjB4vUlIeQgLuGJtE9i/mgaosBzpuzH5L8QxpG46NmDs3SBXTeYN2x7Uht8z
 DxDNDAihFZDkseNpcLD1c4QDTQr9roeJTvfpQ70jMdU/jPDqXtIyEshWchic24DiSVUW
 5k3nPS+eODizd4wt3kTtz02ALYqL8eAQnAy8PTPXQY2qjwHyOn+T6/vpsjQBkOQuvShP
 uwbA==
X-Gm-Message-State: AFq9FYLAlNWHhjoK5igFCWNJkOsFn3tUoN/vpYPylRL3tQPQtS2iydln
 aNryb2Hqnqp+gplzDAhN+teJbI5YTRkDvDeAz7p3c3Lru+WTphiUNp4iqapPD0SG34Bu5YmRlkw
 HV2KnWhs=
X-Gm-Gg: AYBFou1Cgr/w2ED5uVdv6Hfmf24m7W08zCa8loiCOHrsjE5LNswTUJUTM4+dVufHMnK
 Ic/pGZw4nn6lkqcGKHNnlIVLz8MolPno0mbFgt6oyHTsAjKOtCscGq9J9Z5dpsVLmyW3H2IxTYy
 hq9aPZCWBPQE27Q9+AGrhL88NgqpLxQhKW99oFpEHOTENptIiyVhdHlTbZSH35W8M+7Y9fggaez
 j6sX2tJKDh6aPv7MRwAv9Bj2pncD72hmBzo3i7oguBoIa05wOnHTf8Ypj9nQumrghUYYExIfAH7
 UHsQ5JlnJ6Kbz585ZLb6t2xSFiWjNMvrjBME3TK1+4hYnrz9qfJxCIXcOY77TV/tZPeQ2kP+7HH
 8i1HbZcEDyv/Yo7DfMNVpUzWA683Mwzkx2g6uWtmi/OLpB5a0PZ3+CtF39wPUmJnhUc3zjUtFms
 FxGu4w9ffdpRh20XDs7SOG0SKwnhbGM6/PxUYs+Cz2Zt4Z5njfUnHJkVO0o4c0hF9zv5kcSOe6/
 xPy4noL6xOdtGmaflwlzItQoiaXiFgH+AugaGpNQ3fMWGYsPWcJ8bV26raR1ptKHJX/ykNnNgNs
 fsLBhzfaBqtVBUyzmG5tLnHEB1aRw9gtAj20f7+QMB7q+Xid
X-Received: by 2002:a05:600c:3e14:b0:4a0:174:579e with SMTP id
 5b1f17b1804b1-4a1fdd517f2mr46068315e9.28.1792592355999; 
 Wed, 21 Oct 2026 07:19:15 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:19:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 039/100] tcg: Generic expansion of tcg_gen_nor_*
Date: Wed, 21 Oct 2026 16:15:51 +0200
Message-ID: <20261021141652.363109-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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
index 2d9b0704a0..f959f82e08 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -198,7 +197,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index fc40bca553..7d94e0cdfe 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -16,6 +16,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
+DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 587fe0d280..1ec1cc1e97 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -490,6 +490,16 @@ void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+void tcg_gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nor, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_nor, type, dst, src1, src2);
+    } else {
+        tcg_gen_or(type, dst, src1, src2);
+        tcg_gen_not(type, dst, dst);
+    }
+}
+
 void tcg_gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_not, type, 0)) {
@@ -695,16 +705,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
@@ -1722,16 +1722,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-- 
2.53.0


