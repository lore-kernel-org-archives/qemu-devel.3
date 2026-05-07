Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED28CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1ET-0004ax-8C; Thu, 07 May 2026 12:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EP-0004Yd-Ll
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:45 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EL-0006tw-1e
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:45 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dca4debedaso1068958a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169940; x=1778774740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cITeZbJEtyl+09mVpYKhhR7Pw3A+UGIkoZnUsO+bREc=;
 b=Ra2zb2ewrzif+haxLJQWHfswVq2cxYgsgRYG5YYTPy3Q8mSJu0vftflNEnYGeNJ9Ti
 lVPSnr1Q9o/PzBc8xCoYmZeQiZCYbSnXoJFXk6wRalHhtK51k5GKhdsQxsq00PqJNTvJ
 a2AcRgq1twmrWL+KLcH46JnjstaU+lIlqpfGkIe3+d6XTCpddZcXztrm94W/JAuyXPuC
 jsdzzfAbovIvWMq+BnBSsOCV3NQfHzs3972KIlcy+yoPHT2D/bH56O6F9YVs/YorQO6w
 RsdyRlkU8rPBhEd84OhjQ/ZfAaN+UhXyKxVlwaNK/hBxaB3VuJ3hkYaqKjeVwbpbh6ZJ
 WOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169940; x=1778774740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cITeZbJEtyl+09mVpYKhhR7Pw3A+UGIkoZnUsO+bREc=;
 b=kegSO36e7DMsSzp038FWLTFXI7kPZZB11KyeYiwMGAhKj+fsP3U0WLtzxjBEVtNeJt
 Ss8s5+Ro9gGSlVk2zrmq2bj/tKibW69rCYPAvTBkgGhPT0iE5XSz+lyhwYbmKmRB9m95
 5Tl1QqMRjbuLuhptXAGYjIgKXSCb1m8lEjvxkAQ38XiVcZgBbd/n0yG1km1cuZDJMJFC
 3EZE+Ohcss2xJ3IEFZEFUC0TzbJKl6XiCBf/3jAlx6mM06BKGfjNnKr9QThTJ5ovTbSX
 VX1GcvCDBTnLlKulJ7O+e8bCE61pnUxj89IDqFDxkno7A4IyOQWfr8CP0ZD9MVOV3YfA
 m0Jg==
X-Gm-Message-State: AOJu0YxfAvEnMotWBxEIA9LUsto6QuS4fLh9DksPlZoCAXBsrjwpq9dV
 93GwjN30Wws5/8YzTWEwuMr5VCQ6JINd4ZoxEMTbPUaEIasqBeBmYVcpo+uU5UNI1c23ukuz4LY
 3tN9K
X-Gm-Gg: AeBDiev8dnip9fPXwFmm/AaxcHHq/g829ieWQShzPF820KVhIp18NKFCCdfgsFK/EJH
 R1KZIap3SGedH+1vCHwgya7s1hUDWxRx67HdMfEWbzheT2A8uMDskSp06Qp97hVTZtpgJKyc2RT
 yGEWsarzwWrp+/Z0BsWb5YZcQS7yAt5VJmY5Mxmkj32H47jqy+jxDROY+1NGNzAuu226j0TfZyB
 bDmQ7BvV60oaZScKYWBDTXvf4yXNdP9cgoGEUfpN/6CE7z6U6CM7uuahhsY7qta/yJ2lHhwjdO7
 miM9//VJDb9D9fy/L14K7pPraGEyQ4H4hLKIR3yCAHJfm5E01aguEyBtr1s6OVrXyjJpCqLe6N+
 7KiojeoNRZpYyRSJqrGhY07onj7KCRK5m1Dqr0m+dpMZgeJ7eGYldP2DlMz3Lw4V77Tu4ncTEgT
 Qj/IuKdl6dR+1JJ9MsHAC90Ui4EXQIO4PXbcyHq2I2a7M5lQ==
X-Received: by 2002:a05:6830:410d:b0:7d7:f5d4:ef5b with SMTP id
 46e09a7af769-7e1def15227mr5303320a34.7.1778169939678; 
 Thu, 07 May 2026 09:05:39 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/29] fpu: Return struct from parts{64,128}_pick_nan
Date: Thu,  7 May 2026 11:05:04 -0500
Message-ID: <20260507160518.444797-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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
 fpu/softfloat.c           |  8 ++++----
 fpu/softfloat-parts.c.inc | 28 ++++++++++++++++------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b7d461bca4..246209072e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4765,15 +4765,15 @@ void normalizeFloatx80Subnormal(uint64_t aSig, int32_t *zExpPtr,
 
 floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
+    FloatParts128 pa, pb;
 
     if (!floatx80_unpack_canonical(&pa, a, status) ||
         !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
 
-    pr = parts128_pick_nan(&pa, &pb, status);
-    return floatx80_round_pack_canonical(pr, status);
+    pa = parts128_pick_nan(&pa, &pb, status);
+    return floatx80_round_pack_canonical(&pa, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -5120,7 +5120,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
 {
     /* POp table "Results: DIVIDE TO INTEGER (Part 1 of 2)" */
     if ((float_cmask(a->cls) | float_cmask(b->cls)) & float_cmask_anynan) {
-        *r = *parts64_pick_nan(a, b, status);
+        *r = parts64_pick_nan(a, b, status);
         *n = *r;
         *cc = 1;
     } else if (a->cls == float_class_inf || b->cls == float_class_zero) {
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index ef46dd740c..40ea7e3a39 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -37,11 +37,11 @@ static FloatPartsN partsN(return_nan)(const FloatPartsN *a, float_status *s)
     return *a;
 }
 
-static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
-                                     float_status *s)
+static FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
+                                    float_status *s)
 {
     bool have_snan = false;
-    FloatPartsN *ret;
+    const FloatPartsN *ret;
     int cmp;
 
     if (is_snan(a->cls) || is_snan(b->cls)) {
@@ -50,8 +50,7 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (s->default_nan_mode) {
-        *a = partsN(default_nan)(s);
-        return a;
+        return partsN(default_nan)(s);
     }
 
     switch (s->float_2nan_prop_rule) {
@@ -110,9 +109,9 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (is_snan(ret->cls)) {
-        *ret = partsN(silence_nan)(ret, s);
+        return partsN(silence_nan)(ret, s);
     }
-    return ret;
+    return *ret;
 }
 
 static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
@@ -605,7 +604,8 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
     return b;
 
  p_nan:
-    return partsN(pick_nan)(a, b, s);
+    *a = partsN(pick_nan)(a, b, s);
+    return a;
 }
 
 /*
@@ -647,7 +647,8 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return partsN(pick_nan)(a, b, s);
+        *a = partsN(pick_nan)(a, b, s);
+	return a;
     }
 
     /* Multiply by 0 or Inf */
@@ -833,7 +834,8 @@ static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
 
     /* All the NaN cases */
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return partsN(pick_nan)(a, b, s);
+        *a = partsN(pick_nan)(a, b, s);
+	return a;
     }
 
     if ((ab_mask & float_cmask_denormal) && b->cls != float_class_zero) {
@@ -891,7 +893,8 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
 
     /* All the NaN cases */
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return partsN(pick_nan)(a, b, s);
+        *a = partsN(pick_nan)(a, b, s);
+        return a;
     }
 
     /* Inf % N; N % 0 */
@@ -1514,7 +1517,8 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
             return is_nan(a->cls) ? b : a;
         }
 
-        return partsN(pick_nan)(a, b, s);
+        *a = partsN(pick_nan)(a, b, s);
+        return a;
     }
 
     if (ab_mask & float_cmask_denormal) {
-- 
2.43.0


