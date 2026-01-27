Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165DCD2594B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkchr-0002o7-JN; Tue, 27 Jan 2026 01:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchp-0002nE-LL
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:41 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchm-0006h3-LW
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:41 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3530715386cso4617572a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495857; x=1770100657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJAV2CCWbII0vWEelDTLF4MqTlLb7xTdhXpTJlFw7us=;
 b=SRnUdnr7YAgNdTisFc34zNMrhajkihDBqH0RpWMVPOPxP98/nuIpmuYJ7ud8c6EbWa
 1vrH5LZE7zBHnZq9tHgeoykhXzxEvImJxga3bxXVFY6aXZXyywWW9KOSq5/VZbLreuqA
 8ov948w1pWYxa/wbdxZupMIXuZCmvFFcF5ZD1rFxWjAGUWzvtrnfe4MQFVCMAPA+EANZ
 C9jCFjgZjArvpI4ekoI6gHbAV/KI/yIx/ScA7s3rMV++lRpY4L6nFoRn6OegoamaSznI
 ywQ9lHef/w3Y+yNxxKDcO4K6vWE23rHZ6X3yOnSY8gxsm24VIvxoVNhjTZZirIV62gY9
 befA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495857; x=1770100657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eJAV2CCWbII0vWEelDTLF4MqTlLb7xTdhXpTJlFw7us=;
 b=YD5Q7PvogDZRRn3wYtVh2lzkf8xGMNlgQ9Jo5YdvTQjCnoNfz3BTkVpOU25owN0s7e
 rK+QecP0ztuS2/04PPtIXty2Wr1f2cNiWE0yFl3cyaVI0KRETimlSyM/b9m1g51UV9s9
 UKclpqAJnUjoK/SremoIcGYqMufSP354sdxKYGp5Y/EkNCnqQF4iTgjHKuP5h2+28t36
 cJu73xyj0wun4/qfMcOJGR9a+HayDllJq3QvASi7ERXG9UbpDE6lflchPeVJqS/x0ZEa
 Cfceau6oE4A/krKJN+42TkonoBw+jhdkTUucki6f/9cRRun6d38rGrm5hAC9YwOOdt5C
 HFFA==
X-Gm-Message-State: AOJu0YzdZfKSiupt7hJSM0inUThf0IN3txzL5b5T4sZnr5BRa22/nu9/
 zHeRK6bKywU1DA3BYdf5kNwnRJEOw99+8DwCbrgR1vcM+nzqo+aJbaD8lHb7oBCFy50F7wsNGQI
 9cLAvzOG3NQgpbLTDw3p4PPChHFh/cVpVjQGLoCeImVkMzYrQC+SGeLdP3oVqgKAJe6lsDGHPAK
 5jPk35BYAEOV1NaQVLfnxG2sb8AedM9NXgppQxhK0rUQ==
X-Gm-Gg: AZuq6aKTQMuCkLrhlZDuOCz4FuDOGl4RxjBKM00yzD51L4Bd4n77YM9c1Q2ShSqw2hO
 RzI/bWVUbKttBROWyUOreN3iR0ZV2X44fNdljrdGLRyRmq/1lSwX9d4Nve/W75ujYPRa4Ki+vFX
 PVClYpjgtsEFovYVhcWwa2/DtNXx0vw79rNoP3ul+oZUL7MtyDsZQeLVAKAmNK40HuV9kNERB42
 RpDVGSZuB8l1KFfCotkEikP+vOv/UHfwCfz6YnHbcGpQdFyHar18zvxvxS9JqyPDKmeYYlC32rq
 LLCva59PiVxgCV/DNSNy+cNaYuQ2IRlz/WT/UOMeI5NMsQozQbSqJoFxw/v+82lq7vbeSM4N6au
 m+1GbnN7RMknUuT6jNF+JsjdZD1sTsojIIaH7pQ5Fc4vLjCns5+UJq89v8eiHTNRtLuGWkRGhBw
 hMJjiGZn0mQEiOfn+AZpyhln/3HGq9/6Yc7BmCV4b23zUHoPWnW1yxsAukLLP5n3n63qyYy4qPa
 XdOaKUk0zgEZek=
X-Received: by 2002:a17:90b:498e:b0:32e:7270:9499 with SMTP id
 98e67ed59e1d1-353febb9623mr837231a91.0.1769495856851; 
 Mon, 26 Jan 2026 22:37:36 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:37:36 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 03/17] fpu/softfloat: Support OCP(Open Compute Project)
 OFP8 data type
Date: Tue, 27 Jan 2026 14:37:09 +0800
Message-ID: <20260127063723.442734-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This commit provides the implementation defined behavior flags and the basic
operation support for the OCP float8 data types(E4M3 & E5M2).

According to the definition in OFP8 spec, the conversion from a wider
format infinity depends on the saturation mode defined in the spec.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat-parts.c.inc      | 159 +++++++++++++++++++++------
 fpu/softfloat-specialize.c.inc |  75 +++++++++++++
 fpu/softfloat.c                | 191 +++++++++++++++++++++++++++++++--
 include/fpu/softfloat-types.h  |  12 +++
 include/fpu/softfloat.h        |  81 ++++++++++++++
 5 files changed, 480 insertions(+), 38 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5e0438fc0b..eee7daae4d 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -227,11 +227,28 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
             p->exp = fmt->frac_shift - fmt->exp_bias
                    - shift + !has_pseudo_denormals;
         }
-    } else if (likely(p->exp < fmt->exp_max) || fmt->arm_althp) {
+    } else if (likely(p->exp < fmt->exp_max)) {
         p->cls = float_class_normal;
         p->exp -= fmt->exp_bias;
         frac_shl(p, fmt->frac_shift);
         p->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
+    } else if (fmt->limited_nan) {
+        /*
+         * Formats with limited NaN encodings (E4M3, E2M1, ARM Alt HP).
+         */
+        frac_shl(p, fmt->frac_shift);
+        p->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
+        if (fmt->normal_frac_max == NORMAL_FRAC_MAX_ALL ||
+            p->frac_hi <= fmt->normal_frac_max) {
+            p->cls = float_class_normal;
+            p->exp -= fmt->exp_bias;
+        } else {
+            if (parts_is_snan_frac(p->frac_hi, status)) {
+                p->cls = float_class_snan;
+            } else {
+                p->cls = float_class_qnan;
+            }
+        }
     } else if (likely(frac_eqz(p))) {
         p->cls = float_class_inf;
     } else {
@@ -241,14 +258,39 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
     }
 }
 
+/*
+ * Set FloatPartsN to the maximum normal value for the given format.
+ * - IEEE formats (!no_infinity): exp = exp_max - 1, frac = all ones
+ * - Limited NaN formats (E4M3): exp = exp_max, frac = normal_frac_max
+ * - No NaN/InF formats (E2M1, ARM AHP): exp = exp_max, frac = all ones
+ */
+static void partsN(set_max_normal)(FloatPartsN *p, const FloatFmt *fmt)
+{
+    if (!fmt->no_infinity) {
+        p->exp = fmt->exp_max - 1;
+        frac_allones(p);
+    } else if (fmt->normal_frac_max != NORMAL_FRAC_MAX_ALL) {
+        p->exp = fmt->exp_max;
+        frac_clear(p);
+        p->frac_hi = fmt->normal_frac_max;
+    } else {
+        p->exp = fmt->exp_max;
+        frac_allones(p);
+    }
+}
+
 /*
  * Round and uncanonicalize a floating-point number by parts. There
  * are FRAC_SHIFT bits that may require rounding at the bottom of the
  * fraction; these bits will be removed. The exponent will be biased
  * by EXP_BIAS and must be bounded by [EXP_MAX-1, 0].
+ *
+ * The saturate parameter controls saturation behavior for formats that
+ * support it (OCP FP8 E4M3/E5M2). When true, overflow produces max normal
+ * instead of infinity (E5M2) or NaN (E4M3).
  */
 static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
-                                   const FloatFmt *fmt)
+                                   const FloatFmt *fmt, bool saturate)
 {
     const int exp_max = fmt->exp_max;
     const int frac_shift = fmt->frac_shift;
@@ -256,8 +298,8 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
     const uint64_t frac_lsb = round_mask + 1;
     const uint64_t frac_lsbm1 = round_mask ^ (round_mask >> 1);
     const uint64_t roundeven_mask = round_mask | frac_lsb;
+    bool overflow_norm = saturate;
     uint64_t inc;
-    bool overflow_norm = false;
     int exp, flags = 0;
 
     switch (s->float_rounding_mode) {
@@ -313,30 +355,64 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             }
             p->frac_lo &= ~round_mask;
         }
+        p->exp = exp;
 
-        if (fmt->arm_althp) {
-            /* ARM Alt HP eschews Inf and NaN for a wider exponent.  */
-            if (unlikely(exp > exp_max)) {
-                /* Overflow.  Return the maximum normal.  */
-                flags = float_flag_invalid;
-                exp = exp_max;
-                frac_allones(p);
-                p->frac_lo &= ~round_mask;
+        /*
+         * Unified overflow handling based on format capabilities.
+         * 1. Format has infinity -> overflow to infinity (or saturate)
+         * 2. Format has NaN but no infinity -> overflow to NaN (or saturate)
+         * 3. Format has neither -> always saturate
+         */
+        if (!fmt->no_infinity) {
+            if (unlikely(exp >= exp_max)) {
+                flags |= float_flag_overflow;
+                if (s->rebias_overflow) {
+                    exp -= fmt->exp_re_bias;
+                } else if (overflow_norm) {
+                    flags |= float_flag_inexact;
+                    parts_set_max_normal(p, fmt);
+                    exp = p->exp;
+                    p->frac_lo &= ~round_mask;
+                } else {
+                    flags |= float_flag_inexact;
+                    p->cls = float_class_inf;
+                    exp = exp_max;
+                    frac_clear(p);
+                }
             }
-        } else if (unlikely(exp >= exp_max)) {
-            flags |= float_flag_overflow;
-            if (s->rebias_overflow) {
-                exp -= fmt->exp_re_bias;
-            } else if (overflow_norm) {
+        } else if (fmt_has_nan_encoding(fmt)) {
+            bool is_overflow = (exp > exp_max) ||
+                               (exp == exp_max &&
+                                p->frac_hi > fmt->normal_frac_max);
+
+            if (unlikely(is_overflow)) {
+                flags |= float_flag_overflow;
                 flags |= float_flag_inexact;
-                exp = exp_max - 1;
-                frac_allones(p);
+
+                if (overflow_norm) {
+                    parts_set_max_normal(p, fmt);
+                    exp = p->exp;
+                } else {
+                    uint8_t dnan = s->default_nan_pattern;
+                    p->cls = float_class_qnan;
+                    p->sign = dnan >> 7;
+                    exp = exp_max;
+                    frac_allones(p);
+                }
+            }
+        } else {
+            if (unlikely(exp > exp_max)) {
+                if (fmt->overflow_raises_invalid) {
+                    /* ARM Alt HP: raise Invalid, not Overflow */
+                    flags = float_flag_invalid;
+                } else {
+                    flags |= float_flag_overflow;
+                    flags |= float_flag_inexact;
+                }
+
+                parts_set_max_normal(p, fmt);
+                exp = p->exp;
                 p->frac_lo &= ~round_mask;
-            } else {
-                flags |= float_flag_inexact;
-                p->cls = float_class_inf;
-                exp = exp_max;
-                frac_clear(p);
             }
         }
         frac_shr(p, frac_shift);
@@ -422,11 +498,11 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
     float_raise(flags, s);
 }
 
-static void partsN(uncanon)(FloatPartsN *p, float_status *s,
-                            const FloatFmt *fmt)
+static void partsN(uncanon_sat)(FloatPartsN *p, float_status *s,
+                                const FloatFmt *fmt, bool saturate)
 {
     if (likely(is_anynorm(p->cls))) {
-        parts_uncanon_normal(p, s, fmt);
+        parts_uncanon_normal(p, s, fmt, saturate);
     } else {
         switch (p->cls) {
         case float_class_zero:
@@ -434,13 +510,30 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
             frac_clear(p);
             return;
         case float_class_inf:
-            g_assert(!fmt->arm_althp);
-            p->exp = fmt->exp_max;
-            frac_clear(p);
+            /*
+             * Unified infinity handling using format capabilities.
+             * Formats with no_infinity must convert infinity to something else
+             */
+            if (!fmt->no_infinity) {
+                p->exp = fmt->exp_max;
+                frac_clear(p);
+            } else if (fmt_has_nan_encoding(fmt)) {
+                if (saturate) {
+                    parts_set_max_normal(p, fmt);
+                } else {
+                    uint8_t dnan = s->default_nan_pattern;
+                    p->cls = float_class_qnan;
+                    p->sign = dnan >> 7;
+                    p->exp = fmt->exp_max;
+                    frac_allones(p);
+                }
+            } else {
+                parts_set_max_normal(p, fmt);
+            }
             return;
         case float_class_qnan:
         case float_class_snan:
-            g_assert(!fmt->arm_althp);
+            g_assert(fmt_has_nan_encoding(fmt));
             p->exp = fmt->exp_max;
             frac_shr(p, fmt->frac_shift);
             return;
@@ -451,6 +544,12 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
     }
 }
 
+static void partsN(uncanon)(FloatPartsN *p, float_status *s,
+                            const FloatFmt *fmt)
+{
+    partsN(uncanon_sat)(p, s, fmt, false);
+}
+
 /*
  * Returns the result of adding or subtracting the values of the
  * floating-point values `a' and `b'. The operation is performed
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index ce7315c996..3648dc7467 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -242,6 +242,63 @@ static bool float16_is_snan_internal(float16 a, float_status *status)
     return frac_msb == snan_bit_is_one(status);
 }
 
+/*----------------------------------------------------------------------------
+| Internal helper: Determine if E4M3 NaN is signaling.
+| E4M3 has only one NaN encoding, so classification is policy-based.
+*----------------------------------------------------------------------------*/
+
+static bool float8_e4m3_is_snan_internal(float8_e4m3 a, float_status *status)
+{
+    if (!float8_e4m3_is_any_nan(a)) {
+        return false;
+    }
+    if (no_signaling_nans(status)) {
+        return false;
+    }
+    return snan_bit_is_one(status);
+}
+
+/*----------------------------------------------------------------------------
+| Internal helper: Determine if E5M2 NaN is signaling.
+*----------------------------------------------------------------------------*/
+
+static bool float8_e5m2_is_snan_internal(float8_e5m2 a, float_status *status)
+{
+    if (!float8_e5m2_is_any_nan(a)) {
+        return false;
+    }
+    if (no_signaling_nans(status)) {
+        return false;
+    }
+    uint8_t frac = float8_e5m2_val(a) & 0x3;
+    bool frac_msb = (frac >> 1) & 1;
+    return frac_msb == snan_bit_is_one(status);
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the OCP FP8 E4M3 value `a' is a quiet NaN; otherwise returns 0.
+*----------------------------------------------------------------------------*/
+
+bool float8_e4m3_is_quiet_nan(float8_e4m3 a_, float_status *status)
+{
+    if (!float8_e4m3_is_any_nan(a_)) {
+        return false;
+    }
+    return !float8_e4m3_is_snan_internal(a_, status);
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the OCP FP8 E5M2 value `a' is a quiet NaN; otherwise returns 0.
+*----------------------------------------------------------------------------*/
+
+bool float8_e5m2_is_quiet_nan(float8_e5m2 a_, float_status *status)
+{
+    if (!float8_e5m2_is_any_nan(a_)) {
+        return false;
+    }
+    return !float8_e5m2_is_snan_internal(a_, status);
+}
+
 /*----------------------------------------------------------------------------
 | Returns 1 if the half-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
@@ -285,6 +342,24 @@ bool bfloat16_is_quiet_nan(bfloat16 a_, float_status *status)
     return !bfloat16_is_snan_internal(a_, status);
 }
 
+/*----------------------------------------------------------------------------
+| Returns 1 if the OCP FP8 E4M3 value `a' is a signaling NaN; otherwise 0.
+*----------------------------------------------------------------------------*/
+
+bool float8_e4m3_is_signaling_nan(float8_e4m3 a_, float_status *status)
+{
+    return float8_e4m3_is_snan_internal(a_, status);
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the OCP FP8 E5M2 value `a' is a signaling NaN; otherwise 0.
+*----------------------------------------------------------------------------*/
+
+bool float8_e5m2_is_signaling_nan(float8_e5m2 a_, float_status *status)
+{
+    return float8_e5m2_is_snan_internal(a_, status);
+}
+
 /*----------------------------------------------------------------------------
 | Returns 1 if the half-precision floating-point value `a' is a signaling
 | NaN; otherwise returns 0.
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8094358c2e..533f96dcda 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -522,6 +522,13 @@ typedef struct {
 #define DECOMPOSED_BINARY_POINT    63
 #define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
 
+/*
+ * Sentinel value for normal_frac_max indicating "all fraction values at
+ * exp_max are normal" (i.e., the format has no NaN encoding at exp_max).
+ * Used by E2M1 and ARM Alternative Half Precision formats.
+ */
+#define NORMAL_FRAC_MAX_ALL        0
+
 /* Structure holding all of the relevant parameters for a format.
  *   exp_size: the size of the exponent field
  *   exp_bias: the offset applied to the exponent field
@@ -542,11 +549,39 @@ typedef struct {
     int exp_max;
     int frac_size;
     int frac_shift;
-    bool arm_althp;
     bool has_explicit_bit;
     uint64_t round_mask;
+    /*
+     * Format capability flags:
+     * no_infinity: Format has no infinity encoding. When true, exp=exp_max
+     *   with frac=0 is NOT infinity - it's either NaN or max normal.
+     *
+     * limited_nan: Format has limited or no NaN patterns. When combined
+     *   with normal_frac_max, determines NaN encoding capability:
+     *   - limited_nan=false: Standard IEEE NaN (exp=exp_max, frac!=0)
+     *   - limited_nan=true && normal_frac_max!=0: Limited NaN (E4M3)
+     *   - limited_nan=true && normal_frac_max==0: No NaN encoding (AHP, E2M1)
+     *
+     * overflow_raises_invalid: Raise Invalid (not Overflow) exception.
+     *   ARM Alt HP uses this to signal overflow as an invalid operation.
+     *
+     * normal_frac_max: For formats with limited_nan, the maximum fraction
+     *   value (after normalization shift, including implicit bit) that is
+     *   still considered normal at exp=exp_max.
+     *   Use NORMAL_FRAC_MAX_ALL (0) to indicate all frac values at exp_max
+     *   are normal (E2M1, ARM Alt HP), which also implies no NaN encoding.
+     */
+    bool no_infinity;
+    bool limited_nan;
+    bool overflow_raises_invalid;
+    uint64_t normal_frac_max;
 } FloatFmt;
 
+static inline bool fmt_has_nan_encoding(const FloatFmt *fmt)
+{
+    return !fmt->limited_nan || fmt->normal_frac_max != NORMAL_FRAC_MAX_ALL;
+}
+
 /* Expand fields based on the size of exponent and fraction */
 #define FLOAT_PARAMS_(E)                                \
     .exp_size       = E,                                \
@@ -560,13 +595,27 @@ typedef struct {
     .frac_shift     = (-F - 1) & 63,                    \
     .round_mask     = (1ull << ((-F - 1) & 63)) - 1
 
+static const FloatFmt float8_e4m3_params = {
+    FLOAT_PARAMS(4, 3),
+    .no_infinity = true,
+    .limited_nan = true,
+    .normal_frac_max = 0xE000000000000000ULL,
+};
+
+static const FloatFmt float8_e5m2_params = {
+    FLOAT_PARAMS(5, 2),
+};
+
 static const FloatFmt float16_params = {
     FLOAT_PARAMS(5, 10)
 };
 
 static const FloatFmt float16_params_ahp = {
     FLOAT_PARAMS(5, 10),
-    .arm_althp = true
+    .no_infinity = true,
+    .limited_nan = true,
+    .overflow_raises_invalid = true,
+    .normal_frac_max = NORMAL_FRAC_MAX_ALL,
 };
 
 static const FloatFmt bfloat16_params = {
@@ -614,6 +663,16 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
     };
 }
 
+static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
+{
+    unpack_raw64(p, &float8_e4m3_params, f);
+}
+
+static void QEMU_FLATTEN float8_e5m2_unpack_raw(FloatParts64 *p, float8_e5m2 f)
+{
+    unpack_raw64(p, &float8_e5m2_params, f);
+}
+
 static void QEMU_FLATTEN float16_unpack_raw(FloatParts64 *p, float16 f)
 {
     unpack_raw64(p, &float16_params, f);
@@ -671,6 +730,16 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
+static float8_e4m3 QEMU_FLATTEN float8_e4m3_pack_raw(const FloatParts64 *p)
+{
+    return make_float8_e4m3(pack_raw64(p, &float8_e4m3_params));
+}
+
+static float8_e5m2 QEMU_FLATTEN float8_e5m2_pack_raw(const FloatParts64 *p)
+{
+    return make_float8_e5m2(pack_raw64(p, &float8_e5m2_params));
+}
+
 static float16 QEMU_FLATTEN float16_pack_raw(const FloatParts64 *p)
 {
     return make_float16(pack_raw64(p, &float16_params));
@@ -758,12 +827,26 @@ static void parts128_canonicalize(FloatParts128 *p, float_status *status,
     PARTS_GENERIC_64_128(canonicalize, A)(A, S, F)
 
 static void parts64_uncanon_normal(FloatParts64 *p, float_status *status,
-                                   const FloatFmt *fmt);
+                                   const FloatFmt *fmt, bool saturate);
 static void parts128_uncanon_normal(FloatParts128 *p, float_status *status,
-                                    const FloatFmt *fmt);
+                                    const FloatFmt *fmt, bool saturate);
+
+#define parts_uncanon_normal(A, S, F, SAT) \
+    PARTS_GENERIC_64_128(uncanon_normal, A)(A, S, F, SAT)
 
-#define parts_uncanon_normal(A, S, F) \
-    PARTS_GENERIC_64_128(uncanon_normal, A)(A, S, F)
+static void parts64_uncanon_sat(FloatParts64 *p, float_status *status,
+                                const FloatFmt *fmt, bool saturate);
+static void parts128_uncanon_sat(FloatParts128 *p, float_status *status,
+                                 const FloatFmt *fmt, bool saturate);
+
+#define parts_uncanon_sat(A, S, F, SAT) \
+    PARTS_GENERIC_64_128(uncanon_sat, A)(A, S, F, SAT)
+
+static void parts64_set_max_normal(FloatParts64 *p, const FloatFmt *fmt);
+static void parts128_set_max_normal(FloatParts128 *p, const FloatFmt *fmt);
+
+#define parts_set_max_normal(P, F) \
+    PARTS_GENERIC_64_128(set_max_normal, P)(P, F)
 
 static void parts64_uncanon(FloatParts64 *p, float_status *status,
                             const FloatFmt *fmt);
@@ -1662,6 +1745,20 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
+static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
+                                         float_status *s)
+{
+    float8_e4m3_unpack_raw(p, f);
+    parts_canonicalize(p, s, &float8_e4m3_params);
+}
+
+static void float8_e5m2_unpack_canonical(FloatParts64 *p, float8_e5m2 f,
+                                         float_status *s)
+{
+    float8_e5m2_unpack_raw(p, f);
+    parts_canonicalize(p, s, &float8_e5m2_params);
+}
+
 static void float16a_unpack_canonical(FloatParts64 *p, float16 f,
                                       float_status *s, const FloatFmt *params)
 {
@@ -1682,6 +1779,24 @@ static void bfloat16_unpack_canonical(FloatParts64 *p, bfloat16 f,
     parts_canonicalize(p, s, &bfloat16_params);
 }
 
+static float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p,
+                                                    float_status *status,
+                                                    const FloatFmt *params,
+                                                    const bool saturate)
+{
+    parts_uncanon_sat(p, status, params, saturate);
+    return float8_e4m3_pack_raw(p);
+}
+
+static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
+                                                    float_status *status,
+                                                    const FloatFmt *params,
+                                                    const bool saturate)
+{
+    parts_uncanon_sat(p, status, params, saturate);
+    return float8_e5m2_pack_raw(p);
+}
+
 static float16 float16a_round_pack_canonical(FloatParts64 *p,
                                              float_status *s,
                                              const FloatFmt *params)
@@ -1838,7 +1953,7 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
     case float_class_normal:
     case float_class_denormal:
         if (s->floatx80_rounding_precision == floatx80_precision_x) {
-            parts_uncanon_normal(p, s, fmt);
+            parts_uncanon_normal(p, s, fmt, false);
             frac = p->frac_hi;
             exp = p->exp;
         } else {
@@ -1847,7 +1962,7 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
             p64.sign = p->sign;
             p64.exp = p->exp;
             frac_truncjam(&p64, p);
-            parts_uncanon_normal(&p64, s, fmt);
+            parts_uncanon_normal(&p64, s, fmt, false);
             frac = p64.frac;
             exp = p64.exp;
         }
@@ -2823,6 +2938,66 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     }
 }
 
+bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
+{
+    FloatParts64 p;
+
+    float8_e4m3_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+
+    return bfloat16_round_pack_canonical(&p, s);
+}
+
+bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, float_status *s)
+{
+    FloatParts64 p;
+
+    float8_e5m2_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+
+    return bfloat16_round_pack_canonical(&p, s);
+}
+
+float8_e4m3 bfloat16_to_float8_e4m3(bfloat16 a, bool saturate, float_status *s)
+{
+    FloatParts64 p;
+
+    bfloat16_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return float8_e4m3_round_pack_canonical(&p, s, &float8_e4m3_params,
+                                            saturate);
+}
+
+float8_e5m2 bfloat16_to_float8_e5m2(bfloat16 a, bool saturate, float_status *s)
+{
+    FloatParts64 p;
+
+    bfloat16_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return float8_e5m2_round_pack_canonical(&p, s, &float8_e5m2_params,
+                                            saturate);
+}
+
+float8_e4m3 float32_to_float8_e4m3(float32 a, bool saturate, float_status *s)
+{
+    FloatParts64 p;
+
+    float32_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return float8_e4m3_round_pack_canonical(&p, s, &float8_e4m3_params,
+                                            saturate);
+}
+
+float8_e5m2 float32_to_float8_e5m2(float32 a, bool saturate, float_status *s)
+{
+    FloatParts64 p;
+
+    float32_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return float8_e5m2_round_pack_canonical(&p, s, &float8_e5m2_params,
+                                            saturate);
+}
+
 float32 float16_to_float32(float16 a, bool ieee, float_status *s)
 {
     const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 8f82fdfc97..b781bf10b7 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -119,6 +119,18 @@ typedef struct {
  */
 typedef uint16_t bfloat16;
 
+/*
+ * Software OCP(Open Compute Project) floating point types
+ */
+typedef uint8_t float8_e4m3;
+typedef uint8_t float8_e5m2;
+#define float8_e4m3_val(x) (x)
+#define float8_e5m2_val(x) (x)
+#define make_float8_e4m3(x) (x)
+#define make_float8_e5m2(x) (x)
+#define const_float8_e4m3(x) (x)
+#define const_float8_e5m2(x) (x)
+
 /*
  * Software IEC/IEEE floating-point underflow tininess-detection mode.
  */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index c18ab2cb60..30aca23057 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -189,6 +189,87 @@ float128 int128_to_float128(Int128, float_status *status);
 float128 uint64_to_float128(uint64_t, float_status *status);
 float128 uint128_to_float128(Int128, float_status *status);
 
+/*----------------------------------------------------------------------------
+| Software OCP conversion routines.
+*----------------------------------------------------------------------------*/
+
+bfloat16 float8_e4m3_to_bfloat16(float8_e4m3, float_status *status);
+bfloat16 float8_e5m2_to_bfloat16(float8_e5m2, float_status *status);
+float8_e4m3 bfloat16_to_float8_e4m3(bfloat16, bool saturate, float_status *status);
+float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, bool saturate, float_status *status);
+float8_e4m3 float32_to_float8_e4m3(float32, bool saturate, float_status *status);
+float8_e5m2 float32_to_float8_e5m2(float32, bool saturate, float_status *status);
+
+/*----------------------------------------------------------------------------
+| Software OCP operations.
+*----------------------------------------------------------------------------*/
+
+bool float8_e4m3_is_quiet_nan(float8_e4m3, float_status *status);
+bool float8_e4m3_is_signaling_nan(float8_e4m3, float_status *status);
+bool float8_e5m2_is_quiet_nan(float8_e5m2, float_status *status);
+bool float8_e5m2_is_signaling_nan(float8_e5m2, float_status *status);
+
+static inline bool float8_e4m3_is_any_nan(float8_e4m3 a)
+{
+    return ((float8_e4m3_val(a) & ~0x80) == 0x7f);
+}
+
+static inline bool float8_e5m2_is_any_nan(float8_e5m2 a)
+{
+    return ((float8_e5m2_val(a) & ~0x80) > 0x7c);
+}
+
+static inline bool float8_e4m3_is_neg(float8_e4m3 a)
+{
+    return float8_e4m3_val(a) >> 7;
+}
+
+static inline bool float8_e5m2_is_neg(float8_e5m2 a)
+{
+    return float8_e5m2_val(a) >> 7;
+}
+
+static inline bool float8_e4m3_is_infinity(float8_e4m3 a)
+{
+    return false;
+}
+
+static inline bool float8_e5m2_is_infinity(float8_e5m2 a)
+{
+    return (float8_e5m2_val(a) & 0x7f) == 0x7c;
+}
+
+static inline bool float8_e4m3_is_zero(float8_e4m3 a)
+{
+    return (float8_e4m3_val(a) & 0x7f) == 0;
+}
+
+static inline bool float8_e5m2_is_zero(float8_e5m2 a)
+{
+    return (float8_e5m2_val(a) & 0x7f) == 0;
+}
+
+static inline bool float8_e4m3_is_zero_or_denormal(float8_e4m3 a)
+{
+    return (float8_e4m3_val(a) & 0x78) == 0;
+}
+
+static inline bool float8_e5m2_is_zero_or_denormal(float8_e5m2 a)
+{
+    return (float8_e5m2_val(a) & 0x7c) == 0;
+}
+
+static inline bool float8_e4m3_is_normal(float8_e4m3 a)
+{
+    uint8_t em = float8_e4m3_val(a) & 0x7f;
+    return em >= 0x8 && em <= 0x7e;
+}
+
+static inline bool float8_e5m2_is_normal(float8_e5m2 a)
+{
+    return (((float8_e5m2_val(a) >> 2) + 1) & 0x1f) >= 2;
+}
+
 /*----------------------------------------------------------------------------
 | Software half-precision conversion routines.
 *----------------------------------------------------------------------------*/
-- 
2.52.0


