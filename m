Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACE0CCA46C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 00:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHskp-0001VC-4X; Fri, 16 Oct 2026 20:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xHskm-0001U5-TX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 20:58:28 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xHskk-000118-Ur
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 20:58:28 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8a83d2706fdso3993357b3.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792198705; x=1792803505; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IXNEHBFnJVqtUDewbcVFdo2fMaPeEsitr7a1CmyxrXs=;
 b=QchBi8bLGBGObcdb/a+sghRULT5vHLHW9RhQEvXK+6SWgl5euaCnxvA3Q24D/F9lOC
 kfJyUS+y1nK4HnXpavxdVnWkKrZH3fe1pUeMnQ0nDKQes+OE2JWe7AK5WA+/ClgNzgJR
 ActcnUF2p/Xq4XtALBrlWrgcLT8Oh81DPw0q/eMMt2615Mi2FO83lUbQhMESqgrcBkoZ
 1h0fmCmpcu8UHTMGTbYO9NwpjYJiKQ98o0jbg5SL6dnxBOWwMewHhmbJf3V3e2qBhjFe
 oA1mLpNiCdmR+XkL9NMgsdgOnYX4DbqAoVEK7fT7rSAy3KyH0gh67QPncN9kJMy296mN
 NPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792198705; x=1792803505;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IXNEHBFnJVqtUDewbcVFdo2fMaPeEsitr7a1CmyxrXs=;
 b=HKatEeEz/RIcLJgNiQeCxHk1IGtD9Y60Y6DDx0oOOxv+EyKVVf4WlAMTUmjbaOR7HF
 1P0o9fhbsN0oLh8o2/4QFasv5IWMQirR33etKET95EYwFICN9JoAl9nFwOZjcfDkL26f
 wypmnsalyy7ggCJsq5NC+T0ttoz3V5AVqXDbUSDQIipbo6kd8hIF1DHJshWve077BCus
 ETLez8H3/PlJRxSUc9Rn0Zlis6v3Z3rFsRuRlgancq34+mciz7kNyrlFwjkYS5HCL3r2
 +kv4+tu7IexM8dbYTpDtfnVfK3uSvzPGthBvR+honuTvW6Bu2cJSagFhuBj7F3xO9KY5
 RCmw==
X-Gm-Message-State: AFq9FYKxMAzF8OZ5+ga9EIdKCDxabtz/Q8QL+3Q8KvlISNrKk2sAFvxi
 WCLA3FqUDAOyDpN8NC3xwsd/3OM4fvByK1a1Hy8sUupJdR008y+N8EJlTX0Ejw==
X-Gm-Gg: AYBFou0zfjjpd/ik2bfZ6xFfa7tRSu/VBwFiTgOWUbqNzc9+rsW2SOmgkqeGOT84jeS
 4dy66vHc7CKr4na3O5UjD1Sk1TP/N7WumB84qdLWd27z1QB28SFnAS/uB2m/UcfJ7kRyx/T8krT
 mLe8XTzAk5zKXT/BmNLaCJcXiL968N1vf1wQqJ+wWdBK2VIe9aNasz6Diihg+XoSr+NdYhcYYQS
 xnYNk1Onf9PFlRdfCjoCl+l9RMjfMMrYopDcdQCRa2KAkGrz2vNwvREhCThYTK4kFZZdUmF6muY
 JGQGmHr9iotnSCezifR+wBMWElMkAZWcyvGw+baturJjR4ldRZMnwjWKLUaXKbC7xXcJRbQ/RKv
 l0OR5M7qt4nbszsxSTmXANpcm5hq/syykINPdApQMviLxHdPqI6wQcyNbHLulnktia6Hm9AFPwN
 oRiXd3xePu+C3aH9056pSXH7g1LZY+KIzT53Ht/VcwEs/rOAcvaAmyfYMWDW4snlOyRsePxJkXo
 InmHzSAOjxGQxKoyaHnKojCVefEghc/NVPIZ8PpjJuQw2+oYhmgyv3VZoa8E+uVTXmy4bJE5ADu
 x1hpe1aglT+mb+HKs7YtrrzLZrHU
X-Received: by 2002:a05:690c:f91:b0:8b0:e680:615f with SMTP id
 00721157ae682-8b0f2072ae6mr6081027b3.9.1792198705548; 
 Fri, 16 Oct 2026 17:58:25 -0700 (PDT)
Received: from localhost (108-93-236-139.lightspeed.chtnsc.sbcglobal.net.
 [108.93.236.139]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b0e5889c2esm15749967b3.15.2026.10.16.17.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:58:23 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 16 Oct 2026 20:58:03 -0400
Subject: [PATCH v2 2/2] target/alpha: Determine tininess from the delivered
 result
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-alpha-fpcr-status-s-v2-2-4719bec02b3b@gmail.com>
References: <20261016-alpha-fpcr-status-s-v2-0-4719bec02b3b@gmail.com>
In-Reply-To: <20261016-alpha-fpcr-status-s-v2-0-4719bec02b3b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9522; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=pRQKLtSMD7Vpi0qr4uENsRCEmWjCutueoP23p5h5cqc=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIunZAKbV+Q/PJBbzHnueji8jMu7A53K0u+nt0lUi5yt
 kbqycn3HR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHNNQzkjw57PQezcHa
 8mLg8LeeH3SOU8m6mLWvu3bfwJb/2erPCv2cLIsFvGouX0JMFvP/ZrOn8W5rr96+RFzUWtQmeux
 aQl6j834AQA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1136.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Alpha raises underflow only if the result it delivers is tiny.
softfloat implements IEEE 754 tininess after rounding, which rounds as
if the exponent range were unbounded.  The two disagree about a result
that rounds up to the smallest normal:

  0x4p-1024 / 0x1.0000000000001p+0 in FE_UPWARD = 0x4p-1024

The binade below DBL_MIN has a finer spacing than the denormals, so
with an unbounded exponent the quotient rounds to a value below
DBL_MIN and softfloat raises underflow.  Alpha does not.  glibc marks
math/test-float32x-float64-div as XFAIL on Alpha because of this
(glibc commit a32db99a38), and under qemu that test unexpectedly
passes.

Every result that is tiny by Alpha's rule is also tiny by the IEEE
one, so there is no need for another tininess mode in softfloat.  Pass
soft_to_fpcr_exc whether the delivered result is normal, and drop
underflow when it is.  Only the S and T format add, sub, mul, div and
cvtts helpers can underflow; the rest pass false.

An insn with a denormal operand is different.  Unless DNZ is set it
traps for software completion and the kernel computes the result, and
the kernel's emulation raises underflow in the same situation:

  0x3.ffffffffffffcp-1024 / 0x1.fffffffffffffp-1 in FE_UPWARD
    = 0x4p-1024, FPCR_UNF set

That result is tiny whether tininess is detected before rounding, as
math-emu does, or after rounding, as softfloat does.  linux-user
computes these results in the helper instead of trapping, so keep
softfloat's underflow when float_flag_input_denormal_used is set.  That
check is for CONFIG_USER_ONLY only: in system mode gen_ieee_input raises
the trap before the helper runs, and with DNZ set the operand is flushed
rather than used.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 target/alpha/fpu_helper.c | 60 +++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 643ce641e8..e91e907c21 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -38,7 +38,11 @@ void helper_setflushzero(CPUAlphaState *env, uint32_t val)
 #define CONVERT_BIT(X, SRC, DST) \
     (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
 
-static uint32_t soft_to_fpcr_exc(CPUAlphaState *env)
+/*
+ * NORMAL is whether the delivered result is normal.  Operations that
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
+         * normal, so drop it.  In user mode, a denormal operand means the
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
@@ -227,7 +247,7 @@ uint64_t helper_adds(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_add(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -239,7 +259,7 @@ uint64_t helper_subs(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_sub(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -251,7 +271,7 @@ uint64_t helper_muls(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_mul(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -263,7 +283,7 @@ uint64_t helper_alpha_divs(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_div(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -274,7 +294,7 @@ uint64_t helper_sqrts(CPUAlphaState *env, uint64_t a)
 
     fa = s_to_float32(a);
     fr = float32_sqrt(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return float32_to_s(fr);
 }
@@ -304,7 +324,7 @@ uint64_t helper_addt(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_add(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -316,7 +336,7 @@ uint64_t helper_subt(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_sub(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -328,7 +348,7 @@ uint64_t helper_mult(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_mul(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -340,7 +360,7 @@ uint64_t helper_divt(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_div(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -351,7 +371,7 @@ uint64_t helper_sqrtt(CPUAlphaState *env, uint64_t a)
 
     fa = t_to_float64(a);
     fr = float64_sqrt(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return float64_to_t(fr);
 }
@@ -368,7 +388,7 @@ uint64_t helper_cmptun(CPUAlphaState *env, uint64_t a, uint64_t b)
     if (float64_unordered_quiet(fa, fb, &FP_STATUS)) {
         ret = 0x4000000000000000ULL;
     }
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return ret;
 }
@@ -384,7 +404,7 @@ uint64_t helper_cmpteq(CPUAlphaState *env, uint64_t a, uint64_t b)
     if (float64_eq_quiet(fa, fb, &FP_STATUS)) {
         ret = 0x4000000000000000ULL;
     }
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return ret;
 }
@@ -400,7 +420,7 @@ uint64_t helper_cmptle(CPUAlphaState *env, uint64_t a, uint64_t b)
     if (float64_le(fa, fb, &FP_STATUS)) {
         ret = 0x4000000000000000ULL;
     }
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return ret;
 }
@@ -416,7 +436,7 @@ uint64_t helper_cmptlt(CPUAlphaState *env, uint64_t a, uint64_t b)
     if (float64_lt(fa, fb, &FP_STATUS)) {
         ret = 0x4000000000000000ULL;
     }
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return ret;
 }
@@ -429,7 +449,7 @@ uint64_t helper_cvtts(CPUAlphaState *env, uint64_t a)
 
     fa = t_to_float64(a);
     fr = float64_to_float32(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -441,7 +461,7 @@ uint64_t helper_cvtst(CPUAlphaState *env, uint64_t a)
 
     fa = s_to_float32(a);
     fr = float32_to_float64(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return float64_to_t(fr);
 }
@@ -449,7 +469,7 @@ uint64_t helper_cvtst(CPUAlphaState *env, uint64_t a)
 uint64_t helper_cvtqs(CPUAlphaState *env, uint64_t a)
 {
     float32 fr = int64_to_float32(a, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return float32_to_s(fr);
 }
@@ -504,7 +524,7 @@ uint64_t helper_cvttq_c(CPUAlphaState *env, uint64_t a)
 uint64_t helper_cvtqt(CPUAlphaState *env, uint64_t a)
 {
     float64 fr = int64_to_float64(a, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
     return float64_to_t(fr);
 }
 

-- 
2.55.0


