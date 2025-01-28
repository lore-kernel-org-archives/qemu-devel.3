Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4981C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrzB-0004zR-VD; Tue, 28 Jan 2025 15:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcry4-0002NQ-6t
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:52 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcry1-0001ek-6B
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4368a293339so69457935e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095228; x=1738700028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vXQxrPsrci9vDaB5PQbAZefvTexUxy5qpab8pBCRcqI=;
 b=wxiptobWSkQsRUibW7i0COuk4FfyDrX+7X3RDcS6f4ctSLH6BzMGgrb4JIIlLdBKhs
 LRyyUNiqgFUL8LHhOwscNSIrNo9c6InRCxX6/bBvdbv/0xzgVPG6MJosfuKuyNSeBvbg
 VA72LQW+l6t/vIv2g+URK+eJc03tIgJIxo0GJbWriwPiZYZZqsstWP95kygm3PvnjgkA
 Wr5BKoDLRqSQLg6ksua7A4ZDFbCcvCaSMcdEMc7yx6WzzILQGb4VtkOjexd+e9vS3JGo
 CI8UkgRuszx7+w8TEc2Oor6tUFOX7+kQZRQd5oKXXx1iVNl+DwzyiQihGN2/YcNgS1SO
 LzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095228; x=1738700028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXQxrPsrci9vDaB5PQbAZefvTexUxy5qpab8pBCRcqI=;
 b=KitKeX2/Kgcy45p9QW+f7YvLZQVSfk0xqhVVe6rZUpt57qVJGvXShItkkOSCs0RdlR
 i+ux1+EpEpe7H1zZznu0pmHSZHvnDTpEj4vLP46INBOBbIEHEy6nOh0HOAH8AkIlHn1E
 dF7NOATnWenlJqt+sE3sdOEjngNqj5mNaT4QMi/hnq5j5sOj7BBs9oW5BYIRU3PplcNO
 JuqbAP6w0lQSvYwteFFEKeYENJiPBIeXssUwLgPwpEVJvvO+PrGmAF/Xk76Yb6SPZhsO
 E95P1iDUuc7RatnYVuB9eZj7dN+WItJml+4NuPkIZ0scnvZVyPW3C7BvLKonhPoDg6jy
 MwFQ==
X-Gm-Message-State: AOJu0Yx9/hDr2qrXvrQnlBacmvPsef057DEsaXjhh+fSuPFHQYCnlz2d
 CA+mcKZrNf6LQmHv2WW3KTQ0WnEh9ToSOEOmvCX8dOVosIBXB6XlWArRuL6OloJD5ho88WEVenC
 p
X-Gm-Gg: ASbGncuwg7Ift60zgDD1Qa9TzPzPNBcjdDeIKpxalVTgD9rnQ+B3eWgDSzV5/nH/KR5
 hpfbTELUgmI+7kaR7Ex2oeqF4IX5M3eaZyfWfGS/NorKqhg0L5Kn0DQoDEsLFzMYkgf9yVKr5n0
 hoz9NtvQnYfwY3e0S1PIyVHDkTeKjZi6BaoHY6C+J0bBRcF9mOOB8ZmJZW+6vuSc3yvV5huEe2X
 1d00vpNYkkWOtTWNUpIiAktt5Jm78A0k28j0oUorbUDD8we2d8kRU2KXLWgc+uGEY1xTfDV69EI
 8reIAJFOrvb2CrczVkyzUg==
X-Google-Smtp-Source: AGHT+IEOBSvV9KI8S+AlvvErRSO581q2mOYJTZrdFCSNXKaR+aTGIApGsd2DO/2RH/g+SMRwoQpJ3Q==
X-Received: by 2002:a05:600c:4e87:b0:438:a240:c55 with SMTP id
 5b1f17b1804b1-438dc3af833mr2303655e9.1.1738095227378; 
 Tue, 28 Jan 2025 12:13:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/36] target/arm: Use FPST_A64_F16 in A64 decoder
Date: Tue, 28 Jan 2025 20:13:07 +0000
Message-Id: <20250128201314.44038-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In the A32 decoder, use FPST_A64_F16 rather than FPST_FPCR_F16.
By doing an automated conversion of the whole file we avoid possibly
using more than one fpst value in a set_rmode/op/restore_rmode
sequence.

Patch created with
  perl -p -i -e 's/FPST_FPCR_F16(?!_)/FPST_A64_F16/g' target/arm/tcg/translate-{a64,sve,sme}.c

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-18-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a64.c | 32 ++++++++---------
 target/arm/tcg/translate-sve.c | 66 +++++++++++++++++-----------------
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d9c00713675..2b8b253479a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -726,7 +726,7 @@ static void gen_gvec_op3_fpst(DisasContext *s, bool is_q, int rd, int rn,
                               int rm, bool is_fp16, int data,
                               gen_helper_gvec_3_ptr *fn)
 {
-    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_A64);
+    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_A64_F16 : FPST_A64);
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn),
                        vec_full_reg_offset(s, rm), fpst,
@@ -768,7 +768,7 @@ static void gen_gvec_op4_fpst(DisasContext *s, bool is_q, int rd, int rn,
                               int rm, int ra, bool is_fp16, int data,
                               gen_helper_gvec_4_ptr *fn)
 {
-    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_A64);
+    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_A64_F16 : FPST_A64);
     tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn),
                        vec_full_reg_offset(s, rm),
@@ -5062,7 +5062,7 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
         if (fp_access_check(s)) {
             TCGv_i32 t0 = read_fp_hreg(s, a->rn);
             TCGv_i32 t1 = read_fp_hreg(s, a->rm);
-            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16));
+            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_A64_F16));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -5270,9 +5270,9 @@ static bool do_fcmp0_s(DisasContext *s, arg_rr_e *a,
             TCGv_i32 t0 = read_fp_hreg(s, a->rn);
             TCGv_i32 t1 = tcg_constant_i32(0);
             if (swap) {
-                f->gen_h(t0, t1, t0, fpstatus_ptr(FPST_FPCR_F16));
+                f->gen_h(t0, t1, t0, fpstatus_ptr(FPST_A64_F16));
             } else {
-                f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16));
+                f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_A64_F16));
             }
             write_fp_sreg(s, a->rd, t0);
         }
@@ -6230,7 +6230,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
             TCGv_i32 t1 = tcg_temp_new_i32();
 
             read_vec_element_i32(s, t1, a->rm, a->idx, MO_16);
-            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16));
+            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_A64_F16));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -6288,7 +6288,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
                 gen_vfp_negh(t1, t1);
             }
             gen_helper_advsimd_muladdh(t0, t1, t2, t0,
-                                       fpstatus_ptr(FPST_FPCR_F16));
+                                       fpstatus_ptr(FPST_A64_F16));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -6626,7 +6626,7 @@ static bool do_fp3_scalar_pair(DisasContext *s, arg_rr_e *a, const FPScalar *f)
 
             read_vec_element_i32(s, t0, a->rn, 0, MO_16);
             read_vec_element_i32(s, t1, a->rn, 1, MO_16);
-            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16));
+            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_A64_F16));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -6801,7 +6801,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             if (neg_n) {
                 gen_vfp_negh(tn, tn);
             }
-            fpst = fpstatus_ptr(FPST_FPCR_F16);
+            fpst = fpstatus_ptr(FPST_A64_F16);
             gen_helper_advsimd_muladdh(ta, tn, tm, ta, fpst);
             write_fp_sreg(s, a->rd, ta);
         }
@@ -6895,7 +6895,7 @@ static bool do_fp_reduction(DisasContext *s, arg_qrr_e *a,
     if (fp_access_check(s)) {
         MemOp esz = a->esz;
         int elts = (a->q ? 16 : 8) >> esz;
-        TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+        TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
         TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst, fn);
         write_fp_sreg(s, a->rd, res);
     }
@@ -6939,7 +6939,7 @@ static void handle_fp_compare(DisasContext *s, int size,
                               bool cmp_with_zero, bool signal_all_nans)
 {
     TCGv_i64 tcg_flags = tcg_temp_new_i64();
-    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_A64_F16 : FPST_A64);
 
     if (size == MO_64) {
         TCGv_i64 tcg_vn, tcg_vm;
@@ -8407,7 +8407,7 @@ static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
     if (rmode >= 0) {
         tcg_rmode = gen_set_rmode(rmode, fpst);
     }
@@ -8598,7 +8598,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
     TCGv_i32 tcg_shift, tcg_single;
     TCGv_i64 tcg_double;
 
-    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
     tcg_shift = tcg_constant_i32(shift);
 
     switch (esz) {
@@ -8693,7 +8693,7 @@ static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
     TCGv_ptr tcg_fpstatus;
     TCGv_i32 tcg_shift, tcg_rmode, tcg_single;
 
-    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
     tcg_shift = tcg_constant_i32(shift);
     tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
 
@@ -9312,7 +9312,7 @@ static bool do_fp1_vector(DisasContext *s, arg_qrr_e *a,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
     if (rmode >= 0) {
         tcg_rmode = gen_set_rmode(rmode, fpst);
     }
@@ -9372,7 +9372,7 @@ static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+    fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
     tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn), fpst,
                        is_q ? 16 : 8, vec_full_reg_size(s),
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d32a67331df..a7dbea5acd0 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -141,7 +141,7 @@ static bool gen_gvec_fpst_arg_zz(DisasContext *s, gen_helper_gvec_2_ptr *fn,
                                  arg_rr_esz *a, int data)
 {
     return gen_gvec_fpst_zz(s, fn, a->rd, a->rn, data,
-                            a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+                            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
 
 /* Invoke an out-of-line helper on 3 Zregs. */
@@ -191,7 +191,7 @@ static bool gen_gvec_fpst_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
                                   arg_rrr_esz *a, int data)
 {
     return gen_gvec_fpst_zzz(s, fn, a->rd, a->rn, a->rm, data,
-                             a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+                             a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
 
 /* Invoke an out-of-line helper on 4 Zregs. */
@@ -397,7 +397,7 @@ static bool gen_gvec_fpst_arg_zpzz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
                                    arg_rprr_esz *a)
 {
     return gen_gvec_fpst_zzzp(s, fn, a->rd, a->rn, a->rm, a->pg, 0,
-                              a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+                              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
 
 /* Invoke a vector expander on two Zregs and an immediate.  */
@@ -3517,7 +3517,7 @@ static bool do_FMLA_zzxz(DisasContext *s, arg_rrxr_esz *a, bool sub)
     };
     return gen_gvec_fpst_zzzz(s, fns[a->esz], a->rd, a->rn, a->rm, a->ra,
                               (a->index << 1) | sub,
-                              a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+                              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
 
 TRANS_FEAT(FMLA_zzxz, aa64_sve, do_FMLA_zzxz, a, false)
@@ -3533,7 +3533,7 @@ static gen_helper_gvec_3_ptr * const fmul_idx_fns[4] = {
 };
 TRANS_FEAT(FMUL_zzx, aa64_sve, gen_gvec_fpst_zzz,
            fmul_idx_fns[a->esz], a->rd, a->rn, a->rm, a->index,
-           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 /*
  *** SVE Floating Point Fast Reduction Group
@@ -3566,7 +3566,7 @@ static bool do_reduce(DisasContext *s, arg_rpr_esz *a,
 
     tcg_gen_addi_ptr(t_zn, tcg_env, vec_full_reg_offset(s, a->rn));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, a->pg));
-    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+    status = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
     fn(temp, t_zn, t_pg, status, t_desc);
 
@@ -3618,7 +3618,7 @@ static bool do_ppz_fp(DisasContext *s, arg_rpr_esz *a,
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
         TCGv_ptr status =
-            fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+            fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
         tcg_gen_gvec_3_ptr(pred_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
@@ -3654,7 +3654,7 @@ static gen_helper_gvec_3_ptr * const ftmad_fns[4] = {
 };
 TRANS_FEAT_NONSTREAMING(FTMAD, aa64_sve, gen_gvec_fpst_zzz,
                         ftmad_fns[a->esz], a->rd, a->rn, a->rm, a->imm,
-                        a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
+                        a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 /*
  *** SVE Floating Point Accumulating Reduction Group
@@ -3687,7 +3687,7 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
     t_pg = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_rm, tcg_env, vec_full_reg_offset(s, a->rm));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, a->pg));
-    t_fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+    t_fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
     t_desc = tcg_constant_i32(simd_desc(vsz, vsz, 0));
 
     fns[a->esz - 1](t_val, t_val, t_rm, t_pg, t_fpst, t_desc);
@@ -3762,7 +3762,7 @@ static void do_fp_scalar(DisasContext *s, int zd, int zn, int pg, bool is_fp16,
     tcg_gen_addi_ptr(t_zn, tcg_env, vec_full_reg_offset(s, zn));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
 
-    status = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_A64);
+    status = fpstatus_ptr(is_fp16 ? FPST_A64_F16 : FPST_A64);
     desc = tcg_constant_i32(simd_desc(vsz, vsz, 0));
     fn(t_zd, t_zn, t_pg, scalar, status, desc);
 }
@@ -3814,7 +3814,7 @@ static bool do_fp_cmp(DisasContext *s, arg_rprr_esz *a,
     }
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
         tcg_gen_gvec_4_ptr(pred_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3847,7 +3847,7 @@ static gen_helper_gvec_4_ptr * const fcadd_fns[] = {
 };
 TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
            a->rd, a->rn, a->rm, a->pg, a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 #define DO_FMLA(NAME, name) \
     static gen_helper_gvec_5_ptr * const name##_fns[4] = {              \
@@ -3856,7 +3856,7 @@ TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
     };                                                                  \
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_zzzzp, name##_fns[a->esz], \
                a->rd, a->rn, a->rm, a->ra, a->pg, 0,                    \
-               a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
+               a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 DO_FMLA(FMLA_zpzzz, fmla_zpzzz)
 DO_FMLA(FMLS_zpzzz, fmls_zpzzz)
@@ -3871,14 +3871,14 @@ static gen_helper_gvec_5_ptr * const fcmla_fns[4] = {
 };
 TRANS_FEAT(FCMLA_zpzzz, aa64_sve, gen_gvec_fpst_zzzzp, fcmla_fns[a->esz],
            a->rd, a->rn, a->rm, a->ra, a->pg, a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_4_ptr * const fcmla_idx_fns[4] = {
     NULL, gen_helper_gvec_fcmlah_idx, gen_helper_gvec_fcmlas_idx, NULL
 };
 TRANS_FEAT(FCMLA_zzxz, aa64_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz],
            a->rd, a->rn, a->rm, a->ra, a->index * 4 + a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 /*
  *** SVE Floating Point Unary Operations Predicated Group
@@ -3902,17 +3902,17 @@ TRANS_FEAT(FCVT_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sd, a, 0, FPST_A64)
 
 TRANS_FEAT(FCVTZS_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_hh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_fcvtzs_hh, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTZU_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_hh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_fcvtzu_hh, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTZS_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_hs, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_fcvtzs_hs, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTZU_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_hs, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_fcvtzu_hs, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTZS_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_hd, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_fcvtzs_hd, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTZU_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_hd, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_fcvtzu_hd, a, 0, FPST_A64_F16)
 
 TRANS_FEAT(FCVTZS_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_ss, a, 0, FPST_A64)
@@ -3939,7 +3939,7 @@ static gen_helper_gvec_3_ptr * const frint_fns[] = {
     gen_helper_sve_frint_d
 };
 TRANS_FEAT(FRINTI, aa64_sve, gen_gvec_fpst_arg_zpz, frint_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
+           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     NULL,
@@ -3948,7 +3948,7 @@ static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     gen_helper_sve_frintx_d
 };
 TRANS_FEAT(FRINTX, aa64_sve, gen_gvec_fpst_arg_zpz, frintx_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
                           ARMFPRounding mode, gen_helper_gvec_3_ptr *fn)
@@ -3965,7 +3965,7 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
     }
 
     vsz = vec_full_reg_size(s);
-    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
+    status = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
     tmode = gen_set_rmode(mode, status);
 
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
@@ -3993,21 +3993,21 @@ static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     gen_helper_sve_frecpx_s, gen_helper_sve_frecpx_d,
 };
 TRANS_FEAT(FRECPX, aa64_sve, gen_gvec_fpst_arg_zpz, frecpx_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
+           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_3_ptr * const fsqrt_fns[] = {
     NULL,                   gen_helper_sve_fsqrt_h,
     gen_helper_sve_fsqrt_s, gen_helper_sve_fsqrt_d,
 };
 TRANS_FEAT(FSQRT, aa64_sve, gen_gvec_fpst_arg_zpz, fsqrt_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
+           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 TRANS_FEAT(SCVTF_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_hh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_scvt_hh, a, 0, FPST_A64_F16)
 TRANS_FEAT(SCVTF_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_sh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_scvt_sh, a, 0, FPST_A64_F16)
 TRANS_FEAT(SCVTF_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_dh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_scvt_dh, a, 0, FPST_A64_F16)
 
 TRANS_FEAT(SCVTF_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_ss, a, 0, FPST_A64)
@@ -4020,11 +4020,11 @@ TRANS_FEAT(SCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_dd, a, 0, FPST_A64)
 
 TRANS_FEAT(UCVTF_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_hh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_ucvt_hh, a, 0, FPST_A64_F16)
 TRANS_FEAT(UCVTF_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_sh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_ucvt_sh, a, 0, FPST_A64_F16)
 TRANS_FEAT(UCVTF_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_dh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_ucvt_dh, a, 0, FPST_A64_F16)
 
 TRANS_FEAT(UCVTF_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_ss, a, 0, FPST_A64)
@@ -7057,7 +7057,7 @@ static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     gen_helper_flogb_s, gen_helper_flogb_d
 };
 TRANS_FEAT(FLOGB, aa64_sve2, gen_gvec_fpst_arg_zpz, flogb_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
+           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static bool do_FMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sub, bool sel)
 {
-- 
2.34.1


