Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB81C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mnO-0000ss-4L; Sun, 05 May 2024 21:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmt-0008OQ-I5
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:07 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmQ-0002Xd-1p
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:03 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f44bcbaae7so1089212b3a.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957471; x=1715562271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5LFuok2jxUbiWgmM2Sy0JqIQDVEXKHKAdB9OyP0pIk=;
 b=Kz0KYu9cEhON2xPi72DWbuSVZAUz3Rt9CzAaOu6mJp1mRajKpefBkC1xvXDliBJdVv
 Nf9+da5Yep6bVvllikJ07iLt6NYUUrHXBGV8XGBp9xZf/2w5d1uEjA4KckUgA/KxizWx
 X01xGIm4bXgUFlg1j1mhBoLuJu874WmENA8a1yNloBENIM7HrlMjhv1aMP9/j76EroMm
 zWUJ7mpxUYLOEH15oSJfeHdfnfyt4pYe5I3gIhF2t0mKcBwkQTAneLoYMctPMbShZPtK
 5IMAS+XDpDR4W/IaA4EG7UvrwesMXB/CWQHGbKIv6ZfYpKegeOy4In3aURIz8EmOuBac
 deSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957471; x=1715562271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S5LFuok2jxUbiWgmM2Sy0JqIQDVEXKHKAdB9OyP0pIk=;
 b=IljlD42nDlw3eZaT5bIO8QMJBKhkqP/N6XAzmQZJYuUcVuLonVLQCm7B2HO6Y91jIf
 29gtbkrsFAMjM3ah+hOprOCTSuPBdQ6vzyRg5BQhAFi4mR8Ul1q+d4hHg74FV+119O+I
 Ekg0D4uTrdUY80WLujiujuayoSYnxyX3gdK210RARSocxk+8o2Z4i+5UIvCAIb+3glaX
 XPylQKwpYOPE36Ni35Cqm1uoTB2MeyiyFksrXzGimchhzjtjqRAew/dswQfTa1n4U8SI
 +Ra9loWsERaIJ+U16zbgGd+8gK37NAgbiU3BNExkEEGKPmNhwwm4m/byxtLoCqhVzCxH
 y+Nw==
X-Gm-Message-State: AOJu0Yx3UeEp7iWevT9p1hCFfYsh4Fji3Y9TSbOEVCndtTrDZJYjUMfu
 oReBw6/ZCuKBudiVL/tgGd6xR+JzsHZDRsmZYNLH6aaU9tK3fKnlm/szRb83he8ZyKW2Uffcnoq
 5
X-Google-Smtp-Source: AGHT+IGCn1vrLZkiiZa5adeWQcjGcmTUDLIjqnbAuU1qWNxr+Xyu1QgKKPhpWZoPJAhGCxi1fJaXEQ==
X-Received: by 2002:a05:6a20:dd88:b0:1aa:590a:9668 with SMTP id
 kw8-20020a056a20dd8800b001aa590a9668mr6964148pzb.51.1714957471496; 
 Sun, 05 May 2024 18:04:31 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 32/57] target/arm: Inline scalar SUQADD and USQADD
Date: Sun,  5 May 2024 18:03:38 -0700
Message-Id: <20240506010403.6204-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

This eliminates the last uses of these neon helpers.
Incorporate the MO_64 expanders as an option to the vector expander.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |   8 --
 target/arm/tcg/translate-a64.h |   8 ++
 target/arm/tcg/gengvec64.c     |  71 ++++++++++++++
 target/arm/tcg/neon_helper.c   | 165 ---------------------------------
 target/arm/tcg/translate-a64.c |  73 +++++----------
 5 files changed, 103 insertions(+), 222 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index de2c5c9aef..c76158d6d3 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -274,14 +274,6 @@ DEF_HELPER_FLAGS_3(neon_qadd_u16, TCG_CALL_NO_RWG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(neon_qadd_s16, TCG_CALL_NO_RWG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(neon_qadd_u32, TCG_CALL_NO_RWG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(neon_qadd_s32, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_uqadd_s8, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_uqadd_s16, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_uqadd_s32, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_uqadd_s64, TCG_CALL_NO_RWG, i64, env, i64, i64)
-DEF_HELPER_FLAGS_3(neon_sqadd_u8, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_sqadd_u16, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_sqadd_u32, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_sqadd_u64, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_3(neon_qsub_u8, i32, env, i32, i32)
 DEF_HELPER_3(neon_qsub_s8, i32, env, i32, i32)
 DEF_HELPER_3(neon_qsub_u16, i32, env, i32, i32)
diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index b5cb26f8a2..0fcf7cb63a 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -197,9 +197,17 @@ void gen_gvec_eor3(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
                    uint32_t a, uint32_t oprsz, uint32_t maxsz);
 void gen_gvec_bcax(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
                    uint32_t a, uint32_t oprsz, uint32_t maxsz);
+
+void gen_suqadd_bhs(TCGv_i64 res, TCGv_i64 qc,
+                    TCGv_i64 a, TCGv_i64 b, MemOp esz);
+void gen_suqadd_d(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b);
 void gen_gvec_suqadd_qc(unsigned vece, uint32_t rd_ofs,
                         uint32_t rn_ofs, uint32_t rm_ofs,
                         uint32_t opr_sz, uint32_t max_sz);
+
+void gen_usqadd_bhs(TCGv_i64 res, TCGv_i64 qc,
+                    TCGv_i64 a, TCGv_i64 b, MemOp esz);
+void gen_usqadd_d(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b);
 void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
                         uint32_t rn_ofs, uint32_t rm_ofs,
                         uint32_t opr_sz, uint32_t max_sz);
diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
index 201a719bc1..876abadd76 100644
--- a/target/arm/tcg/gengvec64.c
+++ b/target/arm/tcg/gengvec64.c
@@ -188,6 +188,38 @@ void gen_gvec_bcax(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
 }
 
+/*
+ * Set @res to the correctly saturated result.
+ * Set @qc non-zero if saturation occured.
+ */
+void gen_suqadd_bhs(TCGv_i64 res, TCGv_i64 qc,
+                    TCGv_i64 a, TCGv_i64 b, MemOp esz)
+{
+    TCGv_i64 max = tcg_constant_i64((1ull << ((8 << esz) - 1)) - 1);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_add_i64(t, a, b);
+    tcg_gen_smin_i64(res, t, max);
+    tcg_gen_xor_i64(t, t, res);
+    tcg_gen_or_i64(qc, qc, t);
+}
+
+void gen_suqadd_d(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 max = tcg_constant_i64(INT64_MAX);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    /* Maximum value that can be added to @a without overflow. */
+    tcg_gen_sub_i64(t, max, a);
+
+    /* Constrain addend so that the next addition never overflows. */
+    tcg_gen_umin_i64(t, t, b);
+    tcg_gen_add_i64(res, a, t);
+
+    tcg_gen_xor_i64(t, t, b);
+    tcg_gen_or_i64(qc, qc, t);
+}
+
 static void gen_suqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                            TCGv_vec a, TCGv_vec b)
 {
@@ -231,6 +263,7 @@ void gen_gvec_suqadd_qc(unsigned vece, uint32_t rd_ofs,
           .write_aofs = true,
           .vece = MO_32 },
         { .fniv = gen_suqadd_vec,
+          .fni8 = gen_suqadd_d,
           .fno = gen_helper_gvec_suqadd_d,
           .opt_opc = vecop_list,
           .write_aofs = true,
@@ -240,6 +273,43 @@ void gen_gvec_suqadd_qc(unsigned vece, uint32_t rd_ofs,
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
+void gen_usqadd_bhs(TCGv_i64 res, TCGv_i64 qc,
+                    TCGv_i64 a, TCGv_i64 b, MemOp esz)
+{
+    TCGv_i64 max = tcg_constant_i64(MAKE_64BIT_MASK(0, 8 << esz));
+    TCGv_i64 zero = tcg_constant_i64(0);
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_add_i64(tmp, a, b);
+    tcg_gen_smin_i64(res, tmp, max);
+    tcg_gen_smax_i64(res, res, zero);
+    tcg_gen_xor_i64(tmp, tmp, res);
+    tcg_gen_or_i64(qc, qc, tmp);
+}
+
+void gen_usqadd_d(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv_i64 tneg = tcg_temp_new_i64();
+    TCGv_i64 tpos = tcg_temp_new_i64();
+    TCGv_i64 max = tcg_constant_i64(UINT64_MAX);
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    tcg_gen_add_i64(tmp, a, b);
+
+    /* If @b is positive, saturate if (a + b) < a, aka unsigned overflow. */
+    tcg_gen_movcond_i64(TCG_COND_LTU, tpos, tmp, a, max, tmp);
+
+    /* If @b is negative, saturate if a < -b, ie subtraction is negative. */
+    tcg_gen_neg_i64(tneg, b);
+    tcg_gen_movcond_i64(TCG_COND_LTU, tneg, a, tneg, zero, tmp);
+
+    /* Select correct result from sign of @b. */
+    tcg_gen_movcond_i64(TCG_COND_LT, res, b, zero, tneg, tpos);
+    tcg_gen_xor_i64(tmp, tmp, res);
+    tcg_gen_or_i64(qc, qc, tmp);
+}
+
 static void gen_usqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                            TCGv_vec a, TCGv_vec b)
 {
@@ -286,6 +356,7 @@ void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
           .write_aofs = true,
           .vece = MO_32 },
         { .fniv = gen_usqadd_vec,
+          .fni8 = gen_usqadd_d,
           .fno = gen_helper_gvec_usqadd_d,
           .opt_opc = vecop_list,
           .write_aofs = true,
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index a0b51c8809..9505a5fd18 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -236,171 +236,6 @@ uint64_t HELPER(neon_qadd_s64)(CPUARMState *env, uint64_t src1, uint64_t src2)
     return res;
 }
 
-/* Unsigned saturating accumulate of signed value
- *
- * Op1/Rn is treated as signed
- * Op2/Rd is treated as unsigned
- *
- * Explicit casting is used to ensure the correct sign extension of
- * inputs. The result is treated as a unsigned value and saturated as such.
- *
- * We use a macro for the 8/16 bit cases which expects signed integers of va,
- * vb, and vr for interim calculation and an unsigned 32 bit result value r.
- */
-
-#define USATACC(bits, shift) \
-    do { \
-        va = sextract32(a, shift, bits);                                \
-        vb = extract32(b, shift, bits);                                 \
-        vr = va + vb;                                                   \
-        if (vr > UINT##bits##_MAX) {                                    \
-            SET_QC();                                                   \
-            vr = UINT##bits##_MAX;                                      \
-        } else if (vr < 0) {                                            \
-            SET_QC();                                                   \
-            vr = 0;                                                     \
-        }                                                               \
-        r = deposit32(r, shift, bits, vr);                              \
-   } while (0)
-
-uint32_t HELPER(neon_uqadd_s8)(CPUARMState *env, uint32_t a, uint32_t b)
-{
-    int16_t va, vb, vr;
-    uint32_t r = 0;
-
-    USATACC(8, 0);
-    USATACC(8, 8);
-    USATACC(8, 16);
-    USATACC(8, 24);
-    return r;
-}
-
-uint32_t HELPER(neon_uqadd_s16)(CPUARMState *env, uint32_t a, uint32_t b)
-{
-    int32_t va, vb, vr;
-    uint64_t r = 0;
-
-    USATACC(16, 0);
-    USATACC(16, 16);
-    return r;
-}
-
-#undef USATACC
-
-uint32_t HELPER(neon_uqadd_s32)(CPUARMState *env, uint32_t a, uint32_t b)
-{
-    int64_t va = (int32_t)a;
-    int64_t vb = (uint32_t)b;
-    int64_t vr = va + vb;
-    if (vr > UINT32_MAX) {
-        SET_QC();
-        vr = UINT32_MAX;
-    } else if (vr < 0) {
-        SET_QC();
-        vr = 0;
-    }
-    return vr;
-}
-
-uint64_t HELPER(neon_uqadd_s64)(CPUARMState *env, uint64_t a, uint64_t b)
-{
-    uint64_t res;
-    res = a + b;
-    /* We only need to look at the pattern of SIGN bits to detect
-     * +ve/-ve saturation
-     */
-    if (~a & b & ~res & SIGNBIT64) {
-        SET_QC();
-        res = UINT64_MAX;
-    } else if (a & ~b & res & SIGNBIT64) {
-        SET_QC();
-        res = 0;
-    }
-    return res;
-}
-
-/* Signed saturating accumulate of unsigned value
- *
- * Op1/Rn is treated as unsigned
- * Op2/Rd is treated as signed
- *
- * The result is treated as a signed value and saturated as such
- *
- * We use a macro for the 8/16 bit cases which expects signed integers of va,
- * vb, and vr for interim calculation and an unsigned 32 bit result value r.
- */
-
-#define SSATACC(bits, shift) \
-    do { \
-        va = extract32(a, shift, bits);                                 \
-        vb = sextract32(b, shift, bits);                                \
-        vr = va + vb;                                                   \
-        if (vr > INT##bits##_MAX) {                                     \
-            SET_QC();                                                   \
-            vr = INT##bits##_MAX;                                       \
-        } else if (vr < INT##bits##_MIN) {                              \
-            SET_QC();                                                   \
-            vr = INT##bits##_MIN;                                       \
-        }                                                               \
-        r = deposit32(r, shift, bits, vr);                              \
-    } while (0)
-
-uint32_t HELPER(neon_sqadd_u8)(CPUARMState *env, uint32_t a, uint32_t b)
-{
-    int16_t va, vb, vr;
-    uint32_t r = 0;
-
-    SSATACC(8, 0);
-    SSATACC(8, 8);
-    SSATACC(8, 16);
-    SSATACC(8, 24);
-    return r;
-}
-
-uint32_t HELPER(neon_sqadd_u16)(CPUARMState *env, uint32_t a, uint32_t b)
-{
-    int32_t va, vb, vr;
-    uint32_t r = 0;
-
-    SSATACC(16, 0);
-    SSATACC(16, 16);
-
-    return r;
-}
-
-#undef SSATACC
-
-uint32_t HELPER(neon_sqadd_u32)(CPUARMState *env, uint32_t a, uint32_t b)
-{
-    int64_t res;
-    int64_t op1 = (uint32_t)a;
-    int64_t op2 = (int32_t)b;
-    res = op1 + op2;
-    if (res > INT32_MAX) {
-        SET_QC();
-        res = INT32_MAX;
-    } else if (res < INT32_MIN) {
-        SET_QC();
-        res = INT32_MIN;
-    }
-    return res;
-}
-
-uint64_t HELPER(neon_sqadd_u64)(CPUARMState *env, uint64_t a, uint64_t b)
-{
-    uint64_t res;
-    res = a + b;
-    /* We only need to look at the pattern of SIGN bits to detect an overflow */
-    if (((a & res)
-         | (~b & res)
-         | (a & ~b)) & SIGNBIT64) {
-        SET_QC();
-        res = INT64_MAX;
-    }
-    return res;
-}
-
-
 #define NEON_USAT(dest, src1, src2, type) do { \
     uint32_t tmp = (uint32_t)src1 - (uint32_t)src2; \
     if (tmp != (type)tmp) { \
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f221c71c8e..a8fd22f3e9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9979,67 +9979,42 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
 static void handle_2misc_satacc(DisasContext *s, bool is_scalar, bool is_u,
                                 bool is_q, unsigned size, int rn, int rd)
 {
+    TCGv_i64 res, qc, a, b;
+
     if (!is_scalar) {
         gen_gvec_fn3(s, is_q, rd, rd, rn,
                      is_u ? gen_gvec_usqadd_qc : gen_gvec_suqadd_qc, size);
         return;
     }
 
-    if (size == 3) {
-        TCGv_i64 tcg_rn = tcg_temp_new_i64();
-        TCGv_i64 tcg_rd = tcg_temp_new_i64();
+    res = tcg_temp_new_i64();
+    qc = tcg_temp_new_i64();
+    a = tcg_temp_new_i64();
+    b = tcg_temp_new_i64();
 
-        read_vec_element(s, tcg_rn, rn, 0, MO_64);
-        read_vec_element(s, tcg_rd, rd, 0, MO_64);
+    /* Read and extend scalar inputs to 64-bits. */
+    read_vec_element(s, a, rd, 0, size | (is_u ? 0 : MO_SIGN));
+    read_vec_element(s, b, rn, 0, size | (is_u ? MO_SIGN : 0));
+    tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
 
-        if (is_u) { /* USQADD */
-            gen_helper_neon_uqadd_s64(tcg_rd, tcg_env, tcg_rn, tcg_rd);
-        } else { /* SUQADD */
-            gen_helper_neon_sqadd_u64(tcg_rd, tcg_env, tcg_rn, tcg_rd);
+    if (size == MO_64) {
+        if (is_u) {
+            gen_usqadd_d(res, qc, a, b);
+        } else {
+            gen_suqadd_d(res, qc, a, b);
         }
-        write_vec_element(s, tcg_rd, rd, 0, MO_64);
-        clear_vec_high(s, false, rd);
     } else {
-        TCGv_i32 tcg_rn = tcg_temp_new_i32();
-        TCGv_i32 tcg_rd = tcg_temp_new_i32();
-
-        read_vec_element_i32(s, tcg_rn, rn, 0, size);
-        read_vec_element_i32(s, tcg_rd, rd, 0, size);
-
-        if (is_u) { /* USQADD */
-            switch (size) {
-            case 0:
-                gen_helper_neon_uqadd_s8(tcg_rd, tcg_env, tcg_rn, tcg_rd);
-                break;
-            case 1:
-                gen_helper_neon_uqadd_s16(tcg_rd, tcg_env, tcg_rn, tcg_rd);
-                break;
-            case 2:
-                gen_helper_neon_uqadd_s32(tcg_rd, tcg_env, tcg_rn, tcg_rd);
-                break;
-            default:
-                g_assert_not_reached();
-            }
-        } else { /* SUQADD */
-            switch (size) {
-            case 0:
-                gen_helper_neon_sqadd_u8(tcg_rd, tcg_env, tcg_rn, tcg_rd);
-                break;
-            case 1:
-                gen_helper_neon_sqadd_u16(tcg_rd, tcg_env, tcg_rn, tcg_rd);
-                break;
-            case 2:
-                gen_helper_neon_sqadd_u32(tcg_rd, tcg_env, tcg_rn, tcg_rd);
-                break;
-            default:
-                g_assert_not_reached();
-            }
+        if (is_u) {
+            gen_usqadd_bhs(res, qc, a, b, size);
+        } else {
+            gen_suqadd_bhs(res, qc, a, b, size);
+            /* Truncate signed 64-bit result for writeback. */
+            tcg_gen_ext_i64(res, res, size);
         }
-
-        write_vec_element(s, tcg_constant_i64(0), rd, 0, MO_64);
-        write_vec_element_i32(s, tcg_rd, rd, 0, MO_32);
-        clear_vec_high(s, false, rd);
     }
+
+    write_fp_dreg(s, rd, res);
+    tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
 }
 
 /* AdvSIMD scalar two reg misc
-- 
2.34.1


