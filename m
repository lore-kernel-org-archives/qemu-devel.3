Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E695BC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcry0-0002Gf-CR; Tue, 28 Jan 2025 15:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxw-0002Ep-Hb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:45 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxt-0001cz-6o
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:44 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4368a293339so69456725e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095220; x=1738700020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r17lK6EWItzezJyUoImPl9XSowSNSJOkNsi0cwyoOMU=;
 b=bSQ5SSKYKV6fSDj3djy5S7RmxyzIC0XeWRDWPpnDG9KTdjlEdMlHs5qb7P44UxqIHd
 yxC4zHryWTh1mHRkbAMGn4UiMbXJ8IG5ItL4DiTWNIuHOhF3q5Kv6z3a9v7/911Cccyn
 a0+ZLN1lgn1e7zthUYLLKtmc8X70DiE05/zUajXPo0nsohITJ3TJ8indXAoJPexwyeAd
 a8hdL3/04yU7xErlMWdC7Sala1ezz68UMEtdSC2c71LFq5fjFWoff/38wMcnt6DOmc7g
 nKmIJw4GHRC9sHXXE1XUhZo9rh6Vci9lqiEzSEY25m8F/yM8rGcpUAhyaP128PjzEEQZ
 FdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095220; x=1738700020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r17lK6EWItzezJyUoImPl9XSowSNSJOkNsi0cwyoOMU=;
 b=v6+L5xGsnOgifdJmvU0bkIQbecgIAwk5QbAnl+GNn4fYJQswBruPz3oNp22QgWNjx9
 Bau8e/JHc88BmeJqaNWsD60XKCDsevsH6Qdo+eBs4AjvmqE5CT8E6Ll4VVGKjLUVZtlc
 NuENkk19sZ+C6J5brXUzZ52U8VrilFvRI/wus1qjZ90VQpEkhu1tIimj0/etmDzfbrQp
 8Of/MeXc+kL4lhzFFtBFYymPr/HBAFyLnPO5/w+PRvmHED90UT6SJQ3VM6XtQvfl1KW4
 XIaWqxw9wh25PstnAlfJ6zdMZMFt7PUyx2TgkEEk+dgODFkSwwj4Lit7W603xOZHhEXS
 ZcJQ==
X-Gm-Message-State: AOJu0Yz97R8K7ZKJNpBPD7St128KPXNuLUN+Abu61MumG7wrepLVLrRW
 cGfcUuflzJF3B5M5Nkc0WuoWEKSNbFwqjAyLriDy4oFKQcGoxpRtY+sC8jNu/d+3rMDCIhOPZMI
 5
X-Gm-Gg: ASbGncvi3E4Ugcuw2jSAvhf8gRo09BjQRK4vuUfPFOytkP1rvnDZzYtuk4gZFHbUw7S
 OeWmGxAHv8oNA7Chwvdhs/ka3mp5ZE8Y2ClKT10lCLTGJnvZoc5FMjD6It4fNBmDHGM2VNPI0Wl
 dnRrR/zidBBp0mvQTkU8YmYoilaWRWNWD8pqgg4BKFDb40Dx8DIRD0FmL+eakaKKGVxGz+VEQST
 kJOFp8IjlbT2ZU0rVbfgqub//BW7Nmk5gVk2HNUK2za/YGcKSE2t47WO7JbmlHxXIvDPwBRxXcL
 KHm/QIaP5sS3erbCmxVzQw==
X-Google-Smtp-Source: AGHT+IHxLUM+JaHOVcEmB+q4m2KrBMpSrO9kuYdVXfh1GmINFni1vSSUA5w/9OHZD/ecbDtWjuepTA==
X-Received: by 2002:a05:600c:1d83:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-438dc43540bmr2649785e9.30.1738095219573; 
 Tue, 28 Jan 2025 12:13:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/36] target/arm: Use FPST_A32 in A32 decoder
Date: Tue, 28 Jan 2025 20:13:00 +0000
Message-Id: <20250128201314.44038-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In the A32 decoder, use FPST_A32 rather than FPST_FPCR.  By
doing an automated conversion of the whole file we avoid possibly
using more than one fpst value in a set_rmode/op/restore_rmode
sequence.

Patch created with
  perl -p -i -e 's/FPST_FPCR(?!_)/FPST_A32/g' target/arm/tcg/translate-vfp.c

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-11-peter.maydell@linaro.org
---
 target/arm/tcg/translate-vfp.c | 54 +++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 3cbe9a7418d..c82f41234cd 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -462,7 +462,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
     if (sz == 1) {
         fpst = fpstatus_ptr(FPST_FPCR_F16);
     } else {
-        fpst = fpstatus_ptr(FPST_FPCR);
+        fpst = fpstatus_ptr(FPST_A32);
     }
 
     tcg_rmode = gen_set_rmode(rounding, fpst);
@@ -529,7 +529,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
     if (sz == 1) {
         fpst = fpstatus_ptr(FPST_FPCR_F16);
     } else {
-        fpst = fpstatus_ptr(FPST_FPCR);
+        fpst = fpstatus_ptr(FPST_A32);
     }
 
     tcg_shift = tcg_constant_i32(0);
@@ -1398,7 +1398,7 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
     f0 = tcg_temp_new_i32();
     f1 = tcg_temp_new_i32();
     fd = tcg_temp_new_i32();
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
 
     vfp_load_reg32(f0, vn);
     vfp_load_reg32(f1, vm);
@@ -1517,7 +1517,7 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     f0 = tcg_temp_new_i64();
     f1 = tcg_temp_new_i64();
     fd = tcg_temp_new_i64();
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
 
     vfp_load_reg64(f0, vn);
     vfp_load_reg64(f1, vm);
@@ -2181,7 +2181,7 @@ static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
         /* VFNMA, VFNMS */
         gen_vfp_negs(vd, vd);
     }
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     gen_helper_vfp_muladds(vd, vn, vm, vd, fpst);
     vfp_store_reg32(vd, a->vd);
     return true;
@@ -2246,7 +2246,7 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
         /* VFNMA, VFNMS */
         gen_vfp_negd(vd, vd);
     }
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     gen_helper_vfp_muladdd(vd, vn, vm, vd, fpst);
     vfp_store_reg64(vd, a->vd);
     return true;
@@ -2429,12 +2429,12 @@ static void gen_VSQRT_hp(TCGv_i32 vd, TCGv_i32 vm)
 
 static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
 {
-    gen_helper_vfp_sqrts(vd, vm, fpstatus_ptr(FPST_FPCR));
+    gen_helper_vfp_sqrts(vd, vm, fpstatus_ptr(FPST_A32));
 }
 
 static void gen_VSQRT_dp(TCGv_i64 vd, TCGv_i64 vm)
 {
-    gen_helper_vfp_sqrtd(vd, vm, fpstatus_ptr(FPST_FPCR));
+    gen_helper_vfp_sqrtd(vd, vm, fpstatus_ptr(FPST_A32));
 }
 
 DO_VFP_2OP(VSQRT, hp, gen_VSQRT_hp, aa32_fp16_arith)
@@ -2565,7 +2565,7 @@ static bool trans_VCVT_f32_f16(DisasContext *s, arg_VCVT_f32_f16 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
     /* The T bit tells us if we want the low or high 16 bits of Vm */
@@ -2599,7 +2599,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
     /* The T bit tells us if we want the low or high 16 bits of Vm */
@@ -2623,7 +2623,7 @@ static bool trans_VCVT_b16_f32(DisasContext *s, arg_VCVT_b16_f32 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     tmp = tcg_temp_new_i32();
 
     vfp_load_reg32(tmp, a->vm);
@@ -2646,7 +2646,7 @@ static bool trans_VCVT_f16_f32(DisasContext *s, arg_VCVT_f16_f32 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
 
@@ -2680,7 +2680,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
     vm = tcg_temp_new_i64();
@@ -2727,7 +2727,7 @@ static bool trans_VRINTR_sp(DisasContext *s, arg_VRINTR_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg32(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     gen_helper_rints(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
     return true;
@@ -2757,7 +2757,7 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
 
     tmp = tcg_temp_new_i64();
     vfp_load_reg64(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     gen_helper_rintd(tmp, tmp, fpst);
     vfp_store_reg64(tmp, a->vd);
     return true;
@@ -2803,7 +2803,7 @@ static bool trans_VRINTZ_sp(DisasContext *s, arg_VRINTZ_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg32(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     tcg_rmode = gen_set_rmode(FPROUNDING_ZERO, fpst);
     gen_helper_rints(tmp, tmp, fpst);
     gen_restore_rmode(tcg_rmode, fpst);
@@ -2836,7 +2836,7 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
 
     tmp = tcg_temp_new_i64();
     vfp_load_reg64(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     tcg_rmode = gen_set_rmode(FPROUNDING_ZERO, fpst);
     gen_helper_rintd(tmp, tmp, fpst);
     gen_restore_rmode(tcg_rmode, fpst);
@@ -2880,7 +2880,7 @@ static bool trans_VRINTX_sp(DisasContext *s, arg_VRINTX_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg32(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     gen_helper_rints_exact(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
     return true;
@@ -2910,7 +2910,7 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
 
     tmp = tcg_temp_new_i64();
     vfp_load_reg64(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     gen_helper_rintd_exact(tmp, tmp, fpst);
     vfp_store_reg64(tmp, a->vd);
     return true;
@@ -2937,7 +2937,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i64();
     vfp_load_reg32(vm, a->vm);
-    gen_helper_vfp_fcvtds(vd, vm, fpstatus_ptr(FPST_FPCR));
+    gen_helper_vfp_fcvtds(vd, vm, fpstatus_ptr(FPST_A32));
     vfp_store_reg64(vd, a->vd);
     return true;
 }
@@ -2963,7 +2963,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     vd = tcg_temp_new_i32();
     vm = tcg_temp_new_i64();
     vfp_load_reg64(vm, a->vm);
-    gen_helper_vfp_fcvtsd(vd, vm, fpstatus_ptr(FPST_FPCR));
+    gen_helper_vfp_fcvtsd(vd, vm, fpstatus_ptr(FPST_A32));
     vfp_store_reg32(vd, a->vd);
     return true;
 }
@@ -3010,7 +3010,7 @@ static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
 
     vm = tcg_temp_new_i32();
     vfp_load_reg32(vm, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     if (a->s) {
         /* i32 -> f32 */
         gen_helper_vfp_sitos(vm, vm, fpst);
@@ -3044,7 +3044,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i64();
     vfp_load_reg32(vm, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     if (a->s) {
         /* i32 -> f64 */
         gen_helper_vfp_sitod(vd, vm, fpst);
@@ -3161,7 +3161,7 @@ static bool trans_VCVT_fix_sp(DisasContext *s, arg_VCVT_fix_sp *a)
     vd = tcg_temp_new_i32();
     vfp_load_reg32(vd, a->vd);
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     shift = tcg_constant_i32(frac_bits);
 
     /* Switch on op:U:sx bits */
@@ -3223,7 +3223,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     vd = tcg_temp_new_i64();
     vfp_load_reg64(vd, a->vd);
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     shift = tcg_constant_i32(frac_bits);
 
     /* Switch on op:U:sx bits */
@@ -3307,7 +3307,7 @@ static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     vm = tcg_temp_new_i32();
     vfp_load_reg32(vm, a->vm);
 
@@ -3347,7 +3347,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(FPST_A32);
     vm = tcg_temp_new_i64();
     vd = tcg_temp_new_i32();
     vfp_load_reg64(vm, a->vm);
-- 
2.34.1


