Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694F9CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CrF-0000UD-IO; Fri, 10 Oct 2025 09:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqt-00089b-Rb
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:09 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpi-00044n-Ci
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:07 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso1830064f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101612; x=1760706412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CySS8o7/PAaqrW7b+4aD5vDzSAed8+ObrtbkMoyyDPs=;
 b=v2cDMDkZ4HGAEw6lsql74QXNP9jGAFo5uCv2MkV+0RSrIpw1nLq2I+PbW8ZpR+qIs6
 RyAE4ymGLVz9IzyMs9YA/l1EYGrWaCwMNVUZPCE6JXWAc8kkvw5Pc1ry6So+Knp0/xQy
 RaQLcLiuOMWLPtkhsYQSnGK1ntklxdixErI2WbyoDgULm3Y7Ng5NsX5EXvYuq+wy6NZB
 JYMN7/7GhwdpbQKv1zuZjSyg/n/j8hDK8voYPUydfK3z+GYVfyi6cmTfJCUry0x8Ou8f
 yEW3FoGVq6+ROUnwHZD7lLcbW5OEyl0lZt3d/7GV/x0zRSWjLsvff7F8FNWUQiYS7Ivj
 YMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101612; x=1760706412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CySS8o7/PAaqrW7b+4aD5vDzSAed8+ObrtbkMoyyDPs=;
 b=Ou6v0rBe+6xcNNT5nuRfFrqNfz6YvRKMDn/d40BnSX81ELfZC+CMVvYpiT5M25Hwkq
 oQpNC4NmC5bqyyS1NhgoB7dlKDmXsBPy8Z81B7MafGoTJEMwEWiMf/e3dpkWsoLVfA+u
 1Fpq4FMUioJuHUVnv+GAWC9C/+gFDvWMVaHk0h4tW1HyFnmQxmGlIagICLxGW1L/bmpn
 yhwztzzZG8ZB+jpqRY94QBvPzR0qFM3BGI/JPIDk9V3RuIqlm1viILXafcgrRwe1E6Sr
 IvKWyPDIzy3I3+0a7oqU1NyTtvxsjmXirlmvXOjonTAYwAjd1EeXsTVr6LJJn8FEfI0o
 2pJg==
X-Gm-Message-State: AOJu0YxPPtBthmWIbL4PT2HLpfZgyjMkx+01w90WNCUuKnQFJRAj/UFi
 i+Lwhd50lwpabcZ1Q6G86yGn5S1/tqF7RxuwFBgl45rGEdTsVVTR0N1N3dDWzOB+UDe6jsZSQDh
 PYM37
X-Gm-Gg: ASbGncvhoxludScVnGXgJOWmePqRSXNtNkCVD670g8JodYxMY3G/LJVANwE/FZN85+K
 ZBISJESYN7dyj0mznDHOigbnbeJAWtjhK2T49nLHyCJe+LkZsjMqjrMFRREW7KXzGWIuCM8Nmvp
 CcPnNdcSRJkREAJca2p7Nt8Z96noHscLyYXvsJE24CQKL2znm+Bxj3uDLNqX2M3vna9g+2g0wmG
 +vnkZY9bYe34nuqFBwSfOwTXfdReFbt6hL1klce3ru5BA2wrQI1SESZ5pTXLS13zHTEugu6JBmc
 8TPFJ7/KhfK9yM4Tu2m6xCtYJ+6TCCNuQgcl8+Dbu5TBPRqp03/jEHaLFI8K5k/htEeAHqsoAuj
 rtjrrZBwt6bmBRXC6olsGgnULJaNqp00deH+s4h/J69VNYAV6HB2OQ14hksKbUXg5BK1kRfKs
X-Google-Smtp-Source: AGHT+IEWiTmTEnltvJabHymR1vRNXpWLau+zQuwY0sywAxgQzW6jZoePEssnUrA3juQ8hu2xXR/fjA==
X-Received: by 2002:a5d:6a4c:0:b0:425:6fb5:2add with SMTP id
 ffacd0b85a97d-425829e7940mr7280489f8f.19.1760101611871; 
 Fri, 10 Oct 2025 06:06:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 75/76] target/arm: Implement FEAT_MEC registers
Date: Fri, 10 Oct 2025 14:05:26 +0100
Message-ID: <20251010130527.3921602-76-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Message-ID: <20250711140828.1714666-3-gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20251006001018.219756-3-gustavo.romero@linaro.org
[rth: Squash 3 patches to add all registers at once.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h |   5 ++
 target/arm/cpu.h          |  10 ++++
 target/arm/internals.h    |   3 ++
 target/arm/cpu.c          |   3 ++
 target/arm/helper.c       | 108 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 0f0a112c213..37f1eca3af6 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1364,6 +1364,11 @@ static inline bool isar_feature_aa64_s2pie(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S2PIE) != 0;
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
index 91a851dac17..1d4e13320c3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -583,6 +583,15 @@ typedef struct CPUArchState {
 
         uint64_t gcscr_el[4];   /* GCSCRE0_EL1, GCSCR_EL[123] */
         uint64_t gcspr_el[4];   /* GCSPR_EL[0123] */
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
@@ -1728,6 +1737,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_SCTLR2EN          (1ULL << 44)
 #define SCR_PIEN              (1ULL << 45)
 #define SCR_GPF               (1ULL << 48)
+#define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
 
 /* GCSCR_ELx fields */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2a85ab762d5..f539bbe58e1 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1903,4 +1903,7 @@ void cpsr_write_from_spsr_elx(CPUARMState *env, uint32_t val);
 /* Compare uint64_t for qsort and bsearch. */
 int compare_u64(const void *a, const void *b);
 
+/* Used in FEAT_MEC to set the MECIDWidthm1 field in the MECIDR_EL2 register. */
+#define MECID_WIDTH 16
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 11e7c10cef5..3b556f1404e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -652,6 +652,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
                 cpu_isar_feature(aa64_s2pie, cpu)) {
                 env->cp15.scr_el3 |= SCR_PIEN;
             }
+            if (cpu_isar_feature(aa64_mec, cpu)) {
+                env->cp15.scr_el3 |= SCR_MECEN;
+            }
         }
 
         if (target_el == 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0077788e1e8..167f2909b3f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -779,6 +779,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             cpu_isar_feature(aa64_s2pie, cpu)) {
             valid_mask |= SCR_PIEN;
         }
+        if (cpu_isar_feature(aa64_mec, cpu)) {
+            valid_mask |= SCR_MECEN;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -5088,6 +5091,96 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .resetfn = arm_cp_reset_ignore },
 };
 
+static CPAccessResult mecid_access(CPUARMState *env,
+                                   const ARMCPRegInfo *ri, bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el == 2) {
+        if (arm_security_space(env) != ARMSS_Realm) {
+            return CP_ACCESS_UNDEFINED;
+        }
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
+      .access = PL2_R, .type = ARM_CP_CONST | ARM_CP_NV_NO_TRAP,
+      .resetvalue = MECID_WIDTH - 1 },
+    { .name = "MECID_P0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 8,
+      .access = PL2_RW, .type = ARM_CP_NV_NO_TRAP,
+      .accessfn = mecid_access, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p0_el2) },
+    { .name = "MECID_A0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 8,
+      .access = PL2_RW, .type = ARM_CP_NV_NO_TRAP,
+      .accessfn = mecid_access, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a0_el2) },
+    { .name = "MECID_P1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 2, .crn = 10, .crm = 8,
+      .access = PL2_RW, .type = ARM_CP_NV_NO_TRAP,
+      .accessfn = mecid_access, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p1_el2) },
+    { .name = "MECID_A1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 10, .crm = 8,
+      .access = PL2_RW, .type = ARM_CP_NV_NO_TRAP,
+      .accessfn = mecid_access, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a1_el2) },
+    { .name = "MECID_RL_A_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 1, .crn = 10, .crm = 10,
+      .access = PL3_RW, .accessfn = mecid_access,
+      .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_rl_a_el3) },
+    { .name = "VMECID_P_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 9,
+      .access = PL2_RW, .type = ARM_CP_NV_NO_TRAP,
+      .accessfn = mecid_access, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_p_el2) },
+    { .name = "VMECID_A_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 9,
+      .access = PL2_RW, .type = ARM_CP_NV_NO_TRAP,
+      .accessfn = mecid_access, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_a_el2) },
+    { .name = "DC_CIPAE", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 0,
+      .access = PL2_W, .type = ARM_CP_NOP | ARM_CP_NV_NO_TRAP,
+      .accessfn = cipae_access },
+};
+
+static const ARMCPRegInfo mec_mte_reginfo[] = {
+    { .name = "DC_CIGDPAE", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 7,
+      .access = PL2_W, .type = ARM_CP_NOP | ARM_CP_NV_NO_TRAP,
+      .accessfn = cipae_access },
+};
+
 #ifndef CONFIG_USER_ONLY
 /*
  * We don't know until after realize whether there's a GICv3
@@ -5930,6 +6023,9 @@ static void sctlr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= SCTLR2_EMEC;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -5939,6 +6035,9 @@ static void sctlr2_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= SCTLR2_EMEC;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6009,6 +6108,9 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_s1pie, cpu)) {
         valid_mask |= TCR2_PIE;
     }
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -7325,6 +7427,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_s2pie, cpu)) {
         define_arm_cp_regs(cpu, s2pie_reginfo);
     }
+    if (cpu_isar_feature(aa64_mec, cpu)) {
+        define_arm_cp_regs(cpu, mec_reginfo);
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            define_arm_cp_regs(cpu, mec_mte_reginfo);
+        }
+    }
 
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
-- 
2.43.0


