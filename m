Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F91CD3447
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1FN-0005nA-0n; Thu, 07 May 2026 12:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1FL-0005m6-Du
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:06:43 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1FJ-0007HH-2x
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:06:42 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7df05fc49e5so1057963a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169999; x=1778774799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwufvbx5jfOeCU9YUfNQqB3vv3m9DQGfuwS+kcmA360=;
 b=rLWtEGB4NOVa5rL5YBJxgAL7Omayl/IkhYBhcqKAGexGiqlTBEGn94W+VlfuoogeSj
 tE75rJkYBurbk0TfO0D1XaJV4NuQsYfh47nhDhzcFYRoGQupv4SD7BHwHoepp/mif1ce
 T/5g0yx6vosnE4OltSxTrF7TQspI5iIx/8oZJ4Mx1E8Zjol8tguYv/IKnHlqHtpj6Sc6
 tY5lx5y+OL2neuDvyEf2hF2Bb2Yq6yOp/zLurnyL6F11G6qW9VO2JFwj2yZ0QXr/krmV
 RdwYT5llHRqlHv/ilOUCTxe6QN4FVfr77AhoQkAz3ZYjrjgHvzCNh/YbuPIgUYwFpaP3
 oBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169999; x=1778774799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cwufvbx5jfOeCU9YUfNQqB3vv3m9DQGfuwS+kcmA360=;
 b=DzpMkxkezvLANy9kKpwKralSxdWwF+UCluMcfFOMyhY6dSc5WFjxdDv+6KoIAjrFoK
 d9zqe5PDOW75yHe+PCMZrSLdvC5mfyZkNFnygf2rzPsvP94K0A/sIZGV4ejUFz00v9ka
 lBPneUwwMZhrSkv/7rur3lUtpu+pUTC86eGEQPB9ycYLK6bc/My8owIZWDhfarehcylV
 8F265/WkyyIdCh9iUjZkIOsyOcRmWFNej2fsHla9yOErVv6hF7SmcxOeXv5sBEQnyVfh
 e3lg0qBvb0m3eVg3x4/b9ZapPpFc5ObdNEDcL90dmWB+D0puHhppFdDooS+9iKSxavYR
 8UgA==
X-Gm-Message-State: AOJu0Yyv8YnSmpiiSYyXrlU/CgpHyrE85KoqWE09s4oVI/6M/qTeWEhN
 kdPaDvinAPHioCK+8SHh7haoXvRQsiHzS/KvQQjUldo2Q34BFLiK+3wS6dqCpNalnI9aglNU1hm
 Z5vIJ
X-Gm-Gg: AeBDiet1DbKyAkAFAOW1LjAbWblkym0Plb9PflL/iImarRy87o3oSBvjgzZdA1XaCLD
 Gr25o1Eu9tFxwTfg6pf99TlbkA1NXJzG7tPgOFndYlP1d3F7LdZjzPgxLL1+dyDKM7MEDrtiGjh
 /CCyKktGD5g3upNqSyE3KaZDM/6Un6w/+bCLFS8fnU1qrnxxZ8g+BK9hA4G1WVINyrNMtxZgBHc
 S0f9Bt47orYZrj+E7r8qMnGFhf/fFGjsZtYHwNROPzL+PripmXkA+riWX7zbpwb5OWF/y5x2dXl
 VLisJjM3CSQc5B3kgc8kOEJxvUB/Q4/O+yQtKk4JuMzdoG8VSQZIulk3vP6VT7nLsLtzIwVBzWd
 zVYUeaxVXoagCoh1nIBXK6KkZVSEolica/hJAvDPeHte5Yg2O/Ac0MuvUTfY7Gh+h+OxatWKZ2i
 9ncFbudeDQuXhJ9JSwNNtAR0SjDhfnKOzRfSp4xBngkLwbGQ==
X-Received: by 2002:a05:6830:63ca:b0:7dc:e1e6:7687 with SMTP id
 46e09a7af769-7e1deec8566mr5865103a34.4.1778169949224; 
 Thu, 07 May 2026 09:05:49 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/29] fpu: Return struct from parts{64,128}_addsub
Date: Thu,  7 May 2026 11:05:14 -0500
Message-ID: <20260507160518.444797-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
 include/fpu/softfloat-parts.h |  5 ++++
 fpu/softfloat.c               | 30 +++++++++++------------
 fpu/softfloat-parts.c.inc     | 45 ++++++++++++++++++-----------------
 3 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 1285946321..9504d0daa0 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -182,6 +182,11 @@ FloatParts128 parts128_return_nan(const FloatParts128 *a, float_status *s);
  * Operations
  */
 
+FloatParts64 parts64_addsub(const FloatParts64 *a, const FloatParts64 *b,
+                            float_status *s, bool subtract);
+FloatParts128 parts128_addsub(const FloatParts128 *a, const FloatParts128 *b,
+                              float_status *s, bool subtract);
+
 FloatRelation parts64_compare(const FloatParts64 *a, const FloatParts64 *b,
                               float_status *s, bool quiet);
 FloatRelation parts128_compare(const FloatParts128 *a, const FloatParts128 *b,
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c0bf255076..7234ab27da 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1582,9 +1582,9 @@ float16_addsub(float16 a, float16 b, float_status *status, bool subtract)
 {
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return float16_round_pack_canonical(pr, status);
+    return float16_round_pack_canonical(&pr, status);
 }
 
 float16 float16_add(float16 a, float16 b, float_status *status)
@@ -1602,9 +1602,9 @@ soft_f32_addsub(float32 a, float32 b, float_status *status, bool subtract)
 {
     FloatParts64 pa = float32_unpack_canonical(a, status);
     FloatParts64 pb = float32_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return float32_round_pack_canonical(pr, status);
+    return float32_round_pack_canonical(&pr, status);
 }
 
 static float32 soft_f32_add(float32 a, float32 b, float_status *status)
@@ -1622,9 +1622,9 @@ soft_f64_addsub(float64 a, float64 b, float_status *status, bool subtract)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return float64_round_pack_canonical(pr, status);
+    return float64_round_pack_canonical(&pr, status);
 }
 
 static float64 soft_f64_add(float64 a, float64 b, float_status *status)
@@ -1717,9 +1717,9 @@ static float64 float64r32_addsub(float64 a, float64 b, float_status *status,
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return float64r32_round_pack_canonical(pr, status);
+    return float64r32_round_pack_canonical(&pr, status);
 }
 
 float64 float64r32_add(float64 a, float64 b, float_status *status)
@@ -1737,9 +1737,9 @@ bfloat16_addsub(bfloat16 a, bfloat16 b, float_status *status, bool subtract)
 {
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return bfloat16_round_pack_canonical(pr, status);
+    return bfloat16_round_pack_canonical(&pr, status);
 }
 
 bfloat16 bfloat16_add(bfloat16 a, bfloat16 b, float_status *status)
@@ -1757,9 +1757,9 @@ float128_addsub(float128 a, float128 b, float_status *status, bool subtract)
 {
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
-    FloatParts128 *pr = parts128_addsub(&pa, &pb, status, subtract);
+    FloatParts128 pr = parts128_addsub(&pa, &pb, status, subtract);
 
-    return float128_round_pack_canonical(pr, status);
+    return float128_round_pack_canonical(&pr, status);
 }
 
 float128 float128_add(float128 a, float128 b, float_status *status)
@@ -1775,15 +1775,15 @@ float128 float128_sub(float128 a, float128 b, float_status *status)
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
index 07bd0b2fad..2114797aca 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -524,11 +524,11 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
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
 
     /*
      * For addition and subtraction, we will consume an
@@ -538,10 +538,15 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
         record_denormals_used(ab_mask, s);
     }
 
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
@@ -549,7 +554,7 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
         }
 
         if (ab_mask == float_cmask_zero) {
-            a->sign = s->float_rounding_mode == float_round_down;
+            a.sign = s->float_rounding_mode == float_round_down;
             return a;
         }
 
@@ -558,23 +563,22 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
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
 
@@ -587,25 +591,22 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
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
 
  p_nan:
-    *a = partsN(pick_nan)(a, b, s);
-    return a;
+    return partsN(pick_nan)(a_orig, b_orig, s);
 }
 
 /*
-- 
2.43.0


