Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566C0FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEuk-0006RJ-Jn; Wed, 29 Apr 2026 20:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuh-0006GJ-DM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:55 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuf-0001lR-3B
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:55 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so149271b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507552; x=1778112352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s95gOsMYgi/f4zhiYit5ShyHyWR6YE2CuPY1Rv/+Q0w=;
 b=lEcO4nFgVlg+amvS8SOhRB39eMdkTgvoKzZi7etINZPsMScsF5ZCwVhjLpzyvI81yL
 DO8NiLvJtbCexJIHdZFklCCAXQD+HF7o1RT+kYPf8C9hkn12YMvXcTWNwzgt8Ga2sCFb
 TLjIUAtGhzZ4fAoai2ysIbGLlMUZWXHNilJfk2hqxYaDKLvHtNIDtDw21cbm9bMLztpd
 CRycssZs9x1sVUGvF9rh4UcQUV3zj9gD3x8BNYQ04H2Afsy06XZjnu5sTNOHRIKUD76q
 02CINe40LrZa946Q7LsQ0qvJvaIWgGBSqwbm0Om6girnMrWfHc4fpC91V3QFuZeVbxw0
 RFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507552; x=1778112352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s95gOsMYgi/f4zhiYit5ShyHyWR6YE2CuPY1Rv/+Q0w=;
 b=Uq0MFYfOfG89TAIuQCjmtxUb1qdGAhBDs9Wo9W9cxZDMBA7iv1nHo6K5AgcQOIFIXZ
 K9k+dEMdyYAKTPTdUVKo2yd1PZML7B6pkyvoMarDvfk1PJI3uWFFaPSczZQZzyF+zc9J
 gvDnKPYozbwG+q7/DFvsmHahTR8nYgl/+acIE2X2brFvWwnjKi+oYjzlJ0EYmE5s96pG
 pGXodgy7GY8SNGS9N35tT1YmIphe4b87psJLwlwKu/gxc0KNeEAgfcLzhCJwWJBJ0GLL
 v43KeVVslbkX8KahJ95mC+fF6GbqOQikc4LgA3KPU/rQSHalDKk8gKpEzWwv1RJSVRa9
 J3Xg==
X-Gm-Message-State: AOJu0Yy7+o6hops143xKCT9j3rXbCfcNyOnhu7beZP/4mRVmonSuYbXO
 BPaA+ah27TRqScD/PoVzl1wr05mW9fL/yWL0Im7pQuDgEnMrUsltNdllnPkj7dLnS1oZ1iFOTj4
 nH/aOsVQ=
X-Gm-Gg: AeBDievKYoX/rUtx8NY9XhgDO4QOIw2aWzlnf8qtUFk2o295vJbtZtq59Xt/BvRl1z/
 VWm74chdvt+ip2eddMdhOO49dqppE0l+lr8e8wi2Cn1X1fkmCj053hoLsqt06gvkNJBWHcM6mvK
 ZPQf41bDFu6dKVRr9F8VuG1E2IboHusyH/F/hn+RpKFs/ERkQ//JP8REkHsWLyRU9VNftmOO/JZ
 yh/6XH93Swulj8+BRKTrNNW8bKwoge9PIj5qBPA2GIG5yt4YoMaV48edP7uvbfzeu4YeFsmN0WZ
 bxwTO/ref0DI5lqI8wLjo1nZIHIhrAw8IOnBk8UTtIAY1629297AeS1uQq0qSY63L/YUeRs0NKr
 Uiuq3Xi8w4F3R6DPX4LzWbCXn6nB//cXFelOS40kBlsboiUSvG9wzmn/mPOmgBMwKvzt2obDION
 zU3KhkHDq4/cIF8giTsTkF0AGZbtaTk7QzoDDwoi/e
X-Received: by 2002:a05:6a00:1d94:b0:82d:556b:7a01 with SMTP id
 d2e1a72fcca58-834fe0aa898mr652715b3a.16.1777507551438; 
 Wed, 29 Apr 2026 17:05:51 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 10/40] fpu: Export FloatFmt structures
Date: Thu, 30 Apr 2026 10:04:53 +1000
Message-ID: <20260430000524.56046-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Export most of the FloatFmt structures.
Skip float16_params_ahp and the floatx80 precisions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h | 48 ++++++++++++++++++++++++++++++
 fpu/softfloat.c               | 55 +++++------------------------------
 2 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 13c1f3d2d6..a3ae12bb45 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -18,6 +18,54 @@
 #ifndef SOFTFLOAT_PARTS_H
 #define SOFTFLOAT_PARTS_H
 
+/* Format-specific handling of exp == exp_max */
+typedef enum __attribute__((__packed__)) {
+    /* exp==max, frac==0 ? infinity : nan; this is ieee standard. */
+    float_expmax_ieee,
+    /* exp==max is a normal number; no infinity or nan representation. */
+    float_expmax_normal,
+    /* exp==max, frac==max ? nan : normal; no infinity representation. */
+    float_expmax_e4m3,
+} FloatFmtExpMaxKind;
+
+/*
+ * Structure holding all of the relevant parameters for a format.
+ *   exp_size: the size of the exponent field
+ *   exp_bias: the offset applied to the exponent field
+ *   exp_max: the maximum normalised exponent
+ *   frac_size: the size of the fraction field
+ *   frac_shift: shift to normalise the fraction with DECOMPOSED_BINARY_POINT
+ * The following are computed based the size of fraction
+ *   round_mask: bits below lsb which must be rounded
+ * The following optional modifiers are available:
+ *   exp_max_kind: affects how exp == exp_max is interpreted
+ *   has_explicit_bit: has an explicit integer bit; this affects whether
+ *       the float_status floatx80_behaviour handling applies
+ *   overflow_raises_invalid: for float_expmax_normal, raise invalid
+ *       instead of overflow.
+ */
+typedef struct {
+    int exp_size;
+    int exp_bias;
+    int exp_re_bias;
+    int exp_max;
+    int frac_size;
+    int frac_shift;
+    FloatFmtExpMaxKind exp_max_kind;
+    bool has_explicit_bit;
+    bool overflow_raises_invalid;
+    uint64_t round_mask;
+} FloatFmt;
+
+extern const FloatFmt float4_e2m1_params;
+extern const FloatFmt float8_e4m3_params;
+extern const FloatFmt float8_e5m2_params;
+extern const FloatFmt float16_params;
+extern const FloatFmt bfloat16_params;
+extern const FloatFmt float32_params;
+extern const FloatFmt float64_params;
+extern const FloatFmt float128_params;
+
 /*
  * Classify a floating point number. Everything above float_class_qnan
  * is a NaN so cls >= float_class_qnan is any NaN.
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index cd75df3160..d3277e3f60 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -457,45 +457,6 @@ typedef struct {
 #define DECOMPOSED_BINARY_POINT    63
 #define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
 
-/* Format-specific handling of exp == exp_max */
-typedef enum __attribute__((__packed__)) {
-    /* exp==max, frac==0 ? infinity : nan; this is ieee standard. */
-    float_expmax_ieee,
-    /* exp==max is a normal number; no infinity or nan representation. */
-    float_expmax_normal,
-    /* exp==max, frac==max ? nan : normal; no infinity representation. */
-    float_expmax_e4m3,
-} FloatFmtExpMaxKind;
-
-/*
- * Structure holding all of the relevant parameters for a format.
- *   exp_size: the size of the exponent field
- *   exp_bias: the offset applied to the exponent field
- *   exp_max: the maximum normalised exponent
- *   frac_size: the size of the fraction field
- *   frac_shift: shift to normalise the fraction with DECOMPOSED_BINARY_POINT
- * The following are computed based the size of fraction
- *   round_mask: bits below lsb which must be rounded
- * The following optional modifiers are available:
- *   exp_max_kind: affects how exp == exp_max is interpreted
- *   has_explicit_bit: has an explicit integer bit; this affects whether
- *       the float_status floatx80_behaviour handling applies
- *   overflow_raises_invalid: for float_expmax_normal, raise invalid
- *       instead of overflow.
- */
-typedef struct {
-    int exp_size;
-    int exp_bias;
-    int exp_re_bias;
-    int exp_max;
-    int frac_size;
-    int frac_shift;
-    FloatFmtExpMaxKind exp_max_kind;
-    bool has_explicit_bit;
-    bool overflow_raises_invalid;
-    uint64_t round_mask;
-} FloatFmt;
-
 /* Expand fields based on the size of exponent and fraction */
 #define FLOAT_PARAMS_(E)                                \
     .exp_size       = E,                                \
@@ -509,12 +470,12 @@ typedef struct {
     .frac_shift     = (-F - 1) & 63,                    \
     .round_mask     = (1ull << ((-F - 1) & 63)) - 1
 
-static const FloatFmt float4_e2m1_params = {
+const FloatFmt float4_e2m1_params = {
     FLOAT_PARAMS(2, 1),
     .exp_max_kind = float_expmax_normal,
 };
 
-static const FloatFmt float8_e4m3_params = {
+const FloatFmt float8_e4m3_params = {
     FLOAT_PARAMS(4, 3),
     .exp_max_kind = float_expmax_e4m3
 };
@@ -522,11 +483,11 @@ static const FloatFmt float8_e4m3_params = {
 /* 110 << frac_shift, with the implicit bit set */
 #define E4M3_NORMAL_FRAC_MAX  0xe000000000000000ull
 
-static const FloatFmt float8_e5m2_params = {
+const FloatFmt float8_e5m2_params = {
     FLOAT_PARAMS(5, 2)
 };
 
-static const FloatFmt float16_params = {
+const FloatFmt float16_params = {
     FLOAT_PARAMS(5, 10)
 };
 
@@ -536,19 +497,19 @@ static const FloatFmt float16_params_ahp = {
     .overflow_raises_invalid = true,
 };
 
-static const FloatFmt bfloat16_params = {
+const FloatFmt bfloat16_params = {
     FLOAT_PARAMS(8, 7)
 };
 
-static const FloatFmt float32_params = {
+const FloatFmt float32_params = {
     FLOAT_PARAMS(8, 23)
 };
 
-static const FloatFmt float64_params = {
+const FloatFmt float64_params = {
     FLOAT_PARAMS(11, 52)
 };
 
-static const FloatFmt float128_params = {
+const FloatFmt float128_params = {
     FLOAT_PARAMS(15, 112)
 };
 
-- 
2.43.0


