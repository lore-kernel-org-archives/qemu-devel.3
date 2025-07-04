Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE19C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEC-0008SF-RF; Fri, 04 Jul 2025 12:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE8-0008Ok-4k
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:28 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE5-00069Q-VT
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:27 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so598003f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646324; x=1752251124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rw2V7LRv7N3yBEu1EXHYSf8y/jFZBXV4IPLu7x+20gQ=;
 b=rvKj9vUr51dTW/FvE+zTOcUTnQrkwwPHMjMxmjZRVVHpiFGGCCMl6V3zziWH4YIgm7
 ahZZAcD9VoN8Eh0Vl1DAK6ECvbTe3IQsjhbgjeQIwJ0wHiTDzPp49H8sEbDHSc4uzAYf
 pgJ3W06iWqVSoR68HKrbol4Ya6VqoBFI29mgzjIAqdCtOwCzLDiZAxzSc9rUZ8BY+Qez
 /qiEHePkTtnUGMmih/CF+9wHjMmE6ACuL31zJC9kQUxlHvse0oEmb/+ltP0AqG9KhwH0
 J/IAv3rVRwdTferUECHM/0mCEvsxi6/pDnYiwf+22iH0eqbyANQtxfyVdcceNY2SeGkN
 Vs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646324; x=1752251124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rw2V7LRv7N3yBEu1EXHYSf8y/jFZBXV4IPLu7x+20gQ=;
 b=gEuAVVHiS2vpvbvnSA9FMx4lB8rsh4w1ZFjmJmHA1v18rANrHmPEop3/yNqJ3jsRzP
 jwDEXFthsLGyfPAFfMRxmwGoJmxQPu6Y90nsxqli4NjY8akYlDINQVbiO12CXvU3B0IW
 8w2xyf2gGhEPeA55baC1TFYgrYfzT1CtR402Y4g+siLJ+z+yfbkoGcFlRREDOreaHjkz
 BhS96WBM9DhU/0+snKPN6Lxfz9CiOnhRIR3Blt0dFdmymV4Rgdqw2a3fahIwEOZ8h83S
 fqBcigMMAEyDeU8ioiC8KKWKriqy1rDSgHuvrzHXyzWoiLKfdpwSWef4NckErQBkwNrq
 P95w==
X-Gm-Message-State: AOJu0YzHQ2t9LdDyXda3ny2k9cb0QCZjzNMgCOA7dB6Fi7yVHYLVE7ND
 bq1SVme3CH4RWt8IQxnOuddMqy+UHLOyei+VZzaoQh1zUe0VJvIbsHONPbCWEHvR3bQsToXtSyg
 YFaaw
X-Gm-Gg: ASbGnctF6CQMUZSVeYez9sBWIb9CQTHQyrRdLWx3fXEVwZviNYJIwTQ/06cahoQce6u
 jEdP6NhtRA8To1BkgZobwYwaEdvQ2QWDOcW6OLntxmsdUszOsEGwbs819lOoiQGKMgKHzu8a6Da
 2/TdONwIf14M0sLFFQvsXBbcCF1kYf6u9tA/nPa7HR2gV/TZfYBBYCGYJaXkcYIX8DIsxk2se71
 Id68MBReL1XJkfaxq1oNe12BCNyCcJOPtNsgmX+5BR+Hfy9If63bw0xKBWzPrWJtJDLojLi5/ux
 IXnmeofrp+9i/ZgqF/sn2mJxVPzW8rgjtsUByW0MvZ62vaNu/vDCn363DxsTmfm+2AuI
X-Google-Smtp-Source: AGHT+IEBFrDZpH5OvyUYkiTNlzjXX6xep6fJt7cpQrZdpPxSiiJF0TVROBghkKCvp2Wg9IwrsmZ49A==
X-Received: by 2002:a05:6000:22c6:b0:3a5:3a3b:6a3a with SMTP id
 ffacd0b85a97d-3b4970432aamr2244306f8f.54.1751646324221; 
 Fri, 04 Jul 2025 09:25:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 023/119] target/arm: Introduce FPST_ZA, FPST_ZA_F16
Date: Fri,  4 Jul 2025 17:23:23 +0100
Message-ID: <20250704162501.249138-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Rather than repeatedly copying FPST_FPCR to locals
and setting default nan mode, create dedicated float_status.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h            | 12 +++++++++++-
 target/arm/cpu.c            |  4 ++++
 target/arm/tcg/vfp_helper.c | 12 +++++++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 96a49072665..2530aaca22c 100644
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
index ebac86f70d3..7b207f2620c 100644
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
index b1324c5c0a6..e156e3774ad 100644
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


