Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBE2D12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbF-0004Tb-Rb; Tue, 05 Nov 2024 06:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbD-0004Sn-Ov
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:51 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb8-000750-4t
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso45027365e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805578; x=1731410378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4pM4g7JscXIH8rzoftCOwYPedLpbaxY4XzpLuJz9zUQ=;
 b=rZpniMaVMxDFcZ4Ecp4jisDddbMff+jjX02kuSUlbhn5GrivBzrwa0DukNAdciwO4q
 lJfq4HNmTwFqE6P4CB2hqL4qWi6jiOKwUkqDek4khwpuEwscM6ukpl8sYGwn32OpaCRL
 lfKuYXTDcn5l3pKzSykHtE1TIsssyu6lhBcpsLhFStKL8zOQdn7RqAN9wkp5wNePLE5u
 sBgxMRg0GiKQIoWH92MDfbW53xDYgjFtUvcMeDcR4fFMlxRnhcP/UC4EOyn1d5wonrPM
 0f7cZO2hXUzIXPjHiRbSBqoQa/ElGIUQB7zPQOkN2XTnWmVE5yQkT6ugbneoVwBXIUiD
 UHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805578; x=1731410378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4pM4g7JscXIH8rzoftCOwYPedLpbaxY4XzpLuJz9zUQ=;
 b=UYa6jKpQv24LU/PDaKtdH6OmBdDNX1jxnveklegUTjbQP7OPS4ge2S1Cjnlxyv5RE7
 thLWOfc7tJPej3sqQQ6gEP4+0CqVxpPvwXGS+sKpK8WTFfx7AakEZh9CfgTwGI1B5Bi5
 abhLkCd+Bnn7JUAFq/ueLs8ke6DMzdRoR7UVr/fBHGAUmJkMU4k+64wSV7ivWvfdMDYH
 usLtWik8w7qPXP52psi+8fO8Nlw1iSq2owbpC2NR3ryCV5aATdinb2urs1tQD61aqCaf
 FcZM5zOoeZl95W9lvQhm7OkVD1ZoEFyihAu44veVIDCHkizTfu3fjUjrhz8fSwG3bERa
 iw0A==
X-Gm-Message-State: AOJu0YyEDFEs8Hxoot4XAfQv9A27W/+eK4Mrp7xUmELgNvKAXZXpim6k
 SLiy1z/yYyRhdOiHUDezLAQn3DV8dAJBtHAeNSwK/0mSQEFwnPk0vOQe5JO8jMjXoWq+TYm//zN
 g
X-Google-Smtp-Source: AGHT+IHFXqKMVS6UzR4+6ruzvHjcYoyu1XxvXBdTb5rXenqa0TGdRQ7SqY2APqdAJBiDInQdoYA5JA==
X-Received: by 2002:a05:600c:16ca:b0:431:5847:f63f with SMTP id
 5b1f17b1804b1-43283246cb4mr132750125e9.13.1730805578363; 
 Tue, 05 Nov 2024 03:19:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/31] softfloat: Allow 2-operand NaN propagation rule to be
 set at runtime
Date: Tue,  5 Nov 2024 11:19:05 +0000
Message-Id: <20241105111935.2747034-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

IEEE 758 does not define a fixed rule for which NaN to pick as the
result if both operands of a 2-operand operation are NaNs.  As a
result different architectures have ended up with different rules for
propagating NaNs.

QEMU currently hardcodes the NaN propagation logic into the binary
because pickNaN() has an ifdef ladder for different targets.  We want
to make the propagation rule instead be selectable at runtime,
because:
 * this will let us have multiple targets in one QEMU binary
 * the Arm FEAT_AFP architectural feature includes letting
   the guest select a NaN propagation rule at runtime
 * x86 specifies different propagation rules for x87 FPU ops
   and for SSE ops, and specifying the rule in the float_status
   would let us emulate this, instead of wrongly using the
   x87 rules everywhere

In this commit we add an enum for the propagation rule, the field in
float_status, and the corresponding getters and setters.  We change
pickNaN to honour this, but because all targets still leave this
field at its default 0 value, the fallback logic will pick the rule
type with the old ifdef ladder.

It's valid not to set a propagation rule if default_nan_mode is
enabled, because in that case there's no need to pick a NaN; all the
callers of pickNaN() catch this case and skip calling it.  So we can
already assert that we don't get into the "no rule defined" codepath
for our four targets which always set default_nan_mode: Hexagon,
RiscV, SH4 and Tricore, and for the one target which does not have FP
at all: avr.  These targets will not need to be updated to call
set_float_2nan_prop_rule().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-2-peter.maydell@linaro.org
---
 include/fpu/softfloat-helpers.h |  11 ++
 include/fpu/softfloat-types.h   |  42 ++++++
 fpu/softfloat-specialize.c.inc  | 229 ++++++++++++++++++--------------
 3 files changed, 185 insertions(+), 97 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 94cbe073ec5..453188de70b 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -75,6 +75,12 @@ static inline void set_floatx80_rounding_precision(FloatX80RoundPrec val,
     status->floatx80_rounding_precision = val;
 }
 
+static inline void set_float_2nan_prop_rule(Float2NaNPropRule rule,
+                                            float_status *status)
+{
+    status->float_2nan_prop_rule = rule;
+}
+
 static inline void set_flush_to_zero(bool val, float_status *status)
 {
     status->flush_to_zero = val;
@@ -126,6 +132,11 @@ get_floatx80_rounding_precision(float_status *status)
     return status->floatx80_rounding_precision;
 }
 
+static inline Float2NaNPropRule get_float_2nan_prop_rule(float_status *status)
+{
+    return status->float_2nan_prop_rule;
+}
+
 static inline bool get_flush_to_zero(float_status *status)
 {
     return status->flush_to_zero;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 0884ec4ef7a..5cd5a0d0ae1 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -170,6 +170,47 @@ typedef enum __attribute__((__packed__)) {
     floatx80_precision_s,
 } FloatX80RoundPrec;
 
+/*
+ * 2-input NaN propagation rule. Individual architectures have
+ * different rules for which input NaN is propagated to the output
+ * when there is more than one NaN on the input.
+ *
+ * If default_nan_mode is enabled then it is valid not to set a
+ * NaN propagation rule, because the softfloat code guarantees
+ * not to try to pick a NaN to propagate in default NaN mode.
+ *
+ * For transition, currently the 'none' rule will cause us to
+ * fall back to picking the propagation rule based on the existing
+ * ifdef ladder. When all targets are converted it will be an error
+ * not to set the rule in float_status unless in default_nan_mode,
+ * and we will assert if we need to handle an input NaN and no
+ * rule was selected.
+ */
+typedef enum __attribute__((__packed__)) {
+    /* No propagation rule specified */
+    float_2nan_prop_none = 0,
+    /* Prefer SNaN over QNaN, then operand A over B */
+    float_2nan_prop_s_ab,
+    /* Prefer SNaN over QNaN, then operand B over A */
+    float_2nan_prop_s_ba,
+    /* Prefer A over B regardless of SNaN vs QNaN */
+    float_2nan_prop_ab,
+    /* Prefer B over A regardless of SNaN vs QNaN */
+    float_2nan_prop_ba,
+    /*
+     * This implements x87 NaN propagation rules:
+     * SNaN + QNaN => return the QNaN
+     * two SNaNs => return the one with the larger significand, silenced
+     * two QNaNs => return the one with the larger significand
+     * SNaN and a non-NaN => return the SNaN, silenced
+     * QNaN and a non-NaN => return the QNaN
+     *
+     * If we get down to comparing significands and they are the same,
+     * return the NaN with the positive sign bit (if any).
+     */
+    float_2nan_prop_x87,
+} Float2NaNPropRule;
+
 /*
  * Floating Point Status. Individual architectures may maintain
  * several versions of float_status for different functions. The
@@ -181,6 +222,7 @@ typedef struct float_status {
     uint16_t float_exception_flags;
     FloatRoundMode float_rounding_mode;
     FloatX80RoundPrec floatx80_rounding_precision;
+    Float2NaNPropRule float_2nan_prop_rule;
     bool tininess_before_rounding;
     /* should denormalised results go to zero and set the inexact flag? */
     bool flush_to_zero;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 4e279b9bc40..fae6794a152 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -390,118 +390,153 @@ bool float32_is_signaling_nan(float32 a_, float_status *status)
 static int pickNaN(FloatClass a_cls, FloatClass b_cls,
                    bool aIsLargerSignificand, float_status *status)
 {
-#if defined(TARGET_ARM) || defined(TARGET_MIPS) || defined(TARGET_HPPA) || \
-    defined(TARGET_LOONGARCH64) || defined(TARGET_S390X)
-    /* ARM mandated NaN propagation rules (see FPProcessNaNs()), take
-     * the first of:
-     *  1. A if it is signaling
-     *  2. B if it is signaling
-     *  3. A (quiet)
-     *  4. B (quiet)
-     * A signaling NaN is always quietened before returning it.
-     */
-    /* According to MIPS specifications, if one of the two operands is
-     * a sNaN, a new qNaN has to be generated. This is done in
-     * floatXX_silence_nan(). For qNaN inputs the specifications
-     * says: "When possible, this QNaN result is one of the operand QNaN
-     * values." In practice it seems that most implementations choose
-     * the first operand if both operands are qNaN. In short this gives
-     * the following rules:
-     *  1. A if it is signaling
-     *  2. B if it is signaling
-     *  3. A (quiet)
-     *  4. B (quiet)
-     * A signaling NaN is always silenced before returning it.
-     */
-    if (is_snan(a_cls)) {
-        return 0;
-    } else if (is_snan(b_cls)) {
-        return 1;
-    } else if (is_qnan(a_cls)) {
-        return 0;
-    } else {
-        return 1;
-    }
-#elif defined(TARGET_PPC) || defined(TARGET_M68K)
-    /* PowerPC propagation rules:
-     *  1. A if it sNaN or qNaN
-     *  2. B if it sNaN or qNaN
-     * A signaling NaN is always silenced before returning it.
-     */
-    /* M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
-     * 3.4 FLOATING-POINT INSTRUCTION DETAILS
-     * If either operand, but not both operands, of an operation is a
-     * nonsignaling NaN, then that NaN is returned as the result. If both
-     * operands are nonsignaling NaNs, then the destination operand
-     * nonsignaling NaN is returned as the result.
-     * If either operand to an operation is a signaling NaN (SNaN), then the
-     * SNaN bit is set in the FPSR EXC byte. If the SNaN exception enable bit
-     * is set in the FPCR ENABLE byte, then the exception is taken and the
-     * destination is not modified. If the SNaN exception enable bit is not
-     * set, setting the SNaN bit in the operand to a one converts the SNaN to
-     * a nonsignaling NaN. The operation then continues as described in the
-     * preceding paragraph for nonsignaling NaNs.
-     */
-    if (is_nan(a_cls)) {
-        return 0;
-    } else {
-        return 1;
-    }
-#elif defined(TARGET_SPARC)
-    /* Prefer SNaN over QNaN, order B then A. */
-    if (is_snan(b_cls)) {
-        return 1;
-    } else if (is_snan(a_cls)) {
-        return 0;
-    } else if (is_qnan(b_cls)) {
-        return 1;
-    } else {
-        return 0;
-    }
-#elif defined(TARGET_XTENSA)
+    Float2NaNPropRule rule = status->float_2nan_prop_rule;
+
     /*
-     * Xtensa has two NaN propagation modes.
-     * Which one is active is controlled by float_status::use_first_nan.
+     * We guarantee not to require the target to tell us how to
+     * pick a NaN if we're always returning the default NaN.
      */
-    if (status->use_first_nan) {
+    assert(!status->default_nan_mode);
+
+    if (rule == float_2nan_prop_none) {
+        /* target didn't set the rule: fall back to old ifdef choices */
+#if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
+    || defined(TARGET_RISCV) || defined(TARGET_SH4) \
+    || defined(TARGET_TRICORE)
+        g_assert_not_reached();
+#elif defined(TARGET_ARM) || defined(TARGET_MIPS) || defined(TARGET_HPPA) || \
+    defined(TARGET_LOONGARCH64) || defined(TARGET_S390X)
+        /*
+         * ARM mandated NaN propagation rules (see FPProcessNaNs()), take
+         * the first of:
+         *  1. A if it is signaling
+         *  2. B if it is signaling
+         *  3. A (quiet)
+         *  4. B (quiet)
+         * A signaling NaN is always quietened before returning it.
+         */
+        /*
+         * According to MIPS specifications, if one of the two operands is
+         * a sNaN, a new qNaN has to be generated. This is done in
+         * floatXX_silence_nan(). For qNaN inputs the specifications
+         * says: "When possible, this QNaN result is one of the operand QNaN
+         * values." In practice it seems that most implementations choose
+         * the first operand if both operands are qNaN. In short this gives
+         * the following rules:
+         *  1. A if it is signaling
+         *  2. B if it is signaling
+         *  3. A (quiet)
+         *  4. B (quiet)
+         * A signaling NaN is always silenced before returning it.
+         */
+        rule = float_2nan_prop_s_ab;
+#elif defined(TARGET_PPC) || defined(TARGET_M68K)
+        /*
+         * PowerPC propagation rules:
+         *  1. A if it sNaN or qNaN
+         *  2. B if it sNaN or qNaN
+         * A signaling NaN is always silenced before returning it.
+         */
+        /*
+         * M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
+         * 3.4 FLOATING-POINT INSTRUCTION DETAILS
+         * If either operand, but not both operands, of an operation is a
+         * nonsignaling NaN, then that NaN is returned as the result. If both
+         * operands are nonsignaling NaNs, then the destination operand
+         * nonsignaling NaN is returned as the result.
+         * If either operand to an operation is a signaling NaN (SNaN), then the
+         * SNaN bit is set in the FPSR EXC byte. If the SNaN exception enable bit
+         * is set in the FPCR ENABLE byte, then the exception is taken and the
+         * destination is not modified. If the SNaN exception enable bit is not
+         * set, setting the SNaN bit in the operand to a one converts the SNaN to
+         * a nonsignaling NaN. The operation then continues as described in the
+         * preceding paragraph for nonsignaling NaNs.
+         */
+        rule = float_2nan_prop_ab;
+#elif defined(TARGET_SPARC)
+        /* Prefer SNaN over QNaN, order B then A. */
+        rule = float_2nan_prop_s_ba;
+#elif defined(TARGET_XTENSA)
+        /*
+         * Xtensa has two NaN propagation modes.
+         * Which one is active is controlled by float_status::use_first_nan.
+         */
+        if (status->use_first_nan) {
+            rule = float_2nan_prop_ab;
+        } else {
+            rule = float_2nan_prop_ba;
+        }
+#else
+        rule = float_2nan_prop_x87;
+#endif
+    }
+
+    switch (rule) {
+    case float_2nan_prop_s_ab:
+        if (is_snan(a_cls)) {
+            return 0;
+        } else if (is_snan(b_cls)) {
+            return 1;
+        } else if (is_qnan(a_cls)) {
+            return 0;
+        } else {
+            return 1;
+        }
+        break;
+    case float_2nan_prop_s_ba:
+        if (is_snan(b_cls)) {
+            return 1;
+        } else if (is_snan(a_cls)) {
+            return 0;
+        } else if (is_qnan(b_cls)) {
+            return 1;
+        } else {
+            return 0;
+        }
+        break;
+    case float_2nan_prop_ab:
         if (is_nan(a_cls)) {
             return 0;
         } else {
             return 1;
         }
-    } else {
+        break;
+    case float_2nan_prop_ba:
         if (is_nan(b_cls)) {
             return 1;
         } else {
             return 0;
         }
-    }
-#else
-    /* This implements x87 NaN propagation rules:
-     * SNaN + QNaN => return the QNaN
-     * two SNaNs => return the one with the larger significand, silenced
-     * two QNaNs => return the one with the larger significand
-     * SNaN and a non-NaN => return the SNaN, silenced
-     * QNaN and a non-NaN => return the QNaN
-     *
-     * If we get down to comparing significands and they are the same,
-     * return the NaN with the positive sign bit (if any).
-     */
-    if (is_snan(a_cls)) {
-        if (is_snan(b_cls)) {
-            return aIsLargerSignificand ? 0 : 1;
-        }
-        return is_qnan(b_cls) ? 1 : 0;
-    } else if (is_qnan(a_cls)) {
-        if (is_snan(b_cls) || !is_qnan(b_cls)) {
-            return 0;
+        break;
+    case float_2nan_prop_x87:
+        /*
+         * This implements x87 NaN propagation rules:
+         * SNaN + QNaN => return the QNaN
+         * two SNaNs => return the one with the larger significand, silenced
+         * two QNaNs => return the one with the larger significand
+         * SNaN and a non-NaN => return the SNaN, silenced
+         * QNaN and a non-NaN => return the QNaN
+         *
+         * If we get down to comparing significands and they are the same,
+         * return the NaN with the positive sign bit (if any).
+         */
+        if (is_snan(a_cls)) {
+            if (is_snan(b_cls)) {
+                return aIsLargerSignificand ? 0 : 1;
+            }
+            return is_qnan(b_cls) ? 1 : 0;
+        } else if (is_qnan(a_cls)) {
+            if (is_snan(b_cls) || !is_qnan(b_cls)) {
+                return 0;
+            } else {
+                return aIsLargerSignificand ? 0 : 1;
+            }
         } else {
-            return aIsLargerSignificand ? 0 : 1;
+            return 1;
         }
-    } else {
-        return 1;
+    default:
+        g_assert_not_reached();
     }
-#endif
 }
 
 /*----------------------------------------------------------------------------
-- 
2.34.1


