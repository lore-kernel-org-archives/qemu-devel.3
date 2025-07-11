Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D86C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaERd-0007VS-RM; Fri, 11 Jul 2025 10:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uaEQv-00066I-HK
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:09:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uaEQt-0005un-ED
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:09:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so1607278b3a.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752242938; x=1752847738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7yd7Tc+1VK42fWEYbjmC27WF1C1rh0fpZ4Vk8hpQpU=;
 b=YiIQZl45mDDmarhoyhCO1G5Id833hQCIUhcyqVIBYKVGbwmbz+ZwF55TBUHe+567D5
 Oa3bhABw5a2f5owyRKgU7Yn69rEbRkuJ2pNj2SlLxfmPXqVfdb5+OcuUMUM4qzf4fTc4
 iZQCt/E8rQvqJHwUWuQKgWvfS5RWjdw3aivjqcS61irotuA6qEOtWrSdxmxycmIyTfBB
 m/mbHmFc6NDFcgPpm4ETLzbBWODOr4eSRJAOlO80lFdG/ZbVroAtoOnVgzo+fBX4zLTr
 +6/pb5uCZ5mWpTNSX3bA0B7m1mW1qHzJcB/SaUa3FFFeBBWDdkukjQDqwMFIWr47NwRT
 KPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752242938; x=1752847738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7yd7Tc+1VK42fWEYbjmC27WF1C1rh0fpZ4Vk8hpQpU=;
 b=D9jvCuvWLDJ85gt4vmiohs5RrKOuOc+eqH7VQQox4lpAkMz9oLHsxhbLiyeeMJCMZU
 19TizgE/wR0bnECoqnDjp9NRXEjzuDBGot2HrhdfM4L6xtLjW7Z1azE/jMGSS3G2ik7z
 sXxmVMMawh48vXTsuoUUgBerxv4Knwt6G23r7xdnbfIgqLo1zUhXhDlJ0LN3MuYR9akt
 FNGADaMzUA4DRwmjSDPPEIUIhQMWAxBTUqyuuP16zqKi0eWQwdnLyvSxRL/UC2E4deXQ
 2uVcuRXYToamDKswF6M8facjXuF6F4GwPvryR2zM9kNmCV1AtdsXKWlGoufULudqJPXJ
 jgzw==
X-Gm-Message-State: AOJu0Yy5ywf19LMs4j9CZSC2kRI691YgoXD2qvRkAeWxnX8JUPy4THg2
 o72xwko9ezTGppKhgXtLZ/IrzirWh1hYtGKROA/rp1F1FvFw6X3/JPTMlBEnM1eZwSc=
X-Gm-Gg: ASbGncvm0AnwmBzc7Xa6lzpuOPsrLBoK5wqXx69Gz3TdvA3tJXSfGlzZTwDsSL0Cp5L
 x/UiuQRrUPGXfB992yuX8Qh5Wk1gARdKE7ouX1jdkc1YDEC5lor7KwNUHL80m8+zw3bdGNXXA9N
 /VSmG4eemjDwidASWriCa+sh+Mxtqr/hmm5NoEPJSxR+hN3bQIj3KNjYIgYbxarc32lztF6OKWI
 hmGuYVoREw5OGVNURRMXnpreVzxftB+DqYcjn/xYzgc7YDPt0iq2u5CrdU5CN8ir3Q6ntko3kqJ
 lUBiIH+guDeRDCdRG1WlfHWlWd/n7HgIi17ljDGTiOpAZG6Vgti6toPiypqu1Mi8PyzC8jz/ypj
 nLHYQ+3s9hE23simIY/zgvf2N1Pcjw6LtlZTaYISAtFVz3erFwZvM9+BC6A==
X-Google-Smtp-Source: AGHT+IHDwMLRSM5c8lizMuG188t5W9PQxS5+htRRb/P21eXY09lx849/+4tE49seigPz9eIm29dkBQ==
X-Received: by 2002:a05:6300:6304:b0:232:3141:5879 with SMTP id
 adf61e73a8af0-23231415a6emr629857637.33.1752242937568; 
 Fri, 11 Jul 2025 07:08:57 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9dd5d3esm5702280b3a.4.2025.07.11.07.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:08:57 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v7 3/6] target/arm: Add FEAT_SCTLR2
Date: Fri, 11 Jul 2025 14:08:25 +0000
Message-Id: <20250711140828.1714666-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711140828.1714666-1-gustavo.romero@linaro.org>
References: <20250711140828.1714666-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x430.google.com
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

Add FEAT_SCTLR2, which introduces the SCTLR2_EL1, SCTLR2_EL2, and
SCTLR2_EL3 registers. These registers are extensions of the SCTLR_ELx
ones.

Because the bits in these registers depend on other CPU features, and
only FEAT_MEC is supported at the moment, this commit only implements
the EMEC bits in CTLR2_EL2 and SCTLR2_EL3.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu-features.h     |  5 +++
 target/arm/cpu.c              |  3 ++
 target/arm/cpu.h              | 15 +++++++
 target/arm/helper.c           | 80 +++++++++++++++++++++++++++++++++++
 target/arm/internals.h        |  1 +
 target/arm/tcg/cpu64.c        |  5 ++-
 7 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 890dc6fee2..66043b0747 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -121,6 +121,7 @@ the following architecture extensions:
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
+- FEAT_SCTLR2 (Extension to SCTLR_ELx)
 - FEAT_SEL2 (Secure EL2)
 - FEAT_SHA1 (SHA1 instructions)
 - FEAT_SHA256 (SHA256 instructions)
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 72b6fd9b27..a5fc2ca572 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -904,6 +904,11 @@ static inline bool isar_feature_aa64_nv2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, NV) >= 2;
 }
 
+static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8da8d13e4c..2a89dc90c0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -645,6 +645,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_fgt, cpu)) {
                 env->cp15.scr_el3 |= SCR_FGTEN;
             }
+            if (cpu_isar_feature(aa64_sctlr2, cpu)) {
+                env->cp15.scr_el3 |= SCR_SCTLR2EN;
+            }
             if (cpu_isar_feature(aa64_mec, cpu)) {
                 env->cp15.scr_el3 |= SCR_MECEN;
             }
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e3975e687e..af83a16b7e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -337,6 +337,7 @@ typedef struct CPUArchState {
             };
             uint64_t sctlr_el[4];
         };
+        uint64_t sctlr2_el[4]; /* Extension to System control register. */
         uint64_t vsctlr; /* Virtualization System control register. */
         uint64_t cpacr_el1; /* Architectural feature access control register */
         uint64_t cptr_el[4];  /* ARMv8 feature trap registers */
@@ -1429,6 +1430,19 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_SPINTMASK (1ULL << 62) /* FEAT_NMI */
 #define SCTLR_TIDCP   (1ULL << 63) /* FEAT_TIDCP1 */
 
+#define SCTLR2_EMEC (1ULL << 1) /* FEAT_MEC */
+#define SCTLR2_NMEA (1ULL << 2) /* FEAT_DoubleFault2 */
+#define SCTLR2_ENADERR (1ULL << 3) /* FEAT_ADERR */
+#define SCTLR2_ENANERR (1ULL << 4) /* FEAT_ANERR */
+#define SCTLR2_EASE (1ULL << 5) /* FEAT_DoubleFault2 */
+#define SCTLR2_ENIDCP128 (1ULL << 6) /* FEAT_SYSREG128 */
+#define SCTLR2_ENPACM (1ULL << 7) /* FEAT_PAuth_LR */
+#define SCTLR2_ENPACM0 (1ULL << 8 /* FEAT_PAuth_LR */
+#define SCTLR2_CPTA (1ULL << 9) /* FEAT_CPA2 */
+#define SCTLR2_CPTA0 (1ULL << 10) /* FEAT_CPA2 */
+#define SCTLR2_CPTM (1ULL << 11) /* FEAT_CPA2 */
+#define SCTLR2_CPTM0 (1ULL << 12) /* FEAT_CAP2 */
+
 #define CPSR_M (0x1fU)
 #define CPSR_T (1U << 5)
 #define CPSR_F (1U << 6)
@@ -1721,6 +1735,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_HXEN              (1ULL << 38)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
+#define SCR_SCTLR2EN          (1ULL << 44)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bb974647ba..6c32bfcae5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4513,6 +4513,8 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
     static const struct E2HAlias aliases[] = {
         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
           "SCTLR", "SCTLR_EL2", "SCTLR_EL12" },
+        { K(3, 0,  1, 0, 3), K(3, 4,  1, 0, 3), K(3, 5, 1, 0, 3),
+          "SCTLR2_EL1", "SCTLR2_EL2", "SCTLR2_EL12", isar_feature_aa64_sctlr2 },
         { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
           "CPACR", "CPTR_EL2", "CPACR_EL12" },
         { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
@@ -6060,6 +6062,80 @@ static const ARMCPRegInfo actlr2_hactlr2_reginfo[] = {
       .resetvalue = 0 },
 };
 
+static CPAccessResult sctlr2_el2_access(CPUARMState *env,
+                                        const ARMCPRegInfo *ri,
+                                        bool isread)
+{
+    if (arm_current_el(env) < 3
+        && arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_SCTLR2EN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult sctlr2_el1_access(CPUARMState *env,
+                                        const ARMCPRegInfo *ri,
+                                        bool isread)
+{
+    CPAccessResult ret = access_tvm_trvm(env, ri, isread);
+    if (ret != CP_ACCESS_OK) {
+        return ret;
+    }
+    if (arm_current_el(env) < 2 && !(arm_hcrx_el2_eff(env) & HCRX_SCTLR2EN)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return sctlr2_el2_access(env, ri, isread);
+}
+
+static void sctlr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    /* This register does not control any feature yet. */
+}
+
+static void sctlr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    uint64_t valid_mask = 0;
+
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= SCTLR2_EMEC;
+    }
+    value &= valid_mask;
+    raw_write(env, ri, value);
+}
+
+static void sctlr2_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    uint64_t valid_mask = 0;
+
+    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+        valid_mask |= SCTLR2_EMEC;
+    }
+    value &= valid_mask;
+    raw_write(env, ri, value);
+}
+
+static const ARMCPRegInfo sctlr2_reginfo[] = {
+    { .name = "SCTLR2_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .opc2 = 3, .crn = 1, .crm = 0,
+      .access = PL1_RW, .accessfn = sctlr2_el1_access,
+      .writefn = sctlr2_el1_write, .fgt = FGT_SCTLR_EL1,
+      .nv2_redirect_offset = 0x278 | NV2_REDIR_NV1,
+      .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[1]) },
+    { .name = "SCTLR2_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 1, .crm = 0,
+      .access = PL2_RW, .accessfn = sctlr2_el2_access,
+      .writefn = sctlr2_el2_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[2]) },
+    { .name = "SCTLR2_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 3, .crn = 1, .crm = 0,
+      .access = PL3_RW, .writefn = sctlr2_el3_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.sctlr2_el[3]) },
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7293,6 +7369,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, mec_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_sctlr2, cpu)) {
+        define_arm_cp_regs(cpu, sctlr2_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 43cddd95b4..d60d235b19 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -232,6 +232,7 @@ FIELD(VTCR, SL2, 33, 1)
 #define HCRX_CMOW     (1ULL << 9)
 #define HCRX_MCE2     (1ULL << 10)
 #define HCRX_MSCEN    (1ULL << 11)
+#define HCRX_SCTLR2EN (1ULL << 15)
 
 #define HPFAR_NS      (1ULL << 63)
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 35cddbafa4..f4efff03a5 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1247,7 +1247,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
     SET_IDREG(isar, ID_AA64MMFR2, t);
 
-    FIELD_DP64_IDREG(isar, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    t = GET_IDREG(isar, ID_AA64MMFR3);
+    t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    SET_IDREG(isar, ID_AA64MMFR3, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
-- 
2.34.1


