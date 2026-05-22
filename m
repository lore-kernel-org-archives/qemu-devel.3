Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01810CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUbK-0005fZ-K7; Fri, 22 May 2026 14:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUbG-0005XY-NH
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUbE-0005dG-96
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:58 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b941cd869cso50145065ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474475; x=1780079275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjgecQOKIFquxYcNCBsqhcMsA2llHQcUX4f1yL+tqyM=;
 b=KFKf08OSRmOetB+fN1niuWKhlXjOQ9K+vy1t4yezbkd7ItfgJRX9VTzikyGLFiN8GG
 O75QZ90B0pmHyL1rLTQbjHfpK5ptnQPV7A8fgtNrjsGQkmS8vWOK627oIx6g/42sq298
 9+X4FFcLcngp3Kh8V2WUyglWeSarZryv1atjD1vpX1Z6E3+HOVGHDb/J/lXj1eGdSci/
 w2RQa+wh8nya3aT9sN4tYAaKUKv19ZXVHlUMBv211HZjUHbr++6xy7pU8zj1//+ss3Ha
 ZXWBeRdM7grUtrqa7bKrzNhI/78Z3Up2QG0qTId0ZkfX+1+Iyyrt5MbdJF+WPpvP7kuP
 p9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474475; x=1780079275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QjgecQOKIFquxYcNCBsqhcMsA2llHQcUX4f1yL+tqyM=;
 b=LcKGZ02LhP6zPWJ9NUrM1ndi3yy2z3FH8KyaRSmotkwKBoHOlND194cTYOyT5K1Tb3
 kKdxiX9R5jV37+hrsGLf3bJgtwV+Ahxzj3zo/qmkHZJgWYJaGJ9O1fL8NTG4zOkQ7uWs
 ZXewpWEomZBSo0mpUZ1yw4j6p2l5wuwQ2ao63nXHJ5f4wnScOJzjL8OwkvlVzRfJpeVz
 e2V3Gfcyrc2I9+VlKcpblixWKgS5YvMhW+wbhzQT6Mqdoda9lEbncwLWMyjaID7f0Bp2
 ToegGeu8fFdvgPOxJ2duv9FkV7j245niE9a7uGD9gyu/A2WsxZITidGoLCsjE3W84ThS
 83PA==
X-Gm-Message-State: AOJu0YxzF6LRVegf8CZupxtjL496W2+zAU74Kx40Zw/z/dT7nl2S9TMF
 VPMC1CqfGsNODApnHAe4FJUk82S/BTOJc3pCL/VM1CO52zhWtKApEvkzTw6fVmdi6DLJi/n7xPV
 PTkkN
X-Gm-Gg: Acq92OF6tUU3SAi7v6Yl609yI4oSWSNlFDapLDCkHf0/mlZE9BXQX8x0yH7U9Kr98Wq
 +vvv0k7s0NqSbnwA3MqbpTsQxyP6WAEhi1Bv0jPu7yNJ0j27L7mg/Y+1tSwSPB6Ooa3odQ9ZW/h
 sSjKnmmm//xsmeWaWcPY0pE5EkPBdzK8ZL68PdUjwB+OjbKuzPYSe3f6M7SgXEqkJT91HKJnyNV
 9OVpPMPP4BQgUtikjEIrUOHd4y4OmbnxNLJ438/5ZnK8pko7ITjRaxmVs6McDcgt3Y/dW2Y+s42
 IGp86/NHbshf5PrgXFGKvjBADsmlBXHnCQIFXIxguIpd+skDHewPrTWD4EihgUcjDpl50x9UrJg
 9BC3c7mkI10PviQid9bse1DMe0Gx63P0oA4cM96FnUZn+yXbe9lH/h+V2w9eGBVBLMuEb9emlZ4
 IcWyBixL4ypg7LbjtaVCCVXrHoTEwc
X-Received: by 2002:a17:903:15c7:b0:2bd:8938:b811 with SMTP id
 d9443c01a7336-2beb0700897mr55834775ad.34.1779474474528; 
 Fri, 22 May 2026 11:27:54 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/30] fpu: Export floatN_minmax
Date: Fri, 22 May 2026 11:26:58 -0700
Message-ID: <20260522182658.184604-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Allow target access to routines using the minmax flags.
Make the existing min/max wrappers inline.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h   | 93 ++++++++++++++++++++++-----------------
 fpu/softfloat.c           | 50 +++------------------
 fpu/softfloat-parts.c.inc |  8 ++--
 3 files changed, 62 insertions(+), 89 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index e08d1c374d..d48fc6b043 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -132,6 +132,25 @@ enum {
     float_muladd_suppress_add_product_zero = 8,
 };
 
+/*----------------------------------------------------------------------------
+| Options to indicate which negations to perform in float*_minmax()
+*----------------------------------------------------------------------------*/
+
+/* Flags for parts_minmax. */
+enum {
+    /* Set for minimum; clear for maximum. */
+    float_minmax_ismin = 1,
+    /* Set for the IEEE 754-2008 minNum() and maxNum() operations. */
+    float_minmax_isnum = 2,
+    /* Set for the IEEE 754-2008 minNumMag() and minNumMag() operations. */
+    float_minmax_ismag = 4,
+    /*
+     * Set for the IEEE 754-2019 minimumNumber() and maximumNumber()
+     * operations.
+     */
+    float_minmax_isnumber = 8,
+};
+
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE integer-to-floating-point conversion routines.
 *----------------------------------------------------------------------------*/
@@ -258,14 +277,7 @@ float16 float16_muladd_scalbn(float16, float16, float16,
                               int, int, float_status *status);
 float16 float16_div(float16, float16, float_status *status);
 float16 float16_scalbn(float16, int, float_status *status);
-float16 float16_min(float16, float16, float_status *status);
-float16 float16_max(float16, float16, float_status *status);
-float16 float16_minnum(float16, float16, float_status *status);
-float16 float16_maxnum(float16, float16, float_status *status);
-float16 float16_minnummag(float16, float16, float_status *status);
-float16 float16_maxnummag(float16, float16, float_status *status);
-float16 float16_minimum_number(float16, float16, float_status *status);
-float16 float16_maximum_number(float16, float16, float_status *status);
+float16 float16_minmax(float16, float16, float_status *status, int flags);
 float16 float16_sqrt(float16, float_status *status);
 FloatRelation float16_compare(float16, float16, float_status *status);
 FloatRelation float16_compare_quiet(float16, float16, float_status *status);
@@ -451,14 +463,7 @@ bfloat16 bfloat16_div(bfloat16, bfloat16, float_status *status);
 bfloat16 bfloat16_muladd(bfloat16, bfloat16, bfloat16, int,
                          float_status *status);
 float16 bfloat16_scalbn(bfloat16, int, float_status *status);
-bfloat16 bfloat16_min(bfloat16, bfloat16, float_status *status);
-bfloat16 bfloat16_max(bfloat16, bfloat16, float_status *status);
-bfloat16 bfloat16_minnum(bfloat16, bfloat16, float_status *status);
-bfloat16 bfloat16_maxnum(bfloat16, bfloat16, float_status *status);
-bfloat16 bfloat16_minnummag(bfloat16, bfloat16, float_status *status);
-bfloat16 bfloat16_maxnummag(bfloat16, bfloat16, float_status *status);
-bfloat16 bfloat16_minimum_number(bfloat16, bfloat16, float_status *status);
-bfloat16 bfloat16_maximum_number(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_minmax(bfloat16, bfloat16, float_status *status, int flags);
 bfloat16 bfloat16_sqrt(bfloat16, float_status *status);
 FloatRelation bfloat16_compare(bfloat16, bfloat16, float_status *status);
 FloatRelation bfloat16_compare_quiet(bfloat16, bfloat16, float_status *status);
@@ -622,14 +627,7 @@ float32 float32_exp2(float32, float_status *status);
 float32 float32_log2(float32, float_status *status);
 FloatRelation float32_compare(float32, float32, float_status *status);
 FloatRelation float32_compare_quiet(float32, float32, float_status *status);
-float32 float32_min(float32, float32, float_status *status);
-float32 float32_max(float32, float32, float_status *status);
-float32 float32_minnum(float32, float32, float_status *status);
-float32 float32_maxnum(float32, float32, float_status *status);
-float32 float32_minnummag(float32, float32, float_status *status);
-float32 float32_maxnummag(float32, float32, float_status *status);
-float32 float32_minimum_number(float32, float32, float_status *status);
-float32 float32_maximum_number(float32, float32, float_status *status);
+float32 float32_minmax(float32, float32, float_status *status, int flags);
 bool float32_is_quiet_nan(float32, float_status *status);
 bool float32_is_signaling_nan(float32, float_status *status);
 float32 float32_silence_nan(float32, float_status *status);
@@ -818,14 +816,7 @@ float64 float64_sqrt(float64, float_status *status);
 float64 float64_log2(float64, float_status *status);
 FloatRelation float64_compare(float64, float64, float_status *status);
 FloatRelation float64_compare_quiet(float64, float64, float_status *status);
-float64 float64_min(float64, float64, float_status *status);
-float64 float64_max(float64, float64, float_status *status);
-float64 float64_minnum(float64, float64, float_status *status);
-float64 float64_maxnum(float64, float64, float_status *status);
-float64 float64_minnummag(float64, float64, float_status *status);
-float64 float64_maxnummag(float64, float64, float_status *status);
-float64 float64_minimum_number(float64, float64, float_status *status);
-float64 float64_maximum_number(float64, float64, float_status *status);
+float64 float64_minmax(float64, float64, float_status *status, int flags);
 bool float64_is_quiet_nan(float64 a, float_status *status);
 bool float64_is_signaling_nan(float64, float_status *status);
 float64 float64_silence_nan(float64, float_status *status);
@@ -1279,14 +1270,7 @@ float128 float128_rem(float128, float128, float_status *status);
 float128 float128_sqrt(float128, float_status *status);
 FloatRelation float128_compare(float128, float128, float_status *status);
 FloatRelation float128_compare_quiet(float128, float128, float_status *status);
-float128 float128_min(float128, float128, float_status *status);
-float128 float128_max(float128, float128, float_status *status);
-float128 float128_minnum(float128, float128, float_status *status);
-float128 float128_maxnum(float128, float128, float_status *status);
-float128 float128_minnummag(float128, float128, float_status *status);
-float128 float128_maxnummag(float128, float128, float_status *status);
-float128 float128_minimum_number(float128, float128, float_status *status);
-float128 float128_maximum_number(float128, float128, float_status *status);
+float128 float128_minmax(float128, float128, float_status *status, int flags);
 bool float128_is_quiet_nan(float128, float_status *status);
 bool float128_is_signaling_nan(float128, float_status *status);
 float128 float128_silence_nan(float128, float_status *status);
@@ -1388,4 +1372,33 @@ static inline bool float128_unordered_quiet(float128 a, float128 b,
 *----------------------------------------------------------------------------*/
 float128 float128_default_nan(float_status *status);
 
+/*----------------------------------------------------------------------------
+| Minumum and maximum functions.
+*----------------------------------------------------------------------------*/
+
+#define MINMAX_1(type, name, flags)                                     \
+    static inline type type##_##name(type a, type b, float_status *s)   \
+    { return type##_minmax(a, b, s, flags); }
+
+#define MINMAX_2(type)                                                  \
+    MINMAX_1(type, max, 0)                                              \
+    MINMAX_1(type, maxnum, float_minmax_isnum)                          \
+    MINMAX_1(type, maxnummag, float_minmax_isnum | float_minmax_ismag)  \
+    MINMAX_1(type, maximum_number, float_minmax_isnumber)               \
+    MINMAX_1(type, min, float_minmax_ismin)                             \
+    MINMAX_1(type, minnum, float_minmax_ismin | float_minmax_isnum)     \
+    MINMAX_1(type, minnummag,                                           \
+             float_minmax_ismin | float_minmax_isnum | float_minmax_ismag) \
+    MINMAX_1(type, minimum_number,                                      \
+             float_minmax_ismin | float_minmax_isnumber)
+
+MINMAX_2(float16)
+MINMAX_2(bfloat16)
+MINMAX_2(float32)
+MINMAX_2(float64)
+MINMAX_2(float128)
+
+#undef MINMAX_1
+#undef MINMAX_2
+
 #endif /* SOFTFLOAT_H */
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2c3bf01213..bc244a44ff 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -397,21 +397,6 @@ float64_gen2(float64 xa, float64 xb, float_status *s,
     return soft(ua.s, ub.s, s);
 }
 
-/* Flags for parts_minmax. */
-enum {
-    /* Set for minimum; clear for maximum. */
-    minmax_ismin = 1,
-    /* Set for the IEEE 754-2008 minNum() and maxNum() operations. */
-    minmax_isnum = 2,
-    /* Set for the IEEE 754-2008 minNumMag() and minNumMag() operations. */
-    minmax_ismag = 4,
-    /*
-     * Set for the IEEE 754-2019 minimumNumber() and maximumNumber()
-     * operations.
-     */
-    minmax_isnumber = 8,
-};
-
 /* Simple helpers for checking if, or what kind of, NaN we have */
 static inline __attribute__((unused)) bool is_nan(FloatClass c)
 {
@@ -4076,7 +4061,7 @@ float128 uint128_to_float128(Int128 a, float_status *status)
  * Minimum and maximum
  */
 
-static float16 float16_minmax(float16 a, float16 b, float_status *s, int flags)
+float16 float16_minmax(float16 a, float16 b, float_status *s, int flags)
 {
     FloatParts64 pa = float16_unpack_canonical(a, s);
     FloatParts64 pb = float16_unpack_canonical(b, s);
@@ -4085,8 +4070,7 @@ static float16 float16_minmax(float16 a, float16 b, float_status *s, int flags)
     return float16_round_pack_canonical(pr, s);
 }
 
-static bfloat16 bfloat16_minmax(bfloat16 a, bfloat16 b,
-                                float_status *s, int flags)
+bfloat16 bfloat16_minmax(bfloat16 a, bfloat16 b, float_status *s, int flags)
 {
     FloatParts64 pa = bfloat16_unpack_canonical(a, s);
     FloatParts64 pb = bfloat16_unpack_canonical(b, s);
@@ -4095,7 +4079,7 @@ static bfloat16 bfloat16_minmax(bfloat16 a, bfloat16 b,
     return bfloat16_round_pack_canonical(pr, s);
 }
 
-static float32 float32_minmax(float32 a, float32 b, float_status *s, int flags)
+float32 float32_minmax(float32 a, float32 b, float_status *s, int flags)
 {
     FloatParts64 pa = float32_unpack_canonical(a, s);
     FloatParts64 pb = float32_unpack_canonical(b, s);
@@ -4104,7 +4088,7 @@ static float32 float32_minmax(float32 a, float32 b, float_status *s, int flags)
     return float32_round_pack_canonical(pr, s);
 }
 
-static float64 float64_minmax(float64 a, float64 b, float_status *s, int flags)
+float64 float64_minmax(float64 a, float64 b, float_status *s, int flags)
 {
     FloatParts64 pa = float64_unpack_canonical(a, s);
     FloatParts64 pb = float64_unpack_canonical(b, s);
@@ -4113,8 +4097,7 @@ static float64 float64_minmax(float64 a, float64 b, float_status *s, int flags)
     return float64_round_pack_canonical(pr, s);
 }
 
-static float128 float128_minmax(float128 a, float128 b,
-                                float_status *s, int flags)
+float128 float128_minmax(float128 a, float128 b, float_status *s, int flags)
 {
     FloatParts128 pa = float128_unpack_canonical(a, s);
     FloatParts128 pb = float128_unpack_canonical(b, s);
@@ -4123,29 +4106,6 @@ static float128 float128_minmax(float128 a, float128 b,
     return float128_round_pack_canonical(pr, s);
 }
 
-#define MINMAX_1(type, name, flags) \
-    type type##_##name(type a, type b, float_status *s) \
-    { return type##_minmax(a, b, s, flags); }
-
-#define MINMAX_2(type) \
-    MINMAX_1(type, max, 0)                                                \
-    MINMAX_1(type, maxnum, minmax_isnum)                                  \
-    MINMAX_1(type, maxnummag, minmax_isnum | minmax_ismag)                \
-    MINMAX_1(type, maximum_number, minmax_isnumber)                       \
-    MINMAX_1(type, min, minmax_ismin)                                     \
-    MINMAX_1(type, minnum, minmax_ismin | minmax_isnum)                   \
-    MINMAX_1(type, minnummag, minmax_ismin | minmax_isnum | minmax_ismag) \
-    MINMAX_1(type, minimum_number, minmax_ismin | minmax_isnumber)        \
-
-MINMAX_2(float16)
-MINMAX_2(bfloat16)
-MINMAX_2(float32)
-MINMAX_2(float64)
-MINMAX_2(float128)
-
-#undef MINMAX_1
-#undef MINMAX_2
-
 /*
  * Floating point compare
  */
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index d0064f5d22..a154faf32b 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1469,7 +1469,7 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
          * if one operand is a QNaN, and the other
          * operand is numerical, then return numerical argument.
          */
-        if ((flags & (minmax_isnum | minmax_isnumber))
+        if ((flags & (float_minmax_isnum | float_minmax_isnumber))
             && !(ab_mask & float_cmask_snan)
             && (ab_mask & ~float_cmask_qnan)) {
             record_denormals_used(ab_mask, s);
@@ -1487,7 +1487,7 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
          *   but unless both operands are NaNs,
          *   the SNaN is otherwise ignored and not converted to a QNaN.
          */
-        if ((flags & minmax_isnumber)
+        if ((flags & float_minmax_isnumber)
             && (ab_mask & float_cmask_snan)
             && (ab_mask & ~float_cmask_anynan)) {
             float_raise(float_flag_invalid, s);
@@ -1542,7 +1542,7 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
      * Take the sign into account.
      * For ismag, only do this if the magnitudes are equal.
      */
-    if (!(flags & minmax_ismag) || cmp == 0) {
+    if (!(flags & float_minmax_ismag) || cmp == 0) {
         if (a->sign != b->sign) {
             /* For differing signs, the negative operand is less. */
             cmp = a->sign ? -1 : 1;
@@ -1552,7 +1552,7 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
         }
     }
 
-    if (flags & minmax_ismin) {
+    if (flags & float_minmax_ismin) {
         cmp = -cmp;
     }
     return cmp < 0 ? b : a;
-- 
2.43.0


