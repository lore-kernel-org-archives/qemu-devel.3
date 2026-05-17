Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF06CCD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPKn-0001hy-BP; Sat, 16 May 2026 20:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKT-0001db-RA
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:01 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKQ-0002Sk-4g
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:01 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8354461da74so444388b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977557; x=1779582357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Er8/h7hcdrH0i8AVq283Mmmr7LBMQsIla5HO90Oj/dc=;
 b=AhLHVCMijufFPOYMQns75EMTaWvbJMWyBtfHcYAx/pMh1myXgs5RhBJdfxwkunbWst
 J4GiJlhphlHZHab9gSSFImV2qdlmEXaio7SRK4kuEqMigCqKQ2MZlY2WOUJzN2SWzAnR
 IxhosP3M88BM2/WnRv0BJR89ND7pWSD6BU4BulDGK6071JkC4ml15q6lrV27Lp14By2U
 LpPnjVPdDVroE0jsN7Y/kxmlkdxOKkh57Nj8GQh1Sl5OLAYArV1NZU9/WqWbnhfSNMSV
 JL/XNVflYaNqja99PB4VmlpJ36byrk7MrbydU5YqvPdbx9GRK/rPN10DwpJKP/bkaXeL
 EwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977557; x=1779582357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Er8/h7hcdrH0i8AVq283Mmmr7LBMQsIla5HO90Oj/dc=;
 b=hpi6u4GsJs5A7yqUZDNXtacu4BFsdASxNq5smoTD5qnfQ1MQp/pyaGqUYW9tgG5bQq
 e4luWpBdmgGi6qQcamATPsCV6tDHpYh9hKSgOHyPl5dXYHXefIzVYmPnAZWWU7tE3xsz
 wfm4VS9faYWclvvEwQBgSIl6puFq+855MR8Km7bV98Hk+K3hke6QS6xkzY52j1mLAp5M
 YPhZls7xzifsIpJ+QBE1BM0pd095FoTSAisBlE/r65RIrKwWy7fB2sDi5MECR+ONrOOs
 fSA/z3QxkuThLBG4VL837I9UwoKMzh0ylLNVgwWBcdQvOL5hW8szFFKQdEN/lbw6kjCn
 /0Kg==
X-Gm-Message-State: AOJu0YzGMsgEP8+Deb8v9kd/+644756bgpOA8COvx1w1hUN2oyhw19Xh
 AE8/qa/vVliwMJDs9m9ltWP0QPlL5g4theLl1G3BmG4ZXD22EE2E5ySoXOH3KdVSREymUq5lJPu
 Z2Jcg
X-Gm-Gg: Acq92OED1l5jGkxbziGWl/pxPQSck5PbMVKYoF5iCAgvOl09Rc7Je397EPG4obkgpdT
 SJHoXrMZ7BvZZ7E9LGU7AsYO7hXE9I4mhPQvzrZ63LW+UpaPSsjBB7ZwyvLwnLRQD6kkxRFF35T
 9ABT8cRTL5PNT4nejka16BFoqwtP2nBSTKxacJca4vBVo0oAlCIsF8ET3wUHLZy6ASm9MJE0gaO
 MGNMkzkbuof4DC3s7wtwsJ3xDcjphgDtz3TzKKbCe8ZWLhW/hlDFDM8BiX04Upv3b6SPcFa18sS
 Qsso0G4jQuSkYwAVlKg6bdHCpyDzJv9ZitEF4z/RfN5DRmmLbURuEnUR77VhZzBaDTkLfIlG4+8
 bXdd2bQVYnPqr174PTv0aAeG9pOnKzwptX0o9Q9MBrvKjhsb+Psv+Xue8hXPtEHXn6UhYZqmiSC
 I6n4p6nSk9N5kinb/XSTtNt4ZOwODT
X-Received: by 2002:a05:6a00:4c82:b0:838:20b7:40ed with SMTP id
 d2e1a72fcca58-83f33d98b22mr9977189b3a.42.1778977556644; 
 Sat, 16 May 2026 17:25:56 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5be71sm9670317b3a.39.2026.05.16.17.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:25:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 03/12] fpu: Return struct from parts{64,128}_muladd
Date: Sat, 16 May 2026 17:25:40 -0700
Message-ID: <20260517002550.321291-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517002550.321291-1-richard.henderson@linaro.org>
References: <20260517002550.321291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 include/fpu/softfloat-parts.h |  9 ++++
 fpu/softfloat.c               | 83 +++++++++++++++++------------------
 fpu/softfloat-parts.c.inc     | 38 ++++++++--------
 3 files changed, 69 insertions(+), 61 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 46618d217e..7170cc7b6a 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -202,6 +202,15 @@ FloatParts64 parts64_mul(const FloatParts64 *a, const FloatParts64 *b,
 FloatParts128 parts128_mul(const FloatParts128 *a, const FloatParts128 *b,
                            float_status *s);
 
+FloatParts64 parts64_muladd(const FloatParts64 *a,
+                            const FloatParts64 *b,
+                            const FloatParts64 *c,
+                            int flags, float_status *s);
+FloatParts128 parts128_muladd(const FloatParts128 *a,
+                              const FloatParts128 *b,
+                              const FloatParts128 *c,
+                              int flags, float_status *s);
+
 FloatParts64 parts64_round_to_int(const FloatParts64 *a,
                                   FloatRoundMode rmode,
                                   int scale, float_status *s,
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7fc6df461e..905ba6ecf8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1906,18 +1906,18 @@ float16 float16_muladd_scalbn(float16 a, float16 b, float16 c,
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
     FloatParts64 pc = float16_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
+    FloatParts64 pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
     /* Before rounding, scale. */
     if (scale) {
-        *pr = parts64_scalbn(pr, scale, status);
+        pr = parts64_scalbn(&pr, scale, status);
     }
-    parts64_uncanon(pr, status, &float16_params, false);
+    parts64_uncanon(&pr, status, &float16_params, false);
     /* After rounding, apply negate result, especially for -0.0. */
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return pack_raw64(pr, &float16_params);
+    return pack_raw64(&pr, &float16_params);
 }
 
 float16 float16_muladd(float16 a, float16 b, float16 c,
@@ -1933,18 +1933,18 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
     FloatParts64 pa = float32_unpack_canonical(a, status);
     FloatParts64 pb = float32_unpack_canonical(b, status);
     FloatParts64 pc = float32_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
+    FloatParts64 pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
     /* Before rounding, scale. */
     if (scale) {
-        *pr = parts64_scalbn(pr, scale, status);
+        pr = parts64_scalbn(&pr, scale, status);
     }
-    parts64_uncanon(pr, status, &float32_params, false);
+    parts64_uncanon(&pr, status, &float32_params, false);
     /* After rounding, apply negate result, especially for -0.0. */
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return pack_raw64(pr, &float32_params);
+    return pack_raw64(&pr, &float32_params);
 }
 
 float64 QEMU_SOFTFLOAT_ATTR
@@ -1954,18 +1954,18 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
     FloatParts64 pc = float64_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
+    FloatParts64 pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
     /* Before rounding, scale. */
     if (scale) {
-        *pr = parts64_scalbn(pr, scale, status);
+        pr = parts64_scalbn(&pr, scale, status);
     }
-    parts64_uncanon(pr, status, &float64_params, false);
+    parts64_uncanon(&pr, status, &float64_params, false);
     /* After rounding, apply negate result, especially for -0.0. */
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return pack_raw64(pr, &float64_params);
+    return pack_raw64(&pr, &float64_params);
 }
 
 static bool force_soft_fma;
@@ -2115,14 +2115,14 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
     FloatParts64 pc = float64_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
+    FloatParts64 pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
     /* Round before applying negate result. */
-    parts64_uncanon(pr, status, &float32_params, false);
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    parts64_uncanon(&pr, status, &float32_params, false);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return float64r32_pack_raw(pr);
+    return float64r32_pack_raw(&pr);
 }
 
 bfloat16 bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
@@ -2131,14 +2131,14 @@ bfloat16 bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
     FloatParts64 pc = bfloat16_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
+    FloatParts64 pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
     /* Round before applying negate result. */
-    parts64_uncanon(pr, status, &bfloat16_params, false);
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    parts64_uncanon(&pr, status, &bfloat16_params, false);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return pack_raw64(pr, &bfloat16_params);
+    return pack_raw64(&pr, &bfloat16_params);
 }
 
 float128 float128_muladd(float128 a, float128 b, float128 c,
@@ -2147,14 +2147,14 @@ float128 float128_muladd(float128 a, float128 b, float128 c,
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
     FloatParts128 pc = float128_unpack_canonical(c, status);
-    FloatParts128 *pr = parts128_muladd(&pa, &pb, &pc, flags, status);
+    FloatParts128 pr = parts128_muladd(&pa, &pb, &pc, flags, status);
 
     /* Round before applying negate result. */
-    parts128_uncanon(pr, status, &float128_params, false);
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    parts128_uncanon(&pr, status, &float128_params, false);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return float128_pack_raw(pr);
+    return float128_pack_raw(&pr);
 }
 
 /*
@@ -5126,7 +5126,7 @@ float32 float32_exp2(float32 a, float_status *status)
     rp = float64_unpack_canonical(float64_one, status);
     for (int i = 0; i < 15; i++) {
         tp = float64_unpack_canonical(float32_exp2_coefficients[i], status);
-        rp = *parts64_muladd(&tp, &xnp, &rp, 0, status);
+        rp = parts64_muladd(&tp, &xnp, &rp, 0, status);
         xnp = parts64_mul(&xnp, &xp, status);
     }
 
@@ -5175,7 +5175,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
         n->sign = a->sign ^ b->sign;
         *cc = 0;
     } else {
-        FloatParts64 *q, q_buf, *r_precise, r_precise_buf;
+        FloatParts64 *q, q_buf, r_precise;
         int float_exception_flags = 0;
         bool is_q_smallish;
         uint32_t r_flags;
@@ -5205,12 +5205,11 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
                                     0, fmt->frac_size);
 
         /* Compute precise remainder */
-        r_precise_buf = *b;
-        r_precise = parts64_muladd(&r_precise_buf, n, a,
+        r_precise = parts64_muladd(b, n, a,
                                    float_muladd_negate_product, status);
 
         /* Round remainder to the target format */
-        *r = *r_precise;
+        *r = r_precise;
         status->float_exception_flags = 0;
         *r = parts64_round_to_fmt(r, status, fmt);
         r_flags = status->float_exception_flags;
@@ -5234,17 +5233,17 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
                          * toward zero) or incremented.
                          */
                         saved_r_sign = r->sign;
-                        saved_r_precise_sign = r_precise->sign;
+                        saved_r_precise_sign = r_precise.sign;
                         r->sign = false;
-                        r_precise->sign = false;
-                        if (parts64_compare(r, r_precise, status, true) <
+                        r_precise.sign = false;
+                        if (parts64_compare(r, &r_precise, status, true) <
                             float_relation_equal) {
                             *dxc = 0x8;
                         } else {
                             *dxc = 0xc;
                         }
                         r->sign = saved_r_sign;
-                        r_precise->sign = saved_r_precise_sign;
+                        r_precise.sign = saved_r_precise_sign;
                     }
                 }
             }
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index ca2d7a15c9..437b333341 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -677,9 +677,8 @@ FloatPartsN partsN(mul)(const FloatPartsN *a, const FloatPartsN *b,
  * Requires A and C extracted into a double-sized structure to provide the
  * extra space for the widening multiply.
  */
-static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
-                                   FloatPartsN *c,
-                                   int flags, float_status *s)
+FloatPartsN partsN(muladd)(const FloatPartsN *a, const FloatPartsN *b,
+                           const FloatPartsN *c, int flags, float_status *s)
 {
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
     int c_mask = float_cmask(c->cls);
@@ -717,10 +716,13 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
         }
 
         /* Narrow with sticky bit, for proper rounding later. */
-        fracN(truncjam)(a, &p_widen);
-        a->sign = p_widen.sign;
-        a->exp = p_widen.exp;
-        return a;
+        FloatPartsN r = {
+            .sign = p_widen.sign,
+            .exp = p_widen.exp,
+            .cls = float_class_normal,
+        };
+        fracN(truncjam)(&r, &p_widen);
+        return r;
     }
 
     /*
@@ -730,8 +732,7 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
      * off to the target-specific pick-a-NaN routine.
      */
     if (unlikely(abc_mask & float_cmask_anynan)) {
-        *a = partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
-        return a;
+        return partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
     }
 
     if (unlikely(ab_mask == float_cmask_infzero)) {
@@ -748,9 +749,7 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
         }
         /* Inf + C == Inf */
         record_denormals_used(abc_mask, s);
-        a->sign = p_sign;
-        a->cls = float_class_inf;
-        return a;
+        return (FloatPartsN){ .sign = p_sign, .cls = float_class_inf };
     }
     record_denormals_used(abc_mask, s);
 
@@ -766,19 +765,20 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
     if (!(c_mask & float_cmask_zero)
         || p_sign == c_sign
         || (flags & float_muladd_suppress_add_product_zero)) {
-        c->sign = c_sign;
-        return c;
+        FloatPartsN r = *c;
+        r.sign = c_sign;
+        return r;
     }
 
  return_sub_zero:
     /* 0 - 0 == -0 for round_down, +0 otherwise. */
-    a->sign = s->float_rounding_mode == float_round_down;
-    a->cls = float_class_zero;
-    return a;
+    return (FloatPartsN){
+        .sign = s->float_rounding_mode == float_round_down,
+        .cls = float_class_zero
+    };
 
  d_nan:
-    *a = partsN(default_nan)(s);
-    return a;
+    return partsN(default_nan)(s);
 }
 
 /*
-- 
2.43.0


