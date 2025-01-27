Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8222DC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYUq-0006QM-62; Mon, 27 Jan 2025 18:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUf-0006Kh-Cu
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:14 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUb-0005We-KB
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:13 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so8865411a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020368; x=1738625168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEKr8gn5r7dTPdnjanNubYZRqYeexGmGHnTnYnhCaJY=;
 b=PSlkFC3Z2EqKhl6nuMtDF77SUd6tdoT41TluYEP0jltinzEL7jbdel9SCMJWZNLp3t
 cnSNyTnjhqni9bsIWSbG6Oi/XI3dPQXS8b+WW9y+IUl7B+/kyKrCF38wJT72L31lFQrr
 S3OKNbZXjX1MzujaYaoZAQBtgFmpoxq98EUw92Ul3ak2vSmq015UTueDAoHHELjRtrLe
 EjtHsdZUFj1YO6QddhNzw/TlgIygNdyC0GbxwjgX6uKSRLWn7eghP2Flzp4Ytw5MsrQB
 PayBUMqZYozXjVXf7inA3qNVO60ZblIHbKZ4eiy8Glz8q/rvqXAnGQqoLYZiHB2xOfZk
 +K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020368; x=1738625168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cEKr8gn5r7dTPdnjanNubYZRqYeexGmGHnTnYnhCaJY=;
 b=uPq/NRuKlDEL+JH05tEslwU4P6G+I7y09QtYcTnTk9v3GJ9Nof4g91Ko4YiqUO7GUt
 LNR+npCUsvJrwQOm8MH2kgnpA+D0VBxcM6GucOzVI1WjlDsL5xV65Q9N1RtMQLLrwCK5
 0dGdHXiYGXkli2iJ60Gn2v23HQGrggVaYoZ1SfWQ0PTJuFuytIoJU920rCY6dYqmqGqA
 4QUQaJKll9IiwVP1+Qnb7U+ZDuGHJNA11hUM/QTW2V60PQWQBBiMzYjJsGSo+csbDgTB
 HptrYVr32OVhBSku9TDLzb4PsCpKJ8HfQv1RV+UdD8JlNm2UtXOXPtVBaEPYkpebz7zH
 HlpQ==
X-Gm-Message-State: AOJu0YyQo5KrxZPH7O8EYJfXwpcCSTKoQozymHh5y2kjzSpoAWA/EaGM
 9hCxjzEbEcbAr5p12InVakbrm8W9Fmzg4IQVLaYwWmRu3i8SPd52lb5lX0P8Zd5nMLQueAoQ3aQ
 Q
X-Gm-Gg: ASbGncvJT4Pu6WiQ/a6lzYSKPK5T12TFFjm83aiWgNUA4tdkcPZCztbplIwW54AJuKQ
 aJ1Q58cU/x3LoKbwFPWGRqYlkSAmsStXHyUxRnHeZBvIlUYpI1ctrFg4V71oHCIW62GnldIZdu9
 noCy2oJ1kfzUnA0S/jAB2CugiXb+EKPSdDA19esd2q69F/HIkl2UWUdkk1QTc+EPdtJxTO9gJRr
 tEA1vJCtR371nv/0MlTWSGPb943/FLjKEPaOJlNLUqnA5GltVp57E3Dqy+8q6yn+eweRc9mJeNn
 u0aJ8jMx2lKywURWWcsM+YFBNOkJiFn5DX8X/Ek=
X-Google-Smtp-Source: AGHT+IESuwrl37qcIvSQJhJVAD1tn35i0QrjjDXdGnFVNkKC+P+OkFNcXCeqnZQeRh+9VrZlLvfgmQ==
X-Received: by 2002:a17:90b:3bc3:b0:2ee:9b2c:3253 with SMTP id
 98e67ed59e1d1-2f782d97961mr62019512a91.30.1738020368100; 
 Mon, 27 Jan 2025 15:26:08 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 03/22] target/arm: Rename FPST_FPCR_F16_A32 to FPST_A32_F16
Date: Mon, 27 Jan 2025 15:25:45 -0800
Message-ID: <20250127232604.20386-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     |  6 +++---
 target/arm/tcg/translate-vfp.c | 24 ++++++++++++------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 2edb707b85..adf6eb8b91 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -676,7 +676,7 @@ static inline CPUARMTBFlags arm_tbflags_from_tb(const TranslationBlock *tb)
 typedef enum ARMFPStatusFlavour {
     FPST_A32,
     FPST_A64,
-    FPST_FPCR_F16_A32,
+    FPST_A32_F16,
     FPST_FPCR_F16_A64,
     FPST_FPCR_AH,
     FPST_FPCR_AH_F16,
@@ -696,7 +696,7 @@ typedef enum ARMFPStatusFlavour {
  *   for AArch32 non-FP16 operations controlled by the FPCR
  * FPST_A64
  *   for AArch64 non-FP16 operations controlled by the FPCR
- * FPST_FPCR_F16_A32
+ * FPST_A32_F16
  *   for AArch32 operations controlled by the FPCR where FPCR.FZ16 is to be used
  * FPST_FPCR_F16_A64
  *   for AArch64 operations controlled by the FPCR where FPCR.FZ16 is to be used
@@ -723,7 +723,7 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     case FPST_A64:
         offset = offsetof(CPUARMState, vfp.fp_status_a64);
         break;
-    case FPST_FPCR_F16_A32:
+    case FPST_A32_F16:
         offset = offsetof(CPUARMState, vfp.fp_status_f16_a32);
         break;
     case FPST_FPCR_F16_A64:
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 4cc12a407b..8d9d1ab877 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -460,7 +460,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
     }
 
     if (sz == 1) {
-        fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
+        fpst = fpstatus_ptr(FPST_A32_F16);
     } else {
         fpst = fpstatus_ptr(FPST_A32);
     }
@@ -527,7 +527,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
     }
 
     if (sz == 1) {
-        fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
+        fpst = fpstatus_ptr(FPST_A32_F16);
     } else {
         fpst = fpstatus_ptr(FPST_A32);
     }
@@ -1433,7 +1433,7 @@ static bool do_vfp_3op_hp(DisasContext *s, VFPGen3OpSPFn *fn,
     /*
      * Do a half-precision operation. Functionally this is
      * the same as do_vfp_3op_sp(), except:
-     *  - it uses the FPST_FPCR_F16_A32
+     *  - it uses the FPST_A32_F16
      *  - it doesn't need the VFP vector handling (fp16 is a
      *    v8 feature, and in v8 VFP vectors don't exist)
      *  - it does the aa32_fp16_arith feature test
@@ -1456,7 +1456,7 @@ static bool do_vfp_3op_hp(DisasContext *s, VFPGen3OpSPFn *fn,
     f0 = tcg_temp_new_i32();
     f1 = tcg_temp_new_i32();
     fd = tcg_temp_new_i32();
-    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
+    fpst = fpstatus_ptr(FPST_A32_F16);
 
     vfp_load_reg16(f0, vn);
     vfp_load_reg16(f1, vm);
@@ -2122,7 +2122,7 @@ static bool do_vfm_hp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
         /* VFNMA, VFNMS */
         gen_vfp_negh(vd, vd);
     }
-    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     gen_helper_vfp_muladdh(vd, vn, vm, vd, fpst);
     vfp_store_reg32(vd, a->vd);
     return true;
@@ -2424,7 +2424,7 @@ DO_VFP_2OP(VNEG, dp, gen_vfp_negd, aa32_fpdp_v2)
 
 static void gen_VSQRT_hp(TCGv_i32 vd, TCGv_i32 vm)
 {
-    gen_helper_vfp_sqrth(vd, vm, fpstatus_ptr(FPST_FPCR_F16_A32));
+    gen_helper_vfp_sqrth(vd, vm, fpstatus_ptr(FPST_A32_F16));
 }
 
 static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
@@ -2706,7 +2706,7 @@ static bool trans_VRINTR_hp(DisasContext *s, arg_VRINTR_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg16(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     gen_helper_rinth(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
     return true;
@@ -2779,7 +2779,7 @@ static bool trans_VRINTZ_hp(DisasContext *s, arg_VRINTZ_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg16(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     tcg_rmode = gen_set_rmode(FPROUNDING_ZERO, fpst);
     gen_helper_rinth(tmp, tmp, fpst);
     gen_restore_rmode(tcg_rmode, fpst);
@@ -2859,7 +2859,7 @@ static bool trans_VRINTX_hp(DisasContext *s, arg_VRINTX_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg16(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     gen_helper_rinth_exact(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
     return true;
@@ -2983,7 +2983,7 @@ static bool trans_VCVT_int_hp(DisasContext *s, arg_VCVT_int_sp *a)
 
     vm = tcg_temp_new_i32();
     vfp_load_reg32(vm, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     if (a->s) {
         /* i32 -> f16 */
         gen_helper_vfp_sitoh(vm, vm, fpst);
@@ -3105,7 +3105,7 @@ static bool trans_VCVT_fix_hp(DisasContext *s, arg_VCVT_fix_sp *a)
     vd = tcg_temp_new_i32();
     vfp_load_reg32(vd, a->vd);
 
-    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     shift = tcg_constant_i32(frac_bits);
 
     /* Switch on op:U:sx bits */
@@ -3273,7 +3273,7 @@ static bool trans_VCVT_hp_int(DisasContext *s, arg_VCVT_sp_int *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     vm = tcg_temp_new_i32();
     vfp_load_reg16(vm, a->vm);
 
-- 
2.43.0


