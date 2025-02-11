Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1871C021A2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5P-0006QD-Ja; Tue, 11 Feb 2025 11:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5M-0006Oz-GN
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:08 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5K-00033R-Fa
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:08 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4394820123dso13875065e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291165; x=1739895965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cRyCbqg0b5XAx/QhwhjA1gZIaJJF6zFtpss62+gKAsc=;
 b=d/rWtFEGH9CafiOCHtwsgjyDMKPpD9vv0/VMyU/QGbQry+EXQkbAVI3f2/ACjP/q8k
 w5tZmNpzI6uCdXAXEyJIhYErXihFbH1vB+6HKHkTiE8oNPYp/klCInZ9hYilo08B4bAH
 KVksDpbq/7hT8dFFKOmtwzGVMMLjdSN9J9c39Pue19x1fgyk+GedAtatXyilcqMy6Q5q
 auxySRVeaHUlHisEN+J7wIb+UpX8MryNl/ds+lpdvky8FVnfTAb6Ghrufr6QOekBtg9M
 fpcSJG/bXkB8c2uZbGbXq2VY+puDKR5vP5WSit5HMPSWZCXdG9+bLUsiivVUMM6xo5ZM
 eEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291165; x=1739895965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRyCbqg0b5XAx/QhwhjA1gZIaJJF6zFtpss62+gKAsc=;
 b=CgtL1ofu8Utlljov2njDgTSoC4ikpqs0fxiHxEb7T5pLwgcz0fNFebpdWNAz6YkSj7
 JVfA3IxWyOppNf4PRoF+kHmuJy4k+Hu0nzuBafT/wQq62vSyfB5uGymx50wsVHjP9gM5
 C0lVSN/3nlDxE8MuL9kRoVT9vgOEe4MAVOtQWs/MLsCImXLb1Px98Q3TAKnd85x8Rk4I
 87QoayQhiK0czCrPwxl5h4KKQczOGvXE662oAUizlmEtGhnbuiGc4FiGNQUrv2MBAqyS
 atf2J2hq0NL6e0l6D4J6jr7QJqpxtFJg6XAP5MazUgneqCwgkcNBZnaicZsyFxkY4k1W
 XdKA==
X-Gm-Message-State: AOJu0Yz5FA3Uc6wFZM1NsyXjn//qEm2dNJNvhMR8WWWhBWqR1w39h4fN
 HEFNdozBIhpKPbrm7uvmZozlu43k/KZ2+Qn5RcUUeeUs9n1qPTPrNQZ0Q/fu3QAqfMUJTu0+Tdw
 z
X-Gm-Gg: ASbGncuPhXStxVn9csLRVp81C0f6RZTYVOgo04H1tcSCzzH0vUbqkop6c+5V/jSoki0
 smPp3vonPbvy4MmwtAEzaNYks/BdSiOQEHgmrdyrphTSuk8qc9E+FxMAztPfDFDpV0Hpa0exqZk
 1b2SPzMXLAVCoeEPCQ2BTmP+rOZemiB/Ib+DS5LnVceOOKuA0wZSegGwq2W9Tpq8rkW9j4zLC7W
 llBv/7sluXvFuWXbnjipusvm2dZJxfH7sgCOCuBdG+nvKS81XpiUPXCphMoHs2KUelaNeOKSzSW
 KhXBIZ1uII/u9tarsKY0
X-Google-Smtp-Source: AGHT+IGI63dtsyKjKdrK6cyS1FhBstlaCJM27sA/lpsg64N8N82hRVNKzf1H76ebXzGCdclASNs4Mg==
X-Received: by 2002:a05:6000:1fa2:b0:38d:d43c:31b5 with SMTP id
 ffacd0b85a97d-38dd43c356amr10931300f8f.38.1739291164660; 
 Tue, 11 Feb 2025 08:26:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/68] target/arm: Adjust FP behaviour for FPCR.AH = 1
Date: Tue, 11 Feb 2025 16:24:53 +0000
Message-Id: <20250211162554.4135349-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

When FPCR.AH is set, various behaviours of AArch64 floating point
operations which are controlled by softfloat config settings change:
 * tininess and ftz detection before/after rounding
 * NaN propagation order
 * result of 0 * Inf + NaN
 * default NaN value

When the guest changes the value of the AH bit, switch these config
settings on the fp_status_a64 and fp_status_f16_a64 float_status
fields.

This requires us to make the arm_set_default_fp_behaviours() function
global, since we now need to call it from cpu.c and vfp_helper.c; we
move it to vfp_helper.c so it can be next to the new
arm_set_ah_fp_behaviours().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h  |  4 +++
 target/arm/cpu.c        | 23 ----------------
 target/arm/vfp_helper.c | 58 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 24 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 863a84edf81..98073acc276 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1828,4 +1828,8 @@ uint64_t gt_virt_cnt_offset(CPUARMState *env);
  * all EL1" scope; this covers stage 1 and stage 2.
  */
 int alle1_tlbmask(CPUARMState *env);
+
+/* Set the float_status behaviour to match the Arm defaults */
+void arm_set_default_fp_behaviours(float_status *s);
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 80377443008..f95e6cf09e3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -169,29 +169,6 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
     QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
 }
 
-/*
- * Set the float_status behaviour to match the Arm defaults:
- *  * tininess-before-rounding
- *  * 2-input NaN propagation prefers SNaN over QNaN, and then
- *    operand A over operand B (see FPProcessNaNs() pseudocode)
- *  * 3-input NaN propagation prefers SNaN over QNaN, and then
- *    operand C over A over B (see FPProcessNaNs3() pseudocode,
- *    but note that for QEMU muladd is a * b + c, whereas for
- *    the pseudocode function the arguments are in the order c, a, b.
- *  * 0 * Inf + NaN returns the default NaN if the input NaN is quiet,
- *    and the input NaN if it is signalling
- *  * Default NaN has sign bit clear, msb frac bit set
- */
-static void arm_set_default_fp_behaviours(float_status *s)
-{
-    set_float_detect_tininess(float_tininess_before_rounding, s);
-    set_float_ftz_detection(float_ftz_before_rounding, s);
-    set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
-    set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
-    set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
-    set_float_default_nan_pattern(0b01000000, s);
-}
-
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
 {
     /* Reset a single ARMCPRegInfo register */
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 30c170ecee5..ef85c186f17 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -22,15 +22,59 @@
 #include "exec/helper-proto.h"
 #include "internals.h"
 #include "cpu-features.h"
+#include "fpu/softfloat.h"
 #ifdef CONFIG_TCG
 #include "qemu/log.h"
-#include "fpu/softfloat.h"
 #endif
 
 /* VFP support.  We follow the convention used for VFP instructions:
    Single precision routines have a "s" suffix, double precision a
    "d" suffix.  */
 
+/*
+ * Set the float_status behaviour to match the Arm defaults:
+ *  * tininess-before-rounding
+ *  * 2-input NaN propagation prefers SNaN over QNaN, and then
+ *    operand A over operand B (see FPProcessNaNs() pseudocode)
+ *  * 3-input NaN propagation prefers SNaN over QNaN, and then
+ *    operand C over A over B (see FPProcessNaNs3() pseudocode,
+ *    but note that for QEMU muladd is a * b + c, whereas for
+ *    the pseudocode function the arguments are in the order c, a, b.
+ *  * 0 * Inf + NaN returns the default NaN if the input NaN is quiet,
+ *    and the input NaN if it is signalling
+ *  * Default NaN has sign bit clear, msb frac bit set
+ */
+void arm_set_default_fp_behaviours(float_status *s)
+{
+    set_float_detect_tininess(float_tininess_before_rounding, s);
+    set_float_ftz_detection(float_ftz_before_rounding, s);
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
+    set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
+    set_float_default_nan_pattern(0b01000000, s);
+}
+
+/*
+ * Set the float_status behaviour to match the FEAT_AFP
+ * FPCR.AH=1 requirements:
+ *  * tininess-after-rounding
+ *  * 2-input NaN propagation prefers the first NaN
+ *  * 3-input NaN propagation prefers a over b over c
+ *  * 0 * Inf + NaN always returns the input NaN and doesn't
+ *    set Invalid for a QNaN
+ *  * default NaN has sign bit set, msb frac bit set
+ */
+static void arm_set_ah_fp_behaviours(float_status *s)
+{
+    set_float_detect_tininess(float_tininess_after_rounding, s);
+    set_float_ftz_detection(float_ftz_after_rounding, s);
+    set_float_2nan_prop_rule(float_2nan_prop_ab, s);
+    set_float_3nan_prop_rule(float_3nan_prop_abc, s);
+    set_float_infzeronan_rule(float_infzeronan_dnan_never |
+                              float_infzeronan_suppress_invalid, s);
+    set_float_default_nan_pattern(0b11000000, s);
+}
+
 #ifdef CONFIG_TCG
 
 /* Convert host exception flags to vfp form.  */
@@ -173,6 +217,18 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
     }
+    if (changed & FPCR_AH) {
+        bool ah_enabled = val & FPCR_AH;
+
+        if (ah_enabled) {
+            /* Change behaviours for A64 FP operations */
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status_a64);
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status_f16_a64);
+        } else {
+            arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
+            arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
+        }
+    }
     /*
      * If any bits changed that we look at in vfp_get_fpsr_from_host(),
      * we must sync the float_status flags into vfp.fpsr now (under the
-- 
2.34.1


