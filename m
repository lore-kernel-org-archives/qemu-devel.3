Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EBCC71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z2-000549-5E; Sat, 21 Jun 2025 19:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z0-00053V-Dy
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:50 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yy-0004SJ-K5
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:50 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso3934306b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549847; x=1751154647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KV3u/NMl2mm2+PD0vFp086adYqxm1W+7r+6YGl/n7yw=;
 b=Z/7hseckLaR7QIWYclZ42CsUkK7o61LAHtMDKX08yB/gyapqqR/Sy5QQqAc/kXc0Zq
 /Ki3rTUYZq3cmxVqtpN+TzNj/DnKlPAyV66g4PRbmrDs9BqveXy9zdsdJoI16cQAFipS
 hUkc2Xd6U2GUYeZZljsVBq03pBvedJ8GHv+HIyBm9QTNY5+VQi5MRjxEgRm+qTRNPXL1
 BRFCyApUEnFZCxTTw8yD9C8Q3jRBcjyP744pmRPxDmRxlR4fZPXKQLvg6NneuxipEnxy
 bGgRQ4hty/1GF7aZUykpV2Y+PhzdvgYaA5Q5K6/r/06qtmlIE4oYnLqxnU/y0PPsQupt
 Vw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549847; x=1751154647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KV3u/NMl2mm2+PD0vFp086adYqxm1W+7r+6YGl/n7yw=;
 b=k5qQB9D/00M3iU0E9oIEV6gsuiboTjY6uT3OzUlCdF24zbnFIl1bKvMDmFPSb2aT3t
 kmHJxBYf+j+idC0funm1uU7gB/gubTkOQGsndfEX7auTgRsZ8KaAQodY2mt5+IcsnCbN
 UD4wcp3DeIrq/YYvV8RLDIsDhFTE9TGmkfeQtGE0KWTBqiSFsu8vYKa9iNlysGom7LbE
 AS/mkwKvZXyrHG/naUgUHTYmJPBoy0Uq3JR5HTIK2RxPSGV47yCd4ycGFC4pqeZAEfVz
 CPT7dMjuDv9BPDIyWBmj4vLBc6V1c/Yeh/DC5vLgh3IchBuKlX3gBkFCTBhiusQCJBZu
 0jxQ==
X-Gm-Message-State: AOJu0Yw5y88/S3NkqDrEcSJwEfkfpQzYuhbFsau0c2EmIYWf6fkTZ+Ei
 tUdcKj+g4B5O1+2azD28rR2xejRD7wVIX7ZXjPKMIQEMKtyKAXaehfEkND4hAGwWzyYnQmalu36
 1W5KL
X-Gm-Gg: ASbGncvpl+GwE/3BddAMoeBTHMzd/SYwS6Y6oyzTYcS3PZ2g1v+MguTk/ofg6rYzjDw
 RMwGhUCmULYJmUcSFGWFI46Qip/FiyoftsBUgHWRKYmmJzSkj6q3/Z5H31r/K0dwonacoTD95KU
 fGH61cMrsIuAztwMLQsU5U/qruu6MoaRGQp9IyhgsnBZSvKiyZJAFbcFeNNneygDMd1ST9DNqd5
 N2cGurTPLPyTj2LWGk2SdUtpK/lfDe9A19/Dpy4I2iaKTHfTMhjLHJIsiWDeiM2tmteaEjf8uW0
 0Mv8JRKj9ni8t+e9064GnnOHV7ZFx2TIOUmKWq7Z/20IQv2+suVEN1juuBDD59XtFQ6a2l1k9b5
 quRcDYeS+VQBPVPNrSk2n
X-Google-Smtp-Source: AGHT+IH13mP5K964Gi6/EiIQQOUNCQ46ILyX2Ikph0VbWpvIoQFiwgGTbhvq2yxZPQ1wsZ2vP7tmew==
X-Received: by 2002:a05:6a20:3d83:b0:1f5:9024:324f with SMTP id
 adf61e73a8af0-22026ecb493mr15247871637.31.1750549846987; 
 Sat, 21 Jun 2025 16:50:46 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 012/101] target/arm: Introduce FPST_ZA, FPST_ZA_F16
Date: Sat, 21 Jun 2025 16:49:08 -0700
Message-ID: <20250621235037.74091-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Rather than repeatedly copying FPST_FPCR to locals
and setting default nan mode, create dedicated float_status.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h            | 12 +++++++++++-
 target/arm/cpu.c            |  4 ++++
 target/arm/tcg/vfp_helper.c | 10 ++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 15b47a5bfc..c5060bcb97 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -206,6 +206,8 @@ typedef struct NVICState NVICState;
  *       when FPCR.AH == 1 (bfloat16 conversions and multiplies,
  *       and the reciprocal and square root estimate/step insns);
  *       for half-precision
+ * ZA: the "streaming sve" fp status.
+ * ZA_F16: likewise for half-precision.
  *
  * Half-precision operations are governed by a separate
  * flush-to-zero control bit in FPSCR:FZ16. We pass a separate
@@ -226,6 +228,12 @@ typedef struct NVICState NVICState;
  * they ignore FPCR.RMode. But they don't ignore FPCR.FZ16,
  * which means we need an FPST_AH_F16 as well.
  *
+ * The "ZA" float_status are for Streaming SVE operations which use
+ * default-NaN and do not generate fp exceptions, which means that they
+ * do not accumulate exception bits back into FPCR.
+ * See e.g. FPAdd vs FPAdd_ZA pseudocode functions, and the setting
+ * of fpcr.DN and fpexec parameters.
+ *
  * To avoid having to transfer exception bits around, we simply
  * say that the FPSCR cumulative exception flags are the logical
  * OR of the flags in the four fp statuses. This relies on the
@@ -239,10 +247,12 @@ typedef enum ARMFPStatusFlavour {
     FPST_A64_F16,
     FPST_AH,
     FPST_AH_F16,
+    FPST_ZA,
+    FPST_ZA_F16,
     FPST_STD,
     FPST_STD_F16,
 } ARMFPStatusFlavour;
-#define FPST_COUNT  8
+#define FPST_COUNT  10
 
 typedef struct CPUArchState {
     /* Regs for current mode.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e025e241ed..6111b9db91 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -554,11 +554,15 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
+    set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA]);
+    set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
     set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index b1324c5c0a..189fbd4f9e 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -196,6 +196,8 @@ void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32_F16]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_ZA]);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_ZA_F16]);
     }
     if (changed & FPCR_FZ16) {
         bool ftz_enabled = val & FPCR_FZ16;
@@ -203,15 +205,18 @@ void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_ZA_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_ZA_F16]);
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64]);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_ZA]);
         /* FIZ is A64 only so FZ always makes A32 code flush inputs to zero */
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
     }
@@ -223,6 +228,7 @@ void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         bool fitz_enabled = (val & FPCR_FIZ) ||
             (val & (FPCR_FZ | FPCR_AH)) == FPCR_FZ;
         set_flush_inputs_to_zero(fitz_enabled, &env->vfp.fp_status[FPST_A64]);
+        set_flush_inputs_to_zero(fitz_enabled, &env->vfp.fp_status[FPST_ZA]);
     }
     if (changed & FPCR_DN) {
         bool dnan_enabled = val & FPCR_DN;
@@ -240,9 +246,13 @@ void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
             /* Change behaviours for A64 FP operations */
             arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
             arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_ZA]);
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_ZA_F16]);
         } else {
             arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
             arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
+            arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA]);
+            arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA_F16]);
         }
     }
     /*
-- 
2.43.0


