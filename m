Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD2AC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYp-00051m-Lg; Fri, 24 Jan 2025 11:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYG-0003lq-IF
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:01 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYB-0005Q7-3m
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:59 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38a34e8410bso1244340f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736133; x=1738340933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1fTQgZA5aAX5RMS6PA5fZD0DXJXNgm9B+ZdvixNCRKw=;
 b=o09kNWa6pNO6rX6VjpKAikb89ru65Qjl9GlHvQNy+3E5Vfnp2eRZpuuFgVbWB+Ihor
 nszwDQsuXX+275Js/WaeIPNNt5Bw+0M6X3za9/so5/8wHXql5bwvXiKE7HW0274Z7ctz
 PBKkXufVMpDHKbDzQyD8vPIItaxCqlnso9I2RoYFIBMP3Sl6XkIWuaCifLjDE7VJdrM+
 7mVH9M0H1AQc1bA5G/w85eoametafvrTT7Mh1zjMRrOLjmj6YGZdehG7t6TVRc13/aVx
 pDki3PXud8qtvNfkzidDkBWdLT+JKPkPXMByNJ7B7bdjZ07X5jDxoAdpAuR1nLoDe6bF
 kBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736133; x=1738340933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fTQgZA5aAX5RMS6PA5fZD0DXJXNgm9B+ZdvixNCRKw=;
 b=HcbtNNg/1xOFQvKVgDghZYtlJM91Kz9CM3kh7GvplpGqo74xrCtTKt0m7yRpYrXiSV
 sMZduiWGz7g0Y4/XEBoIYZ00RIkUc53E3Q3u7f/uBuYO6hieNzl6b53S9yaXwR41EOO5
 AsGRKkY5V0ZrlpzBYjeSeKkzwletVIFZH956zduLcjvICqrYolXDMBCa3KPddgAri+Mm
 PuNenNLpKsSQoHfWlJOOpwsI1YPgjGaPCeppIQSeOe+NcOoh/Uv9uTmFzbV+6TZqrbGY
 s6SVBE3l+gDIQGi9yvVR459DPUSdlwasRzNuPmqL7F4ukKBJMAzAhP+Qpj077sQ/1Yv7
 Xvfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoyCsl32rjyclkylzA58Ot7Fp6qv0J9UHB0uD/tSVJ4ZE9DLOoF5klCjImMzxTKOPPi01fW9twU4ma@nongnu.org
X-Gm-Message-State: AOJu0YzJJCnFfXnWBi/q8PNxfjEf2NAKCr8hSMzYqzA5DsSKWLYo2p+G
 4AzF8FtS0AokjTXUrE4Nu4xnV/EdW0bh9e/NPptNyMFnZax50DPZVm4rL3iY9Gg=
X-Gm-Gg: ASbGncvB1fioPA+QVBIBhBfvA3muXySQ/ui6rcoco/fmw5fpboJjQJTaicgk/lXYC6A
 gYGSYfYs6wYXa0QUfdRwMSJDsL8egHxR71fhb9BySd7PXImufR8PfogDHpL5h6O44NFGQgYMtQU
 RdGQAXziiADnC6seFcXt6u85ntRklLUw5TC6cUpd8eHpUPjZcKDQk0x6qMbx2L38UTNU8nG6vFZ
 Tinc5IHiZBo4LQXegFsg1cxZHrVf5oTDyjophF25nBu/wtwzsK/mvNlm3YpTuRKoWEsjU2OJJ9Y
 Vv15K3aCttBWUDmticMPpw==
X-Google-Smtp-Source: AGHT+IEVMtVnFitD9EPDVF9aJhHETiqZxtSliJJ1/ZNHm8UEJsx5dBcTM8m6RAP8JmP7y2Rtu/b6pQ==
X-Received: by 2002:a5d:6d87:0:b0:385:e1eb:a7af with SMTP id
 ffacd0b85a97d-38bf59eff3bmr33316174f8f.48.1737736133376; 
 Fri, 24 Jan 2025 08:28:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/76] target/arm: Define new fp_status_f16_a32 and
 fp_status_f16_a64
Date: Fri, 24 Jan 2025 16:27:33 +0000
Message-Id: <20250124162836.2332150-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

As the first part of splitting the existing fp_status_f16
into separate float_status fields for AArch32 and AArch64
(so that we can make FEAT_AFP control bits apply only
for AArch64), define the two new fp_status_f16_a32 and
fp_status_f16_a64 fields, but don't use them yet.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  4 ++++
 target/arm/tcg/translate.h | 12 ++++++++++++
 target/arm/cpu.c           |  2 ++
 target/arm/vfp_helper.c    | 14 ++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7b967bbd1d2..be409c5c76e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -636,6 +636,8 @@ typedef struct CPUArchState {
          *  fp_status_a32: is the "normal" fp status for AArch32 insns
          *  fp_status_a64: is the "normal" fp status for AArch64 insns
          *  fp_status_fp16: used for half-precision calculations
+         *  fp_status_fp16_a32: used for AArch32 half-precision calculations
+         *  fp_status_fp16_a64: used for AArch64 half-precision calculations
          *  standard_fp_status : the ARM "Standard FPSCR Value"
          *  standard_fp_status_fp16 : used for half-precision
          *       calculations with the ARM "Standard FPSCR Value"
@@ -662,6 +664,8 @@ typedef struct CPUArchState {
         float_status fp_status_a32;
         float_status fp_status_a64;
         float_status fp_status_f16;
+        float_status fp_status_f16_a32;
+        float_status fp_status_f16_a64;
         float_status standard_fp_status;
         float_status standard_fp_status_f16;
 
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 197772eb13d..57e5d92cd60 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -673,6 +673,8 @@ typedef enum ARMFPStatusFlavour {
     FPST_FPCR_A32,
     FPST_FPCR_A64,
     FPST_FPCR_F16,
+    FPST_FPCR_F16_A32,
+    FPST_FPCR_F16_A64,
     FPST_STD,
     FPST_STD_F16,
 } ARMFPStatusFlavour;
@@ -691,6 +693,10 @@ typedef enum ARMFPStatusFlavour {
  *   for AArch64 non-FP16 operations controlled by the FPCR
  * FPST_FPCR_F16
  *   for operations controlled by the FPCR where FPCR.FZ16 is to be used
+ * FPST_FPCR_F16_A32
+ *   for AArch32 operations controlled by the FPCR where FPCR.FZ16 is to be used
+ * FPST_FPCR_F16_A64
+ *   for AArch64 operations controlled by the FPCR where FPCR.FZ16 is to be used
  * FPST_STD
  *   for A32/T32 Neon operations using the "standard FPSCR value"
  * FPST_STD_F16
@@ -711,6 +717,12 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     case FPST_FPCR_F16:
         offset = offsetof(CPUARMState, vfp.fp_status_f16);
         break;
+    case FPST_FPCR_F16_A32:
+        offset = offsetof(CPUARMState, vfp.fp_status_f16_a32);
+        break;
+    case FPST_FPCR_F16_A64:
+        offset = offsetof(CPUARMState, vfp.fp_status_f16_a64);
+        break;
     case FPST_STD:
         offset = offsetof(CPUARMState, vfp.standard_fp_status);
         break;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a2b9bd3fb9d..ff8514edc6d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -576,6 +576,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status_f16);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 9fee6265f20..45f9dfc8861 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -69,6 +69,10 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     /* FZ16 does not generate an input denormal exception.  */
     i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
           & ~float_flag_input_denormal);
+    i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
+          & ~float_flag_input_denormal);
+    i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
+          & ~float_flag_input_denormal);
     i |= (get_float_exception_flags(&env->vfp.standard_fp_status_f16)
           & ~float_flag_input_denormal);
     return vfp_exceptbits_from_host(i);
@@ -84,6 +88,8 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
     set_float_exception_flags(0, &env->vfp.fp_status_f16);
+    set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
+    set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
     set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
 }
@@ -113,12 +119,18 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_float_rounding_mode(i, &env->vfp.fp_status_a32);
         set_float_rounding_mode(i, &env->vfp.fp_status_a64);
         set_float_rounding_mode(i, &env->vfp.fp_status_f16);
+        set_float_rounding_mode(i, &env->vfp.fp_status_f16_a32);
+        set_float_rounding_mode(i, &env->vfp.fp_status_f16_a64);
     }
     if (changed & FPCR_FZ16) {
         bool ftz_enabled = val & FPCR_FZ16;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_to_zero(ftz_enabled, &env->vfp.standard_fp_status_f16);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.standard_fp_status_f16);
     }
     if (changed & FPCR_FZ) {
@@ -133,6 +145,8 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
     }
 }
 
-- 
2.34.1


