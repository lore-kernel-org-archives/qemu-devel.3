Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D6606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uRsKfYFM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsam-0002VV-TQ; Sun, 25 Oct 2026 03:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZr-0006hP-PC
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZq-00049N-1Y
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so2127405e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913012; x=1793517812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wN1XRd5jSypFGDlkyelhzvn9ikl4sskd4t+aMJnXVWM=;
 b=uRsKfYFMkxoKyjd77Y0P3Dvp7AnSQIGUUBHzvGAkKkbj9OjSliI6dcrEfFl6oAt8eB
 7HC02Hyu1xhK+KbSDduHk85NNfLRRRI+9M5R6ZYZxsQyRJRhlWiBzSI8aL4lG3dcXFtd
 sZyEigxevBoB/92zsF4MazGsMQg5YOev59bTjVS1Fb+/pLgypHCF7Sj4hZxLYfj9AQRi
 xQvjqanmxN89k/fa4hZEzXqU8f7kM13bkuIRiwph3D54K8ry9bxG9A3y33jc4WCO5RTl
 Tr5VHPrO3GQzD4wHlvxndL5BSNrfF/f5d2r01sSv0xpY3SzQacPX0DDe9aiG/BgKn3Ph
 XPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913012; x=1793517812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wN1XRd5jSypFGDlkyelhzvn9ikl4sskd4t+aMJnXVWM=;
 b=ldDl9ko/smepSlZ3e5/QOcDYR/rqqede28+DPH2E7q21EIToXmJMKigpZNzSgyyEMD
 7OQYyhLJNNQebI16h1+cgzfCJ8Ud0XTp87RMTxYrWEgKmvl1vB+RT27dd4DOw3KVNTGt
 +B0v2B5JN3LbpT4m8r/wMw9ezV9malXr7vtzApfHZIYvNqfJeOYK8Uw7t3Qn3xc9aqXQ
 Oop0z6t9vq5wEnok5P06Z3yXH5H25wbStSg7Va+BrOpsKT+ElfTvvf0nohr+gCO3jbRu
 1PVHMjsXWlWTkIggGLCwnuy7YSJTHvpQGwN1eAohraciW0F3M9vVh4QpWALxMSsGCIfN
 RplQ==
X-Gm-Message-State: AFq9FYK++mAxyAXQxJHFrYEo/GAk38yESFtbptccTsiM8r2/cx3Y14jj
 /sTAPNZxkHS7mSO0W7hDBIM1YBhY8mFKSxn12wDrckJcqsNCsL5honBzj16XVusMbiN1ovBYFyY
 HXnYkpTQ=
X-Gm-Gg: AYBFou2Y0p7W5LIBIjsaVp69YpNEDV7utz/dR0+I+pJPDVwMy5SXSWxD7zvJzK8uuph
 0ISyNKQeADdo5QQz99S3+HMuC0WQejMQRm3rNwGMzPAHpL6ApXIsXY41HdqjpIWNntax5LJbv2I
 p1VLq03b0Jg5SFIczZ+auswu+Qfzr184w8cyLz1O3dLLV8QkJjVnrlJMWh5FFUItwaLRk91X9E3
 AYGGpUMMuYwZYiimTjiaKTjCRAKpdJGMP16i/TQaMcwTDbKwngROXwPuiScUL7g9vvJtgB5BIIn
 qA4s3pFqZRrHU3RX7+jpRGgBGVmEi7OU4wN5s3AOQAWCFI0qjwdlsrUU2D+5KO1PHZ4CGY/2zbA
 v0aZTqUegMgf/QfYVLkdoYwiSOAzjydd0i3emFFYrTfpO2oeitQqhVbG32Akl6ex4PWwD1Yr/pX
 kYnUcfRQcYGZysb8eBDbJsxvuxeSZ0LPOJFrYOd4IsmNoYuaI3FqhOGS6cfUfV7M5rjqouaFdh0
 7Qrsz+bjBIoy9Wcdn1cjQ4sgk7baT8a4TLNXP9ShTjTXBvkdKNkJYlfwRw=
X-Received: by 2002:a05:600c:4583:b0:4a2:1197:1de0 with SMTP id
 5b1f17b1804b1-4a35ac963edmr66669505e9.19.1792913012533; 
 Sun, 25 Oct 2026 00:23:32 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 072/100] tcg: Generic expansion of tcg_gen_umin_*
Date: Sun, 25 Oct 2026 08:18:47 +0100
Message-ID: <20261025071915.1123867-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7214846b81..e23f247b90 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
@@ -187,7 +186,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index de3feeabdb..7d1035a8c8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -60,5 +60,6 @@ DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(umin, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c97b0ad64a..7a5e992557 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1050,6 +1050,15 @@ void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_umin, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_umin, type, dst, src1, src2);
+    } else {
+        tcg_gen_movcond(type, TCG_COND_LTU, dst, src1, src2, src1, src2);
+    }
+}
+
 void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
@@ -1347,15 +1356,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_umin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
@@ -1869,15 +1869,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_umin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-- 
2.53.0


