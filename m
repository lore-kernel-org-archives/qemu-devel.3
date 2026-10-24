Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68415606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OA9BSl10
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKRMG-0001ee-8t; Fri, 23 Oct 2026 22:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xKRMD-0001dy-Lm
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:19:41 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xKRMB-0002fp-GF
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:19:41 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8ab43af5e97so15279667b3.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792808378; x=1793413178; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IIMOL2hjU9bJMKjDYWGXJpshdP5KEsMeXp6HZd9a8vU=;
 b=OA9BSl10VjP+C/Uf1CDWWccZla2KTBGlWr6IBjh4npYdFXugmh6oOzebfMP9DsWTO2
 Qha49Wmw/n0uVHCuXpT2zbMzSMx2pHYF8C7p5z122fxEbLJyNBSekJT1+DUjXeXzl18+
 4xvvBw9es5Ub9OylwITO5eaGUoddkmlBmEL4KpqtREWPe3rGtui2wqIw922fX93k8W0a
 5OSJwswZzeFA/jERiaPKS/cDU/GVlXFqd3tW5p5Hu1JlvQL2T3P1teCxnnV7BdMdM3UI
 XcNlBk3+Nlh1BazYoAezUok6uz82ww4g4hXPtXsCMsyxZB68sbbMACzMwOLYT7d0/yi7
 jqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792808378; x=1793413178;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IIMOL2hjU9bJMKjDYWGXJpshdP5KEsMeXp6HZd9a8vU=;
 b=O2zgUDyZKLukFdI4j6fVJStlPDuMUuXF8o3OurpoYEzOTOXfV5AUM9emiJDvIWQlY0
 qIDGBPx49Y5NBccsGAymzLyGK8Vkxn6iKc/aOdzPm33KtQQOTXfzLTHIvf0NZagSFW4J
 bP/99h/eMtLRD6PtupZppVwFzeFpNF+fGSsfc5HXZf/mw+AC8T3pjTQX/oJks+TefSEZ
 sKAX90q/ulAK8piZpKeFlTsJvCYRJRFAWeoeaWifzgzw9dGFf3vduRUgk0GXHbqRMoQS
 NOIgzv5Q2a45+CIniUN4v3HtT+dyycN60FZx/sTMgwFMGd/Cllo7MiMlG/XN3sUa+dZl
 svbQ==
X-Gm-Message-State: AFq9FYK9DXkbaso+1QvV2NCj8Ncp+XB4noaN72ixh8QeZWAOeiArafTm
 0kB+bCdyFABnhI7twqELbcOFYvo0/IKzkLE2V/jhH3F7wJezpz13XXhA
X-Gm-Gg: AYBFou1ode2H9cPw6NohDeNPaZ3JS+dhLTFztjTuSrJ+BiR/SKfwpLdH9WW5KHK5yEi
 lIgEob1jE9iXeU83wzNUbfG6ZMOnmuFqvYxjFke6iip/QwQXj76ajJBSVQOEkCIqW2qbhr8OjKU
 VHM9Op17Dwub94w3ns89RetbW7kZbGlduqNcwlKpYieX+ISueIadpJfKdnI6X0yKPrDiwYD0ttG
 tb8cg/vGeUUJQB2rVZk2iAgO5IP4chofoOu56ruS4Vyzd/RFQMATY6EZ1m24/Fr5JISgunaC07a
 r/K55y0/gaaRYLc6FOF+pwzrD46uGwnfvgeW4YFV1ICr0YFGQ7JyWIQwE86DOLsOQzygY6fvH2o
 KWv0Gq+GQP6lG85U7L4rgEXss+aus4yOjQC/voFyNdbKczj7oxupGEM7V61QyNE4gR5ytxU8tQf
 nMtr2kRBCFKscpj/pZ7ZD1uPchpIbX7SE6K5pyhw00V36nZrHzu74bH97+XRTXeSkCIfH+8JMUK
 LJ1AUhCIRLmpCO+ZLC6o6I8zpQl4Aim56ksQ9De1W1y+uHB4X+7EKQm4y1Fo+Z0NUhwsskdwXvx
 1dkQ9MTIPz9AQBrAXARrA5wZ2EhTkcHKad/f
X-Received: by 2002:a05:690c:9d:b0:8ab:390f:8d36 with SMTP id
 00721157ae682-8b1673b6d19mr6442857b3.35.1792808378369; 
 Fri, 23 Oct 2026 19:19:38 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b166e53e34sm4855887b3.29.2026.10.23.19.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 19:19:36 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 23 Oct 2026 22:19:29 -0400
Subject: [PATCH v3 3/3] target/alpha: Determine tininess from the delivered
 result
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-alpha-fpcr-status-s-v3-3-7d11facb8a50@gmail.com>
References: <20261023-alpha-fpcr-status-s-v3-0-7d11facb8a50@gmail.com>
In-Reply-To: <20261023-alpha-fpcr-status-s-v3-0-7d11facb8a50@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9964; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=/C9N0iOgAC/6X2QEQjf7xOfGJBUfr2HAeBhLf6ZpC4E=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLuiK5jtJz+/EFklZ9V96Qbi1TUlr9qyhHjn+R1Znf0t
 4P/5Nb/7vjIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhrLNYwMvRb3Wdz4w
 mxyG3yZJd9+t/KwO+7h97Mi4arYnSkPmZIOzAyHCj09tTayn5lCWcS45Mbn9qXSgjHbrnnWn+27
 kZzqcJCPgA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Alpha raises underflow only if the result it delivers is tiny.
softfloat implements IEEE 754 tininess after rounding, which rounds as
if the exponent range were unbounded. The two disagree about a result
that rounds up to the smallest normal:

  0x4p-1024 / 0x1.0000000000001p+0 in FE_UPWARD = 0x4p-1024

The binade below DBL_MIN has a finer spacing than the denormals, so
with an unbounded exponent the quotient rounds to a value below
DBL_MIN and softfloat raises underflow. Alpha does not. glibc marks
math/test-float32x-float64-div as XFAIL on Alpha because of this
(glibc commit a32db99a38), and under qemu that test unexpectedly
passes.

Every result that is tiny by Alpha's rule is also tiny by the IEEE
one, so there is no need for another tininess mode in softfloat. Pass
soft_to_fpcr_exc whether the delivered result is normal, and drop
underflow when it is. Only the S and T format add, sub, mul, div and
cvtts helpers can underflow; the rest pass false.

An insn with a denormal operand is different. Unless DNZ is set it
traps for software completion and the kernel computes the result, and
the kernel's emulation raises underflow in the same situation:

  0x3.ffffffffffffcp-1024 / 0x1.fffffffffffffp-1 in FE_UPWARD
    = 0x4p-1024, FPCR_UNF set

That result is tiny whether tininess is detected before rounding, as
math-emu did until Linux commit b74843b38da8 ("alpha: determine tininess
after rounding in the FP emulation"), or after rounding, as math-emu and
softfloat both do now. linux-user computes these results in the helper
instead of trapping, so keep softfloat's underflow when
float_flag_input_denormal_used is set. That check is for
CONFIG_USER_ONLY only: in system mode gen_ieee_input raises the trap
before the helper runs, and with DNZ set the operand is flushed rather
than used.

For a denormal operand, keeping softfloat's underflow also matches a
kernel with b74843b38da8 when the result is not tiny once rounded: on
the ES47, 0x3.ffffffffffffcp-1024 * 0x1.0000000000001p+0 = 0x4p-1024
raises inexact but not underflow, as it does under qemu.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 target/alpha/fpu_helper.c | 60 +++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index ce4f635cd4..c5635171c0 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -38,7 +38,11 @@ void helper_setflushzero(CPUAlphaState *env, uint32_t val)
 #define CONVERT_BIT(X, SRC, DST) \
     (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
 
-static uint32_t soft_to_fpcr_exc(CPUAlphaState *env)
+/*
+ * NORMAL is whether the delivered result is normal. Operations that
+ * cannot underflow pass false.
+ */
+static uint32_t soft_to_fpcr_exc(CPUAlphaState *env, bool normal)
 {
     FloatExceptionFlags exc = get_float_exception_flags(&FP_STATUS);
     uint32_t ret = 0;
@@ -48,8 +52,24 @@ static uint32_t soft_to_fpcr_exc(CPUAlphaState *env)
         ret |= CONVERT_BIT(exc, float_flag_invalid, FPCR_INV);
         ret |= CONVERT_BIT(exc, float_flag_divbyzero, FPCR_DZE);
         ret |= CONVERT_BIT(exc, float_flag_overflow, FPCR_OVF);
-        ret |= CONVERT_BIT(exc, float_flag_underflow, FPCR_UNF);
         ret |= CONVERT_BIT(exc, float_flag_inexact, FPCR_INE);
+
+        /*
+         * Alpha raises no underflow when the delivered result is normal.
+         * softfloat does when that result was rounded up to the smallest
+         * normal, so drop it. In user mode, a denormal operand means the
+         * result is the one the kernel's software completion would compute,
+         * and that does raise underflow.
+         */
+        if (exc & float_flag_underflow) {
+            bool tiny = !normal;
+#ifdef CONFIG_USER_ONLY
+            tiny |= exc & float_flag_input_denormal_used;
+#endif
+            if (tiny) {
+                ret |= FPCR_UNF;
+            }
+        }
     }
 
     return ret;
@@ -237,7 +257,7 @@ uint64_t helper_adds(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_add(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -249,7 +269,7 @@ uint64_t helper_subs(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_sub(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -261,7 +281,7 @@ uint64_t helper_muls(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_mul(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -273,7 +293,7 @@ uint64_t helper_alpha_divs(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_div(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -284,7 +304,7 @@ uint64_t helper_sqrts(CPUAlphaState *env, uint64_t a)
 
     fa = s_to_float32(a);
     fr = float32_sqrt(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return float32_to_s(fr);
 }
@@ -314,7 +334,7 @@ uint64_t helper_addt(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_add(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -326,7 +346,7 @@ uint64_t helper_subt(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_sub(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -338,7 +358,7 @@ uint64_t helper_mult(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_mul(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -350,7 +370,7 @@ uint64_t helper_divt(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_div(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -361,7 +381,7 @@ uint64_t helper_sqrtt(CPUAlphaState *env, uint64_t a)
 
     fa = t_to_float64(a);
     fr = float64_sqrt(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return float64_to_t(fr);
 }
@@ -378,7 +398,7 @@ uint64_t helper_cmptun(CPUAlphaState *env, uint64_t a, uint64_t b)
     if (float64_unordered_quiet(fa, fb, &FP_STATUS)) {
         ret = 0x4000000000000000ULL;
     }
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return ret;
 }
@@ -394,7 +414,7 @@ uint64_t helper_cmpteq(CPUAlphaState *env, uint64_t a, uint64_t b)
     if (float64_eq_quiet(fa, fb, &FP_STATUS)) {
         ret = 0x4000000000000000ULL;
     }
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return ret;
 }
@@ -410,7 +430,7 @@ uint64_t helper_cmptle(CPUAlphaState *env, uint64_t a, uint64_t b)
     if (float64_le(fa, fb, &FP_STATUS)) {
         ret = 0x4000000000000000ULL;
     }
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return ret;
 }
@@ -426,7 +446,7 @@ uint64_t helper_cmptlt(CPUAlphaState *env, uint64_t a, uint64_t b)
     if (float64_lt(fa, fb, &FP_STATUS)) {
         ret = 0x4000000000000000ULL;
     }
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return ret;
 }
@@ -439,7 +459,7 @@ uint64_t helper_cvtts(CPUAlphaState *env, uint64_t a)
 
     fa = t_to_float64(a);
     fr = float64_to_float32(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -451,7 +471,7 @@ uint64_t helper_cvtst(CPUAlphaState *env, uint64_t a)
 
     fa = s_to_float32(a);
     fr = float32_to_float64(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return float64_to_t(fr);
 }
@@ -459,7 +479,7 @@ uint64_t helper_cvtst(CPUAlphaState *env, uint64_t a)
 uint64_t helper_cvtqs(CPUAlphaState *env, uint64_t a)
 {
     float32 fr = int64_to_float32(a, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return float32_to_s(fr);
 }
@@ -514,7 +534,7 @@ uint64_t helper_cvttq_c(CPUAlphaState *env, uint64_t a)
 uint64_t helper_cvtqt(CPUAlphaState *env, uint64_t a)
 {
     float64 fr = int64_to_float64(a, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
     return float64_to_t(fr);
 }
 

-- 
2.55.0


