Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84606606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tUkY0ae6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsa2-0007T7-51; Sun, 25 Oct 2026 03:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZS-0006GG-Hc
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:10 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZQ-00044O-2m
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:10 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1254748f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912987; x=1793517787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dw9AIznl4oiFrKN3DKm+PGgPyOKqmVn2llbup5Yi0+k=;
 b=tUkY0ae6VbW1WT3SiAjhTuOShbZQJfkBj6fIjsHh2ihKk09ah/RS6TfXk/gwa6pI0C
 6MlVsuBIMLWNcMzdGcKvGbtgaWcd2KuZxFlLWdDWKR8q0VQYoyn3Eu3rKQ8fYP67v73Z
 MEkpUA1P6JInI3GlLEOWoAi7ISKqCl4AKlT3uLp4DN5kSzfnmrC05s231e4fT1nTYWDY
 +/Q/Nw7fK7kiH0dfeE6phzScrHqlHfm58/hNJWhALDS8CMpgdzEuAq9EXZNZi0FnqExb
 sbgqe+uVfTDZKrZnVIo7BwjOyr0Bqh3NkRjW51KC0qH9zC7bmlD4IZ5hJU+oI81zW3An
 16aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912987; x=1793517787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dw9AIznl4oiFrKN3DKm+PGgPyOKqmVn2llbup5Yi0+k=;
 b=H7QalXxwdTCQEWFl0QQCHBvvHbKR5b656nGDPTUsEM8uLAgBkEQWBk1EUJi4kHfRdT
 3J3pA7vM2rVBFo3qtl14pEvOlcO6U3LctIRaWWnt9t2yJSpnY73a90T/jZznxGBJsfkL
 SINHB3YCXryNTJWaUlNTcTx7PA+lfGcKmJyz8cB9LPrVkSXy62SvZR6hyux7+fzhlSzq
 gOUXsmRtdTJCyJX25Ii7EsCW3RsQtyemCrbI3ogh1Y/Nwyc1C/DOkm0j0k5ppPrpb5qz
 T0FCRD0ATRWl/etYm+D50nwnGLYXFUNlnSMHM5VFprEU96Rq6hxKJ0bgdiNGMtunPd/h
 M40A==
X-Gm-Message-State: AFq9FYIPdN394JUPQbZsHLYMOkrXsw128mqk66dFm5avZnGdJpr9+Cyb
 rAyi3s3Oz+nXRUh6LiMJDg7BnRQtjFb02XKQiS3ypKwtoyx9R0hYMPAinKl/dvlgfTj9XzwskeJ
 SpNYTrIo=
X-Gm-Gg: AYBFou0Ry987Hq0rs1jkjyQ4ca88t7OiHYOMCIgg0SwXLTYT4QkgbpnoqEAEuYiXikZ
 W/MVkAjJnM423aCsctUkw20vySC1yq5VUeyxijGrfKyzx0buafycboG/j56DZyKRisgGAGFEaJS
 oDlLQ4ZCegDaTMtFfjof7PgpRGGA4P+TTfDyKuZMBlsjDUpsK/fUnwYyfLIDkGjK912kFShXE4B
 rHwB75GZeFvsu2zizaUTodneRCzLuplNnXFxDxdwfxb/izLzezP44uv2r9L6CBToOohiFSpZH1C
 55qdWfXwKPXLpwC9vhvCqizJLpZg685zwVGVbhUPWeDmxcK6J0j/cWxBg50njYBtstFX4Db2SCU
 cCbSGHXPq2XMv9P3/j1fd4zp4SoGdtI8ildaz9P+wDZIlQoddfnpcG07U3IP+x/waeUYC5Py24k
 gjbbmutu53bpoO1Gpe0pe6HO5YfW/Lh7zPPb4ms2kWya5QIGWHpRzzTBf0x/QCPP+1NKcI92G2I
 CLj0G5ihPyRQOzEh9muQtHKLbU5OAZk9t4UKgMIqiduwMIc8gIFCMd/d9U=
X-Received: by 2002:a05:600c:8b81:b0:4a0:2488:71cc with SMTP id
 5b1f17b1804b1-4a35acc45a5mr53276285e9.32.1792912986629; 
 Sun, 25 Oct 2026 00:23:06 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 045/100] tcg: Generic expansion of tcg_gen_negsetcond_*
Date: Sun, 25 Oct 2026 08:18:20 +0100
Message-ID: <20261025071915.1123867-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 3 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c7ca7a493d..923d6eadee 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
-                            TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
                              TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
@@ -213,8 +211,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
-                            TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
                              TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 92a35e83f8..1ab2c69cbe 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -18,6 +18,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
+DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
 DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 94451fcfd9..40156e4113 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -518,6 +518,18 @@ void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+void tcg_gen_negsetcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                        TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_movi(type, dst, -1);
+    } else if (cond == TCG_COND_NEVER) {
+        tcg_gen_movi(type, dst, 0);
+    } else {
+        tcg_gen_op_ttti(INDEX_op_negsetcond, type, dst, src1, src2, cond);
+    }
+}
+
 void tcg_gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nor, type, 0)) {
@@ -707,18 +719,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
-                            TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, -1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_negsetcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
                              TCGv_i32 arg1, int32_t arg2)
 {
@@ -1485,18 +1485,6 @@ void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
     tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
 }
 
-void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
-                            TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, -1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_negsetcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


