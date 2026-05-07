Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B27CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1Eb-0004ep-6l; Thu, 07 May 2026 12:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1ET-0004bk-Tj
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:49 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1ER-00070X-Na
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:49 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso877320a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169946; x=1778774746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhbgvoCRwmebYNkEMIy2MxqqEuYsVTL29FJUMN7mzgw=;
 b=A5Q9lJGDK5/32mITkAeI1Gui5M5/Es8r/AX3Nswi5BHT3lRpTGKFRbQug4hPoFQfFl
 qLB7ui8r9jjyxPBABt+N9a9w987lpmxD1tFeg9oWS3JJEKuU2Tzg5bLz5cq4l9ILLYaH
 bAX9VXtrnwf81aITkc9OPVE/XFpCZdaWennPhh7TgX72IzWIYsw9pSMh3omHza1xqggC
 5YMHJ6xtcKCMKlrD0bKqChB3N6XLyru0HnkG2jm1XwiAS4w+C/c9jhzVkjB8kaAzu2Pa
 h1Tc4an3+XN2M7PwL9Onemr7gwCg8ztOrIPSm0Z1ReoY4CXCZi1eqmvfYljgRAXjeSL1
 DuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169946; x=1778774746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jhbgvoCRwmebYNkEMIy2MxqqEuYsVTL29FJUMN7mzgw=;
 b=VYc+lFPzV81OF+2t9uq4pLxtI/lfdyMSkQG/0hStH3H3co5Bkj7PxVGImIPIkvwt/X
 Edm5p7MgCesIGMIdvMPSbNPdfQEYMmJ0ZVH9Yi94HwmfcmQAHkXC+XIxlHKNsQS1PFXQ
 vnXmnXKMSATR9gv8PrdrcoyTGlPBHWHILXPp4Qwsr04/STI98j84aUtlw2MEs4iXyGGB
 3QDBNeLl50+Su/rdt8H3LPrPsDReD5vMrhfSsQlfHKD32EI4mlP0CwTpanMu6Vypq3aO
 NPNgLyH/BMO78Nku1dPo2xH2a0yDQHfwAxOiamyNkKJdtaWd8GN7YK2nO8uspDh9/0bp
 VCfQ==
X-Gm-Message-State: AOJu0Yy5htPekDDNYg8mbOSM3Miy8b1oCey16rGlnQc7HiKfw1dk4lXw
 RO9w7viaZalHgEe7UhrP9aQeNfG65ssCGiIwSo7WPJbA4JjQxhlDfYAMSksex/4FwSWJeWH0fnl
 Wba9z
X-Gm-Gg: AeBDieuhRO4j5tLVszTgd96C1FBaWD6un//2iWExiaUkDglEhVj2w4vveePKiKCV9xq
 cRgV/fqwHW0HSmsynRv1IdKDqYQynwmb76QgKgr/qArcUWYuRzie+vuKDoEbLCD4c/F+Nu4P0Zn
 G0l6rM6yGQw5HFUuR/kTl8tzaY0XdWZhLleCfPkwoaT5rEenJ1K0gRYVugwkDY+Idd1/vPCcVSx
 C7NFZAvYnizOC6QVJRNU2A1YU7TgMPfu4TbwY/HBNkeQGEbcFRqdk4W8R3Au6QzlXH5Ow54YruT
 RrwfjfZb6v6zKSUtuFwNIJgjmtanTzET9w8ekNa3+ZOMoqymR56PNZj0WPlwFnf/uJNAd1qBc52
 A8YQdcGlgD85/4KH6x6wH4kz2k1jo1nKpoLcNAluNLW6YHmGnQnciVhs+KMiEefXlZYDs2h/PBo
 W2ZMveFW7IUtTpu7q0m+ONDCIZxyHS52ca+fEJVRW2yZdZK4XWXNgUH/eQ
X-Received: by 2002:a05:6830:8544:20b0:7dc:e059:c25d with SMTP id
 46e09a7af769-7e1fc4b389dmr1307550a34.0.1778169946325; 
 Thu, 07 May 2026 09:05:46 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/29] fpu: Split scalbn from partsN(muladd_scalbn)
Date: Thu,  7 May 2026 11:05:11 -0500
Message-ID: <20260507160518.444797-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 37 ++++++++++++++++++++++++-------------
 fpu/softfloat-parts.c.inc | 20 ++++++++++----------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0a8da13e01..962528cb73 100644
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
 
@@ -5196,8 +5207,8 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
 
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


