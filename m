Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CA9606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UDQIW1L9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXIO-0008WM-Is; Wed, 21 Oct 2026 10:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGg-0006aI-H4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGe-0002Yg-Hx
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:14 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso531471f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592771; x=1793197571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A6ekT2N4sQlHzpPQ/sJ3pfetJsFKs3I5t8DK5+g381Y=;
 b=UDQIW1L9b00H71LClLsPQ9q0qnWAiIcdrO5XqM8LO1WMs6IUsSX+KbVXWpHYPYvAoC
 y9NV/al8fks5JysJoWJQfFQTYAUyytG7Xo7Jr5HEM2aCZqWwgmTgItvnMyzawi/2U2TY
 JoYzgqrcfxzgt/8koFwWMhSWQ5/aRo1rcP8WFN+/CRIQYx2uI9Ta9+Z2xR5yGv3ddh8W
 CCOfvhIdBJyhx66V5IIyiAcZXNwwlMmCh8CtKDiSsjaVl1+PMEtkPn1mwXtPqa7C8ChY
 mJVJE89oC0wR1NMkwqwmO78WIvWisEv0QPNNZBGrGNLpNjPQfZGPbflvw2CGl7xGas8t
 OpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592771; x=1793197571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A6ekT2N4sQlHzpPQ/sJ3pfetJsFKs3I5t8DK5+g381Y=;
 b=iFaU66BY5jAr1v4dEt+ERFu6I44RjMpbytFOcNeWN8EjjEFuQCtSnnw+8Igqurda7d
 NoADlRFs9x+YgUSeCaNI3GZ1A1E1aMYMHOYuOxIAqtJ4lqK6v+0gyz8pM4taAbvB2xxD
 ZIELxgHJYkviLpv9u6lSdhiA8xvCbT3Jew4yILzlEfKo0llGzPsqaQz28uJ9QzGZGd5K
 S0rbRaRRyb3+ZW1EQT687hsofmaQL5mHkYoFAtBFjixK2nA0kMbe1SE+xN1MBEjBpMn3
 NIFG1abMw2Qh6IamY2+uZpCFS32dqqfGljHSW8MCah1MCf8zOIca+lItIj4B5T+A2u6b
 7Xzg==
X-Gm-Message-State: AFq9FYLfA9DFUHNHJb3nxaE3U/z+42vS3/s2ys5+v94tkzJJpcKxxwIN
 Ux6MznHScjQEZ8U4TRJ2mA0umzblMehU7I1L82G4ygAPTMK/TszObeDGCkTkUIdOkVxicXpbHYU
 EW+hGbhI=
X-Gm-Gg: AYBFou3KDG8A23c7dojPc7gECWY2/K60uPRbm2aFwhsaxfuanrA4VEtX+HR2aIIzRhy
 hzcf78aULaR3mY7h22koFbuw68r8lxWGtLhGcOMxW3hwwtV3K3eeNDSKB79KgAELgylQLrFSNEM
 2wNck4Zcd4GYEKzr3nl3FA9x8YjzmPHq5tIBlCW+eEyojeAXfr8Gks3za0z/RWWCAUf6/VASNxZ
 YT+VQ3LgiCYiDfH61ykXWuCX8P5uMwujwJqBrNWAud6VivsnFGRcT0t5XgUEB2dBDK8ARY/Ad61
 UVnpUlSC6rQekpcNBkgtP3iZZ3GZU7qF22HVjI1yqDRI14frfbt82YPYEeT37sJFkDPxvEoqcep
 Jl+ZAY4yuxXTo/ZhlmT3A3C8vM6W9u4vH6wMC1hE7P6O7G8dVOs+6UlfI/C2iWiixKQQmGSfjnB
 XD9D1vABOF1xOB6Rw1+T1axDKCKC7sblEFo5AuvPb/yPvNX61Bdo63dtsG2NK56/PQm1jmWK9ws
 8cX/QG3Co6BKb6nMiNCOPGerYqAWTit9uDNkaTkcWWsTDX7fTOPabZR7E10ltBRNV4dOzMCVugG
 3eC4JcaFIx4VBfrTA2LF6cSkCBcDRVljqAFFW0I7HSgzdXl5
X-Received: by 2002:a5d:40cb:0:b0:48c:7037:aee9 with SMTP id
 ffacd0b85a97d-48e264e01dbmr3634732f8f.50.1792592770891; 
 Wed, 21 Oct 2026 07:26:10 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 090/100] tcg: Generic expansion of tcg_gen_ld16s_*
Date: Wed, 21 Oct 2026 16:16:42 +0200
Message-ID: <20261021141652.363109-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 744211c4c6..c12217f68e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -141,7 +141,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
@@ -168,7 +167,6 @@ void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 75bb38a07e..785c417a74 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF3(eqv, TCGV, TCGV, TCGV)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld16s, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 74ddc74191..73dba6a15d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -786,6 +786,12 @@ void tcg_gen_ld8u(TCGType type, TCGTemp *dst,
     tcg_gen_op_tti(INDEX_op_ld8u, type, dst, base, ofs);
 }
 
+void tcg_gen_ld16s(TCGType type, TCGTemp *dst,
+                   TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld16s, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1395,11 +1401,6 @@ void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
 }
 
-void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld16s, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
@@ -1423,11 +1424,6 @@ void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
 }
 
-void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld16s, ret, arg2, offset);
-}
-
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld32u, ret, arg2, offset);
-- 
2.53.0


