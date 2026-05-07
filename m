Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5467CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1EU-0004bx-DR; Thu, 07 May 2026 12:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1ES-0004ae-S7
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:48 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EQ-0006zv-RX
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:48 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7de4be15125so842679a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169945; x=1778774745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkAw+lVYJp+/TFLv7ThrsHP9Ke0UbhMUufIzBrbvwe0=;
 b=A/6B3You62mDNZXebEGh9IApXgaRMhFp4NEtcTcbImMREqMXrNZX1YzSxic6hf4Db1
 gFNs+IDIgU5saHIxudPrpgdYXAIl3PgqngMQoTb8CtQbNIma025O/sDEXKlS2c5dHwxg
 fN1PPq4AQ5r8RU7IMxqyoovaYTbadLq8o9dXohzoQX6dglvwxysR6Qrgif5KpiB0fjAf
 oTc1f2Us5xhTmwjI8MbD8iPwb0n4bfrfQ+Q7zdyNKYNrLMe2S3KEy7WMshlEITBrV7Yq
 34Oj0VJZkXr/2iSxrkUSuVDSbTRKQqCFtSxg5KtpeaG+s9ziHd1rvLvgRq3uOTWmCCDh
 5Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169945; x=1778774745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UkAw+lVYJp+/TFLv7ThrsHP9Ke0UbhMUufIzBrbvwe0=;
 b=gXIVMXSFBO/iiypiIktUMfDwhkjFesFCzdcKLwPXQDK5ZYwsRM1jVY3SqefRHxmDcd
 u594agpZlYI+hcOfxwJtkMN30H/Qpw5H67yZ3gYpXxwbkBPM5NuXB/iweZJNAqhlne9t
 OimVHCRGO5AxvxXuypnQSQhxG1zMaGYG2lhwQO8m31LeKiVIRzIwTrEAy4FA3vLWp0SE
 xuJbG5W7USwVDylJXKuu7NrZ8nnII2UxK948XonRszGBkmE6hzfqr0gKIy/xusAHJOHi
 jXawQhFS0pjEjUwbBLTcfRk1aWZILPdau7DBdJ4iUzeQDiE59BurCw5v+n3EUCP1VvFw
 iiuQ==
X-Gm-Message-State: AOJu0Yzpi6Htib4PTLjzFxJLRa2/xicYupV3EdiCZE8YmpPyRlr9TZ4t
 3vVWX3+zFwmXIWzFK3t206Bd1fB00dyMEaQyNp7c4ww6wwDoWsluwjR2HJl5QJ7Fwy9nCFn9k16
 4nWw2
X-Gm-Gg: AeBDietX9k49lnPbEtV/TXqYPmXGySZ4NCa7lQXrPgVbyt8pruR/Tx7sqJrfGr8T7gQ
 C00jbOpeeSredojgZAq8veA5fZeeCcIK/PW550f1AwGvA4NbzvQWwA1QGFJNKP7rR0CjRP3a56e
 qBiv2taXtzCuSKhou4T78kcUyDoMSc/RI5q7G+36PdMhIxke9TaPi1Ra9T7BfwAKiCYmSeALDL7
 IDPMEggUOUSy1oPHrI11hbunuup1g6lhHDmFC1aULi9Owl01PHX+z6euPUN80OepFI5jxZv4El4
 ZD4gyKYVABKQ0v6D8vQLvln2eMxk0Fs3vuHx/ob1OYo/ak3pGowMeAAh2WvzRs7E9dMjuyW5Jmf
 MZ0UpvN41lv8VaqOjqm+wnBF6mb0ersB35uznmVXdk3HfF8WUU8GA371cDEQr893bYeyFs5W4wf
 rniOe17pjGSJsHIh0fYloz+JW1Viep7nJUpi/eoN65R3kbQA==
X-Received: by 2002:a05:6830:4182:b0:7d7:d524:bc88 with SMTP id
 46e09a7af769-7e1def3f862mr5748609a34.10.1778169945395; 
 Thu, 07 May 2026 09:05:45 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/29] fpu: Introduce record_denormals_used
Date: Thu,  7 May 2026 11:05:10 -0500
Message-ID: <20260507160518.444797-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
 fpu/softfloat.c           |  8 +++++++
 fpu/softfloat-parts.c.inc | 49 +++++++++++----------------------------
 2 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b6cf0c8188..0a8da13e01 100644
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
index 211ecdf114..028c2daa27 100644
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


