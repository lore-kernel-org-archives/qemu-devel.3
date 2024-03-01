Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF330C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg7gT-0006U2-Lt; Fri, 01 Mar 2024 13:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gN-0006RU-W5
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:33 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gJ-0008LP-HU
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:31 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412ce4f62f8so2106845e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709317944; x=1709922744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVVKscQ5vCUHxCMh3/cOUoLf8I/F9iPoQ7drxX5MzdQ=;
 b=nS0ChmGQ2DyuJQm9Mtnr8QGv2Es55jFanHbLy/j55jlXev1aqwRsMCkWao+qAEiYUn
 KOdj6QZdhTXfZ9Fgp4TjTAsXVEudSLB1nn7wu2P4egdyI4nMkwOeHVntjiJ8VWbP1pDD
 tKlEvWKsi+csxGfTTSCeeEAyUwSQivNVyFUDwvAga0w5AWUXDAPhZchDWIJwI7r9wY/D
 Mzpan9jtYLS7svAKwPeO+o/BbS515RSsRxcD82eTNPPxXWnJlES1B5Z0eDsjYLWTwzVd
 5oS9qkjXR0pw6cF+/dpcQiXyGUtSvzojwrx6Dk5cu1A5j3W308fv1MSy1V2/U7hqhN4l
 8MgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709317944; x=1709922744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hVVKscQ5vCUHxCMh3/cOUoLf8I/F9iPoQ7drxX5MzdQ=;
 b=AqTKmpKAAH9iOGdAmlTI0MzSuVJupix5Pm/HG74/VRwYF0FOaWG0rgWt9aaczW/xkk
 k6wURrNBIKACPbzTCnsEzJ/s46nRJ4xVBMFcbJjCbgv0/qLKzXx4cpqrfS0DkByNntl3
 IOy/IJwxaIBktUU2oGQxFRGKyZ94vFcJNoTIiZWH63rSWonPg/WlzERXtZMhomR/OyGk
 eJzQSx2YyqPjA5TBMtw5UlaJLJtY+iTdQCLuHHOK8OflY/E+32wq69mIqkzC0DnNEIkG
 OUExLyCMrwPL6FFTxUG+L0uUaIjahMBcgdZERdWhNT2Vc4gKQ91x//SZ0hFwx3dsFBS4
 klkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5mcvoUYZK7EbkRAtwo1q4mrWuQETD9MyKqVQjuj06/5eI+uJY2G19XwmoMVhfaRv545A2Ttd+3MQ2S3Qc34UK307vOOc=
X-Gm-Message-State: AOJu0YyBFjB4Ifk0KUHQq239ghBjVNaWU3bv75gGFXz1Cw54IQnpWOp9
 cCt8dt2kAfevi2jfy2lufSgM1kZ35GoSTUr7kkeVEo0d8TFW+8Dt7Y0Xw4oHEVs=
X-Google-Smtp-Source: AGHT+IF1Cob9zTiI5DEDo58tyNws/gB/cba8T1mphYQVnAs4hpEGzT6r2iKHDg/iRk5TF1annX4Rcg==
X-Received: by 2002:adf:9ccb:0:b0:33c:deed:6745 with SMTP id
 h11-20020adf9ccb000000b0033cdeed6745mr2146626wre.13.1709317944481; 
 Fri, 01 Mar 2024 10:32:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u2-20020adfeb42000000b0033b483d1abcsm5158934wrn.53.2024.03.01.10.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:32:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 7/8] target/arm: Implement FEAT_ECV CNTPOFF_EL2 handling
Date: Fri,  1 Mar 2024 18:32:18 +0000
Message-Id: <20240301183219.2424889-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301183219.2424889-1-peter.maydell@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When ID_AA64MMFR0_EL1.ECV is 0b0010, a new register CNTPOFF_EL2 is
implemented.  This is similar to the existing CNTVOFF_EL2, except
that it controls a hypervisor-adjustable offset made to the physical
counter and timer.

Implement the handling for this register, which includes control/trap
bits in SCR_EL3 and CNTHCTL_EL2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h |  5 +++
 target/arm/cpu.h          |  1 +
 target/arm/helper.c       | 68 +++++++++++++++++++++++++++++++++++++--
 target/arm/trace-events   |  1 +
 4 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b447ec5c0e6..e5758d9fbc8 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -746,6 +746,11 @@ static inline bool isar_feature_aa64_ecv_traps(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, ECV) > 0;
 }
 
+static inline bool isar_feature_aa64_ecv(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, ECV) > 1;
+}
+
 static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3cbfd4f9a74..262ebbf1c19 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -453,6 +453,7 @@ typedef struct CPUArchState {
         uint64_t c14_cntkctl; /* Timer Control register */
         uint64_t cnthctl_el2; /* Counter/Timer Hyp Control register */
         uint64_t cntvoff_el2; /* Counter Virtual Offset register */
+        uint64_t cntpoff_el2; /* Counter Physical Offset register */
         ARMGenericTimer c14_timer[NUM_GTIMERS];
         uint32_t c15_cpar; /* XScale Coprocessor Access Register */
         uint32_t c15_ticonfig; /* TI925T configuration byte.  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3441b14ba39..f590bdf0f7e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1923,6 +1923,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_rme, cpu)) {
             valid_mask |= SCR_NSE | SCR_GPF;
         }
+        if (cpu_isar_feature(aa64_ecv, cpu)) {
+            valid_mask |= SCR_ECVEN;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -2682,6 +2685,25 @@ void gt_rme_post_el_change(ARMCPU *cpu, void *ignored)
     gt_update_irq(cpu, GTIMER_PHYS);
 }
 
+static uint64_t gt_phys_raw_cnt_offset(CPUARMState *env)
+{
+    if ((env->cp15.scr_el3 & SCR_ECVEN) &&
+        FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, ECV) &&
+        arm_is_el2_enabled(env) &&
+        (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+        return env->cp15.cntpoff_el2;
+    }
+    return 0;
+}
+
+static uint64_t gt_phys_cnt_offset(CPUARMState *env)
+{
+    if (arm_current_el(env) >= 2) {
+        return 0;
+    }
+    return gt_phys_raw_cnt_offset(env);
+}
+
 static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
 {
     ARMGenericTimer *gt = &cpu->env.cp15.c14_timer[timeridx];
@@ -2692,7 +2714,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
          * reset timer to when ISTATUS next has to change
          */
         uint64_t offset = timeridx == GTIMER_VIRT ?
-                                      cpu->env.cp15.cntvoff_el2 : 0;
+            cpu->env.cp15.cntvoff_el2 : gt_phys_raw_cnt_offset(&cpu->env);
         uint64_t count = gt_get_countervalue(&cpu->env);
         /* Note that this must be unsigned 64 bit arithmetic: */
         int istatus = count - offset >= gt->cval;
@@ -2755,7 +2777,7 @@ static void gt_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env);
+    return gt_get_countervalue(env) - gt_phys_cnt_offset(env);
 }
 
 static uint64_t gt_virt_cnt_offset(CPUARMState *env)
@@ -2804,6 +2826,9 @@ static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
     case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
+    case GTIMER_PHYS:
+        offset = gt_phys_cnt_offset(env);
+        break;
     }
 
     return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
@@ -2821,6 +2846,9 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
     case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
+    case GTIMER_PHYS:
+        offset = gt_phys_cnt_offset(env);
+        break;
     }
 
     trace_arm_gt_tval_write(timeridx, value);
@@ -3000,6 +3028,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
             R_CNTHCTL_EL1NVVCT_MASK |
             R_CNTHCTL_EVNTIS_MASK;
     }
+    if (cpu_isar_feature(aa64_ecv, cpu)) {
+        valid_mask |= R_CNTHCTL_ECV_MASK;
+    }
 
     /* Clear RES0 bits */
     value &= valid_mask;
@@ -3417,6 +3448,34 @@ static const ARMCPRegInfo gen_timer_ecv_cp_reginfo[] = {
     },
 };
 
+static CPAccessResult gt_cntpoff_access(CPUARMState *env,
+                                        const ARMCPRegInfo *ri,
+                                        bool isread)
+{
+    if (arm_current_el(env) == 2 && !(env->cp15.scr_el3 & SCR_ECVEN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static void gt_cntpoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    trace_arm_gt_cntpoff_write(value);
+    raw_write(env, ri, value);
+    gt_recalc_timer(cpu, GTIMER_PHYS);
+}
+
+static const ARMCPRegInfo gen_timer_cntpoff_reginfo = {
+    .name = "CNTPOFF_EL2", .state = ARM_CP_STATE_AA64,
+    .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 0, .opc2 = 6,
+    .access = PL2_RW, .type = ARM_CP_IO, .resetvalue = 0,
+    .accessfn = gt_cntpoff_access, .writefn = gt_cntpoff_write,
+    .nv2_redirect_offset = 0x1a8,
+    .fieldoffset = offsetof(CPUARMState, cp15.cntpoff_el2),
+};
 #else
 
 /*
@@ -9301,6 +9360,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_ecv_traps, cpu)) {
         define_arm_cp_regs(cpu, gen_timer_ecv_cp_reginfo);
     }
+#ifndef CONFIG_USER_ONLY
+    if (cpu_isar_feature(aa64_ecv, cpu)) {
+        define_one_arm_cp_reg(cpu, &gen_timer_cntpoff_reginfo);
+    }
+#endif
     if (arm_feature(env, ARM_FEATURE_VAPA)) {
         ARMCPRegInfo vapa_cp_reginfo[] = {
             { .name = "PAR", .cp = 15, .crn = 7, .crm = 4, .opc1 = 0, .opc2 = 0,
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 48cc0512dbe..4438dce7bec 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -8,6 +8,7 @@ arm_gt_tval_write(int timer, uint64_t value) "gt_tval_write: timer %d value 0x%"
 arm_gt_ctl_write(int timer, uint64_t value) "gt_ctl_write: timer %d value 0x%" PRIx64
 arm_gt_imask_toggle(int timer) "gt_ctl_write: timer %d IMASK toggle"
 arm_gt_cntvoff_write(uint64_t value) "gt_cntvoff_write: value 0x%" PRIx64
+arm_gt_cntpoff_write(uint64_t value) "gt_cntpoff_write: value 0x%" PRIx64
 arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 
 # kvm.c
-- 
2.34.1


