Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A666FF8864
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpl-0000ia-Sn; Sun, 26 Apr 2026 09:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzp2-0006qS-AC
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:47:05 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzot-0001vX-Nv
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:50 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2aae146b604so62462345ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211205; x=1777816005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMjZBAFwkU0Rtj4ZBMRtvRhbF7S8/ZqmxhOX5o1ySM4=;
 b=vsOS6lcKwKm54OOPSNvUkhpqrYRxvP27fLiKBuRyNBTIol6gHWr5z6MYDmNBLD/Evk
 XaPyvb61jQ7yG30pN8xeC7BZTgL+gTjkcGK9GjXGouKR8BzbQjblp7/eLZXC00QgYdCn
 TAdymJDnJB9kqA50/jzrWiduCE3qzyzingUlQ1iBQFGTBoTEpjrr6YXjqaF394xphY/H
 GIMeKBOMsOrUTPFmxcFpznZYpSMXQJt5wXnUJsWLhijiWxjstsDHgh4cPeIzLQuSd1u7
 02c9sR0aMhme+l9/xmfN3FWUnnNzeia55eKH/o5umVmNptxIRx1H3cng7jzga04xII4m
 9WSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211205; x=1777816005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yMjZBAFwkU0Rtj4ZBMRtvRhbF7S8/ZqmxhOX5o1ySM4=;
 b=H7wVCPmymZT/pH7rhGOdAu8LfDES3mcFjFGOaNcBZN1zVR8t1WT5STcSxiEwxMFkB5
 dmF5gUwqYIIAmkZRZKuYOkmRcI1E6D62KLT7E/Q3jOlX4MEnTX8i3DszH4TM1hG6lafA
 AZctwgQCbSSNjLLmhxrYdIFYIDPFVWjpXCgSaZqg4iBSqCXnrrwkgU6VqE3yy1y/o77A
 FBGBJQG7CmBCFT0X7SxeeBCEaaCw/4rKlChDn0JCGKCnWii484Rgv76xqjm9USd5f3q6
 O9ejviHmQHnpvwCrn5Q2aokcbAYI9KlYy1i78I+imsho892cQbpRUG+CKRXRP4SY+36v
 joNA==
X-Gm-Message-State: AOJu0YyA9iTE3E97VqW+EoGqp6FkZpzUaPxxajDQYScZe0NIpZpODVuG
 1cmyVEQNZNQIKUCrNkbGoS/b1SlIW23lxTtqWT1uusUaZjmBqW94gE6c2hj4/RmQanyAZzyimtR
 G/fhcq58=
X-Gm-Gg: AeBDievYlpYEdZwhqLBRQsFAeGYWQ7l+UgE5/P86qu1ePnq/LnHt8Kd16n2EBpyflDF
 /3Df379xrzIE/fdMRk1ToaDSE5Pb8eHkXCjFmkWNIruu4mDl5PblLHAqP5vHTgfKjVL6ELY8Uiz
 kaqLv37BGNm0r50mWJFf3d4wvuigtWt2jAS3VpenVJT4uX1upvi6TS82Z7VvKgEpzefWRSyNK8X
 whqVbqA8jXm7mDyT6PnCtvDe2qCc9BVM4Ihw7LugSV0eDE6bcqkHi9tchea992xda7WVy9VS5v8
 CpVlLksBmrcYi4jDbCHSOJioPebXyHOrlxuYiAkAFFo9kyVtrbiwryrbpRmi+sB91RPaZsJ9dea
 tNKD4J4JI8MpOIjOPLEb7CgYe97mncNt22jwg+eZfOb2eT3gqgktyJz6Kmz9BgIeGKjujFf95OH
 m0xXUaY8GMpf2jUh0PdzydvVUxkmtmHuPjnV/JpErk
X-Received: by 2002:a17:903:17cb:b0:2b2:67cd:9963 with SMTP id
 d9443c01a7336-2b5f9fd5c04mr397257095ad.38.1777211205068; 
 Sun, 26 Apr 2026 06:46:45 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:46:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 79/84] fpu: Return struct from parts{64,128}_addsub
Date: Sun, 26 Apr 2026 23:39:56 +1000
Message-ID: <20260426134002.865628-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h |  5 ++++
 fpu/softfloat.c               | 30 +++++++++++------------
 fpu/softfloat-parts.c.inc     | 45 ++++++++++++++++++-----------------
 3 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index f2c31eb7a6..8522b916f3 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -179,6 +179,11 @@ FloatParts128 parts128_pick_nan(const FloatParts128 *, const FloatParts128 *,
  * Operations
  */
 
+FloatParts64 parts64_addsub(const FloatParts64 *a, const FloatParts64 *b,
+                            float_status *s, bool subtract);
+FloatParts128 parts128_addsub(const FloatParts128 *a, const FloatParts128 *b,
+                              float_status *s, bool subtract);
+
 FloatParts64 parts64_div(const FloatParts64 *a, const FloatParts64 *b,
                          float_status *s);
 FloatParts128 parts128_div(const FloatParts128 *a, const FloatParts128 *b,
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2db08ca660..484db3ddf6 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1579,9 +1579,9 @@ float16_addsub(float16 a, float16 b, float_status *status, bool subtract)
 {
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return float16_round_pack_canonical(pr, status);
+    return float16_round_pack_canonical(&pr, status);
 }
 
 float16 float16_add(float16 a, float16 b, float_status *status)
@@ -1599,9 +1599,9 @@ soft_f32_addsub(float32 a, float32 b, float_status *status, bool subtract)
 {
     FloatParts64 pa = float32_unpack_canonical(a, status);
     FloatParts64 pb = float32_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return float32_round_pack_canonical(pr, status);
+    return float32_round_pack_canonical(&pr, status);
 }
 
 static float32 soft_f32_add(float32 a, float32 b, float_status *status)
@@ -1619,9 +1619,9 @@ soft_f64_addsub(float64 a, float64 b, float_status *status, bool subtract)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return float64_round_pack_canonical(pr, status);
+    return float64_round_pack_canonical(&pr, status);
 }
 
 static float64 soft_f64_add(float64 a, float64 b, float_status *status)
@@ -1714,9 +1714,9 @@ static float64 float64r32_addsub(float64 a, float64 b, float_status *status,
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return float64r32_round_pack_canonical(pr, status);
+    return float64r32_round_pack_canonical(&pr, status);
 }
 
 float64 float64r32_add(float64 a, float64 b, float_status *status)
@@ -1734,9 +1734,9 @@ bfloat16_addsub(bfloat16 a, bfloat16 b, float_status *status, bool subtract)
 {
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return bfloat16_round_pack_canonical(pr, status);
+    return bfloat16_round_pack_canonical(&pr, status);
 }
 
 bfloat16 bfloat16_add(bfloat16 a, bfloat16 b, float_status *status)
@@ -1754,9 +1754,9 @@ float128_addsub(float128 a, float128 b, float_status *status, bool subtract)
 {
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
-    FloatParts128 *pr = parts128_addsub(&pa, &pb, status, subtract);
+    FloatParts128 pr = parts128_addsub(&pa, &pb, status, subtract);
 
-    return float128_round_pack_canonical(pr, status);
+    return float128_round_pack_canonical(&pr, status);
 }
 
 float128 float128_add(float128 a, float128 b, float_status *status)
@@ -1772,15 +1772,15 @@ float128 float128_sub(float128 a, float128 b, float_status *status)
 static floatx80 QEMU_FLATTEN
 floatx80_addsub(floatx80 a, floatx80 b, float_status *status, bool subtract)
 {
-    FloatParts128 pa, pb, *pr;
+    FloatParts128 pa, pb;
 
     if (!floatx80_unpack_canonical(&pa, a, status) ||
         !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
 
-    pr = parts128_addsub(&pa, &pb, status, subtract);
-    return floatx80_round_pack_canonical(pr, status);
+    pa = parts128_addsub(&pa, &pb, status, subtract);
+    return floatx80_round_pack_canonical(&pa, status);
 }
 
 floatx80 floatx80_add(floatx80 a, floatx80 b, float_status *status)
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 244fdd90d2..6d65b7bfe3 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -524,15 +524,14 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
  * according to the IEC/IEEE Standard for Binary Floating-Point
  * Arithmetic.
  */
-static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
-                                   float_status *s, bool subtract)
+FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
+                           const FloatPartsN *b_orig,
+                           float_status *s, bool subtract)
 {
-    bool b_sign = b->sign ^ subtract;
-    int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
+    int ab_mask = float_cmask(a_orig->cls) | float_cmask(b_orig->cls);
 
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        *a = partsN(pick_nan)(a, b, s);
-        return a;
+        return partsN(pick_nan)(a_orig, b_orig, s);
     }
 
     /*
@@ -541,10 +540,15 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
      */
     record_denormals_used(ab_mask, s);
 
-    if (a->sign != b_sign) {
+    FloatPartsN a = *a_orig;
+    FloatPartsN b = *b_orig;
+
+    b.sign ^= subtract;
+
+    if (a.sign != b.sign) {
         /* Subtraction */
         if (likely(cmask_is_only_normals(ab_mask))) {
-            if (partsN(sub_normal)(a, b)) {
+            if (partsN(sub_normal)(&a, &b)) {
                 return a;
             }
             /* Subtract was exact, fall through to set sign. */
@@ -552,28 +556,27 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
         }
 
         if (ab_mask == float_cmask_zero) {
-            a->sign = s->float_rounding_mode == float_round_down;
+            a.sign = s->float_rounding_mode == float_round_down;
             return a;
         }
 
         if (ab_mask & float_cmask_inf) {
-            if (a->cls != float_class_inf) {
+            if (a.cls != float_class_inf) {
                 /* N - Inf */
-                goto return_b;
+                return b;
             }
-            if (b->cls != float_class_inf) {
+            if (b.cls != float_class_inf) {
                 /* Inf - N */
                 return a;
             }
             /* Inf - Inf */
             float_raise(float_flag_invalid | float_flag_invalid_isi, s);
-            *a = partsN(default_nan)(s);
-            return a;
+            return partsN(default_nan)(s);
         }
     } else {
         /* Addition */
         if (likely(cmask_is_only_normals(ab_mask))) {
-            partsN(add_normal)(a, b);
+            partsN(add_normal)(&a, &b);
             return a;
         }
 
@@ -582,20 +585,18 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
         }
 
         if (ab_mask & float_cmask_inf) {
-            a->cls = float_class_inf;
+            a.cls = float_class_inf;
             return a;
         }
     }
 
-    if (b->cls == float_class_zero) {
-        g_assert(is_anynorm(a->cls));
+    if (b.cls == float_class_zero) {
+        g_assert(is_anynorm(a.cls));
         return a;
     }
 
-    g_assert(a->cls == float_class_zero);
-    g_assert(is_anynorm(b->cls));
- return_b:
-    b->sign = b_sign;
+    g_assert(a.cls == float_class_zero);
+    g_assert(is_anynorm(b.cls));
     return b;
 }
 
-- 
2.43.0


