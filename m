Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E15C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6z-0000sk-4d; Tue, 11 Feb 2025 11:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6H-00071v-0S
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:07 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6C-0003e0-R1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:04 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4394a823036so17360835e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291219; x=1739896019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2+eGFS3Y9n+RVP7ZZfbx8EfwhLtSPudzUjSz57pI92s=;
 b=Kj9nvD62qtJMo5U5TSWThj6ga8v5tZquObsB3DBYidFu4fHiI06ZQbLe/FSGqTa8pX
 UrFEaqGxgtdJXMvOV7ts1eqSLLXsitD7Tuzkfhk+lp0W9O0AsiUBMKfTeSoqtwwG6ZvO
 6KS2HJlHUr/F9m7hLL6YSCc2CGhTpZdZiD3+VwFltP3IPuaiRvQ9TJ1SjvlKaCn0wW05
 HvLo9LukQpsNSzMQPN+QfjfikBavifaAMmn3tZfNwXgp8w7tMFFKCvAA8isYH/W9qw/8
 ypvuj8Y83JmP/qJ+akwwZ4/FAQ88LmXS+YNGgQI19+joOmrEz2Gri/ZMbnER0FbsvsKP
 ITlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291219; x=1739896019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+eGFS3Y9n+RVP7ZZfbx8EfwhLtSPudzUjSz57pI92s=;
 b=HL5A6prBc8KsGLEl+wr56pDxINkemj3wB/0pGF4qWQSbEWysOmmgKicka7opbuzt5v
 jo37O3lWLe/oN1UmxZTeaZjzGbEY5ZoceMmL6Tlmln2J/1UIM2XRz7BMlVs3NOF2ud9g
 7+B3KIdgnM3DZez5uXgWuSrRTLmDMMkyJaexm2qRC2GOnsLOVHXzP+fOKhQ5uyuzTIOb
 viBTpeWYohQQ93bQ5DWLDAKPPsXAd7O8jWHrNv5xCg+3u3BknMQiAG91GUl+qbNeMBPe
 IrMSWXUuYS0lqky+vcG7IG5phTiIuJ6xoGom7o1V2MBucOFcZ2odRoBkLlLuQ3eHKdt4
 XSnw==
X-Gm-Message-State: AOJu0Yz6kC1I/GalIjEHO0GVEPGx05YS+p551zQpi9ZMRnMNbpb+vhaN
 zBXTm92lFVW90RGk7QcCrtujVuTJiieU1IWwr/9oefASN4vZXIyU09OLtJVOHiqbIC11dQlWpCX
 P
X-Gm-Gg: ASbGncu6ErBt9i5gS4OKvl83Jii6eDEf1QY6wvpQos/dMSkbfr92ruM9s0OGiHn9WFe
 J9xz6v0IkADS+0PZLn2VoL8h0Fu4AXf2W9TTEQ9OfsGVXsU4Jm5HKdS9zWzoTJhENcBxxEtWjMg
 14tf4umOyFhrgVon2zegPbwlkwqTbw45iO1kh49RCdAEyyLxGyjFW62T1KsQ37ZU0DDqaTH44Rj
 HpRXUvOVtneQyqYgVCUOKwJenYRnGvrp7zO6Erkvx07v3AwJEqTXi7NOaCGrTXRcWb6ZaqbjVL2
 r1TNSfmnkK9MOqiLSBDX
X-Google-Smtp-Source: AGHT+IH0E+f5czgyCvfms/S93rjeSjsXmzrj2DLaBLi8AsFy+SJV5JZbNOyGaanggR8ZsJrTcBlzWQ==
X-Received: by 2002:a05:600c:1f8c:b0:439:35d2:ed6 with SMTP id
 5b1f17b1804b1-43935d2109emr109492875e9.3.1739291218797; 
 Tue, 11 Feb 2025 08:26:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/68] target/arm: Remove ah_fp_status
Date: Tue, 11 Feb 2025 16:25:46 +0000
Message-Id: <20250211162554.4135349-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Replace with fp_status[FPST_AH].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        | 3 +--
 target/arm/cpu.c        | 6 +++---
 target/arm/vfp_helper.c | 6 +++---
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 91e132024e7..577c69dec1a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -233,7 +233,7 @@ typedef struct NVICState NVICState;
  * the "standard FPSCR" tracks the FPSCR.FZ16 bit rather than
  * using a fixed value for it.
  *
- * The ah_fp_status is needed because some insns have different
+ * FPST_AH is needed because some insns have different
  * behaviour when FPCR.AH == 1: they don't update cumulative
  * exception flags, they act like FPCR.{FZ,FIZ} = {1,1} and
  * they ignore FPCR.RMode. But they don't ignore FPCR.FZ16,
@@ -694,7 +694,6 @@ typedef struct CPUArchState {
                 float_status fp_status_a64;
                 float_status fp_status_f16_a32;
                 float_status fp_status_f16_a64;
-                float_status ah_fp_status;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5a21a6c6eb2..6b4839b5bac 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -556,9 +556,9 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
-    arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status);
-    set_flush_to_zero(1, &env->vfp.ah_fp_status);
-    set_flush_inputs_to_zero(1, &env->vfp.ah_fp_status);
+    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
+    set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
+    set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_AH]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH_F16]);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index ec7c0d6a98f..2bb98c4ee49 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -129,7 +129,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
           & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
-     * We do not merge in flags from ah_fp_status or FPST_AH_F16, because
+     * We do not merge in flags from FPST_AH or FPST_AH_F16, because
      * they are used for insns that must not set the cumulative exception bits.
      */
 
@@ -161,7 +161,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
-    set_float_exception_flags(0, &env->vfp.ah_fp_status);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH_F16]);
 }
 
@@ -236,7 +236,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
-        set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
     if (changed & FPCR_AH) {
-- 
2.34.1


