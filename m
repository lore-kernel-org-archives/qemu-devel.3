Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729D2FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEvr-0008IV-5S; Wed, 29 Apr 2026 20:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvC-0007oh-V6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:29 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvA-0001sS-L9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:26 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8296d553142so203866b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507583; x=1778112383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mnphmMdh5qVs16ds/iO+k1UV8auN4hiLyk67HUUL8zk=;
 b=CZfFJgl1Q7LbA4TvIQOlLa3G36n3ItCDMGyfxyJm6a6sOr2uTtQC9EHVM8Fvu7eV2n
 3La1DA+ayLZ6H3fppk4pTOtMrIl6f37/3FSD0sX+2P2SCp2Y8sFuHFsxxH0kSavc/k4x
 /qXtwZ0AqeDxCKyTHuJ3Z3gAjkP3zXlBlaFtBd5lGEQoVm3GyUW3NaxzIQLDa301H0yQ
 PR2d/yzz6SBMeI2IaMC1pTJPHj79d+CabeI94+oLxdnkK332B9xSOPajjYOHA29KAG40
 c0LpbK94+ptaRgMsXmKuSVPSGbuNkSwGSWyYU2iuvks7jROWAoHUknHFooMi9kcPwmph
 l6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507583; x=1778112383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mnphmMdh5qVs16ds/iO+k1UV8auN4hiLyk67HUUL8zk=;
 b=jU0I5KCWe7Ta+ljUI5BdmWef5AAgPt/e5ZUFqjMuYBuhwBJLjDcFgi3ArEgNDSWNu9
 toT05sQjl0ZDiQaqo8PCGpM1NExPZcQjJke93+LFc1JemX2z3gBPwKV0+VhvS+tEmqRy
 MF6PthA3A/sHqIFx13o13di622KcyPlL5h0shxNj6r1kff0SVVpz8YSKQ+JMUBxavS3d
 SmWRnmnC2EVBlzeZRFGhIS+RLx0Mok3GqdWfwBMh2t2FcT4hnx/ORK1fQk9vDw3DuKqq
 hy/EQ36cHyUo/Z1A3kQDnE7UjgNc2w8avVJuQjXDGotnwD6abH9svkKGsYXJu8GPmvdf
 Yptg==
X-Gm-Message-State: AOJu0YyD4aif+kBwQ8yf8P/y+Fs/a+dVU5klA9cFE6qBiiTevG32YOis
 M2Gbq0kbwo64L5+KDxPmQGyyB/QWwr4X5F1xJAnb+wOzJHkLbYuCtwTos6U4C50q0IUjmkUGTCl
 JWXu/BB0=
X-Gm-Gg: AeBDievfAa+co2MQcTppVm/WXe2e0EIG3CvhTI6dN4mT+L0qt2AycoXWhT7LjxTzAzy
 MkUiwrYJloybYRaIjsg1kh54gSb6pRktdhFpW01fKdyDpU8q+YF2rttpTxJb5ZFUdXktoyb6Fmm
 w+5vhVCwSKpFJuSqTA9w9Jbo5Yr1mjxqkwqUXt7JwT4B+pD8LG8uWz1e3GqWOC+5p0DScEZ3ZmL
 jR1YEzbg76yL2j3q9Ksv77sXrE2dDSBRpcq7ENIU8yO7cH2jiqeHP2v8sCluN9WTwFtsg3xg0p8
 niKtz6NDXEuHbo1rGTYywDqHL8yzVEoAAmyd9gA1niy41L475AWFIaRh0xnX2JOyj7cJh28PHqV
 Mf1xW05lIpC40SyKW2BpsC3qSbNQbcbv5WqGdUUN6kPhKb6Vo+sKiZZhhxwYpJ69metpLDgMYAZ
 M9pkwE56qbsXR6wFM4L7uiZubX4kiO3s2EFmnfHrt4
X-Received: by 2002:a05:6a00:22cc:b0:829:8942:2c93 with SMTP id
 d2e1a72fcca58-834fdb58a49mr754278b3a.9.1777507583189; 
 Wed, 29 Apr 2026 17:06:23 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 24/40] fpu: Split scalbn from partsN(muladd_scalbn)
Date: Thu, 30 Apr 2026 10:05:07 +1000
Message-ID: <20260430000524.56046-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Handle the scaling separately with parts64_scalbn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 37 ++++++++++++++++++++++++-------------
 fpu/softfloat-parts.c.inc | 20 ++++++++++----------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 168181858f..2e5c1d4a32 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1907,11 +1907,14 @@ float16_muladd_scalbn(float16 a, float16 b, float16 c,
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
     FloatParts64 pc = float16_unpack_canonical(c, status);
-    FloatParts64 *pr =
-        parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
-    /* Round before applying negate result. */
+    /* Before rounding, scale. */
+    if (scale) {
+        parts64_scalbn(pr, scale, status);
+    }
     parts64_uncanon(pr, status, &float16_params, false);
+    /* After rounding, apply negate result, especially for -0.0. */
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -1931,10 +1934,14 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
     FloatParts64 pa = float32_unpack_canonical(a, status);
     FloatParts64 pb = float32_unpack_canonical(b, status);
     FloatParts64 pc = float32_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
-    /* Round before applying negate result. */
+    /* Before rounding, scale. */
+    if (scale) {
+        parts64_scalbn(pr, scale, status);
+    }
     parts64_uncanon(pr, status, &float32_params, false);
+    /* After rounding, apply negate result, especially for -0.0. */
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -1948,10 +1955,14 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
     FloatParts64 pc = float64_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
-    /* Round before applying negate result. */
+    /* Before rounding, scale. */
+    if (scale) {
+        parts64_scalbn(pr, scale, status);
+    }
     parts64_uncanon(pr, status, &float64_params, false);
+    /* After rounding, apply negate result, especially for -0.0. */
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -2105,7 +2116,7 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
     FloatParts64 pc = float64_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float32_params, false);
@@ -2121,7 +2132,7 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
     FloatParts64 pc = bfloat16_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &bfloat16_params, false);
@@ -2137,7 +2148,7 @@ float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
     FloatParts128 pc = float128_unpack_canonical(c, status);
-    FloatParts128 *pr = parts128_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    FloatParts128 *pr = parts128_muladd(&pa, &pb, &pc, flags, status);
 
     /* Round before applying negate result. */
     parts128_uncanon(pr, status, &float128_params, false);
@@ -5116,7 +5127,7 @@ float32 float32_exp2(float32 a, float_status *status)
     rp = float64_unpack_canonical(float64_one, status);
     for (int i = 0; i < 15; i++) {
         tp = float64_unpack_canonical(float32_exp2_coefficients[i], status);
-        rp = *parts64_muladd_scalbn(&tp, &xnp, &rp, 0, 0, status);
+        rp = *parts64_muladd(&tp, &xnp, &rp, 0, status);
         xnp = *parts64_mul(&xnp, &xp, status);
     }
 
@@ -5195,8 +5206,8 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
 
         /* Compute precise remainder */
         r_precise_buf = *b;
-        r_precise = parts64_muladd_scalbn(&r_precise_buf, n, a, 0,
-                                          float_muladd_negate_product, status);
+        r_precise = parts64_muladd(&r_precise_buf, n, a,
+                                   float_muladd_negate_product, status);
 
         /* Round remainder to the target format */
         *r = *r_precise;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 028c2daa27..b8baaf1e76 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -669,17 +669,19 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
  * `b' then adding 'c', with no intermediate rounding step after the
  * multiplication. The operation is performed according to the
  * IEC/IEEE Standard for Binary Floating-Point Arithmetic 754-2008.
- * The flags argument allows the caller to select negation of the
- * addend, the intermediate product, or the final result. (The
- * difference between this and having the caller do a separate
- * negation is that negating externally will flip the sign bit on NaNs.)
+ * The flags argument allows the caller to select negation of the addend
+ * or the intermediate product. (The difference between this and having
+ * the caller do a separate negation is that negating externally will
+ * flip the sign bit on NaNs.) Note that float_muladd_negate_result
+ * is not applied here, and should be handled separately after rounding
+ * chooses the final sign of 0.0.
  *
  * Requires A and C extracted into a double-sized structure to provide the
  * extra space for the widening multiply.
  */
-static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
-                                          FloatPartsN *c, int scale,
-                                          int flags, float_status *s)
+static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
+                                   FloatPartsN *c,
+                                   int flags, float_status *s)
 {
     int ab_mask, abc_mask;
     FloatPartsW p_widen, c_widen;
@@ -725,7 +727,7 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
         g_assert(ab_mask & float_cmask_zero);
         if (is_anynorm(c->cls)) {
             *a = *c;
-            goto return_normal;
+            goto finish_sign;
         }
         if (c->cls == float_class_zero) {
             if (flags & float_muladd_suppress_add_product_zero) {
@@ -770,8 +772,6 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
     a->sign = p_widen.sign;
     a->exp = p_widen.exp;
 
- return_normal:
-    a->exp += scale;
  finish_sign:
     /*
      * All result types except for "return the default NaN
-- 
2.43.0


