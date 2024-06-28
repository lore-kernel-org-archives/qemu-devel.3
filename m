Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895E4C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCWk-0002gc-N3; Fri, 28 Jun 2024 10:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWW-0002ap-Ge
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:28 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWA-0004WA-7R
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:19 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eaea28868dso9543361fa.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719584636; x=1720189436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uem/v2axAJA0BB1dpydfxHH8U9BEMfWx4sO4XmB5FGg=;
 b=LO6DA8gpEHR9mn5CMU7NNz+nWMpB2Zh5YbCed+h1r61DWFIUF76hYgiDLkcOyEqNhD
 b31vsFc++JgAnPh96r3vT7jq36A0SNj3Vkiz/ONt5GvDYPWn+YUAS1XoAghq0KE9aMP7
 rNQS3EPo+IbIxPkkRTCaKPW5THNx6/NEvF2zKNzbopJswo2MpN6ASK5MvLlsR4MbhIKI
 YevdqNztCPIC4iheyjiX2HAtn3tLk2kI/DpRmhrXOCaFqVQH83GDC5qug1BaDUP2miyx
 xc/XJM+7ifcsCKr1OjpnVlI/2JZ68yY4NI2HV+qEZsfzR9WXct7GE31KMeBZg32fQauO
 RlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719584636; x=1720189436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uem/v2axAJA0BB1dpydfxHH8U9BEMfWx4sO4XmB5FGg=;
 b=rO4iwKK6nspZHBwYkHuryoABT08wswBiGoqz1tLeEPu0Pd0C7IxdctbaEQZ8PhAl4D
 lhOPsLrlK5/mnvv38++8SPZv4NC5cPS2uBqzFefYlwMHl5Dbmu2ZrdLiLKnaRWoXES1L
 /AAfH22hKT9P2ZxhFLBFU4UoiVRhlCCnIzDZa4wOc3hOXuA9ob6Ow1ZTUQSqFqXtL427
 JrIA1yE1R3/9BDW3pu4f8YC22Eg7XX5A7Z2sywgvldfxsuPgA6MYUlTzxaZCVpEuiiNX
 fhN408lPt6Ab+yYbx7a3GnFN+htveVJRp7vqkgryj25ilqooQtG1cwPlXsxoOnKrk/37
 co0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSYOFdgGxrHjknhfncFTd0O3TPcm4PxL2IwLlB5yfzVdEyneOKbmevbndNNfjoPgzF14NYq1YSgKi1ZmU5UtqG75Jp17Y=
X-Gm-Message-State: AOJu0YwzqWMuTPNXAJ4Yp0xDt4SBCxOBN3vvIrK9zI32e7JfCCG/aNWi
 sW75sPEeB0Y1+B+RU/BhPJ/cyHD6PvOcL0JpjT3yDtI27WIVr0lvwqILu0wQYts=
X-Google-Smtp-Source: AGHT+IH5fDky1iDheHciv83SBIKGthfDA03HpqmV873ctQPmr7grLSbe7cnYnHLoNqYxlo9qgFmDCA==
X-Received: by 2002:a2e:8048:0:b0:2ee:4f58:7738 with SMTP id
 38308e7fff4ca-2ee4f5878f3mr24804511fa.17.1719584636538; 
 Fri, 28 Jun 2024 07:23:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55c0asm37180945e9.15.2024.06.28.07.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 07:23:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 7/9] target/arm: Rename FPCR_ QC, NZCV macros to FPSR_
Date: Fri, 28 Jun 2024 15:23:45 +0100
Message-Id: <20240628142347.1283015-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628142347.1283015-1-peter.maydell@linaro.org>
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The QC, N, Z, C, V bits live in the FPSR, not the FPCR. Rename the
macros that define these bits accordingly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h                  | 17 ++++++++++-------
 target/arm/tcg/mve_helper.c       |  8 ++++----
 target/arm/tcg/translate-m-nocp.c | 16 ++++++++--------
 target/arm/tcg/translate-vfp.c    |  2 +-
 target/arm/vfp_helper.c           |  8 ++++----
 5 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2eb7fc3bc39..9d226c474d2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1697,6 +1697,7 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPSR_MASK 0xf800009f
 #define FPCR_MASK 0x07ff9f00
 
+/* FPCR bits */
 #define FPCR_IOE    (1 << 8)    /* Invalid Operation exception trap enable */
 #define FPCR_DZE    (1 << 9)    /* Divide by Zero exception trap enable */
 #define FPCR_OFE    (1 << 10)   /* Overflow exception trap enable */
@@ -1708,18 +1709,20 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPCR_FZ     (1 << 24)   /* Flush-to-zero enable bit */
 #define FPCR_DN     (1 << 25)   /* Default NaN enable bit */
 #define FPCR_AHP    (1 << 26)   /* Alternative half-precision */
-#define FPCR_QC     (1 << 27)   /* Cumulative saturation bit */
-#define FPCR_V      (1 << 28)   /* FP overflow flag */
-#define FPCR_C      (1 << 29)   /* FP carry flag */
-#define FPCR_Z      (1 << 30)   /* FP zero flag */
-#define FPCR_N      (1 << 31)   /* FP negative flag */
 
 #define FPCR_LTPSIZE_SHIFT 16   /* LTPSIZE, M-profile only */
 #define FPCR_LTPSIZE_MASK (7 << FPCR_LTPSIZE_SHIFT)
 #define FPCR_LTPSIZE_LENGTH 3
 
-#define FPCR_NZCV_MASK (FPCR_N | FPCR_Z | FPCR_C | FPCR_V)
-#define FPCR_NZCVQC_MASK (FPCR_NZCV_MASK | FPCR_QC)
+/* FPSR bits */
+#define FPSR_QC     (1 << 27)   /* Cumulative saturation bit */
+#define FPSR_V      (1 << 28)   /* FP overflow flag */
+#define FPSR_C      (1 << 29)   /* FP carry flag */
+#define FPSR_Z      (1 << 30)   /* FP zero flag */
+#define FPSR_N      (1 << 31)   /* FP negative flag */
+
+#define FPSR_NZCV_MASK (FPSR_N | FPSR_Z | FPSR_C | FPSR_V)
+#define FPSR_NZCVQC_MASK (FPSR_NZCV_MASK | FPSR_QC)
 
 /**
  * vfp_get_fpsr: read the AArch64 FPSR
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 234f395b093..03ebef5ef21 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -1115,21 +1115,21 @@ static void do_vadc(CPUARMState *env, uint32_t *d, uint32_t *n, uint32_t *m,
 
     if (update_flags) {
         /* Store C, clear NZV. */
-        env->vfp.fpsr &= ~FPCR_NZCV_MASK;
-        env->vfp.fpsr |= carry_in * FPCR_C;
+        env->vfp.fpsr &= ~FPSR_NZCV_MASK;
+        env->vfp.fpsr |= carry_in * FPSR_C;
     }
     mve_advance_vpt(env);
 }
 
 void HELPER(mve_vadc)(CPUARMState *env, void *vd, void *vn, void *vm)
 {
-    bool carry_in = env->vfp.fpsr & FPCR_C;
+    bool carry_in = env->vfp.fpsr & FPSR_C;
     do_vadc(env, vd, vn, vm, 0, carry_in, false);
 }
 
 void HELPER(mve_vsbc)(CPUARMState *env, void *vd, void *vn, void *vm)
 {
-    bool carry_in = env->vfp.fpsr & FPCR_C;
+    bool carry_in = env->vfp.fpsr & FPSR_C;
     do_vadc(env, vd, vn, vm, -1, carry_in, false);
 }
 
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index 875f6a8725d..b92773b4af5 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -332,7 +332,7 @@ static bool gen_M_fp_sysreg_write(DisasContext *s, int regno,
         if (dc_isar_feature(aa32_mve, s)) {
             /* QC is only present for MVE; otherwise RES0 */
             TCGv_i32 qc = tcg_temp_new_i32();
-            tcg_gen_andi_i32(qc, tmp, FPCR_QC);
+            tcg_gen_andi_i32(qc, tmp, FPSR_QC);
             /*
              * The 4 vfp.qc[] fields need only be "zero" vs "non-zero";
              * here writing the same value into all elements is simplest.
@@ -340,9 +340,9 @@ static bool gen_M_fp_sysreg_write(DisasContext *s, int regno,
             tcg_gen_gvec_dup_i32(MO_32, offsetof(CPUARMState, vfp.qc),
                                  16, 16, qc);
         }
-        tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
+        tcg_gen_andi_i32(tmp, tmp, FPSR_NZCV_MASK);
         fpscr = load_cpu_field_low32(vfp.fpsr);
-        tcg_gen_andi_i32(fpscr, fpscr, ~FPCR_NZCV_MASK);
+        tcg_gen_andi_i32(fpscr, fpscr, ~FPSR_NZCV_MASK);
         tcg_gen_or_i32(fpscr, fpscr, tmp);
         store_cpu_field_low32(fpscr, vfp.fpsr);
         break;
@@ -390,7 +390,7 @@ static bool gen_M_fp_sysreg_write(DisasContext *s, int regno,
         tcg_gen_deposit_i32(control, control, sfpa,
                             R_V7M_CONTROL_SFPA_SHIFT, 1);
         store_cpu_field(control, v7m.control[M_REG_S]);
-        tcg_gen_andi_i32(tmp, tmp, ~FPCR_NZCV_MASK);
+        tcg_gen_andi_i32(tmp, tmp, ~FPSR_NZCV_MASK);
         gen_helper_vfp_set_fpscr(tcg_env, tmp);
         s->base.is_jmp = DISAS_UPDATE_NOCHAIN;
         break;
@@ -457,7 +457,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
     case ARM_VFP_FPSCR_NZCVQC:
         tmp = tcg_temp_new_i32();
         gen_helper_vfp_get_fpscr(tmp, tcg_env);
-        tcg_gen_andi_i32(tmp, tmp, FPCR_NZCVQC_MASK);
+        tcg_gen_andi_i32(tmp, tmp, FPSR_NZCVQC_MASK);
         storefn(s, opaque, tmp, true);
         break;
     case QEMU_VFP_FPSCR_NZCV:
@@ -466,7 +466,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
          * helper call for the "VMRS to CPSR.NZCV" insn.
          */
         tmp = load_cpu_field_low32(vfp.fpsr);
-        tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
+        tcg_gen_andi_i32(tmp, tmp, FPSR_NZCV_MASK);
         storefn(s, opaque, tmp, true);
         break;
     case ARM_VFP_FPCXT_S:
@@ -476,7 +476,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
         tmp = tcg_temp_new_i32();
         sfpa = tcg_temp_new_i32();
         gen_helper_vfp_get_fpscr(tmp, tcg_env);
-        tcg_gen_andi_i32(tmp, tmp, ~FPCR_NZCV_MASK);
+        tcg_gen_andi_i32(tmp, tmp, ~FPSR_NZCV_MASK);
         control = load_cpu_field(v7m.control[M_REG_S]);
         tcg_gen_andi_i32(sfpa, control, R_V7M_CONTROL_SFPA_MASK);
         tcg_gen_shli_i32(sfpa, sfpa, 31 - R_V7M_CONTROL_SFPA_SHIFT);
@@ -529,7 +529,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
         sfpa = tcg_temp_new_i32();
         fpscr = tcg_temp_new_i32();
         gen_helper_vfp_get_fpscr(fpscr, tcg_env);
-        tcg_gen_andi_i32(tmp, fpscr, ~FPCR_NZCV_MASK);
+        tcg_gen_andi_i32(tmp, fpscr, ~FPSR_NZCV_MASK);
         control = load_cpu_field(v7m.control[M_REG_S]);
         tcg_gen_andi_i32(sfpa, control, R_V7M_CONTROL_SFPA_MASK);
         tcg_gen_shli_i32(sfpa, sfpa, 31 - R_V7M_CONTROL_SFPA_SHIFT);
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 0d9788e8103..cd5b8483576 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -834,7 +834,7 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
         case ARM_VFP_FPSCR:
             if (a->rt == 15) {
                 tmp = load_cpu_field_low32(vfp.fpsr);
-                tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
+                tcg_gen_andi_i32(tmp, tmp, FPSR_NZCV_MASK);
             } else {
                 tmp = tcg_temp_new_i32();
                 gen_helper_vfp_get_fpscr(tmp, tcg_env);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index f7a3da7f68b..1ac0142e10f 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -196,7 +196,7 @@ uint32_t vfp_get_fpsr(CPUARMState *env)
     fpsr |= vfp_get_fpsr_from_host(env);
 
     i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
-    fpsr |= i ? FPCR_QC : 0;
+    fpsr |= i ? FPSR_QC : 0;
     return fpsr;
 }
 
@@ -222,7 +222,7 @@ void vfp_set_fpsr(CPUARMState *env, uint32_t val)
          * The bit we set within fpscr_q is arbitrary; the register as a
          * whole being zero/non-zero is what counts.
          */
-        env->vfp.qc[0] = val & FPCR_QC;
+        env->vfp.qc[0] = val & FPSR_QC;
         env->vfp.qc[1] = 0;
         env->vfp.qc[2] = 0;
         env->vfp.qc[3] = 0;
@@ -234,7 +234,7 @@ void vfp_set_fpsr(CPUARMState *env, uint32_t val)
      * fp_status, and QC is in vfp.qc[]. Store the NZCV bits there,
      * and zero any of the other FPSR bits.
      */
-    val &= FPCR_NZCV_MASK;
+    val &= FPSR_NZCV_MASK;
     env->vfp.fpsr = val;
 }
 
@@ -1156,7 +1156,7 @@ uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
     uint32_t z = (pair >> 32) == 0;
 
     /* Store Z, clear NCV, in FPSCR.NZCV.  */
-    env->vfp.fpsr = (env->vfp.fpsr & ~FPCR_NZCV_MASK) | (z * FPCR_Z);
+    env->vfp.fpsr = (env->vfp.fpsr & ~FPSR_NZCV_MASK) | (z * FPSR_Z);
 
     return result;
 }
-- 
2.34.1


