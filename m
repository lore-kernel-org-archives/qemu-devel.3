Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2E7FF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpV-0007el-P8; Sun, 26 Apr 2026 09:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoF-0005wK-Rd
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:11 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoC-0001Ut-JG
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:06 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ad9a9be502so58239345ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211148; x=1777815948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s95gOsMYgi/f4zhiYit5ShyHyWR6YE2CuPY1Rv/+Q0w=;
 b=Ay4kyAePka02/goQCElt3a4a58enaFMmJz35ZAUr0dj/F+Ej0IeIR2U9BkQLMaiyM7
 XS75rtaiocElAQEsa9qUc8qUkKh4w3BMdiNaXSQPyFJO1MJU5lKUTImqtV3Ik7fD8mit
 HAcgNds+OKdsVZt/5N+VTZCDtRYgI54znIynONJlfbEVPiUPJ9hJWUVbxgfIoqrebR/p
 PEYFydr0iSRUJiT38ErhOBQuENOl3+vIGh+f3Jt302htq2m3xWA6TqL7knVl6tHWrWDA
 Z2ieLjmTQpXv6mMINes7h083n26aZ3agz9BC4RhoSvUC26W6p7RR2woxCotv73i48htM
 J9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211148; x=1777815948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s95gOsMYgi/f4zhiYit5ShyHyWR6YE2CuPY1Rv/+Q0w=;
 b=HAG3+BS8ITTZoWE6Cq4zcs2SgvjwQjeYN6riusZX0JbTsG3xloi8lATy/fPOymHnXK
 op2XqNSe5IsGtWFVaugyUAN6CxfQUY/MDR0IxP9dUcs2QZGqUJMxebMWvUVQQJNyVdmy
 i5F9FduARWCjpBsIPx0PjNZMRQCC1mQfPKl+pV5BZ7Q3uwIQN5JC2LEjQkV9J0JQaN7G
 NDgeK11+Jwa2YSDtu0N/ZhQaT0GG3q2u4N4CmUwHJR60XwOGxwkxUgFW59Uhs5EE+wjj
 0zIHkZlxusRNa1XEyUoh1FZFh0OEudihCYgr8CnqAjKaZQ4YF1V2Ua4gg4xUJUp+45jO
 RedQ==
X-Gm-Message-State: AOJu0YzPW+OEziVRvLdQxHJdB7g8o2XyC0KgB4Z2RcNtpqHDdcJ5XwBr
 CLpjFu94c1MXV39JK7vxpP3kEBwJBvoPk0YSeFZUASBZMEOBjF+ipTC+f49gX3is0dSsJGyRT+j
 VBEWVAMY=
X-Gm-Gg: AeBDietlZdgPFWLKdW0FJMBudVw6/jYHTUZ3E2DykXOZW9poiu/wDjXIKN3wE3DdAMU
 cvVI6nv+PjlSJkdnN2O7ZGhnFJ6txNweYx2nYyqD+TU1GSUcz/fKcVSLfAwND1l+WtBVGh63WJ+
 fNDfCnRniUSg863Q1LKD3RXoohUDAStm7GQ8ZyNBW3t+UDi6vUfIa+RRN91hpKSeD9xgXhagvZQ
 MI2Ut0P7LgwtZvhnMTjBp9iiKB9+skWvoQVYJECpLZW2whpxV/2RZa1ThzbtbJftKlqkwTN+uUI
 md1eIymgKM2Ob7Dp7aDxSatp3XzJjO52BxmVNdvsoZJmD4BbcR2brfQaTvmF7L43d4lN6/E+xf8
 bp5tCQ/T76VYosq7U9YqucdDHSfeSJqM0SpzHDTs3E+BZJPPwcq7Fvpg0aXAX3BoBX8YwHSNFIx
 d4iSRfzO5xqxGe3dGBSyxJTNdtpjAzOcqMIAZBal6b
X-Received: by 2002:a17:903:2acb:b0:2b4:6398:6aa2 with SMTP id
 d9443c01a7336-2b5f9f3a802mr451335435ad.27.1777211148231; 
 Sun, 26 Apr 2026 06:45:48 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 58/84] fpu: Export FloatFmt structures
Date: Sun, 26 Apr 2026 23:39:35 +1000
Message-ID: <20260426134002.865628-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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


