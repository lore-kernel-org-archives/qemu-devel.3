Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C1EFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEur-0006hT-9p; Wed, 29 Apr 2026 20:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEup-0006dt-Qn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:03 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuo-0001mn-2L
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:03 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82f4a53ae20so240947b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507561; x=1778112361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcYkneR9Skc297NkyUYU49GZmHwypHS79RqQoM9N3gU=;
 b=lsVT37T6IBC4kPJsujXz2ZiSFjyC/8Vdg0O+ULel3A4S8E9Ev9pgHTMoCPHT3hWkaP
 sdcXLqay+mKUQ7iuSXoZXpPXLoAEHlJ8+jeYcvejd6A/EzFvJ/36izO+s9mh2q3MZ0cJ
 YmlK0TsYLypFFxjTwKICF6xLliyc61IJEyuCCAUPuRrw+tYt/HTcY3rUn1c/4nzimfaD
 Za8m9JKNOhicib0kqugyFfwaQ6S6s+krB/kwbZ2/++dUB+0UvYGa/1FKXCEeqO1wrr7n
 qaKskrlMGzvyb5wtPkCuljKG3j6sLze4H7+WUfs2tnAYwe1mHdohh+cQrmjna8wlW8F3
 to/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507561; x=1778112361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RcYkneR9Skc297NkyUYU49GZmHwypHS79RqQoM9N3gU=;
 b=W3MZhdXdAm8qTROFDNieqblFoKt9zCUt42LQzLKBbrPXhQQO7qxBkL8eRMthECDGXz
 HuQMpXgVnIMH8KHDcNh2b6kSkEtDI0jNCtTSFHLWRupgGifR6chIyJYOdGgprH8XGv4f
 oagydnXdbRDSR6uPrUIm0zDUAwZrgXIplcuQ74O0hBMT0v1u4lKhYnUjwqUmeZtQ94EZ
 SE71TJbHqUQ7pZlWNgQRqa9gQzsRH63oh0nXqFqoZAXPNX5Ain2IVfAdzLD7UsEGt6PR
 PLXwwYMwPp25YfoQsCj7/FjU8Mabd7K7ZqcOR3yA/hRmPS4ebJ/JpY9ha2Fi5btj1sQd
 j8Tw==
X-Gm-Message-State: AOJu0YwoVdhPhKZz+S6m3O6ytf3YaS0gPFwkQdoCTnxoZXrvrpHbfd/q
 WFH9dl6U2zLj4bGEOZVE+aMSXk7GpZ30Q9YFD+yzIqkxcbhSAsJMAqaGhkjXpdkNZ7VoMAVOK5f
 4IfE5kMQ=
X-Gm-Gg: AeBDievI49gDunFkGdQvxUt8/R6any45M+pDrApHcO3Xuv2dL3Fyi3iX4NxUCFV2vGP
 xvKGiGrXrj92vzO60dyWi6OYz1xLOT4M5hRlSMQtl217fA5YH5vxog3BvPXaioLVz4z+dDRRCd2
 UTl72GTFW0WXWDcoBeFP0O5eH5DsCtzN7zkY5HVgrRS9Nk7gye1IUogFDbjg/LKqBUNlPa5+lRu
 m8FmBfJoj9/8pcFHt1jQARIbRka/IGDIJd2LR1mCUThfx2w88o9FHmvmufPPsXR7AO6b89rIMLN
 XhHl47Kwd/JIZdXEcHFCb9z+JHkQW05XITGK4r8nJeYds60H0SMVV1OrvJ5CZ+xUb92+kWP4Bwl
 IZLMIHRevkrGjHX8jSMR+zww1+Caw6wy2tcPTr0s0rRxrTU/EQ1fpZwfHTbEGe3+Ff7kPR7HCfx
 NsxNbRd0OXF4dGmF/p1imoLoHPwvOQWnwc0BbIUyk6
X-Received: by 2002:a05:6a00:2d1a:b0:82f:5571:1a92 with SMTP id
 d2e1a72fcca58-834fdb0e9b3mr802351b3a.7.1777507560727; 
 Wed, 29 Apr 2026 17:06:00 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 14/40] fpu: Return struct from parts{64,128}_return_nan
Date: Thu, 30 Apr 2026 10:04:57 +1000
Message-ID: <20260430000524.56046-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 fpu/softfloat.c           | 14 +++++++-------
 fpu/softfloat-parts.c.inc | 15 ++++++++-------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9c1e6fdce4..7d67e25c17 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2378,7 +2378,7 @@ static void parts_float_to_e5m2(FloatParts64 *a, float_status *s, bool saturate)
     switch (a->cls) {
     case float_class_snan:
     case float_class_qnan:
-        parts64_return_nan(a, s);
+        *a = parts64_return_nan(a, s);
         break;
 
     case float_class_inf:
@@ -2405,7 +2405,7 @@ static void parts_float_to_e5m2(FloatParts64 *a, float_status *s, bool saturate)
 static void parts64_float_to_float(FloatParts64 *a, float_status *s)
 {
     if (is_nan(a->cls)) {
-        parts64_return_nan(a, s);
+        *a = parts64_return_nan(a, s);
     }
     if (a->cls == float_class_denormal) {
         float_raise(float_flag_input_denormal_used, s);
@@ -2415,7 +2415,7 @@ static void parts64_float_to_float(FloatParts64 *a, float_status *s)
 static void parts128_float_to_float(FloatParts128 *a, float_status *s)
 {
     if (is_nan(a->cls)) {
-        parts128_return_nan(a, s);
+        *a = parts128_return_nan(a, s);
     }
     if (a->cls == float_class_denormal) {
         float_raise(float_flag_input_denormal_used, s);
@@ -2441,7 +2441,7 @@ static FloatParts64 parts128_to_parts64(FloatParts128 *b, float_status *s)
     case float_class_qnan:
         /* Discard the low bits of the NaN. */
         r.frac = b->frac_hi;
-        parts64_return_nan(&r, s);
+        r = parts64_return_nan(&r, s);
         break;
     default:
         break;
@@ -2461,7 +2461,7 @@ static FloatParts128 parts64_to_parts128(FloatParts64 *b, float_status *s)
     switch (r.cls) {
     case float_class_qnan:
     case float_class_snan:
-        parts128_return_nan(&r, s);
+        r = parts128_return_nan(&r, s);
         break;
     case float_class_denormal:
         float_raise(float_flag_input_denormal_used, s);
@@ -4458,7 +4458,7 @@ static void parts64_log2(FloatParts64 *a, float_status *s, const FloatFmt *fmt)
             break;
         case float_class_snan:
         case float_class_qnan:
-            parts64_return_nan(a, s);
+            *a = parts64_return_nan(a, s);
             return;
         case float_class_zero:
             float_raise(float_flag_divbyzero, s);
@@ -5067,7 +5067,7 @@ float32 float32_exp2(float32 a, float_status *status)
             break;
         case float_class_snan:
         case float_class_qnan:
-            parts64_return_nan(&xp, status);
+            xp = parts64_return_nan(&xp, status);
             return float32_round_pack_canonical(&xp, status);
         case float_class_inf:
             return xp.sign ? float32_zero : a;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 4733755f35..ef46dd740c 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -15,25 +15,26 @@
  * indicated otherwise.
  */
 
-static void partsN(return_nan)(FloatPartsN *a, float_status *s)
+static FloatPartsN partsN(return_nan)(const FloatPartsN *a, float_status *s)
 {
     switch (a->cls) {
     case float_class_snan:
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
         if (s->default_nan_mode) {
-            *a = partsN(default_nan)(s);
+            return partsN(default_nan)(s);
         } else {
-            *a = partsN(silence_nan)(a, s);
+            return partsN(silence_nan)(a, s);
         }
         break;
     case float_class_qnan:
         if (s->default_nan_mode) {
-            *a = partsN(default_nan)(s);
+            return partsN(default_nan)(s);
         }
         break;
     default:
         g_assert_not_reached();
     }
+    return *a;
 }
 
 static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
@@ -941,7 +942,7 @@ static void partsN(sqrt)(FloatPartsN *a, float_status *status,
             break;
         case float_class_snan:
         case float_class_qnan:
-            partsN(return_nan)(a, status);
+            *a = partsN(return_nan)(a, status);
             return;
         case float_class_zero:
             return;
@@ -1263,7 +1264,7 @@ static void partsN(round_to_int)(FloatPartsN *a, FloatRoundMode rmode,
     switch (a->cls) {
     case float_class_qnan:
     case float_class_snan:
-        partsN(return_nan)(a, s);
+        *a = partsN(return_nan)(a, s);
         break;
     case float_class_zero:
     case float_class_inf:
@@ -1656,7 +1657,7 @@ static void partsN(scalbn)(FloatPartsN *a, int n, float_status *s)
     switch (a->cls) {
     case float_class_snan:
     case float_class_qnan:
-        partsN(return_nan)(a, s);
+        *a = partsN(return_nan)(a, s);
         break;
     case float_class_zero:
     case float_class_inf:
-- 
2.43.0


