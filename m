Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214C0CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72E-0000pm-9w; Thu, 07 May 2026 18:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72D-0000pU-JE
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:33 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL729-0003Ci-CK
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:33 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-696ad0c2c2dso758082eaf.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192248; x=1778797048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KCo+wD8N44ZCWiLcNlX2vFV691X/Knl4fAZ2l88NYrw=;
 b=A0mOch3+1/VpDEaYCnVZxn+2jFOkOTma/JNS/OdVA6GjdXBBj58uwTIN5uMRqTB6it
 OZuuCLbJpQPpXnwNmX/Wrgii3dRWZlxW9fJIsQWPaIdvzs8IvveHfPBgRxc/yUT/8knx
 K56gWjSDWZJmwyHiA1XZ9IHqZnf64QtEd4lMyfuW+a1iNdXaodO1BNvS3vKDP/e3SOoE
 S49XWviZWQkW9wzxGwwR89q1737/fXzroiuQUgYD+He3VKiPKM3i4he95tWReszpN7Cu
 WLjPp7CeRLbPJ+gxC8+u5JxBm9M0+Rcx4uP/rbUeJouP+nB3jGMD/W4BMQ5ViD/zDTWm
 nmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192248; x=1778797048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KCo+wD8N44ZCWiLcNlX2vFV691X/Knl4fAZ2l88NYrw=;
 b=VWTFdnTYUl9KBr2Ky/4prMWCe+Y2bZ18kEagg6wXelZ/P4YGiNdD6fVw+IHsFf3i2u
 brwjS2paGMY/GyyFWqr0alIcMsryQOY8N0N4gttyhvkwOSXDouM8zoDhxzyYDZzp/dhT
 wzUWnZ2obOHmEXsF5ByKH8pGF/doU8psv2TzGPPfVar0SAGYp+5YtjDUe0EKje3GgXKn
 rEF7fRLibiOUeJDj+eyWbpIAa9CkThRDbttQdqnVSylnG5UFOBIVBzB6Tn3m2WiwfWcq
 NRTqU4uyDzQ28YQ90gdtk4xro3+vVuv2dritWCI8E42Qxd8t4dKjVYvLgy0+vowSmGd3
 1rEg==
X-Gm-Message-State: AOJu0YxN2gaWy9hWh6FMxX9H6tiorU9Tgea05lzfmoTn7lObdzO1gybS
 GOZ6tu9v8f+QaFwEW+pzhjQqVEpJgrarlDrk4X34i9ILOdexnocWI1wnfFvyAvV+JTTwxqrgBQg
 RxfZ8
X-Gm-Gg: AeBDievHd+5biRgnnAVoz027HzTnA9jERjuB9DD5uFjHiAtJMpYxfAQVY6trqHlyGbu
 VHAuGAJq63h/vP17v9KW410ptc4x4xT4FcG7TAy7wa4Qn+qLLhklYeZN4YRIsZqATlmyJPTV1bJ
 t6TspeBvZhJNMpHWak/QB/Y94v143ChT5tCFvEdqGcS6UAoMeGA46I1qZxuXsha8YsVTdxWuJYT
 ID4xe63uElXEbTrJ1+RhOikFR1pxSNQj7gJ3IDFwtOoPvPKBgXmB1ae9EjhXnHkMSMOQGfdalRk
 U+2b5MZil/2rQVxJAS3KPf5/gmWe/bBS0jhYeLv+6CNW2t6SfADlsDYloSkh7vCt0EwCAILevhk
 0jHkyD3lah+ZRYL3KlUGg2qw020f3r/NZm4UGX/z5AU7PHoclvXgy8tFftTiVGvcq/ytPz8QGuE
 KEPdIOqb3HcZjsNWbvuRuyhxjIpMFBfA0ym5HvDlg2TZ6XoQ==
X-Received: by 2002:a05:6820:1c91:b0:67e:ae5:732e with SMTP id
 006d021491bc7-69998cfe0e9mr5068968eaf.36.1778192247771; 
 Thu, 07 May 2026 15:17:27 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/18] fpu: Use of {get,
 set}_floatx80_rounding_precision everywhere
Date: Thu,  7 May 2026 17:17:05 -0500
Message-ID: <20260507221717.486023-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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
 fpu/softfloat.c              |  10 +-
 target/i386/tcg/fpu_helper.c |  37 ++++---
 target/m68k/softfloat.c      | 208 ++++++++++++++++++-----------------
 tests/fp/fp-test.c           |   2 +-
 4 files changed, 130 insertions(+), 127 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 231b308b50..11ab26c7f6 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1503,7 +1503,7 @@ float128 float128_round_pack_canonical(FloatParts128 *p, float_status *s)
 bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f, float_status *s)
 {
     /* Ensure rounding precision is set before beginning. */
-    switch (s->floatx80_rounding_precision) {
+    switch (get_floatx80_rounding_precision(s)) {
     case floatx80_precision_x:
     case floatx80_precision_d:
     case floatx80_precision_s:
@@ -1538,14 +1538,14 @@ bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f, float_status *s)
 
 floatx80 floatx80_round_pack_canonical(FloatParts128 *p, float_status *s)
 {
-    const FloatFmt *fmt = &floatx80_params[s->floatx80_rounding_precision];
+    const FloatFmt *fmt = &floatx80_params[get_floatx80_rounding_precision(s)];
     uint64_t frac;
     int exp;
 
     switch (p->cls) {
     case float_class_normal:
     case float_class_denormal:
-        if (s->floatx80_rounding_precision == floatx80_precision_x) {
+        if (get_floatx80_rounding_precision(s) == floatx80_precision_x) {
             parts128_uncanon_normal(p, s, fmt, false);
             frac = p->frac_hi;
             exp = p->exp;
@@ -2841,7 +2841,7 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
     }
 
     p = parts128_round_to_int(&p, get_float_rounding_mode(status), 0, status,
-                              &floatx80_params[status->floatx80_rounding_precision]);
+                              &floatx80_params[get_floatx80_rounding_precision(status)]);
     return floatx80_round_pack_canonical(&p, status);
 }
 
@@ -4491,7 +4491,7 @@ floatx80 floatx80_sqrt(floatx80 a, float_status *s)
     if (!floatx80_unpack_canonical(&p, a, s)) {
         return floatx80_default_nan(s);
     }
-    parts128_sqrt(&p, s, &floatx80_params[s->floatx80_rounding_precision]);
+    parts128_sqrt(&p, s, &floatx80_params[get_floatx80_rounding_precision(s)]);
     return floatx80_round_pack_canonical(&p, s);
 }
 
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 7b0b0dd520..978eb1411b 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1185,9 +1185,9 @@ void helper_f2xm1(CPUX86State *env)
         uint64_t asig0, asig1, asig2, bsig0, bsig1;
         FloatRoundMode save_mode = get_float_rounding_mode(&env->fp_status);
         FloatX80RoundPrec save_prec =
-            env->fp_status.floatx80_rounding_precision;
+            get_floatx80_rounding_precision(&env->fp_status);
         set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
+        set_floatx80_rounding_precision(floatx80_precision_x, &env->fp_status);
 
         /* Find the nearest multiple of 1/32 to the argument.  */
         tmp = floatx80_scalbn(ST0, 5, &env->fp_status);
@@ -1290,7 +1290,7 @@ void helper_f2xm1(CPUX86State *env)
                                                 &env->fp_status);
         }
 
-        env->fp_status.floatx80_rounding_precision = save_prec;
+        set_floatx80_rounding_precision(save_prec, &env->fp_status);
     }
     merge_exception_flags(env, old_flags);
 }
@@ -1406,10 +1406,10 @@ void helper_fpatan(CPUX86State *env)
          * (and underflowing where appropriate).
          */
         FloatX80RoundPrec save_prec =
-            env->fp_status.floatx80_rounding_precision;
-        env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
+            get_floatx80_rounding_precision(&env->fp_status);
+        set_floatx80_rounding_precision(floatx80_precision_x, &env->fp_status);
         ST1 = floatx80_div(ST1, ST0, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = save_prec;
+        set_floatx80_rounding_precision(save_prec, &env->fp_status);
         if (!floatx80_is_zero(ST1) &&
             !(get_float_exception_flags(&env->fp_status) &
               float_flag_inexact)) {
@@ -1485,9 +1485,10 @@ void helper_fpatan(CPUX86State *env)
             floatx80 x8;
             FloatRoundMode save_mode = get_float_rounding_mode(&env->fp_status);
             FloatX80RoundPrec save_prec =
-                env->fp_status.floatx80_rounding_precision;
+                get_floatx80_rounding_precision(&env->fp_status);
             set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
-            env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
+            set_floatx80_rounding_precision(floatx80_precision_x,
+                                            &env->fp_status);
 
             if (arg0_exp == 0) {
                 normalizeFloatx80Subnormal(arg0_sig, &arg0_exp, &arg0_sig);
@@ -1794,7 +1795,7 @@ void helper_fpatan(CPUX86State *env)
             }
 
             set_float_rounding_mode(save_mode, &env->fp_status);
-            env->fp_status.floatx80_rounding_precision = save_prec;
+            set_floatx80_rounding_precision(save_prec, &env->fp_status);
         }
         /* This result is inexact.  */
         rsig1 |= 1;
@@ -2123,9 +2124,9 @@ void helper_fyl2xp1(CPUX86State *env)
         uint64_t asig0, asig1, asig2;
         FloatRoundMode save_mode = get_float_rounding_mode(&env->fp_status);
         FloatX80RoundPrec save_prec =
-            env->fp_status.floatx80_rounding_precision;
+            get_floatx80_rounding_precision(&env->fp_status);
         set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
+        set_floatx80_rounding_precision(floatx80_precision_x, &env->fp_status);
 
         helper_fyl2x_common(env, ST0, &aexp, &asig0, &asig1);
         /*
@@ -2143,7 +2144,7 @@ void helper_fyl2xp1(CPUX86State *env)
         ST1 = normalizeRoundAndPackFloatx80(floatx80_precision_x,
                                             arg0_sign ^ arg1_sign, aexp,
                                             asig0, asig1, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = save_prec;
+        set_floatx80_rounding_precision(save_prec, &env->fp_status);
     }
     fpop(env);
     merge_exception_flags(env, old_flags);
@@ -2226,9 +2227,9 @@ void helper_fyl2x(CPUX86State *env)
         floatx80 arg0_m1;
         FloatRoundMode save_mode = get_float_rounding_mode(&env->fp_status);
         FloatX80RoundPrec save_prec =
-            env->fp_status.floatx80_rounding_precision;
+            get_floatx80_rounding_precision(&env->fp_status);
         set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
+        set_floatx80_rounding_precision(floatx80_precision_x, &env->fp_status);
 
         if (arg0_exp == 0) {
             normalizeFloatx80Subnormal(arg0_sig, &arg0_exp, &arg0_sig);
@@ -2290,7 +2291,7 @@ void helper_fyl2x(CPUX86State *env)
                                                 asig0, asig1, &env->fp_status);
         }
 
-        env->fp_status.floatx80_rounding_precision = save_prec;
+        set_floatx80_rounding_precision(save_prec, &env->fp_status);
     }
     fpop(env);
     merge_exception_flags(env, old_flags);
@@ -2368,14 +2369,14 @@ void helper_fscale(CPUX86State *env)
         }
     } else {
         int n;
-        FloatX80RoundPrec save = env->fp_status.floatx80_rounding_precision;
+        FloatX80RoundPrec save = get_floatx80_rounding_precision(&env->fp_status);
         int save_flags = get_float_exception_flags(&env->fp_status);
         set_float_exception_flags(0, &env->fp_status);
         n = floatx80_to_int32_round_to_zero(ST1, &env->fp_status);
         set_float_exception_flags(save_flags, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
+        set_floatx80_rounding_precision(floatx80_precision_x, &env->fp_status);
         ST0 = floatx80_scalbn(ST0, n, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = save;
+        set_floatx80_rounding_precision(save, &env->fp_status);
     }
     merge_exception_flags(env, old_flags);
 }
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 51706f6db8..f5d683bcc5 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -72,7 +72,8 @@ floatx80 floatx80_getman(floatx80 a, float_status *status)
         normalizeFloatx80Subnormal(aSig, &aExp, &aSig);
     }
 
-    return roundAndPackFloatx80(status->floatx80_rounding_precision, aSign,
+    return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
+                                aSign,
                                 0x3FFF, aSig, 0, status);
 }
 
@@ -160,7 +161,7 @@ floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status)
 
     if (0x400F < bExp) {
         aExp = bSign ? -0x6001 : 0xE000;
-        return roundAndPackFloatx80(status->floatx80_rounding_precision,
+        return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                     aSign, aExp, aSig, 0, status);
     }
 
@@ -168,7 +169,7 @@ floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status)
     bSig >>= shiftCount;
     aExp = bSign ? (aExp - bSig) : (aExp + bSig);
 
-    return roundAndPackFloatx80(status->floatx80_rounding_precision,
+    return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                 aSign, aExp, aSig, 0, status);
 }
 
@@ -192,10 +193,11 @@ floatx80 floatx80_move(floatx80 a, float_status *status)
         if (aSig == 0) {
             return a;
         }
-        normalizeRoundAndPackFloatx80(status->floatx80_rounding_precision,
+        normalizeRoundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                       aSign, aExp, aSig, 0, status);
     }
-    return roundAndPackFloatx80(status->floatx80_rounding_precision, aSign,
+    return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
+                                aSign,
                                 aExp, aSig, 0, status);
 }
 
@@ -267,9 +269,9 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -337,7 +339,7 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
         fp0 = floatx80_add(fp0, fp1, status); /* FP0 IS LOG(F) + LOG(1+U) */
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_add(fp0, klog2, status);
 
@@ -403,7 +405,7 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
                            status); /* U*V*([B1+W*(B3+W*B5)] + [V*(B2+W*B4)]) */
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_add(fp0, saveu, status);
 
@@ -465,9 +467,9 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -524,7 +526,7 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
         fp0 = floatx80_add(fp0, fp1, status); /* FP0 IS LOG(F) + LOG(1+U) */
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_add(fp0, klog2, status);
 
@@ -570,7 +572,7 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
                            status); /* U*V*([B1+W*(B3+W*B5)] + [V*(B2+W*B4)]) */
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_add(fp0, saveu, status);
 
@@ -621,15 +623,15 @@ floatx80 floatx80_log10(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     fp0 = floatx80_logn(a, status);
     fp1 = packFloatx80(0, 0x3FFD, UINT64_C(0xDE5BD8A937287195)); /* INV_L10 */
 
     set_float_rounding_mode(user_rnd_mode, status);
-    status->floatx80_rounding_precision = user_rnd_prec;
+    set_floatx80_rounding_precision(user_rnd_prec, status);
 
     a = floatx80_mul(fp0, fp1, status); /* LOGN(X)*INV_L10 */
 
@@ -680,13 +682,13 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     if (aSig == one_sig) { /* X is 2^k */
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = int32_to_floatx80(aExp - 0x3FFF, status);
     } else {
@@ -694,7 +696,7 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
         fp1 = packFloatx80(0, 0x3FFF, UINT64_C(0xB8AA3B295C17F0BC)); /* INV_L2 */
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_mul(fp0, fp1, status); /* LOGN(X)*INV_L2 */
     }
@@ -740,9 +742,9 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     adjflag = 0;
 
@@ -818,7 +820,7 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
             }
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_mul(fp0, scale, status);
 
@@ -828,15 +830,13 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
         } else { /* |X| >= 16380 log2 */
             if (compact > 0x400CB27C) { /* |X| >= 16480 log2 */
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
                 if (aSign) {
-                    a = roundAndPackFloatx80(
-                                           status->floatx80_rounding_precision,
-                                           0, -0x1000, aSig, 0, status);
+                    a = roundAndPackFloatx80(get_floatx80_rounding_precision(status),
+                                             0, -0x1000, aSig, 0, status);
                 } else {
-                    a = roundAndPackFloatx80(
-                                           status->floatx80_rounding_precision,
-                                           0, 0x8000, aSig, 0, status);
+                    a = roundAndPackFloatx80(get_floatx80_rounding_precision(status),
+                                             0, 0x8000, aSig, 0, status);
                 }
                 float_raise(float_flag_inexact, status);
 
@@ -877,7 +877,7 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
         }
     } else { /* |X| < 2^(-65) */
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_add(a, float32_to_floatx80(make_float32(0x3F800000),
                          status), status); /* 1 + X */
@@ -923,9 +923,9 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     fp0 = a;
 
@@ -935,18 +935,18 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
         /* |X| > 16480 or |X| < 2^(-70) */
         if (compact > 0x3FFF8000) { /* |X| > 16480 */
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             if (aSign) {
-                return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                             0, -0x1000, aSig, 0, status);
             } else {
-                return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                             0, 0x8000, aSig, 0, status);
             }
         } else { /* |X| < 2^(-70) */
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, float32_to_floatx80(
                              make_float32(0x3F800000), status),
@@ -1028,7 +1028,7 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
         fp0 = floatx80_add(fp0, fact1, status);
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_mul(fp0, adjfact, status);
 
@@ -1073,9 +1073,9 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     fp0 = a;
 
@@ -1085,18 +1085,18 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
         /* |X| > 16480 LOG2/LOG10 or |X| < 2^(-70) */
         if (compact > 0x3FFF8000) { /* |X| > 16480 */
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             if (aSign) {
-                return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                             0, -0x1000, aSig, 0, status);
             } else {
-                return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                             0, 0x8000, aSig, 0, status);
             }
         } else { /* |X| < 2^(-70) */
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, float32_to_floatx80(
                              make_float32(0x3F800000), status),
@@ -1183,7 +1183,7 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
         fp0 = floatx80_add(fp0, fact1, status);
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_mul(fp0, adjfact, status);
 
@@ -1228,9 +1228,9 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -1295,7 +1295,7 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
             goto loop;
         } else {
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_move(a, status);
 
@@ -1355,7 +1355,7 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
             fp1 = packFloatx80(xSign, xExp, xSig);
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_div(fp0, fp1, status);
 
@@ -1393,7 +1393,7 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
                                status); /* 1+S(Q1+S(Q2+S(Q3+SQ4))) */
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_div(fp0, fp1, status);
 
@@ -1439,9 +1439,9 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -1510,7 +1510,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
                                       status); /* 1 */
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             /* SINTINY */
             a = floatx80_move(a, status);
@@ -1583,7 +1583,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             fp0 = floatx80_mul(fp0, x, status);
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, float32_to_floatx80(posneg1, status), status);
 
@@ -1633,7 +1633,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             fp0 = floatx80_mul(fp0, fp1, status); /* SIN(R')-R' */
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, x, status);
 
@@ -1679,9 +1679,9 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -1749,7 +1749,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             fp0 = float32_to_floatx80(make_float32(0x3F800000), status); /* 1 */
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             /* COSTINY */
             a = floatx80_sub(fp0, float32_to_floatx80(
@@ -1823,7 +1823,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             fp0 = floatx80_mul(fp0, x, status);
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, float32_to_floatx80(posneg1, status), status);
 
@@ -1871,7 +1871,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             fp0 = floatx80_mul(fp0, fp1, status); /* SIN(R')-R' */
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, x, status);
 
@@ -1918,9 +1918,9 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
     compact = floatx80_make_compact(aExp, aSig);
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     if (compact < 0x3FFB8000 || compact > 0x4002FFFF) {
         /* |X| >= 16 or |X| < 1/16 */
@@ -1930,7 +1930,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
                 fp1 = packFloatx80(aSign, 0x0001, one_sig);
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_sub(fp0, fp1, status);
 
@@ -1970,7 +1970,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
                 fp1 = packFloatx80(aSign, piby2_exp, pi_sig);
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_add(fp0, fp1, status);
 
@@ -1981,7 +1981,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
         } else { /* |X| < 1/16 */
             if (compact < 0x3FD78000) { /* |X| < 2^(-40) */
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_move(a, status);
 
@@ -2021,7 +2021,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
                 fp0 = floatx80_mul(fp0, fp1, status);
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_add(fp0, xsave, status);
 
@@ -2070,7 +2070,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
         fp0 = floatx80_add(fp0, fp1, status); /* ATAN(U) */
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_add(fp0, fp3, status); /* ATAN(X) */
 
@@ -2123,9 +2123,9 @@ floatx80 floatx80_asin(floatx80 a, float_status *status)
     } /* |X| < 1 */
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     one = packFloatx80(0, one_exp, one_sig);
     fp0 = a;
@@ -2137,7 +2137,7 @@ floatx80 floatx80_asin(floatx80 a, float_status *status)
     fp0 = floatx80_div(fp0, fp1, status);   /* X/SQRT((1+X)*(1-X)) */
 
     set_float_rounding_mode(user_rnd_mode, status);
-    status->floatx80_rounding_precision = user_rnd_prec;
+    set_floatx80_rounding_precision(user_rnd_prec, status);
 
     a = floatx80_atan(fp0, status);         /* ATAN(X/SQRT((1+X)*(1-X))) */
 
@@ -2171,7 +2171,8 @@ floatx80 floatx80_acos(floatx80 a, float_status *status)
     }
     if (aExp == 0 && aSig == 0) {
         float_raise(float_flag_inexact, status);
-        return roundAndPackFloatx80(status->floatx80_rounding_precision, 0,
+        return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
+                                    0,
                                     piby2_exp, pi_sig, 0, status);
     }
 
@@ -2193,9 +2194,9 @@ floatx80 floatx80_acos(floatx80 a, float_status *status)
     } /* |X| < 1 */
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     one = packFloatx80(0, one_exp, one_sig);
     fp0 = a;
@@ -2207,7 +2208,7 @@ floatx80 floatx80_acos(floatx80 a, float_status *status)
     fp0 = floatx80_atan(fp0, status);       /* ATAN(SQRT((1-X)/(1+X))) */
 
     set_float_rounding_mode(user_rnd_mode, status);
-    status->floatx80_rounding_precision = user_rnd_prec;
+    set_floatx80_rounding_precision(user_rnd_prec, status);
 
     a = floatx80_add(fp0, fp0, status);     /* 2 * ATAN(SQRT((1-X)/(1+X))) */
 
@@ -2257,9 +2258,9 @@ floatx80 floatx80_atanh(floatx80 a, float_status *status)
     } /* |X| < 1 */
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     one = packFloatx80(0, one_exp, one_sig);
     fp2 = packFloatx80(aSign, 0x3FFE, one_sig); /* SIGN(X) * (1/2) */
@@ -2271,7 +2272,7 @@ floatx80 floatx80_atanh(floatx80 a, float_status *status)
     fp0 = floatx80_lognp1(fp0, status); /* LOG1P(Z) */
 
     set_float_rounding_mode(user_rnd_mode, status);
-    status->floatx80_rounding_precision = user_rnd_prec;
+    set_floatx80_rounding_precision(user_rnd_prec, status);
 
     a = floatx80_mul(fp0, fp2,
                      status); /* ATANH(X) = SIGN(X) * (1/2) * LOG1P(Z) */
@@ -2316,9 +2317,9 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     if (aExp >= 0x3FFD) { /* |X| >= 1/4 */
         compact = floatx80_make_compact(aExp, aSig);
@@ -2411,7 +2412,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
             sc = packFloatx80(0, m + 0x3FFF, one_sig);
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_mul(fp0, sc, status);
 
@@ -2424,7 +2425,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
                       status); /* -1 */
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_add(fp0, float32_to_floatx80(
                                  make_float32(0x00800000), status),
@@ -2435,7 +2436,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
                 return a;
             } else {
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 return floatx80_etox(a, status);
             }
@@ -2496,7 +2497,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
             fp0 = floatx80_add(fp0, fp1, status); /* S*B1+Q */
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, a, status);
 
@@ -2514,14 +2515,14 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
                 fp0 = floatx80_add(fp0, sc, status);
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_mul(fp0, float64_to_floatx80(
                                  make_float64(0x3730000000000000), status),
                                  status);
             } else {
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_add(fp0, sc, status);
             }
@@ -2566,9 +2567,9 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -2577,7 +2578,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
         if (compact < 0x3FFF8000) {
             /* TANHSM */
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_move(a, status);
 
@@ -2594,7 +2595,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
                 sign ^= 0x80800000; /* -SIGN(X)*EPS */
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_add(fp0, float32_to_floatx80(make_float32(sign),
                                  status), status);
@@ -2616,7 +2617,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
                                           status); /* SIGN */
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_add(fp1, fp0, status);
 
@@ -2639,7 +2640,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
         fp1 = packFloatx80(vSign ^ aSign, vExp, vSig);
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_div(fp0, fp1, status);
 
@@ -2682,9 +2683,9 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -2692,9 +2693,9 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
         /* SINHBIG */
         if (compact > 0x400CB2B3) {
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
-            return roundAndPackFloatx80(status->floatx80_rounding_precision,
+            return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                         aSign, 0x8000, aSig, 0, status);
         } else {
             fp0 = floatx80_abs(a); /* Y = |X| */
@@ -2708,7 +2709,7 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
             fp2 = packFloatx80(aSign, 0x7FFB, one_sig);
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_mul(fp0, fp2, status);
 
@@ -2728,7 +2729,7 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
         fact = packFloat32(aSign, 0x7E, 0);
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_mul(fp0, float32_to_floatx80(fact, status), status);
 
@@ -2768,17 +2769,18 @@ floatx80 floatx80_cosh(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
     if (compact > 0x400CB167) {
         if (compact > 0x400CB2B3) {
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
-            return roundAndPackFloatx80(status->floatx80_rounding_precision, 0,
+            set_floatx80_rounding_precision(user_rnd_prec, status);
+            return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
+                                        0,
                                         0x8000, one_sig, 0, status);
         } else {
             fp0 = packFloatx80(0, aExp, aSig);
@@ -2792,7 +2794,7 @@ floatx80 floatx80_cosh(floatx80 a, float_status *status)
             fp1 = packFloatx80(0, 0x7FFB, one_sig);
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_mul(fp0, fp1, status);
 
@@ -2810,7 +2812,7 @@ floatx80 floatx80_cosh(floatx80 a, float_status *status)
     fp1 = floatx80_div(fp1, fp0, status); /* 1/(2*EXP(|X|)) */
 
     set_float_rounding_mode(user_rnd_mode, status);
-    status->floatx80_rounding_precision = user_rnd_prec;
+    set_floatx80_rounding_precision(user_rnd_prec, status);
 
     a = floatx80_add(fp0, fp1, status);
 
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index fdb0cccf14..326a1201f3 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -996,7 +996,7 @@ void run_test(void)
 
                 verCases_roundingPrecision = 0;
                 slow_extF80_roundingPrecision = prec80;
-                qsf.floatx80_rounding_precision = qsf_prec80;
+                set_floatx80_rounding_precision(qsf_prec80, &qsf);
 
                 if (attrs & FUNC_EFF_ROUNDINGPRECISION) {
                     verCases_roundingPrecision = prec80;
-- 
2.43.0


