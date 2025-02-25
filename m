Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132B2C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzL6-0002lZ-F7; Tue, 25 Feb 2025 13:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJB-0008L2-11
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:32 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ7-0002DF-MV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:28 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-439a4dec9d5so57994125e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506724; x=1741111524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o85nyeCWBlwcMm8LJhi8yYph6HgZIzLDg7S+MlOpjLI=;
 b=t3TPC+UDTwyA9CK4q4zwlB7JVzmkVITDlH0EUrdk+C9oBM3atGmL2WiCZwWKW4wgX+
 TL3AuGpEmoQPXfhhYmNI+2tSlrhadnTA1IstrzaF31UCvI042dDOtgVHHC03/i2+uSxP
 rfLsASVYnc2gRbM93/Zj6dBexG6xSmxUOp9qdKX0+oA2w9IrZAzRzgNFv6Jkyfcrg50n
 YdAmQKG9UjMwcLlF2JkDg+xhCWYCrzVd7JjSv1rjeC7GsNBLD2dut2ciyRUYaqxOC24O
 Ib7v2kH/g/sSGLAJ4H+rsZxJRwuXqwnoM2YqI54qKOZREFwe9K40J6iVnwkqVQQQiMEb
 vC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506724; x=1741111524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o85nyeCWBlwcMm8LJhi8yYph6HgZIzLDg7S+MlOpjLI=;
 b=wNAWse0sv5yZZWAk8/sq4zrx69dnqjuZWPeRIaimI2zjw8157YgrYzb1VwmqpRRp2E
 hu0yG8rcZX0P1aI89Wnn15C13erJFa/jL4O7/ATouas+WNTz7vUtlIy1o3DnKFc0w8j5
 L6LWgYkwrLWJXDDu2dbjQ4A0CG2Oj+Kmhv/DEodjwGPI3dT15GLDg3mCJouybT9OQvl5
 PLSbwzrQf98sZqchbvaXWMkHZl7wVMt5UyaxzQkaA+G3asFHcaxW9pW+JdNZFep9+4J3
 WVevgKEym8WDUiikxBCezZJU47tiP936oF6br34J3zmNvbnMDZAnBOsqn0wz27PUnDEx
 v3aA==
X-Gm-Message-State: AOJu0YyQLzjRpUbZ7Bn6ZZ4TglYGt2IFHlCgECAKU35RZ7mHSPwlv/1B
 4jiAf7lk1Y79EwGRlDU1rT4gQuKd2c01DQy3thHFh3YHyPHiPwekT467vmId/o7qmBD1wd97cgH
 y
X-Gm-Gg: ASbGncu6TaZ//mtY7xKzcC0YnhNPo0Js5GoMEXWy08rytorOvzc7akUCb2QrbVs7FoL
 skgcD65DAPF2cnP6diVj0RH+XsaZ5uLyC3J4pgQMnIxat1ovqBlwzHPc5tl4Zw5DW9UUd4bJa/r
 6AwMKtmhgLSiRvgt+dHUwxaiFlwdw1+FegOOo5PgImraZGyalCoA+hlY1cpGkj+CR3Cv3v/yos6
 rAYH3CrIpnyh9w+IlT2UIhorI0xQiRpffibIF5ysYRQ8+8JEnuy0t7Q7mzchUh0zSyLJaOWArZg
 YYMA7/PbRHPrzxi4N/MZF+F4YaivLjWn
X-Google-Smtp-Source: AGHT+IG0b8r9qwGGKyo/rN+jtw7nstDC91bBVTAsC6RbrmslbYn8uBNQbEJvaeXaubZpv7+5iBoJHQ==
X-Received: by 2002:a05:600c:154e:b0:439:a0a3:a15 with SMTP id
 5b1f17b1804b1-43ab0f3c907mr54966635e9.14.1740506723621; 
 Tue, 25 Feb 2025 10:05:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/43] fpu: Make targets specify floatx80 default Inf at runtime
Date: Tue, 25 Feb 2025 18:04:35 +0000
Message-ID: <20250225180510.1318207-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Currently we hardcode at compile time whether the floatx80 default
Infinity value has the explicit integer bit set or not (x86 sets it;
m68k does not).  To be able to compile softfloat once for all targets
we'd like to move this setting to runtime.

Define a new FloatX80Behaviour enum which is a set of flags that
define the target's floatx80 handling.  Initially we define just one
flag, for whether the default Infinity has the Integer bit set or
not, but we will expand this in future commits to cover the other
floatx80 target specifics that we currently make compile-time
settings.

Define a new function floatx80_default_inf() which returns the
appropriate default Infinity value of the given sign, and use it in
the code that was previously directly using the compile-time constant
floatx80_infinity_{low,high} values when packing an infinity into a
floatx80.

Since floatx80 is highly unlikely to be supported in any new
architecture, and the existing code is generally written as "default
to like x87, with an ifdef for m68k", we make the default value for
the floatx80 behaviour flags be "what x87 does".  This means we only
need to change the m68k target to specify the behaviour flags.

(Other users of floatx80 are the Arm NWFPE emulation, which is
obsolete and probably not actually doing the right thing anyway, and
the PPC xsrqpxp insn.  Making the default be "like x87" avoids our
needing to review and test for behaviour changes there.)

We will clean up the remaining uses of the floatx80_infinity global
constant in subsequent commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250224111524.1101196-2-peter.maydell@linaro.org
Message-id: 20250217125055.160887-2-peter.maydell@linaro.org
---
 include/fpu/softfloat-helpers.h | 12 ++++++++++++
 include/fpu/softfloat-types.h   | 13 +++++++++++++
 include/fpu/softfloat.h         |  1 +
 fpu/softfloat.c                 |  7 +++----
 target/m68k/cpu.c               |  6 ++++++
 fpu/softfloat-specialize.c.inc  | 10 ++++++++++
 6 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 8983c2748ec..90862f5cd22 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -75,6 +75,12 @@ static inline void set_floatx80_rounding_precision(FloatX80RoundPrec val,
     status->floatx80_rounding_precision = val;
 }
 
+static inline void set_floatx80_behaviour(FloatX80Behaviour b,
+                                          float_status *status)
+{
+    status->floatx80_behaviour = b;
+}
+
 static inline void set_float_2nan_prop_rule(Float2NaNPropRule rule,
                                             float_status *status)
 {
@@ -151,6 +157,12 @@ get_floatx80_rounding_precision(const float_status *status)
     return status->floatx80_rounding_precision;
 }
 
+static inline FloatX80Behaviour
+get_floatx80_behaviour(const float_status *status)
+{
+    return status->floatx80_behaviour;
+}
+
 static inline Float2NaNPropRule
 get_float_2nan_prop_rule(const float_status *status)
 {
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 53d5eb85210..dd22ecdbe60 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -320,6 +320,18 @@ typedef enum __attribute__((__packed__)) {
     float_ftz_before_rounding = 1,
 } FloatFTZDetection;
 
+/*
+ * floatx80 is primarily used by x86 and m68k, and there are
+ * differences in the handling, largely related to the explicit
+ * Integer bit which floatx80 has and the other float formats do not.
+ * These flag values allow specification of the target's requirements
+ * and can be ORed together to set floatx80_behaviour.
+ */
+typedef enum __attribute__((__packed__)) {
+    /* In the default Infinity value, is the Integer bit 0 ? */
+    floatx80_default_inf_int_bit_is_zero = 1,
+} FloatX80Behaviour;
+
 /*
  * Floating Point Status. Individual architectures may maintain
  * several versions of float_status for different functions. The
@@ -331,6 +343,7 @@ typedef struct float_status {
     uint16_t float_exception_flags;
     FloatRoundMode float_rounding_mode;
     FloatX80RoundPrec floatx80_rounding_precision;
+    FloatX80Behaviour floatx80_behaviour;
     Float2NaNPropRule float_2nan_prop_rule;
     Float3NaNPropRule float_3nan_prop_rule;
     FloatInfZeroNaNRule float_infzeronan_rule;
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 09a40b43106..afae3906024 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -961,6 +961,7 @@ float128 floatx80_to_float128(floatx80, float_status *status);
 | The pattern for an extended double-precision inf.
 *----------------------------------------------------------------------------*/
 extern const floatx80 floatx80_infinity;
+floatx80 floatx80_default_inf(bool zSign, float_status *status);
 
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE extended double-precision operations.
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f4fed9bfda9..b12ad2b42a9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1860,7 +1860,8 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
 
     case float_class_inf:
         /* x86 and m68k differ in the setting of the integer bit. */
-        frac = floatx80_infinity_low;
+        frac = s->floatx80_behaviour & floatx80_default_inf_int_bit_is_zero ?
+            0 : (1ULL << 63);
         exp = fmt->exp_max;
         break;
 
@@ -5144,9 +5145,7 @@ floatx80 roundAndPackFloatx80(FloatX80RoundPrec roundingPrecision, bool zSign,
                ) {
                 return packFloatx80( zSign, 0x7FFE, ~ roundMask );
             }
-            return packFloatx80(zSign,
-                                floatx80_infinity_high,
-                                floatx80_infinity_low);
+            return floatx80_default_inf(zSign, status);
         }
         if ( zExp <= 0 ) {
             isTiny = status->tininess_before_rounding
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 41dfdf58045..df66e8ba22a 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -107,6 +107,12 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
     /* Default NaN: sign bit clear, all frac bits set */
     set_float_default_nan_pattern(0b01111111, &env->fp_status);
+    /*
+     * m68k-specific floatx80 behaviour:
+     *  * default Infinity values have a zero Integer bit
+     */
+    set_floatx80_behaviour(floatx80_default_inf_int_bit_is_zero,
+                           &env->fp_status);
 
     nan = floatx80_default_nan(&env->fp_status);
     for (i = 0; i < 8; i++) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index cbbbab52ba3..73789e97d77 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -227,6 +227,16 @@ floatx80 floatx80_default_nan(float_status *status)
 | The pattern for a default generated extended double-precision inf.
 *----------------------------------------------------------------------------*/
 
+floatx80 floatx80_default_inf(bool zSign, float_status *status)
+{
+    /*
+     * Whether the Integer bit is set in the default Infinity is
+     * target dependent.
+     */
+    bool z = status->floatx80_behaviour & floatx80_default_inf_int_bit_is_zero;
+    return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
+}
+
 #define floatx80_infinity_high 0x7FFF
 #if defined(TARGET_M68K)
 #define floatx80_infinity_low  UINT64_C(0x0000000000000000)
-- 
2.43.0


