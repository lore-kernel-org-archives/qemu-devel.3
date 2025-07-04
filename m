Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E77CC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXi8E-000272-ME; Fri, 04 Jul 2025 11:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uXi87-0001zI-OJ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:15:14 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uXi85-0004cx-PG
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:15:11 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-702cbfe860cso4267856d6.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751642109; x=1752246909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2pA8Kdl7I3oMXH8ei53t6GkTDaEspN8YWJLUEgwyNk=;
 b=mIYuFd0tF+N4tEuCtIpQhHyLIJ/ZYWQyx3urdJDpaG+vIrMl/sGzWYn3zLngNm4lcY
 yoHHYJqtqdZKkeZ9tewrJl7cx+HTLLM99P8AQNhQixI3Z1z/fbG8zjBhKcdcv4/gSQeB
 mYMQw/fJH39hM3nTu2+vlIiEfCurDZBrwaI5UBJ2Ulk/B7Q7u+AalBgr+NwYWV9LHXQV
 JHlOVHipLT7gdOaRHkviPu+kr5OMkyXKq3BrC4BjZpZizm8/aTrrEGd5yt0/EtuG/HiQ
 sEE4IUSkD+Zs4TWhj1d4xr+xcES63TpnrU+69VoiDWU4jsS6MvynRyrIddvtG1F4hYwg
 dlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751642109; x=1752246909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2pA8Kdl7I3oMXH8ei53t6GkTDaEspN8YWJLUEgwyNk=;
 b=Igwl4DkjQ2VPjOIjt2ilbwa2cEmCKf5IWMaxsXFsq3p0oweePxmpi2uhQpScd+rHYR
 +ljfwL/bEUFsnrBPxtnXY8MGxQkyB3V322Aqpw5d9GD3J2l4od+v+PljBfkHe0tUnc4a
 yRqc9dX8iU/RdXfzwVYKCPF7HDmFKKSo76vx/Rj0fCAsK3qJEbMfajLgD+Jp3Melw7V2
 cHj8NyL+SXSTemmnRYIFCGTUkn1ExyOhTs8jOJ87XWjxK16yz/MawWZRZrOsC9mh9TEy
 +pPGsJ3b3O+i6rg2j7lASp8fBfO4GEXx6B6t+LVo3/dxDSMyPpEq6Joq/xtgmQGYGFwW
 XMKw==
X-Gm-Message-State: AOJu0YwQTHjTJocT2h1oT/5rVQm4PJ1ilkka635Ufo8J44E9qBpUoXBc
 j87fi8HcbqowMQapQ5c7h8xYjt8fIiy1mmk+rdnjl0PXJ4TRNrAvRayBAyCcWVNGW8I=
X-Gm-Gg: ASbGncvcPUYDEDMhhnLZdmfzxc3O69fN+l40XslygE14pqgfdc/7IcEt3Iyipifjsso
 7W9TNimGcJwFEkN2WgHHSaVYCWBWKclNn2/irWbW8WTgxVti3bgEqHaLCDzG/dmWV1UTOSB9DjC
 mt7cVqbZyNliw7Qvzi4dZ3YWCaf6qRju8sJ18YgdipqVXtV7me4OZ5Xi17yB1GhDlogsuCW8/oD
 HRHX282jcYtqKWogjl+87jUxDTiRydTUvLtthuoWTM7ANjZnRs1ek/m/poDlC7zylu8Fus/ofrH
 HIMRJjgkTp5ArMgJWANIYgcrgJnj5qPopIiydLMQAtiz5XLEgITCqk21c0wV3RUnLp4=
X-Google-Smtp-Source: AGHT+IHj77mXCr/eo8Y9pVElKQB6QlMeINThWHuNNEHwQi2m0hzBWii/jY6k/xnVh3sxR5m+fSPUHA==
X-Received: by 2002:a05:6214:301a:b0:702:c150:46c2 with SMTP id
 6a1803df08f44-702c6d33a2dmr42807526d6.10.1751642108469; 
 Fri, 04 Jul 2025 08:15:08 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d6039fsm13658666d6.111.2025.07.04.08.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:15:07 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org,
	alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [WIP-for-10.1 v2 2/5] target/arm: Add FEAT_MEC registers
Date: Fri,  4 Jul 2025 15:14:28 +0000
Message-Id: <20250704151431.1033520-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704151431.1033520-1-gustavo.romero@linaro.org>
References: <20250704151431.1033520-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qv1-xf36.google.com
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
 target/arm/cpu.h    | 14 +++++++
 target/arm/helper.c | 98 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8ce30ca857..9509217486 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -565,6 +565,16 @@ typedef struct CPUArchState {
 
         /* NV2 register */
         uint64_t vncr_el2;
+
+        /* MEC registers */
+        uint64_t mecidr_el2;
+        uint64_t mecid_p0_el2;
+        uint64_t mecid_a0_el2;
+        uint64_t mecid_p1_el2;
+        uint64_t mecid_a1_el2;
+        uint64_t mecid_rl_a_el3;
+        uint64_t vmecid_p_el2;
+        uint64_t vmecid_a_el2;
     } cp15;
 
     struct {
@@ -2389,6 +2399,10 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+FIELD(MECIDR, MECIDW, 0, 4)
+FIELD(MECID, MECID, 0, 16)
+FIELD(VMECID, MECID, 0, 16)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 889d308807..9f8a284261 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6823,6 +6823,100 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .resetfn = arm_cp_reset_ignore },
 };
 
+static void mecidr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* MECIDWidthm1 = 15, i.e. 16 bits is the width of a MECID. */
+    env->cp15.mecidr_el2 = FIELD_DP64(0, MECIDR, MECIDW, 15);
+}
+
+static uint64_t mecidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    uint64_t valid_mask;
+
+    if (!arm_is_el2_enabled(env)) {
+        /* All bits are RES0. */
+        return 0ULL;
+    }
+
+    valid_mask = R_MECIDR_MECIDW_MASK;
+    return env->cp15.mecidr_el2 & valid_mask;
+}
+
+static CPAccessResult mecid_access(CPUARMState *env,
+                                   const ARMCPRegInfo *ri, bool isread)
+{
+    int el;
+
+    el = arm_current_el(env);
+    if (el == 2 && !(env->cp15.scr_el3 & SCR_MECEN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+
+    return CP_ACCESS_OK;
+}
+
+static void mecid_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    uint64_t valid_mask;
+
+    valid_mask = R_MECID_MECID_MASK;
+    value &= valid_mask;
+    raw_write(env, ri, value);
+}
+
+static uint64_t mecid_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    uint64_t valid_mask;
+
+    valid_mask = R_MECID_MECID_MASK;
+    return raw_read(env, ri) & valid_mask;
+}
+
+static const ARMCPRegInfo mec_reginfo[] = {
+    { .name = "MECIDR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 7, .crn = 10, .crm = 8,
+      .resetfn = mecidr_reset,
+      .access = PL2_RW, .accessfn = mecid_access, .readfn = mecidr_read,
+      .writefn = arm_cp_write_ignore,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecidr_el2) },
+    { .name = "MECID_P0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p0_el2) },
+    { .name = "MECID_A0_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a0_el2) },
+    { .name = "MECID_P1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 2, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_p1_el2) },
+    { .name = "MECID_A1_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 3, .crn = 10, .crm = 8,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_a1_el2) },
+    { .name = "MECID_RL_A_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .opc2 = 1, .crn = 10, .crm = 10,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.mecid_rl_a_el3) },
+    { .name = "VMECID_P_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 0, .crn = 10, .crm = 9,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_p_el2) },
+    { .name = "VMECID_A_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .opc2 = 1, .crn = 10, .crm = 9,
+      .access = PL2_RW, .accessfn = mecid_access,
+      .readfn = mecid_read, .writefn = mecid_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.vmecid_a_el2) },
+};
+
 static void define_pmu_regs(ARMCPU *cpu)
 {
     /*
@@ -9008,6 +9102,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


