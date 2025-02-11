Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA35BC021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6S-0007N6-CS; Tue, 11 Feb 2025 11:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5V-0006Sm-N2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:17 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5P-00034x-FM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:17 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dcb33cba1so2239970f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291169; x=1739895969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o775MXMIHycAwNVfY9God7JvImfw+wZLCDndgtLg4EE=;
 b=EhekVqXxL0M7fvCjoZzpD8XZUZy2XSa602ymzWE2soual4mSd58CD2P+XKaMNyHE8Q
 lnAqv8fEDjoLh7tXIdwWRbRQHR8T0qoUOR5mIyPfyRNR9qWyznOqSdkZjpPuCd3/G6Pi
 VP+9iEw48deUS8SHV3sl8h7vmzxcEdi9IfmP7VCU61vepQHPtN8v4PLxDsdSND4DLANz
 u7oLX01Xgqw8hTCvJrViq/RWe1/JCZNqJt8CxJ3+fl/P7fYsyAbJJQFABet0e25S52ik
 j+mL2qDp8YynjoJZ0PK3MG9h9ObUxSk2rjbyCZ1bdca9J7/Y/N/foDidK+OjFiLUJUWx
 MR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291169; x=1739895969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o775MXMIHycAwNVfY9God7JvImfw+wZLCDndgtLg4EE=;
 b=v+nHjsQwnO00mOsNNCoMbM4jhe4NL6+otENoyMzW0Rdl/6zwYaqsTJ1GqeySNCwGLu
 cBe5QQqNZfDBA/FzULVaAUHsCz6tCBrnRX2wJYbKfiOwLNzMhWpu/lOR90q0QeBWweTZ
 i4KwCPm+bg2Q/xeQlDtpK9upTBUqjh/QhKxD158SWgu41QBNRL5v+S22xDxWpGnRn1M9
 RA2Za8EWARcU3oXgqgytRuXrRfv8cdXBfEo8XOlh4L/rmStm1v/gCDZq163QpvPQaQeS
 TjUDtZ1W/QNwY8te885kwy88CztIP8/9JqBBR2Jihi4lot/75o0vpPrhMg8BDOtx7bR8
 tRHQ==
X-Gm-Message-State: AOJu0YyydtKP8WRFQoLoRT67SPTxwMaii9Z6Di0erSsMBkJjgN5lzM7f
 BRY/Efo8IJh1GBFb8PYklpfRIknwwx7xXQIl2vocqTCQjJoSPrxm0gXoEHbDMZiMWgKfiw2gdB4
 +
X-Gm-Gg: ASbGncsLeRLB+LZP08cL60OuG865bydIMwcOza06GT0OzUE+uzVmAoWzH/Su+pxQ19E
 iWij4g2Is4qAKH24CHfAim3OJn0D9I4dg6jbbX5S0RKlJuegdnc48bRzSaJvhlpSgjjKr9Vkkox
 j985R1VSog5XNJAdk8TmPK+ZLuCC0byE3P8vQUPquxp+xAOmkhOT9JbHuSCg+ofSuyc9fh2hNAn
 vPxLj1qp/5AW7QZB2kb8elMwSqHqruc7EopQNKxfNVh3vr7oMOPkTI8g4Jscoc6YaT3oqFFaUFW
 iu81bf5Ewp901OCLIMj6
X-Google-Smtp-Source: AGHT+IH+g2ULAtSETKaahZfc2k3ilyWVbbZTAaS6eh+TruFeSSleG4fckoyPvI88LrMmCih5w/OyDg==
X-Received: by 2002:a05:6000:1846:b0:38d:e411:98c2 with SMTP id
 ffacd0b85a97d-38de41198dfmr3904507f8f.32.1739291169258; 
 Tue, 11 Feb 2025 08:26:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/68] target/arm: Use FPST_FPCR_AH for FRECPE, FRECPS, FRECPX,
 FRSQRTE, FRSQRTS
Date: Tue, 11 Feb 2025 16:24:57 +0000
Message-Id: <20250211162554.4135349-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

For the instructions FRECPE, FRECPS, FRECPX, FRSQRTE, FRSQRTS, use
FPST_FPCR_AH or FPST_FPCR_AH_F16 when FPCR.AH is 1, so that they get
the required behaviour changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.h |  13 ++++
 target/arm/tcg/translate-a64.c | 119 +++++++++++++++++++++++++--------
 target/arm/tcg/translate-sve.c |  30 ++++++---
 3 files changed, 127 insertions(+), 35 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 0fcf7cb63ad..7d3b59ccd96 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -185,6 +185,19 @@ static inline TCGv_ptr pred_full_reg_ptr(DisasContext *s, int regno)
     return ret;
 }
 
+/*
+ * Return the ARMFPStatusFlavour to use based on element size and
+ * whether FPCR.AH is set.
+ */
+static inline ARMFPStatusFlavour select_ah_fpst(DisasContext *s, MemOp esz)
+{
+    if (s->fpcr_ah) {
+        return esz == MO_16 ? FPST_AH_F16 : FPST_AH;
+    } else {
+        return esz == MO_16 ? FPST_A64_F16 : FPST_A64;
+    }
+}
+
 bool disas_sve(DisasContext *, uint32_t);
 bool disas_sme(DisasContext *, uint32_t);
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index be3f4489e5e..1556980c761 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -712,10 +712,10 @@ static void gen_gvec_op3_ool(DisasContext *s, bool is_q, int rd,
  * an out-of-line helper.
  */
 static void gen_gvec_op3_fpst(DisasContext *s, bool is_q, int rd, int rn,
-                              int rm, bool is_fp16, int data,
+                              int rm, ARMFPStatusFlavour fpsttype, int data,
                               gen_helper_gvec_3_ptr *fn)
 {
-    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_A64_F16 : FPST_A64);
+    TCGv_ptr fpst = fpstatus_ptr(fpsttype);
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn),
                        vec_full_reg_offset(s, rm), fpst,
@@ -5025,14 +5025,16 @@ typedef struct FPScalar {
     void (*gen_d)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
 } FPScalar;
 
-static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
+static bool do_fp3_scalar_with_fpsttype(DisasContext *s, arg_rrr_e *a,
+                                        const FPScalar *f,
+                                        ARMFPStatusFlavour fpsttype)
 {
     switch (a->esz) {
     case MO_64:
         if (fp_access_check(s)) {
             TCGv_i64 t0 = read_fp_dreg(s, a->rn);
             TCGv_i64 t1 = read_fp_dreg(s, a->rm);
-            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_A64));
+            f->gen_d(t0, t0, t1, fpstatus_ptr(fpsttype));
             write_fp_dreg(s, a->rd, t0);
         }
         break;
@@ -5040,7 +5042,7 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
         if (fp_access_check(s)) {
             TCGv_i32 t0 = read_fp_sreg(s, a->rn);
             TCGv_i32 t1 = read_fp_sreg(s, a->rm);
-            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_A64));
+            f->gen_s(t0, t0, t1, fpstatus_ptr(fpsttype));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -5051,7 +5053,7 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
         if (fp_access_check(s)) {
             TCGv_i32 t0 = read_fp_hreg(s, a->rn);
             TCGv_i32 t1 = read_fp_hreg(s, a->rm);
-            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_A64_F16));
+            f->gen_h(t0, t0, t1, fpstatus_ptr(fpsttype));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -5061,6 +5063,18 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
     return true;
 }
 
+static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
+{
+    return do_fp3_scalar_with_fpsttype(s, a, f,
+                                       a->esz == MO_16 ?
+                                       FPST_A64_F16 : FPST_A64);
+}
+
+static bool do_fp3_scalar_ah(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
+{
+    return do_fp3_scalar_with_fpsttype(s, a, f, select_ah_fpst(s, a->esz));
+}
+
 static const FPScalar f_scalar_fadd = {
     gen_helper_vfp_addh,
     gen_helper_vfp_adds,
@@ -5214,14 +5228,14 @@ static const FPScalar f_scalar_frecps = {
     gen_helper_recpsf_f32,
     gen_helper_recpsf_f64,
 };
-TRANS(FRECPS_s, do_fp3_scalar, a, &f_scalar_frecps)
+TRANS(FRECPS_s, do_fp3_scalar_ah, a, &f_scalar_frecps)
 
 static const FPScalar f_scalar_frsqrts = {
     gen_helper_rsqrtsf_f16,
     gen_helper_rsqrtsf_f32,
     gen_helper_rsqrtsf_f64,
 };
-TRANS(FRSQRTS_s, do_fp3_scalar, a, &f_scalar_frsqrts)
+TRANS(FRSQRTS_s, do_fp3_scalar_ah, a, &f_scalar_frsqrts)
 
 static bool do_fcmp0_s(DisasContext *s, arg_rr_e *a,
                        const FPScalar *f, bool swap)
@@ -5472,8 +5486,10 @@ TRANS(CMHS_s, do_cmop_d, a, TCG_COND_GEU)
 TRANS(CMEQ_s, do_cmop_d, a, TCG_COND_EQ)
 TRANS(CMTST_s, do_cmop_d, a, TCG_COND_TSTNE)
 
-static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
-                          gen_helper_gvec_3_ptr * const fns[3])
+static bool do_fp3_vector_with_fpsttype(DisasContext *s, arg_qrrr_e *a,
+                                        int data,
+                                        gen_helper_gvec_3_ptr * const fns[3],
+                                        ARMFPStatusFlavour fpsttype)
 {
     MemOp esz = a->esz;
     int check = fp_access_check_vector_hsd(s, a->q, esz);
@@ -5482,11 +5498,26 @@ static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
         return check == 0;
     }
 
-    gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
-                      esz == MO_16, data, fns[esz - 1]);
+    gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm, fpsttype,
+                      data, fns[esz - 1]);
     return true;
 }
 
+static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
+                          gen_helper_gvec_3_ptr * const fns[3])
+{
+    return do_fp3_vector_with_fpsttype(s, a, data, fns,
+                                       a->esz == MO_16 ?
+                                       FPST_A64_F16 : FPST_A64);
+}
+
+static bool do_fp3_vector_ah(DisasContext *s, arg_qrrr_e *a, int data,
+                             gen_helper_gvec_3_ptr * const f[3])
+{
+    return do_fp3_vector_with_fpsttype(s, a, data, f,
+                                       select_ah_fpst(s, a->esz));
+}
+
 static gen_helper_gvec_3_ptr * const f_vector_fadd[3] = {
     gen_helper_gvec_fadd_h,
     gen_helper_gvec_fadd_s,
@@ -5611,14 +5642,14 @@ static gen_helper_gvec_3_ptr * const f_vector_frecps[3] = {
     gen_helper_gvec_recps_s,
     gen_helper_gvec_recps_d,
 };
-TRANS(FRECPS_v, do_fp3_vector, a, 0, f_vector_frecps)
+TRANS(FRECPS_v, do_fp3_vector_ah, a, 0, f_vector_frecps)
 
 static gen_helper_gvec_3_ptr * const f_vector_frsqrts[3] = {
     gen_helper_gvec_rsqrts_h,
     gen_helper_gvec_rsqrts_s,
     gen_helper_gvec_rsqrts_d,
 };
-TRANS(FRSQRTS_v, do_fp3_vector, a, 0, f_vector_frsqrts)
+TRANS(FRSQRTS_v, do_fp3_vector_ah, a, 0, f_vector_frsqrts)
 
 static gen_helper_gvec_3_ptr * const f_vector_faddp[3] = {
     gen_helper_gvec_faddp_h,
@@ -6374,7 +6405,8 @@ static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
     }
 
     gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
-                      esz == MO_16, a->idx, fns[esz - 1]);
+                      esz == MO_16 ? FPST_A64_F16 : FPST_A64,
+                      a->idx, fns[esz - 1]);
     return true;
 }
 
@@ -8383,8 +8415,9 @@ typedef struct FPScalar1 {
     void (*gen_d)(TCGv_i64, TCGv_i64, TCGv_ptr);
 } FPScalar1;
 
-static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
-                          const FPScalar1 *f, int rmode)
+static bool do_fp1_scalar_with_fpsttype(DisasContext *s, arg_rr_e *a,
+                                        const FPScalar1 *f, int rmode,
+                                        ARMFPStatusFlavour fpsttype)
 {
     TCGv_i32 tcg_rmode = NULL;
     TCGv_ptr fpst;
@@ -8396,7 +8429,7 @@ static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+    fpst = fpstatus_ptr(fpsttype);
     if (rmode >= 0) {
         tcg_rmode = gen_set_rmode(rmode, fpst);
     }
@@ -8427,6 +8460,20 @@ static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
     return true;
 }
 
+static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
+                          const FPScalar1 *f, int rmode)
+{
+    return do_fp1_scalar_with_fpsttype(s, a, f, rmode,
+                                       a->esz == MO_16 ?
+                                       FPST_A64_F16 : FPST_A64);
+}
+
+static bool do_fp1_scalar_ah(DisasContext *s, arg_rr_e *a,
+                             const FPScalar1 *f, int rmode)
+{
+    return do_fp1_scalar_with_fpsttype(s, a, f, rmode, select_ah_fpst(s, a->esz));
+}
+
 static const FPScalar1 f_scalar_fsqrt = {
     gen_helper_vfp_sqrth,
     gen_helper_vfp_sqrts,
@@ -8481,21 +8528,21 @@ static const FPScalar1 f_scalar_frecpe = {
     gen_helper_recpe_f32,
     gen_helper_recpe_f64,
 };
-TRANS(FRECPE_s, do_fp1_scalar, a, &f_scalar_frecpe, -1)
+TRANS(FRECPE_s, do_fp1_scalar_ah, a, &f_scalar_frecpe, -1)
 
 static const FPScalar1 f_scalar_frecpx = {
     gen_helper_frecpx_f16,
     gen_helper_frecpx_f32,
     gen_helper_frecpx_f64,
 };
-TRANS(FRECPX_s, do_fp1_scalar, a, &f_scalar_frecpx, -1)
+TRANS(FRECPX_s, do_fp1_scalar_ah, a, &f_scalar_frecpx, -1)
 
 static const FPScalar1 f_scalar_frsqrte = {
     gen_helper_rsqrte_f16,
     gen_helper_rsqrte_f32,
     gen_helper_rsqrte_f64,
 };
-TRANS(FRSQRTE_s, do_fp1_scalar, a, &f_scalar_frsqrte, -1)
+TRANS(FRSQRTE_s, do_fp1_scalar_ah, a, &f_scalar_frsqrte, -1)
 
 static bool trans_FCVT_s_ds(DisasContext *s, arg_rr *a)
 {
@@ -9350,9 +9397,10 @@ TRANS_FEAT(FRINT64Z_v, aa64_frint, do_fp1_vector, a,
            &f_scalar_frint64, FPROUNDING_ZERO)
 TRANS_FEAT(FRINT64X_v, aa64_frint, do_fp1_vector, a, &f_scalar_frint64, -1)
 
-static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
-                             int rd, int rn, int data,
-                             gen_helper_gvec_2_ptr * const fns[3])
+static bool do_gvec_op2_fpst_with_fpsttype(DisasContext *s, MemOp esz,
+                                           bool is_q, int rd, int rn, int data,
+                                           gen_helper_gvec_2_ptr * const fns[3],
+                                           ARMFPStatusFlavour fpsttype)
 {
     int check = fp_access_check_vector_hsd(s, is_q, esz);
     TCGv_ptr fpst;
@@ -9361,7 +9409,7 @@ static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+    fpst = fpstatus_ptr(fpsttype);
     tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn), fpst,
                        is_q ? 16 : 8, vec_full_reg_size(s),
@@ -9369,6 +9417,23 @@ static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
     return true;
 }
 
+static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
+                             int rd, int rn, int data,
+                             gen_helper_gvec_2_ptr * const fns[3])
+{
+    return do_gvec_op2_fpst_with_fpsttype(s, esz, is_q, rd, rn, data, fns,
+                                          esz == MO_16 ? FPST_A64_F16 :
+                                          FPST_A64);
+}
+
+static bool do_gvec_op2_ah_fpst(DisasContext *s, MemOp esz, bool is_q,
+                                int rd, int rn, int data,
+                                gen_helper_gvec_2_ptr * const fns[3])
+{
+    return do_gvec_op2_fpst_with_fpsttype(s, esz, is_q, rd, rn, data,
+                                          fns, select_ah_fpst(s, esz));
+}
+
 static gen_helper_gvec_2_ptr * const f_scvtf_v[] = {
     gen_helper_gvec_vcvt_sh,
     gen_helper_gvec_vcvt_sf,
@@ -9478,14 +9543,14 @@ static gen_helper_gvec_2_ptr * const f_frecpe[] = {
     gen_helper_gvec_frecpe_s,
     gen_helper_gvec_frecpe_d,
 };
-TRANS(FRECPE_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frecpe)
+TRANS(FRECPE_v, do_gvec_op2_ah_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frecpe)
 
 static gen_helper_gvec_2_ptr * const f_frsqrte[] = {
     gen_helper_gvec_frsqrte_h,
     gen_helper_gvec_frsqrte_s,
     gen_helper_gvec_frsqrte_d,
 };
-TRANS(FRSQRTE_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frsqrte)
+TRANS(FRSQRTE_v, do_gvec_op2_ah_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frsqrte)
 
 static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e1788330aa7..c084bb58e7e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -137,11 +137,11 @@ static bool gen_gvec_fpst_zz(DisasContext *s, gen_helper_gvec_2_ptr *fn,
     return true;
 }
 
-static bool gen_gvec_fpst_arg_zz(DisasContext *s, gen_helper_gvec_2_ptr *fn,
-                                 arg_rr_esz *a, int data)
+static bool gen_gvec_fpst_ah_arg_zz(DisasContext *s, gen_helper_gvec_2_ptr *fn,
+                                    arg_rr_esz *a, int data)
 {
     return gen_gvec_fpst_zz(s, fn, a->rd, a->rn, data,
-                            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+                            select_ah_fpst(s, a->esz));
 }
 
 /* Invoke an out-of-line helper on 3 Zregs. */
@@ -194,6 +194,13 @@ static bool gen_gvec_fpst_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
                              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
 
+static bool gen_gvec_fpst_ah_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
+                                     arg_rrr_esz *a, int data)
+{
+    return gen_gvec_fpst_zzz(s, fn, a->rd, a->rn, a->rm, data,
+                             select_ah_fpst(s, a->esz));
+}
+
 /* Invoke an out-of-line helper on 4 Zregs. */
 static bool gen_gvec_ool_zzzz(DisasContext *s, gen_helper_gvec_4 *fn,
                               int rd, int rn, int rm, int ra, int data)
@@ -3597,13 +3604,13 @@ static gen_helper_gvec_2_ptr * const frecpe_fns[] = {
     NULL,                     gen_helper_gvec_frecpe_h,
     gen_helper_gvec_frecpe_s, gen_helper_gvec_frecpe_d,
 };
-TRANS_FEAT(FRECPE, aa64_sve, gen_gvec_fpst_arg_zz, frecpe_fns[a->esz], a, 0)
+TRANS_FEAT(FRECPE, aa64_sve, gen_gvec_fpst_ah_arg_zz, frecpe_fns[a->esz], a, 0)
 
 static gen_helper_gvec_2_ptr * const frsqrte_fns[] = {
     NULL,                      gen_helper_gvec_frsqrte_h,
     gen_helper_gvec_frsqrte_s, gen_helper_gvec_frsqrte_d,
 };
-TRANS_FEAT(FRSQRTE, aa64_sve, gen_gvec_fpst_arg_zz, frsqrte_fns[a->esz], a, 0)
+TRANS_FEAT(FRSQRTE, aa64_sve, gen_gvec_fpst_ah_arg_zz, frsqrte_fns[a->esz], a, 0)
 
 /*
  *** SVE Floating Point Compare with Zero Group
@@ -3707,11 +3714,18 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
     };                                                              \
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_arg_zzz, name##_fns[a->esz], a, 0)
 
+#define DO_FP3_AH(NAME, name) \
+    static gen_helper_gvec_3_ptr * const name##_fns[4] = {          \
+        NULL, gen_helper_gvec_##name##_h,                           \
+        gen_helper_gvec_##name##_s, gen_helper_gvec_##name##_d      \
+    };                                                              \
+    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_ah_arg_zzz, name##_fns[a->esz], a, 0)
+
 DO_FP3(FADD_zzz, fadd)
 DO_FP3(FSUB_zzz, fsub)
 DO_FP3(FMUL_zzz, fmul)
-DO_FP3(FRECPS, recps)
-DO_FP3(FRSQRTS, rsqrts)
+DO_FP3_AH(FRECPS, recps)
+DO_FP3_AH(FRSQRTS, rsqrts)
 
 #undef DO_FP3
 
@@ -3993,7 +4007,7 @@ static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     gen_helper_sve_frecpx_s, gen_helper_sve_frecpx_d,
 };
 TRANS_FEAT(FRECPX, aa64_sve, gen_gvec_fpst_arg_zpz, frecpx_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+           a, 0, select_ah_fpst(s, a->esz))
 
 static gen_helper_gvec_3_ptr * const fsqrt_fns[] = {
     NULL,                   gen_helper_sve_fsqrt_h,
-- 
2.34.1


