Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195B3CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1EQ-0004ZR-Jl; Thu, 07 May 2026 12:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EO-0004YL-Oa
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:44 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EI-0006qE-Lh
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:44 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dccb8644c4so567263a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169937; x=1778774737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+x+yoMED4Jyx4x+O3iz43StrYiJ12dpPepYjofWmnQo=;
 b=UHFK7jrB7HLsU6aZWD47BFJc4XmUnnIPVn/Bcij6f6jmeWjptIQFpEMDZMlYvvbG4P
 mWem2ZSG0dJ4GOoq+wTbZzxCJIAo5AeJO0jFrcSU+6x1pRwYDxLww9sBfSmV96lZQwRV
 i2ab/5L3mdn6b/SZjVIQH+hWqnaWZ1t2VanELOaMsbtAIQ5dDL07E5VZWs4mv8wDLOuW
 0ytrXuKL2UpmWY068l0UH5NKfFDNsk8ZUp6ieddVe8Sz0ebA6jPMZ3dlASmnj9A3AxgY
 Y3drQGh4o6Bl7B3K7P5gTjoOs3PBJJn5rmycVU/aEWXnTbndyPAmAy6fLojNpsj9CdEi
 QLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169937; x=1778774737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+x+yoMED4Jyx4x+O3iz43StrYiJ12dpPepYjofWmnQo=;
 b=L6noZWaWdSounebcCK2I1ohujsFxInB9rUqMzlQdxiTWWb7ohiP84bMIMFYa5cWegu
 priJhvinHd2QLTe4CLfYMNSpIV8IuZ7ngOB4gLnySj8FVF6qusaTtNFDLgK308KV3CN/
 4kIsDqZoupadUcobjqVy/yKmg5+wY0NUfvkQ8ps+yRPltVzpzJNqLbq64yoD38bZl00p
 hSwM3Jyo5XMC8TdntzBmGRyaqW7I0lVQzJuoLLEikFOkMWxt2Q6nY1oLRxYjg+9kBN2/
 ybUM6lqSwR3aK4N3Fomq4Mou0s81gU7CFQNIL8RZQKIYGHW855xXIKWXVX9oVbaxWqeH
 CkLw==
X-Gm-Message-State: AOJu0Yx7bOUhujr3w6lVzNa7vyv7XaFhwLurbyr1XEd9j5/rrh4s3KnL
 fjY+h0ar3lW1Qn1NONHI6ACfCwTxWYbiq2kI+jUCN9YTpqcy0+Q8SdcF4K8SfxrO9P774FDeeZ2
 5DQFH
X-Gm-Gg: AeBDievZri6pxBWy4Nku4oDkbxvIVa3zzHnTek9kx1rxAZwOFiSOTNEXj35SDFudLRG
 IrVc5KTd2whVVUSVZBrwR/KDJ3Rj0ZNZ1BUI7JZ7DPuua56hJY7rUY+xwA0ZrUPQMVkQHgchtf6
 MvAK9SFoGCVE13Cd5YQLUJuGICKI8YdxNYQSsZJhGfqPsnoxe9114W1ryel8Zcoiyu+Wjt7IFs+
 U2Bo+pGXubwasUUlawLYNbABWEOI8/VtYvad10NRfyO+riIf1bIx2JafMRl9LgSCCMRq7q2Ktuq
 htCoGEIkWS0/jBBqaYkgwJheSGc99fcUtGBsa+bijjohNc2hhkKwlhGM5nzchoIJppEOrslrahn
 hraxVXOi0JXS6LXlbqeIJ7qhwV5npJj6zUelP6js1hzoBcfFjT27azYSyOM/K4a6UlCh0jIljZ8
 drsZTdDoijd79ZFVZf8+jkbpFUiL7ltrsvzayBw4dvl/S/MQ==
X-Received: by 2002:a05:6830:6734:b0:7d7:fb8c:3c29 with SMTP id
 46e09a7af769-7e1df0f9574mr5332156a34.14.1778169937139; 
 Thu, 07 May 2026 09:05:37 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/29] fpu: Return struct from parts{64,128}_return_nan
Date: Thu,  7 May 2026 11:05:02 -0500
Message-ID: <20260507160518.444797-15-richard.henderson@linaro.org>
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


