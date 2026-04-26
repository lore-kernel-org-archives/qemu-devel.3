Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB70FF8866
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzph-0000VO-LQ; Sun, 26 Apr 2026 09:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoc-0006CB-9Q
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:31 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoa-0001jW-Jq
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:30 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b25cf1b5f0so51284955ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211187; x=1777815987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2XVMrD/f4RJUgxWV8u8BjTDkroVGGY6C/cEhJrX7QLw=;
 b=nnmT+XE0znfpP/299NN3seaopbeAodNt31G+hfFePzh0kN6bdjbitkoR4dkramzvxH
 cCKMf0cUP1CU+xzXVMy7NVQdtja7LgJ5lUYd/ylKBKo6akMDqIhRzojWnfkGYwB0kcBl
 g9unxlonIwo9pPWDisHmyHk28XTDmvYpadB9D/wnTzdbHfnefAB1YuqBdbMwIdtU7V7Z
 R4an/RnvxR4r2O7/ydXRa8TdKBrQzunqG59Ja7nzy37MV1sZpfHdCtIf852giW16FBI5
 Xl6JkZS5Ywtt63dh1+5GVz7Q+zmdmG8g0MEkfkFLLuApNEAB3+6kyGOb/G293yk7DokU
 aB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211187; x=1777815987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2XVMrD/f4RJUgxWV8u8BjTDkroVGGY6C/cEhJrX7QLw=;
 b=VVWssERS5tBxRZwZRmA52FHYqkzxSRiY0drSPO8pumCIMLfSnmjBK4xUF5eiTIT+oB
 /kGIkwS2o756YfBvpyQ+B6zE4hUBpVgDmUy9HzdfDiKzxLAicCZL2kPp2JXEnUXyDcLV
 itMa4Aq6oJy8+eJapTdD+62uk/ld6xqSOfoiZw6UBgKWiJlsdv4fJOgOp84rfjY+menD
 n7GK2QL51aN/6D84kJkgMz9aDfQANgo9rlw2m7F20lbstTj9Yqm3vMTPqynEyiFrVVpk
 hcCe0ODjTqWynOdUxtjdPhZ2xQ4//Kx/DjuNGgjBmBOPLvTNwRJmg3ayf1OEqskLLndU
 gfZA==
X-Gm-Message-State: AOJu0Yxuvod/I83Juox7EWQu6Yk7rLP3lz38/9HiK1YUeO5wr2NIk/UY
 iXbmpjMGkSWVsSzPui/CtHUBWDirGW9LE7pb4aPnKLq89REjs/QYCTdqdeoBiM8wxlhtj8BznHn
 KDuf+MME=
X-Gm-Gg: AeBDiet32Kakw2LYyDgoMhM2oVvQIGBXutyKg577C/5etpwBuqHgJXB9Z/kLxtb8Tvh
 X6uRceuIgBSm6lpxBnc0PbBta3helmsogIjtp00g8kaxJUUhOmuPuDFKFDqCObC0aZFpDxd0fzU
 b3OKmVIpi6aMLEbzgTgeCHR9kY5tobg8c5BrGi573DCqqWeSy3d9fMdljyGlB3PCqf7e90efmte
 MU311qpVsDi+SXDHMHh/bBqSXwA8cHdZ3FZW8HcctBknX2V4yTjIHKwZgcM3BuMf9WneoJUhuox
 1Tw8C8HJh0HDjz1CiKso54mloMON8dU8JQwGohV0TTdVKnPqSo/qf4kkK9dSVDiHE+zkwaLuypM
 2/j/o/6X7AZzJWXH0imeKfLY1OcVapnQw81oF8HcseENy7rsNilgUjjgQ7RTQGC3BqvQlgzf8Tn
 /O0Y9nDyKBqVIRg68BfdhY7wP04yX6q5we4AQwQLiE
X-Received: by 2002:a17:902:f550:b0:2b2:4611:5dca with SMTP id
 d9443c01a7336-2b5f9f1c1edmr408094765ad.24.1777211187215; 
 Sun, 26 Apr 2026 06:46:27 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:46:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 73/84] fpu: Introduce record_denormals_used
Date: Sun, 26 Apr 2026 23:39:50 +1000
Message-ID: <20260426134002.865628-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           |  8 +++++++
 fpu/softfloat-parts.c.inc | 49 +++++++++++----------------------------
 2 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0c931842c3..1423695a5a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -442,6 +442,14 @@ static inline bool is_anynorm(FloatClass c)
     return float_cmask(c) & float_cmask_anynorm;
 }
 
+/* Record when denormals have been used. */
+static void record_denormals_used(int mask, float_status *s)
+{
+    if (unlikely(mask & float_cmask_denormal)) {
+        float_raise(float_flag_input_denormal_used, s);
+    }
+}
+
 /* FloatParts256 is entirely internal, for parts128_mul* */
 typedef struct {
     FloatClass cls;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5eaac357ec..82d59df406 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -534,9 +534,8 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
      * For addition and subtraction, we will consume an
      * input denormal unless the other input is a NaN.
      */
-    if ((ab_mask & (float_cmask_denormal | float_cmask_anynan)) ==
-        float_cmask_denormal) {
-        float_raise(float_flag_input_denormal_used, s);
+    if (!(ab_mask & float_cmask_anynan)) {
+        record_denormals_used(ab_mask, s);
     }
 
     if (a->sign != b_sign) {
@@ -623,9 +622,7 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     if (likely(cmask_is_only_normals(ab_mask))) {
         FloatPartsW tmp;
 
-        if (ab_mask & float_cmask_denormal) {
-            float_raise(float_flag_input_denormal_used, s);
-        }
+        record_denormals_used(ab_mask, s);
 
         fracN(mulw)(&tmp, a, b);
         fracN(truncjam)(a, &tmp);
@@ -653,9 +650,7 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     }
 
     /* Multiply by 0 or Inf */
-    if (ab_mask & float_cmask_denormal) {
-        float_raise(float_flag_input_denormal_used, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     if (ab_mask & float_cmask_inf) {
         a->cls = float_class_inf;
@@ -784,9 +779,7 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
      * this matches the set of cases where we consumed a
      * denormal input.
      */
-    if (abc_mask & float_cmask_denormal) {
-        float_raise(float_flag_input_denormal_used, s);
-    }
+    record_denormals_used(abc_mask, s);
     return a;
 
  return_sub_zero:
@@ -819,9 +812,7 @@ FloatPartsN partsN(div)(const FloatPartsN *a, const FloatPartsN *b,
     r.exp -= b->exp;
 
     if (likely(cmask_is_only_normals(ab_mask))) {
-        if (ab_mask & float_cmask_denormal) {
-            float_raise(float_flag_input_denormal_used, s);
-        }
+        record_denormals_used(ab_mask, s);
         r.exp -= fracN(div)(&r, b);
         return r;
     }
@@ -841,8 +832,8 @@ FloatPartsN partsN(div)(const FloatPartsN *a, const FloatPartsN *b,
         return partsN(pick_nan)(a, b, s);
     }
 
-    if ((ab_mask & float_cmask_denormal) && b->cls != float_class_zero) {
-        float_raise(float_flag_input_denormal_used, s);
+    if (b->cls != float_class_zero) {
+        record_denormals_used(ab_mask, s);
     }
 
     /* Inf / X */
@@ -877,9 +868,7 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
 
     if (likely(cmask_is_only_normals(ab_mask))) {
-        if (ab_mask & float_cmask_denormal) {
-            float_raise(float_flag_input_denormal_used, s);
-        }
+        record_denormals_used(ab_mask, s);
         fracN(modrem)(a, b, mod_quot);
         return a;
     }
@@ -901,9 +890,7 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
         return a;
     }
 
-    if (ab_mask & float_cmask_denormal) {
-        float_raise(float_flag_input_denormal_used, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     /* N % Inf; 0 % N */
     g_assert(b->cls == float_class_inf || a->cls == float_class_zero);
@@ -1493,9 +1480,7 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
         if ((flags & (minmax_isnum | minmax_isnumber))
             && !(ab_mask & float_cmask_snan)
             && (ab_mask & ~float_cmask_qnan)) {
-            if (ab_mask & float_cmask_denormal) {
-                float_raise(float_flag_input_denormal_used, s);
-            }
+            record_denormals_used(ab_mask, s);
             return is_nan(a->cls) ? b : a;
         }
 
@@ -1521,9 +1506,7 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
         return a;
     }
 
-    if (ab_mask & float_cmask_denormal) {
-        float_raise(float_flag_input_denormal_used, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     a_exp = a->exp;
     b_exp = b->exp;
@@ -1594,9 +1577,7 @@ static FloatRelation partsN(compare)(FloatPartsN *a, FloatPartsN *b,
     if (likely(cmask_is_only_normals(ab_mask))) {
         FloatRelation cmp;
 
-        if (ab_mask & float_cmask_denormal) {
-            float_raise(float_flag_input_denormal_used, s);
-        }
+        record_denormals_used(ab_mask, s);
 
         if (a->sign != b->sign) {
             goto a_sign;
@@ -1623,9 +1604,7 @@ static FloatRelation partsN(compare)(FloatPartsN *a, FloatPartsN *b,
         return float_relation_unordered;
     }
 
-    if (ab_mask & float_cmask_denormal) {
-        float_raise(float_flag_input_denormal_used, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     if (ab_mask & float_cmask_zero) {
         if (ab_mask == float_cmask_zero) {
-- 
2.43.0


