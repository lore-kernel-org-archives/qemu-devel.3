Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269F0C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMah-00089L-Ut; Fri, 24 Jan 2025 11:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYX-00040E-Rq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:19 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYV-0005ZF-V7
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:17 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so24852005e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736154; x=1738340954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jN3mFnktaZqVK11S456/SP/OoMEiasYt5k58IjHmWbU=;
 b=eryf4QoeJnKBtq5craoip97NvTILEp5Dqy3hbwhgSDDs73DRxGHxVyWquh+oBHQACx
 dnJDki1ZsxsXfUIvXaGPmibO/KlSC12i/t/QZF570ihWUUIjjCOjQv9Tmhtf15UvGDAj
 quWogAvqqubs/jOqRzP6u2zQSV0oEuslu+/fs0Ou7OlIYMmxspe/flkFsU1IqfuW55hU
 1/R9YpjT1WnmSXLbP2Ni4RhwIIpfeIRA8thqCrMAEMAgL+ddYew8aUWM1evsfAcdBzYf
 Rn5ncMa1y5nOqR/yJPzUUmwbnfl76ubdvbVMuNLlwr7DzwxYMsm2cGasD3bJK+IEyppL
 lYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736154; x=1738340954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jN3mFnktaZqVK11S456/SP/OoMEiasYt5k58IjHmWbU=;
 b=tdbkUF0HGQbglN329XqJ35T/F/XEfsT6CkkZojwC+6xXUqlc0iFKbQfnrhya7y1Lk9
 Pq2TF92hIDXZiIfrAogeSwS/qyOaYocdBLtj8a0m74iffVaG5c6+2bylI+aEy5NQOA+S
 xjSclAXCYR5h61DUWov1wuDOw0JGEy1v6nqI4Kjl7NZXvb9ksLlb1QvKYWN8Nl4hn2nM
 8NdGFX5R7u8Wb6mkP9IiodNRhMb4lpRXbkketYIBvsx4ClX4fLs7JQLWbs6EwRpDCV2/
 8WUnzt4Si7bUxDtLbEZPUCZjfsqqHjEEHMSTlqf5Qo85WPNH+XqHvxqXo1znXcw+5MYD
 W6Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBC+zyVs18KBMkieZFiadrXBUlQlEqd8czV6vCWqtty3qeBUQfixZCNZq+txpjjw7YPuSMRAApRNz+@nongnu.org
X-Gm-Message-State: AOJu0YyXTxZrAeZZIJE7sNqIbJdKtJCbRMV5kHo/+jetM80fxsUIygGu
 SlH5W99yy08oK/pB1N4NTWQ0/Y9QI93wKWCgUjh3GTLrC9hBkJ8FSvvCzmhe/DM=
X-Gm-Gg: ASbGnctAvPX2AnBLyTj3uwUg9w9BtRHTj7jcyJgQn13lnN/+zcuj/054QgllbPQcIbj
 QU7v1ZrHLcBcfs7D7iR1gMNDNEKNMUqOr4R3kBVLa2nXWqMgXSuTIqv8G0a/Rs8/Eb7BosObepC
 Jy69uuKZc4lmsFJXhoYt+uO9EZX6hLmKfNaSKb42NtOmmW1NT7XNmbf5TFhPQdQAlEWJiw7ugQ0
 ZtG1fICI9hFimHSpTz68T3QGbrTvsC+zbHcTN4WmkzZJ7CcmOAq/roetjr+opwjHEvQge9zypV5
 QrtdvrmcAoA=
X-Google-Smtp-Source: AGHT+IFTaKlHVCwBeoUj4YP2e0U6QEJOsGn9/GcaotTgu9S/cZTLGw0tPkXt1cxN3qTrNq9GPdEhnQ==
X-Received: by 2002:a05:600c:1c1e:b0:436:6460:e67a with SMTP id
 5b1f17b1804b1-43891452899mr251172675e9.25.1737736154514; 
 Fri, 24 Jan 2025 08:29:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 29/76] target/arm: Adjust FP behaviour for FPCR.AH = 1
Date: Fri, 24 Jan 2025 16:27:49 +0000
Message-Id: <20250124162836.2332150-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
---
 target/arm/internals.h  |  4 +++
 target/arm/cpu.c        | 23 -----------------
 target/arm/vfp_helper.c | 56 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 23 deletions(-)

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
index 0b4cd872d27..1ba22c4c7aa 100644
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
-    set_float_detect_ftz(detect_ftz_before_rounding, s);
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
index 5a0b389f7a3..7507ff24bc0 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -31,6 +31,50 @@
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
+    set_float_detect_ftz(detect_ftz_before_rounding, s);
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
+    set_float_detect_ftz(detect_ftz_after_rounding, s);
+    set_float_2nan_prop_rule(float_2nan_prop_ab, s);
+    set_float_3nan_prop_rule(float_3nan_prop_abc, s);
+    set_float_infzeronan_rule(float_infzeronan_dnan_never |
+                              float_infzeronan_suppress_invalid, s);
+    set_float_default_nan_pattern(0b11000000, s);
+}
+
 #ifdef CONFIG_TCG
 
 /* Convert host exception flags to vfp form.  */
@@ -171,6 +215,18 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
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


