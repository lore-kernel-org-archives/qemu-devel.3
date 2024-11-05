Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0048AD12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbD-0004SX-Lj; Tue, 05 Nov 2024 06:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbB-0004RY-1G
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb6-000751-FC
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:48 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so41098995e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805579; x=1731410379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SsKJm0cgG3cclmW2jQ7Wow6omeKg5AA44umCDXD6jSQ=;
 b=aw6w2CpoQUXCprwSkO9uo51gCWBdIQjF6yduYqQIAgqQ6MFqmsg1wJk1R99LNWkfgv
 H5KDPIoyR0NbZGMuEVsVYbb1E/b5/KpkVa509fCKP0suGZO+DonySA6ox5Wp4pV4aRKE
 EgUlEsGRyfrfmsOUJE36CIKjqm1O0gaJnUaP2qvo11ijo+tIZjAjffRuYhKRF45LL5w6
 Eh4n53Tat9A6r/+OLec+2OLnMmkOuzy/TGfJPjG4KUiycGDanqxbui65LXUm/v2Pq0HR
 SuABph4yk9cRH8yATz5oLLvWD1PLQrNCx26wQyJGs6wHzXGyBhM2uKhU45/8x8h4jayg
 p+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805579; x=1731410379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsKJm0cgG3cclmW2jQ7Wow6omeKg5AA44umCDXD6jSQ=;
 b=B+VsdU46D9lg/sKZoLPfVvj70l4GJxjcoTWGOmVEK1GSbCd+GQIghywOMNESH18bOn
 rnSml089dUFT0HK6fa0LszqeqOdC/NS8HT0MgpLS57hy+ktDGdoC2GoWzCqrgcCOyuep
 YKQVXVqEIgDxIWhyXxU+X06LvK2bED+c4gKtFi706smGZG5+UG7RgY1h2vUZHnRyEWRm
 M7dlrqAGHa1wEZSn8MYd6uxqG5A8l+vQbdXIJTwKpO9fys5uRbXik7QzS9QIeVtFRzIg
 sqAanZHRIvByDxCmRsMCayn5DvaM50wzarMCpsHY+GYRgy15l0OWeqWLMbzCfpqKxwgB
 Tj0A==
X-Gm-Message-State: AOJu0YyuJHdhPd564toNymmJzOgSRA3VFpkscbZw/pOMUJ/m8o0ax4+z
 w2zfnAwVTeVNThrxPPbyAobRECTmck+tKIzoSZfCyp1hRZ5oCLA4UIkXzO81+NaEJwtpFL1s6dD
 g
X-Google-Smtp-Source: AGHT+IFkvhgauqiqDhNrqVse+JaZwTyEdSEvUxGE3f+xYWcLi+czc+ldVyCWu+OSQL6oxcTF2ejRRw==
X-Received: by 2002:a05:600c:1f82:b0:430:57f2:bae2 with SMTP id
 5b1f17b1804b1-431bb9d14afmr189910775e9.23.1730805579447; 
 Tue, 05 Nov 2024 03:19:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/31] target/arm: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:07 +0000
Message-Id: <20241105111935.2747034-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Set the 2-NaN propagation rule explicitly in the float_status words
we use.  We wrap this plus the pre-existing setting of the
tininess-before-rounding flag in a new function
arm_set_default_fp_behaviours() to avoid repetition, since we have a
lot of float_status words at this point.

The situation with FPA11 emulation in linux-user is a little odd, and
arguably "correct" behaviour there would be to exactly match a real
Linux kernel's FPA11 emulation.  However FPA11 emulation is
essentially dead at this point and so it seems better to continue
with QEMU's current behaviour and leave a comment describing the
situation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-4-peter.maydell@linaro.org
---
 linux-user/arm/nwfpe/fpa11.c   | 18 ++++++++++++++++++
 target/arm/cpu.c               | 25 +++++++++++++++++--------
 fpu/softfloat-specialize.c.inc | 13 ++-----------
 3 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/linux-user/arm/nwfpe/fpa11.c b/linux-user/arm/nwfpe/fpa11.c
index 9a93610d245..8356beb52c6 100644
--- a/linux-user/arm/nwfpe/fpa11.c
+++ b/linux-user/arm/nwfpe/fpa11.c
@@ -51,6 +51,24 @@ void resetFPA11(void)
 #ifdef MAINTAIN_FPCR
   fpa11->fpcr = MASK_RESET;
 #endif
+
+  /*
+   * Real FPA11 hardware does not handle NaNs, but always takes an
+   * exception for them to be software-emulated (ARM7500FE datasheet
+   * section 10.4). There is no documented architectural requirement
+   * for NaN propagation rules and it will depend on how the OS
+   * level software emulation opted to do it. We here use prop_s_ab
+   * which matches the later VFP hardware choice and how QEMU's
+   * fpa11 emulation has worked in the past. The real Linux kernel
+   * does something slightly different: arch/arm/nwfpe/softfloat-specialize
+   * propagateFloat64NaN() has the curious behaviour that it prefers
+   * the QNaN over the SNaN, but if both are QNaN it picks A and
+   * if both are SNaN it picks B. In theory we could add this as
+   * a NaN propagation rule, but in practice FPA11 emulation is so
+   * close to totally dead that it's not worth trying to match it at
+   * this late date.
+   */
+  set_float_2nan_prop_rule(float_2nan_prop_s_ab, &fpa11->fp_status);
 }
 
 void SetRoundingMode(const unsigned int opcode)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5b751439bdc..6938161b954 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -168,6 +168,18 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
     QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
 }
 
+/*
+ * Set the float_status behaviour to match the Arm defaults:
+ *  * tininess-before-rounding
+ *  * 2-input NaN propagation prefers SNaN over QNaN, and then
+ *    operand A over operand B (see FPProcessNaNs() pseudocode)
+ */
+static void arm_set_default_fp_behaviours(float_status *s)
+{
+    set_float_detect_tininess(float_tininess_before_rounding, s);
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
+}
+
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
 {
     /* Reset a single ARMCPRegInfo register */
@@ -549,14 +561,11 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_inputs_to_zero(1, &env->vfp.standard_fp_status);
     set_default_nan_mode(1, &env->vfp.standard_fp_status);
     set_default_nan_mode(1, &env->vfp.standard_fp_status_f16);
-    set_float_detect_tininess(float_tininess_before_rounding,
-                              &env->vfp.fp_status);
-    set_float_detect_tininess(float_tininess_before_rounding,
-                              &env->vfp.standard_fp_status);
-    set_float_detect_tininess(float_tininess_before_rounding,
-                              &env->vfp.fp_status_f16);
-    set_float_detect_tininess(float_tininess_before_rounding,
-                              &env->vfp.standard_fp_status_f16);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status);
+    arm_set_default_fp_behaviours(&env->vfp.standard_fp_status);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status_f16);
+    arm_set_default_fp_behaviours(&env->vfp.standard_fp_status_f16);
+
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
         kvm_arm_reset_vcpu(cpu);
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index fae6794a152..70cd3628b54 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -402,19 +402,10 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
         /* target didn't set the rule: fall back to old ifdef choices */
 #if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
-    || defined(TARGET_TRICORE)
+    || defined(TARGET_TRICORE) || defined(TARGET_ARM)
         g_assert_not_reached();
-#elif defined(TARGET_ARM) || defined(TARGET_MIPS) || defined(TARGET_HPPA) || \
+#elif defined(TARGET_MIPS) || defined(TARGET_HPPA) || \
     defined(TARGET_LOONGARCH64) || defined(TARGET_S390X)
-        /*
-         * ARM mandated NaN propagation rules (see FPProcessNaNs()), take
-         * the first of:
-         *  1. A if it is signaling
-         *  2. B if it is signaling
-         *  3. A (quiet)
-         *  4. B (quiet)
-         * A signaling NaN is always quietened before returning it.
-         */
         /*
          * According to MIPS specifications, if one of the two operands is
          * a sNaN, a new qNaN has to be generated. This is done in
-- 
2.34.1


