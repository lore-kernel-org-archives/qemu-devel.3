Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BA3CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZF-0001Zz-20; Wed, 20 May 2026 13:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ1-0001NR-SU
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:36 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYy-0001vV-6f
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:35 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3665b67ed66so3347335a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297511; x=1779902311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yj7ZvwjIiBB1Rcal6z5w1HZi23h74lNdQA/PCnqvLXY=;
 b=mptimgAnBts2Zqwb60T6Q5Sr2vtVne0soxTg6d/93kG/f6gepsn888mClF0ljfbQeW
 BXDICgeaMnp6xT770cpjJ/qmsdNXJ5TWn8c03G/YFfaFxz8brqFKkzFuqHZDjIVufX/3
 0oIt/yLk5d0MgvNM+xEBgB0nJhARv/Bf7uD+tpsQEdHManoBDA1tG+tXKSDOPxkPTHIA
 0+i4i6CcMb3+uGtKy1wR8YOGFVZiyqwCU7YJK2UMLQesma+RFKGkRefHMATnYcX0NU/B
 mRspKOo9F+96h7oRIsvDn4gpGluX6OHOiZDMBF5HkoLtVQ0fLsYTLLgg3YzOV2axsDm3
 uDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297511; x=1779902311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yj7ZvwjIiBB1Rcal6z5w1HZi23h74lNdQA/PCnqvLXY=;
 b=W4v/xR0Y9miATI10UesUQlj4sc+AC0ppfUY1DbxAFuEHx0qV0SEfYGXy+uJOL2vZRq
 B/UZSuHMcSlbO9KT8NMGfBJD2elpUYUvfC8FsaSUWsNdIM/NIvfRvvMr8Iey6hI24+0t
 ToAlggJW4GMRhjK2J7BB+Y9I65XLDOxxb1BnE9DLYmsO6VzsCGW7iGDTlT4Ju3RLwdH1
 gHaHOTP1ZTswfDCyJ74JFEFL7YqNuALFt8eoeIb5FMaNNQZP6pK2is1QqXcF2jdx761g
 jGaXmtX+fVCLEgR66VObhwrcTg+n99fJpVyoXiT+2Fou8JPr+8Bsg7DxVONuS134pRhO
 qyBQ==
X-Gm-Message-State: AOJu0YyakevFrvmzW2Lr5zVMzog/RljqW/2CPI7yaGowqDuOZkyKVddl
 65AROEAzCUxpyzCiwaqJVKd/eVeX38ETk4OWUFnxDxX2EzdtN5u2G4OJhzERzIrv+z2m4HUhzhW
 C9mbZXPA=
X-Gm-Gg: Acq92OGDHQasj9JTsvkVzZM0rAEtKm+5fAKzyAA4o72N+ghCehcNbMm0+vVEmfXOFFL
 ADB4kzp5OdEGVb6Xa4f2KjqIyLvEcnggTm/afyPp+3KefqE3jyRZtytdxz8derQZs942PnuWV2Y
 PfhXeuKDgMVTUijnEu1fJUjQ3lPXbptB49djwdKBexqC2SCI5QLDMHyG7Q9rya5QF7wbTLslyx4
 IKf9lIQnfQ9lNDxjl+9QUqmVn9dJ8Kq64d4fOSeoiuiADccADlTMe2fMoy1UHHD53YCKKBKPIpd
 H5HJSRM7ca/x17NAdfdtZbElKjvSJ6KiP8YwoWft6rzWqVZ1DB78taUq/pxip9LOD/uXA38ERkF
 gdQxElW5kuz5TmIRyt9ddQlHUA+QiTrcPbxzgQ7aIu7x5bjmh88lmjN2/gx1JnBiNd8QAM1DDGJ
 Vc4y/yAc1ZaoQVraslipeqL8HnmC5A
X-Received: by 2002:a17:90b:38d2:b0:35b:9894:f6f9 with SMTP id
 98e67ed59e1d1-36951b82f83mr24025483a91.18.1779297510481; 
 Wed, 20 May 2026 10:18:30 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 12/30] fpu: Introduce frac_msb_is_snan
Date: Wed, 20 May 2026 10:18:02 -0700
Message-ID: <20260520171820.848839-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Unify handling of the two snan parameters, letting the
caller simply extract the msb.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.c.inc | 45 ++++++++++------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 485f082cf8..e2e3ec0e81 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -104,16 +104,21 @@ static inline bool snan_bit_is_one(float_status *status)
 | if the fraction represents a signalling NaN; otherwise false.
 *----------------------------------------------------------------------------*/
 
-static bool parts_is_snan_frac(uint64_t frac, float_status *status)
+static bool frac_msb_is_snan(bool msb, float_status *status)
 {
     if (no_signaling_nans(status)) {
         return false;
     } else {
-        bool msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
         return msb == snan_bit_is_one(status);
     }
 }
 
+static bool parts_is_snan_frac(uint64_t frac, float_status *status)
+{
+    bool msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
+    return frac_msb_is_snan(msb, status);
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated deconstructed floating-point NaN.
 *----------------------------------------------------------------------------*/
@@ -238,11 +243,7 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
 
 static bool float16_nan_is_snan(float16 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 9) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 9) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -271,11 +272,7 @@ bool float16_is_signaling_nan(float16 a_, float_status *status)
 
 static bool bfloat16_nan_is_snan(bfloat16 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 6) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 6) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -302,11 +299,7 @@ bool bfloat16_is_signaling_nan(bfloat16 a_, float_status *status)
 
 static bool float32_nan_is_snan(float32 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 22) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 22) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -335,11 +328,7 @@ bool float32_is_signaling_nan(float32 a_, float_status *status)
 
 static bool float64_nan_is_snan(float64 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 51) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 51) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -370,11 +359,7 @@ bool float64_is_signaling_nan(float64 a_, float_status *status)
 
 static bool floatx80_nan_is_snan(floatx80 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a.low >> 62) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a.low >> 62) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -416,11 +401,7 @@ floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
 
 static bool float128_nan_is_snan(float128 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a.high >> 47) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a.high >> 47) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
-- 
2.43.0


