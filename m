Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1299CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ldE-000613-05; Mon, 22 Sep 2025 14:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lcF-0005An-8s
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:23 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lc0-0004Rq-SJ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:22 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-77f22902b46so1875214b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567007; x=1759171807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZG8tt3GkG0LL7r1QL+TX6+QxMb7w4gNUJqKBL4V2zQ=;
 b=JTJhs/blFJ3pIZja4Wn82cuuCLyfMfVWW0dal1hKgrjPMXpu2aqs9inTskUgALnsp0
 rL6/yjZphpitrd1pjC98lfTxOeH4EREymI0pHCWkiOygW6m9rPs9LDeTj5aZecFO7VuO
 XBSfr4VDFuYMHdiuogsMkQNdqdFLLpK5NYzGVVB+EzKeX1FcVTZ7SxdVohQ+S9pu3Tmk
 IkEFoaB+bE5Q+XRcli+DBX4lWCClH22Gjcq+FYTi9deHu82GgMa+HzZehPz0nwB84Umt
 C2sD15cPlR0zkOSmAr2hcyrcBfn7iUcWP+FEBqB/zHOENBtfyZ4NRQ9/NcwPdeOjrNpo
 6OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567007; x=1759171807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZG8tt3GkG0LL7r1QL+TX6+QxMb7w4gNUJqKBL4V2zQ=;
 b=J6jxCeK3FttJMh5XANMZ2GY7XTumTV9Qs1+/uvUkobyEaRWSQRrARppHwPYzWvaM4t
 Bl1mQdV6Dts6yHaGDn5Hbt680/PSROb0BD0Qmd5X5sJLGnTu/ujVQoepvFSOD5YQ+mwm
 kxbnKf4HuZY4f/N1JMgsuuA7mA6XTfBzZkzB6Xl/U7H1QC5YWGJtGhMJcNQNzkbL7bnF
 /NLP6DjOvutgynefap3+3401KZrqSwMEMFei1ZjvbB0X0k2PC3G959HN0iu5YKwl4Cr6
 EwrFAf/UF2N1iwcUs6fpwXMR1BReLIM8txYYW19W2XR53sCVeVlq4oF+GvVhO3L9BNWq
 mXrA==
X-Gm-Message-State: AOJu0YyxZ9SYTWT5yFxbS9qnPAol+KSALmpUwQLWnbAmcfqzDMeZUUbo
 yxd+hRKLQAv0gA1KsUiuw4WdQ1/1iKfTRsals4bMpjsBNfTk/pAMRpkIKzCT9luRktu4N3T1gjX
 QLo2n
X-Gm-Gg: ASbGncsdFQ/OMZk5qw/DiyoVyRjEasnDC7cL2c6RmcZY+pBBSoTRt5Ha16sTOEZpylK
 cgt+hUc20Qu0q1jPwJNbasQUTsTzDkWetJxsBtwwtZS8wOHTJLnXBlgLPoN7gN2aw8kd8jtGc4N
 Qpk/rJv6BlHbyhY7FpWryWiYsoUM/V3hVfHr1+E9qZz+r8s+rybMEd3P9Lu4KZQUJW5FBmJ7139
 DLhhz7qkNOO9HHkvrdTjNK6BiF1TZtq4b/h8XTi2jOFfGNflQQq1YkEO5ASqbwzIpwXoP1EF1I7
 9SGR4H0r+HZVJKFYhI7A2WEzhHH3zxg7V7Gnao1eW/BSesDqlTm78VcmpZ5/up9Qi4H3YrENsvT
 ZUm2jvC09qxjDvZQaCEk0hXDz6GQD
X-Google-Smtp-Source: AGHT+IGG1LGiVwHMqg1F6Biy18toEegJr3QKZIMhN4qM+K6EC9EGKetv8/DNLK339O/VGEc9hjfZBQ==
X-Received: by 2002:a05:6a20:7d8b:b0:262:c083:bb45 with SMTP id
 adf61e73a8af0-2d0160a49bcmr66675637.37.1758567007148; 
 Mon, 22 Sep 2025 11:50:07 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:50:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 34/76] target/arm: Add GCS cpregs
Date: Mon, 22 Sep 2025 11:48:42 -0700
Message-ID: <20250922184924.2754205-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add isar_feature_aa64_gcs.
Enable SCR_GCSEN in scr_write.
Enable HCRX_GCSEN in hcrx_write.
Default HCRX_GCSEN on if EL2 disabled.
Add the GCSCR* and GCSPR* registers.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h       |  2 +
 target/arm/cpu-features.h |  5 +++
 target/arm/cpu.h          | 12 +++++
 target/arm/internals.h    |  3 ++
 target/arm/cpregs-gcs.c   | 95 +++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c          |  3 ++
 target/arm/helper.c       | 10 +++++
 target/arm/meson.build    |  2 +
 8 files changed, 132 insertions(+)
 create mode 100644 target/arm/cpregs-gcs.c

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index f48c4df30f..bd2121a336 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -779,6 +779,8 @@ typedef enum FGTBit {
     DO_BIT(HFGRTR, VBAR_EL1),
     DO_BIT(HFGRTR, ICC_IGRPENN_EL1),
     DO_BIT(HFGRTR, ERRIDR_EL1),
+    DO_REV_BIT(HFGRTR, NGCS_EL0),
+    DO_REV_BIT(HFGRTR, NGCS_EL1),
     DO_REV_BIT(HFGRTR, NSMPRI_EL1),
     DO_REV_BIT(HFGRTR, NTPIDR2_EL0),
     DO_REV_BIT(HFGRTR, NPIRE0_EL1),
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 30226814bb..4a35cf6b69 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -729,6 +729,11 @@ static inline bool isar_feature_aa64_nmi(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, NMI) != 0;
 }
 
+static inline bool isar_feature_aa64_gcs(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, GCS) != 0;
+}
+
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
 {
     return FIELD_SEX64_IDREG(id, ID_AA64MMFR0, TGRAN4) >= 1;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d5a45e9b43..14a08d2f99 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -580,6 +580,9 @@ typedef struct CPUArchState {
 
         /* NV2 register */
         uint64_t vncr_el2;
+
+        uint64_t gcscr_el[4];   /* GCSCRE0_EL1, GCSCR_EL[123] */
+        uint64_t gcspr_el[4];   /* GCSPR_EL[0123] */
     } cp15;
 
     struct {
@@ -1717,6 +1720,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_ENAS0             (1ULL << 36)
 #define SCR_ADEN              (1ULL << 37)
 #define SCR_HXEN              (1ULL << 38)
+#define SCR_GCSEN             (1ULL << 39)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
 #define SCR_TCR2EN            (1ULL << 43)
@@ -1725,6 +1729,14 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_NSE               (1ULL << 62)
 
+/* GCSCR_ELx fields */
+#define GCSCR_PCRSEL    (1ULL << 0)
+#define GCSCR_RVCHKEN   (1ULL << 5)
+#define GCSCR_EXLOCKEN  (1ULL << 6)
+#define GCSCR_PUSHMEN   (1ULL << 8)
+#define GCSCR_STREN     (1ULL << 9)
+#define GCSCRE0_NTR     (1ULL << 10)
+
 /* Return the current FPSCR value.  */
 uint32_t vfp_get_fpscr(CPUARMState *env);
 void vfp_set_fpscr(CPUARMState *env, uint32_t val);
diff --git a/target/arm/internals.h b/target/arm/internals.h
index dc6bf3548e..f72e95a5ba 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -251,6 +251,7 @@ FIELD(VSTCR, SA, 30, 1)
 #define HCRX_MSCEN    (1ULL << 11)
 #define HCRX_TCR2EN   (1ULL << 14)
 #define HCRX_SCTLR2EN (1ULL << 15)
+#define HCRX_GCSEN    (1ULL << 22)
 
 #define HPFAR_NS      (1ULL << 63)
 
@@ -1778,6 +1779,8 @@ void define_tlb_insn_regs(ARMCPU *cpu);
 void define_at_insn_regs(ARMCPU *cpu);
 /* Add the cpreg definitions for PM cpregs */
 void define_pm_cpregs(ARMCPU *cpu);
+/* Add the cpreg definitions for GCS cpregs */
+void define_gcs_cpregs(ARMCPU *cpu);
 
 /* Effective value of MDCR_EL2 */
 static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
new file mode 100644
index 0000000000..1ff041811d
--- /dev/null
+++ b/target/arm/cpregs-gcs.c
@@ -0,0 +1,95 @@
+/*
+ * QEMU ARM CP Register GCS regiters and instructions
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "exec/icount.h"
+#include "hw/irq.h"
+#include "cpu.h"
+#include "cpu-features.h"
+#include "cpregs.h"
+#include "internals.h"
+
+
+static CPAccessResult access_gcs(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    if (arm_current_el(env) < 3
+        && arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_GCSEN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_gcs_el0(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     bool isread)
+{
+    if (arm_current_el(env) == 0 && !(env->cp15.gcscr_el[0] & GCSCRE0_NTR)) {
+        return CP_ACCESS_TRAP_EL1;
+    }
+    return access_gcs(env, ri, isread);
+}
+
+static void gcspr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    /*
+     * Bits [2:0] are RES0, so we might as well clear them now,
+     * rather than upon each usage a-la GetCurrentGCSPointer.
+     */
+    raw_write(env, ri, value & ~7);
+}
+
+static const ARMCPRegInfo gcs_reginfo[] = {
+    { .name = "GCSCRE0_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 2,
+      .access = PL1_RW, .accessfn = access_gcs, .fgt = FGT_NGCS_EL0,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcscr_el[0]) },
+    { .name = "GCSCR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_gcs, .fgt = FGT_NGCS_EL1,
+      .nv2_redirect_offset = 0x8d0 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 5, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 5, 0),
+      .fieldoffset = offsetof(CPUARMState, cp15.gcscr_el[1]) },
+    { .name = "GCSCR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 5, .opc2 = 0,
+      .access = PL2_RW, .accessfn = access_gcs,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcscr_el[2]) },
+    { .name = "GCSCR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 5, .opc2 = 0,
+      .access = PL3_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcscr_el[3]) },
+
+    { .name = "GCSPR_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 2, .crm = 5, .opc2 = 1,
+      .access = PL0_R | PL1_W, .accessfn = access_gcs_el0,
+      .fgt = FGT_NGCS_EL0, .writefn = gcspr_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[0]) },
+    { .name = "GCSPR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_gcs,
+      .fgt = FGT_NGCS_EL1, .writefn = gcspr_write,
+      .nv2_redirect_offset = 0x8c0 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 5, 1),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 5, 1),
+      .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[1]) },
+    { .name = "GCSPR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 5, .opc2 = 1,
+      .access = PL2_RW, .accessfn = access_gcs, .writefn = gcspr_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[2]) },
+    { .name = "GCSPR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 5, .opc2 = 1,
+      .access = PL3_RW, .writefn = gcspr_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[2]) },
+};
+
+void define_gcs_cpregs(ARMCPU *cpu)
+{
+    if (cpu_isar_feature(aa64_gcs, cpu)) {
+        define_arm_cp_regs(cpu, gcs_reginfo);
+    }
+}
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d4bc2e6a92..aab7250399 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -629,6 +629,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_fgt, cpu)) {
                 env->cp15.scr_el3 |= SCR_FGTEN;
             }
+            if (cpu_isar_feature(aa64_gcs, cpu)) {
+               env->cp15.scr_el3 |= SCR_GCSEN;
+            }
             if (cpu_isar_feature(aa64_tcr2, cpu)) {
                 env->cp15.scr_el3 |= SCR_TCR2EN;
             }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 65f38727d6..3b9e7a822e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -766,6 +766,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_ecv, cpu)) {
             valid_mask |= SCR_ECVEN;
         }
+        if (cpu_isar_feature(aa64_gcs, cpu)) {
+            valid_mask |= SCR_GCSEN;
+        }
         if (cpu_isar_feature(aa64_tcr2, cpu)) {
             valid_mask |= SCR_TCR2EN;
         }
@@ -3948,6 +3951,9 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_sctlr2, cpu)) {
         valid_mask |= HCRX_SCTLR2EN;
     }
+    if (cpu_isar_feature(aa64_gcs, cpu)) {
+        valid_mask |= HCRX_GCSEN;
+    }
 
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
@@ -4018,6 +4024,9 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
         if (cpu_isar_feature(aa64_sctlr2, cpu)) {
             hcrx |= HCRX_SCTLR2EN;
         }
+        if (cpu_isar_feature(aa64_gcs, cpu)) {
+            hcrx |= HCRX_GCSEN;
+        }
         return hcrx;
     }
     if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_HXEN)) {
@@ -7247,6 +7256,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
 
     define_pm_cpregs(cpu);
+    define_gcs_cpregs(cpu);
 }
 
 /*
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 91630a1f72..8c82304fde 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -27,6 +27,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c',
 ))
 arm_user_ss.add(files(
+  'cpregs-gcs.c',
   'cpregs-pmu.c',
   'debug_helper.c',
   'helper.c',
@@ -42,6 +43,7 @@ arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
   'cortex-regs.c',
+  'cpregs-gcs.c',
   'cpregs-pmu.c',
   'debug_helper.c',
   'helper.c',
-- 
2.43.0


