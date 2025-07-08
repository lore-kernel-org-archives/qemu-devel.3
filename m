Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD07C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFEq-0007DG-3b; Tue, 08 Jul 2025 16:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZDqx-0007Dn-5H
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:19:47 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZDqq-00087I-7f
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:19:41 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6fafdd322d3so60041966d6.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002356; x=1752607156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmhliCegNfZGHfr7J+p0jeoV/6BX3pT1C+80y0xkf40=;
 b=qJpaMapCABOibg96xQyPBepmRzEv9Wh1ApEcdV3xJdh6mi9lkWoQB0cmqY0lfogOQP
 8OeaqJCu6FJPGn8wcS2t7tTXsnIJC5luF3ckur+k0oj/I4E+Kut4aHbbuGTuhjnbfqq9
 NnovCXRoUmydcuepST7U3KsmBt69mRVRFE0mT1Hu6hxIREHE9mD/XU78d0HROGm2XcgN
 rRU35K1fdlw01WSDmmadDBVhxagAN3m9FnTaUJ7rFOXYleFf9pt6gKWzqyQtYOURdoeE
 1fgkn/evWOgx7XxPlAWpilUeAopd6qparHcrFpaN+YzlF9Bu2QYM6XQlgc1dfOauC+yG
 AbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002356; x=1752607156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmhliCegNfZGHfr7J+p0jeoV/6BX3pT1C+80y0xkf40=;
 b=VLpS/iNQhOnLPEr53F1I9BuRLoyi2rbF28v/rePo8M56/0SwAWoqmUpsdbhedW2nxQ
 IqG3NHGXHvPuh4wi8e8OQXe84ySLOc0w2RtY90kGwFtm9iVWiaqFcZr9rwMPHqOfiHiz
 RfI6ztixcTELEQsoLQdAGpKFzSXWOr5YhIle9VCJcZ7SZMFJz0QuffXBIhPRWFGgc2zV
 ta4eCQeDwFsrTuEcyeCuvfeM9S5qJ02PKvOMeMIXvvsYSLVQNofM/PQPIMd5P1VLsCIb
 7tsWeqXN2Yianr1/SLDGzMZKbBagL/asQnagR8sWDrf6aDJd0wogEUz6FduqQp7G0eSy
 LDGA==
X-Gm-Message-State: AOJu0Yy/m+LA35WF6SZJK1cHCgOOGG4j+9F+GUjdoY5nlTcUKN/p8T7d
 nv24y1IXdSJAR+QFckW6XQbJjpHs4BrGg76rMICh2275ToQdyS5RL8veNmzW2yyHCRCD7i13IET
 4ziCZ0Yw=
X-Gm-Gg: ASbGncsT5DNyYsfvp8VpQbwET89YRgE91aFit14+TS2kMpXlYNPDF0MIhzt6+fzDQpf
 OlwXTlgXQx3dFS+z+2xfSkaJf/t8P8+ObF/ictOYZFRn/hmFi/0+PLehq8Vi7h0Z/ceuSllKBgp
 GvhLO8HW/5IfRTOgBssC7dkep8ZKQeQ9ooox2rrsJOptiTixcivX3yiVlDyCYbt2RBstrBd/SVD
 NyE4S7Obo0eoqXvpbHc3WXFk2WwShQqa5lzbyXhEIL8yacWCZ/jqUx2p3rgqFv1oNPnMYXoDOXK
 mBFKyITBW0TaepSvFyqtcY0XANdU9obtqh+7qH0ySNGjZKIqELPFsFz0bt7A6bjF33I=
X-Google-Smtp-Source: AGHT+IE+65XyCIHt0mMmNZ9x/WwtrgdOw2UmcMAB1mrk69YadyhIoyQ74Jz4sZDUtqmP6YZOIZNBbg==
X-Received: by 2002:a05:6214:ca9:b0:6fd:d91:ba28 with SMTP id
 6a1803df08f44-702c8cd99bdmr252089966d6.41.1752002356234; 
 Tue, 08 Jul 2025 12:19:16 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702d638846asm56289096d6.22.2025.07.08.12.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 12:19:15 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [RFC PATCH-for-10.1 v3 2/5] target/arm: Add FEAT_MEC registers
Date: Tue,  8 Jul 2025 19:17:01 +0000
Message-Id: <20250708191704.1068604-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708191704.1068604-1-gustavo.romero@linaro.org>
References: <20250708191704.1068604-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qv1-xf2c.google.com
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

Add all FEAT_MEC registers.

To work properly, FEAT_MEC also depends on FEAT_SCTLR2 and FEAT_TCR2,
which are not implemented in this commit. The bits in SCTLR2 and TCR2
control which translation regimes use MECIDs, and determine which MECID
is selected.

FEAT_MEC also requires two new cache management instructions, not
included in this commit, that will be implemented in subsequent commits.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpu-features.h |  5 +++
 target/arm/cpu.h          | 11 ++++++
 target/arm/helper.c       | 70 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5876162428..552d8757b7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -594,6 +594,11 @@ static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, BC) != 0;
 }
 
+static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
+}
+
 static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, MOPS);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0f64c7b163..a93eebe077 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -576,6 +576,15 @@ typedef struct CPUArchState {
 
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
@@ -2424,6 +2433,8 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+#define MECID_WIDTH 16
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b3f0d6f17a..984406c945 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6827,6 +6827,72 @@ static const ARMCPRegInfo nmi_reginfo[] = {
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
+};
+
 static void define_pmu_regs(ARMCPU *cpu)
 {
     /*
@@ -9014,6 +9080,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, nmi_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_mec, cpu)) {
+        define_arm_cp_regs(cpu, mec_reginfo);
+    }
+
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
-- 
2.34.1


