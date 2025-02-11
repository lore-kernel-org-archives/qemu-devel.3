Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B57C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7Q-0002C6-Bg; Tue, 11 Feb 2025 11:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6D-0006xA-4d
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:02 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht66-0003Yc-V0
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-439554db49dso7735635e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291213; x=1739896013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rHdPYoaNtSW6szZbbvGIFs2n75GS6UBB15kG4jxX0x4=;
 b=QxBq3mn8ZzFGcDTuUUN9fqJ9VgmDdVjRDgNtwqqYvzmFH58BOShkuKQyKFItMuknBM
 fP9Bs3cAVU88tVcwluC1GyQLj9v42DIRFwNHAr6/QflHvS3/RrqbGq7zwNdd+IFFepvh
 VtpRNegLIOswOxXAiKK3haudL8bokHiM44V6XEbmAqjBrKH6CF7QR4CxyBMVUjkhWbWv
 DH3VUod4i1UJLXY4I4afAl02K5BM0PWi3pxBEPU3GwH++W08Nf99vhhEzWblMcvHh4N7
 42rGRKe4BxYWfrKbFhKRqD0i06qVIzk3bZJ33ZriLhef1g7jAiv2K8oKBZBdcGmvbCBy
 T3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291213; x=1739896013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHdPYoaNtSW6szZbbvGIFs2n75GS6UBB15kG4jxX0x4=;
 b=REJrVZSuVV193e3ZWMEpjaPXVH9EJFYDH8WMEg4kSWGJX6eRb5E2dhKEaWSeeRd0uG
 BqCyeksTMcs36Qkv3nWfAaJrsOIZoGWEDtnDbIoE/P74iP8qFmNck8zIrllLLuPF3UWg
 esGsR2H0LOg+Lhg/DfPfMCOamHEglvoaUHjKg0I3CAHBKnTYnRa45YKe73qg29YWpSY9
 PhQPI1c7soP0dqxPa6nLv0PhTaXUn8tbIafjs3i4JJStEyKXIxxEBovGQyQSlpSfzJpZ
 ZKQipOtEJLx5IiSd9M+T22tDf8YGZ972Ix3X+9P/Eb/wpwd9gBO/gQd3Q+NBnFUYMuRm
 WO+A==
X-Gm-Message-State: AOJu0YwNpP3Tzeaib3/2/O0LWEAPe2IWeOf9oZand3VTEYJqHMjVSsGo
 MZzxYRVaECFrx2hb0TVdefgIfZUYxl6px3YaRQ491FF8NTaotgWp8u2vsUfxIcakI9zUQW1kypM
 n
X-Gm-Gg: ASbGncsBLGiTejkDwE4MnhR6GYInJ3FkyHjqurFcNp1Uiz8b9zV7d2IUnBX7TU0vReq
 19qtXmEDpoe3zJUvr3fI0+Ld1gCiHWgkVrmvaMSttxUy6Q/2USwT/NUgLdcnuXIDaw3ZBAjqSRD
 lCNHkVa/yzI9bXgP8UIDNumPDTjlrv75gsy0LRcEipP2K3h0lxwSxcf0U4lHk+79ImQt5yB+GnV
 ESbcQS0Hl6Nr7HDSGDqrl5gb80FAyRLf2dXDQa4al/mrBw4h21LcnkkH5Oxayo2uMkDmhCKgXk8
 fsy+JB8ZxJ0UUpjY11o7
X-Google-Smtp-Source: AGHT+IG5MdPrv4CoxZxQyHD9O4amVQMhTx9l7PZUnpIcPbjdg9cTKl7+uIehkykjoDnPN9bOrcu15A==
X-Received: by 2002:a05:600c:1f17:b0:436:e8b4:36e7 with SMTP id
 5b1f17b1804b1-43924987efbmr148135225e9.8.1739291213449; 
 Tue, 11 Feb 2025 08:26:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/68] target/arm: Implement increased precision FRSQRTE
Date: Tue, 11 Feb 2025 16:25:40 +0000
Message-Id: <20250211162554.4135349-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement the increased precision variation of FRSQRTE.  In the
pseudocode this corresponds to the handling of the
"increasedprecision" boolean in the FPRSqrtEstimate() and
RecipSqrtEstimate() functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp_helper.c | 77 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 2df97e128f2..9d58fa7d6f5 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1015,8 +1015,36 @@ static int do_recip_sqrt_estimate(int a)
     return estimate;
 }
 
+static int do_recip_sqrt_estimate_incprec(int a)
+{
+    /*
+     * The Arm ARM describes the 12-bit precision version of RecipSqrtEstimate
+     * in terms of an infinite-precision floating point calculation of a
+     * square root. We implement this using the same kind of pure integer
+     * algorithm as the 8-bit mantissa, to get the same bit-for-bit result.
+     */
+    int64_t b, estimate;
 
-static uint64_t recip_sqrt_estimate(int *exp , int exp_off, uint64_t frac)
+    assert(1024 <= a && a < 4096);
+    if (a < 2048) {
+        a = a * 2 + 1;
+    } else {
+        a = (a >> 1) << 1;
+        a = (a + 1) * 2;
+    }
+    b = 8192;
+    while (a * (b + 1) * (b + 1) < (1ULL << 39)) {
+        b += 1;
+    }
+    estimate = (b + 1) / 2;
+
+    assert(4096 <= estimate && estimate < 8192);
+
+    return estimate;
+}
+
+static uint64_t recip_sqrt_estimate(int *exp , int exp_off, uint64_t frac,
+                                    bool increasedprecision)
 {
     int estimate;
     uint32_t scaled;
@@ -1029,17 +1057,32 @@ static uint64_t recip_sqrt_estimate(int *exp , int exp_off, uint64_t frac)
         frac = extract64(frac, 0, 51) << 1;
     }
 
-    if (*exp & 1) {
-        /* scaled = UInt('01':fraction<51:45>) */
-        scaled = deposit32(1 << 7, 0, 7, extract64(frac, 45, 7));
+    if (increasedprecision) {
+        if (*exp & 1) {
+            /* scaled = UInt('01':fraction<51:42>) */
+            scaled = deposit32(1 << 10, 0, 10, extract64(frac, 42, 10));
+        } else {
+            /* scaled = UInt('1':fraction<51:41>) */
+            scaled = deposit32(1 << 11, 0, 11, extract64(frac, 41, 11));
+        }
+        estimate = do_recip_sqrt_estimate_incprec(scaled);
     } else {
-        /* scaled = UInt('1':fraction<51:44>) */
-        scaled = deposit32(1 << 8, 0, 8, extract64(frac, 44, 8));
+        if (*exp & 1) {
+            /* scaled = UInt('01':fraction<51:45>) */
+            scaled = deposit32(1 << 7, 0, 7, extract64(frac, 45, 7));
+        } else {
+            /* scaled = UInt('1':fraction<51:44>) */
+            scaled = deposit32(1 << 8, 0, 8, extract64(frac, 44, 8));
+        }
+        estimate = do_recip_sqrt_estimate(scaled);
     }
-    estimate = do_recip_sqrt_estimate(scaled);
 
     *exp = (exp_off - *exp) / 2;
-    return extract64(estimate, 0, 8) << 44;
+    if (increasedprecision) {
+        return extract64(estimate, 0, 12) << 40;
+    } else {
+        return extract64(estimate, 0, 8) << 44;
+    }
 }
 
 uint32_t HELPER(rsqrte_f16)(uint32_t input, float_status *s)
@@ -1078,7 +1121,7 @@ uint32_t HELPER(rsqrte_f16)(uint32_t input, float_status *s)
 
     f64_frac = ((uint64_t) f16_frac) << (52 - 10);
 
-    f64_frac = recip_sqrt_estimate(&f16_exp, 44, f64_frac);
+    f64_frac = recip_sqrt_estimate(&f16_exp, 44, f64_frac, false);
 
     /* result = sign : result_exp<4:0> : estimate<7:0> : Zeros(2) */
     val = deposit32(0, 15, 1, f16_sign);
@@ -1127,12 +1170,20 @@ static float32 do_rsqrte_f32(float32 input, float_status *s, bool rpres)
 
     f64_frac = ((uint64_t) f32_frac) << 29;
 
-    f64_frac = recip_sqrt_estimate(&f32_exp, 380, f64_frac);
+    f64_frac = recip_sqrt_estimate(&f32_exp, 380, f64_frac, rpres);
 
-    /* result = sign : result_exp<4:0> : estimate<7:0> : Zeros(15) */
+    /*
+     * result = sign : result_exp<7:0> : estimate<7:0> : Zeros(15)
+     * or for increased precision
+     * result = sign : result_exp<7:0> : estimate<11:0> : Zeros(11)
+     */
     val = deposit32(0, 31, 1, f32_sign);
     val = deposit32(val, 23, 8, f32_exp);
-    val = deposit32(val, 15, 8, extract64(f64_frac, 52 - 8, 8));
+    if (rpres) {
+        val = deposit32(val, 11, 12, extract64(f64_frac, 52 - 12, 12));
+    } else {
+        val = deposit32(val, 15, 8, extract64(f64_frac, 52 - 8, 8));
+    }
     return make_float32(val);
 }
 
@@ -1176,7 +1227,7 @@ float64 HELPER(rsqrte_f64)(float64 input, float_status *s)
         return float64_zero;
     }
 
-    f64_frac = recip_sqrt_estimate(&f64_exp, 3068, f64_frac);
+    f64_frac = recip_sqrt_estimate(&f64_exp, 3068, f64_frac, false);
 
     /* result = sign : result_exp<4:0> : estimate<7:0> : Zeros(44) */
     val = deposit64(0, 61, 1, f64_sign);
-- 
2.34.1


