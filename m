Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954C6C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwUO-00053y-5J; Wed, 02 Jul 2025 08:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwU9-0004yS-Ae
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:48 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTs-0007FY-8C
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:44 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2e9071e3706so2767577fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751458947; x=1752063747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFSiC0+11dXo7FuOpfNgMNVi+oIVpV/+XgXfRFy8NQA=;
 b=d93NKuarKN0RspXo1JmAiXszxTUGTMwrrnUVKbZhxRiCrOEpqSu8yIgOj2vGFrBuoP
 puur3uBnuj12+RtzQAHbNssRUsImzKxK3XH8T1HLOMsP9esyL8O+VmJIQOQdIE+efzY0
 HjyWdUEqaImSuMnfuWEDG8hE99XUXbXpCFgwLbjt1/dlUQddlcZL9FMiMzJv8zLC1UWN
 z5xAz4+VTWs+bAXYgQ1XciXHIS1ujHfFcunxpv1JdriaRMcY84cOFa2Dzt0QEpSNwinK
 r5rToMhH10xQKMvT53nei8GjFEmjujh1o5Mex+53arK4yFyh+1w/+eskZ/3ojhh2f3+e
 KwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458947; x=1752063747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFSiC0+11dXo7FuOpfNgMNVi+oIVpV/+XgXfRFy8NQA=;
 b=Y3EHIbvP+TYzq5krFlYNKOtbdgguqVD38uaEtxI/lBzelNcG25sXmB3d52WIG8BzU/
 DNmmbrkQAi5it2lTxBLrU8U9b6VqLN/KCDkNe7no58CA+fAjSz6/k+6FBBGorz5EyO51
 vtDR9eLtJ8O1EnkpmeG35kECy7lLlfhLlRYGL0DL42pyJf3HGSOCkE/HCGCCovXXt39k
 BJsPzI0wGo+gXLFJdCcMhTk+ni0aahVCFIuA/TfF7En8ZLGlwkQokuOBsDsLgXZ8fyf9
 CK1iE6kAAgmp6sTHQvqZo2VPvO1M+4UvkNVS9F5FaGkfw/7zlRD2o16rbkLwquFuDwQG
 HvqQ==
X-Gm-Message-State: AOJu0Yxh9srBt5x/WNWQ1x1CZLNsL6TJvg8jhufPhKjG7rLgafq1ZNkL
 rPBFqyVc45T3A5S2C7G1OmiluW+ktEr4BOCsTkKSXqm2icgymwotUOYmzpDGJ4FRN0uShOfXE3B
 fAnOigXM=
X-Gm-Gg: ASbGncs2yKjRtWK3F73UfGCZMwp6JPXC0BjBVOg0Gp0ezhNb5NJS6TVSjGC1UNhdWs8
 jaQdFpetqNojaLsOuhIl0Bc5mQMT/vckGxLrnUgTdfkI9GlsG2gbQqPz4OeYc+/+AVV7IUeQXI2
 2ntDHu1L/fNjyfGNQmiW/UdzDtZ5YvRq04J2oftv7qtCPcaoppz5Jzmm+Sq3jFVIRni7Zzw72jc
 oww/1oRi2loRDswdXqy+y6zB5T+I+ApM5SMO0/IzHAKbnYHpwE8m6fElyGoweqiXwVfzSAlBru0
 isnFXnVXIkpsv+N0+Fk+814IvXFpvMjCmZngwvw7CtAKMaaFE7C+dTmmmX/xYcbBElylSA==
X-Google-Smtp-Source: AGHT+IHiYD/TYpQst1Fmt/3QoBk7gxMei9f4xF3PJTg4TAHI9M62BFigj3mF4KsfoXZGdwkyex/jbQ==
X-Received: by 2002:a05:6871:282:b0:2bc:7811:5bb8 with SMTP id
 586e51a60fabf-2f5a8c8e55emr1903291fac.18.1751458946733; 
 Wed, 02 Jul 2025 05:22:26 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1bd3sm3785013fac.28.2025.07.02.05.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:22:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v3 09/10] target/arm: Fix bfdotadd_ebf vs nan selection
Date: Wed,  2 Jul 2025 06:22:12 -0600
Message-ID: <20250702122213.758588-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702122213.758588-1-richard.henderson@linaro.org>
References: <20250702122213.758588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Implement FPProcessNaNs4 within f16_dotadd, rather than
simply letting NaNs propagate through the function.

Cc: qemu-stable@nongnu.org
Fixes: 0e1850182a1 ("target/arm: Implement FPCR.EBF=1 semantics for bfdotadd()")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 75 ++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 986eaf8ffa..21c6175d2e 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2989,31 +2989,62 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
 float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
                      float_status *fpst, float_status *fpst_odd)
 {
-    /*
-     * Compare f16_dotadd() in sme_helper.c, but here we have
-     * bfloat16 inputs. In particular that means that we do not
-     * want the FPCR.FZ16 flush semantics, so we use the normal
-     * float_status for the input handling here.
-     */
-    float64 e1r = float32_to_float64(e1 << 16, fpst);
-    float64 e1c = float32_to_float64(e1 & 0xffff0000u, fpst);
-    float64 e2r = float32_to_float64(e2 << 16, fpst);
-    float64 e2c = float32_to_float64(e2 & 0xffff0000u, fpst);
-    float64 t64;
+    float32 s1r = e1 << 16;
+    float32 s1c = e1 & 0xffff0000u;
+    float32 s2r = e2 << 16;
+    float32 s2c = e2 & 0xffff0000u;
     float32 t32;
 
-    /*
-     * The ARM pseudocode function FPDot performs both multiplies
-     * and the add with a single rounding operation.  Emulate this
-     * by performing the first multiply in round-to-odd, then doing
-     * the second multiply as fused multiply-add, and rounding to
-     * float32 all in one step.
-     */
-    t64 = float64_mul(e1r, e2r, fpst_odd);
-    t64 = float64r32_muladd(e1c, e2c, t64, 0, fpst);
+    /* C.f. FPProcessNaNs4 */
+    if (float32_is_any_nan(s1r) || float32_is_any_nan(s1c) ||
+        float32_is_any_nan(s2r) || float32_is_any_nan(s2c)) {
+        if (float32_is_signaling_nan(s2r, fpst)) {
+            t32 = s2r;
+        } else if (float32_is_signaling_nan(s2c, fpst)) {
+            t32 = s2c;
+        } else if (float32_is_signaling_nan(s2r, fpst)) {
+            t32 = s2r;
+        } else if (float32_is_signaling_nan(s2c, fpst)) {
+            t32 = s2c;
+        } else if (float32_is_any_nan(s2r)) {
+            t32 = s2r;
+        } else if (float32_is_any_nan(s2c)) {
+            t32 = s2c;
+        } else if (float32_is_any_nan(s2r)) {
+            t32 = s2r;
+        } else {
+            t32 = s2c;
+        }
+        /*
+         * FPConvertNaN(FPProcessNaN(t32)) will be done as part
+         * of the final addition below.
+         */
+    } else {
+        /*
+         * Compare f16_dotadd() in sme_helper.c, but here we have
+         * bfloat16 inputs. In particular that means that we do not
+         * want the FPCR.FZ16 flush semantics, so we use the normal
+         * float_status for the input handling here.
+         */
+        float64 e1r = float32_to_float64(s1r, fpst);
+        float64 e1c = float32_to_float64(s1c, fpst);
+        float64 e2r = float32_to_float64(s2r, fpst);
+        float64 e2c = float32_to_float64(s2c, fpst);
+        float64 t64;
 
-    /* This conversion is exact, because we've already rounded. */
-    t32 = float64_to_float32(t64, fpst);
+        /*
+         * The ARM pseudocode function FPDot performs both multiplies
+         * and the add with a single rounding operation.  Emulate this
+         * by performing the first multiply in round-to-odd, then doing
+         * the second multiply as fused multiply-add, and rounding to
+         * float32 all in one step.
+         */
+        t64 = float64_mul(e1r, e2r, fpst_odd);
+        t64 = float64r32_muladd(e1c, e2c, t64, 0, fpst);
+
+        /* This conversion is exact, because we've already rounded. */
+        t32 = float64_to_float32(t64, fpst);
+    }
 
     /* The final accumulation step is not fused. */
     return float32_add(sum, t32, fpst);
-- 
2.43.0


