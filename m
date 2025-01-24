Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1826C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYj-0004Zl-3q; Fri, 24 Jan 2025 11:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYN-0003tZ-7N
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:08 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYI-0005Tk-Vu
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:06 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso16642405e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736141; x=1738340941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yzojriWazlUo5BpsMATktHytz8JColu0+OBr+77Yv4A=;
 b=Yz+smkr1XJG3Dmvnr3EUgdTXG3LCiOqPOV9idS/ZiytoEF+0TuOGePWPHROee1Bkjw
 bJiczfAXXMKcv7VZMGcEP5he81+tZcOIjuKF+gnHvoxxKXej7uCn+BAyBhAkm2hI4H43
 ho55PvZf22LaAoWW327uUW5GGPVvrHN9/4W42T2K+BW89zDhrXdD0Uqh6EipMMcCOO8a
 mSg4md6HPlizp/9LKOVYLRMmkeGCYEia6BAgL7gbuM7e8Po7og0q9RZDWHdQJ6nL63cQ
 FaD+RgE6xU/9D93k0MHb3sgemfNOb7h9yatH6Mah6VIGplsTHNXhwX/8mq/8PlnshkEc
 QSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736141; x=1738340941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzojriWazlUo5BpsMATktHytz8JColu0+OBr+77Yv4A=;
 b=Hz+zk6PGoSWJJbO2zfPkfqGH8NWY8n9vOFo/k/dltbht/60z94Th/dvZBot/DFOqjG
 lVLjd0xjOq9OL7P2DN3/QU1Hp+8jmrFSRwtLOcyucaR+TWqSjiXzmkcV6bHrh0DxmmHO
 85WpUFsbkUdYHAbGc3w9XTbJteB+uY3pZTzwRTKs0UDx//fkVRkwHfN2ZS54U0nK8sPq
 5ZWeVLceqO8r1bzRryzUngtMURl0Ml13KykQMDpR+Rk9fMUfwTBaM1vCxVfPRUh5xXNQ
 7/Os6eErEoGCgJRkvodN00X/PaXaRXBoFPqbkz7D2HDDribHpuxo9qn+qx2CCDiHb0q4
 tpCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYDtDK/muof2ECSAV8I15NlJcZy5hW2kUKzvqaY10Q5lofpfaioIhzL4HPNJr8uTtYQszq2v/599dN@nongnu.org
X-Gm-Message-State: AOJu0YxVtCr8y8fbMmG7TjEvfY2OUCKMtfDHCl1m5S+ljsGN1InvMilt
 Fut3P/I7TDl53ts2v9Q4Dh0OHaEK1i31R78fKfbyw9vClq8N8G0oSwO6SWgFnmlh2InzNOu4LBg
 u
X-Gm-Gg: ASbGncs3Eh4F8/PRrk2UMWgV20NlKvTR1oWtcsmItif/GYnIxKOdOqQeGafGp9GVxzJ
 OXM0+56Vik2kyoyDNsOmtf/sJ0AhKsc4pq7gY80f/3aMJx4gcxd8Xy5tJ3qdogY+Iry0st+l4Yo
 Hq+BW57YlZPm1KCjZJO1mNgxHOQ0PcFftGWENX2r73SNMaScW24LNqG/6le2a7LWb+LDrQZTo54
 fBR1e5R8ScVG6MHERLbPp1lVwSt3jEuwhKFP3ofP8YCCsL8d9lP3SyKNcabUDOM8HusP/2j0QNa
 u7FjeQqXsJk=
X-Google-Smtp-Source: AGHT+IElvNqrTvpDRT853zUge8gAVILX8BugJqLricJpFmDsBWhTHGbkegWZKlc7du5UQq+73Gvhlg==
X-Received: by 2002:a05:600c:5112:b0:434:a5bc:70fc with SMTP id
 5b1f17b1804b1-438913cfa0emr282087645e9.8.1737736141481; 
 Fri, 24 Jan 2025 08:29:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 19/76] fpu: Rename float_flag_input_denormal to
 float_flag_input_denormal_flushed
Date: Fri, 24 Jan 2025 16:27:39 +0000
Message-Id: <20250124162836.2332150-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Our float_flag_input_denormal exception flag is set when the fpu code
flushes an input denormal to zero.  This is what many guest
architectures (eg classic Arm behaviour) require, but it is not the
only donarmal-related reason we might want to set an exception flag.
The x86 behaviour (which we do not currently model correctly) wants
to see an exception flag when a denormal input is *not* flushed to
zero and is actually used in an arithmetic operation. Arm's FEAT_AFP
also wants these semantics.

Rename float_flag_input_denormal to float_flag_input_denormal_flushed
to make it clearer when it is set and to allow us to add a new
float_flag_input_denormal_used next to it for the x86/FEAT_AFP
semantics.

Commit created with
 for f in `git grep -l float_flag_input_denormal`; do sed -i -e 's/float_flag_input_denormal/float_flag_input_denormal_flushed/' $f; done

and manual editing of softfloat-types.h and softfloat.c to clean
up the indentation afterwards and to fix a comment which wasn't
using the full name of the flag.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat-types.h |  5 +++--
 fpu/softfloat.c               |  4 ++--
 target/arm/tcg/sve_helper.c   |  6 +++---
 target/arm/vfp_helper.c       | 10 +++++-----
 target/i386/tcg/fpu_helper.c  |  6 +++---
 target/mips/tcg/msa_helper.c  |  2 +-
 target/rx/op_helper.c         |  2 +-
 fpu/softfloat-parts.c.inc     |  2 +-
 8 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index d8f831c331d..77bc172a074 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -154,7 +154,8 @@ enum {
     float_flag_overflow        = 0x0004,
     float_flag_underflow       = 0x0008,
     float_flag_inexact         = 0x0010,
-    float_flag_input_denormal  = 0x0020,
+    /* We flushed an input denormal to 0 (because of flush_inputs_to_zero) */
+    float_flag_input_denormal_flushed = 0x0020,
     float_flag_output_denormal = 0x0040,
     float_flag_invalid_isi     = 0x0080,  /* inf - inf */
     float_flag_invalid_imz     = 0x0100,  /* inf * 0 */
@@ -312,7 +313,7 @@ typedef struct float_status {
     bool tininess_before_rounding;
     /* should denormalised results go to zero and set the inexact flag? */
     bool flush_to_zero;
-    /* should denormalised inputs go to zero and set the input_denormal flag? */
+    /* should denormalised inputs go to zero and set input_denormal_flushed? */
     bool flush_inputs_to_zero;
     bool default_nan_mode;
     /*
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8d75d668172..648050be6fb 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -132,7 +132,7 @@ this code that are retained.
         if (unlikely(soft_t ## _is_denormal(*a))) {                     \
             *a = soft_t ## _set_sign(soft_t ## _zero,                   \
                                      soft_t ## _is_neg(*a));            \
-            float_raise(float_flag_input_denormal, s);                  \
+            float_raise(float_flag_input_denormal_flushed, s);          \
         }                                                               \
     }
 
@@ -4848,7 +4848,7 @@ float128 float128_silence_nan(float128 a, float_status *status)
 static bool parts_squash_denormal(FloatParts64 p, float_status *status)
 {
     if (p.exp == 0 && p.frac != 0) {
-        float_raise(float_flag_input_denormal, status);
+        float_raise(float_flag_input_denormal_flushed, status);
         return true;
     }
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index d0865dece35..9837c5bc7ac 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4658,7 +4658,7 @@ static int16_t do_float16_logb_as_int(float16 a, float_status *s)
                 return -15 - clz32(frac);
             }
             /* flush to zero */
-            float_raise(float_flag_input_denormal, s);
+            float_raise(float_flag_input_denormal_flushed, s);
         }
     } else if (unlikely(exp == 0x1f)) {
         if (frac == 0) {
@@ -4686,7 +4686,7 @@ static int32_t do_float32_logb_as_int(float32 a, float_status *s)
                 return -127 - clz32(frac);
             }
             /* flush to zero */
-            float_raise(float_flag_input_denormal, s);
+            float_raise(float_flag_input_denormal_flushed, s);
         }
     } else if (unlikely(exp == 0xff)) {
         if (frac == 0) {
@@ -4714,7 +4714,7 @@ static int64_t do_float64_logb_as_int(float64 a, float_status *s)
                 return -1023 - clz64(frac);
             }
             /* flush to zero */
-            float_raise(float_flag_input_denormal, s);
+            float_raise(float_flag_input_denormal_flushed, s);
         }
     } else if (unlikely(exp == 0x7ff)) {
         if (frac == 0) {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 3ed69d73698..444702a4600 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -53,7 +53,7 @@ static inline uint32_t vfp_exceptbits_from_host(int host_bits)
     if (host_bits & float_flag_inexact) {
         target_bits |= FPSR_IXC;
     }
-    if (host_bits & float_flag_input_denormal) {
+    if (host_bits & float_flag_input_denormal_flushed) {
         target_bits |= FPSR_IDC;
     }
     return target_bits;
@@ -68,11 +68,11 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     i |= get_float_exception_flags(&env->vfp.standard_fp_status);
     /* FZ16 does not generate an input denormal exception.  */
     i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
-          & ~float_flag_input_denormal);
+          & ~float_flag_input_denormal_flushed);
     i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
-          & ~float_flag_input_denormal);
+          & ~float_flag_input_denormal_flushed);
     i |= (get_float_exception_flags(&env->vfp.standard_fp_status_f16)
-          & ~float_flag_input_denormal);
+          & ~float_flag_input_denormal_flushed);
     return vfp_exceptbits_from_host(i);
 }
 
@@ -1133,7 +1133,7 @@ uint64_t HELPER(fjcvtzs)(float64 value, float_status *status)
 
     /* Normal inexact, denormal with flush-to-zero, or overflow or NaN */
     inexact = e_new & (float_flag_inexact |
-                       float_flag_input_denormal |
+                       float_flag_input_denormal_flushed |
                        float_flag_invalid);
 
     /* While not inexact for IEEE FP, -0.0 is inexact for JavaScript. */
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index e0a072b4ebc..7151e809643 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -207,7 +207,7 @@ static void merge_exception_flags(CPUX86State *env, uint8_t old_flags)
                        (new_flags & float_flag_overflow ? FPUS_OE : 0) |
                        (new_flags & float_flag_underflow ? FPUS_UE : 0) |
                        (new_flags & float_flag_inexact ? FPUS_PE : 0) |
-                       (new_flags & float_flag_input_denormal ? FPUS_DE : 0)));
+                       (new_flags & float_flag_input_denormal_flushed ? FPUS_DE : 0)));
 }
 
 static inline floatx80 helper_fdiv(CPUX86State *env, floatx80 a, floatx80 b)
@@ -1832,7 +1832,7 @@ void helper_fxtract(CPUX86State *env)
             int shift = clz64(temp.l.lower);
             temp.l.lower <<= shift;
             expdif = 1 - EXPBIAS - shift;
-            float_raise(float_flag_input_denormal, &env->fp_status);
+            float_raise(float_flag_input_denormal_flushed, &env->fp_status);
         } else {
             expdif = EXPD(temp) - EXPBIAS;
         }
@@ -3261,7 +3261,7 @@ void update_mxcsr_from_sse_status(CPUX86State *env)
     uint8_t flags = get_float_exception_flags(&env->sse_status);
     /*
      * The MXCSR denormal flag has opposite semantics to
-     * float_flag_input_denormal (the softfloat code sets that flag
+     * float_flag_input_denormal_flushed (the softfloat code sets that flag
      * only when flushing input denormals to zero, but SSE sets it
      * only when not flushing them to zero), so is not converted
      * here.
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 1d40383ca4f..aeab6a1d8b3 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -6231,7 +6231,7 @@ static inline int update_msacsr(CPUMIPSState *env, int action, int denormal)
     enable = GET_FP_ENABLE(env->active_tc.msacsr) | FP_UNIMPLEMENTED;
 
     /* Set Inexact (I) when flushing inputs to zero */
-    if ((ieee_exception_flags & float_flag_input_denormal) &&
+    if ((ieee_exception_flags & float_flag_input_denormal_flushed) &&
             (env->active_tc.msacsr & MSACSR_FS_MASK) != 0) {
         if (action & CLEAR_IS_INEXACT) {
             mips_exception_flags &= ~FP_INEXACT;
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 691a12b2be1..59dd1ae6128 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -99,7 +99,7 @@ static void update_fpsw(CPURXState *env, float32 ret, uintptr_t retaddr)
         if (xcpt & float_flag_inexact) {
             SET_FPSW(X);
         }
-        if ((xcpt & (float_flag_input_denormal
+        if ((xcpt & (float_flag_input_denormal_flushed
                      | float_flag_output_denormal))
             && !FIELD_EX32(env->fpsw, FPSW, DN)) {
             env->fpsw = FIELD_DP32(env->fpsw, FPSW, CE, 1);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 4bb341b2f94..ec2467e9fff 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -199,7 +199,7 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
         if (likely(frac_eqz(p))) {
             p->cls = float_class_zero;
         } else if (status->flush_inputs_to_zero) {
-            float_raise(float_flag_input_denormal, status);
+            float_raise(float_flag_input_denormal_flushed, status);
             p->cls = float_class_zero;
             frac_clear(p);
         } else {
-- 
2.34.1


