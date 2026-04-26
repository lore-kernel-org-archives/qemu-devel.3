Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE80BFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGznp-0005gF-Jp; Sun, 26 Apr 2026 09:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznS-0005Uc-2T
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznQ-0001JH-1D
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:17 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b23fcf90b2so89126595ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211115; x=1777815915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6zcSXo4A730eHR1OTgbhR0R0t6QcmaEIHgFVIpsyOqk=;
 b=gCma/9myrE28bflg66oylwd9qoUBkfeA77zL+AiVAYGk09fAlj8TDT/MaE7q2RXZVU
 ATm83wu+pMppF9zkeqgYjRLcF5E4sfZMJkd8lVI2a8BHX2gWop22HyUtt6U780M6GB1c
 DZ31ycCcnrrxLsoFb/vBy1Y6Cu+fWQAyMePvz56o07jNg7X+NE3UAMl2+O5xuIvvouME
 Ib/e2n8Akw63hbO4t8uuKtFtavPtl1siqdFP4f1DrdaFzzRaOTzWB235wSWtS/tWF2qn
 kpr4RcPXIV+T/rcEPKfx96JhaAeepKX6Ko7E4Hp+DNhTZa5m5gF83JOs1A7qKUMXf+dw
 ROXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211115; x=1777815915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6zcSXo4A730eHR1OTgbhR0R0t6QcmaEIHgFVIpsyOqk=;
 b=c67h05G4NNBhuGhuAub6k7YVkE8Vo97VCnPOVxLwDGrMDPv+2RSH92KQTM07n2iDWH
 s3dzVmDOZeZqkrtfoI8htWrrt+ZX0ZulnUyJ4gcuN1vU6U1WJBtaUgWXlh/QTWJaxlS2
 cBiq8FXcg2IQAklBpzKvI+QxYwECdDIG1ivqZKD7jOL09yR75t0rrWPSS5Z1LCLWNVgp
 AgwGt1xGBvzRz+YukkhCenwhwJPM01hZvi6IoMLuOdE+k3WAS44MR/tbaYwY3AB61+X1
 rmf3RrIWB01/dWaA6byXMaPvP6qpbyrcoeCDhQwXN0+9FttWU3YTNTcVYZ+qx+Pg3vH4
 SOvA==
X-Gm-Message-State: AOJu0YzuarvQCCNxFDw/EaK3TztC8mNuXdiRnl9doVOmLjlmF85hGPcY
 2A8sOlRyf6v9iHACy3LIMJ/D7QiAFvabVs2NJCeJJvjvR/2gj8UWjyZbLeQ8TKgQ2sefHu6JyKc
 T3G6DdMk=
X-Gm-Gg: AeBDies7UepDsZ5/eMJnOlWTrKAC8FH7ciY9wIUd0VbKor4kG0NR3SLAw55sdHdi3pL
 1nuveyWLbdeR1FXObEzZ+Ay1cUKzkH2lxPip73dQyEs3+PqehRJvxBDnEirUF3cnnrRmxF/Ycny
 CJ38/K9J1qgkkYKgiurovP4PWHaB66DE0hU3Zerc9Gm8VmJXRv05nLSGyUFPEXawfkSBHi/ix0w
 pYYApMaomG9NNUFBS5kZKt9rYsfkPPHw3qTfWRaCSsB5ryV+3mWNBS95AunHJ9fAGGX1brGoxwE
 OMa01dTQujzBbYMCLrXkhM1X4HvAY3zqP4VmsjOci9GFI6OhVdQT2IXffZAbOir0wtly1wAG5rV
 6jTdMXnu/OhzQbubP/oHOxDM7ANVEWZ+WH4ldFPxSYI0H5dUAqhB/fALhuv03KKEK8EVhwyjSam
 5GtbtcyKV513hbHUEK57vCPqmFkbbRaojcpjngVkQ7
X-Received: by 2002:a17:902:7585:b0:2b4:656b:aeb0 with SMTP id
 d9443c01a7336-2b5f9f61d74mr261402715ad.35.1777211114552; 
 Sun, 26 Apr 2026 06:45:14 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 46/84] fpu: Return struct from float128_unpack_canonical
Date: Sun, 26 Apr 2026 23:39:23 +1000
Message-ID: <20260426134002.865628-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 fpu/softfloat.c | 105 +++++++++++++++++-------------------------------
 1 file changed, 37 insertions(+), 68 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index a9c91fb8a4..77585fa11f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1583,11 +1583,11 @@ static float64 float64r32_round_pack_canonical(FloatParts64 *p,
     return float64r32_pack_raw(p);
 }
 
-static void float128_unpack_canonical(FloatParts128 *p, float128 f,
-                                      float_status *s)
+static FloatParts128 float128_unpack_canonical(float128 f, float_status *s)
 {
-    *p = float128_unpack_raw(f);
-    parts128_canonicalize(p, s, &float128_params);
+    FloatParts128 p = float128_unpack_raw(f);
+    parts128_canonicalize(&p, s, &float128_params);
+    return p;
 }
 
 static float128 float128_round_pack_canonical(FloatParts128 *p,
@@ -1872,11 +1872,9 @@ bfloat16 bfloat16_sub(bfloat16 a, bfloat16 b, float_status *status)
 static float128 QEMU_FLATTEN
 float128_addsub(float128 a, float128 b, float_status *status, bool subtract)
 {
-    FloatParts128 pa, pb, *pr;
-
-    float128_unpack_canonical(&pa, a, status);
-    float128_unpack_canonical(&pb, b, status);
-    pr = parts128_addsub(&pa, &pb, status, subtract);
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 *pr = parts128_addsub(&pa, &pb, status, subtract);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -1994,11 +1992,9 @@ bfloat16_mul(bfloat16 a, bfloat16 b, float_status *status)
 float128 QEMU_FLATTEN
 float128_mul(float128 a, float128 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
-
-    float128_unpack_canonical(&pa, a, status);
-    float128_unpack_canonical(&pb, b, status);
-    pr = parts128_mul(&pa, &pb, status);
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 *pr = parts128_mul(&pa, &pb, status);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -2255,12 +2251,10 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
 float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
                                       int flags, float_status *status)
 {
-    FloatParts128 pa, pb, pc, *pr;
-
-    float128_unpack_canonical(&pa, a, status);
-    float128_unpack_canonical(&pb, b, status);
-    float128_unpack_canonical(&pc, c, status);
-    pr = parts128_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 pc = float128_unpack_canonical(c, status);
+    FloatParts128 *pr = parts128_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
     parts128_uncanon(pr, status, &float128_params, false);
@@ -2383,11 +2377,9 @@ bfloat16_div(bfloat16 a, bfloat16 b, float_status *status)
 float128 QEMU_FLATTEN
 float128_div(float128 a, float128 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
-
-    float128_unpack_canonical(&pa, a, status);
-    float128_unpack_canonical(&pb, b, status);
-    pr = parts128_div(&pa, &pb, status);
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 *pr = parts128_div(&pa, &pb, status);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -2429,11 +2421,9 @@ float64 float64_rem(float64 a, float64 b, float_status *status)
 
 float128 float128_rem(float128 a, float128 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
-
-    float128_unpack_canonical(&pa, a, status);
-    float128_unpack_canonical(&pb, b, status);
-    pr = parts128_modrem(&pa, &pb, NULL, status);
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 *pr = parts128_modrem(&pa, &pb, NULL, status);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -2782,20 +2772,18 @@ bfloat16 float64_to_bfloat16(float64 a, float_status *s)
 
 float32 float128_to_float32(float128 a, float_status *s)
 {
+    FloatParts128 p128 = float128_unpack_canonical(a, s);
     FloatParts64 p64;
-    FloatParts128 p128;
 
-    float128_unpack_canonical(&p128, a, s);
     parts_float_to_float_narrow(&p64, &p128, s);
     return float32_round_pack_canonical(&p64, s);
 }
 
 float64 float128_to_float64(float128 a, float_status *s)
 {
+    FloatParts128 p128 = float128_unpack_canonical(a, s);
     FloatParts64 p64;
-    FloatParts128 p128;
 
-    float128_unpack_canonical(&p128, a, s);
     parts_float_to_float_narrow(&p64, &p128, s);
     return float64_round_pack_canonical(&p64, s);
 }
@@ -2876,9 +2864,8 @@ floatx80 float64_to_floatx80(float64 a, float_status *s)
 
 floatx80 float128_to_floatx80(float128 a, float_status *s)
 {
-    FloatParts128 p;
+    FloatParts128 p = float128_unpack_canonical(a, s);
 
-    float128_unpack_canonical(&p, a, s);
     parts128_float_to_float(&p, s);
     return floatx80_round_pack_canonical(&p, s);
 }
@@ -2921,9 +2908,8 @@ bfloat16 bfloat16_round_to_int(bfloat16 a, float_status *s)
 
 float128 float128_round_to_int(float128 a, float_status *s)
 {
-    FloatParts128 p;
+    FloatParts128 p = float128_unpack_canonical(a, s);
 
-    float128_unpack_canonical(&p, a, s);
     parts128_round_to_int(&p, s->float_rounding_mode, 0, s, &float128_params);
     return float128_round_pack_canonical(&p, s);
 }
@@ -3046,18 +3032,14 @@ int64_t bfloat16_to_int64_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
 static int32_t float128_to_int32_scalbn(float128 a, FloatRoundMode rmode,
                                         int scale, float_status *s)
 {
-    FloatParts128 p;
-
-    float128_unpack_canonical(&p, a, s);
+    FloatParts128 p = float128_unpack_canonical(a, s);
     return parts128_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 static int64_t float128_to_int64_scalbn(float128 a, FloatRoundMode rmode,
                                         int scale, float_status *s)
 {
-    FloatParts128 p;
-
-    float128_unpack_canonical(&p, a, s);
+    FloatParts128 p = float128_unpack_canonical(a, s);
     return parts128_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
@@ -3066,9 +3048,7 @@ static Int128 float128_to_int128_scalbn(float128 a, FloatRoundMode rmode,
 {
     int flags = 0;
     Int128 r;
-    FloatParts128 p;
-
-    float128_unpack_canonical(&p, a, s);
+    FloatParts128 p = float128_unpack_canonical(a, s);
 
     switch (p.cls) {
     case float_class_snan:
@@ -3512,18 +3492,14 @@ uint64_t bfloat16_to_uint64_scalbn(bfloat16 a, FloatRoundMode rmode,
 static uint32_t float128_to_uint32_scalbn(float128 a, FloatRoundMode rmode,
                                           int scale, float_status *s)
 {
-    FloatParts128 p;
-
-    float128_unpack_canonical(&p, a, s);
+    FloatParts128 p = float128_unpack_canonical(a, s);
     return parts128_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
 }
 
 static uint64_t float128_to_uint64_scalbn(float128 a, FloatRoundMode rmode,
                                           int scale, float_status *s)
 {
-    FloatParts128 p;
-
-    float128_unpack_canonical(&p, a, s);
+    FloatParts128 p = float128_unpack_canonical(a, s);
     return parts128_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
@@ -3532,9 +3508,7 @@ static Int128 float128_to_uint128_scalbn(float128 a, FloatRoundMode rmode,
 {
     int flags = 0;
     Int128 r;
-    FloatParts128 p;
-
-    float128_unpack_canonical(&p, a, s);
+    FloatParts128 p = float128_unpack_canonical(a, s);
 
     switch (p.cls) {
     case float_class_snan:
@@ -4210,11 +4184,9 @@ static float64 float64_minmax(float64 a, float64 b, float_status *s, int flags)
 static float128 float128_minmax(float128 a, float128 b,
                                 float_status *s, int flags)
 {
-    FloatParts128 pa, pb, *pr;
-
-    float128_unpack_canonical(&pa, a, s);
-    float128_unpack_canonical(&pb, b, s);
-    pr = parts128_minmax(&pa, &pb, s, flags);
+    FloatParts128 pa = float128_unpack_canonical(a, s);
+    FloatParts128 pb = float128_unpack_canonical(b, s);
+    FloatParts128 *pr = parts128_minmax(&pa, &pb, s, flags);
 
     return float128_round_pack_canonical(pr, s);
 }
@@ -4393,10 +4365,9 @@ FloatRelation bfloat16_compare_quiet(bfloat16 a, bfloat16 b, float_status *s)
 static FloatRelation QEMU_FLATTEN
 float128_do_compare(float128 a, float128 b, float_status *s, bool is_quiet)
 {
-    FloatParts128 pa, pb;
+    FloatParts128 pa = float128_unpack_canonical(a, s);
+    FloatParts128 pb = float128_unpack_canonical(b, s);
 
-    float128_unpack_canonical(&pa, a, s);
-    float128_unpack_canonical(&pb, b, s);
     return parts128_compare(&pa, &pb, s, is_quiet);
 }
 
@@ -4470,9 +4441,8 @@ bfloat16 bfloat16_scalbn(bfloat16 a, int n, float_status *status)
 
 float128 float128_scalbn(float128 a, int n, float_status *status)
 {
-    FloatParts128 p;
+    FloatParts128 p = float128_unpack_canonical(a, status);
 
-    float128_unpack_canonical(&p, a, status);
     parts128_scalbn(&p, n, status);
     return float128_round_pack_canonical(&p, status);
 }
@@ -4590,9 +4560,8 @@ bfloat16 QEMU_FLATTEN bfloat16_sqrt(bfloat16 a, float_status *status)
 
 float128 QEMU_FLATTEN float128_sqrt(float128 a, float_status *status)
 {
-    FloatParts128 p;
+    FloatParts128 p = float128_unpack_canonical(a, status);
 
-    float128_unpack_canonical(&p, a, status);
     parts128_sqrt(&p, status, &float128_params);
     return float128_round_pack_canonical(&p, status);
 }
-- 
2.43.0


