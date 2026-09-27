Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008DAC9833F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkp4-0007F0-Jd; Sun, 27 Sep 2026 05:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoE-0005NV-QK
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:35 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoD-0007hf-3g
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:34 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0bcdf41a3so1025052a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499872; x=1791104672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mXrrL12s3/rTxGr73ZNI9U9KNibAWMsQrk2NR1R4VzU=;
 b=TNuDOA2MKIzA1MUy+ItGeB2148ZjeV/+f/BMeN7Qkku8gLXUTDzA8Vh0+kPZNdEo0y
 zA2pYXXQrl6nzl/26ncHgdoDnhFjSd+/Mpyvx7xGrKXJg+ewY2Ozkhqz7fEX7uzJorUQ
 6T7omhOalU/r3yg4iCAYsSjszwQ8HRbL8bcQE0vvCWRG0ene/O8tVNXLOoXj43dCfKfB
 /aAOg2w92lTx97sFh2IObkSMgApWUnQfY5DTRTnyKpmpQYa4TuGN0APPbRMltwxk2hvs
 M0uibhEa/8Fu3nBzHBHfNGTT/dYH19siGNBURFdC9aJphLbav61GBJztr7l2uwUF+eP+
 R7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499872; x=1791104672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mXrrL12s3/rTxGr73ZNI9U9KNibAWMsQrk2NR1R4VzU=;
 b=YKvyWEZXtB2s2kGvjupR1dKW4O61rv4D9qHJBXysllICG31p35CVKGkl3rLP+uPAqc
 WeZuOeoa9udzgTDtRPR4zIAwr+DaiRy/ywuxLRrJM6FDr9CmdGlZW9eKiozHmrdRO6VD
 C+ticG8ekDRYM3aHCm+KynaHYHSRW77iPn4vfd2pYBnlY/TDiwDNBcOrto4nxZinej1S
 9ayzYuLh0OayexualGE5PCRADea4jNvYDwt6dordIqWyYrZ69+7tFiFeg/YOs16qh/Ly
 Z+5AQXy1bka1QCeI4wMT9ONGvL5XYwxeviZY2XY8uYaqo/SwYpfTgX9qRnNliS1ElKHS
 UCXg==
X-Gm-Message-State: AFq9FYKph12FD0AQSrZoN3e0uHdXN95LyVqUp3UBieXbJw8dhW8Qz8Wl
 ACu2f1zD3VkK9osNvJbzafY0H5rvKgWHz6KedsJeZ4zutNaVwGymLuWnqpG0XKWHZrbHeSuBUaI
 QSR2j
X-Gm-Gg: AYBFou3WpupgiqB6rNV6ZskdIM9+m+Kc5ozaZ5y2mm8Ke34ynuiYvSxOpEs+wrhnBUA
 x7L/nPe36fFaTTu54rOCC6Ro3JCVp7C6gsDO7moHHjWZBv1u7niiKq3qiv1vrBYWLACaz8C+mMl
 ZtIkdfOEN4fkSSDXErXLdga9XiP5vBR5MfxO/ekabC4QY6tRMu0wrir4RIANcFMkAShqia79UWS
 iFRUMfepybj+bStU4V9WxEp/3TNMH8rjPfJ+kudo+XMaBSKnbzJXkrZqzc/LmEPhSwRFVtuGOWN
 6iIblZlD361NR/UIhn+Hxv8CYTZ648WRm5v4ab7pXUlIsp7WGV4J7nJr0cANUfy9Fg9dXumXpE0
 CVqJUlbV4b+NkvJ0Le5jz3Yi+ikdws8XcDzqZVTnBcGM3ZhgVqdosZuoJS5KC5y59sIyKQBthxA
 3Zdot+o3oh2RkV3AaOlMq1z+qBoIWRRpXkAQvLd9LwFr069O7cl0shhd4ZEb9JGYqPHcvsrdQiy
 rCD14I32qQJZoEYEyvDOkA2UsSFUec=
X-Received: by 2002:a17:90b:3887:b0:3a2:b70b:9cc3 with SMTP id
 98e67ed59e1d1-3a2b70bb06emr269129a91.8.1790499871501; 
 Sun, 27 Sep 2026 02:04:31 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 073/101] tcg: Generic expansion of tcg_gen_umin_*
Date: Sun, 27 Sep 2026 01:59:43 -0700
Message-ID: <20260927090011.10724-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c7dafd2773d..79a2716e29a 100644
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
index de3feeabdb6..7d1035a8c84 100644
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
index 3deaecc7e0b..904c3ed0e1a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1052,6 +1052,15 @@ void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
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
@@ -1349,15 +1358,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
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
@@ -1871,15 +1871,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
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


