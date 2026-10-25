Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9982606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pI5v5IE1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsam-0002Pl-D5; Sun, 25 Oct 2026 03:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZr-0006hK-DD
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZo-00048m-Ke
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso15869635e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913010; x=1793517810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GDaoX5/AtoP79ijTs1l26nizqOF4tg6tNu2tAHVvXlg=;
 b=pI5v5IE1VMwN2drFV9SN9RDWR72e4s+a6ABSLmdhawllU8KbdWFLOW8WBBP7iWIym/
 9V9qfZi3kYthFc39/bgDaOmuLhL6EpKE9jeKgj3xJ7G720CPPP82R/2wcdyU9e9UGaxc
 CUy5K/wTMVQLfVkqC4z3x8C51vO9VwYQbBY+lwE9a7KSkTWBbSeVqI55nRzAB6yTNbHd
 9J7SAN/vDyaH2NipVvEoOWDS4hvn6XDUsmErICiV8VcIWoyur1hs7/nsK5/O/SlX3YZu
 7L5KU532adJyj0IfrwP1kyM256EFZtKfO7jfTcgcdkj6+xNrk0x9v1fZYzONzt7SYmDV
 +MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913010; x=1793517810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GDaoX5/AtoP79ijTs1l26nizqOF4tg6tNu2tAHVvXlg=;
 b=ZKK2G0p0ucTtgnskv6w+EfU3Jye1oDU89P8bIxQMks8tto0yu0/ZuHXzZgRQI4J8Z7
 SYXUPxEK59HELLuq6xOwlb+4+CCsLMBy1gzSOOkfV5bjbQSw4hCVhof1N6+zak11Z2Ih
 wZUjbRIDZEkd0kPLoApUqn85RWz/VXfs5NWXJ/ltlEtOLQX5tHo/+lcVP68Mf1nLpFQq
 Zhmdq7xXgVywQEHAkIJPxRER6fReuCwPtAy5zcUMt0kPNyg0qoR7/HTf5it2Befn+Nfp
 oDAlxEutWgpAbCYu/GjxJrl9I4RVQIMjpMy+93d+FrlvzZtZ6Jp8Qv98Rmn0aztY8Gqz
 A4zw==
X-Gm-Message-State: AFq9FYJrkyBr2M9/au1M+rSLE4aGfjgUrU1tpa7Gkz9yoqp+ZKwuiEnt
 vK3c6pQiGFk8eQlFFMFVTVkfAFwzm1FfKPD/J+EEMSiYrj3n6/t2eKtXfObNc8mSzHNEwYTOItm
 MwFluevw=
X-Gm-Gg: AYBFou2G2QIcdOhMsTMqTkyf8KUPiBoiC1Tw9mQxtEKC0YlKfpwZs7mUk3wkU0AFCDI
 0+7eKX8D/3+dU8kc6GFgF2gobzQCbpuqRYAcOWynx6PATetfiO9qWAnr3PQjuWi2zTt+fjYs+0l
 FsEVp0R4f+cFrA9o3LgZuXZl6xf6waqEHYZtZk+zVp4opJNwl4ss9yT3fxPYMlEXSECFF+e3TEd
 VUHSjyOEdAlXirQoQwQGPXYcS4pvhY50kfBKrZw+3fEZYXp4OvkmDdQA0/J2UFLhHOJa3bxgekB
 Lf5s6VSj1f0xyxAPXgr3Nuy07yITIgX6bRGQdgpcq/D/ZFlk0AjRrQJgX3BIyodFpDcp/Q3T+NR
 MXwEu0NRKPHJkojydmLlvVZ14LPCyNJgp7BzDYCBFzK8OC+XyFKB6WNqnbFBwltd6NfC5nlD6nJ
 NVrrNJsHyzxJiqO7B4A5dCq1Tq1ORYvQAawN4XCV0syNaZvobLH5C8abOh2m5TPa7cgpNMsm7vr
 +oJb5LykKfRyMEhV6dZhGWpbI16KIN9FQytr9Ar9CbtFGGjTI+2RZ1oDXgO
X-Received: by 2002:a05:600c:3b25:b0:4a2:1a:a128 with SMTP id
 5b1f17b1804b1-4a35ac9f1ecmr63349005e9.19.1792913010191; 
 Sun, 25 Oct 2026 00:23:30 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 070/100] tcg: Generic expansion of tcg_gen_smin_*
Date: Sun, 25 Oct 2026 08:18:45 +0100
Message-ID: <20261025071915.1123867-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 911b94f9c4..54ad54b0da 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -189,7 +188,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f9812c1f88..1486066728 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -55,6 +55,7 @@ DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
+DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 11676eff30..24e7d6da50 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1013,6 +1013,15 @@ void tcg_gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smin, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_smin, type, dst, src1, src2);
+    } else {
+        tcg_gen_movcond(type, TCG_COND_LT, dst, src1, src2, src1, src2);
+    }
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1329,15 +1338,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_smin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
@@ -1869,15 +1869,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_smin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_smin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
-- 
2.53.0


