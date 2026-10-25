Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12E606A31F
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BeQ+vcPd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWS-0006cg-Mz; Sun, 25 Oct 2026 03:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWI-0006I9-3M
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWG-0003je-Ab
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:53 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso1378987f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912791; x=1793517591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Ncl7JiO4j52jzYfdIgWD09vGMYphkdQ0kXZDUa7qYw=;
 b=BeQ+vcPdKkKpF9GBFFkq2w4iWOnD7NatnRtsTZXaWyZcIKYVrntSRlhJ06XofnOQjv
 o7t+7ACwLvUSySFL0xv/JWTjZYjteJ1xV3txRJP2a6rhMx4UQsUx/bSnahOittJIkp1h
 RIxI9rEzxMUOW2RMY0yjrXDEEye+8Gqy60ufg30q5hYxutretcEsA+XxUT504CxtkdLw
 GY62hpwEXtesR1t4kwTf02fxkHn9CmI1EiFmxNOfxLljCySNVwUTVY8hAvGorXZ6KZvg
 vDhxCV9aWZCYYXM0yOCcFfDHpOKZlaZH5zrHZbAvOzB9M3fhkxRIdqiX4DLX/4jCQhl6
 9bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912791; x=1793517591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Ncl7JiO4j52jzYfdIgWD09vGMYphkdQ0kXZDUa7qYw=;
 b=Plu/vLnTVePtGs8fGD/928r8Wr3YDLGbjPHvRFZLHfk5odW3IBZwgxSGraS5+GW8Q4
 own2nIeGzSy0XRKJ0rBfdN6Df+wYHjH6BtMcMbr8bCsrzidsDt1qoB/w+of4FDyDsMrz
 VfHtNa3muVzL+2gHVkHVwr3HkSYCGpzjwK8L2yXU9RSN2KpamicNFyLxLo/hfwavfGw9
 6OwKf1l111IuQjxz/teRLt1xxBvzn950t4W1LI/tLPlxfg4icS0WI0Ck1T/EKR27e3te
 TCflJysRwp7UF2MS0Kpfh0UE+D9Hja1bm6iUTJO9WRZZsJepM/QtTPzV0Hx97bHz2ref
 d/kg==
X-Gm-Message-State: AFq9FYLHG2n5Ys38zhecZ9J1QKJcP6LutXxZ7lJNKEM2pJKWrQaRV/0M
 O6cB87i16RgSI85bEC3nHMvQ3xDOYTqpmCNKGqZDie3PuppLOInBNaYUYh2e32PW8faxNm93+Rn
 rZ2vQ4Uc=
X-Gm-Gg: AYBFou3F//6yk9A4tASI2P/EDlwhi39e1biUWa3XBd6CXDhFZv2QkA6pa3nUTGjVQcG
 Istxet9MLCH0KGr8kzLc8buz7/65n5gaXlyqKh5lavmt/uUzSRIPgigm4B2J30i+Gq61gA5oGAb
 AgkXltgkTPuRM7cze+s1y252Kur5UsnYJlAbvqmDqt+DGbq7XSnjT4XnFAKXepHNn1ZI6tOa+aY
 j0uwIQ8RE+p1B5gHqSkTyYZrgamRaLrH1ladtcJiGr01dsFejtUkuHKpY7KVyf9GhpmTKua3ApE
 vtAXIJUvQdqJUthzAIvVw15J5xcnQsjG/J3Lrn4nEywEqoyrdgnlCZeYvDvBitdJemwRkz0yBHN
 1Oia5aj1iZkufchPzuMGY5iXnSkNVAR6xj1kdeWw1U/Dfp9bGzOicx2hc6wdSQV2aWzG8qQnzCX
 xvHBcznJUJjubUYuBHryMvLZLMoVAJfh3dPcQMuxn834+dZcpGtl286lKJH0/9kbTsAbOt0e22r
 Y3e4IeJNDndFQOAO8fV2guFA+jmZnnk4+/oNSuzBiuldwzizcZmc4LQaw==
X-Received: by 2002:a05:6000:200f:b0:48e:f8d:8cab with SMTP id
 ffacd0b85a97d-48e3eb455bdmr6284369f8f.4.1792912790765; 
 Sun, 25 Oct 2026 00:19:50 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 029/100] tcg: Generic expansion of tcg_gen_muli_*
Date: Sun, 25 Oct 2026 08:18:04 +0100
Message-ID: <20261025071915.1123867-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 33 +++++++++++----------------------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index dd4e7f6686..2b2653d07c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -208,7 +207,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b38969478a..abea00e7e0 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
+DEF3(muli, TCGV, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index cc34e0f31f..23aeea8026 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -428,6 +428,17 @@ void tcg_gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
 }
 
+void tcg_gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        tcg_gen_movi(type, dst, 0);
+    } else if (is_power_of_2(src2)) {
+        tcg_gen_shli(type, dst, src1, ctz64(src2));
+    } else {
+        tcg_gen_mul(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -597,17 +608,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    if (arg2 == 0) {
-        tcg_gen_movi_i32(ret, 0);
-    } else if (is_power_of_2(arg2)) {
-        tcg_gen_shli_i32(ret, arg1, ctz32(arg2));
-    } else {
-        tcg_gen_mul_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
@@ -1536,17 +1536,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    if (arg2 == 0) {
-        tcg_gen_movi_i64(ret, 0);
-    } else if (is_power_of_2(arg2)) {
-        tcg_gen_shli_i64(ret, arg1, ctz64(arg2));
-    } else {
-        tcg_gen_mul_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-- 
2.53.0


