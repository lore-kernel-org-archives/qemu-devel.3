Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E45DCD37AA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72Q-0000uq-2W; Thu, 07 May 2026 18:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72O-0000u5-Rl
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:44 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72M-0003G2-E8
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:44 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-408778a8ec4so807660fac.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192260; x=1778797060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DHW/PVSACyLCeJ01Jj+8W8gGU3WJOwf4DpmqjVgtWRw=;
 b=Uu8Y43q25PTCOJEfnHlEAr/04lenDI6HRuTslVhlAfsVRn/LHS247Q3JbVtXOJQJKM
 2eejI/xtG5vbjCmU+g85ejdXIPbyO6aWE0HxI9aa5l2Qb+rCL0A2PW6QB9xBcoGKtYN/
 i4B5NHIonWRoo9dGZ9CdKxclZTPWWeRXkWqHF8vAe8y6/XwCLPqJcPs2Ke990xdns4i2
 x/1bPIEWpg9bsrp3yy74b9F7jPgaywAfyOA31V3hF7pzD1j9FS5s9DcenrL2YG4PXNqb
 fPX2ZtVhKK8MErGgqkR3tThHiJp6XE2ANNmIxLmu/4BaOslSc0M1iJlE6I9HmfNBgaCO
 Qs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192260; x=1778797060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DHW/PVSACyLCeJ01Jj+8W8gGU3WJOwf4DpmqjVgtWRw=;
 b=kmU0X5Qx/VgFFaRbY2SBVzqJWvqarjUaza1aeb+I5Nl2FoL+SVximD4e+M2hX0MYfw
 ZtyCkeCz8D+j+5Sp/FM2tKyG+stDdylP6yTIUFZ4Dsp9wXZ+YiG1LVQlFX0JVcOQOMoK
 RC0FekEq0q93lgb5+nA7iY9nGPMoIB1GNu3GlcXDZy0idSGgXSSLGD0CJ+PuQt9Ko5ER
 KfKrtT2bfPA22gzHl0STUJ+3p/FaS4OzaluykaiCP23+39WtS/qjWZpEX+TnV+8ZyfZF
 8v3QAoJ/hlK3gCO+jU2SZtKzQW1EFr4PEj0xQ3RK4k7AL6vWiW8oVtczthFDW7GjEI4s
 HSJg==
X-Gm-Message-State: AOJu0Yw7IF7fajn/MlCsuxCg8fSqEKpZIZyrckaKLYtSGwCZ9BHNvnF0
 pQxMNeB5A0Qi9fOk9vNqpk8F3xdyk8K4NEhx30Va36nY6VvbFPEOFzp+douWiVoQ4GQmkE4bAMT
 IatQu
X-Gm-Gg: AeBDietiZmR8kI/e09P2m65uZ7DrCYMci3hw1FfAJfPuHpo+28Q6flgBNo/q94d9OZV
 4ZwBjGyltD7wfEMMqtW1F8UagNvmvjTfztMB0nsEgUW6Dsi23Vh8XS0if1auMEVU/pWGhz+ZuFq
 OpvM8o4CCC5c9ExTWLjs377JEM/q9L8NGeW6kv/pk16swMMMLmb12NeCwbcND8oT0LAFm1aECgm
 n8aYsyCWcouMcA4eEmpKL5qTQV95h99Gn4jyYUF0x2N8u4OXQCXWbKpDnPi7HEb8rFOVNPKvZEW
 SfFX26f/v5k6cJ+mDQDI4h9r2qaMlmJnyfn/c7rsAnhfdHyp9T7vHwyoi5MV/6Qvb9BZJYdHWcV
 Zdk8RVFCvqy71qqfPq2fUiEubR+Zl9ToFxtqvVH12I2N4WGFVVuyi5wMAudDU7ss6ynyVw0sT3E
 hZWTa7IgdJDbemX4zbsKrA289ZOakPddlX/fg6pBJntiUdPgzdGxfZ0jvm3i1/lmOmXSI=
X-Received: by 2002:a05:6820:1745:b0:694:6acf:a423 with SMTP id
 006d021491bc7-69998d22f94mr5417823eaf.44.1778192260176; 
 Thu, 07 May 2026 15:17:40 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/18] fpu: Add accessors for rebias_{underflow,overflow}
Date: Thu,  7 May 2026 17:17:16 -0500
Message-ID: <20260507221717.486023-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 10 ++++++++++
 target/ppc/cpu.c                |  4 ++--
 fpu/softfloat-parts.c.inc       |  4 ++--
 fpu/softfloat-specialize.c.inc  | 10 ++++++++++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 49e04ffee9..4791a7fc87 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -131,6 +131,16 @@ static inline void set_snan_rule(FloatSNaNRule val, float_status *status)
     status->float_snan_rule = val;
 }
 
+static inline void set_float_rebias_overflow(bool val, float_status *status)
+{
+    status->rebias_overflow = val;
+}
+
+static inline void set_float_rebias_underflow(bool val, float_status *status)
+{
+    status->rebias_underflow = val;
+}
+
 static inline FloatRoundMode get_float_rounding_mode(const float_status *status)
 {
     return status->float_rounding_mode;
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 4d8faaddee..41edb18643 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -248,8 +248,8 @@ void ppc_store_fpscr(CPUPPCState *env, target_ulong val)
         val |= FP_FEX;
     }
     env->fpscr = val;
-    env->fp_status.rebias_overflow  = (FP_OE & env->fpscr) ? true : false;
-    env->fp_status.rebias_underflow = (FP_UE & env->fpscr) ? true : false;
+    set_float_rebias_overflow(FP_OE & env->fpscr, &env->fp_status);
+    set_float_rebias_underflow(FP_UE & env->fpscr, &env->fp_status);
     if (tcg_enabled()) {
         fpscr_set_rounding_mode(env);
     }
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5598c8b44a..2198841f05 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -368,7 +368,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             switch (fmt->exp_max_kind) {
             case float_expmax_ieee:
                 flags |= float_flag_overflow;
-                if (s->rebias_overflow) {
+                if (get_float_rebias_overflow(s)) {
                     exp -= fmt->exp_re_bias;
                 } else if (overflow_norm) {
                     flags |= float_flag_inexact;
@@ -408,7 +408,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             }
         }
         fracN(shr)(p, frac_shift);
-    } else if (unlikely(s->rebias_underflow)) {
+    } else if (unlikely(get_float_rebias_underflow(s))) {
         flags |= float_flag_underflow;
         exp += fmt->exp_re_bias;
         if (p->frac_lo & round_mask) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index fe56cb7c7a..d9bea064e3 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -94,6 +94,16 @@ static inline uint8_t get_float_default_nan_pattern(const float_status *status)
     return status->default_nan_pattern;
 }
 
+static inline bool get_float_rebias_overflow(const float_status *status)
+{
+    return status->rebias_overflow;
+}
+
+static inline bool get_float_rebias_underflow(const float_status *status)
+{
+    return status->rebias_underflow;
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
-- 
2.43.0


