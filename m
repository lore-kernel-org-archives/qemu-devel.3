Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1329C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwm2-0006pG-Ch; Wed, 02 Jul 2025 08:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjB-0004DB-B5
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:23 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwj3-00021r-Em
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:16 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2eacb421554so1272026fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459885; x=1752064685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAnURywcY2KjLsGWsqIy5uNGKzj9sqUsUzbcJ1ZI7Vw=;
 b=qheoxbeh8gMeYMP6ZxLOsdYOx234p4CNMDjoYGPGqVBgIBp3oxrRanCMR6YoQ40Ku1
 +ZCQz+A2k/hwKbIQAR3RsXwv7O7fw8tJbWwdkd04n1m5xckHyrNlpfGejFv9lVF4oNT1
 8IjDiSTL8iVjE0OG6iU/1QfRjpJLkbJNWpWPTKo//UjS2NZ2ephg3Xjt6H+RvHRKVfgJ
 AeRVO4HI8Es0KVoAIKfmFfq/3Mlz7EQHhM8lK5AtWbS0ghQNRUDAWdEYI2VVECJza+NG
 n/7VoednoFQkNC4fs08piv4J4ZB8sVSjJ4guZr1Ghu+2bdMX/5FXGFmjNE3aLJYkMIp2
 7j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459885; x=1752064685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAnURywcY2KjLsGWsqIy5uNGKzj9sqUsUzbcJ1ZI7Vw=;
 b=IN4tYm+ssoF3N7h6KSfjLYEAyclfZZpxA39kcImXtDGQQRHRq2v2uI2H2WvRHUdWx9
 D+M48BEKY56LyStUH9Px1+7eY3vJZIRoEoO5CkejQcBbohNg5G/jJw/YV8lXVcirMDN1
 j00RPLC20BTIMaYA86iKfuA8HiE+H8u04g4y72mw5RNuFTrxxzuVuGbaAYG94+USsBAL
 rIdbE3OoKI/rPsGvjGFpbo6P4G230NlF3Exa35qOaO1NK8uaE7RE4T4NqzrlgprER6Pd
 0Dnfm/sAKRTO7+uX9vB/py6mJ/DW0jBSMfC2DlvCAYFZjibbHTkAVwE9yO6zlGHNkYLy
 nVUg==
X-Gm-Message-State: AOJu0YxNzs+Y5De//kNxJ9HH/i3CAmmGaLAKEJJWYobcsiRUNsQY6S3u
 SDAZkS5WKzL0gNFkk90n4mWvrkJdHrHN+f/PhNYHOvDxqzC5Y0/Ih6zR/s/ynUM/V1i6lhOuccl
 ODoNnVx8=
X-Gm-Gg: ASbGncvxiy+c4kX5715RSWgNYWgsTcfjjLP4oV2dvAet4KNAeWpoMMIdRDMtPEicCPo
 tHeGn+s4U4/bM1YdQfOmeMR7CcNSMC4nSZbAXxPaGOTUe1QxBhs01pI7DUvOdA9Wr+feNQ65A0u
 u+orEg+Pl+eFSmtNvQvxoCKU1keNdp0hE2vSPakkatZmHLg2fJwQOzxiyRABcFTfYbFkI2lgBmT
 wgg5BcChs6se9hM9UoF2ah56JYUq4zZswgHvy5o2w8orOhuMN7cHWEWkJr4EKAV46uyW4U0PYi2
 BU2/9CWmlL+w0PUCQgD6oO5cvjqqfEtzoaHjBmfD60znsJP/GjrrloZXhWCdLLCrr4yPvw==
X-Google-Smtp-Source: AGHT+IEnNBzVhQQpPt7/8AxPQgAHz+48AULKn48o4RlTujG9Nwh0YjHb9ZRo6AeGeHxkFmFcZYK6ww==
X-Received: by 2002:a05:6870:d330:b0:2b7:7abf:df6b with SMTP id
 586e51a60fabf-2f5c7cc9cd8mr1994820fac.26.1751459885347; 
 Wed, 02 Jul 2025 05:38:05 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 42/97] target/arm: Implement SME2 BFCVT, BFCVTN, FCVT, FCVTN
Date: Wed,  2 Jul 2025 06:33:15 -0600
Message-ID: <20250702123410.761208-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  5 +++
 target/arm/tcg/vec_internal.h  |  2 +
 target/arm/tcg/sme_helper.c    | 74 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve_helper.c    |  2 +-
 target/arm/tcg/translate-sme.c | 25 ++++++++++++
 target/arm/tcg/sme.decode      | 12 ++++++
 6 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 0bb8af194b..97e70959e8 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -212,3 +212,8 @@ DEF_HELPER_FLAGS_5(sme2_umlsll_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr,
 DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_sumlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 64a7249d01..c8199a3ef8 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -306,4 +306,6 @@ static inline float64 float64_maybe_ah_chs(float64 a, bool fpcr_ah)
 bfloat16 helper_sme2_ah_fmax_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 bfloat16 helper_sme2_ah_fmin_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 
+float16 sve_f32_to_f16(float32 f, float_status *fpst);
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 0f79d7cb6e..d97afdb69c 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1517,3 +1517,77 @@ DO_MLALL_IDX(sme2_usmlall_idx_s, uint32_t, uint8_t, int8_t, H4, H1, +)
 DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
 
 #undef DO_MLALL_IDX
+
+/* Convert and compress */
+void HELPER(sme2_bfcvt)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    ARMVectorReg scratch;
+    size_t oprsz = simd_oprsz(desc);
+    size_t i, n = oprsz / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    bfloat16 *d = vd;
+
+    if (vd == s1) {
+        s1 = memcpy(&scratch, s1, oprsz);
+    }
+
+    for (i = 0; i < n; ++i) {
+        d[H2(i)] = float32_to_bfloat16(s0[H4(i)], fpst);
+    }
+    for (i = 0; i < n; ++i) {
+        d[H2(i) + n] = float32_to_bfloat16(s1[H4(i)], fpst);
+    }
+}
+
+void HELPER(sme2_fcvt_n)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    ARMVectorReg scratch;
+    size_t oprsz = simd_oprsz(desc);
+    size_t i, n = oprsz / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    float16 *d = vd;
+
+    if (vd == s1) {
+        s1 = memcpy(&scratch, s1, oprsz);
+    }
+
+    for (i = 0; i < n; ++i) {
+        d[H2(i)] = sve_f32_to_f16(s0[H4(i)], fpst);
+    }
+    for (i = 0; i < n; ++i) {
+        d[H2(i) + n] = sve_f32_to_f16(s1[H4(i)], fpst);
+    }
+}
+
+/* Convert and interleave */
+void HELPER(sme2_bfcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    bfloat16 *d = vd;
+
+    for (i = 0; i < n; ++i) {
+        bfloat16 d0 = float32_to_bfloat16(s0[H4(i)], fpst);
+        bfloat16 d1 = float32_to_bfloat16(s1[H4(i)], fpst);
+        d[H2(i * 2 + 0)] = d0;
+        d[H2(i * 2 + 1)] = d1;
+    }
+}
+
+void HELPER(sme2_fcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    bfloat16 *d = vd;
+
+    for (i = 0; i < n; ++i) {
+        bfloat16 d0 = sve_f32_to_f16(s0[H4(i)], fpst);
+        bfloat16 d1 = sve_f32_to_f16(s1[H4(i)], fpst);
+        d[H2(i * 2 + 0)] = d0;
+        d[H2(i * 2 + 1)] = d1;
+    }
+}
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a2c363a4e1..b522ddaf7c 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4576,7 +4576,7 @@ static inline float64 sve_f16_to_f64(float16 f, float_status *fpst)
     return ret;
 }
 
-static inline float16 sve_f32_to_f16(float32 f, float_status *fpst)
+float16 sve_f32_to_f16(float32 f, float_status *fpst)
 {
     bool save = get_flush_to_zero(fpst);
     float16 ret;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 4c3b9aa7d6..10e5b77040 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1335,3 +1335,28 @@ TRANS_FEAT(SMLALL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_smlal
 TRANS_FEAT(SMLSLL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_smlsll_idx_d)
 TRANS_FEAT(UMLALL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_umlall_idx_d)
 TRANS_FEAT(UMLSLL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_umlsll_idx_d)
+
+static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
+                       ARMFPStatusFlavour type, gen_helper_gvec_2_ptr *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        TCGv_ptr fpst = fpstatus_ptr(type);
+
+        for (int i = 0, n = a->n; i < n; ++i) {
+            tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->zd + i),
+                               vec_full_reg_offset(s, a->zn + i),
+                               fpst, svl, svl, data, fn);
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_bfcvt)
+TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_bfcvtn)
+TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_fcvt_n)
+TRANS_FEAT(FCVTN, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_fcvtn)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 22e2a68b1b..831179c0ee 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -720,3 +720,15 @@ SUB_aaz_s       11000001 101 000000 .. 111 ....0 11 ...     @az_2x2_o3
 SUB_aaz_s       11000001 101 000010 .. 111 ...00 11 ...     @az_4x4_o3
 SUB_aaz_d       11000001 111 000000 .. 111 ....0 11 ...     @az_2x2_o3
 SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
+
+### SME2 Multi-vector SVE Constructive Unary
+
+&zz_n           zd zn n
+@zz_1x2         ........ ... ..... ...... ..... zd:5        \
+                &zz_n n=1 zn=%zn_ax2
+
+BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
+BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
+
+FCVT_n          11000001 001 00000 111000 ....0 .....       @zz_1x2
+FCVTN           11000001 001 00000 111000 ....1 .....       @zz_1x2
-- 
2.43.0


