Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299C1CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1Eg-0004gX-MK; Thu, 07 May 2026 12:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EZ-0004e2-Iw
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:55 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1ET-00071r-Er
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:51 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dcd689829eso900922a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169948; x=1778774748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8/R07coZVPLeMow688U4HbHyRxrGDzvDIkI37R8zno=;
 b=oixx+JVEf6/vCPUnbeJoqWaJDUaYkouNaesa1L5j7BiBvtOQl5NRECQQoI9+WnWAiH
 4QNXVf5jTVQLVok4ckK2TrEpdkwBkN4RMnEGjn5Oc2gERYliycOQpAkhnsp7WK10tBT1
 LkHooGf7mFoYGh72bWlcIrAdhN13lQ9gC+XXph2FYPZj9Geh/ECOl2t0fyrWK1fVz9PH
 K2s5J/5Lg7q3LYd8M3OJHqnIsfEVpK7Ui3BrBJcBT6YY5EKH7NpBDSnibC4ofacS7u3C
 tb35L6YU2AE12yaNLA6fwZ+8QxFePeTGXqhqeLOSuP2O9dOmGdYJMJK+kY4ZHyhxAO+q
 SfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169948; x=1778774748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b8/R07coZVPLeMow688U4HbHyRxrGDzvDIkI37R8zno=;
 b=Z2JOx7j60Tb4XuBKjNvVRxDBSmU4/iDWTr3o1a3o/4aof6MoteO7HwMSdbc1Dmybez
 HDcFEFW+FqxtWrm245172nhqUXRsfUYYnU7KpVLz1o6z1/Dv0dW1pmnnRY98lXJ7kdHy
 axebPZna/v3xuYRrrCv+QqcA29QBqB3pWHQ7U5CgvM3tZzLlmGwj6z2OFRXGknS1RRJf
 u5OrWeCv9S+5xNU6X/+NXZL90wCIbf15L6dzvSeTv+QflUoYf/q910HBdEwIcI9n0T2G
 zfuTGgPQMakK5dmC4wlJx3ywz10iXkN2eSY16k68khKAabal3dzKWDeP5p1eyh+KrUjy
 BnuQ==
X-Gm-Message-State: AOJu0YzdWSDd6TjFDTCG+nI//TcOdAXPpRbQWAhMN0imZq7nleXqf3Uj
 w+l8ktur9CNfi8JlZHQ1q++yQE5bAcYvsCc2Y83Mu3obUsVnDv1Q/XMRn8+/PeG72ESb7qRaSfI
 XqHt2
X-Gm-Gg: AeBDies+TN0CTfFZSthdfK16LZPa9JWaMV6FUg9jMOYiSEURBlcDFwdw8sJgvqni/jY
 mCZ7bzy28YCN26D2G3l9Pfyujb0AWDxxtsdO3V4OsQwV8twjz742TTa507fllbSl/V+99lPlkPg
 c+s6Cp8K8racVRb82Dk5K6uKF59sMUzqxEKSk5Ra4fQAmVRPv4qC1HuV/FfbyxvjKiGBilZoeOQ
 mfedK3kinTF1fuzPUsIj4a0//hVNlj9+2TovvVl/FMez9iQ1dVMfz3Wx7RpcZ8Hj/U348VKZINK
 rj5vRKw4Th7X47wOSkIrr+xK6R+gqqPyjfSSGUh4hMyHxI3iEMNBrkEqojGkDLFeDww4TlSxHC7
 rM4Xd//TPShi/oNBJovnrraCthKPk8+b/Glr0c4rSVR00Ik9qXcigIsRj3FW8w0yc9/dZb5HD9H
 UsSpMtks7x9RtUZ3ydmL4VtDlrF+ZhJD/fQxnn6Fq/QxMarWiIqi5AndRR
X-Received: by 2002:a05:6830:3785:b0:7dc:d967:63de with SMTP id
 46e09a7af769-7e1deea311fmr5564249a34.3.1778169947959; 
 Thu, 07 May 2026 09:05:47 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/29] fpu: Return struct from parts{64,128}_mul
Date: Thu,  7 May 2026 11:05:13 -0500
Message-ID: <20260507160518.444797-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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
 include/fpu/softfloat-parts.h |  5 +++++
 fpu/softfloat.c               | 34 +++++++++++++++++-----------------
 fpu/softfloat-parts.c.inc     | 35 ++++++++++++++++-------------------
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 0dd8d9c526..1285946321 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -192,6 +192,11 @@ FloatParts64 parts64_div(const FloatParts64 *a, const FloatParts64 *b,
 FloatParts128 parts128_div(const FloatParts128 *a, const FloatParts128 *b,
                            float_status *s);
 
+FloatParts64 parts64_mul(const FloatParts64 *a, const FloatParts64 *b,
+                         float_status *s);
+FloatParts128 parts128_mul(const FloatParts128 *a, const FloatParts128 *b,
+                           float_status *s);
+
 FloatParts64 parts64_round_to_int(const FloatParts64 *a,
                                   FloatRoundMode rmode,
                                   int scale, float_status *s,
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 962528cb73..c0bf255076 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1804,9 +1804,9 @@ float16 QEMU_FLATTEN float16_mul(float16 a, float16 b, float_status *status)
 {
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return float16_round_pack_canonical(pr, status);
+    return float16_round_pack_canonical(&pr, status);
 }
 
 static float32 QEMU_SOFTFLOAT_ATTR
@@ -1814,9 +1814,9 @@ soft_f32_mul(float32 a, float32 b, float_status *status)
 {
     FloatParts64 pa = float32_unpack_canonical(a, status);
     FloatParts64 pb = float32_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return float32_round_pack_canonical(pr, status);
+    return float32_round_pack_canonical(&pr, status);
 }
 
 static float64 QEMU_SOFTFLOAT_ATTR
@@ -1824,9 +1824,9 @@ soft_f64_mul(float64 a, float64 b, float_status *status)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return float64_round_pack_canonical(pr, status);
+    return float64_round_pack_canonical(&pr, status);
 }
 
 static float hard_f32_mul(float a, float b)
@@ -1857,9 +1857,9 @@ float64 float64r32_mul(float64 a, float64 b, float_status *status)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return float64r32_round_pack_canonical(pr, status);
+    return float64r32_round_pack_canonical(&pr, status);
 }
 
 bfloat16 QEMU_FLATTEN
@@ -1867,9 +1867,9 @@ bfloat16_mul(bfloat16 a, bfloat16 b, float_status *status)
 {
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return bfloat16_round_pack_canonical(pr, status);
+    return bfloat16_round_pack_canonical(&pr, status);
 }
 
 float128 QEMU_FLATTEN
@@ -1877,23 +1877,23 @@ float128_mul(float128 a, float128 b, float_status *status)
 {
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
-    FloatParts128 *pr = parts128_mul(&pa, &pb, status);
+    FloatParts128 pr = parts128_mul(&pa, &pb, status);
 
-    return float128_round_pack_canonical(pr, status);
+    return float128_round_pack_canonical(&pr, status);
 }
 
 floatx80 QEMU_FLATTEN
 floatx80_mul(floatx80 a, floatx80 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
+    FloatParts128 pa, pb;
 
     if (!floatx80_unpack_canonical(&pa, a, status) ||
         !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
 
-    pr = parts128_mul(&pa, &pb, status);
-    return floatx80_round_pack_canonical(pr, status);
+    pa = parts128_mul(&pa, &pb, status);
+    return floatx80_round_pack_canonical(&pa, status);
 }
 
 /*
@@ -5121,14 +5121,14 @@ float32 float32_exp2(float32 a, float_status *status)
     float_raise(float_flag_inexact, status);
 
     tp = float64_unpack_canonical(float64_ln2, status);
-    xp = *parts64_mul(&xp, &tp, status);
+    xp = parts64_mul(&xp, &tp, status);
     xnp = xp;
 
     rp = float64_unpack_canonical(float64_one, status);
     for (int i = 0; i < 15; i++) {
         tp = float64_unpack_canonical(float32_exp2_coefficients[i], status);
         rp = *parts64_muladd(&tp, &xnp, &rp, 0, status);
-        xnp = *parts64_mul(&xnp, &xp, status);
+        xnp = parts64_mul(&xnp, &xp, status);
     }
 
     return float32_round_pack_canonical(&rp, status);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 7f5abbc6e6..07bd0b2fad 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -613,55 +613,52 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
  * `b'. The operation is performed according to the IEC/IEEE Standard
  * for Binary Floating-Point Arithmetic.
  */
-static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
-                                float_status *s)
+FloatPartsN partsN(mul)(const FloatPartsN *a, const FloatPartsN *b,
+                        float_status *s)
 {
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
     bool sign = a->sign ^ b->sign;
 
     if (likely(cmask_is_only_normals(ab_mask))) {
         FloatPartsW tmp;
+        FloatPartsN r = {
+            .cls = float_class_normal,
+            .sign = sign,
+            .exp = a->exp + b->exp + 1,
+        };
 
         record_denormals_used(ab_mask, s);
 
         fracN(mulw)(&tmp, a, b);
-        fracN(truncjam)(a, &tmp);
+        fracN(truncjam)(&r, &tmp);
 
-        a->exp += b->exp + 1;
-        if (!(a->frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
-            fracN(add)(a, a, a);
-            a->exp -= 1;
+        if (!(r.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
+            fracN(add)(&r, &r, &r);
+            r.exp -= 1;
         }
 
-        a->sign = sign;
-        return a;
+        return r;
     }
 
     /* Inf * Zero == NaN */
     if (unlikely(ab_mask == float_cmask_infzero)) {
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
-        *a = partsN(default_nan)(s);
-        return a;
+        return partsN(default_nan)(s);
     }
 
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        *a = partsN(pick_nan)(a, b, s);
-	return a;
+        return partsN(pick_nan)(a, b, s);
     }
 
     /* Multiply by 0 or Inf */
     record_denormals_used(ab_mask, s);
 
     if (ab_mask & float_cmask_inf) {
-        a->cls = float_class_inf;
-        a->sign = sign;
-        return a;
+        return (FloatPartsN){ .cls = float_class_inf, .sign = sign };
     }
 
     g_assert(ab_mask & float_cmask_zero);
-    a->cls = float_class_zero;
-    a->sign = sign;
-    return a;
+    return (FloatPartsN){ .cls = float_class_zero, .sign = sign };
 }
 
 /*
-- 
2.43.0


