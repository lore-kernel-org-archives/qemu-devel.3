Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF67EC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73rf-0005iI-Rz; Thu, 17 Sep 2026 00:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qw-0003t9-Pc
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:07 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qu-0007xK-Tq
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:06 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2cso336687a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619763; x=1790224563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ef8ofqaPMNPbfFoVZalzi7/jscXslYUane0qo/xYIy8=;
 b=I04M8gmIElZIdtfgaxGPnikaLwWeqpuhOaDdBmC4XL484mMbg7kITH4ORwwW4mq7pJ
 dTeqiKwn2kmTLdyPCamSH8R05XqkBsISmPEpDrOacph96oM1qPwUJmmD8EaEhcrXDjD9
 wPE/gCn/YRBV/IFRIM4Rgce+26mRYwBD7urFSi75+mGvQajYcOC4VEIL0tgOhVGkOpTT
 HAveR/iDT0R4eWhEjzi8B1hYiqvjVfk0OSkpWIbREY3aiWyVApQ21k1ZtQZc+lQv4kNZ
 3z/IOsjuA0O1kuU28egizIi5iNZPSZ0XBQK5CtoY3ETg20U7d71/8QrHyutgokGDPqGn
 8WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619763; x=1790224563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ef8ofqaPMNPbfFoVZalzi7/jscXslYUane0qo/xYIy8=;
 b=hlo4G+126H0Kjk2MDz6h1Jwe9zuz8m+JtSDEYYtBdOmKy47E5+eoLyF/SnSV5lFTBS
 AcKrB4pPEVg88Uur6HrNGCIdmLaRreNIW+fYxo+OjIeIRkS/rA4mTuBomAC5bBYSbWK3
 CwjayZt9RsXlQ1ZrhOfeGlE9kuuZebZuUvRrGt6C+YVqbz0tBpK7M49a8rfwVQQrgMc3
 nuMNyYa60HCBtQir1SY8ADLjhdYjACEYvbKF9jhXARKBdBacWJI4OjZ/GF+NHRg3fH4o
 dODBswJiQ0oX9288c2/i0JzsD/QzP+x57y8hXz5oV9u6q5zTuD6m3PbANo0N0mTTx8jw
 4iBg==
X-Gm-Message-State: AFuF++nNxd1w2PaQypjWycXNZazovpcz0q1aowuGMBYAIpk3IDbhhvyo
 syxBpv+iSTQe9p7l2a1mmtePNBgRhSQ2e1sFfnbZwu0DVsdRJvFpbOhznQvJ+b9nTTBd/5Ylm9w
 tfWx6zZA=
X-Gm-Gg: AYBFou05RW6MEyA2vOTFJkm1UTBFmslWT/VncRvaMbFRwJPbqtK3NCs3UPnRCfHsBRR
 y0MHhJNl+H1Oy0cHg1X7QQTDLuyBZRndEZukVOyj5PXsrwtZgpsVraihQYDy67XtnBaTKUQQ8/s
 iZ/Vcsi5x9HLD3N4z7iU2N6eoy+lDYFTlSrfuBnAqvjyrEZgN0gy7ShoP5fJLbcpyhCTGcRJ/Cv
 kGqnX+ya3Mo537spwrttrJcb9mu0X+KE6wCx8VPglLN8PRrmhmcoMBf1Ph5Hy4ylEKb51dmRWkI
 6IzwO/I/vnP4NhUgVEJS0HV+HEbhqF/NuM7sKWZJPbVuvVp9OQtT2hyyToE0b9cKEYluFs4Q8bp
 t70EUYdsecqBJkCZa3Vd4TbviFFuUYaPuyh3IzPR8q25cpxqcb7/q9LdwzCPhbDkmGOI9Tb52ON
 nwhVe1MibnCQzdrLKNaXlxTww/6t+MVt7LWjwm88xCJo3PJJxkAP8oJyuy8gYgWUuLUDcBJUWRA
 /rxhbI=
X-Received: by 2002:a05:6a20:d8b:b0:3d0:d1f1:6ec5 with SMTP id
 adf61e73a8af0-3dd5f3c0a82mr14049918637.4.1789619763504; 
 Wed, 16 Sep 2026 21:36:03 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.36.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:36:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 093/101] tcg: Generic expansion of tcg_gen_ld8u_*
Date: Wed, 16 Sep 2026 18:28:15 -1000
Message-ID: <20260917042823.542588-94-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 0e75243f534..925d6c1a2ae 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,7 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
@@ -168,7 +167,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index d246b47a38d..14b545c4b50 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -32,6 +32,7 @@ DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c4419b702b1..1a22c0d71ff 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -903,6 +903,12 @@ static void gen_ld8s(TCGType type, TCGTemp *dst,
     gen_op_tti(INDEX_op_ld8s, type, dst, base, ofs);
 }
 
+static void gen_ld8u(TCGType type, TCGTemp *dst,
+                     TCGTemp *base, tcg_target_long ofs)
+{
+    gen_op_tti(INDEX_op_ld8u, type, dst, base, ofs);
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1507,11 +1513,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
@@ -1540,11 +1541,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
 /* 64-bit ops */
 
-void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
-- 
2.53.0


