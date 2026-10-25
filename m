Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02AB606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YUzOnNJM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsew-0003g5-DP; Sun, 25 Oct 2026 03:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd9-0008Vu-67
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:27:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd7-0004cQ-JA
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso18314715e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913216; x=1793518016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pBhd+IYTP8nKJijTTWIHWWeELJlCEArhNK0UIxmo9mU=;
 b=YUzOnNJM6ERz0iBlriYunRSahL689O0o0A11ovG2LvZaNu8QAZT+EAJRQVJw5LkwKr
 R/ZD7vizmBSf4di0mcRwemSlMF9fF3m6igWfnNMlEi0hbLeTvqGc0eTpI5c7vnWbiygE
 a85j0TgfZuoKm55bxABp350a1h6GiY9/AISS/rL2iRVf47HFNDsjUyZkv0yJg0zEYkoz
 nazblHrBiK9EqKV8u2bos+nvwV9BBryJhOqdaTiBIrWV4dwHITvq34NES/zYkDLw9dfO
 Wx/un/e2ZDNIHw+1VjOekcIe+8C8t42Ih/3zTBlAZuU1gsEMmYXNc3C+/Vh9wNFjhUTc
 vwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913216; x=1793518016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pBhd+IYTP8nKJijTTWIHWWeELJlCEArhNK0UIxmo9mU=;
 b=2TtvvHX/iqv62oGiWrS8Rjhvun4AdZ3tQIoVhVOvAMMra+4TsO1827AYvl943siQKk
 Du9q3ymzOKt0VkRGUO0PLmKGvC+Cqt4u7IxGJUOeah4pYbyLBDpePjKsVZZr7hVeEblN
 Azbq7i4FkAcqwJ4/VP6mg4Qv648jy4t+p/p7C4YxWDRTGq3ym3fyWcgf516iomVor9VQ
 mh2JFDBgqJ8M4oR5AjxfXPO/SuOyeK7e5/eKVQDGoMkmqAdaPUGgpdzBAhU2U7Z81aat
 L2XoePUmeXDRmU3qRRMcZ6Hnljm9/YZVW1r7jLeaDohy3e04Nq60l81KDdIM/HWOTr4n
 KUHg==
X-Gm-Message-State: AFq9FYLZhCtJMVFLqa+3Ov2i5dSn3vYukW6i88zKGDZSu3OWFtK3+qJO
 WUVdFKlzLS2p2R2LR9EXOmVg3zAqIdMsfn7sz4j3FmyR0LJdV3s1vrS1sI5LeboKRy7GkgPrt3y
 Qa1YSzq8=
X-Gm-Gg: AYBFou12PiQZWpAxl9e3V3qSwNG2bOTBGCy4uHqC2JpkdDjoBDmP4mbVU/DqBt5WDYv
 eBVpK9+8764w2taItEgjrnYFaEFk2SC1wAtNku8VEsF3SAlMJuYdyUfTeIetkvp4I+hvny3Lg+J
 24Ks5cZgaVkllcJbEBa+C4lPorlv/Oj6tpLODvKg8oM1fF5uxn+uKpL2e+QHAHGjAWIHX0jkX99
 r//bPWBG1o3lUscvzlPsmeA4q1LZtzdnkf5agHsYpHuinXclBJ4uPojeriL4oj6PEa1PmQjm5dS
 UlxeiEUR+xhAm3Ne9QdVe0TsNChs6QiN3H13T6MceqHospSVHdaaB5ZiAKGdGiKwoOEd76bXYES
 BhkOzin5NjvpA8W9LzFdOl/P2QOUwtoxOGBGwmQRoyq9UP2WUWXxp/9gmYOMCjbSNgJ4T7W2/EH
 V/anF8r289G4nHg7NC2ESVjfu9jVBMCY71TRjvrCv6uysZngvrLn5EaZ3hOobvWvmLkGLicA6yt
 Y7dby743otqNa2nzNsyfqYCuKaWoDP0kSYKahjvpd73CBUD+6Lgc8XX65c=
X-Received: by 2002:a05:600c:37cc:b0:4a1:a6e0:4ce4 with SMTP id
 5b1f17b1804b1-4a35acb990emr59371725e9.33.1792913216226; 
 Sun, 25 Oct 2026 00:26:56 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 094/100] tcg: Generic expansion of tcg_gen_st16_*
Date: Sun, 25 Oct 2026 08:19:09 +0100
Message-ID: <20261025071915.1123867-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 23 ++++++-----------------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cd66b0d7de..1fe791d5f5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,8 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
-
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
@@ -158,7 +156,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
 
-void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 90bcf9e5ab..f9dab50a91 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -72,6 +72,7 @@ DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(st8, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(st16, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6925b1ef2d..f7da3ff5c1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -143,13 +143,6 @@ static void DNI tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
     tcg_gen_op3(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
 }
 
-static void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
-                                    TCGv_ptr base, TCGArg offset)
-{
-    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(val),
-                tcgv_ptr_arg(base), offset);
-}
-
 static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
                                     TCGv_ptr base, TCGArg offset)
 {
@@ -1262,6 +1255,12 @@ void tcg_gen_st8(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
     tcg_gen_op_tti(INDEX_op_st8, type, dst, base, ofs);
 }
 
+void tcg_gen_st16(TCGType type, TCGTemp *dst,
+                  TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_st16, type, dst, base, ofs);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1413,11 +1412,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
-}
-
 /* 64-bit ops */
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
@@ -1430,11 +1424,6 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
-void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st16, arg1, arg2, offset);
-}
-
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_st32, arg1, arg2, offset);
-- 
2.53.0


