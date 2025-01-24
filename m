Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E561CC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMgu-0007Db-2V; Fri, 24 Jan 2025 11:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZa-00065Z-3g
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:28 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZS-0005rD-K0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:21 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso15353985e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736207; x=1738341007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xCeU+LpcSryg5lQ4AtUsxFm/b07YhdAnNy4h4JOSVJ8=;
 b=jdpXH+DPMjvvIWElio+xHOBN4syCyDgu6NcT74/DhVrqqe+nvfXjyRRTVsUb7M3hPU
 5HrORUx079jZgAoMhFSRQZg734ohfPKHJZynkXqli/ts3adeB82PsVsosuo8xN4JulGl
 AbAMp/6B5Yy0LEKnFPNRJ6FgQ9U+zzBiJcwLd03X9M2FpHNIkUM7hiikQnXJs2arLpfz
 Z8snTo483KO0NSSh6jPMuVLewQXmGX88gU/m0vU8zVx448Lq/Mc48ndIRU6ZN14NExuZ
 NxtiuYVr5WJiPy3tThrhd4IO1e4xzkXqh+qHHwUl1Y8Ol0PmfVAU7h/ExnQ0KOrAFFEg
 L2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736207; x=1738341007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCeU+LpcSryg5lQ4AtUsxFm/b07YhdAnNy4h4JOSVJ8=;
 b=X7FQJGhDwTfdP2QniTs3yv9q+J0XqjRYlPzKSAEsxsCtxEtV3ihuKt95rC6KFnlUPj
 0+sehUJP1hzH4IwqoXyVn2W1IrRcTLxhFRM+De6Uf4n5Jsxf5cCBizHj+EjawdM6AOri
 MZTxH7652IFktUedC6eWwqTPjaL5Y2bZ2OgPmqnu3i2UwTzFHGWNiDoTuDCoMmGYCKN7
 njn4qFHg18RxbQN4PI1GnDNd6OZPugWXv3AdaFXx5B5ZnCroawruucs62an2dc6/L508
 YW6JtoIFW2GOya2XoIRsyNv6AwAe1VixOJGh2IfxKjUCZqTny5MMBPW9cl2vTPByNiKR
 o18g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFmWoig5R+qEyH5zE+fg70v6x7wbJI0GMiXcJ+DhWy3Y5r7BrkQ9QNuExR8HKKv9nb949KZXW4iFEA@nongnu.org
X-Gm-Message-State: AOJu0YwyS5lftaAn4gBu5sL9CpFxh2/0WpwhlkQCiDAX7PFPYoNeYLGK
 aiqLDo22atBDDi7jN5oQH1RL7LGqcSX+6ddPsxNUFPF1rzQmW7YgAmyAGG7KYlWqk6CIcf5GQla
 r
X-Gm-Gg: ASbGncvdOuATobVcvmefv39NY7MMiM+D5n23fJnIuc/YVgblxeTxJ+Tf0lg4ArTia7f
 kQ1T6V8PCI+oma/gJApSW/THPV5Qeu2/hv3z7NbXNy2YaKSmG2D1KCNtF4hiPXHC9xTq0FaXy+a
 /nvyJ8DbkFaDI9s11eph3khEYkKdAHzZ3IB7DREHNkm8LTid55hBDFCdIxvSeUvwf3JbjVbOn2K
 LzXzsLJNnyoRU9SetEUI41T3pEPu3eBPUgoaOxbJ9Isj92NWSpMEOVWJtc0s5MG/Ds5QVZ9QJ4l
 FJrtFQv5VWE=
X-Google-Smtp-Source: AGHT+IHfnasuJshO9PMkLeTFBXLl8vmy4FE37r20nVavj8160SOI4ISSJ3PJHv+J0NMQ67jKI02S9g==
X-Received: by 2002:a05:600c:5110:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-438b885b8c1mr76545395e9.10.1737736207376; 
 Fri, 24 Jan 2025 08:30:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:30:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 70/76] target/arm: Implement increased precision FRECPE
Date: Fri, 24 Jan 2025 16:28:30 +0000
Message-Id: <20250124162836.2332150-71-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Implement the increased precision variation of FRECPE.  In the
pseudocode this corresponds to the handling of the
"increasedprecision" boolean in the FPRecipEstimate() and
RecipEstimate() functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 54 +++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 1b7ecc14621..79e58c5bb2a 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -731,6 +731,33 @@ static int recip_estimate(int input)
     return r;
 }
 
+/*
+ * Increased precision version:
+ * input is a 13 bit fixed point number
+ * input range 2048 .. 4095 for a number from 0.5 <= x < 1.0.
+ * result range 4096 .. 8191 for a number from 1.0 to 2.0
+ */
+static int recip_estimate_incprec(int input)
+{
+    int a, b, r;
+    assert(2048 <= input && input < 4096);
+    a = (input * 2) + 1;
+    /*
+     * The pseudocode expresses this as an operation on infinite
+     * precision reals where it calculates 2^25 / a and then looks
+     * at the error between that and the rounded-down-to-integer
+     * value to see if it should instead round up. We instead
+     * follow the same approach as the pseudocode for the 8-bit
+     * precision version, and calculate (2 * (2^25 / a)) as an
+     * integer so we can do the "add one and halve" to round it.
+     * So the 1 << 26 here is correct.
+     */
+    b = (1 << 26) / a;
+    r = (b + 1) >> 1;
+    assert(4096 <= r && r < 8192);
+    return r;
+}
+
 /*
  * Common wrapper to call recip_estimate
  *
@@ -740,7 +767,8 @@ static int recip_estimate(int input)
  * callee.
  */
 
-static uint64_t call_recip_estimate(int *exp, int exp_off, uint64_t frac)
+static uint64_t call_recip_estimate(int *exp, int exp_off, uint64_t frac,
+                                    bool increasedprecision)
 {
     uint32_t scaled, estimate;
     uint64_t result_frac;
@@ -756,12 +784,22 @@ static uint64_t call_recip_estimate(int *exp, int exp_off, uint64_t frac)
         }
     }
 
-    /* scaled = UInt('1':fraction<51:44>) */
-    scaled = deposit32(1 << 8, 0, 8, extract64(frac, 44, 8));
-    estimate = recip_estimate(scaled);
+    if (increasedprecision) {
+        /* scaled = UInt('1':fraction<51:41>) */
+        scaled = deposit32(1 << 11, 0, 11, extract64(frac, 41, 11));
+        estimate = recip_estimate_incprec(scaled);
+    } else {
+        /* scaled = UInt('1':fraction<51:44>) */
+        scaled = deposit32(1 << 8, 0, 8, extract64(frac, 44, 8));
+        estimate = recip_estimate(scaled);
+    }
 
     result_exp = exp_off - *exp;
-    result_frac = deposit64(0, 44, 8, estimate);
+    if (increasedprecision) {
+        result_frac = deposit64(0, 40, 12, estimate);
+    } else {
+        result_frac = deposit64(0, 44, 8, estimate);
+    }
     if (result_exp == 0) {
         result_frac = deposit64(result_frac >> 1, 51, 1, 1);
     } else if (result_exp == -1) {
@@ -830,7 +868,7 @@ uint32_t HELPER(recpe_f16)(uint32_t input, float_status *fpst)
     }
 
     f64_frac = call_recip_estimate(&f16_exp, 29,
-                                   ((uint64_t) f16_frac) << (52 - 10));
+                                   ((uint64_t) f16_frac) << (52 - 10), false);
 
     /* result = sign : result_exp<4:0> : fraction<51:42> */
     f16_val = deposit32(0, 15, 1, f16_sign);
@@ -883,7 +921,7 @@ static float32 do_recpe_f32(float32 input, float_status *fpst, bool rpres)
     }
 
     f64_frac = call_recip_estimate(&f32_exp, 253,
-                                   ((uint64_t) f32_frac) << (52 - 23));
+                                   ((uint64_t) f32_frac) << (52 - 23), rpres);
 
     /* result = sign : result_exp<7:0> : fraction<51:29> */
     f32_val = deposit32(0, 31, 1, f32_sign);
@@ -941,7 +979,7 @@ float64 HELPER(recpe_f64)(float64 input, float_status *fpst)
         return float64_set_sign(float64_zero, float64_is_neg(f64));
     }
 
-    f64_frac = call_recip_estimate(&f64_exp, 2045, f64_frac);
+    f64_frac = call_recip_estimate(&f64_exp, 2045, f64_frac, false);
 
     /* result = sign : result_exp<10:0> : fraction<51:0>; */
     f64_val = deposit64(0, 63, 1, f64_sign);
-- 
2.34.1


