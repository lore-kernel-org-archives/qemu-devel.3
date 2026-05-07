Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69810CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1Ec-0004f3-Kx; Thu, 07 May 2026 12:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EQ-0004ZY-Ly
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:46 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EM-0006v9-Mg
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:46 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so657846a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169941; x=1778774741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o48wrIEYAbabDCExut6JMD01MN3k6KJ5HxRrPE5FtEY=;
 b=nBtF8WyoyVUBA+rzDNUWJhlR7zVuq8j/gHFT+F5qIir78uuSZPZYu6wYGyB1BZGnRh
 jUpMbJN4P8OOlOdcXYscahBob3zq7sKjz7TatFS06hsBf4iQGemNTylhfqHPcq84m6N+
 9uZHC0ZhEPxtJb4WbOOrrcNRhlKG1hYa40W9xP8w5eSmdd1iTAT2I+OejNR3CH+loj1y
 j+1ZkZhXoYs14v9EN2UEgKoDocjjIWcNe4SBiSy4hw/6Fgrvby8X3/2qHqkgl6lfYzw6
 /YJ8USGRoBYJ+xbC1zCkrh16f5382761S38CdCdEOf/Aii0s9HK1cxaE4qytIqJDDDky
 D8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169941; x=1778774741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o48wrIEYAbabDCExut6JMD01MN3k6KJ5HxRrPE5FtEY=;
 b=GIFDIQjreg6FpOLudvM/qg7C6zSBGtc2Y67dRRrkkdgXtZbbtDiuqpeg+uy7kQKdiF
 uoBicvtX6sPww4e6/cLvHtMBX1+dLr7JaydaUJUK8r8xE79P2SsQYa4e5NDkIWs37zMC
 r6HIBmaikkdXdRgdPHPib6pLI0GvpImt40q4Ccx3JS8lnh4MrgkQiDlbDeVbb1Gavlui
 MeB130bEu2MjTG1fR1w86oUUpQxwK3rK5L611joaGITT6T1ChzPeAP/yoz5OVW/uIsGc
 5/U8/St90dBwP70azHITZR8noLPUMSqlPqyxZNELz5HaZNCGhAGuQ205xxBg16Ycj0cQ
 ko5Q==
X-Gm-Message-State: AOJu0Yzr7AsOxzTQpFmSWGr5W22tL6k9pI1+X0VKEZjkclHSjs34KliW
 +qTNmgGOgs+mRlNNxEcwqZt7yxLhhFj9QtxuY2zAwsNrh75RYxrgKKuP0QJlLbE4Pyq6TwPfN9u
 u93xH
X-Gm-Gg: AeBDiev05QhhzGEx7B6pxEuB2OS2g9g4ZecTBniM7SUgkzW6dHylTxvXQPTNPyPpVvN
 J3FPzttYzId0Jibxomk/JC5xTHWyiMZjpudXd4o93vx0TDZEqNc6id/Q0d+KCy1a/yvmsHeaU8G
 gT4FNdiCfTIOAvoWrQ3M3pTvXZglYugmQdOHx/F/+ZUhlQr8DrlCu7gyosoRmdxGXUX0ZmON++J
 VAgM5zyuQXU87axILjPpmq50eUw9DVKoVt1LmX3RX4ydtVoiH+NdEDD7g+bx/nFD7Uv4WY96Gzt
 XvVUGlEs4qzb91R3WmT8bg0QiUxYfuGOYb1N0VlNw8aqSpEspyWH/dsVkyjgN5CH1it++LlB/wQ
 jgY82xkbCeY+fLAG7iNNd5Gcbc0L7tpDn35+hqY/dK2VxKp8tnTzmFvevFHaTWu3cZ7VcXwc0xF
 4sUhNsCNc8ThN244wlkyfqRAyqHt2QPts3066HGSrisQgR/crLu3muEs8WlP60Mq+0Nxg=
X-Received: by 2002:a05:6830:6734:b0:7dc:dd58:50c7 with SMTP id
 46e09a7af769-7e1df0c4d92mr5315980a34.18.1778169940780; 
 Thu, 07 May 2026 09:05:40 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/29] fpu: Return struct from parts{64,128}_div
Date: Thu,  7 May 2026 11:05:05 -0500
Message-ID: <20260507160518.444797-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

At the same time, export.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h |  9 +++++++
 fpu/softfloat.c               | 34 +++++++++++++-------------
 fpu/softfloat-parts.c.inc     | 45 ++++++++++++++++-------------------
 3 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index f631c38c79..44e0cb7d05 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -163,4 +163,13 @@ float64 float64_round_pack_canonical(FloatParts64 *p, float_status *s);
 float128 float128_round_pack_canonical(FloatParts128 *p, float_status *s);
 floatx80 floatx80_round_pack_canonical(FloatParts128 *p, float_status *s);
 
+/*
+ * Operations
+ */
+
+FloatParts64 parts64_div(const FloatParts64 *a, const FloatParts64 *b,
+                         float_status *s);
+FloatParts128 parts128_div(const FloatParts128 *a, const FloatParts128 *b,
+                           float_status *s);
+
 #endif
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 246209072e..6d69b61c7f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2129,9 +2129,9 @@ float16 float16_div(float16 a, float16 b, float_status *status)
 {
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pr = parts64_div(&pa, &pb, status);
 
-    return float16_round_pack_canonical(pr, status);
+    return float16_round_pack_canonical(&pr, status);
 }
 
 static float32 QEMU_SOFTFLOAT_ATTR
@@ -2139,9 +2139,9 @@ soft_f32_div(float32 a, float32 b, float_status *status)
 {
     FloatParts64 pa = float32_unpack_canonical(a, status);
     FloatParts64 pb = float32_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pr = parts64_div(&pa, &pb, status);
 
-    return float32_round_pack_canonical(pr, status);
+    return float32_round_pack_canonical(&pr, status);
 }
 
 static float64 QEMU_SOFTFLOAT_ATTR
@@ -2149,9 +2149,9 @@ soft_f64_div(float64 a, float64 b, float_status *status)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pr = parts64_div(&pa, &pb, status);
 
-    return float64_round_pack_canonical(pr, status);
+    return float64_round_pack_canonical(&pr, status);
 }
 
 static float hard_f32_div(float a, float b)
@@ -2216,9 +2216,9 @@ float64 float64r32_div(float64 a, float64 b, float_status *status)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pr = parts64_div(&pa, &pb, status);
 
-    return float64r32_round_pack_canonical(pr, status);
+    return float64r32_round_pack_canonical(&pr, status);
 }
 
 bfloat16 QEMU_FLATTEN
@@ -2226,9 +2226,9 @@ bfloat16_div(bfloat16 a, bfloat16 b, float_status *status)
 {
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pr = parts64_div(&pa, &pb, status);
 
-    return bfloat16_round_pack_canonical(pr, status);
+    return bfloat16_round_pack_canonical(&pr, status);
 }
 
 float128 QEMU_FLATTEN
@@ -2236,22 +2236,22 @@ float128_div(float128 a, float128 b, float_status *status)
 {
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
-    FloatParts128 *pr = parts128_div(&pa, &pb, status);
+    FloatParts128 pr = parts128_div(&pa, &pb, status);
 
-    return float128_round_pack_canonical(pr, status);
+    return float128_round_pack_canonical(&pr, status);
 }
 
 floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
+    FloatParts128 pa, pb;
 
     if (!floatx80_unpack_canonical(&pa, a, status) ||
         !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
 
-    pr = parts128_div(&pa, &pb, status);
-    return floatx80_round_pack_canonical(pr, status);
+    pa = parts128_div(&pa, &pb, status);
+    return floatx80_round_pack_canonical(&pa, status);
 }
 
 /*
@@ -5140,8 +5140,8 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
         uint32_t r_flags;
 
         /* Compute precise quotient */
-        q_buf = *a;
-        q = parts64_div(&q_buf, b, status);
+        q_buf = parts64_div(a, b, status);
+        q = &q_buf;
 
         /*
          * Check whether two closest integers can be precisely represented,
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 40ea7e3a39..1634160728 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -807,68 +807,63 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
  * corresponding value `b'. The operation is performed according to
  * the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
  */
-static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
-                                float_status *s)
+FloatPartsN partsN(div)(const FloatPartsN *a, const FloatPartsN *b,
+                        float_status *s)
 {
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
-    bool sign = a->sign ^ b->sign;
+    FloatPartsN r = *a;
+
+    r.sign ^= b->sign;
+    r.exp -= b->exp;
 
     if (likely(cmask_is_only_normals(ab_mask))) {
         if (ab_mask & float_cmask_denormal) {
             float_raise(float_flag_input_denormal_used, s);
         }
-        a->sign = sign;
-        a->exp -= b->exp + fracN(div)(a, b);
-        return a;
+        r.exp -= fracN(div)(&r, b);
+        return r;
     }
 
     /* 0/0 or Inf/Inf => NaN */
     if (unlikely(ab_mask == float_cmask_zero)) {
         float_raise(float_flag_invalid | float_flag_invalid_zdz, s);
-        goto d_nan;
+        return partsN(default_nan)(s);
     }
     if (unlikely(ab_mask == float_cmask_inf)) {
         float_raise(float_flag_invalid | float_flag_invalid_idi, s);
-        goto d_nan;
+        return partsN(default_nan)(s);
     }
 
     /* All the NaN cases */
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        *a = partsN(pick_nan)(a, b, s);
-	return a;
+        return partsN(pick_nan)(a, b, s);
     }
 
     if ((ab_mask & float_cmask_denormal) && b->cls != float_class_zero) {
         float_raise(float_flag_input_denormal_used, s);
     }
 
-    a->sign = sign;
-
     /* Inf / X */
-    if (a->cls == float_class_inf) {
-        return a;
+    if (r.cls == float_class_inf) {
+        return r;
     }
 
     /* 0 / X */
-    if (a->cls == float_class_zero) {
-        return a;
+    if (r.cls == float_class_zero) {
+        return r;
     }
 
     /* X / Inf */
     if (b->cls == float_class_inf) {
-        a->cls = float_class_zero;
-        return a;
+        r.cls = float_class_zero;
+        return r;
     }
 
     /* X / 0 => Inf */
-    g_assert(b->cls == float_class_zero);
+    assert(b->cls == float_class_zero);
     float_raise(float_flag_divbyzero, s);
-    a->cls = float_class_inf;
-    return a;
-
- d_nan:
-    *a = partsN(default_nan)(s);
-    return a;
+    r.cls = float_class_inf;
+    return r;
 }
 
 /*
-- 
2.43.0


