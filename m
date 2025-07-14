Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D82C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMfK-0002zw-BL; Mon, 14 Jul 2025 13:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubLZw-00036K-Oz
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:58:59 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubLZs-0007nv-NI
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:58:56 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7490702fc7cso2728126b3a.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752508730; x=1753113530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkWKrmPvGxfDEFpWqVjHc4jDew6BiM/rgpCdg4haG3g=;
 b=hQmNG5+h6hcMxfB7nPhkK6WlT/4pHPVHWh+IK4uNLIqvcAnEPUQJieS349fbN0EjlY
 p87UaEnA3IOq/BS1eYWn5IjbtEOdPO6pgoHsf7bidD7OVRQlCIuzDLvhboVjfA4WauD9
 6qmgmDFyYDDIwuz9nYxrREvc3lZnsDGZoCOPL3otZh6tzB7R8Dgc9lCN+7C7mSWZbdPd
 iyhBWQOpXNc2RVCA9FPkLzAt7LZ89AFpPrjQzEfcV5OcKR/PdpWC37bDaNBqcRomYZXh
 4OIK+N6ZfWVPa3eFMPDfjnVhVEga0z3f1ihYUV0YOzuJ2hMAOq3Sv7hu3sORLsgH+Cbe
 wF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752508730; x=1753113530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IkWKrmPvGxfDEFpWqVjHc4jDew6BiM/rgpCdg4haG3g=;
 b=fik4p+xWWRzya5ui8sa0QqQFTWWUOr+JDFCl5W1UwZWdDhFc0fCGqnNOAonXDKc4Uj
 CBs5e4VZPBjDRxR4zxY7khr+k+5XZMCz7KxXpnNhT9fdrVsNpRy85XFLU1qAKuGl8Ztx
 TeCftd9LnyoxtySvwsPmiaDPi/NrBwa964K3V7JJDTmDIZfypSioyQzPam3YJBebOOh9
 G4P+dkbj+Ls/QYx5GU0UTZO1G5Vf4yB9mhH0Yrc47ndZrG7fNjLOYIo0g5Dd2N+FwIkd
 Z2p5GBKC5aq42YgZPC7X+LrXSbZjqvtwgSIRKlfpT3tq8XyXUWuJ1FPRVryNe6OdDPKl
 yFpQ==
X-Gm-Message-State: AOJu0YyustHO6EKwtD9bJttXNk30b1mxNJn6Ix5MGc0zq5odHIzfdt+M
 CfwlxIVPGiwLmGbJ4R3pIrSb7RcAZgtMWHJ/hxWU95zJUSv+WpRHFU8cheJYTjkX5fIs8mMc8uO
 juplHDQ0=
X-Gm-Gg: ASbGncsHCCibzXxj51L873akLgb6pQSX/+nmyX4bv15wfDLxSBgpwXdTLADUrPAXyQU
 xd3bp0NnF9OqYAbkuyFDj17HPAZlztRcp4O9gEMdf+jpsTTB08J3wlWGs73I14KlfCLSNwg9PdM
 9ID5d0nQqUOGemZAz75cPZH9rgJGC5ciZu1pE5QO53I8aQGQkz536IyOvwZ+OHGOQsDdj66j4A/
 +P3FLBKZL2sa9CXW5420fSYOpV9KiSsl6byKHP/bULB7xDWSyfttGW+z4pg0zJ1t9HuselI45ok
 CrxctbGFyGLdKZe9QUMZVkFC7fxnQqY9kxyyYNa6RMucIcK0FGVkU/zojGftLGnUiqsoRlObvoY
 nJQ6T1cfe4KCrWx+H2nieIBhmGSi+5a1ADOj2BdMjMDhG3vsuJlU7
X-Google-Smtp-Source: AGHT+IHfmBQlKD4ALYecIjfAcPpmaBP9JhC0yN54QvKl6q3SkuX8unuLX17/AxwPnc/WGamMjplJJg==
X-Received: by 2002:a05:6a00:b42:b0:73d:fefb:325 with SMTP id
 d2e1a72fcca58-74f1beebda4mr15825909b3a.5.1752508730066; 
 Mon, 14 Jul 2025 08:58:50 -0700 (PDT)
Received: from stoup.. ([172.56.179.167]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f8f24dsm10265805b3a.156.2025.07.14.08.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 08:58:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org, pierrick.bouvier@linaro.org
Subject: [PATCH v8 3/4] target/arm: Implement FEAT_MEC registers
Date: Mon, 14 Jul 2025 09:58:34 -0600
Message-ID: <20250714155836.1514748-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714155836.1514748-1-richard.henderson@linaro.org>
References: <20250714155836.1514748-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add all FEAT_MEC registers.  Enable access to the registers via the
SCTLR2 and TCR2 control bits.  Add the two new cache management
instructions, which are nops in QEMU because we do not model caches.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20250711140828.1714666-3-gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Squash 3 patches to add all registers at once.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h |   5 ++
 target/arm/cpu.h          |  10 ++++
 target/arm/internals.h    |   3 ++
 target/arm/cpu.c          |   3 ++
 target/arm/helper.c       | 103 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 8ec8c3feb3..9579d93cec 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -914,6 +914,11 @@ static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
 }
 
+static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 4 &&
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0e247f50c7..5156120b50 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -578,6 +578,15 @@ typedef struct CPUArchState {
 
         /* NV2 register */
         uint64_t vncr_el2;
+
+        /* MEC registers */
+        uint64_t mecid_p0_el2;
+        uint64_t mecid_a0_el2;
+        uint64_t mecid_p1_el2;
+        uint64_t mecid_a1_el2;
+        uint64_t mecid_rl_a_el3;
+        uint64_t vmecid_p_el2;
+        uint64_t vmecid_a_el2;
     } cp15;
 
     struct {
@@ -1730,6 +1739,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_TCR2EN            (1ULL << 43)
 #define SCR_SCTLR2EN          (1ULL << 44)
 #define SCR_GPF               (1ULL << 48)
+#define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
 
 /* Return the current FPSCR value.  */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index b4cd03df69..6c1112e641 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -2007,4 +2007,7 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
 bool arm_pan_enabled(CPUARMState *env);
 
+/* Used in FEAT_MEC to set the MECIDWidthm1 field in the MECIDR_EL2 register. */
+#define MECID_WIDTH 16
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e709ca74da..34638ea100 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -651,6 +651,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_sctlr2, cpu)) {
                 env->cp15.scr_el3 |= SCR_SCTLR2EN;
             }
+            if (cpu_isar_feature(aa64_mec, cpu)) {
+                env->cp15.scr_el3 |= SCR_MECEN;
+            }
         }
 
         if (target_el == 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1e0e747146..dd7beba079 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5207,6 +5207,93 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .resetfn = arm_cp_reset_ignore },
 };
 
+static CPAccessResult mecid_access(CPUARMState *env,
+                                   const ARMCPRegInfo *ri, bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el == 2) {
+        if (arm_security_space(env) != ARMSS_Realm) {
+	    return CP_ACCESS_UNDEFINED;
+	}
+
+        if (!(env->cp15.scr_el3 & SCR_MECEN)) {
+            return CP_ACCESS_TRAP_EL3;
+        }
+    }
+
+    return CP_ACCESS_OK;
+}
+
+static void mecid_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    value = extract64(value, 0, MECID_WIDTH);
+    raw_write(env, ri, value);
+}
+
+static CPAccessResult cipae_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    switch (arm_security_space(env)) {
+    case ARMSS_Root:  /* EL3 */
+    case ARMSS_Realm: /* Realm EL2 */
+        return CP_ACCESS_OK;
+    default:
+        return CP_ACCESS_UNDEFINED;
+    }
+}
+
+static const ARMCPRegInfo mec_reginfo[] = {
+    { .name = "MECIDR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 7, .crn = 10, .crm = 8,
+      .access = PL2_R, .type = ARM_CP_CONST, .resetvalue = MECID_WIDTH - 1 },
+    { .name = "MECID_P0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p0_el2) },
+    { .name = "MECID_A0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a0_el2) },
+    { .name = "MECID_P1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 2, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p1_el2) },
+    { .name = "MECID_A1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a1_el2) },
+    { .name = "MECID_RL_A_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 1, .crn = 10, .crm = 10,
+      .access = PL3_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_rl_a_el3) },
+    { .name = "VMECID_P_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 9,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_p_el2) },
+    { .name = "VMECID_A_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 9,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_a_el2) },
+    { .name = "DC_CIPAE", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 0,
+      .access = PL2_W, .accessfn = cipae_access, .type = ARM_CP_NOP },
+};
+
+static const ARMCPRegInfo mec_mte_reginfo[] = {
+    { .name = "DC_CIGDPAE", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 7,
+      .access = PL2_W, .accessfn = cipae_access, .type = ARM_CP_NOP },
+};
+
 #ifndef CONFIG_USER_ONLY
 /*
  * We don't know until after realize whether there's a GICv3
@@ -6045,6 +6132,9 @@ static void sctlr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= SCTLR2_EMEC;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6054,6 +6144,9 @@ static void sctlr2_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= SCTLR2_EMEC;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6114,6 +6207,9 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -7369,6 +7465,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, tcr2_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_mec, cpu)) {
+        define_arm_cp_regs(cpu, mec_reginfo);
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            define_arm_cp_regs(cpu, mec_mte_reginfo);
+        }
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
-- 
2.43.0


