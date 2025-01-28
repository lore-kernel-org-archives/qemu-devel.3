Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A403BC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcryU-0002dJ-Id; Tue, 28 Jan 2025 15:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxy-0002GP-LO
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:47 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxu-0001dD-6T
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:46 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso62374845e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095221; x=1738700021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vc+eduDCzrTnhO0Ul0zdv6g+F+TjUReFJ2abWohRGpA=;
 b=iq2HeS2smLiJtsZN0n0hrpcRPjYp1PLmV2yhIvXUzlnC2vDFT4ZA6SOol7I9LSIY//
 mGPCcEVdzT4fx+2Fzb+zKj6KvZqbuMMJLMSOMb2d1DVT2U0vwoWmUZ3HfeLNc7oKxjOw
 9Hsaz0ywAepPGr5LJ47/5g8YTgUds8BrOQSWDUhW64QqE2luoQvnFPgS6XXzkgth4hOs
 hz5mVPGVEgBg71d86mhX674/W6F3QV+VyRy8WI5rIcPcXe427G5Wis/LbHKfpumB1sHo
 Z6b1MoMlQgtiUlX75OKD8pkcH5PaaHDZmApmpDU8bLXN+3UjrsvAiojZq8faTRVAJZXA
 K4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095221; x=1738700021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vc+eduDCzrTnhO0Ul0zdv6g+F+TjUReFJ2abWohRGpA=;
 b=TBxjSWg3MsGeJ4tvVpoqPGfChKduir8Zh976/t9IMwVCiXf1mk349LXdkpb80sZbTR
 15elv5bLhWtKu2zsjX76q8OdzDtRy6y5jTlhZCya/yp30Udl+rmR7ndof5mbPQyrJwU/
 kRQTVkvAAOfEPVSfyVyhad8raI0cBVrR/dN0qqNJKCUwYA7bxHDhEycyX9fAlDKI78gN
 Iod23tTeJh1jEyxMyT9lA0+9CHbIAElzP8T/3agrEs3ogzXdYlq4w1wbGpoZwVZOOKKR
 GCbyVyreyJrHGioh7ZAtLo825qBIqy0Tuyu4dXPxCacv0lTht4WUaOMnVN803GSV4rgW
 91Tw==
X-Gm-Message-State: AOJu0Yznb1AG2XI3ywtT+bdY3o7U5qohEJ5jr0srbKEi8BVrcyJIMpOx
 sE0nkI7RbI8Bjcf/zIovUPqNc0bPIbDl5QaqmC3PtAwOH70+IjAaRpvYmQOePbKjKmBlx48hF+M
 8
X-Gm-Gg: ASbGncu/M8AayMCatlwkQhwHZzYtf0JJSIoC6ZWaZ0jrzd8idO7IUW0J8Ssx3GtkijK
 nY79TcAa+ppn+Pafb3oHCTpukfC6kSRxny81sfg5WbvOdf85uLWsjCKrhqye2wxs+5jhmyPwBlQ
 DMQdZWvA5ZgLXqttJq/Web6pafj4wru28fPDlvylf2enDRsA2fDnTW3gjMhoghfrArOWjKt3ozf
 sQ8xLQqje2OFEmAGrZrqWUo5EEDVhmsW3SuGdWUFW4kBleWWmeoQqfWlisHPQ+m8eDCZrQ7kCAw
 +4z57iwvy+r5Df3H1rG61A==
X-Google-Smtp-Source: AGHT+IFHQQ455JKICrlcmdxB1zdFwX8IkKn5KTdnKJS4toTcQcTBjXxSvkNTPX6r12C83BxC9xbdig==
X-Received: by 2002:a05:600c:3d0e:b0:434:f753:600f with SMTP id
 5b1f17b1804b1-438dc40b3fbmr2308915e9.19.1738095220612; 
 Tue, 28 Jan 2025 12:13:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/36] target/arm: Use FPST_A64 in A64 decoder
Date: Tue, 28 Jan 2025 20:13:01 +0000
Message-Id: <20250128201314.44038-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

In the A64 decoder, use FPST_A64 rather than FPST_FPCR.  By
doing an automated conversion of the whole file we avoid possibly
using more than one fpst value in a set_rmode/op/restore_rmode
sequence.

Patch created with

  perl -p -i -e 's/FPST_FPCR(?!_)/FPST_A64/g' target/arm/tcg/translate-{a64,sve,sme}.c

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-12-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a64.c |  70 +++++++++++-----------
 target/arm/tcg/translate-sme.c |   4 +-
 target/arm/tcg/translate-sve.c | 106 ++++++++++++++++-----------------
 3 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bd814849c19..d9c00713675 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -726,7 +726,7 @@ static void gen_gvec_op3_fpst(DisasContext *s, bool is_q, int rd, int rn,
                               int rm, bool is_fp16, int data,
                               gen_helper_gvec_3_ptr *fn)
 {
-    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR);
+    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_A64);
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn),
                        vec_full_reg_offset(s, rm), fpst,
@@ -768,7 +768,7 @@ static void gen_gvec_op4_fpst(DisasContext *s, bool is_q, int rd, int rn,
                               int rm, int ra, bool is_fp16, int data,
                               gen_helper_gvec_4_ptr *fn)
 {
-    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR);
+    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_A64);
     tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn),
                        vec_full_reg_offset(s, rm),
@@ -5043,7 +5043,7 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
         if (fp_access_check(s)) {
             TCGv_i64 t0 = read_fp_dreg(s, a->rn);
             TCGv_i64 t1 = read_fp_dreg(s, a->rm);
-            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_A64));
             write_fp_dreg(s, a->rd, t0);
         }
         break;
@@ -5051,7 +5051,7 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
         if (fp_access_check(s)) {
             TCGv_i32 t0 = read_fp_sreg(s, a->rn);
             TCGv_i32 t1 = read_fp_sreg(s, a->rm);
-            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_A64));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -5243,9 +5243,9 @@ static bool do_fcmp0_s(DisasContext *s, arg_rr_e *a,
             TCGv_i64 t0 = read_fp_dreg(s, a->rn);
             TCGv_i64 t1 = tcg_constant_i64(0);
             if (swap) {
-                f->gen_d(t0, t1, t0, fpstatus_ptr(FPST_FPCR));
+                f->gen_d(t0, t1, t0, fpstatus_ptr(FPST_A64));
             } else {
-                f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+                f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_A64));
             }
             write_fp_dreg(s, a->rd, t0);
         }
@@ -5255,9 +5255,9 @@ static bool do_fcmp0_s(DisasContext *s, arg_rr_e *a,
             TCGv_i32 t0 = read_fp_sreg(s, a->rn);
             TCGv_i32 t1 = tcg_constant_i32(0);
             if (swap) {
-                f->gen_s(t0, t1, t0, fpstatus_ptr(FPST_FPCR));
+                f->gen_s(t0, t1, t0, fpstatus_ptr(FPST_A64));
             } else {
-                f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+                f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_A64));
             }
             write_fp_sreg(s, a->rd, t0);
         }
@@ -6207,7 +6207,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
             TCGv_i64 t1 = tcg_temp_new_i64();
 
             read_vec_element(s, t1, a->rm, a->idx, MO_64);
-            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_A64));
             write_fp_dreg(s, a->rd, t0);
         }
         break;
@@ -6217,7 +6217,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
             TCGv_i32 t1 = tcg_temp_new_i32();
 
             read_vec_element_i32(s, t1, a->rm, a->idx, MO_32);
-            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_A64));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -6256,7 +6256,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
             if (neg) {
                 gen_vfp_negd(t1, t1);
             }
-            gen_helper_vfp_muladdd(t0, t1, t2, t0, fpstatus_ptr(FPST_FPCR));
+            gen_helper_vfp_muladdd(t0, t1, t2, t0, fpstatus_ptr(FPST_A64));
             write_fp_dreg(s, a->rd, t0);
         }
         break;
@@ -6270,7 +6270,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
             if (neg) {
                 gen_vfp_negs(t1, t1);
             }
-            gen_helper_vfp_muladds(t0, t1, t2, t0, fpstatus_ptr(FPST_FPCR));
+            gen_helper_vfp_muladds(t0, t1, t2, t0, fpstatus_ptr(FPST_A64));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -6601,7 +6601,7 @@ static bool do_fp3_scalar_pair(DisasContext *s, arg_rr_e *a, const FPScalar *f)
 
             read_vec_element(s, t0, a->rn, 0, MO_64);
             read_vec_element(s, t1, a->rn, 1, MO_64);
-            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_A64));
             write_fp_dreg(s, a->rd, t0);
         }
         break;
@@ -6612,7 +6612,7 @@ static bool do_fp3_scalar_pair(DisasContext *s, arg_rr_e *a, const FPScalar *f)
 
             read_vec_element_i32(s, t0, a->rn, 0, MO_32);
             read_vec_element_i32(s, t1, a->rn, 1, MO_32);
-            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_A64));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -6762,7 +6762,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             if (neg_n) {
                 gen_vfp_negd(tn, tn);
             }
-            fpst = fpstatus_ptr(FPST_FPCR);
+            fpst = fpstatus_ptr(FPST_A64);
             gen_helper_vfp_muladdd(ta, tn, tm, ta, fpst);
             write_fp_dreg(s, a->rd, ta);
         }
@@ -6780,7 +6780,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             if (neg_n) {
                 gen_vfp_negs(tn, tn);
             }
-            fpst = fpstatus_ptr(FPST_FPCR);
+            fpst = fpstatus_ptr(FPST_A64);
             gen_helper_vfp_muladds(ta, tn, tm, ta, fpst);
             write_fp_sreg(s, a->rd, ta);
         }
@@ -6895,7 +6895,7 @@ static bool do_fp_reduction(DisasContext *s, arg_qrr_e *a,
     if (fp_access_check(s)) {
         MemOp esz = a->esz;
         int elts = (a->q ? 16 : 8) >> esz;
-        TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+        TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
         TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst, fn);
         write_fp_sreg(s, a->rd, res);
     }
@@ -6939,7 +6939,7 @@ static void handle_fp_compare(DisasContext *s, int size,
                               bool cmp_with_zero, bool signal_all_nans)
 {
     TCGv_i64 tcg_flags = tcg_temp_new_i64();
-    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_A64);
 
     if (size == MO_64) {
         TCGv_i64 tcg_vn, tcg_vm;
@@ -8407,7 +8407,7 @@ static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
     if (rmode >= 0) {
         tcg_rmode = gen_set_rmode(rmode, fpst);
     }
@@ -8513,7 +8513,7 @@ static bool trans_FCVT_s_ds(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i32 tcg_rn = read_fp_sreg(s, a->rn);
         TCGv_i64 tcg_rd = tcg_temp_new_i64();
-        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+        TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvtds(tcg_rd, tcg_rn, fpst);
         write_fp_dreg(s, a->rd, tcg_rd);
@@ -8526,7 +8526,7 @@ static bool trans_FCVT_s_hs(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i32 tmp = read_fp_sreg(s, a->rn);
         TCGv_i32 ahp = get_ahp_flag();
-        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+        TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
         /* write_fp_sreg is OK here because top half of result is zero */
@@ -8540,7 +8540,7 @@ static bool trans_FCVT_s_sd(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i64 tcg_rn = read_fp_dreg(s, a->rn);
         TCGv_i32 tcg_rd = tcg_temp_new_i32();
-        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+        TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvtsd(tcg_rd, tcg_rn, fpst);
         write_fp_sreg(s, a->rd, tcg_rd);
@@ -8554,7 +8554,7 @@ static bool trans_FCVT_s_hd(DisasContext *s, arg_rr *a)
         TCGv_i64 tcg_rn = read_fp_dreg(s, a->rn);
         TCGv_i32 tcg_rd = tcg_temp_new_i32();
         TCGv_i32 ahp = get_ahp_flag();
-        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+        TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvt_f64_to_f16(tcg_rd, tcg_rn, fpst, ahp);
         /* write_fp_sreg is OK here because top half of tcg_rd is zero */
@@ -8568,7 +8568,7 @@ static bool trans_FCVT_s_sh(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i32 tcg_rn = read_fp_hreg(s, a->rn);
         TCGv_i32 tcg_rd = tcg_temp_new_i32();
-        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_FPCR);
+        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_A64);
         TCGv_i32 tcg_ahp = get_ahp_flag();
 
         gen_helper_vfp_fcvt_f16_to_f32(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
@@ -8582,7 +8582,7 @@ static bool trans_FCVT_s_dh(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i32 tcg_rn = read_fp_hreg(s, a->rn);
         TCGv_i64 tcg_rd = tcg_temp_new_i64();
-        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_FPCR);
+        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_A64);
         TCGv_i32 tcg_ahp = get_ahp_flag();
 
         gen_helper_vfp_fcvt_f16_to_f64(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
@@ -8598,7 +8598,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
     TCGv_i32 tcg_shift, tcg_single;
     TCGv_i64 tcg_double;
 
-    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
     tcg_shift = tcg_constant_i32(shift);
 
     switch (esz) {
@@ -8693,7 +8693,7 @@ static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
     TCGv_ptr tcg_fpstatus;
     TCGv_i32 tcg_shift, tcg_rmode, tcg_single;
 
-    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
     tcg_shift = tcg_constant_i32(shift);
     tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
 
@@ -8857,7 +8857,7 @@ static bool trans_FJCVTZS(DisasContext *s, arg_FJCVTZS *a)
     }
     if (fp_access_check(s)) {
         TCGv_i64 t = read_fp_dreg(s, a->rn);
-        TCGv_ptr fpstatus = fpstatus_ptr(FPST_FPCR);
+        TCGv_ptr fpstatus = fpstatus_ptr(FPST_A64);
 
         gen_helper_fjcvtzs(t, t, fpstatus);
 
@@ -9115,7 +9115,7 @@ static void gen_fcvtxn_sd(TCGv_i64 d, TCGv_i64 n)
      * with von Neumann rounding (round to odd)
      */
     TCGv_i32 tmp = tcg_temp_new_i32();
-    gen_helper_fcvtx_f64_to_f32(tmp, n, fpstatus_ptr(FPST_FPCR));
+    gen_helper_fcvtx_f64_to_f32(tmp, n, fpstatus_ptr(FPST_A64));
     tcg_gen_extu_i32_i64(d, tmp);
 }
 
@@ -9208,7 +9208,7 @@ static void gen_fcvtn_hs(TCGv_i64 d, TCGv_i64 n)
 {
     TCGv_i32 tcg_lo = tcg_temp_new_i32();
     TCGv_i32 tcg_hi = tcg_temp_new_i32();
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
     TCGv_i32 ahp = get_ahp_flag();
 
     tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, n);
@@ -9221,7 +9221,7 @@ static void gen_fcvtn_hs(TCGv_i64 d, TCGv_i64 n)
 static void gen_fcvtn_sd(TCGv_i64 d, TCGv_i64 n)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
     gen_helper_vfp_fcvtsd(tmp, n, fpst);
     tcg_gen_extu_i32_i64(d, tmp);
@@ -9237,7 +9237,7 @@ TRANS(FCVTXN_v, do_2misc_narrow_vector, a, f_scalar_fcvtxn)
 
 static void gen_bfcvtn_hs(TCGv_i64 d, TCGv_i64 n)
 {
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
     TCGv_i32 tmp = tcg_temp_new_i32();
     gen_helper_bfcvt_pair(tmp, n, fpst);
     tcg_gen_extu_i32_i64(d, tmp);
@@ -9312,7 +9312,7 @@ static bool do_fp1_vector(DisasContext *s, arg_qrr_e *a,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
     if (rmode >= 0) {
         tcg_rmode = gen_set_rmode(rmode, fpst);
     }
@@ -9372,7 +9372,7 @@ static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
     tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn), fpst,
                        is_q ? 16 : 8, vec_full_reg_size(s),
@@ -9511,7 +9511,7 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A64);
     if (a->esz == MO_64) {
         /* 32 -> 64 bit fp conversion */
         TCGv_i64 tcg_res[2];
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 01ece570164..fcbb3500161 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -358,9 +358,9 @@ static bool do_outprod_env(DisasContext *s, arg_op *a, MemOp esz,
 TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_env, a,
            MO_32, gen_helper_sme_fmopa_h)
 TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
-           MO_32, FPST_FPCR, gen_helper_sme_fmopa_s)
+           MO_32, FPST_A64, gen_helper_sme_fmopa_s)
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
-           MO_64, FPST_FPCR, gen_helper_sme_fmopa_d)
+           MO_64, FPST_A64, gen_helper_sme_fmopa_d)
 
 TRANS_FEAT(BFMOPA, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa)
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e3031965920..d32a67331df 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -141,7 +141,7 @@ static bool gen_gvec_fpst_arg_zz(DisasContext *s, gen_helper_gvec_2_ptr *fn,
                                  arg_rr_esz *a, int data)
 {
     return gen_gvec_fpst_zz(s, fn, a->rd, a->rn, data,
-                            a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+                            a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
 }
 
 /* Invoke an out-of-line helper on 3 Zregs. */
@@ -191,7 +191,7 @@ static bool gen_gvec_fpst_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
                                   arg_rrr_esz *a, int data)
 {
     return gen_gvec_fpst_zzz(s, fn, a->rd, a->rn, a->rm, data,
-                             a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+                             a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
 }
 
 /* Invoke an out-of-line helper on 4 Zregs. */
@@ -397,7 +397,7 @@ static bool gen_gvec_fpst_arg_zpzz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
                                    arg_rprr_esz *a)
 {
     return gen_gvec_fpst_zzzp(s, fn, a->rd, a->rn, a->rm, a->pg, 0,
-                              a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+                              a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
 }
 
 /* Invoke a vector expander on two Zregs and an immediate.  */
@@ -3517,7 +3517,7 @@ static bool do_FMLA_zzxz(DisasContext *s, arg_rrxr_esz *a, bool sub)
     };
     return gen_gvec_fpst_zzzz(s, fns[a->esz], a->rd, a->rn, a->rm, a->ra,
                               (a->index << 1) | sub,
-                              a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+                              a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
 }
 
 TRANS_FEAT(FMLA_zzxz, aa64_sve, do_FMLA_zzxz, a, false)
@@ -3533,7 +3533,7 @@ static gen_helper_gvec_3_ptr * const fmul_idx_fns[4] = {
 };
 TRANS_FEAT(FMUL_zzx, aa64_sve, gen_gvec_fpst_zzz,
            fmul_idx_fns[a->esz], a->rd, a->rn, a->rm, a->index,
-           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR)
+           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
 
 /*
  *** SVE Floating Point Fast Reduction Group
@@ -3566,7 +3566,7 @@ static bool do_reduce(DisasContext *s, arg_rpr_esz *a,
 
     tcg_gen_addi_ptr(t_zn, tcg_env, vec_full_reg_offset(s, a->rn));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, a->pg));
-    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
 
     fn(temp, t_zn, t_pg, status, t_desc);
 
@@ -3618,7 +3618,7 @@ static bool do_ppz_fp(DisasContext *s, arg_rpr_esz *a,
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
         TCGv_ptr status =
-            fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+            fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
 
         tcg_gen_gvec_3_ptr(pred_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
@@ -3654,7 +3654,7 @@ static gen_helper_gvec_3_ptr * const ftmad_fns[4] = {
 };
 TRANS_FEAT_NONSTREAMING(FTMAD, aa64_sve, gen_gvec_fpst_zzz,
                         ftmad_fns[a->esz], a->rd, a->rn, a->rm, a->imm,
-                        a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR)
+                        a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
 
 /*
  *** SVE Floating Point Accumulating Reduction Group
@@ -3687,7 +3687,7 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
     t_pg = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_rm, tcg_env, vec_full_reg_offset(s, a->rm));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, a->pg));
-    t_fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    t_fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
     t_desc = tcg_constant_i32(simd_desc(vsz, vsz, 0));
 
     fns[a->esz - 1](t_val, t_val, t_rm, t_pg, t_fpst, t_desc);
@@ -3762,7 +3762,7 @@ static void do_fp_scalar(DisasContext *s, int zd, int zn, int pg, bool is_fp16,
     tcg_gen_addi_ptr(t_zn, tcg_env, vec_full_reg_offset(s, zn));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
 
-    status = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR);
+    status = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_A64);
     desc = tcg_constant_i32(simd_desc(vsz, vsz, 0));
     fn(t_zd, t_zn, t_pg, scalar, status, desc);
 }
@@ -3814,7 +3814,7 @@ static bool do_fp_cmp(DisasContext *s, arg_rprr_esz *a,
     }
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
         tcg_gen_gvec_4_ptr(pred_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3847,7 +3847,7 @@ static gen_helper_gvec_4_ptr * const fcadd_fns[] = {
 };
 TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
            a->rd, a->rn, a->rm, a->pg, a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR)
+           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
 
 #define DO_FMLA(NAME, name) \
     static gen_helper_gvec_5_ptr * const name##_fns[4] = {              \
@@ -3856,7 +3856,7 @@ TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
     };                                                                  \
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_zzzzp, name##_fns[a->esz], \
                a->rd, a->rn, a->rm, a->ra, a->pg, 0,                    \
-               a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR)
+               a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
 
 DO_FMLA(FMLA_zpzzz, fmla_zpzzz)
 DO_FMLA(FMLS_zpzzz, fmls_zpzzz)
@@ -3871,35 +3871,35 @@ static gen_helper_gvec_5_ptr * const fcmla_fns[4] = {
 };
 TRANS_FEAT(FCMLA_zpzzz, aa64_sve, gen_gvec_fpst_zzzzp, fcmla_fns[a->esz],
            a->rd, a->rn, a->rm, a->ra, a->pg, a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR)
+           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
 
 static gen_helper_gvec_4_ptr * const fcmla_idx_fns[4] = {
     NULL, gen_helper_gvec_fcmlah_idx, gen_helper_gvec_fcmlas_idx, NULL
 };
 TRANS_FEAT(FCMLA_zzxz, aa64_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz],
            a->rd, a->rn, a->rm, a->ra, a->index * 4 + a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR)
+           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
 
 /*
  *** SVE Floating Point Unary Operations Predicated Group
  */
 
 TRANS_FEAT(FCVT_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_sh, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvt_sh, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_hs, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvt_hs, a, 0, FPST_A64)
 
 TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_bfcvt, a, 0, FPST_FPCR)
+           gen_helper_sve_bfcvt, a, 0, FPST_A64)
 
 TRANS_FEAT(FCVT_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_dh, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvt_dh, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_hd, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvt_hd, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_ds, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvt_ds, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_sd, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvt_sd, a, 0, FPST_A64)
 
 TRANS_FEAT(FCVTZS_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_hh, a, 0, FPST_FPCR_F16)
@@ -3915,22 +3915,22 @@ TRANS_FEAT(FCVTZU_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_hd, a, 0, FPST_FPCR_F16)
 
 TRANS_FEAT(FCVTZS_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_ss, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvtzs_ss, a, 0, FPST_A64)
 TRANS_FEAT(FCVTZU_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_ss, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvtzu_ss, a, 0, FPST_A64)
 TRANS_FEAT(FCVTZS_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_sd, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvtzs_sd, a, 0, FPST_A64)
 TRANS_FEAT(FCVTZU_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_sd, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvtzu_sd, a, 0, FPST_A64)
 TRANS_FEAT(FCVTZS_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_ds, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvtzs_ds, a, 0, FPST_A64)
 TRANS_FEAT(FCVTZU_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_ds, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvtzu_ds, a, 0, FPST_A64)
 
 TRANS_FEAT(FCVTZS_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_dd, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvtzs_dd, a, 0, FPST_A64)
 TRANS_FEAT(FCVTZU_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_dd, a, 0, FPST_FPCR)
+           gen_helper_sve_fcvtzu_dd, a, 0, FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frint_fns[] = {
     NULL,
@@ -3939,7 +3939,7 @@ static gen_helper_gvec_3_ptr * const frint_fns[] = {
     gen_helper_sve_frint_d
 };
 TRANS_FEAT(FRINTI, aa64_sve, gen_gvec_fpst_arg_zpz, frint_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR)
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     NULL,
@@ -3948,7 +3948,7 @@ static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     gen_helper_sve_frintx_d
 };
 TRANS_FEAT(FRINTX, aa64_sve, gen_gvec_fpst_arg_zpz, frintx_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
 
 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
                           ARMFPRounding mode, gen_helper_gvec_3_ptr *fn)
@@ -3965,7 +3965,7 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
     }
 
     vsz = vec_full_reg_size(s);
-    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64);
     tmode = gen_set_rmode(mode, status);
 
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
@@ -3993,14 +3993,14 @@ static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     gen_helper_sve_frecpx_s, gen_helper_sve_frecpx_d,
 };
 TRANS_FEAT(FRECPX, aa64_sve, gen_gvec_fpst_arg_zpz, frecpx_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR)
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
 
 static gen_helper_gvec_3_ptr * const fsqrt_fns[] = {
     NULL,                   gen_helper_sve_fsqrt_h,
     gen_helper_sve_fsqrt_s, gen_helper_sve_fsqrt_d,
 };
 TRANS_FEAT(FSQRT, aa64_sve, gen_gvec_fpst_arg_zpz, fsqrt_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR)
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
 
 TRANS_FEAT(SCVTF_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_hh, a, 0, FPST_FPCR_F16)
@@ -4010,14 +4010,14 @@ TRANS_FEAT(SCVTF_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_dh, a, 0, FPST_FPCR_F16)
 
 TRANS_FEAT(SCVTF_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_ss, a, 0, FPST_FPCR)
+           gen_helper_sve_scvt_ss, a, 0, FPST_A64)
 TRANS_FEAT(SCVTF_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_ds, a, 0, FPST_FPCR)
+           gen_helper_sve_scvt_ds, a, 0, FPST_A64)
 
 TRANS_FEAT(SCVTF_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_sd, a, 0, FPST_FPCR)
+           gen_helper_sve_scvt_sd, a, 0, FPST_A64)
 TRANS_FEAT(SCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_dd, a, 0, FPST_FPCR)
+           gen_helper_sve_scvt_dd, a, 0, FPST_A64)
 
 TRANS_FEAT(UCVTF_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_hh, a, 0, FPST_FPCR_F16)
@@ -4027,14 +4027,14 @@ TRANS_FEAT(UCVTF_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_dh, a, 0, FPST_FPCR_F16)
 
 TRANS_FEAT(UCVTF_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_ss, a, 0, FPST_FPCR)
+           gen_helper_sve_ucvt_ss, a, 0, FPST_A64)
 TRANS_FEAT(UCVTF_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_ds, a, 0, FPST_FPCR)
+           gen_helper_sve_ucvt_ds, a, 0, FPST_A64)
 TRANS_FEAT(UCVTF_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_sd, a, 0, FPST_FPCR)
+           gen_helper_sve_ucvt_sd, a, 0, FPST_A64)
 
 TRANS_FEAT(UCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_dd, a, 0, FPST_FPCR)
+           gen_helper_sve_ucvt_dd, a, 0, FPST_A64)
 
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
@@ -6916,10 +6916,10 @@ DO_ZPZZ_FP(FMINP, aa64_sve2, sve2_fminp_zpzz)
 
 TRANS_FEAT_NONSTREAMING(FMMLA_s, aa64_sve_f32mm, gen_gvec_fpst_zzzz,
                         gen_helper_fmmla_s, a->rd, a->rn, a->rm, a->ra,
-                        0, FPST_FPCR)
+                        0, FPST_A64)
 TRANS_FEAT_NONSTREAMING(FMMLA_d, aa64_sve_f64mm, gen_gvec_fpst_zzzz,
                         gen_helper_fmmla_d, a->rd, a->rn, a->rm, a->ra,
-                        0, FPST_FPCR)
+                        0, FPST_A64)
 
 static gen_helper_gvec_4 * const sqdmlal_zzzw_fns[] = {
     NULL,                           gen_helper_sve2_sqdmlal_zzzw_h,
@@ -7035,17 +7035,17 @@ TRANS_FEAT_NONSTREAMING(RAX1, aa64_sve2_sha3, gen_gvec_fn_arg_zzz,
                         gen_gvec_rax1, a)
 
 TRANS_FEAT(FCVTNT_sh, aa64_sve2, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve2_fcvtnt_sh, a, 0, FPST_FPCR)
+           gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
 TRANS_FEAT(FCVTNT_ds, aa64_sve2, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve2_fcvtnt_ds, a, 0, FPST_FPCR)
+           gen_helper_sve2_fcvtnt_ds, a, 0, FPST_A64)
 
 TRANS_FEAT(BFCVTNT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_bfcvtnt, a, 0, FPST_FPCR)
+           gen_helper_sve_bfcvtnt, a, 0, FPST_A64)
 
 TRANS_FEAT(FCVTLT_hs, aa64_sve2, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_FPCR)
+           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64)
 TRANS_FEAT(FCVTLT_sd, aa64_sve2, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve2_fcvtlt_sd, a, 0, FPST_FPCR)
+           gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
 
 TRANS_FEAT(FCVTX_ds, aa64_sve2, do_frint_mode, a,
            FPROUNDING_ODD, gen_helper_sve_fcvt_ds)
@@ -7057,7 +7057,7 @@ static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     gen_helper_flogb_s, gen_helper_flogb_d
 };
 TRANS_FEAT(FLOGB, aa64_sve2, gen_gvec_fpst_arg_zpz, flogb_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR)
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_A64)
 
 static bool do_FMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sub, bool sel)
 {
@@ -7101,7 +7101,7 @@ TRANS_FEAT_NONSTREAMING(BFMMLA, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
 static bool do_BFMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
 {
     return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlal,
-                              a->rd, a->rn, a->rm, a->ra, sel, FPST_FPCR);
+                              a->rd, a->rn, a->rm, a->ra, sel, FPST_A64);
 }
 
 TRANS_FEAT(BFMLALB_zzzw, aa64_sve_bf16, do_BFMLAL_zzzw, a, false)
@@ -7111,7 +7111,7 @@ static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
 {
     return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlal_idx,
                               a->rd, a->rn, a->rm, a->ra,
-                              (a->index << 1) | sel, FPST_FPCR);
+                              (a->index << 1) | sel, FPST_A64);
 }
 
 TRANS_FEAT(BFMLALB_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, false)
-- 
2.34.1


