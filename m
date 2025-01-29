Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A5CC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2o-0000mr-B8; Tue, 28 Jan 2025 20:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2m-0000lQ-8A
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:04 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2k-0003Ti-3w
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:03 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso108634765ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114741; x=1738719541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEKr8gn5r7dTPdnjanNubYZRqYeexGmGHnTnYnhCaJY=;
 b=qSg+SW/LzfjhAHyGPxkSx/fah93vVwfkxUPHCyvdBpogmJsDQOu/d5ReoYkRpzWT3N
 KHfjzE5+/y6msT/fMrtXGqL2Zc7Bqi/wbQIcLu4MxsrDBUkrarTEiDSHmDiuifyqSBUz
 l8bfUjCH0AmyhYJuOfvn89TO3JwgStsB1n5ewMadPz178/diWvDwEltD8lD6DrnBaAO7
 5AsB9LJS4HvUNp2eW6AwIYBRSJOztevJKRpH8SviR7p1Cz3kIAcdWyfjYn/seAmGT4i4
 hLv2PcJ9ENfui6HOgbFeOsUXzC69AgVbCKrL2j7/V/ilj4amaklFVtPzbeCDux8KJ5re
 xfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114741; x=1738719541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cEKr8gn5r7dTPdnjanNubYZRqYeexGmGHnTnYnhCaJY=;
 b=k4P9qXZ0NXxgHeQ4Ohb2g1pHPuPihqtSl5QlJYwXZ6b4Ah+ywLdMJG4X0wE95QxyS2
 nmcPwdV/CM81smNASnM7BSd57Di/p15TZ46tqqCVmk90S/lTOUtzGj7eMQVqKhAHYS7p
 kbyAg3be1KYJEnX1icW1IhTmgy/hWn1u2HbFqK9twbaZUuJ0KCmf6fOT0oWn3eat9h2R
 y/1FxBASg9lf5qb0q9slStSwhYLcO0wMsyJk4+/MWJu3w3gBMwpykZVKwlnDXri/35Rt
 YUE/liwPVaq3ba/4x3JkoZ6S6JsKIs71wyN0Np28dqmH95EfIPmC1SmGB9FfeQGZLEUV
 LPwQ==
X-Gm-Message-State: AOJu0YznXbOUw2rHErUQFsb4Aok5JneWBAXqFPRJ8+e1FnkThfZladFa
 mDv822qq82I6a7ay3lMii0u1+StmO3t3edVGy7UVVPUhSzTWoOEN2H55COkQevdkCz6xq8US9sk
 w
X-Gm-Gg: ASbGncvmd7Zu4enuXoQpXeuKWAUoN10Jm1NVpfvA+hUjjBTusEeupj1NhMIXPY280Lf
 qO7N3UroC5H2Um/GazzZ0Y2TR/J2D1d4Sb+bkyg1/v533y9cg4jtPk2R2gMsnx8v5gpRX8A9yZq
 ZAsDs8G06ug3KQ53cXKi9JJBV4OCtq0n4BrbAFDLWfG7sUF5IGcaainMFZLEiTY9c1fp33I5TGr
 Qjsmcg0Kun0KSsy51P/zYuaYMWrkN0n7s2FIB8dk/m/RhXOGf63veSsKGWdAofJUuVRjJAgvV7b
 CddFEWrdvV4taIw1hm8GBGiKeVed6M6PfiiD2H4VOeGrknjVBQ==
X-Google-Smtp-Source: AGHT+IGSaKDurqHmRgSkFl4yOJMkHeC3rC+K8qKiFpkYvnggDWGJOL54I4/CGWr8OqB6398UqlMhsQ==
X-Received: by 2002:a17:903:41cc:b0:215:bb50:6a05 with SMTP id
 d9443c01a7336-21dd7c499d2mr14114725ad.9.1738114740773; 
 Tue, 28 Jan 2025 17:39:00 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 03/34] target/arm: Rename FPST_FPCR_F16_A32 to FPST_A32_F16
Date: Tue, 28 Jan 2025 17:38:26 -0800
Message-ID: <20250129013857.135256-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


