Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88B8C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeIq-0002II-Ev; Fri, 24 May 2024 19:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeI3-0007lN-AG
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:35 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHt-0006y5-6X
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:33 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f6a045d476so3611208b3a.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716593119; x=1717197919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U08xz9w8d1Te1t7LIidyDjNjL+T7qJ8Gada+qFJ0dkg=;
 b=zEPQW0CebemDgLgdga/ftwqMs2dCzPuhRRxtQMtrc4zLBJxQ5CS08gAeFPXArw4KcX
 Qxa00RMQj9qxEEAlUwLb7t7OkMpCnJtCsXkW1ekf3GgMj78Ghl8ZwwVRyP9m4CfRSAjZ
 TzjEUL3DvIb72RWvx9o2AlhjHERMctBVdd2NRWVT8manjgI8oca6oAfRL0e9DRhgqtlX
 v22+KRYRjQd1QKcKaLLQF+Y2K5tD0a1hHgnBVw7cS1jxBT2lXeaULPReQ0PUa5TVwxIs
 YdVNdiK7wnbrn6O35lSEpfiKHeQ7A/K3DOEJMihMdKMfQdVZ6KT8Mnw5vmBEb2JzHfQm
 fV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716593119; x=1717197919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U08xz9w8d1Te1t7LIidyDjNjL+T7qJ8Gada+qFJ0dkg=;
 b=i0R57kEbiVBwNTW7XHnU2VbCl+Z2OKL/S+UKUu3odKeugGbxLmVs71jhx9kf3vRmK/
 sXNVfyoRxOkXVvrJ2BAjFunA1PZWwmCX/s9rB3DBTW/XT46Q2fY6LCvOo3BUU9SpaVZE
 n5sxQC2vwuYy5AJ1R8BFV6/I5XSg0hjhl+SfYwL9VWqC8kJP48d5aUZfXpOEWWUFSo8p
 8zD3iSW1KYVcK/XAj6DjN50LvLxsRFLTYYbtz+bJ5xtk/4/vlsTdoJIFS+9jrF73pfdW
 McwefBTRTX7eq63SaqfIAp1u7+gPTJi7/IP9wJvhbBqxvpyRZ0rSmorhfamhk7m3JAly
 dv4Q==
X-Gm-Message-State: AOJu0Yw7TdK3ftrd9n62nj1Px4OvOmcPICsqOa3ATAJGip2xpaZv2eyO
 AaBdJZ05Klwufhfl8f55WyfJMfpQp40eK51PfmaQfVVLP13UAPv+BYagVwczNWLSI38bF6IpjHv
 J
X-Google-Smtp-Source: AGHT+IHrRY5F8c6y6AU9hJfW3KvEbrp5+//7F2f2sQhCEIW8duoAWzBP+hWQHwPVXign5I1QgEfP4w==
X-Received: by 2002:a05:6a20:43ac:b0:1aa:43f4:3562 with SMTP id
 adf61e73a8af0-1b212d38fd6mr5029271637.11.1716593119095; 
 Fri, 24 May 2024 16:25:19 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2cfd1sm1591695b3a.3.2024.05.24.16.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:25:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 65/67] target/arm: Convert SQDMULH, SQRDMULH to decodetree
Date: Fri, 24 May 2024 16:21:19 -0700
Message-Id: <20240524232121.284515-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
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

These are the last instructions within disas_simd_three_reg_same
and disas_simd_scalar_three_reg_same, so remove them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  10 ++
 target/arm/tcg/a64.decode      |  18 +++
 target/arm/tcg/translate-a64.c | 276 ++++++++++-----------------------
 target/arm/tcg/vec_helper.c    |  64 ++++++++
 4 files changed, 172 insertions(+), 196 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 85f9302563..24feecee9b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -968,6 +968,16 @@ DEF_HELPER_FLAGS_5(neon_sqrdmulh_h, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(neon_sqrdmulh_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(neon_sqdmulh_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqdmulh_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(neon_sqrdmulh_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqrdmulh_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2dea68a0a9..f7f897f9fc 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -774,6 +774,9 @@ CMHS_s          0111 1110 111 ..... 00111 1 ..... ..... @rrr_d
 CMTST_s         0101 1110 111 ..... 10001 1 ..... ..... @rrr_d
 CMEQ_s          0111 1110 111 ..... 10001 1 ..... ..... @rrr_d
 
+SQDMULH_s       0101 1110 ..1 ..... 10110 1 ..... ..... @rrr_e
+SQRDMULH_s      0111 1110 ..1 ..... 10110 1 ..... ..... @rrr_e
+
 ### Advanced SIMD scalar pairwise
 
 FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
@@ -931,6 +934,9 @@ PMUL_v          0.10 1110 001 ..... 10011 1 ..... ..... @qrrr_b
 MLA_v           0.00 1110 ..1 ..... 10010 1 ..... ..... @qrrr_e
 MLS_v           0.10 1110 ..1 ..... 10010 1 ..... ..... @qrrr_e
 
+SQDMULH_v       0.00 1110 ..1 ..... 10110 1 ..... ..... @qrrr_e
+SQRDMULH_v      0.10 1110 ..1 ..... 10110 1 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -949,6 +955,12 @@ FMULX_si        0111 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
 FMULX_si        0111 1111 10 . ..... 1001 . 0 ..... .....   @rrx_s
 FMULX_si        0111 1111 11 0 ..... 1001 . 0 ..... .....   @rrx_d
 
+SQDMULH_si      0101 1111 01 .. .... 1100 . 0 ..... .....   @rrx_h
+SQDMULH_si      0101 1111 10 .. .... 1100 . 0 ..... .....   @rrx_s
+
+SQRDMULH_si     0101 1111 01 .. .... 1101 . 0 ..... .....   @rrx_h
+SQRDMULH_si     0101 1111 10 . ..... 1101 . 0 ..... .....   @rrx_s
+
 ### Advanced SIMD vector x indexed element
 
 FMUL_vi         0.00 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
@@ -980,3 +992,9 @@ MLA_vi          0.10 1111 10 . ..... 0000 . 0 ..... .....   @qrrx_s
 
 MLS_vi          0.10 1111 01 .. .... 0100 . 0 ..... .....   @qrrx_h
 MLS_vi          0.10 1111 10 . ..... 0100 . 0 ..... .....   @qrrx_s
+
+SQDMULH_vi      0.00 1111 01 .. .... 1100 . 0 ..... .....   @qrrx_h
+SQDMULH_vi      0.00 1111 10 . ..... 1100 . 0 ..... .....   @qrrx_s
+
+SQRDMULH_vi     0.00 1111 01 .. .... 1101 . 0 ..... .....   @qrrx_h
+SQRDMULH_vi     0.00 1111 10 . ..... 1101 . 0 ..... .....   @qrrx_s
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c673b95ec7..14226c56cf 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1350,6 +1350,14 @@ static bool do_gvec_fn3_no64(DisasContext *s, arg_qrrr_e *a, GVecGen3Fn *fn)
     return true;
 }
 
+static bool do_gvec_fn3_no8_no64(DisasContext *s, arg_qrrr_e *a, GVecGen3Fn *fn)
+{
+    if (a->esz == MO_8) {
+        return false;
+    }
+    return do_gvec_fn3_no64(s, a, fn);
+}
+
 static bool do_gvec_fn4(DisasContext *s, arg_qrrrr_e *a, GVecGen4Fn *fn)
 {
     if (!a->q && a->esz == MO_64) {
@@ -5167,6 +5175,25 @@ static const ENVScalar2 f_scalar_uqrshl = {
 };
 TRANS(UQRSHL_s, do_env_scalar2, a, &f_scalar_uqrshl)
 
+static bool do_env_scalar2_hs(DisasContext *s, arg_rrr_e *a,
+                              const ENVScalar2 *f)
+{
+    if (a->esz == MO_16 || a->esz == MO_32) {
+        return do_env_scalar2(s, a, f);
+    }
+    return false;
+}
+
+static const ENVScalar2 f_scalar_sqdmulh = {
+    { NULL, gen_helper_neon_qdmulh_s16, gen_helper_neon_qdmulh_s32 }
+};
+TRANS(SQDMULH_s, do_env_scalar2_hs, a, &f_scalar_sqdmulh)
+
+static const ENVScalar2 f_scalar_sqrdmulh = {
+    { NULL, gen_helper_neon_qrdmulh_s16, gen_helper_neon_qrdmulh_s32 }
+};
+TRANS(SQRDMULH_s, do_env_scalar2_hs, a, &f_scalar_sqrdmulh)
+
 static bool do_cmop_d(DisasContext *s, arg_rrr_e *a, TCGCond cond)
 {
     if (fp_access_check(s)) {
@@ -5482,6 +5509,9 @@ TRANS(CMHS_v, do_cmop_v, a, TCG_COND_GEU)
 TRANS(CMEQ_v, do_cmop_v, a, TCG_COND_EQ)
 TRANS(CMTST_v, do_gvec_fn3, a, gen_gvec_cmtst)
 
+TRANS(SQDMULH_v, do_gvec_fn3_no8_no64, a, gen_gvec_sqdmulh_qc)
+TRANS(SQRDMULH_v, do_gvec_fn3_no8_no64, a, gen_gvec_sqrdmulh_qc)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -5589,6 +5619,27 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
 TRANS(FMLA_si, do_fmla_scalar_idx, a, false)
 TRANS(FMLS_si, do_fmla_scalar_idx, a, true)
 
+static bool do_env_scalar2_idx_hs(DisasContext *s, arg_rrx_e *a,
+                                  const ENVScalar2 *f)
+{
+    if (a->esz < MO_16 || a->esz > MO_32) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+
+        read_vec_element_i32(s, t0, a->rn, 0, a->esz);
+        read_vec_element_i32(s, t1, a->rm, a->idx, a->esz);
+        f->gen_bhs[a->esz](t0, tcg_env, t0, t1);
+        write_fp_sreg(s, a->rd, t0);
+    }
+    return true;
+}
+
+TRANS(SQDMULH_si, do_env_scalar2_idx_hs, a, &f_scalar_sqdmulh)
+TRANS(SQRDMULH_si, do_env_scalar2_idx_hs, a, &f_scalar_sqrdmulh)
+
 static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                               gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5719,6 +5770,33 @@ static bool do_mla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool sub)
 TRANS(MLA_vi, do_mla_vector_idx, a, false)
 TRANS(MLS_vi, do_mla_vector_idx, a, true)
 
+static bool do_int3_qc_vector_idx(DisasContext *s, arg_qrrx_e *a,
+                                  gen_helper_gvec_4 * const fns[2])
+{
+    assert(a->esz == MO_16 || a->esz == MO_32);
+    if (fp_access_check(s)) {
+        tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           offsetof(CPUARMState, vfp.qc),
+                           a->q ? 16 : 8, vec_full_reg_size(s),
+                           a->idx, fns[a->esz - 1]);
+    }
+    return true;
+}
+
+static gen_helper_gvec_4 * const f_vector_idx_sqdmulh[2] = {
+    gen_helper_neon_sqdmulh_idx_h,
+    gen_helper_neon_sqdmulh_idx_s,
+};
+TRANS(SQDMULH_vi, do_int3_qc_vector_idx, a, f_vector_idx_sqdmulh)
+
+static gen_helper_gvec_4 * const f_vector_idx_sqrdmulh[2] = {
+    gen_helper_neon_sqrdmulh_idx_h,
+    gen_helper_neon_sqrdmulh_idx_s,
+};
+TRANS(SQRDMULH_vi, do_int3_qc_vector_idx, a, f_vector_idx_sqrdmulh)
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -9500,109 +9578,6 @@ static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
-/* AdvSIMD scalar three same
- *  31 30  29 28       24 23  22  21 20  16 15    11  10 9    5 4    0
- * +-----+---+-----------+------+---+------+--------+---+------+------+
- * | 0 1 | U | 1 1 1 1 0 | size | 1 |  Rm  | opcode | 1 |  Rn  |  Rd  |
- * +-----+---+-----------+------+---+------+--------+---+------+------+
- */
-static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int opcode = extract32(insn, 11, 5);
-    int rm = extract32(insn, 16, 5);
-    int size = extract32(insn, 22, 2);
-    bool u = extract32(insn, 29, 1);
-    TCGv_i64 tcg_rd;
-
-    switch (opcode) {
-    case 0x16: /* SQDMULH, SQRDMULH (vector) */
-        if (size != 1 && size != 2) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
-    default:
-    case 0x1: /* SQADD, UQADD */
-    case 0x5: /* SQSUB, UQSUB */
-    case 0x6: /* CMGT, CMHI */
-    case 0x7: /* CMGE, CMHS */
-    case 0x8: /* SSHL, USHL */
-    case 0x9: /* SQSHL, UQSHL */
-    case 0xa: /* SRSHL, URSHL */
-    case 0xb: /* SQRSHL, UQRSHL */
-    case 0x10: /* ADD, SUB (vector) */
-    case 0x11: /* CMTST, CMEQ */
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    tcg_rd = tcg_temp_new_i64();
-
-    if (size == 3) {
-        g_assert_not_reached();
-    } else {
-        /* Do a single operation on the lowest element in the vector.
-         * We use the standard Neon helpers and rely on 0 OP 0 == 0 with
-         * no side effects for all these operations.
-         * OPTME: special-purpose helpers would avoid doing some
-         * unnecessary work in the helper for the 8 and 16 bit cases.
-         */
-        NeonGenTwoOpEnvFn *genenvfn = NULL;
-        void (*genfn)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64, MemOp) = NULL;
-
-        switch (opcode) {
-        case 0x16: /* SQDMULH, SQRDMULH */
-        {
-            static NeonGenTwoOpEnvFn * const fns[2][2] = {
-                { gen_helper_neon_qdmulh_s16, gen_helper_neon_qrdmulh_s16 },
-                { gen_helper_neon_qdmulh_s32, gen_helper_neon_qrdmulh_s32 },
-            };
-            assert(size == 1 || size == 2);
-            genenvfn = fns[size - 1][u];
-            break;
-        }
-        default:
-        case 0x1: /* SQADD, UQADD */
-        case 0x5: /* SQSUB, UQSUB */
-        case 0x9: /* SQSHL, UQSHL */
-        case 0xb: /* SQRSHL, UQRSHL */
-            g_assert_not_reached();
-        }
-
-        if (genenvfn) {
-            TCGv_i32 tcg_rn = tcg_temp_new_i32();
-            TCGv_i32 tcg_rm = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_rn, rn, 0, size);
-            read_vec_element_i32(s, tcg_rm, rm, 0, size);
-            genenvfn(tcg_rn, tcg_env, tcg_rn, tcg_rm);
-            tcg_gen_extu_i32_i64(tcg_rd, tcg_rn);
-        } else {
-            TCGv_i64 tcg_rn = tcg_temp_new_i64();
-            TCGv_i64 tcg_rm = tcg_temp_new_i64();
-            TCGv_i64 qc = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_rn, rn, 0, size | (u ? 0 : MO_SIGN));
-            read_vec_element(s, tcg_rm, rm, 0, size | (u ? 0 : MO_SIGN));
-            tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-            genfn(tcg_rd, qc, tcg_rn, tcg_rm, size);
-            tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-            if (!u) {
-                /* Truncate signed 64-bit result for writeback. */
-                tcg_gen_ext_i64(tcg_rd, tcg_rd, size);
-            }
-        }
-    }
-
-    write_fp_dreg(s, rd, tcg_rd);
-}
-
 /* AdvSIMD scalar three same extra
  *  31 30  29 28       24 23  22  21 20  16  15 14    11  10 9  5 4  0
  * +-----+---+-----------+------+---+------+---+--------+---+----+----+
@@ -10940,94 +10915,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Integer op subgroup of C3.6.16. */
-static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
-{
-    int is_q = extract32(insn, 30, 1);
-    int u = extract32(insn, 29, 1);
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 11, 5);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    switch (opcode) {
-    case 0x16: /* SQDMULH, SQRDMULH */
-        if (size == 0 || size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
-    default:
-        if (size == 3 && !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
-
-    case 0x0: /* SHADD, UHADD */
-    case 0x01: /* SQADD, UQADD */
-    case 0x02: /* SRHADD, URHADD */
-    case 0x04: /* SHSUB, UHSUB */
-    case 0x05: /* SQSUB, UQSUB */
-    case 0x06: /* CMGT, CMHI */
-    case 0x07: /* CMGE, CMHS */
-    case 0x08: /* SSHL, USHL */
-    case 0x09: /* SQSHL, UQSHL */
-    case 0x0a: /* SRSHL, URSHL */
-    case 0x0b: /* SQRSHL, UQRSHL */
-    case 0x0c: /* SMAX, UMAX */
-    case 0x0d: /* SMIN, UMIN */
-    case 0x0e: /* SABD, UABD */
-    case 0x0f: /* SABA, UABA */
-    case 0x10: /* ADD, SUB */
-    case 0x11: /* CMTST, CMEQ */
-    case 0x12: /* MLA, MLS */
-    case 0x13: /* MUL, PMUL */
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    switch (opcode) {
-    case 0x16: /* SQDMULH, SQRDMULH */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqrdmulh_qc, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqdmulh_qc, size);
-        }
-        return;
-    }
-    g_assert_not_reached();
-}
-
-/* AdvSIMD three same
- *  31  30  29  28       24 23  22  21 20  16 15    11  10 9    5 4    0
- * +---+---+---+-----------+------+---+------+--------+---+------+------+
- * | 0 | Q | U | 0 1 1 1 0 | size | 1 |  Rm  | opcode | 1 |  Rn  |  Rd  |
- * +---+---+---+-----------+------+---+------+--------+---+------+------+
- */
-static void disas_simd_three_reg_same(DisasContext *s, uint32_t insn)
-{
-    int opcode = extract32(insn, 11, 5);
-
-    switch (opcode) {
-    default:
-        disas_simd_3same_int(s, insn);
-        break;
-    case 0x3: /* logic ops */
-    case 0x14: /* SMAXP, UMAXP */
-    case 0x15: /* SMINP, UMINP */
-    case 0x17: /* ADDP */
-    case 0x18 ... 0x31: /* floating point ops */
-        unallocated_encoding(s);
-        break;
-    }
-}
-
 /* AdvSIMD three same extra
  *  31   30  29 28       24 23  22  21 20  16  15 14    11  10 9  5 4  0
  * +---+---+---+-----------+------+---+------+---+--------+---+----+----+
@@ -12214,9 +12101,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0b: /* SQDMULL, SQDMULL2 */
         is_long = true;
         break;
-    case 0x0c: /* SQDMULH */
-    case 0x0d: /* SQRDMULH */
-        break;
     case 0x1d: /* SQRDMLAH */
     case 0x1f: /* SQRDMLSH */
         if (!dc_isar_feature(aa64_rdm, s)) {
@@ -12278,6 +12162,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x05: /* FMLS */
     case 0x08: /* MUL */
     case 0x09: /* FMUL */
+    case 0x0c: /* SQDMULH */
+    case 0x0d: /* SQRDMULH */
     case 0x10: /* MLA */
     case 0x14: /* MLS */
     case 0x18: /* FMLAL2 */
@@ -12683,7 +12569,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
  */
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
-    { 0x0e200400, 0x9f200400, disas_simd_three_reg_same },
     { 0x0e008400, 0x9f208400, disas_simd_three_reg_same_extra },
     { 0x0e200000, 0x9f200c00, disas_simd_three_reg_diff },
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
@@ -12695,7 +12580,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x0e000000, 0xbf208c00, disas_simd_tb },
     { 0x0e000800, 0xbf208c00, disas_simd_zip_trn },
     { 0x2e000000, 0xbf208400, disas_simd_ext },
-    { 0x5e200400, 0xdf200400, disas_simd_scalar_three_reg_same },
     { 0x5e008400, 0xdf208400, disas_simd_scalar_three_reg_same_extra },
     { 0x5e200000, 0xdf200c00, disas_simd_scalar_three_reg_diff },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index d8e96386be..b05922b425 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -311,6 +311,38 @@ void HELPER(neon_sqrdmulh_h)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(neon_sqdmulh_idx_h)(void *vd, void *vn, void *vm,
+                                void *vq, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    int idx = simd_data(desc);
+    int16_t *d = vd, *n = vn, *m = (int16_t *)vm + H2(idx);
+
+    for (i = 0; i < opr_sz / 2; i += 16 / 2) {
+        int16_t mm = m[i];
+        for (j = 0; j < 16 / 2; ++j) {
+            d[i + j] = do_sqrdmlah_h(n[i + j], mm, 0, false, false, vq);
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(neon_sqrdmulh_idx_h)(void *vd, void *vn, void *vm,
+                                 void *vq, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    int idx = simd_data(desc);
+    int16_t *d = vd, *n = vn, *m = (int16_t *)vm + H2(idx);
+
+    for (i = 0; i < opr_sz / 2; i += 16 / 2) {
+        int16_t mm = m[i];
+        for (j = 0; j < 16 / 2; ++j) {
+            d[i + j] = do_sqrdmlah_h(n[i + j], mm, 0, false, true, vq);
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(sve2_sqrdmlah_h)(void *vd, void *vn, void *vm,
                              void *va, uint32_t desc)
 {
@@ -474,6 +506,38 @@ void HELPER(neon_sqrdmulh_s)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(neon_sqdmulh_idx_s)(void *vd, void *vn, void *vm,
+                                void *vq, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    int idx = simd_data(desc);
+    int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
+
+    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
+        int32_t mm = m[i];
+        for (j = 0; j < 16 / 4; ++j) {
+            d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, false, vq);
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(neon_sqrdmulh_idx_s)(void *vd, void *vn, void *vm,
+                                 void *vq, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    int idx = simd_data(desc);
+    int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
+
+    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
+        int32_t mm = m[i];
+        for (j = 0; j < 16 / 4; ++j) {
+            d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, true, vq);
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(sve2_sqrdmlah_s)(void *vd, void *vn, void *vm,
                              void *va, uint32_t desc)
 {
-- 
2.34.1


