Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFF5EB2711
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpu9m-0000dg-Vg; Tue, 10 Feb 2026 15:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu9N-0007yv-Et
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:15:57 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu9K-0008Bs-J5
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:15:57 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c47ee987401so80888a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770754553; x=1771359353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRMZzY0OzErIKD5PibrfJvzVCxdt8auMtfgu55oP4ZE=;
 b=w2jXsTjjQukoUbMIFnVV3FpwQYBKYT6a0/ir/hYA0HFWHiw6XVt9mTEECR468BWItI
 A90t3mtAPR7XcxvbiLRMet5XBp0O+ymbcd95LCmpgtqlK2qHj100TUP6R0rdOztZttvs
 IBDMdpGdB+TJIDEqnpw9CuqlNwUa+kzNZ9QK7SWUQkNuPb7JMgT2pT17yM2O3lzwU0KN
 cH7Y75E1Au/J3cS+E2Tcx126Fm8stIpPQ9hLWkrjsT/UR9gleJHKrko85q/B+3lWZPYz
 Gjl3O2zqbyojgLk5C2+rIVEXu/PS2YFssyhtQN13IbBD2HE9TSRh1sMKxOI4m/upWnPC
 dtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770754553; x=1771359353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JRMZzY0OzErIKD5PibrfJvzVCxdt8auMtfgu55oP4ZE=;
 b=rW8Pq5qLcXZ2n6BMo8MxsK5OoiKgJx30UVVlnKeZUvF96mt7AA6blZoasqIUmAjolb
 j9mC6ToLy4Khd6iXyPjwWRNWVqhxc2HDEEf5mOzPhxQsPm6557zcgHiMv6q6kH0Fq3PX
 M1kMtBNhljVqrD4k7zT1V8dUp6ORGzGiSv8aAC/lHyZZrIiRtaPU2IOKnOgGfc6sCQNp
 2jloq9aolsF5vfsr9UPzJe2h8XKYZz6e+jC0VrodbvYoxqvNhhgH3xgaldJp6UGi1omA
 ug8eepj+RHrFCWH3sB8teLSyNwA9SiCr4yB/UwMb6z4viVc+24C/kYAqkZB2tHg5+6Uw
 Op0A==
X-Gm-Message-State: AOJu0Yyg0+APDhBMRBK7T1rytlNAs36MJmrxTrvRYSZsWWTZNuopzyP8
 uRIYhsf27tz1cT6/pmyZEd9Op07q3YUdRu1BR8AwutYutxX4lbqWyYNdcEV4ikr41/3n+g8eYcX
 Zra4f
X-Gm-Gg: AZuq6aKB+z5ltzvAjFO/ydGAuxdF+kqa8H539UF7c2lwY4jO9fjRgwIhxmDezMT9OJO
 2hdVQ1IQOW4/sogXmxPOo19KA5aADLXl8IvilbvBRqTWuXV0yW943QUMXkW2hf+wBZuZMpeKhqC
 K+yN9y7WKbsTdiU/rvGuXJbS1r7dJqi+mdFMgMtGKeow/FlWl1xXGaMD92WN0XNeL49bnFyPm+L
 17U41MyzwpV0Alf9pqjlNJMppPne/cLlSbKbUDXdfpqFwm0hSG6WDypu+/kNDQWcJny+Jy9ZfgH
 8YoxJIrBI6d39T5JW8gZXVB829kVn35GCru95oGRiW1CRrXaC0TCDXwVuo/5ROKKSemGS+Xnl5A
 JQlVpF/UYu/qt3Kq2PdSgHN/4g/VUucrDdmGbIMzg1xwZqR6RxYSGRbh38VGQtCAD7WSolrZ/IX
 O3Wk+K5mX6TJzHAkIJownYwgB9p2HJkdnVvraZGkDTBHlVvrAsJaS6LPaGpYbdW7n/DptP33mQR
 a03
X-Received: by 2002:a17:902:e74b:b0:2aa:e4f2:f076 with SMTP id
 d9443c01a7336-2ab1007a93emr39393675ad.8.1770754552836; 
 Tue, 10 Feb 2026 12:15:52 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab0b392cb5sm38523225ad.70.2026.02.10.12.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:15:52 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 09/12] target/arm/tcg/vec_helper.c: make compilation unit
 common
Date: Tue, 10 Feb 2026 12:15:37 -0800
Message-ID: <20260210201540.1405424-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
References: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

We need to extract 64 bits helper in a new file (vec_helper64.c), and
extract some macro definition also, since they will be used in both
files.
As well, DO_3OP_PAIR was defined twice, so rename the second variant
to DO_3OP_PAIR_NO_STATUS to reflect what it does.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/vec_internal.h |  49 ++++++++
 target/arm/tcg/vec_helper.c   | 225 +++-------------------------------
 target/arm/tcg/vec_helper64.c | 142 +++++++++++++++++++++
 target/arm/tcg/meson.build    |   4 +-
 4 files changed, 212 insertions(+), 208 deletions(-)
 create mode 100644 target/arm/tcg/vec_helper64.c

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index cf41b03dbcd..4edd2b4fc18 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -450,4 +450,53 @@ static inline void depositn(uint64_t *p, unsigned pos,
     }
 }
 
+#define DO_3OP(NAME, FUNC, TYPE) \
+void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
+                  float_status * stat, uint32_t desc)                      \
+{                                                                          \
+    intptr_t i, oprsz = simd_oprsz(desc);                                  \
+    TYPE *d = vd, *n = vn, *m = vm;                                        \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {                           \
+        d[i] = FUNC(n[i], m[i], stat);                                     \
+    }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
+}
+
+#define DO_3OP_PAIR(NAME, FUNC, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
+                  float_status * stat, uint32_t desc)                      \
+{                                                                          \
+    ARMVectorReg scratch;                                                  \
+    intptr_t oprsz = simd_oprsz(desc);                                     \
+    intptr_t half = oprsz / sizeof(TYPE) / 2;                              \
+    TYPE *d = vd, *n = vn, *m = vm;                                        \
+    if (unlikely(d == m)) {                                                \
+        m = memcpy(&scratch, m, oprsz);                                    \
+    }                                                                      \
+    for (intptr_t i = 0; i < half; ++i) {                                  \
+        d[H(i)] = FUNC(n[H(i * 2)], n[H(i * 2 + 1)], stat);                \
+    }                                                                      \
+    for (intptr_t i = 0; i < half; ++i) {                                  \
+        d[H(i + half)] = FUNC(m[H(i * 2)], m[H(i * 2 + 1)], stat);         \
+    }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
+}
+
+#define DO_FMUL_IDX(NAME, ADD, MUL, TYPE, H)                               \
+void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
+                  float_status * stat, uint32_t desc)                      \
+{                                                                          \
+    intptr_t i, j, oprsz = simd_oprsz(desc);                               \
+    intptr_t segment = MIN(16, oprsz) / sizeof(TYPE);                      \
+    intptr_t idx = simd_data(desc);                                        \
+    TYPE *d = vd, *n = vn, *m = vm;                                        \
+    for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
+        TYPE mm = m[H(i + idx)];                                           \
+        for (j = 0; j < segment; j++) {                                    \
+            d[i + j] = ADD(d[i + j], MUL(n[i + j], mm, stat), stat);       \
+        }                                                                  \
+    }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
+}
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 1223b843bf1..91e98d28aea 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -20,9 +20,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "helper.h"
-#include "helper-a64.h"
-#include "helper-sme.h"
-#include "helper-sve.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "qemu/int128.h"
@@ -1458,18 +1455,6 @@ static float32 float32_rsqrts_nf(float32 op1, float32 op2, float_status *stat)
     return float32_div(op1, float32_two, stat);
 }
 
-#define DO_3OP(NAME, FUNC, TYPE) \
-void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
-                  float_status *stat, uint32_t desc)                       \
-{                                                                          \
-    intptr_t i, oprsz = simd_oprsz(desc);                                  \
-    TYPE *d = vd, *n = vn, *m = vm;                                        \
-    for (i = 0; i < oprsz / sizeof(TYPE); i++) {                           \
-        d[i] = FUNC(n[i], m[i], stat);                                     \
-    }                                                                      \
-    clear_tail(d, oprsz, simd_maxsz(desc));                                \
-}
-
 DO_3OP(gvec_fadd_b16, bfloat16_add, float16)
 DO_3OP(gvec_fadd_h, float16_add, float16)
 DO_3OP(gvec_fadd_s, float32_add, float32)
@@ -1541,49 +1526,6 @@ DO_3OP(gvec_recps_nf_s, float32_recps_nf, float32)
 DO_3OP(gvec_rsqrts_nf_h, float16_rsqrts_nf, float16)
 DO_3OP(gvec_rsqrts_nf_s, float32_rsqrts_nf, float32)
 
-#ifdef TARGET_AARCH64
-DO_3OP(gvec_fdiv_h, float16_div, float16)
-DO_3OP(gvec_fdiv_s, float32_div, float32)
-DO_3OP(gvec_fdiv_d, float64_div, float64)
-
-DO_3OP(gvec_fmulx_h, helper_advsimd_mulxh, float16)
-DO_3OP(gvec_fmulx_s, helper_vfp_mulxs, float32)
-DO_3OP(gvec_fmulx_d, helper_vfp_mulxd, float64)
-
-DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
-DO_3OP(gvec_recps_s, helper_recpsf_f32, float32)
-DO_3OP(gvec_recps_d, helper_recpsf_f64, float64)
-
-DO_3OP(gvec_rsqrts_h, helper_rsqrtsf_f16, float16)
-DO_3OP(gvec_rsqrts_s, helper_rsqrtsf_f32, float32)
-DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
-
-DO_3OP(gvec_ah_recps_h, helper_recpsf_ah_f16, float16)
-DO_3OP(gvec_ah_recps_s, helper_recpsf_ah_f32, float32)
-DO_3OP(gvec_ah_recps_d, helper_recpsf_ah_f64, float64)
-
-DO_3OP(gvec_ah_rsqrts_h, helper_rsqrtsf_ah_f16, float16)
-DO_3OP(gvec_ah_rsqrts_s, helper_rsqrtsf_ah_f32, float32)
-DO_3OP(gvec_ah_rsqrts_d, helper_rsqrtsf_ah_f64, float64)
-
-DO_3OP(gvec_ah_fmax_h, helper_vfp_ah_maxh, float16)
-DO_3OP(gvec_ah_fmax_s, helper_vfp_ah_maxs, float32)
-DO_3OP(gvec_ah_fmax_d, helper_vfp_ah_maxd, float64)
-
-DO_3OP(gvec_ah_fmin_h, helper_vfp_ah_minh, float16)
-DO_3OP(gvec_ah_fmin_s, helper_vfp_ah_mins, float32)
-DO_3OP(gvec_ah_fmin_d, helper_vfp_ah_mind, float64)
-
-DO_3OP(gvec_fmax_b16, bfloat16_max, bfloat16)
-DO_3OP(gvec_fmin_b16, bfloat16_min, bfloat16)
-DO_3OP(gvec_fmaxnum_b16, bfloat16_maxnum, bfloat16)
-DO_3OP(gvec_fminnum_b16, bfloat16_minnum, bfloat16)
-DO_3OP(gvec_ah_fmax_b16, helper_sme2_ah_fmax_b16, bfloat16)
-DO_3OP(gvec_ah_fmin_b16, helper_sme2_ah_fmin_b16, bfloat16)
-
-#endif
-#undef DO_3OP
-
 /* Non-fused multiply-add (unlike float16_muladd etc, which are fused) */
 static float16 float16_muladd_nf(float16 dest, float16 op1, float16 op2,
                                  float_status *stat)
@@ -1769,23 +1711,6 @@ DO_MLA_IDX(gvec_mls_idx_d, uint64_t, -, H8)
 
 #undef DO_MLA_IDX
 
-#define DO_FMUL_IDX(NAME, ADD, MUL, TYPE, H)                               \
-void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
-                  float_status *stat, uint32_t desc)                       \
-{                                                                          \
-    intptr_t i, j, oprsz = simd_oprsz(desc);                               \
-    intptr_t segment = MIN(16, oprsz) / sizeof(TYPE);                      \
-    intptr_t idx = simd_data(desc);                                        \
-    TYPE *d = vd, *n = vn, *m = vm;                                        \
-    for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
-        TYPE mm = m[H(i + idx)];                                           \
-        for (j = 0; j < segment; j++) {                                    \
-            d[i + j] = ADD(d[i + j], MUL(n[i + j], mm, stat), stat);       \
-        }                                                                  \
-    }                                                                      \
-    clear_tail(d, oprsz, simd_maxsz(desc));                                \
-}
-
 #define nop(N, M, S) (M)
 
 DO_FMUL_IDX(gvec_fmul_idx_b16, nop, bfloat16_mul, float16, H2)
@@ -1793,14 +1718,6 @@ DO_FMUL_IDX(gvec_fmul_idx_h, nop, float16_mul, float16, H2)
 DO_FMUL_IDX(gvec_fmul_idx_s, nop, float32_mul, float32, H4)
 DO_FMUL_IDX(gvec_fmul_idx_d, nop, float64_mul, float64, H8)
 
-#ifdef TARGET_AARCH64
-
-DO_FMUL_IDX(gvec_fmulx_idx_h, nop, helper_advsimd_mulxh, float16, H2)
-DO_FMUL_IDX(gvec_fmulx_idx_s, nop, helper_vfp_mulxs, float32, H4)
-DO_FMUL_IDX(gvec_fmulx_idx_d, nop, helper_vfp_mulxd, float64, H8)
-
-#endif
-
 #undef nop
 
 /*
@@ -1812,8 +1729,6 @@ DO_FMUL_IDX(gvec_fmla_nf_idx_s, float32_add, float32_mul, float32, H4)
 DO_FMUL_IDX(gvec_fmls_nf_idx_h, float16_sub, float16_mul, float16, H2)
 DO_FMUL_IDX(gvec_fmls_nf_idx_s, float32_sub, float32_mul, float32, H4)
 
-#undef DO_FMUL_IDX
-
 #define DO_FMLA_IDX(NAME, TYPE, H, NEGX, NEGF)                             \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
                   float_status *stat, uint32_t desc)                       \
@@ -2530,31 +2445,6 @@ void HELPER(neon_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
     clear_tail(d, 16, simd_maxsz(desc));
 }
 
-#ifdef TARGET_AARCH64
-void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
-{
-    int shift = simd_data(desc) * 8;
-    intptr_t i, opr_sz = simd_oprsz(desc);
-    uint64_t *d = vd, *n = vn, *m = vm;
-
-    for (i = 0; i < opr_sz / 8; ++i) {
-        d[i] = clmul_8x4_even(n[i] >> shift, m[i] >> shift);
-    }
-}
-
-void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
-{
-    intptr_t sel = H4(simd_data(desc));
-    intptr_t i, opr_sz = simd_oprsz(desc);
-    uint32_t *n = vn, *m = vm;
-    uint64_t *d = vd;
-
-    for (i = 0; i < opr_sz / 8; ++i) {
-        d[i] = clmul_32(n[2 * i + sel], m[2 * i + sel]);
-    }
-}
-#endif
-
 #define DO_CMP0(NAME, TYPE, OP)                         \
 void HELPER(NAME)(void *vd, void *vn, uint32_t desc)    \
 {                                                       \
@@ -2628,26 +2518,6 @@ DO_ABA(gvec_uaba_d, uint64_t)
 
 #undef DO_ABA
 
-#define DO_3OP_PAIR(NAME, FUNC, TYPE, H) \
-void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
-                  float_status *stat, uint32_t desc)                       \
-{                                                                          \
-    ARMVectorReg scratch;                                                  \
-    intptr_t oprsz = simd_oprsz(desc);                                     \
-    intptr_t half = oprsz / sizeof(TYPE) / 2;                              \
-    TYPE *d = vd, *n = vn, *m = vm;                                        \
-    if (unlikely(d == m)) {                                                \
-        m = memcpy(&scratch, m, oprsz);                                    \
-    }                                                                      \
-    for (intptr_t i = 0; i < half; ++i) {                                  \
-        d[H(i)] = FUNC(n[H(i * 2)], n[H(i * 2 + 1)], stat);                \
-    }                                                                      \
-    for (intptr_t i = 0; i < half; ++i) {                                  \
-        d[H(i + half)] = FUNC(m[H(i * 2)], m[H(i * 2 + 1)], stat);         \
-    }                                                                      \
-    clear_tail(d, oprsz, simd_maxsz(desc));                                \
-}
-
 DO_3OP_PAIR(gvec_faddp_h, float16_add, float16, H2)
 DO_3OP_PAIR(gvec_faddp_s, float32_add, float32, H4)
 DO_3OP_PAIR(gvec_faddp_d, float64_add, float64, )
@@ -2668,19 +2538,7 @@ DO_3OP_PAIR(gvec_fminnump_h, float16_minnum, float16, H2)
 DO_3OP_PAIR(gvec_fminnump_s, float32_minnum, float32, H4)
 DO_3OP_PAIR(gvec_fminnump_d, float64_minnum, float64, )
 
-#ifdef TARGET_AARCH64
-DO_3OP_PAIR(gvec_ah_fmaxp_h, helper_vfp_ah_maxh, float16, H2)
-DO_3OP_PAIR(gvec_ah_fmaxp_s, helper_vfp_ah_maxs, float32, H4)
-DO_3OP_PAIR(gvec_ah_fmaxp_d, helper_vfp_ah_maxd, float64, )
-
-DO_3OP_PAIR(gvec_ah_fminp_h, helper_vfp_ah_minh, float16, H2)
-DO_3OP_PAIR(gvec_ah_fminp_s, helper_vfp_ah_mins, float32, H4)
-DO_3OP_PAIR(gvec_ah_fminp_d, helper_vfp_ah_mind, float64, )
-#endif
-
-#undef DO_3OP_PAIR
-
-#define DO_3OP_PAIR(NAME, FUNC, TYPE, H) \
+#define DO_3OP_PAIR_NO_STATUS(NAME, FUNC, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
 {                                                               \
     ARMVectorReg scratch;                                       \
@@ -2700,29 +2558,29 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
 }
 
 #define ADD(A, B) (A + B)
-DO_3OP_PAIR(gvec_addp_b, ADD, uint8_t, H1)
-DO_3OP_PAIR(gvec_addp_h, ADD, uint16_t, H2)
-DO_3OP_PAIR(gvec_addp_s, ADD, uint32_t, H4)
-DO_3OP_PAIR(gvec_addp_d, ADD, uint64_t, )
+DO_3OP_PAIR_NO_STATUS(gvec_addp_b, ADD, uint8_t, H1)
+DO_3OP_PAIR_NO_STATUS(gvec_addp_h, ADD, uint16_t, H2)
+DO_3OP_PAIR_NO_STATUS(gvec_addp_s, ADD, uint32_t, H4)
+DO_3OP_PAIR_NO_STATUS(gvec_addp_d, ADD, uint64_t, /**/)
 #undef  ADD
 
-DO_3OP_PAIR(gvec_smaxp_b, MAX, int8_t, H1)
-DO_3OP_PAIR(gvec_smaxp_h, MAX, int16_t, H2)
-DO_3OP_PAIR(gvec_smaxp_s, MAX, int32_t, H4)
+DO_3OP_PAIR_NO_STATUS(gvec_smaxp_b, MAX, int8_t, H1)
+DO_3OP_PAIR_NO_STATUS(gvec_smaxp_h, MAX, int16_t, H2)
+DO_3OP_PAIR_NO_STATUS(gvec_smaxp_s, MAX, int32_t, H4)
 
-DO_3OP_PAIR(gvec_umaxp_b, MAX, uint8_t, H1)
-DO_3OP_PAIR(gvec_umaxp_h, MAX, uint16_t, H2)
-DO_3OP_PAIR(gvec_umaxp_s, MAX, uint32_t, H4)
+DO_3OP_PAIR_NO_STATUS(gvec_umaxp_b, MAX, uint8_t, H1)
+DO_3OP_PAIR_NO_STATUS(gvec_umaxp_h, MAX, uint16_t, H2)
+DO_3OP_PAIR_NO_STATUS(gvec_umaxp_s, MAX, uint32_t, H4)
 
-DO_3OP_PAIR(gvec_sminp_b, MIN, int8_t, H1)
-DO_3OP_PAIR(gvec_sminp_h, MIN, int16_t, H2)
-DO_3OP_PAIR(gvec_sminp_s, MIN, int32_t, H4)
+DO_3OP_PAIR_NO_STATUS(gvec_sminp_b, MIN, int8_t, H1)
+DO_3OP_PAIR_NO_STATUS(gvec_sminp_h, MIN, int16_t, H2)
+DO_3OP_PAIR_NO_STATUS(gvec_sminp_s, MIN, int32_t, H4)
 
-DO_3OP_PAIR(gvec_uminp_b, MIN, uint8_t, H1)
-DO_3OP_PAIR(gvec_uminp_h, MIN, uint16_t, H2)
-DO_3OP_PAIR(gvec_uminp_s, MIN, uint32_t, H4)
+DO_3OP_PAIR_NO_STATUS(gvec_uminp_b, MIN, uint8_t, H1)
+DO_3OP_PAIR_NO_STATUS(gvec_uminp_h, MIN, uint16_t, H2)
+DO_3OP_PAIR_NO_STATUS(gvec_uminp_s, MIN, uint32_t, H4)
 
-#undef DO_3OP_PAIR
+#undef DO_3OP_PAIR_NO_STATUS
 
 #define DO_VCVT_FIXED(NAME, FUNC, TYPE)                                 \
     void HELPER(NAME)(void *vd, void *vn, float_status *stat, uint32_t desc) \
@@ -2797,53 +2655,6 @@ DO_VRINT_RMODE(gvec_vrint_rm_s, helper_rints, uint32_t)
 
 #undef DO_VRINT_RMODE
 
-#ifdef TARGET_AARCH64
-void HELPER(simd_tblx)(void *vd, void *vm, CPUARMState *env, uint32_t desc)
-{
-    const uint8_t *indices = vm;
-    size_t oprsz = simd_oprsz(desc);
-    uint32_t rn = extract32(desc, SIMD_DATA_SHIFT, 5);
-    bool is_tbx = extract32(desc, SIMD_DATA_SHIFT + 5, 1);
-    uint32_t table_len = desc >> (SIMD_DATA_SHIFT + 6);
-    union {
-        uint8_t b[16];
-        uint64_t d[2];
-    } result;
-
-    /*
-     * We must construct the final result in a temp, lest the output
-     * overlaps the input table.  For TBL, begin with zero; for TBX,
-     * begin with the original register contents.  Note that we always
-     * copy 16 bytes here to avoid an extra branch; clearing the high
-     * bits of the register for oprsz == 8 is handled below.
-     */
-    if (is_tbx) {
-        memcpy(&result, vd, 16);
-    } else {
-        memset(&result, 0, 16);
-    }
-
-    for (size_t i = 0; i < oprsz; ++i) {
-        uint32_t index = indices[H1(i)];
-
-        if (index < table_len) {
-            /*
-             * Convert index (a byte offset into the virtual table
-             * which is a series of 128-bit vectors concatenated)
-             * into the correct register element, bearing in mind
-             * that the table can wrap around from V31 to V0.
-             */
-            const uint8_t *table = (const uint8_t *)
-                aa64_vfp_qreg(env, (rn + (index >> 4)) % 32);
-            result.b[H1(i)] = table[H1(index % 16)];
-        }
-    }
-
-    memcpy(vd, &result, 16);
-    clear_tail(vd, oprsz, simd_maxsz(desc));
-}
-#endif
-
 /*
  * NxN -> N highpart multiply
  *
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
new file mode 100644
index 00000000000..249a257177e
--- /dev/null
+++ b/target/arm/tcg/vec_helper64.c
@@ -0,0 +1,142 @@
+/*
+ * ARM AdvSIMD / SVE Vector Operations
+ *
+ * Copyright (c) 2026 Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "helper.h"
+#include "helper-a64.h"
+#include "helper-sme.h"
+#include "helper-sve.h"
+#include "tcg/tcg-gvec-desc.h"
+#include "fpu/softfloat.h"
+#include "qemu/int128.h"
+#include "crypto/clmul.h"
+#include "vec_internal.h"
+
+DO_3OP(gvec_fdiv_h, float16_div, float16)
+DO_3OP(gvec_fdiv_s, float32_div, float32)
+DO_3OP(gvec_fdiv_d, float64_div, float64)
+
+DO_3OP(gvec_fmulx_h, helper_advsimd_mulxh, float16)
+DO_3OP(gvec_fmulx_s, helper_vfp_mulxs, float32)
+DO_3OP(gvec_fmulx_d, helper_vfp_mulxd, float64)
+
+DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
+DO_3OP(gvec_recps_s, helper_recpsf_f32, float32)
+DO_3OP(gvec_recps_d, helper_recpsf_f64, float64)
+
+DO_3OP(gvec_rsqrts_h, helper_rsqrtsf_f16, float16)
+DO_3OP(gvec_rsqrts_s, helper_rsqrtsf_f32, float32)
+DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
+
+DO_3OP(gvec_ah_recps_h, helper_recpsf_ah_f16, float16)
+DO_3OP(gvec_ah_recps_s, helper_recpsf_ah_f32, float32)
+DO_3OP(gvec_ah_recps_d, helper_recpsf_ah_f64, float64)
+
+DO_3OP(gvec_ah_rsqrts_h, helper_rsqrtsf_ah_f16, float16)
+DO_3OP(gvec_ah_rsqrts_s, helper_rsqrtsf_ah_f32, float32)
+DO_3OP(gvec_ah_rsqrts_d, helper_rsqrtsf_ah_f64, float64)
+
+DO_3OP(gvec_ah_fmax_h, helper_vfp_ah_maxh, float16)
+DO_3OP(gvec_ah_fmax_s, helper_vfp_ah_maxs, float32)
+DO_3OP(gvec_ah_fmax_d, helper_vfp_ah_maxd, float64)
+
+DO_3OP(gvec_ah_fmin_h, helper_vfp_ah_minh, float16)
+DO_3OP(gvec_ah_fmin_s, helper_vfp_ah_mins, float32)
+DO_3OP(gvec_ah_fmin_d, helper_vfp_ah_mind, float64)
+
+DO_3OP(gvec_fmax_b16, bfloat16_max, bfloat16)
+DO_3OP(gvec_fmin_b16, bfloat16_min, bfloat16)
+DO_3OP(gvec_fmaxnum_b16, bfloat16_maxnum, bfloat16)
+DO_3OP(gvec_fminnum_b16, bfloat16_minnum, bfloat16)
+DO_3OP(gvec_ah_fmax_b16, helper_sme2_ah_fmax_b16, bfloat16)
+DO_3OP(gvec_ah_fmin_b16, helper_sme2_ah_fmin_b16, bfloat16)
+
+#define nop(N, M, S) (M)
+
+DO_FMUL_IDX(gvec_fmulx_idx_h, nop, helper_advsimd_mulxh, float16, H2)
+DO_FMUL_IDX(gvec_fmulx_idx_s, nop, helper_vfp_mulxs, float32, H4)
+DO_FMUL_IDX(gvec_fmulx_idx_d, nop, helper_vfp_mulxd, float64, H8)
+
+#undef nop
+
+void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    int shift = simd_data(desc) * 8;
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = clmul_8x4_even(n[i] >> shift, m[i] >> shift);
+    }
+}
+
+void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t sel = H4(simd_data(desc));
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *n = vn, *m = vm;
+    uint64_t *d = vd;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = clmul_32(n[2 * i + sel], m[2 * i + sel]);
+    }
+}
+
+DO_3OP_PAIR(gvec_ah_fmaxp_h, helper_vfp_ah_maxh, float16, H2)
+DO_3OP_PAIR(gvec_ah_fmaxp_s, helper_vfp_ah_maxs, float32, H4)
+DO_3OP_PAIR(gvec_ah_fmaxp_d, helper_vfp_ah_maxd, float64, /**/)
+
+DO_3OP_PAIR(gvec_ah_fminp_h, helper_vfp_ah_minh, float16, H2)
+DO_3OP_PAIR(gvec_ah_fminp_s, helper_vfp_ah_mins, float32, H4)
+DO_3OP_PAIR(gvec_ah_fminp_d, helper_vfp_ah_mind, float64, /**/)
+
+void HELPER(simd_tblx)(void *vd, void *vm, CPUARMState *env, uint32_t desc)
+{
+    const uint8_t *indices = vm;
+    size_t oprsz = simd_oprsz(desc);
+    uint32_t rn = extract32(desc, SIMD_DATA_SHIFT, 5);
+    bool is_tbx = extract32(desc, SIMD_DATA_SHIFT + 5, 1);
+    uint32_t table_len = desc >> (SIMD_DATA_SHIFT + 6);
+    union {
+        uint8_t b[16];
+        uint64_t d[2];
+    } result;
+
+    /*
+     * We must construct the final result in a temp, lest the output
+     * overlaps the input table.  For TBL, begin with zero; for TBX,
+     * begin with the original register contents.  Note that we always
+     * copy 16 bytes here to avoid an extra branch; clearing the high
+     * bits of the register for oprsz == 8 is handled below.
+     */
+    if (is_tbx) {
+        memcpy(&result, vd, 16);
+    } else {
+        memset(&result, 0, 16);
+    }
+
+    for (size_t i = 0; i < oprsz; ++i) {
+        uint32_t index = indices[H1(i)];
+
+        if (index < table_len) {
+            /*
+             * Convert index (a byte offset into the virtual table
+             * which is a series of 128-bit vectors concatenated)
+             * into the correct register element, bearing in mind
+             * that the table can wrap around from V31 to V0.
+             */
+            const uint8_t *table = (const uint8_t *)
+                aa64_vfp_qreg(env, (rn + (index >> 4)) % 32);
+            result.b[H1(i)] = table[H1(index % 16)];
+        }
+    }
+
+    memcpy(vd, &result, 16);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 08ac5ec9906..3b501df7425 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(files(
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
-  'vec_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -47,6 +46,7 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'pauth_helper.c',
   'sme_helper.c',
   'sve_helper.c',
+  'vec_helper64.c',
 ))
 
 arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
@@ -66,11 +66,13 @@ arm_common_system_ss.add(files(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'vec_helper.c',
   'vfp_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'vec_helper.c',
   'vfp_helper.c',
 ))
-- 
2.47.3


