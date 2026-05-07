Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C6FCD37AF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72A-0000p4-E5; Thu, 07 May 2026 18:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL728-0000oh-9l
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:28 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL725-00039r-QF
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:27 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-42321c8b8f5so1093365fac.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192244; x=1778797044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1HnxtWH4yGYngMg/1E/CURv4bewMQRvEBgxk9Rn0Sro=;
 b=RbDqyvQzZFj8uNJVMTUpcPFAwExzEI6ce8wIPAXHg6dcLJFzqjRhG79vdruyvBhMh2
 TjbtkhIg5N1GozVdbLRZZSUgCAWZlvDmsYx9xrC1lNZV9hbbgAA9vk0J2BkWrdpyi/PC
 Z/hMj55PiSma7YKEw0YvSfYjwBHYh49RQbtQJQFW53PLd5UrKVWROzMFws+mUuif0Qoq
 bmtSfxUMoAb7giZdyF4qoyCwcKA1+F2bRi0CndKvW//kLKY0i8BEhHMdymv1qd1tRFDR
 TTSaXeHXUDFh0RCPXu0Q7pSLy9m8VlwgJr5sHGHh0xHSHwzBHqSJLTYCKledaEk5wdja
 KM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192244; x=1778797044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1HnxtWH4yGYngMg/1E/CURv4bewMQRvEBgxk9Rn0Sro=;
 b=YbXKhxHLBLRAU/cK7WF/CQo42U6VSeYIVhi9N7VteNrWs0QhjDunEl8kLHIZ0YAJPR
 /XvoGKpQBuySmrcnaWnyPDTnIt1hVvV8SI5xAg+aZyxsnmi1NFsCuIadMnyZ5TzJgGii
 eaA0fhlc2TZi1PaafQtcFcqhfXhPzSkHT+K5pa2Se3SdveGjIH08QiXXUVNf718jMei3
 eSMAc3OqncAceieS6EPvaDmdy+FqE0o19zim98VaGiKfXTY26LUdDfV0dT3eliaTXA1Q
 myQFxXk4si5vYnR68CBHgg1htfoEZIu/9n71T9Rj222Dpe67rGCaTg7Nd6FxwYloUv56
 MJoQ==
X-Gm-Message-State: AOJu0YyHFfCGCMr4k4Q2ZHOE95pA6b75s/Ma/hsuS26hFInfRRjrPRli
 TEv9+zNWJ4dI48ThhM3KqedW/LBgDFY54Z2Nc7/QOUhMz6GfqTd1JOCp28d94nTAG4lRPKC9KuW
 FnAPQ
X-Gm-Gg: Acq92OEc7tn1XuJjOfTPksKFrD/rn/1ciRexFvye/mDHpgwnOG4Qqxifn3xAziDmbo7
 /+jHc7ghIC7EF/5KIMukKTGEuChW/fTxbMZvXsmedreQpbBSWKg0ptJMCbEU93n/hcaE0qhT4zL
 uME/Mr/OeshlwnqFiQC6JHbgNuL/qRCsp/P4ftfXnIOTe+9HgqNy2R4nZg68+lAlitF/bGIffh7
 t4FYcx0862JvFAOHMsasXgN6+Q3yIzVvCidFsXNhiHuowgowFXsH61J6KbjujxI2XWnyEJD4dYn
 eOAFb2jEebM8JdJm0ELAtk2VpLVykq8fpdUHY8RNb7fRDcb6qbQIXLU8QzIJPEFar2A0VaWE1Sk
 G+8o8g7MDgJ8DabgU5tludQgOHzPTueuJD9ej4l3l60XJkP0a3rnNOKqiO9TO+Gdi+Aegx9EHBN
 ezlj9e3I1sqqIKCG7Hz+3ca4WIdE7e9UrA/7vxaS38vjWhLw==
X-Received: by 2002:a05:6870:d215:b0:42f:f390:d9 with SMTP id
 586e51a60fabf-435269c4445mr2740642fac.15.1778192243851; 
 Thu, 07 May 2026 15:17:23 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/18] fpu: Introduce FloatSNaNRule
Date: Thu,  7 May 2026 17:17:03 -0500
Message-ID: <20260507221717.486023-5-richard.henderson@linaro.org>
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

Merge snan_bit_is_one and no_signaling_nans into one control.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 14 ++---
 include/fpu/softfloat-types.h   | 25 ++++++---
 target/mips/fpu_helper.h        |  3 +-
 target/hppa/fpu_helper.c        |  2 +-
 target/mips/msa.c               |  4 +-
 target/sh4/cpu.c                |  2 +-
 target/xtensa/cpu.c             |  3 +-
 fpu/softfloat-specialize.c.inc  | 95 ++++++++++++---------------------
 8 files changed, 66 insertions(+), 82 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 745a49f07a..95edd22842 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -127,14 +127,9 @@ static inline void set_default_nan_mode(bool val, float_status *status)
     status->default_nan_mode = val;
 }
 
-static inline void set_snan_bit_is_one(bool val, float_status *status)
+static inline void set_snan_rule(FloatSNaNRule val, float_status *status)
 {
-    status->snan_bit_is_one = val;
-}
-
-static inline void set_no_signaling_nans(bool val, float_status *status)
-{
-    status->no_signaling_nans = val;
+    status->float_snan_rule = val;
 }
 
 static inline bool get_float_detect_tininess(const float_status *status)
@@ -203,6 +198,11 @@ static inline bool get_default_nan_mode(const float_status *status)
     return status->default_nan_mode;
 }
 
+static inline FloatSNaNRule get_snan_rule(float_status *status)
+{
+    return status->float_snan_rule;
+}
+
 static inline FloatFTZDetection get_float_ftz_detection(const float_status *status)
 {
     return status->ftz_detection;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 5048faa76f..b8ce8ff78e 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -192,6 +192,23 @@ typedef enum __attribute__((__packed__)) {
     floatx80_precision_s,
 } FloatX80RoundPrec;
 
+/*
+ * Define how the architecture discriminates signaling NaNs.
+ * This done with the most significant bit of the fraction.
+ *
+ * In IEEE 754-1985 this was implementation defined, but in IEEE 754-2008
+ * the msb must be 0.  But setting the msb to 1 got baked into HPPA, SH4,
+ * and pre-2008 MIPS.
+ *
+ * Further, some architectures (or modes of architectures) do not detect
+ * signaling NaNs at all.
+ */
+typedef enum __attribute__((__packed__)) {
+    float_snan_bit_is_zero = 0,
+    float_snan_bit_is_one = 1,
+    float_snan_never,
+} FloatSNaNRule;
+
 /*
  * 2-input NaN propagation rule. Individual architectures have
  * different rules for which input NaN is propagated to the output
@@ -394,6 +411,7 @@ typedef struct float_status {
     Float2NaNPropRule float_2nan_prop_rule;
     Float3NaNPropRule float_3nan_prop_rule;
     FloatInfZeroNaNRule float_infzeronan_rule;
+    FloatSNaNRule float_snan_rule;
     bool tininess_before_rounding;
     /* should denormalised results go to zero and set output_denormal_flushed? */
     bool flush_to_zero;
@@ -412,13 +430,6 @@ typedef struct float_status {
      * create a default NaN.
      */
     uint8_t default_nan_pattern;
-    /*
-     * The flags below are not used on all specializations and may
-     * constant fold away (see snan_bit_is_one()/no_signalling_nans() in
-     * softfloat-specialize.inc.c)
-     */
-    bool snan_bit_is_one;
-    bool no_signaling_nans;
     /* should overflowed results subtract re_bias to its exponent? */
     bool rebias_overflow;
     /* should underflowed results add re_bias to its exponent? */
diff --git a/target/mips/fpu_helper.h b/target/mips/fpu_helper.h
index 08fb409390..cf667c6637 100644
--- a/target/mips/fpu_helper.h
+++ b/target/mips/fpu_helper.h
@@ -35,7 +35,8 @@ static inline void restore_snan_bit_mode(CPUMIPSState *env)
      * With nan2008, SNaNs are silenced in the usual way.
      * Before that, SNaNs are not silenced; default nans are produced.
      */
-    set_snan_bit_is_one(!nan2008, &env->active_fpu.fp_status);
+    set_snan_rule(nan2008 ? float_snan_bit_is_zero : float_snan_bit_is_one,
+                  &env->active_fpu.fp_status);
     set_default_nan_mode(!nan2008, &env->active_fpu.fp_status);
     /*
      * For MIPS systems that conform to IEEE754-1985, the (inf,zero,nan)
diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 2d272730f6..cdbebcfeb3 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -66,7 +66,7 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
     /* Default NaN: sign bit clear, msb-1 frac bit set */
     set_float_default_nan_pattern(0b00100000, &env->fp_status);
-    set_snan_bit_is_one(true, &env->fp_status);
+    set_snan_rule(float_snan_bit_is_one, &env->fp_status);
     /*
      * "PA-RISC 2.0 Architecture" says it is IMPDEF whether the flushing
      * enabled by FPSR.D happens before or after rounding. We pick "before"
diff --git a/target/mips/msa.c b/target/mips/msa.c
index 32c6acbcc5..53fbce10d3 100644
--- a/target/mips/msa.c
+++ b/target/mips/msa.c
@@ -84,8 +84,8 @@ void msa_reset(CPUMIPSState *env)
     /* clear float_status nan mode */
     set_default_nan_mode(0, &env->active_tc.msa_fp_status);
 
-    /* set proper signanling bit meaning ("1" means "quiet") */
-    set_snan_bit_is_one(0, &env->active_tc.msa_fp_status);
+    /* set proper signanling bit meaning */
+    set_snan_rule(float_snan_bit_is_zero, &env->active_tc.msa_fp_status);
 
     /* Inf * 0 + NaN returns the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index e2bde45761..0f40acea00 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -151,7 +151,7 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_to_zero(1, &env->fp_status);
 #endif
     set_default_nan_mode(1, &env->fp_status);
-    set_snan_bit_is_one(true, &env->fp_status);
+    set_snan_rule(float_snan_bit_is_one, &env->fp_status);
     /* sign bit clear, set all frac bits other than msb */
     set_float_default_nan_pattern(0b00111111, &env->fp_status);
     /*
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 31429ec2f8..e6cd0e160d 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -209,7 +209,8 @@ static void xtensa_cpu_reset_hold(Object *obj, ResetType type)
 #endif
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
-    set_no_signaling_nans(!dfpu, &env->fp_status);
+    set_snan_rule(dfpu ? float_snan_bit_is_zero : float_snan_never,
+                  &env->fp_status);
     /* Default NaN value: sign bit clear, set frac msb */
     set_float_default_nan_pattern(0b01000000, &env->fp_status);
     xtensa_use_first_nan(env, !dfpu);
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 485f082cf8..29a2fdeb9b 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -79,39 +79,29 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
-/*
- * Define whether architecture deviates from IEEE in not supporting
- * signaling NaNs (so all NaNs are treated as quiet).
- */
-static inline bool no_signaling_nans(float_status *status)
-{
-    return status->no_signaling_nans;
-}
-
-/* Define how the architecture discriminates signaling NaNs.
- * This done with the most significant bit of the fraction.
- * In IEEE 754-1985 this was implementation defined, but in IEEE 754-2008
- * the msb must be zero.  MIPS is (so far) unique in supporting both the
- * 2008 revision and backward compatibility with their original choice.
- */
-static inline bool snan_bit_is_one(float_status *status)
-{
-    return status->snan_bit_is_one;
-}
-
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
 *----------------------------------------------------------------------------*/
 
+static bool frac_msb_is_snan(bool msb, float_status *status)
+{
+    FloatSNaNRule rule = get_snan_rule(status);
+
+    switch (rule) {
+    case float_snan_never:
+        return false;
+    case float_snan_bit_is_one:
+    case float_snan_bit_is_zero:
+        return msb == rule;
+    }
+    g_assert_not_reached();
+}
+
 static bool parts_is_snan_frac(uint64_t frac, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    } else {
-        bool msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
-        return msb == snan_bit_is_one(status);
-    }
+    bool msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
+    return frac_msb_is_snan(msb, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -167,14 +157,19 @@ FloatParts128 parts128_default_nan(float_status *status)
 
 static uint64_t parts_silence_nan_frac(uint64_t frac, float_status *status)
 {
-    g_assert(!no_signaling_nans(status));
+    FloatSNaNRule rule = get_snan_rule(status);
 
-    /* The only snan_bit_is_one target without default_nan_mode is HPPA. */
-    if (snan_bit_is_one(status)) {
+    switch (rule) {
+    case float_snan_bit_is_zero:
+        frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 1);
+        break;
+    case float_snan_bit_is_one:
+        /* The only snan_bit_is_one target without default_nan_mode is HPPA. */
         frac &= ~(1ULL << (DECOMPOSED_BINARY_POINT - 1));
         frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 2);
-    } else {
-        frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 1);
+        break;
+    default:
+        g_assert_not_reached();
     }
     return frac;
 }
@@ -238,11 +233,7 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
 
 static bool float16_nan_is_snan(float16 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 9) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 9) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -271,11 +262,7 @@ bool float16_is_signaling_nan(float16 a_, float_status *status)
 
 static bool bfloat16_nan_is_snan(bfloat16 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 6) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 6) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -302,11 +289,7 @@ bool bfloat16_is_signaling_nan(bfloat16 a_, float_status *status)
 
 static bool float32_nan_is_snan(float32 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 22) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 22) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -335,11 +318,7 @@ bool float32_is_signaling_nan(float32 a_, float_status *status)
 
 static bool float64_nan_is_snan(float64 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 51) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 51) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -370,11 +349,7 @@ bool float64_is_signaling_nan(float64 a_, float_status *status)
 
 static bool floatx80_nan_is_snan(floatx80 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a.low >> 62) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a.low >> 62) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -405,7 +380,7 @@ bool floatx80_is_signaling_nan(floatx80 a, float_status *status)
 floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
 {
     /* None of the targets that have snan_bit_is_one use floatx80.  */
-    assert(!snan_bit_is_one(status));
+    assert(get_snan_rule(status) == float_snan_bit_is_zero);
     a.low |= UINT64_C(0xC000000000000000);
     return a;
 }
@@ -416,11 +391,7 @@ floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
 
 static bool float128_nan_is_snan(float128 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a.high >> 47) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a.high >> 47) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
-- 
2.43.0


