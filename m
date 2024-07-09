Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5BEC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 00:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQyNF-0006g7-4L; Mon, 08 Jul 2024 20:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyNB-0006Sn-2c
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:06:21 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyN6-0001uv-Jk
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:06:20 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5b9794dad09so2394530eaf.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720483575; x=1721088375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JLkLo0gxnu230N78zzCEQoNXzOMuU1EfIP/dgPgNLg=;
 b=sJSSPtf34yP4WSpvoIWbOQQi25GomSNTyq7cXd4oxZSjhSvIlTMuMne3yUPtYPMNkk
 eUBA55gsVvhfyptNHGzZCnRBAH4XIptQhTi+BRVvd0e7Wm0vp1RlrTyR9KU7KlmaJ9bc
 TQgFHAHPks4aaYjTeHZ8jha5/7EpvwpbOOGw2f0HXOIr554yGWryK7BLBMZADsZP+Iub
 4CelGSJIyPrNJGJO9+2zcQc6ZWuVIxORG4CaWRkHh40TcXYTZCkFQmI4qrekSyu3T7/u
 3A48XdUm/Zr3LOFWTCAIQ4nvgMTmAwOtlr8FdrFLyu0+FwoIRk80UBsjxXUfVaTyYVDb
 scig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720483575; x=1721088375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JLkLo0gxnu230N78zzCEQoNXzOMuU1EfIP/dgPgNLg=;
 b=EgGrCLF9n1v7ycsCnxILY5RUa47Ux58QZQIra5QOj54gokrFSFV8ZI/dVECmJgD2LT
 WeHaXWVObmJ2X5Hq9lInv9Bl603w3ODc0YD4I+N9sVaSNnFkmnvFwFuebxQh7BRy6mbQ
 NkimTaBuYRsvdJEzk+oFyYrr0hxjjSVJSM+YyB2z9nkmdJm0YBOmmV+eQQtQZbth1zKJ
 zMwUzQceZvR2tjVC+DmeuXm1tPyM6RXmiuuHY+ANk82qMgJDPYqYimWnw2qnPbnj4KNu
 HYaFKM5r4rT3yJKj74Yraqg/w2XPwkDA/jB7MH4Et3OPNuBbu9p3OX/xPa/A1n3FjFoO
 OovA==
X-Gm-Message-State: AOJu0YwTfuA1UlMwNykZtpfDnVHyTLxhZh1gZDwemxsp/Z4LFtsB/1u2
 gRcLpVVwZ5RP7W2usluai1E3vQUPrelhwUJdlmLfk6pitgoMpXjdK9/9vkW9V6GrAPuvE6LDTKe
 Au28=
X-Google-Smtp-Source: AGHT+IEGLdkDltivLyQGM8+smI2IUeM5CH1Vmgx/GX1FDZXEGS6RcT7358LUWQibxAlxgngt4CvA4w==
X-Received: by 2002:a05:6359:6713:b0:1aa:b7d7:21f2 with SMTP id
 e5c5f4694b2df-1aade276accmr71193555d.1.1720483575062; 
 Mon, 08 Jul 2024 17:06:15 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d682b3fefsm316617a12.76.2024.07.08.17.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 17:06:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 3/6] target/arm: Convert SQDMULL, SQDMLAL,
 SQDMLSL to decodetree
Date: Mon,  8 Jul 2024 17:06:07 -0700
Message-ID: <20240709000610.382391-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709000610.382391-1-richard.henderson@linaro.org>
References: <20240709000610.382391-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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
 target/arm/tcg/translate-a64.c | 604 ++++++---------------------------
 target/arm/tcg/a64.decode      |  33 ++
 2 files changed, 138 insertions(+), 499 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 95a37c71bc..07b9cdd78f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5838,6 +5838,76 @@ TRANS(UABAL_v, do_3op_widening,
       a->esz, a->q, a->rd, a->rn, a->rm, -1,
       gen_uaba_i64, true)
 
+static void gen_sqdmull_h(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    tcg_gen_mul_i64(d, n, m);
+    gen_helper_neon_addl_saturate_s32(d, tcg_env, d, d);
+}
+
+static void gen_sqdmull_s(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    tcg_gen_mul_i64(d, n, m);
+    gen_helper_neon_addl_saturate_s64(d, tcg_env, d, d);
+}
+
+static void gen_sqdmlal_h(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_mul_i64(t, n, m);
+    gen_helper_neon_addl_saturate_s32(t, tcg_env, t, t);
+    gen_helper_neon_addl_saturate_s32(d, tcg_env, d, t);
+}
+
+static void gen_sqdmlal_s(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_mul_i64(t, n, m);
+    gen_helper_neon_addl_saturate_s64(t, tcg_env, t, t);
+    gen_helper_neon_addl_saturate_s64(d, tcg_env, d, t);
+}
+
+static void gen_sqdmlsl_h(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_mul_i64(t, n, m);
+    gen_helper_neon_addl_saturate_s32(t, tcg_env, t, t);
+    tcg_gen_neg_i64(t, t);
+    gen_helper_neon_addl_saturate_s32(d, tcg_env, d, t);
+}
+
+static void gen_sqdmlsl_s(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_mul_i64(t, n, m);
+    gen_helper_neon_addl_saturate_s64(t, tcg_env, t, t);
+    tcg_gen_neg_i64(t, t);
+    gen_helper_neon_addl_saturate_s64(d, tcg_env, d, t);
+}
+
+TRANS(SQDMULL_v, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, -1,
+      a->esz == MO_16 ? gen_sqdmull_h : gen_sqdmull_s, false)
+TRANS(SQDMLAL_v, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, -1,
+      a->esz == MO_16 ? gen_sqdmlal_h : gen_sqdmlal_s, true)
+TRANS(SQDMLSL_v, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, -1,
+      a->esz == MO_16 ? gen_sqdmlsl_h : gen_sqdmlsl_s, true)
+
+TRANS(SQDMULL_vi, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, a->idx,
+      a->esz == MO_16 ? gen_sqdmull_h : gen_sqdmull_s, false)
+TRANS(SQDMLAL_vi, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, a->idx,
+      a->esz == MO_16 ? gen_sqdmlal_h : gen_sqdmlal_s, true)
+TRANS(SQDMLSL_vi, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, a->idx,
+      a->esz == MO_16 ? gen_sqdmlsl_h : gen_sqdmlsl_s, true)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -5989,6 +6059,38 @@ static bool do_env_scalar3_idx_hs(DisasContext *s, arg_rrx_e *a,
 TRANS_FEAT(SQRDMLAH_si, aa64_rdm, do_env_scalar3_idx_hs, a, &f_scalar_sqrdmlah)
 TRANS_FEAT(SQRDMLSH_si, aa64_rdm, do_env_scalar3_idx_hs, a, &f_scalar_sqrdmlsh)
 
+static bool do_scalar_muladd_widening_idx(DisasContext *s, arg_rrx_e *a,
+                                          NeonGenTwo64OpFn *fn, bool acc)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        TCGv_i64 t1 = tcg_temp_new_i64();
+        TCGv_i64 t2 = tcg_temp_new_i64();
+        unsigned vsz, dofs;
+
+        if (acc) {
+            read_vec_element(s, t0, a->rd, 0, a->esz + 1);
+        }
+        read_vec_element(s, t1, a->rn, 0, a->esz | MO_SIGN);
+        read_vec_element(s, t2, a->rm, a->idx, a->esz | MO_SIGN);
+        fn(t0, t1, t2);
+
+        /* Clear the whole register first, then store scalar. */
+        vsz = vec_full_reg_size(s);
+        dofs = vec_full_reg_offset(s, a->rd);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, vsz, vsz, 0);
+        write_vec_element(s, t0, a->rd, 0, a->esz + 1);
+    }
+    return true;
+}
+
+TRANS(SQDMULL_si, do_scalar_muladd_widening_idx, a,
+      a->esz == MO_16 ? gen_sqdmull_h : gen_sqdmull_s, false)
+TRANS(SQDMLAL_si, do_scalar_muladd_widening_idx, a,
+      a->esz == MO_16 ? gen_sqdmlal_h : gen_sqdmlal_s, true)
+TRANS(SQDMLSL_si, do_scalar_muladd_widening_idx, a,
+      a->esz == MO_16 ? gen_sqdmlsl_h : gen_sqdmlsl_s, true)
+
 static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                               gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -9821,102 +9923,6 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
     }
 }
 
-/* AdvSIMD scalar three different
- *  31 30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
- * +-----+---+-----------+------+---+------+--------+-----+------+------+
- * | 0 1 | U | 1 1 1 1 0 | size | 1 |  Rm  | opcode | 0 0 |  Rn  |  Rd  |
- * +-----+---+-----------+------+---+------+--------+-----+------+------+
- */
-static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
-{
-    bool is_u = extract32(insn, 29, 1);
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 4);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    if (is_u) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0x9: /* SQDMLAL, SQDMLAL2 */
-    case 0xb: /* SQDMLSL, SQDMLSL2 */
-    case 0xd: /* SQDMULL, SQDMULL2 */
-        if (size == 0 || size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (size == 2) {
-        TCGv_i64 tcg_op1 = tcg_temp_new_i64();
-        TCGv_i64 tcg_op2 = tcg_temp_new_i64();
-        TCGv_i64 tcg_res = tcg_temp_new_i64();
-
-        read_vec_element(s, tcg_op1, rn, 0, MO_32 | MO_SIGN);
-        read_vec_element(s, tcg_op2, rm, 0, MO_32 | MO_SIGN);
-
-        tcg_gen_mul_i64(tcg_res, tcg_op1, tcg_op2);
-        gen_helper_neon_addl_saturate_s64(tcg_res, tcg_env, tcg_res, tcg_res);
-
-        switch (opcode) {
-        case 0xd: /* SQDMULL, SQDMULL2 */
-            break;
-        case 0xb: /* SQDMLSL, SQDMLSL2 */
-            tcg_gen_neg_i64(tcg_res, tcg_res);
-            /* fall through */
-        case 0x9: /* SQDMLAL, SQDMLAL2 */
-            read_vec_element(s, tcg_op1, rd, 0, MO_64);
-            gen_helper_neon_addl_saturate_s64(tcg_res, tcg_env,
-                                              tcg_res, tcg_op1);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-
-        write_fp_dreg(s, rd, tcg_res);
-    } else {
-        TCGv_i32 tcg_op1 = read_fp_hreg(s, rn);
-        TCGv_i32 tcg_op2 = read_fp_hreg(s, rm);
-        TCGv_i64 tcg_res = tcg_temp_new_i64();
-
-        gen_helper_neon_mull_s16(tcg_res, tcg_op1, tcg_op2);
-        gen_helper_neon_addl_saturate_s32(tcg_res, tcg_env, tcg_res, tcg_res);
-
-        switch (opcode) {
-        case 0xd: /* SQDMULL, SQDMULL2 */
-            break;
-        case 0xb: /* SQDMLSL, SQDMLSL2 */
-            gen_helper_neon_negl_u32(tcg_res, tcg_res);
-            /* fall through */
-        case 0x9: /* SQDMLAL, SQDMLAL2 */
-        {
-            TCGv_i64 tcg_op3 = tcg_temp_new_i64();
-            read_vec_element(s, tcg_op3, rd, 0, MO_32);
-            gen_helper_neon_addl_saturate_s32(tcg_res, tcg_env,
-                                              tcg_res, tcg_op3);
-            break;
-        }
-        default:
-            g_assert_not_reached();
-        }
-
-        tcg_gen_ext32u_i64(tcg_res, tcg_res);
-        write_fp_dreg(s, rd, tcg_res);
-    }
-}
-
 static void handle_2misc_64(DisasContext *s, int opcode, bool u,
                             TCGv_i64 tcg_rd, TCGv_i64 tcg_rn,
                             TCGv_i32 tcg_rmode, TCGv_ptr tcg_fpstatus)
@@ -10784,141 +10790,6 @@ static void gen_neon_addl(int size, bool is_sub, TCGv_i64 tcg_res,
     genfn(tcg_res, tcg_op1, tcg_op2);
 }
 
-static void handle_3rd_widening(DisasContext *s, int is_q, int is_u, int size,
-                                int opcode, int rd, int rn, int rm)
-{
-    /* 3-reg-different widening insns: 64 x 64 -> 128 */
-    TCGv_i64 tcg_res[2];
-    int pass, accop;
-
-    tcg_res[0] = tcg_temp_new_i64();
-    tcg_res[1] = tcg_temp_new_i64();
-
-    /* Does this op do an adding accumulate, a subtracting accumulate,
-     * or no accumulate at all?
-     */
-    switch (opcode) {
-    case 5:
-    case 8:
-    case 9:
-        accop = 1;
-        break;
-    case 10:
-    case 11:
-        accop = -1;
-        break;
-    default:
-        accop = 0;
-        break;
-    }
-
-    if (accop != 0) {
-        read_vec_element(s, tcg_res[0], rd, 0, MO_64);
-        read_vec_element(s, tcg_res[1], rd, 1, MO_64);
-    }
-
-    /* size == 2 means two 32x32->64 operations; this is worth special
-     * casing because we can generally handle it inline.
-     */
-    if (size == 2) {
-        for (pass = 0; pass < 2; pass++) {
-            TCGv_i64 tcg_op1 = tcg_temp_new_i64();
-            TCGv_i64 tcg_op2 = tcg_temp_new_i64();
-            TCGv_i64 tcg_passres;
-            MemOp memop = MO_32 | (is_u ? 0 : MO_SIGN);
-
-            int elt = pass + is_q * 2;
-
-            read_vec_element(s, tcg_op1, rn, elt, memop);
-            read_vec_element(s, tcg_op2, rm, elt, memop);
-
-            if (accop == 0) {
-                tcg_passres = tcg_res[pass];
-            } else {
-                tcg_passres = tcg_temp_new_i64();
-            }
-
-            switch (opcode) {
-            case 9: /* SQDMLAL, SQDMLAL2 */
-            case 11: /* SQDMLSL, SQDMLSL2 */
-            case 13: /* SQDMULL, SQDMULL2 */
-                tcg_gen_mul_i64(tcg_passres, tcg_op1, tcg_op2);
-                gen_helper_neon_addl_saturate_s64(tcg_passres, tcg_env,
-                                                  tcg_passres, tcg_passres);
-                break;
-            default:
-            case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
-            case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
-            case 12: /* UMULL, UMULL2, SMULL, SMULL2 */
-            case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
-            case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
-            case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
-            case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
-                g_assert_not_reached();
-            }
-
-            if (accop != 0) {
-                /* saturating accumulate ops */
-                if (accop < 0) {
-                    tcg_gen_neg_i64(tcg_passres, tcg_passres);
-                }
-                gen_helper_neon_addl_saturate_s64(tcg_res[pass], tcg_env,
-                                                  tcg_res[pass], tcg_passres);
-            }
-        }
-    } else {
-        /* size 0 or 1, generally helper functions */
-        for (pass = 0; pass < 2; pass++) {
-            TCGv_i32 tcg_op1 = tcg_temp_new_i32();
-            TCGv_i32 tcg_op2 = tcg_temp_new_i32();
-            TCGv_i64 tcg_passres;
-            int elt = pass + is_q * 2;
-
-            read_vec_element_i32(s, tcg_op1, rn, elt, MO_32);
-            read_vec_element_i32(s, tcg_op2, rm, elt, MO_32);
-
-            if (accop == 0) {
-                tcg_passres = tcg_res[pass];
-            } else {
-                tcg_passres = tcg_temp_new_i64();
-            }
-
-            switch (opcode) {
-            case 9: /* SQDMLAL, SQDMLAL2 */
-            case 11: /* SQDMLSL, SQDMLSL2 */
-            case 13: /* SQDMULL, SQDMULL2 */
-                assert(size == 1);
-                gen_helper_neon_mull_s16(tcg_passres, tcg_op1, tcg_op2);
-                gen_helper_neon_addl_saturate_s32(tcg_passres, tcg_env,
-                                                  tcg_passres, tcg_passres);
-                break;
-            default:
-            case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
-            case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
-            case 12: /* UMULL, UMULL2, SMULL, SMULL2 */
-            case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
-            case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
-            case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
-            case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
-                g_assert_not_reached();
-            }
-
-            if (accop != 0) {
-                /* saturating accumulate ops */
-                if (accop < 0) {
-                    gen_helper_neon_negl_u32(tcg_passres, tcg_passres);
-                }
-                gen_helper_neon_addl_saturate_s32(tcg_res[pass], tcg_env,
-                                                  tcg_res[pass],
-                                                  tcg_passres);
-            }
-        }
-    }
-
-    write_vec_element(s, tcg_res[0], rd, 0, MO_64);
-    write_vec_element(s, tcg_res[1], rd, 1, MO_64);
-}
-
 static void handle_3rd_wide(DisasContext *s, int is_q, int is_u, int size,
                             int opcode, int rd, int rn, int rm)
 {
@@ -11075,32 +10946,17 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
             break;
         }
         return;
-    case 9: /* SQDMLAL, SQDMLAL2 */
-    case 11: /* SQDMLSL, SQDMLSL2 */
-    case 13: /* SQDMULL, SQDMULL2 */
-        if (is_u || size == 0) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* 64 x 64 -> 128 */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-
-        handle_3rd_widening(s, is_q, is_u, size, opcode, rd, rn, rm);
-        break;
     default:
     case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
     case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
     case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
     case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
     case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
+    case 9: /* SQDMLAL, SQDMLAL2 */
     case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
+    case 11: /* SQDMLSL, SQDMLSL2 */
     case 12: /* SMULL, SMULL2, UMULL, UMULL2 */
+    case 13: /* SQDMULL, SQDMULL2 */
         /* opcode 15 not allocated */
         unallocated_encoding(s);
         break;
@@ -12049,253 +11905,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     }
 }
 
-/* AdvSIMD scalar x indexed element
- *  31 30  29 28       24 23  22 21  20  19  16 15 12  11  10 9    5 4    0
- * +-----+---+-----------+------+---+---+------+-----+---+---+------+------+
- * | 0 1 | U | 1 1 1 1 1 | size | L | M |  Rm  | opc | H | 0 |  Rn  |  Rd  |
- * +-----+---+-----------+------+---+---+------+-----+---+---+------+------+
- * AdvSIMD vector x indexed element
- *   31  30  29 28       24 23  22 21  20  19  16 15 12  11  10 9    5 4    0
- * +---+---+---+-----------+------+---+---+------+-----+---+---+------+------+
- * | 0 | Q | U | 0 1 1 1 1 | size | L | M |  Rm  | opc | H | 0 |  Rn  |  Rd  |
- * +---+---+---+-----------+------+---+---+------+-----+---+---+------+------+
- */
-static void disas_simd_indexed(DisasContext *s, uint32_t insn)
-{
-    /* This encoding has two kinds of instruction:
-     *  normal, where we perform elt x idxelt => elt for each
-     *     element in the vector
-     *  long, where we perform elt x idxelt and generate a result of
-     *     double the width of the input element
-     * The long ops have a 'part' specifier (ie come in INSN, INSN2 pairs).
-     */
-    bool is_scalar = extract32(insn, 28, 1);
-    bool is_q = extract32(insn, 30, 1);
-    bool u = extract32(insn, 29, 1);
-    int size = extract32(insn, 22, 2);
-    int l = extract32(insn, 21, 1);
-    int m = extract32(insn, 20, 1);
-    /* Note that the Rm field here is only 4 bits, not 5 as it usually is */
-    int rm = extract32(insn, 16, 4);
-    int opcode = extract32(insn, 12, 4);
-    int h = extract32(insn, 11, 1);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    int index;
-
-    switch (16 * u + opcode) {
-    case 0x03: /* SQDMLAL, SQDMLAL2 */
-    case 0x07: /* SQDMLSL, SQDMLSL2 */
-    case 0x0b: /* SQDMULL, SQDMULL2 */
-        break;
-    default:
-    case 0x00: /* FMLAL */
-    case 0x01: /* FMLA */
-    case 0x02: /* SMLAL, SMLAL2 */
-    case 0x04: /* FMLSL */
-    case 0x05: /* FMLS */
-    case 0x06: /* SMLSL, SMLSL2 */
-    case 0x08: /* MUL */
-    case 0x09: /* FMUL */
-    case 0x0a: /* SMULL, SMULL2 */
-    case 0x0c: /* SQDMULH */
-    case 0x0d: /* SQRDMULH */
-    case 0x0e: /* SDOT */
-    case 0x0f: /* SUDOT / BFDOT / USDOT / BFMLAL */
-    case 0x10: /* MLA */
-    case 0x11: /* FCMLA #0 */
-    case 0x12: /* UMLAL, UMLAL2 */
-    case 0x13: /* FCMLA #90 */
-    case 0x14: /* MLS */
-    case 0x15: /* FCMLA #180 */
-    case 0x16: /* UMLSL, UMLSL2 */
-    case 0x17: /* FCMLA #270 */
-    case 0x18: /* FMLAL2 */
-    case 0x19: /* FMULX */
-    case 0x1a: /* UMULL, UMULL2 */
-    case 0x1c: /* FMLSL2 */
-    case 0x1d: /* SQRDMLAH */
-    case 0x1e: /* UDOT */
-    case 0x1f: /* SQRDMLSH */
-        unallocated_encoding(s);
-        return;
-    }
-
-    /* Given MemOp size, adjust register and indexing.  */
-    switch (size) {
-    case MO_8:
-    case MO_64:
-        unallocated_encoding(s);
-        return;
-    case MO_16:
-        index = h << 2 | l << 1 | m;
-        break;
-    case MO_32:
-        index = h << 1 | l;
-        rm |= m << 4;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (size == 3) {
-        g_assert_not_reached();
-    } else {
-        /* long ops: 16x16->32 or 32x32->64 */
-        TCGv_i64 tcg_res[2];
-        int pass;
-        bool satop = extract32(opcode, 0, 1);
-        MemOp memop = MO_32;
-
-        if (satop || !u) {
-            memop |= MO_SIGN;
-        }
-
-        if (size == 2) {
-            TCGv_i64 tcg_idx = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_idx, rm, index, memop);
-
-            for (pass = 0; pass < (is_scalar ? 1 : 2); pass++) {
-                TCGv_i64 tcg_op = tcg_temp_new_i64();
-                TCGv_i64 tcg_passres;
-                int passelt;
-
-                if (is_scalar) {
-                    passelt = 0;
-                } else {
-                    passelt = pass + (is_q * 2);
-                }
-
-                read_vec_element(s, tcg_op, rn, passelt, memop);
-
-                tcg_res[pass] = tcg_temp_new_i64();
-
-                if (opcode == 0xa || opcode == 0xb) {
-                    /* Non-accumulating ops */
-                    tcg_passres = tcg_res[pass];
-                } else {
-                    tcg_passres = tcg_temp_new_i64();
-                }
-
-                tcg_gen_mul_i64(tcg_passres, tcg_op, tcg_idx);
-
-                if (satop) {
-                    /* saturating, doubling */
-                    gen_helper_neon_addl_saturate_s64(tcg_passres, tcg_env,
-                                                      tcg_passres, tcg_passres);
-                }
-
-                if (opcode == 0xa || opcode == 0xb) {
-                    continue;
-                }
-
-                /* Accumulating op: handle accumulate step */
-                read_vec_element(s, tcg_res[pass], rd, pass, MO_64);
-
-                switch (opcode) {
-                case 0x7: /* SQDMLSL, SQDMLSL2 */
-                    tcg_gen_neg_i64(tcg_passres, tcg_passres);
-                    /* fall through */
-                case 0x3: /* SQDMLAL, SQDMLAL2 */
-                    gen_helper_neon_addl_saturate_s64(tcg_res[pass], tcg_env,
-                                                      tcg_res[pass],
-                                                      tcg_passres);
-                    break;
-                default:
-                case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
-                case 0x6: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
-                    g_assert_not_reached();
-                }
-            }
-
-            clear_vec_high(s, !is_scalar, rd);
-        } else {
-            TCGv_i32 tcg_idx = tcg_temp_new_i32();
-
-            assert(size == 1);
-            read_vec_element_i32(s, tcg_idx, rm, index, size);
-
-            if (!is_scalar) {
-                /* The simplest way to handle the 16x16 indexed ops is to
-                 * duplicate the index into both halves of the 32 bit tcg_idx
-                 * and then use the usual Neon helpers.
-                 */
-                tcg_gen_deposit_i32(tcg_idx, tcg_idx, tcg_idx, 16, 16);
-            }
-
-            for (pass = 0; pass < (is_scalar ? 1 : 2); pass++) {
-                TCGv_i32 tcg_op = tcg_temp_new_i32();
-                TCGv_i64 tcg_passres;
-
-                if (is_scalar) {
-                    read_vec_element_i32(s, tcg_op, rn, pass, size);
-                } else {
-                    read_vec_element_i32(s, tcg_op, rn,
-                                         pass + (is_q * 2), MO_32);
-                }
-
-                tcg_res[pass] = tcg_temp_new_i64();
-
-                if (opcode == 0xa || opcode == 0xb) {
-                    /* Non-accumulating ops */
-                    tcg_passres = tcg_res[pass];
-                } else {
-                    tcg_passres = tcg_temp_new_i64();
-                }
-
-                if (memop & MO_SIGN) {
-                    gen_helper_neon_mull_s16(tcg_passres, tcg_op, tcg_idx);
-                } else {
-                    gen_helper_neon_mull_u16(tcg_passres, tcg_op, tcg_idx);
-                }
-                if (satop) {
-                    gen_helper_neon_addl_saturate_s32(tcg_passres, tcg_env,
-                                                      tcg_passres, tcg_passres);
-                }
-
-                if (opcode == 0xa || opcode == 0xb) {
-                    continue;
-                }
-
-                /* Accumulating op: handle accumulate step */
-                read_vec_element(s, tcg_res[pass], rd, pass, MO_64);
-
-                switch (opcode) {
-                case 0x7: /* SQDMLSL, SQDMLSL2 */
-                    gen_helper_neon_negl_u32(tcg_passres, tcg_passres);
-                    /* fall through */
-                case 0x3: /* SQDMLAL, SQDMLAL2 */
-                    gen_helper_neon_addl_saturate_s32(tcg_res[pass], tcg_env,
-                                                      tcg_res[pass],
-                                                      tcg_passres);
-                    break;
-                default:
-                case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
-                case 0x6: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
-                    g_assert_not_reached();
-                }
-            }
-
-            if (is_scalar) {
-                tcg_gen_ext32u_i64(tcg_res[0], tcg_res[0]);
-            }
-        }
-
-        if (is_scalar) {
-            tcg_res[1] = tcg_constant_i64(0);
-        }
-
-        for (pass = 0; pass < 2; pass++) {
-            write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
-        }
-    }
-}
-
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -12306,16 +11915,13 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x0e200000, 0x9f200c00, disas_simd_three_reg_diff },
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
     { 0x0e300800, 0x9f3e0c00, disas_simd_across_lanes },
-    { 0x0f000000, 0x9f000400, disas_simd_indexed }, /* vector indexed */
     /* simd_mod_imm decode is a subset of simd_shift_imm, so must precede it */
     { 0x0f000400, 0x9ff80400, disas_simd_mod_imm },
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
     { 0x0e000000, 0xbf208c00, disas_simd_tb },
     { 0x0e000800, 0xbf208c00, disas_simd_zip_trn },
     { 0x2e000000, 0xbf208400, disas_simd_ext },
-    { 0x5e200000, 0xdf200c00, disas_simd_scalar_three_reg_diff },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
-    { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x00000000, 0x00000000, NULL }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e626ee067f..cf69e7e1be 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -785,6 +785,14 @@ SQRDMULH_s      0111 1110 ..1 ..... 10110 1 ..... ..... @rrr_e
 SQRDMLAH_s      0111 1110 ..0 ..... 10000 1 ..... ..... @rrr_e
 SQRDMLSH_s      0111 1110 ..0 ..... 10001 1 ..... ..... @rrr_e
 
+# Decode scalar x scalar as scalar x indexed, with index 0.
+SQDMULL_si      0101 1110 011 rm:5  11010 0 rn:5  rd:5  &rrx_e idx=0 esz=1
+SQDMULL_si      0101 1110 101 rm:5  11010 0 rn:5  rd:5  &rrx_e idx=0 esz=2
+SQDMLAL_si      0101 1110 011 rm:5  10010 0 rn:5  rd:5  &rrx_e idx=0 esz=1
+SQDMLAL_si      0101 1110 101 rm:5  10010 0 rn:5  rd:5  &rrx_e idx=0 esz=2
+SQDMLSL_si      0101 1110 011 rm:5  10110 0 rn:5  rd:5  &rrx_e idx=0 esz=1
+SQDMLSL_si      0101 1110 101 rm:5  10110 0 rn:5  rd:5  &rrx_e idx=0 esz=2
+
 ### Advanced SIMD scalar pairwise
 
 FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
@@ -978,6 +986,13 @@ UABAL_v         0.10 1110 ..1 ..... 01010 0 ..... ..... @qrrr_e
 SABDL_v         0.00 1110 ..1 ..... 01110 0 ..... ..... @qrrr_e
 UABDL_v         0.10 1110 ..1 ..... 01110 0 ..... ..... @qrrr_e
 
+SQDMULL_v       0.00 1110 011 ..... 11010 0 ..... ..... @qrrr_h
+SQDMULL_v       0.00 1110 101 ..... 11010 0 ..... ..... @qrrr_s
+SQDMLAL_v       0.00 1110 011 ..... 10010 0 ..... ..... @qrrr_h
+SQDMLAL_v       0.00 1110 101 ..... 10010 0 ..... ..... @qrrr_s
+SQDMLSL_v       0.00 1110 011 ..... 10110 0 ..... ..... @qrrr_h
+SQDMLSL_v       0.00 1110 101 ..... 10110 0 ..... ..... @qrrr_s
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1008,6 +1023,15 @@ SQRDMLAH_si     0111 1111 10 .. .... 1101 . 0 ..... .....   @rrx_s
 SQRDMLSH_si     0111 1111 01 .. .... 1111 . 0 ..... .....   @rrx_h
 SQRDMLSH_si     0111 1111 10 .. .... 1111 . 0 ..... .....   @rrx_s
 
+SQDMULL_si      0101 1111 01 .. .... 1011 . 0 ..... .....   @rrx_h
+SQDMULL_si      0101 1111 10 . ..... 1011 . 0 ..... .....   @rrx_s
+
+SQDMLAL_si      0101 1111 01 .. .... 0011 . 0 ..... .....   @rrx_h
+SQDMLAL_si      0101 1111 10 . ..... 0011 . 0 ..... .....   @rrx_s
+
+SQDMLSL_si      0101 1111 01 .. .... 0111 . 0 ..... .....   @rrx_h
+SQDMLSL_si      0101 1111 10 . ..... 0111 . 0 ..... .....   @rrx_s
+
 ### Advanced SIMD vector x indexed element
 
 FMUL_vi         0.00 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
@@ -1078,6 +1102,15 @@ SMLSL_vi        0.00 1111 10 . ..... 0110 . 0 ..... .....   @qrrx_s
 UMLSL_vi        0.10 1111 01 .. .... 0110 . 0 ..... .....   @qrrx_h
 UMLSL_vi        0.10 1111 10 . ..... 0110 . 0 ..... .....   @qrrx_s
 
+SQDMULL_vi      0.00 1111 01 .. .... 1011 . 0 ..... .....   @qrrx_h
+SQDMULL_vi      0.00 1111 10 . ..... 1011 . 0 ..... .....   @qrrx_s
+
+SQDMLAL_vi      0.00 1111 01 .. .... 0011 . 0 ..... .....   @qrrx_h
+SQDMLAL_vi      0.00 1111 10 . ..... 0011 . 0 ..... .....   @qrrx_s
+
+SQDMLSL_vi      0.00 1111 01 .. .... 0111 . 0 ..... .....   @qrrx_h
+SQDMLSL_vi      0.00 1111 10 . ..... 0111 . 0 ..... .....   @qrrx_s
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
-- 
2.43.0


