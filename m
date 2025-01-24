Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFF4C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMZx-0006SQ-Ba; Fri, 24 Jan 2025 11:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYI-0003rV-Fl
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:04 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYE-0005N5-Dk
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:01 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so23925635e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736125; x=1738340925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MgMjtmIn5YHOySMtqed78/dy6/ryGORph+YbtAdKVfY=;
 b=ZOK8y6SthOCMdrJ7V8Yu8MsmjtqhA3NkeX2WOV1vnXK2N9b9rCKu1yvleKyTJ3vFQs
 fc9n+Grt3swpKnqxRc36m9/wLKqkre4g327A3FyLLaZTZbOuNEzJTYT843EAn8YHfp4z
 vnSQbgSOjlXsZYNFjaOyETwe/f+VHTVCu8tmcKWFVFy/LyrdckzT6RxymOBwA5pFxVR+
 FXfWcVWh6fjJ/v3xhoYOKzMty8cqP1a7xROVxf1TL+VYwxEq7kvbQGuIw1mHcoKR1ar5
 AzAJNO3FlmveecygrsvvtiAh23nJaRMuFfkcSegseNl9OUDMzYS5S/BvER49eMrJ/Tvy
 Im2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736125; x=1738340925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgMjtmIn5YHOySMtqed78/dy6/ryGORph+YbtAdKVfY=;
 b=p8fbn8//3LCNIjcwlARXQ7v67C6xQkzym96JVBuTDCfhViwkcrWbIbMfIHVsemAHaU
 EaxeQr7qVcVF0FHnFEWRGLHWKC/D+FCH/476chGCMkpI0jzrWeDnFkmESb54YBvzJWsQ
 VuC236jwerONMGt3bkXGtcmMOYBZ4UpOZJ3mKB3Yz1ifnG/JZyclSYNbBiNOnoBQCJUS
 h6JB2DBq8i5luoRxiDXEUlci5pNcOa19V05mGc6isnkSR6nRgf6+275UWf//uj0s/Dt9
 ne17V0haZ68/DZQWXxJwbNfvm9LGuPD4R3weW9EFwllBmgCYNBCmXMRuwIPbjkmib2sf
 eVHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYwac9wOxUzs3FFWt7WQCh1uFCl2sktEjvrz0kSC3HdqfhlYDnAM1kVYOskJTpC7725SJhXhg9Ife+@nongnu.org
X-Gm-Message-State: AOJu0YzzkeFWGEGzhlbgAm9CScGqJNH0GFFXGjK1c2/TqXpdirJe0GDT
 KvDy67zs2kEtr71ATf9Pet78H3mDKRVG0lhOG1YKGy2ZcAQvpIW20ICgmRfUOHV2DcASJdaqXul
 S
X-Gm-Gg: ASbGncvEkjT2U5dcQSSLufaTZtE8jufk7dP2A7risFEvcgIc50IS1xN+Ylmrh3TY2BL
 OHTKATL86KHWTgdNneA8xbG+djXKo5C83a8YEgrrKd0QpMd8PRxQ10kgvjCZCvYprrBhqPCwUPh
 gf9rpTiIwouJSWonCjGnQhvtZanxVtOiVXC60t8IYcujaUFQYeSN99oacU+tw/l2lUXy6aKjwCn
 AeFMP98DCwpwXNi3siU2VEU2LUY+tTV5Xi6TkXq0Y0a+jA13tG3PS35wpQ7HOqM6geAL8ySucNG
 ERrUKkr5G88=
X-Google-Smtp-Source: AGHT+IHe1ko4alECHlICV+XZV5VY96Dbt04v3ZTmrCQoYplHACySM6Q5GQzJJsYU72lFwDg6nLSsLg==
X-Received: by 2002:a7b:c3d8:0:b0:436:17e4:ad4c with SMTP id
 5b1f17b1804b1-438a0d3c71fmr222778305e9.6.1737736125570; 
 Fri, 24 Jan 2025 08:28:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/76] target/arm: Define new fp_status_a32 and fp_status_a64
Date: Fri, 24 Jan 2025 16:27:26 +0000
Message-Id: <20250124162836.2332150-7-peter.maydell@linaro.org>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We want to split the existing fp_status in the Arm CPUState into
separate float_status fields for AArch32 and AArch64.  (This is
because new control bits defined by FEAT_AFP only have an effect for
AArch64, not AArch32.) To make this split we will:
 * define new fp_status_a32 and fp_status_a64 which have
   identical behaviour to the existing fp_status
 * move existing uses of fp_status to fp_status_a32 or
   fp_status_a64 as appropriate
 * delete the old fp_status when it has no uses left

In this patch we add the new float_status fields.

We will also need to split fp_status_f16, but we will do that
as a separate series of patches.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  4 ++++
 target/arm/tcg/translate.h | 12 ++++++++++++
 target/arm/cpu.c           |  2 ++
 target/arm/vfp_helper.c    | 12 ++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9a6e8e589cc..337c5383748 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -634,6 +634,8 @@ typedef struct CPUArchState {
         /* There are a number of distinct float control structures:
          *
          *  fp_status: is the "normal" fp status.
+         *  fp_status_a32: is the "normal" fp status for AArch32 insns
+         *  fp_status_a64: is the "normal" fp status for AArch64 insns
          *  fp_status_fp16: used for half-precision calculations
          *  standard_fp_status : the ARM "Standard FPSCR Value"
          *  standard_fp_status_fp16 : used for half-precision
@@ -659,6 +661,8 @@ typedef struct CPUArchState {
          * an explicit FPSCR read.
          */
         float_status fp_status;
+        float_status fp_status_a32;
+        float_status fp_status_a64;
         float_status fp_status_f16;
         float_status standard_fp_status;
         float_status standard_fp_status_f16;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 2d37d7c9f21..a7509b314b0 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -671,6 +671,8 @@ static inline CPUARMTBFlags arm_tbflags_from_tb(const TranslationBlock *tb)
  */
 typedef enum ARMFPStatusFlavour {
     FPST_FPCR,
+    FPST_FPCR_A32,
+    FPST_FPCR_A64,
     FPST_FPCR_F16,
     FPST_STD,
     FPST_STD_F16,
@@ -686,6 +688,10 @@ typedef enum ARMFPStatusFlavour {
  *
  * FPST_FPCR
  *   for non-FP16 operations controlled by the FPCR
+ * FPST_FPCR_A32
+ *   for AArch32 non-FP16 operations controlled by the FPCR
+ * FPST_FPCR_A64
+ *   for AArch64 non-FP16 operations controlled by the FPCR
  * FPST_FPCR_F16
  *   for operations controlled by the FPCR where FPCR.FZ16 is to be used
  * FPST_STD
@@ -702,6 +708,12 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     case FPST_FPCR:
         offset = offsetof(CPUARMState, vfp.fp_status);
         break;
+    case FPST_FPCR_A32:
+        offset = offsetof(CPUARMState, vfp.fp_status_a32);
+        break;
+    case FPST_FPCR_A64:
+        offset = offsetof(CPUARMState, vfp.fp_status_a64);
+        break;
     case FPST_FPCR_F16:
         offset = offsetof(CPUARMState, vfp.fp_status_f16);
         break;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dc0231233a6..8bdd535db95 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -573,6 +573,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_default_nan_mode(1, &env->vfp.standard_fp_status);
     set_default_nan_mode(1, &env->vfp.standard_fp_status_f16);
     arm_set_default_fp_behaviours(&env->vfp.fp_status);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status_f16);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index afc41420eb1..7475f97e0ce 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -64,6 +64,8 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     uint32_t i;
 
     i = get_float_exception_flags(&env->vfp.fp_status);
+    i |= get_float_exception_flags(&env->vfp.fp_status_a32);
+    i |= get_float_exception_flags(&env->vfp.fp_status_a64);
     i |= get_float_exception_flags(&env->vfp.standard_fp_status);
     /* FZ16 does not generate an input denormal exception.  */
     i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
@@ -81,6 +83,8 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      * be the architecturally up-to-date exception flag information first.
      */
     set_float_exception_flags(0, &env->vfp.fp_status);
+    set_float_exception_flags(0, &env->vfp.fp_status_a32);
+    set_float_exception_flags(0, &env->vfp.fp_status_a64);
     set_float_exception_flags(0, &env->vfp.fp_status_f16);
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
     set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
@@ -109,6 +113,8 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
             break;
         }
         set_float_rounding_mode(i, &env->vfp.fp_status);
+        set_float_rounding_mode(i, &env->vfp.fp_status_a32);
+        set_float_rounding_mode(i, &env->vfp.fp_status_a64);
         set_float_rounding_mode(i, &env->vfp.fp_status_f16);
     }
     if (changed & FPCR_FZ16) {
@@ -122,10 +128,16 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         bool ftz_enabled = val & FPCR_FZ;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a64);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a64);
     }
     if (changed & FPCR_DN) {
         bool dnan_enabled = val & FPCR_DN;
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16);
     }
 }
-- 
2.34.1


