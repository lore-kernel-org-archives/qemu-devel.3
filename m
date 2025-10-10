Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AA5CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cot-00068G-5o; Fri, 10 Oct 2025 09:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cok-00065I-HE
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CoW-0003lB-Fn
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:54 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso1633969f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101534; x=1760706334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dx5k1CdxaRZ5+Tptck/uq9yaU0heQGJNoP2aoiJPgbc=;
 b=mLjBH+2SusU3Dcm51pIb+nlJGFdyDiiBd3p6jPTwJ6RHWuLfds1WTOou9X/Mr9F+e+
 DSbYbCbu+q6WraclJ7omUJdO4aqNd9lDVCIUeVTObddDNHUB8LznoFUxEl5wHre6n5VJ
 tF0UJ/RKxB00GISZED61uZO5X9eNWstOAOWvRgVls+bDxdnnW0/S3n2AHKp1tDTk8QYZ
 zXCQwyFFXp52rpURt8c4eaZNkefIWmrBBzKo/D4TqZ/3cpAXnyknazOj9Vd4YKsQxrvM
 soiidChi9vSOj4NIxhUZwfjQINQwLgBHt3u+vOm3w19S2Xro4FtllmrqoccKJ9B5NNEl
 syOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101534; x=1760706334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dx5k1CdxaRZ5+Tptck/uq9yaU0heQGJNoP2aoiJPgbc=;
 b=EG1YPJnCy2GsYVzeREWhKJcFm8sN1ilnTeS4yiwJk+SlLKrpzeMFbtAUXZE65nFMND
 aoJ+0FUIh+AtS/Wl065yJph8WdEq7WJP93LCxuHNYhsYmasmBaooI1yR6LkXXDIF/n7u
 LrqE8Cou2GsOpXIxrTU/d/7RhydnccoocgXrk2lJXuHSFkf1Bq209okU2U+29tcSsh8e
 lDtcHqSdBP0E6/VtPixDfNG3T4kx74PmsNdcMOA6kYdT1sp7IzBI/tf8k6+zglA26W18
 JqQ6r9sHa+lQsSSXjPTuxpq9SbLTHswy2JvkFEnnSDf27Ve65VvCL5NVMPpPu5pWfs8M
 shwA==
X-Gm-Message-State: AOJu0Yyhzaj4INKkQrOASP0Qa3Pn5UQQKe/RFhsaCVT4aLQVgkC1+ILT
 CIcGK1jB4PlqmvUwPy9YSJIMia9gl7HU2aAVi5jT6jd1O+aT7rcE2vc1ysuNqzwjUpWtxcfvX+9
 XA5k4
X-Gm-Gg: ASbGncveVpN/mwRysdIktBQymp+U0HcRRqCpnhMTTSKTF3Rbn1EBMlW9DS6td6dH0f4
 ZBYoE2BKW1Smq1NQnK0nwkkfAjMVTMNsVfDhtw/YWySHYAdr9l6WLYaAnZd/JcJuoiUUBiYhjUX
 oxmZFk9+WiL/L4as9L/2AMOHcRqEZ/cN+T48C0gVXQTVqdepbdAPWG/oTGKsrNelzp/yLXIi4dL
 /XB6EimVRmwhMS3L+j1wFFhebN2L9Jj15CIKdBlyhnthAi8D5fuG8v97QGUFyuTFLGO0e6eAqXc
 yMMJEiCCN0CvPQlyxi8G2X4ZVDNMqJT3TZ7vsRlH4LFICigrgQ103d4OczPV8grbXPvmoY0/qhL
 CmFWviArnWgCXGNdU8hSVoe7476k4KAobKTqPbxkaCDiiax38iN5m0i+pE1o7NQ==
X-Google-Smtp-Source: AGHT+IER5l/V/oVy5qOFU5X1q5DPD387hKmVrB0oEYCg9thqLR/3hN7I+IJgMJSBzPDEmavOM6QouQ==
X-Received: by 2002:a5d:5d85:0:b0:3d6:4596:8a3a with SMTP id
 ffacd0b85a97d-4266e7bf18emr8605218f8f.17.1760101534183; 
 Fri, 10 Oct 2025 06:05:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/76] target/arm: Implement PIR_ELx, PIRE0_ELx,
 S2PIR_EL2 registers
Date: Fri, 10 Oct 2025 14:04:15 +0100
Message-ID: <20251010130527.3921602-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h |  2 ++
 target/arm/cpu.h    |  4 +++
 target/arm/cpu.c    |  4 +++
 target/arm/helper.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 57fde5f57ae..f48c4df30fb 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -781,6 +781,8 @@ typedef enum FGTBit {
     DO_BIT(HFGRTR, ERRIDR_EL1),
     DO_REV_BIT(HFGRTR, NSMPRI_EL1),
     DO_REV_BIT(HFGRTR, NTPIDR2_EL0),
+    DO_REV_BIT(HFGRTR, NPIRE0_EL1),
+    DO_REV_BIT(HFGRTR, NPIR_EL1),
 
     /* Trap bits in HDFGRTR_EL2 / HDFGWTR_EL2, starting from bit 0. */
     DO_BIT(HDFGRTR, DBGBCRN_EL1),
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 41414ac22b8..c9ea160d035 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -368,6 +368,9 @@ typedef struct CPUArchState {
         uint64_t tcr2_el[3];
         uint64_t vtcr_el2; /* Virtualization Translation Control.  */
         uint64_t vstcr_el2; /* Secure Virtualization Translation Control. */
+        uint64_t pir_el[4]; /* PIRE0_EL1, PIR_EL1, PIR_EL2, PIR_EL3 */
+        uint64_t pire0_el2;
+        uint64_t s2pir_el2;
         uint32_t c2_data; /* MPU data cacheable bits.  */
         uint32_t c2_insn; /* MPU instruction cacheable bits.  */
         union { /* MMU domain access control register
@@ -1720,6 +1723,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_ENTP2             (1ULL << 41)
 #define SCR_TCR2EN            (1ULL << 43)
 #define SCR_SCTLR2EN          (1ULL << 44)
+#define SCR_PIEN              (1ULL << 45)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_NSE               (1ULL << 62)
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 30e29fd3153..9bca1b8eae5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -641,6 +641,10 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_sctlr2, cpu)) {
                 env->cp15.scr_el3 |= SCR_SCTLR2EN;
             }
+            if (cpu_isar_feature(aa64_s1pie, cpu) ||
+                cpu_isar_feature(aa64_s2pie, cpu)) {
+                env->cp15.scr_el3 |= SCR_PIEN;
+            }
         }
 
         if (target_el == 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c9ebdf144e3..20a189ef4f7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -770,6 +770,10 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_sctlr2, cpu)) {
             valid_mask |= SCR_SCTLR2EN;
         }
+        if (cpu_isar_feature(aa64_s1pie, cpu) ||
+            cpu_isar_feature(aa64_s2pie, cpu)) {
+            valid_mask |= SCR_PIEN;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -5941,6 +5945,64 @@ static const ARMCPRegInfo tcr2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.tcr2_el[2]) },
 };
 
+static CPAccessResult pien_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
+{
+    if (arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_PIEN)
+        && arm_current_el(env) < 3) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult pien_el1_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    CPAccessResult ret = access_tvm_trvm(env, ri, isread);
+    if (ret == CP_ACCESS_OK) {
+        ret = pien_access(env, ri, isread);
+    }
+    return ret;
+}
+
+static const ARMCPRegInfo s1pie_reginfo[] = {
+    { .name = "PIR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 10, .crm = 2,
+      .access = PL1_RW, .accessfn = pien_el1_access,
+      .fgt = FGT_NPIR_EL1, .nv2_redirect_offset = 0x2a0 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 10, 2, 3),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 10, 2, 3),
+      .fieldoffset = offsetof(CPUARMState, cp15.pir_el[1]) },
+    { .name = "PIR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 10, .crm = 2,
+      .access = PL2_RW, .accessfn = pien_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.pir_el[2]) },
+    { .name = "PIR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 3, .crn = 10, .crm = 2,
+      .access = PL3_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.pir_el[3]) },
+    { .name = "PIRE0_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 2, .crn = 10, .crm = 2,
+      .access = PL1_RW, .accessfn = pien_el1_access,
+      .fgt = FGT_NPIRE0_EL1, .nv2_redirect_offset = 0x290 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 10, 2, 2),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 10, 2, 2),
+      .fieldoffset = offsetof(CPUARMState, cp15.pir_el[0]) },
+    { .name = "PIRE0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 2, .crn = 10, .crm = 2,
+      .access = PL2_RW, .accessfn = pien_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.pire0_el2) },
+};
+
+static const ARMCPRegInfo s2pie_reginfo[] = {
+    { .name = "S2PIR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 5, .crn = 10, .crm = 2,
+      .access = PL2_RW, .accessfn = pien_access,
+      .nv2_redirect_offset = 0x2b0,
+      .fieldoffset = offsetof(CPUARMState, cp15.s2pir_el2) },
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7173,6 +7235,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, tcr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_s1pie, cpu)) {
+        define_arm_cp_regs(cpu, s1pie_reginfo);
+    }
+    if (cpu_isar_feature(aa64_s2pie, cpu)) {
+        define_arm_cp_regs(cpu, s2pie_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
-- 
2.43.0


