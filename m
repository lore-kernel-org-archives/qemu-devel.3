Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72239606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ex3vWMS2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX8j-0003l3-51; Wed, 21 Oct 2026 10:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8G-00038A-7b
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8E-0001X9-HV
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso6550165e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592249; x=1793197049; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ETG+SyCXliXlbQGKKJubvX4TbLREx/bJuO8bdIn8hbU=;
 b=Ex3vWMS2zEN/iEifrhpBg6wOnNIahsp63sHdrxVa9j5RrXV6Ao/W5XqFcCHVqX+GPN
 /k+FhM89FcwCftKdwjkpxxGJYeUCA+8Ur5zhbXceuVbK9s7ReFLxBpebp34gNXTt4GPL
 svFAh5u3c+2AmUUUtN2Ndi6jHKpCw4u1kOkW2VHfIsM4JWFDjkts//2uVtYmi2yqqwYZ
 gGXwLdIKECh9KFm1aOrGNhHd6Zra07ZhNjJIK6K1ZJyv8T3e1eUO0EwSNxKceurd4fIF
 jfUaxb8vEvcJWn8M6zOI/FMZ6qqiVu6bcDWpuMGQcsom3ast+fI5lOKYucgE1ljY/wWD
 ukYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592249; x=1793197049;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ETG+SyCXliXlbQGKKJubvX4TbLREx/bJuO8bdIn8hbU=;
 b=voaNFsymTYNsV4dPq2a7ODHU3ZGqKffHbjoALIsusDuk4xb2cgW405IJk50HltsBfV
 xlr7tfg7AKDsFy10jPok/upnvN9P0MuguP0gIm8cS2CPrvxXqmCNFDPJVb1TyREdn7c8
 lpRTmHgmdYBea8WaNw6Pgtl1+iJa/euW4PYQob2wyOBV8wgllpd6XLgYYIe8h80HhZPW
 mAAVp7ITu3mCsWe7joKwoqs+I1hMSgSlxKgKHTiTK7LO+SgFsnTc9rHQj8zX/PJPbG9/
 WJOkVSzxhpLUsycZWrEDCp9H0fMUp4KWdf+2DaO868tKb9w+KleA3XpHiCtnL8S1Ptbp
 L+2g==
X-Gm-Message-State: AFq9FYKEMtlngIJ6r6lVZAEaoi/D5Kxc3iRsz5o+lPG9DUHLasSDI1wP
 5D6I+lmPOnP2BBCpqfwY1CfRkG1NoBYwZ1PH7+gRGL3qhAsZ5isRdL5fEKNmlBoXSMr/Zwz6+cl
 x++JPTME=
X-Gm-Gg: AYBFou0Ym3DHK8tvYqamRsNd/1Oa5Z/hykqwzrA+FSnGEV0P63wE4/NyKbl9JH0eYU+
 UXTGMOBb2YC4J2SnlvDS+04uFSDjQVStn2NNsGPkLaNxG5gttuolk8h90ZRPhDZzfoGhIAt0aOd
 n7G5HhyDuhd+mlPjhJYWDI//ot0pAWZo9HTJlebFXfTFOpyoxR+CNp5EF/+ip7TZk0M8/+yzVoG
 e3LHKorOcRbEWMEhoYkNRQKg/GwKoXssigdjfP0hzXbMiIMToI6BF1AYxjN54uN/yQxxCix2aJZ
 sYTzV/L2NLd0ihKKHM3gCYuqKtHG1/qUMy/GYT2+kVdU5F/UyFOxC4L5zYtppmf/ur3JYJ5D5tp
 g6p0S98870h08yvJ4a5EMG7sTBChPi7Tz7p18GvPdGWYWyTHXtYHIGBwPLQLbVZD4Pc1QsUzJ3N
 VbbRKughUFlYVpAxnkuGBLSyfxq+RsXUwf80X3FlHnBsnUhK1wqRnZAPifMz5CMv5MmLpfg9ObV
 azzmgDCBp8OX26vBM6ji8OaOTL6zkqIYpSh97yJ4LvFbnQN3luE1NCSphKxKZg1S69lZBNBqtUE
 aCUSdAoAD3AIQKFVXMT/nAkMgLY=
X-Received: by 2002:a05:600c:3b22:b0:4a1:dbdc:b2f1 with SMTP id
 5b1f17b1804b1-4a1fdd141f5mr46731585e9.14.1792592248952; 
 Wed, 21 Oct 2026 07:17:28 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 016/100] tcg: Generic expansion of tcg_gen_and_*
Date: Wed, 21 Oct 2026 16:15:28 +0200
Message-ID: <20261021141652.363109-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 03f3cba216..54ed9c9f6e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -317,7 +316,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 487ee5936e..d6b45004a2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -3,6 +3,7 @@
 
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF3(and, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index cdb9774ca6..4e7ff03b34 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -377,6 +377,11 @@ void tcg_gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -420,11 +425,6 @@ void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-}
-
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
-- 
2.53.0


