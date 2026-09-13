Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EA1C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a83-0000um-BB; Sat, 12 Sep 2026 22:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7W-0008R6-T0
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:10 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7Q-00010Y-RK
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:05 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb752so1044724a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267138; x=1789871938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rKPPOoGq83JxUWWA3GF5Nl06jpolEV87xjpvIIodUoc=;
 b=ekDYKc11DOwP3CTidC4FiYeoGC/4IG6ngjz4A6odKnxrQ2CBvZP/TEQPH5pVu818y7
 VfwBpyeg5epKv7yJFGw2iMHm5KgKLn776CIEgGQTEFVGch2KD+51Yiy1FPj4EUZFpDWq
 PV58czlmocS+O5dHnfQ22lVGpTLbs+VcNB/ZWDtG5E7oaXty6oyJgTZzj9CfzJJB7HHR
 zL47mTqkMmqbiOVHXmQ5BuDU4Hg1Z43i1/nYUEsPaqYYRLAicVdm9ngK4T4FghDXxN1O
 CYFw05JBRXG8k5vA505IbtRcPvt3PvjDuEznh/XFp2d+6dw8H10rHF4+X42iIwz+b1zi
 xK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267138; x=1789871938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rKPPOoGq83JxUWWA3GF5Nl06jpolEV87xjpvIIodUoc=;
 b=gbcMLUklcpIg4XkmGw0pwxxoaf9l0M/u9x/WURtArbEksh3VCUTGGC2Ocb97Arud+w
 cJWziCpY4jh4u0rfIWgSbpQhyef2G+ymt2klq/93eoxIsuOy64zxUUZmlM/rPWLAV34q
 PPkFHONFTF+eIKlAo1ZLXGQJb46zRcQ9/s+Vy/CR0/5Qnp7h1TzJbXKVXwMb/AQA+WoT
 sbQu3nX/7QR69qQjHWZ8a7lDVUGRCV09wZrNBYUbRx0tnxIsQyHPjZUcT2aJb0cVhPPS
 qELmwHobET/llnbo04iHnwLzM4i/gyhvtJJ2KtVbq30F2KkCMg5vix7PadMNG+YEbsmR
 swqw==
X-Gm-Message-State: AFuF++non6ayFKPtDsQ77pVILU0PtDg5W68oV5eeoafJqAViR4lxVOfs
 BEN2Q2qrgeXHsjk0cKcjpt4qloH/yCgfSlUwS/WvGc00G1JPW1drBzWKTiX1SwEGKel1deqWmr1
 dbgLa
X-Gm-Gg: AYBFou09prLi6zQjwubhENaeDgp5HrmnjThOQTL5JLaQOYcrbhP5mBnVD8wyuu5tnJF
 dSICzoWD8DhkRHVsxyuP/cpaSSWdsh0UfjaoHWW/ZbKHvMyI5x1mmuhdbSfWwn9pCA2zYdxd2qn
 mZr1lheLXeIys+P7X9OwpH/j1Egyh9Xygk+Q8IJ7b7IX2XS7l7Vv9RjCWnE6yO4WxtvhGnED0Wy
 nt7mgdMBouS5zo6jFG9sYaK1hoVmQtWdwWYU2xrRVIxVnEuxqC7jn8L9s1dTlPPgRy+693RRrEi
 Tm/4W3BnJkNL378pupN75jwvzWpYvh0UtwkGY/ZvjSN4SuLm+84hRJ5L6Wo9GxnhqBbvmiHru/4
 iC/+eSyzjOB+WUoxz8Mxz0ujuYQSvpcoja2crdu/PsvZCjXXKvmurMw34YrlzkT4VekrFhlx9BV
 7YEF8OeBF9ca5MCGCPxSe0/AlT6FD3mlW3gpkMtdU6WNSCpuXahshl1vQDq8CJbLYVwYLMCi2MF
 RiAS54=
X-Received: by 2002:a17:90b:560e:b0:398:a2ed:7b5c with SMTP id
 98e67ed59e1d1-39d9c3a1fc2mr20639039a91.24.1789267138271; 
 Sat, 12 Sep 2026 19:38:58 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/86] tcg: Generic expansion of tcg_gen_shr_*
Date: Sat, 12 Sep 2026 16:37:27 -1000
Message-ID: <20260913023837.741866-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 99c182aa5a4..1120cd45e66 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -313,7 +312,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 15cbb6c341a..3f928d4cb8f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
+DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1223ba31e3f..8bf3d40971d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -448,6 +448,11 @@ static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+static void gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -549,11 +554,6 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shr, ret, arg1, arg2);
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-}
-
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
-- 
2.53.0


