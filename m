Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA87C021A2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht77-0001CM-SS; Tue, 11 Feb 2025 11:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5t-0006hY-4e
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:41 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5n-0003Dw-AM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:39 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43955067383so6057405e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291194; x=1739895994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fcOgI7vhIXtBt2XJpHxK/BLOHfcQfWg+SKFhYv1eqLo=;
 b=aAAq2t/kmsUt0ThIuAP/JQPC3rIrMOav1q9T48yeKo1wRdAUyaC5w8Cp8gRHQ2IkRE
 WNOad/9qWShBIzg/P6pVVxunUqQ1lsZn6m6fBrQ+z+gPDQa8tUGz6Cnqjvf00gihxXIb
 fMRTGg0OQN5HDiYtmzl5Fsv2/paBU5HbFYDAW4ZJKw+pVXc8EQ/cGHlSGQvflf+C+T+z
 QE3Cb7jPYAIwKD3P1oDuRl1gqPVOgtEWKJl4VN62g4NlUmU5CEduHgk22LHhQ0u5AhK/
 BIQ4GrKLzbMuND8VE3ktEdLd9ysv2hhQ6BP4bJeN3BH3zVfbYO9PwB5467hB2NiJCmPI
 NAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291194; x=1739895994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fcOgI7vhIXtBt2XJpHxK/BLOHfcQfWg+SKFhYv1eqLo=;
 b=oxzFB2LjATcwwK0ZhsAjxiBH+XlZ7B9cc/HmOQIG9MRM+HcGAQcRTYblf3qk48r0bp
 Mndof4ub62Pbm6OYvZxFngIB7h7Jk3X9v8TRIfMTinj1b1g/8HtB11320gwV97H3oHjE
 8vSbcf2N66PjXo/DmcKDM/QzpWu+a4e8ZKccjkpPnHsboAwMAP19QqtyUKrbs7xI+XAT
 xNQWd5JwJWnrXQaqMQ7yqltIi4oEOObhblhD62p2COs8Juq8SQsaI3oif8pFiy97E8DV
 /d2yyMsjX1tMw111UMeY/i0KYHaBQzodnzovFyvV12BY6euDWzeDM9oMU80KlcVj8Fr0
 bMZg==
X-Gm-Message-State: AOJu0Yxgz4QMgot/7ryctK3UE07xvbkpttKvwxnr52oo9ydmHyanB4RY
 42UccILcphc4W1779wDOIp1wq9dXeJ+nWegofoHaFy5jKptd8L3a6Dov1xeEf3sokZOG9y+DLhO
 i
X-Gm-Gg: ASbGnctxxlQa1AgZtUTIZMUw9Gc953Kr0ynqGX7oQb/jrd0Iw0Nvcr83WbbmV6tme+W
 IbwWVuaC10gkMQSFS3r6rRSflmcQlUt9qZMfcRvxnrg63czzkYMmtvBSqIa0XP2V53/8ZVJ73GY
 RteQ24xdJc79g5q9jZCOVRyq0dOoZHJ2uBb9kqrzqL9Hd8fqhphbpozCgW3Nh6itgapyVQBtQLy
 I4FUdzhF01bP2mCe2RpX4R+TDo9brduN1TKK+ua2HOleKadaBhK9dqCn40mGH9Ums0eCU7EjTAA
 UHZHcgUbdXFeNZ8MRjo4
X-Google-Smtp-Source: AGHT+IG6FamDUbVvVFl1SueQs+DP1DjOZpHhYWTuldIyekfSJDN/azRTzOQV2+BCbcO1k79M5XJzQA==
X-Received: by 2002:a05:600c:310f:b0:439:4700:9eb1 with SMTP id
 5b1f17b1804b1-4394c807906mr42017505e9.2.1739291193768; 
 Tue, 11 Feb 2025 08:26:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/68] target/arm: Handle FPCR.AH in negation steps in SVE FCADD
Date: Tue, 11 Feb 2025 16:25:22 +0000
Message-Id: <20250211162554.4135349-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The negation steps in FCADD must honour FPCR.AH's "don't change the
sign of a NaN" semantics.  Implement this in the same way we did for
the base ASIMD FCADD, by encoding FPCR.AH into the SIMD data field
passed to the helper and using that to decide whether to negate the
values.

The construction of neg_imag and neg_real were done to make it easy
to apply both in parallel with two simple logical operations.  This
changed with FPCR.AH, which is more complex than that. Switch to
an approach that follows the pseudocode more closely, by extracting
the 'rot=1' parameter from the SIMD data field and changing the
sign of the appropriate input value.

Note that there was a naming issue with neg_imag and neg_real.
They were named backward, with neg_imag being non-zero for rot=1,
and vice versa.  This was combined with reversed usage within the
loop, so that the negation in the end turned out correct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h  | 17 ++++++++++++++
 target/arm/tcg/sve_helper.c    | 42 ++++++++++++++++++++++++----------
 target/arm/tcg/translate-sve.c |  2 +-
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 094f5c169ca..826791523a6 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -20,6 +20,8 @@
 #ifndef TARGET_ARM_VEC_INTERNAL_H
 #define TARGET_ARM_VEC_INTERNAL_H
 
+#include "fpu/softfloat.h"
+
 /*
  * Note that vector data is stored in host-endian 64-bit chunks,
  * so addressing units smaller than that needs a host-endian fixup.
@@ -265,4 +267,19 @@ float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
  */
 bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp);
 
+static inline float16 float16_maybe_ah_chs(float16 a, bool fpcr_ah)
+{
+    return fpcr_ah && float16_is_any_nan(a) ? a : float16_chs(a);
+}
+
+static inline float32 float32_maybe_ah_chs(float32 a, bool fpcr_ah)
+{
+    return fpcr_ah && float32_is_any_nan(a) ? a : float32_chs(a);
+}
+
+static inline float64 float64_maybe_ah_chs(float64 a, bool fpcr_ah)
+{
+    return fpcr_ah && float64_is_any_nan(a) ? a : float64_chs(a);
+}
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 8527a7495a6..770945a2c6a 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5131,8 +5131,8 @@ void HELPER(sve_fcadd_h)(void *vd, void *vn, void *vm, void *vg,
 {
     intptr_t j, i = simd_oprsz(desc);
     uint64_t *g = vg;
-    float16 neg_imag = float16_set_sign(0, simd_data(desc));
-    float16 neg_real = float16_chs(neg_imag);
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5144,9 +5144,15 @@ void HELPER(sve_fcadd_h)(void *vd, void *vn, void *vm, void *vg,
             i -= 2 * sizeof(float16);
 
             e0 = *(float16 *)(vn + H1_2(i));
-            e1 = *(float16 *)(vm + H1_2(j)) ^ neg_real;
+            e1 = *(float16 *)(vm + H1_2(j));
             e2 = *(float16 *)(vn + H1_2(j));
-            e3 = *(float16 *)(vm + H1_2(i)) ^ neg_imag;
+            e3 = *(float16 *)(vm + H1_2(i));
+
+            if (rot) {
+                e3 = float16_maybe_ah_chs(e3, fpcr_ah);
+            } else {
+                e1 = float16_maybe_ah_chs(e1, fpcr_ah);
+            }
 
             if (likely((pg >> (i & 63)) & 1)) {
                 *(float16 *)(vd + H1_2(i)) = float16_add(e0, e1, s);
@@ -5163,8 +5169,8 @@ void HELPER(sve_fcadd_s)(void *vd, void *vn, void *vm, void *vg,
 {
     intptr_t j, i = simd_oprsz(desc);
     uint64_t *g = vg;
-    float32 neg_imag = float32_set_sign(0, simd_data(desc));
-    float32 neg_real = float32_chs(neg_imag);
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5176,9 +5182,15 @@ void HELPER(sve_fcadd_s)(void *vd, void *vn, void *vm, void *vg,
             i -= 2 * sizeof(float32);
 
             e0 = *(float32 *)(vn + H1_2(i));
-            e1 = *(float32 *)(vm + H1_2(j)) ^ neg_real;
+            e1 = *(float32 *)(vm + H1_2(j));
             e2 = *(float32 *)(vn + H1_2(j));
-            e3 = *(float32 *)(vm + H1_2(i)) ^ neg_imag;
+            e3 = *(float32 *)(vm + H1_2(i));
+
+            if (rot) {
+                e3 = float32_maybe_ah_chs(e3, fpcr_ah);
+            } else {
+                e1 = float32_maybe_ah_chs(e1, fpcr_ah);
+            }
 
             if (likely((pg >> (i & 63)) & 1)) {
                 *(float32 *)(vd + H1_2(i)) = float32_add(e0, e1, s);
@@ -5195,8 +5207,8 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
 {
     intptr_t j, i = simd_oprsz(desc);
     uint64_t *g = vg;
-    float64 neg_imag = float64_set_sign(0, simd_data(desc));
-    float64 neg_real = float64_chs(neg_imag);
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5208,9 +5220,15 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
             i -= 2 * sizeof(float64);
 
             e0 = *(float64 *)(vn + H1_2(i));
-            e1 = *(float64 *)(vm + H1_2(j)) ^ neg_real;
+            e1 = *(float64 *)(vm + H1_2(j));
             e2 = *(float64 *)(vn + H1_2(j));
-            e3 = *(float64 *)(vm + H1_2(i)) ^ neg_imag;
+            e3 = *(float64 *)(vm + H1_2(i));
+
+            if (rot) {
+                e3 = float64_maybe_ah_chs(e3, fpcr_ah);
+            } else {
+                e1 = float64_maybe_ah_chs(e1, fpcr_ah);
+            }
 
             if (likely((pg >> (i & 63)) & 1)) {
                 *(float64 *)(vd + H1_2(i)) = float64_add(e0, e1, s);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 0d8bd1a49c4..7816b5801af 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3916,7 +3916,7 @@ static gen_helper_gvec_4_ptr * const fcadd_fns[] = {
     gen_helper_sve_fcadd_s, gen_helper_sve_fcadd_d,
 };
 TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
-           a->rd, a->rn, a->rm, a->pg, a->rot,
+           a->rd, a->rn, a->rm, a->pg, a->rot | (s->fpcr_ah << 1),
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 #define DO_FMLA(NAME, name) \
-- 
2.34.1


