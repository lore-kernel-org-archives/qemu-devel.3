Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EA1C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhL0-0001Q0-MG; Fri, 04 Jul 2025 10:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIB-00050u-IW
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:34 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhI8-0005VL-LC
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:31 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2da3c572a0bso856067fac.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638887; x=1752243687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/yxK4ycoVNRw596WwqFvL3H0CMyEDhZFsU88OCfnpOI=;
 b=tA5tcOKo9K0J3rPuuFfMphKNQQP1mmZKx7bV+D3pB2OTD+3Z6gv2J/mP7UNy7kOxDs
 4/AovTDkeD79pM9kq+j1FZoJTs0ktSCe1CMN6Wfw6JbPwTTCfEHBKX6cnqpXgUqYq6OM
 Or2YKkQhwfSR6T8JNQ5VVAqIRQmf0R/AvVmrdD4Ui5k9UUP2hj25ZgabbiE4QcXYl0VV
 itarpuU6oajZp4S58e3IoEzV/v75R2tHX28IR7z0aD5D9whCd7n2gN3sO1K8mVIs/dNK
 GLGYuF0nvwDtTUe7Nx8GU8Lx1hGuFDs+3Qr/BUsJ0BqmP+DHGw0Ai9yF3x+iBH1mGbuv
 QKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638887; x=1752243687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/yxK4ycoVNRw596WwqFvL3H0CMyEDhZFsU88OCfnpOI=;
 b=TnMBI3MOjmzMOCPt0v9KAdjS3GiLgoGM4wFkMU5HiJL09FQwkmf1Qo5QOqPvq4irGp
 PysgvGe6jv6O7U4DgoqgybxNbddxZFb0QODEwkt6OvV6ppPHbto5CqNNBa6kGNEp4RCm
 sMTPstPxK60CjlYiz594RpRP8oFTp/G1BAf4irq6ztRp7/4QObPqOzXNDWRGloqM5gsG
 aXkCzn8wlCkS3TFKU+2IV6dT8/4NbFlF+RZu4bNKmNL/7ZmSjTl+9n5JyWNlLYFghg1M
 g/D5HV/ZKlOmKJMMWMd+6dLckPBjlwaJQ+HlAArhI+hjm7EAkFMC0UteKhSi+zq8A8hv
 MoAg==
X-Gm-Message-State: AOJu0YxeUKCfOHVK/ctY9mQh8rqOllOp4J9bKgXxJmlceqbnOLYVaJ1t
 Nt2wFuZ63EFAa4NSuUxrvRp4RZLbian5it8S1D4xp/OLdWM1RV7adgZ6idM1JlthynwPxgf62L+
 Q7Zbdu8I=
X-Gm-Gg: ASbGncuOyHp93aVLZbxkz9nt8ltxgZk6LNV4fqR36+KiZMwJfke11lxnXthYiq8PaNd
 bZ6TUMOOa/69hxqZvhrvo+8+ZlEM8nob455EZegvSaFOI5EvtPHfNgPwfiStl//9b8Us/WIXG9I
 OU+/eNvBrBP/O6LytoiWvkz5eDE8KX/mDWUrmX1z8t1cgxI7Luwb6muGS//cp3guIAhe1TNUiYW
 1ODa6AIACfe4+1DuKwDJZfOMk881NTN4BldQb49kS0bZcmIm4EPwsQEwm0J/Y+OW1LDOxaWK1f7
 zcS+v6UbuM3WEcwDBZuLqsiio5VlxNLIx8EMH3AKHUMN9ADr9bdsUrCOCaJCdD8NJX/TyY+MfPf
 TiAbwXE4mcySV1Fs4W0oWLpLWXdh8VK7JFVfS0KBoXdaO4gkP
X-Google-Smtp-Source: AGHT+IEmRCTiwOFW/kGqe4lYhLdRnfDVrEL2oZtajURqn2LDdkMZJBZ28xTr5yZxLzkaMldGlV+bfQ==
X-Received: by 2002:a05:6870:8588:b0:29e:24c7:2861 with SMTP id
 586e51a60fabf-2f796a19e1dmr1863391fac.13.1751638887284; 
 Fri, 04 Jul 2025 07:21:27 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 011/108] target/arm: Introduce FPST_ZA, FPST_ZA_F16
Date: Fri,  4 Jul 2025 08:19:34 -0600
Message-ID: <20250704142112.1018902-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h            | 12 +++++++++++-
 target/arm/cpu.c            |  4 ++++
 target/arm/tcg/vfp_helper.c | 12 +++++++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 96a4907266..2530aaca22 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -207,6 +207,8 @@ typedef struct NVICState NVICState;
  *       when FPCR.AH == 1 (bfloat16 conversions and multiplies,
  *       and the reciprocal and square root estimate/step insns);
  *       for half-precision
+ * ZA: the "streaming sve" fp status.
+ * ZA_F16: likewise for half-precision.
  *
  * Half-precision operations are governed by a separate
  * flush-to-zero control bit in FPSCR:FZ16. We pass a separate
@@ -227,6 +229,12 @@ typedef struct NVICState NVICState;
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
@@ -240,10 +248,12 @@ typedef enum ARMFPStatusFlavour {
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
index ebac86f70d..7b207f2620 100644
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
index b1324c5c0a..e156e3774a 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -123,7 +123,7 @@ uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     a64_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A64_F16])
           & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
-     * We do not merge in flags from FPST_AH or FPST_AH_F16, because
+     * We do not merge in flags from FPST_{AH,ZA} or FPST_{AH,ZA}_F16, because
      * they are used for insns that must not set the cumulative exception bits.
      */
 
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


