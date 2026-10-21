Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87177606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sjh7XmUo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXFu-0004nK-OS; Wed, 21 Oct 2026 10:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD2-0001Ez-L6
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:29 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD0-00027k-Gq
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e011d370dso633445f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592545; x=1793197345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VyztQsZRKtFbzU12VpxGjlpFXGIeJftW4HYXu+o3sZk=;
 b=sjh7XmUoQ5LKQChfKQAiwJutSSxlVPkTFipWvjoJ1yL2BPRQHioWyAxYm3zuBlCD0n
 kv6yDjr04EqocuHsPHTiEswbSnnv09uJKQNsh8GnQfgKvFmW7vf1Use3Bq5d6VmdBlKx
 3zVYoBRV7eYlbriIGmdJWVBPJYJmlP27VrlaiPtC1Bt+FUBhiLNxRNKvILoFhGB/zpzG
 FtWoJkRXNo2wClh7lt7/xQhcNRInv+xt010YVtd4+KNcQuDrQLFft8SALgjkHBVf8/X0
 lTlOAl5JMsuaHXIfbnCV2Ov2kYBm6ZOsVHQqVXHcLtGXzGt1TrgCqclcEi7GcLYeBlNM
 n+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592545; x=1793197345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VyztQsZRKtFbzU12VpxGjlpFXGIeJftW4HYXu+o3sZk=;
 b=TXJXOC1+mJRrn50Uyf1pinQvcEl/oj12hOxGZbTsf1H8ZqBmyBp43L05jvXKnA3R3n
 aOzFAlNyVOzGEFIBBey3oL0JMG1msnTyBYEbqgxicSMz5pC43BiljcByhiwtff7rWYmE
 RuWhYHE2wdjLFrU9fcwlMqOsHmpcqVwvsoLOWfo4NPmTX4H/+CYBBJD4JK51EiqBb1p2
 b8/D59cQMUtRbsf37twLp1YgJaCzDcp9S0VHzsVKDVSHoWKLnlDyWDEFr4CqZpP1iP+8
 bYmTOzmwQf2SV2HXO1ewwgfVVnX34yvDd5OouYOfHm6/1KpdrbdGP2jeqmLTy2ZKEJ6/
 oeYA==
X-Gm-Message-State: AFq9FYJyvwEwUP3/3Z1skB8gOaYF7328e14k/u4EXt0zYTLSAXWRB8x4
 1kzfkvZC6gfL9EhXCF0FhJRt3gD1LmHPtlfnEKKFydQ3EUsjfj76eXStZWf8KbRRM7KXhsBEOmG
 xhbCPm60=
X-Gm-Gg: AYBFou15i2S/sbP2OERRuzheyTXRI+TNOl4fJx8vPUujdDxjH2fZcxxsaFdKnPRfITx
 0jXMQ++fhnf7hdW0iKmvyAbN8KXftuCCQp8XIjnox9FRx9qCR3aqzCgCgMsykUeEuIT/xuxvaxC
 yjmMsFoJ2k1RDQZueHRrm05Zsc5dc0aXw+zuT1Wvqj/7JofNF1jinqm6MT6DQf8pl3Hwak5PTbI
 shOV7+Vi0MGzzgNvuLHwZcvObkAbZgrS+IdN31MMt1fOCQq31i9JkjLpteUVig912W1Nl0T6s25
 5wLhNfA7scUblIF2Im2McJnkzC5zU+lVLsGe8lscJnv8cLmV8fB1QMJx9W59JfisrFueMxX9C3L
 mhTNyeAsfFoKK4XaOVUw4TIHWcfJsEqIKnJ3Oa10zrHGMescQATjI8+H4AETr3S6eS4DsEKwOhF
 XcouuE2+FZlZ6zqmLD1rscpho4MYjYMsseaGDz1hrD2vVnisvPNHUBMKJEps76ju2u5x6Bpnd0M
 WaC6IBGtd+6UAnGtgVW3JImg9rCBqloaBFsYip1xS3idgdosSxgZ6GF70atUsggdLdog2EdyPRk
 t/t7XqX1ZFh6halab5tFubaUDmU=
X-Received: by 2002:a05:600c:1c1a:b0:4a1:bc6e:2f4 with SMTP id
 5b1f17b1804b1-4a1fd72acf3mr45712365e9.0.1792592544789; 
 Wed, 21 Oct 2026 07:22:24 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 046/100] tcg: Generic expansion of tcg_gen_negsetcondi_*
Date: Wed, 21 Oct 2026 16:15:58 +0200
Message-ID: <20261021141652.363109-47-richard.henderson@linaro.org>
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


