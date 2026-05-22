Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EEACD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUas-0004ir-Of; Fri, 22 May 2026 14:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUam-0004e7-Aa
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:28 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUai-0005HG-O0
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:28 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c828daf83e2so3599719a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474443; x=1780079243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AIP97JpAti9CBhJAGj5cYJK7hFfMC9+CjBTqIhrsE0Q=;
 b=nymvdQFNc5spAiydrbZSRMQ+Iewy2jA8tEKhyVEn/CKcfAgzKv6/C8P9PQIrEGP7c8
 uMmux2x/mx3ebdZ9GETa6bm4Gp/ciIc0CNIOErzvN5t/1s1rEbmYjZC1m9Vj9UKbPB5D
 FfJUhbz0Qmj2rSDC0f3j0+UZBafRK01MSSFyQeA5vxahNTwjXC8Cc0DpU/NpFsx1XC+Z
 FfziUu5pumqPEWM+X9iwYnLaJA7TPELK57d5l71yRWCeue2d+Ty7NldvygwlQiv1cs8l
 b2TZVnz/W5UzyS4IxnX6ZQR9lG/qD3gAFLHCjoGJ005iG30YMMMPGLuqw5RKgo+lJcFm
 Xf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474443; x=1780079243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AIP97JpAti9CBhJAGj5cYJK7hFfMC9+CjBTqIhrsE0Q=;
 b=VjfOd4Enw8BS1evrxFAjM+0LmhIIre9ska0NLfCsaa+5wLPdcDugmCmQkZb4iaI+Jk
 NOw7SHNyZEBZXcl0hkDJckEw/C6rYLY7D5Cq5AXjv+w9Ezbne37BEzAir5K3INHG4Umi
 mKEnNKzfr+z8inIal269oO3tLssOSE+b41gZBkFPF4n2W10xWumODzLlreDFSjpa6QDp
 TjXdp+oWMoLOTgKSFc2h2yTIRrrT9qizFYyJaq+nEvcLqy0ljUT1uwUISMUX4aZSxDgN
 WW2RwJmhh8tpjtGJDq83M1FhYohUYhVT8HZL+15/QlyX3+Cfy84gIcQjrxpsPwKVVBeP
 WlkA==
X-Gm-Message-State: AOJu0YxWvmMnw0gO8ZVp5CZm42U2caME2gf/yJas6Y7JHDeZVn1eXNW0
 jcT8Dczo5yxPvZspWXY5AvEdcmiZe5MwC5/74emSk/Jgh07PlQ76ziUTiPPtyc91vF3c4JtFsg7
 f9sD9
X-Gm-Gg: Acq92OGWKSKuz/Xdj+/GjqYUblWxdW5l4upnv0Az2MhTiSnZ52Vysn8pcVnllkcZ8Tq
 5NECZ6Ach6ZPsPjkswwGVc/QUhFDwZ5W5/YAvm7tmzgHG5QZWkReJmNt8/34vNxEAP63dLZn3pT
 XEgIwgm/FGBZQNIlHj1buGy++2+qhqG9cXo3zp1nFJaacMWGWbG5JC1txS99B25aal4ggYPwggr
 CkWb4lMyRVP8ZVZh14W1CihKgPOI2sjN2HZaxSR6r2V5CUt3yqF5XjstseZyRAJ6reFdFGQAnu/
 4nxkEUWKNCqAGBwwGhWXW2Wbtcrd5/9OFWf/JbuLzdAyBFWlOrFfrpKFGuSyo1bA9WFI1GbLPaG
 1gS9SUD+b/+J1geUT0JwLLCO10PgZRmTqBqLDCLynWMI0ShIcCuoxlE++xcJL4OsW7XE99YCkFd
 SRKBotyR3CFlS8xj708n7m57lpup/1/b+7LI70IjE=
X-Received: by 2002:a17:903:2bcc:b0:2bc:b80f:677e with SMTP id
 d9443c01a7336-2beb069970bmr49615995ad.25.1779474442938; 
 Fri, 22 May 2026 11:27:22 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/30] fpu: Reorganize partsN(muladd)
Date: Fri, 22 May 2026 11:26:30 -0700
Message-ID: <20260522182658.184604-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Check the likely case of normal product and normal or
zero addend first; shift NaN and infinity detection down;
end with zero product + addend.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 156 +++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 85 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 3a9c2748cd..ca2d7a15c9 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -681,11 +681,47 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
                                    FloatPartsN *c,
                                    int flags, float_status *s)
 {
-    int ab_mask, abc_mask;
-    FloatPartsW p_widen, c_widen;
+    int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
+    int c_mask = float_cmask(c->cls);
+    int abc_mask = ab_mask | c_mask;
+    bool c_sign = c->sign ^ !!(flags & float_muladd_negate_c);
+    bool p_sign = a->sign ^ b->sign ^ !!(flags & float_muladd_negate_product);
 
-    ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
-    abc_mask = float_cmask(c->cls) | ab_mask;
+    /*
+     * The "likely" case is A and B normal, so that the product is normal,
+     * and C normal or zero so that the result is normal.
+     */
+    int likely_mask = ab_mask | (c_mask & ~float_cmask_zero);
+    if (likely(cmask_is_only_normals(likely_mask))) {
+        record_denormals_used(abc_mask, s);
+
+        /* Perform the multiplication step. */
+        FloatPartsW p_widen = { .sign = p_sign, .exp = a->exp + b->exp + 1 };
+        fracN(mulw)(&p_widen, a, b);
+        if (!(p_widen.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
+            fracW(add)(&p_widen, &p_widen, &p_widen);
+            p_widen.exp -= 1;
+        }
+
+        /* Perform the addition step. */
+        if (!(c_mask & float_cmask_zero)) {
+            /* Zero-extend C to less significant bits. */
+            FloatPartsW c_widen = { .sign = c_sign, .exp = c->exp };
+            fracN(widen)(&c_widen, c);
+
+            if (p_sign == c_sign) {
+                partsW(add_normal)(&p_widen, &c_widen);
+            } else if (!partsW(sub_normal)(&p_widen, &c_widen)) {
+                goto return_sub_zero;
+            }
+        }
+
+        /* Narrow with sticky bit, for proper rounding later. */
+        fracN(truncjam)(a, &p_widen);
+        a->sign = p_widen.sign;
+        a->exp = p_widen.exp;
+        return a;
+    }
 
     /*
      * It is implementation-defined whether the cases of (0,inf,qnan)
@@ -698,97 +734,47 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
         return a;
     }
 
-    if (flags & float_muladd_negate_c) {
-        c->sign ^= 1;
+    if (unlikely(ab_mask == float_cmask_infzero)) {
+        /* Inf * Zero == NaN */
+        float_raise(float_flag_invalid | float_flag_invalid_imz, s);
+        goto d_nan;
     }
 
-    /* Compute the sign of the product into A. */
-    a->sign ^= b->sign;
-    if (flags & float_muladd_negate_product) {
-        a->sign ^= 1;
-    }
-
-    if (unlikely(!cmask_is_only_normals(ab_mask))) {
-        if (unlikely(ab_mask == float_cmask_infzero)) {
-            float_raise(float_flag_invalid | float_flag_invalid_imz, s);
+    if (unlikely(ab_mask & float_cmask_inf)) {
+        if ((c_mask & float_cmask_inf) && p_sign != c_sign) {
+            /* Inf - Inf == NaN */
+            float_raise(float_flag_invalid | float_flag_invalid_isi, s);
             goto d_nan;
         }
-
-        if (ab_mask & float_cmask_inf) {
-            if (c->cls == float_class_inf && a->sign != c->sign) {
-                float_raise(float_flag_invalid | float_flag_invalid_isi, s);
-                goto d_nan;
-            }
-            goto return_inf;
-        }
-
-        g_assert(ab_mask & float_cmask_zero);
-        if (is_anynorm(c->cls)) {
-            *a = *c;
-            goto finish_sign;
-        }
-        if (c->cls == float_class_zero) {
-            if (flags & float_muladd_suppress_add_product_zero) {
-                a->sign = c->sign;
-            } else if (a->sign != c->sign) {
-                goto return_sub_zero;
-            }
-            goto return_zero;
-        }
-        g_assert(c->cls == float_class_inf);
+        /* Inf + C == Inf */
+        record_denormals_used(abc_mask, s);
+        a->sign = p_sign;
+        a->cls = float_class_inf;
+        return a;
     }
-
-    if (unlikely(c->cls == float_class_inf)) {
-        a->sign = c->sign;
-        goto return_inf;
-    }
-
-    /* Perform the multiplication step. */
-    p_widen.sign = a->sign;
-    p_widen.exp = a->exp + b->exp + 1;
-    fracN(mulw)(&p_widen, a, b);
-    if (!(p_widen.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
-        fracW(add)(&p_widen, &p_widen, &p_widen);
-        p_widen.exp -= 1;
-    }
-
-    /* Perform the addition step. */
-    if (c->cls != float_class_zero) {
-        /* Zero-extend C to less significant bits. */
-        fracN(widen)(&c_widen, c);
-        c_widen.exp = c->exp;
-
-        if (a->sign == c->sign) {
-            partsW(add_normal)(&p_widen, &c_widen);
-        } else if (!partsW(sub_normal)(&p_widen, &c_widen)) {
-            goto return_sub_zero;
-        }
-    }
-
-    /* Narrow with sticky bit, for proper rounding later. */
-    fracN(truncjam)(a, &p_widen);
-    a->sign = p_widen.sign;
-    a->exp = p_widen.exp;
-
- finish_sign:
-    /*
-     * All result types except for "return the default NaN
-     * because this is an Invalid Operation" go through here;
-     * this matches the set of cases where we consumed a
-     * denormal input.
-     */
     record_denormals_used(abc_mask, s);
-    return a;
+
+    /* Only remaining cases are zero product or inf addend. */
+    assert((ab_mask & float_cmask_zero) | (c_mask & float_cmask_inf));
+
+    /*
+     * P + Inf == Inf, or
+     * 0 + C == C,
+     * except for 0 - 0, which needs special rounding,
+     * except for when we want to suppress this addition step.
+     */
+    if (!(c_mask & float_cmask_zero)
+        || p_sign == c_sign
+        || (flags & float_muladd_suppress_add_product_zero)) {
+        c->sign = c_sign;
+        return c;
+    }
 
  return_sub_zero:
+    /* 0 - 0 == -0 for round_down, +0 otherwise. */
     a->sign = s->float_rounding_mode == float_round_down;
- return_zero:
     a->cls = float_class_zero;
-    goto finish_sign;
-
- return_inf:
-    a->cls = float_class_inf;
-    goto finish_sign;
+    return a;
 
  d_nan:
     *a = partsN(default_nan)(s);
-- 
2.43.0


