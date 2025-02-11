Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62520C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5O-0006Pc-Jq; Tue, 11 Feb 2025 11:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5J-0006Nu-6T
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:05 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5G-00032D-J8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:04 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4395578be70so6995335e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291161; x=1739895961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E8d1e8v8TaO/4sfmUH381EpDmG22TwqLuybWuGTDe9I=;
 b=xBEtcIQGwOCsRygZ1u8O1OBt9G7xfbW6LMIgLMYLN9YHpIECeAHgCX+LfaeFh/v4uA
 UtzyGq74lYNQjuHj2Z75P1nsjIYPh5Z4opNHzPdbPSSYEa2Ev/wCHBezsLKo+MXPxrMZ
 Xx26IekRSubBYbMvl6cakIBxGrhyvarnhkQUTgJpxbhvaQxhoR52yPRjncWciGsZmhhj
 E74CDp/VHd8s+sSQgIetsL9rNfTSjhnN8RLa7OBwzZrMVJeYH797zbxakWy0MuSx7F3Q
 ST2i3QRgyZc29UaOS3IsPxxTaG3CCf+qRyl72iNqcrObXPYfKAI/gPak9UblQBNOiVNP
 M7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291161; x=1739895961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8d1e8v8TaO/4sfmUH381EpDmG22TwqLuybWuGTDe9I=;
 b=CQd8qz+d97R3KSmMoKzpbOGgkEgyG6nTpyBijRTvNKtxgfuk7AJCver36KoJMtEBd5
 iBTg7DKYNRNt3YLeHBKoJYIgkw+O6kRBOzQ6mKeSpiUxwArJ24ba2EEPM3T4b9tN6yJp
 SkY8aOp6eBkiTgadauJMB0VoxMZE8PSg/3TQXh+lqtCyCYy7f4Orfr/CrZ4tkm/Nkdw5
 M0q+LVowbfVYYd2oN5pJ0qb8X9uZccAQ9u20MeQRoGfuuSJhtYtKjrNWaokIsZD9vePA
 KYRA/J11jEMrMsba6ka+/xufsMEv5yRtSDpMANlnaCLgh6LumXBvr/qIzpEtKxGatzj3
 KWnA==
X-Gm-Message-State: AOJu0Yxti+Sg5Y0gxWdYj04Efh6zUVTvn3L6FKO5rMayC6kxIqtvSIX2
 Yd8Ov6wphHvGSTIqRIJTgsQaUjrNTXFzqLySqL0psEqiTlOgu3/knL0QNjwK8CARJo5kzqyaxKq
 q
X-Gm-Gg: ASbGncvcXtcNrO06CP2y+iOn5eG2XtNFDZvs8V/mKI9MyUC37/7MRMUdy4SxFUcyz0a
 ZW7RTXJbM2w8sWT+GCzN8ofouSWIwiG0aSmaPgxftYYBNvBiwC4kGMS5NMvTkeW36oUQ0AUuTUO
 8KbLz525gr/S7VDX87PXNXOFhaJbOB3sJcKqvs1tStrQ34pXdB0h6ZOcZ7+QTfARzP7tZ3LLhna
 ntwFOf/qPoADuQjPG+I+tfAZGwFvvvqZDZ+xGNqreT4rCPciM5HI60KQni9Ki+Kj/n19zL+x/GU
 FylEVCvfFQ1MSdOKw/Fg
X-Google-Smtp-Source: AGHT+IFLsfBImT9gfsk7rH6ieS30Wa8ZDPFegWEDDKR6m6rzSV2iCIQtsFeeQ6IX10+QK/gt+C4Rlg==
X-Received: by 2002:a05:600c:1ca6:b0:439:5529:33eb with SMTP id
 5b1f17b1804b1-4395529365fmr29827565e9.30.1739291160796; 
 Tue, 11 Feb 2025 08:26:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.25.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:25:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/68] fpu: Implement float_flag_input_denormal_used
Date: Tue, 11 Feb 2025 16:24:49 +0000
Message-Id: <20250211162554.4135349-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

For the x86 and the Arm FEAT_AFP semantics, we need to be able to
tell the target code that the FPU operation has used an input
denormal.  Implement this; when it happens we set the new
float_flag_denormal_input_used.

Note that we only set this when an input denormal is actually used by
the operation: if the operation results in Invalid Operation or
Divide By Zero or the result is a NaN because some other input was a
NaN then we never needed to look at the input denormal and do not set
denormal_input_used.

We mostly do not need to adjust the hardfloat codepaths to deal with
this flag, because almost all hardfloat operations are already gated
on the input not being a denormal, and will fall back to softfloat
for a denormal input.  The only exception is the comparison
operations, where we need to add the check for input denormals, which
must now fall back to softfloat where they did not before.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h |  7 ++++
 fpu/softfloat.c               | 38 +++++++++++++++++---
 fpu/softfloat-parts.c.inc     | 68 ++++++++++++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 2e43d1dd9e6..bba1c397bb7 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -165,6 +165,13 @@ enum {
     float_flag_invalid_sqrt    = 0x0800,  /* sqrt(-x) */
     float_flag_invalid_cvti    = 0x1000,  /* non-nan to integer */
     float_flag_invalid_snan    = 0x2000,  /* any operand was snan */
+    /*
+     * An input was denormal and we used it (without flushing it to zero).
+     * Not set if we do not actually use the denormal input (e.g.
+     * because some other input was a NaN, or because the operation
+     * wasn't actually carried out (divide-by-zero; invalid))
+     */
+    float_flag_input_denormal_used = 0x4000,
 };
 
 /*
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 03a604c38ec..f4fed9bfda9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2718,8 +2718,10 @@ static void parts_float_to_ahp(FloatParts64 *a, float_status *s)
                                   float16_params_ahp.frac_size + 1);
         break;
 
-    case float_class_normal:
     case float_class_denormal:
+        float_raise(float_flag_input_denormal_used, s);
+        break;
+    case float_class_normal:
     case float_class_zero:
         break;
 
@@ -2733,6 +2735,9 @@ static void parts64_float_to_float(FloatParts64 *a, float_status *s)
     if (is_nan(a->cls)) {
         parts_return_nan(a, s);
     }
+    if (a->cls == float_class_denormal) {
+        float_raise(float_flag_input_denormal_used, s);
+    }
 }
 
 static void parts128_float_to_float(FloatParts128 *a, float_status *s)
@@ -2740,6 +2745,9 @@ static void parts128_float_to_float(FloatParts128 *a, float_status *s)
     if (is_nan(a->cls)) {
         parts_return_nan(a, s);
     }
+    if (a->cls == float_class_denormal) {
+        float_raise(float_flag_input_denormal_used, s);
+    }
 }
 
 #define parts_float_to_float(P, S) \
@@ -2752,12 +2760,21 @@ static void parts_float_to_float_narrow(FloatParts64 *a, FloatParts128 *b,
     a->sign = b->sign;
     a->exp = b->exp;
 
-    if (is_anynorm(a->cls)) {
+    switch (a->cls) {
+    case float_class_denormal:
+        float_raise(float_flag_input_denormal_used, s);
+        /* fall through */
+    case float_class_normal:
         frac_truncjam(a, b);
-    } else if (is_nan(a->cls)) {
+        break;
+    case float_class_snan:
+    case float_class_qnan:
         /* Discard the low bits of the NaN. */
         a->frac = b->frac_hi;
         parts_return_nan(a, s);
+        break;
+    default:
+        break;
     }
 }
 
@@ -2772,6 +2789,9 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     if (is_nan(a->cls)) {
         parts_return_nan(a, s);
     }
+    if (a->cls == float_class_denormal) {
+        float_raise(float_flag_input_denormal_used, s);
+    }
 }
 
 float32 float16_to_float32(float16 a, bool ieee, float_status *s)
@@ -4411,7 +4431,11 @@ float32_hs_compare(float32 xa, float32 xb, float_status *s, bool is_quiet)
         goto soft;
     }
 
-    float32_input_flush2(&ua.s, &ub.s, s);
+    if (unlikely(float32_is_denormal(ua.s) || float32_is_denormal(ub.s))) {
+        /* We may need to set the input_denormal_used flag */
+        goto soft;
+    }
+
     if (isgreaterequal(ua.h, ub.h)) {
         if (isgreater(ua.h, ub.h)) {
             return float_relation_greater;
@@ -4461,7 +4485,11 @@ float64_hs_compare(float64 xa, float64 xb, float_status *s, bool is_quiet)
         goto soft;
     }
 
-    float64_input_flush2(&ua.s, &ub.s, s);
+    if (unlikely(float64_is_denormal(ua.s) || float64_is_denormal(ub.s))) {
+        /* We may need to set the input_denormal_used flag */
+        goto soft;
+    }
+
     if (isgreaterequal(ua.h, ub.h)) {
         if (isgreater(ua.h, ub.h)) {
             return float_relation_greater;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 8621cb87185..0122b35008a 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -433,6 +433,15 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
     bool b_sign = b->sign ^ subtract;
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
 
+    /*
+     * For addition and subtraction, we will consume an
+     * input denormal unless the other input is a NaN.
+     */
+    if ((ab_mask & (float_cmask_denormal | float_cmask_anynan)) ==
+        float_cmask_denormal) {
+        float_raise(float_flag_input_denormal_used, s);
+    }
+
     if (a->sign != b_sign) {
         /* Subtraction */
         if (likely(cmask_is_only_normals(ab_mask))) {
@@ -516,6 +525,10 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     if (likely(cmask_is_only_normals(ab_mask))) {
         FloatPartsW tmp;
 
+        if (ab_mask & float_cmask_denormal) {
+            float_raise(float_flag_input_denormal_used, s);
+        }
+
         frac_mulw(&tmp, a, b);
         frac_truncjam(a, &tmp);
 
@@ -541,6 +554,10 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     }
 
     /* Multiply by 0 or Inf */
+    if (ab_mask & float_cmask_denormal) {
+        float_raise(float_flag_input_denormal_used, s);
+    }
+
     if (ab_mask & float_cmask_inf) {
         a->cls = float_class_inf;
         a->sign = sign;
@@ -664,6 +681,16 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
     if (flags & float_muladd_negate_result) {
         a->sign ^= 1;
     }
+
+    /*
+     * All result types except for "return the default NaN
+     * because this is an Invalid Operation" go through here;
+     * this matches the set of cases where we consumed a
+     * denormal input.
+     */
+    if (abc_mask & float_cmask_denormal) {
+        float_raise(float_flag_input_denormal_used, s);
+    }
     return a;
 
  return_sub_zero:
@@ -693,6 +720,9 @@ static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
     bool sign = a->sign ^ b->sign;
 
     if (likely(cmask_is_only_normals(ab_mask))) {
+        if (ab_mask & float_cmask_denormal) {
+            float_raise(float_flag_input_denormal_used, s);
+        }
         a->sign = sign;
         a->exp -= b->exp + frac_div(a, b);
         return a;
@@ -713,6 +743,10 @@ static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
         return parts_pick_nan(a, b, s);
     }
 
+    if ((ab_mask & float_cmask_denormal) && b->cls != float_class_zero) {
+        float_raise(float_flag_input_denormal_used, s);
+    }
+
     a->sign = sign;
 
     /* Inf / X */
@@ -751,6 +785,9 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
 
     if (likely(cmask_is_only_normals(ab_mask))) {
+        if (ab_mask & float_cmask_denormal) {
+            float_raise(float_flag_input_denormal_used, s);
+        }
         frac_modrem(a, b, mod_quot);
         return a;
     }
@@ -771,6 +808,10 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
         return a;
     }
 
+    if (ab_mask & float_cmask_denormal) {
+        float_raise(float_flag_input_denormal_used, s);
+    }
+
     /* N % Inf; 0 % N */
     g_assert(b->cls == float_class_inf || a->cls == float_class_zero);
     return a;
@@ -801,6 +842,10 @@ static void partsN(sqrt)(FloatPartsN *a, float_status *status,
     if (unlikely(a->cls != float_class_normal)) {
         switch (a->cls) {
         case float_class_denormal:
+            if (!a->sign) {
+                /* -ve denormal will be InvalidOperation */
+                float_raise(float_flag_input_denormal_used, status);
+            }
             break;
         case float_class_snan:
         case float_class_qnan:
@@ -1431,6 +1476,9 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
         if ((flags & (minmax_isnum | minmax_isnumber))
             && !(ab_mask & float_cmask_snan)
             && (ab_mask & ~float_cmask_qnan)) {
+            if (ab_mask & float_cmask_denormal) {
+                float_raise(float_flag_input_denormal_used, s);
+            }
             return is_nan(a->cls) ? b : a;
         }
 
@@ -1455,6 +1503,10 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
         return parts_pick_nan(a, b, s);
     }
 
+    if (ab_mask & float_cmask_denormal) {
+        float_raise(float_flag_input_denormal_used, s);
+    }
+
     a_exp = a->exp;
     b_exp = b->exp;
 
@@ -1524,6 +1576,10 @@ static FloatRelation partsN(compare)(FloatPartsN *a, FloatPartsN *b,
     if (likely(cmask_is_only_normals(ab_mask))) {
         FloatRelation cmp;
 
+        if (ab_mask & float_cmask_denormal) {
+            float_raise(float_flag_input_denormal_used, s);
+        }
+
         if (a->sign != b->sign) {
             goto a_sign;
         }
@@ -1549,6 +1605,10 @@ static FloatRelation partsN(compare)(FloatPartsN *a, FloatPartsN *b,
         return float_relation_unordered;
     }
 
+    if (ab_mask & float_cmask_denormal) {
+        float_raise(float_flag_input_denormal_used, s);
+    }
+
     if (ab_mask & float_cmask_zero) {
         if (ab_mask == float_cmask_zero) {
             return float_relation_equal;
@@ -1588,8 +1648,10 @@ static void partsN(scalbn)(FloatPartsN *a, int n, float_status *s)
     case float_class_zero:
     case float_class_inf:
         break;
-    case float_class_normal:
     case float_class_denormal:
+        float_raise(float_flag_input_denormal_used, s);
+        /* fall through */
+    case float_class_normal:
         a->exp += MIN(MAX(n, -0x10000), 0x10000);
         break;
     default:
@@ -1609,6 +1671,10 @@ static void partsN(log2)(FloatPartsN *a, float_status *s, const FloatFmt *fmt)
     if (unlikely(a->cls != float_class_normal)) {
         switch (a->cls) {
         case float_class_denormal:
+            if (!a->sign) {
+                /* -ve denormal will be InvalidOperation */
+                float_raise(float_flag_input_denormal_used, s);
+            }
             break;
         case float_class_snan:
         case float_class_qnan:
-- 
2.34.1


