Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4E606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Lo1rxsSz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsaT-00008K-76; Sun, 25 Oct 2026 03:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZS-0006GH-Nw
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:10 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZR-00044V-2C
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:10 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so1010540f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912988; x=1793517788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vbtvxDpGCjqoe6+/804awCm4Vu8XK0l0tIY/omyVMDc=;
 b=Lo1rxsSz+4xqDwkzbKRdlvwqYnJB19mAJd2IOVu3o8/FqejXm9yk2/+zqpLK/UlhZ9
 xNQcZBZqCB3E69xmss1LVjnfj66JXIhsc+2UROyAduNK/hzTvKDx/trH/z2X8V5zMJdX
 e0gK0wJOzl49y0g0ToABK5NM4IjoE88j7yzHQlH+mVauVa7DMaPJi6lpJVFDkKmnn7Op
 fzCCqzVTb2lQDZSq/aQbFurQwcbmxuvzmPSxjeggNVC4JDNYwfDSz7doetql642BTRJy
 c+/6Db9kSz2XZgyeXabG5pyCFJ7BW0FO5W6yq5lMJpVvNqWt3yN1svf0uOBuODEPwsny
 ovqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912988; x=1793517788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vbtvxDpGCjqoe6+/804awCm4Vu8XK0l0tIY/omyVMDc=;
 b=NRgBHlx/+5TufqesGGFbdcv9K+k7gxuWdWYfoSGXxy/OPRisSmfK/eZNx16hGtdIt5
 zDsPQSaLI170mNBIic2VYgMDDa3fp2bN+7MhVo6W2CUHxyyJa6xk3DS6qsig7frB2J5y
 tt9OfOkM21zC9JAWnILEyptPe6PJ17eQyY69KfnAjgX7IOcKT4ADJ1ZxEoaGGUkrbw2W
 yDxxTe+3aHDmf795+NPMsWNY8PyilHZvfij1YorUSiqikSN8bZlBg8+TQ2cGQ73mV3NB
 zIEZf14jVupzCWnQP7pEfh7VPLzwmQu38RgPOVEBkZHSXQyMmKQDbYsIzppuzArn0rhI
 oGOA==
X-Gm-Message-State: AFq9FYK2ljR66s3I5SejW3b+ov4VOv8uDfCWObMV7BQ6NYVIT1/D0OzO
 NmW1ycGn6f97H6KvWgN37ZU0tN9Y0yfskl4bXeq8woXqkFWz5KOh0I8gFGjCypyG55J7CH3YkOf
 wg4EW4A0=
X-Gm-Gg: AYBFou3WmrnXnnRFPPoMRLnF2fbUZV4fYqLyaHOB3NBLQDoJTh73UAcEyD0fkmFKW8R
 BVTXTjACEwfVVYe8EVQFSTGTYqnrRZpHW0Fl+4SQsYMrISaZB1cFmiyLUo1a08RfQk7JO8Fsmpz
 FqWuL3oSQ9casOS0TD+/yhwqiovGfRXfDknko94T2uLNUS8mRcHnX6SaCbjUAdIH7jmMQrY7kEc
 5RruB7/faZagbrGqqF1+rOIWTzx73nTb5zKH8hXokbZ4G07SQfB2V7u7Gu6bQoM8C+9qVUZ2ZT7
 8vBfc2DSXtUjuZSCn6rfbNlbjnFX/FZB5BfbL+LK8Z0Z67AxKt+juu3IiEoj9dqH8oPy6Ze95/1
 av97M+Yu1D1i9EFPeJuBcc29hgiG0OT4TSW85BPlnzqtQFqTU67p20R5TWmvQLKy1dmv2EPlJ9M
 7imtq5Wnt/ZOxCAeN4bfmNlZMM6MLPw7qYVh4PjWs5f+70Qip6RePQ8UgLTzET+z/nvAceSVZVl
 741Vo/WsrGlcdR+GGi0qwe4wb4niW3SJeKzi7sCppU9zlmh2BoEBVl8/L0=
X-Received: by 2002:a05:600c:4583:b0:4a1:825a:56fd with SMTP id
 5b1f17b1804b1-4a35acc2773mr67241205e9.32.1792912987608; 
 Sun, 25 Oct 2026 00:23:07 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 046/100] tcg: Generic expansion of tcg_gen_negsetcondi_*
Date: Sun, 25 Oct 2026 08:18:21 +0100
Message-ID: <20261025071915.1123867-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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
 tcg/tcg-op.c                 | 19 +++++++------------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 923d6eadee..fad2933425 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
-                             TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
                          TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -211,8 +209,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
-                             TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
                          TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1ab2c69cbe..846b781c83 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -19,6 +19,7 @@ DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
+DEF4(negsetcondi, TCGCond, TCGV, TCGV, TINT)
 DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 40156e4113..6be1141c08 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -530,6 +530,13 @@ void tcg_gen_negsetcond(TCGType type, TCGCond cond, TCGTemp *dst,
     }
 }
 
+void tcg_gen_negsetcondi(TCGType type, TCGCond cond, TCGTemp *dst,
+                         TCGTemp *src1, int64_t src2)
+{
+    tcg_gen_negsetcond(type, cond, dst, src1,
+                       tcg_constant_internal(type, src2));
+}
+
 void tcg_gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nor, type, 0)) {
@@ -719,12 +726,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
-                             TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
@@ -1479,12 +1480,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
-                             TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


