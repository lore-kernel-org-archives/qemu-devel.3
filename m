Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6243EC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSg-0005jT-Eh; Tue, 01 Jul 2025 13:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSP-0005UW-PD
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:45 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSH-0003QP-8r
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:45 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so3284132f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389655; x=1751994455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VkcC/6HdEeSglld81pIIFbWGMKXGbw2aBdIeTePjnOM=;
 b=h4VYaj89r+v2IM2foBPA9bGKAOSSlW2Wsq9gP8vVhEennOVmMcLAdDc6I8bLyeddM7
 b3WV2Y/6evN6zkiFp7nvw8ZaRfnIdmBgBFjS4TqPQoYw2VEuMySCrsuCnG/V5rEOATBX
 OSKu7QNnuDt/kLiIOuopfZKEthGf1NNPC+uLDfvZh4pwCd/eqOU/3IbstRkFgYVSzEpt
 bvGXEeDMn54LgsFirRJKseMvIuFIOsyNjkh7AcWiO0RJnjMy2C4LUv0OB1Bdd54zBU2X
 OfKs2vV8/IAeUOqJKG7JB9D/7s4TVgKYSuJlzSdyvRVZI27so5q1GwHPlQ5yM0bhh1dD
 rzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389655; x=1751994455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VkcC/6HdEeSglld81pIIFbWGMKXGbw2aBdIeTePjnOM=;
 b=PK7HOyTMG8Wa2Ijyvn3k+YdVPDDkotQK9865Ey/dBIdpM0DstC3gPe8n7Eib64KMLK
 72mgVWihnr/ey3iTNVxyOuNOkPGb2fwtAldPjwJh+eIjcQsG88wfD+CUmVUVn6UBTtTc
 t+9sdjyzkHZcvUn6wdZ28RD/10RTA6gFVZk8nHMvU2n2SviQPI6bw+yvuF+dE9n3oMVW
 47u1TgSEYgApJvWRx5gyA3Vha7cOh4Bt2RarTrNZV0t3EDDCTnFDY9a60YlrcPMlQkN4
 oCx+aHI+p/Ym2ilU5IO3Uhfm5tmJkx2Fim/1zoUJJ/U8biAv9QBffYzv+WsOxb1SdnkV
 LqlQ==
X-Gm-Message-State: AOJu0Yynqdr/mI8XrDi8ACH4UO+JhOPiV/nN8CL2j4IQy06/3L3ud//D
 7xeEn3i5PDjTnulUooU1pdM5cJQI2tE/mGnSfog1RGdS/Zy65f2qOM+BSyOwPUY0yia9teZR16H
 mr2ZH
X-Gm-Gg: ASbGncvbM1JT12wZnRaGNO4jDvMHNXXBrPfEpLGM8CMw+hF92Q5/sTdB3F5nTX9UV1H
 6Yn+Ue2ZraNAW42EeoLzRAIpw4Mp+ZSjSubImR9BvfSZeDQ+ZHsPm6snk2GshFueNeBDGBYnx0Y
 TlAmrzd4YQp7BQW9Jx65tKf+zG36zwpxaaT21oHjxC7N+hbYcpUl75Lpc8yXmoSp0PT/t0tq4iF
 +gqYlm9LQT6W7ewbAcX7RPma/Quea32II+znKjML92l65T3yAiPA5cyrw9yd6Fhm3+1HgJcD5hB
 SJDpnoZdxLnVkGCvIqDGSuZI9Ms7eFiGE7UkzLhGpKJZjEzYJjE1TRnwafezJxxJyc3cFKSeBo0
 +H88=
X-Google-Smtp-Source: AGHT+IEz8zne9mqaz5219RAaERY5A1IApLjAFVtwjC8xL3v1JGtGGiaJh7m0nX4dPuuQXeSnOmJQyA==
X-Received: by 2002:adf:9cc9:0:b0:3a3:67bb:8f3f with SMTP id
 ffacd0b85a97d-3a902f70a1cmr14855438f8f.53.1751389655060; 
 Tue, 01 Jul 2025 10:07:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/43] arm/cpu: Store id_dfr0/1 into the idregs array
Date: Tue,  1 Jul 2025 18:06:48 +0100
Message-ID: <20250701170720.4072660-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-id: 20250617153931.1330449-11-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 16 ++++++++--------
 target/arm/cpu.h          |  2 --
 hw/intc/armv7m_nvic.c     |  2 +-
 target/arm/cpu.c          | 13 +++++--------
 target/arm/cpu64.c        |  4 ++--
 target/arm/helper.c       |  4 ++--
 target/arm/kvm.c          |  6 ++----
 target/arm/tcg/cpu-v7m.c  | 12 ++++++------
 target/arm/tcg/cpu32.c    | 30 ++++++++++++++----------------
 target/arm/tcg/cpu64.c    | 16 ++++++++--------
 10 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a34378577f0..0292a7cd6ec 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -300,22 +300,22 @@ static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
 static inline bool isar_feature_aa32_pmuv3p1(const ARMISARegisters *id)
 {
     /* 0xf means "non-standard IMPDEF PMU" */
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
-        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+    return FIELD_EX32_IDREG(id, ID_DFR0, PERFMON) >= 4 &&
+        FIELD_EX32_IDREG(id, ID_DFR0, PERFMON) != 0xf;
 }
 
 static inline bool isar_feature_aa32_pmuv3p4(const ARMISARegisters *id)
 {
     /* 0xf means "non-standard IMPDEF PMU" */
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 5 &&
-        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+    return FIELD_EX32_IDREG(id, ID_DFR0, PERFMON) >= 5 &&
+        FIELD_EX32_IDREG(id, ID_DFR0, PERFMON) != 0xf;
 }
 
 static inline bool isar_feature_aa32_pmuv3p5(const ARMISARegisters *id)
 {
     /* 0xf means "non-standard IMPDEF PMU" */
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 6 &&
-        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+    return FIELD_EX32_IDREG(id, ID_DFR0, PERFMON) >= 6 &&
+        FIELD_EX32_IDREG(id, ID_DFR0, PERFMON) != 0xf;
 }
 
 static inline bool isar_feature_aa32_hpd(const ARMISARegisters *id)
@@ -360,12 +360,12 @@ static inline bool isar_feature_aa32_ssbs(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa32_debugv7p1(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, COPDBG) >= 5;
+    return FIELD_EX32_IDREG(id, ID_DFR0, COPDBG) >= 5;
 }
 
 static inline bool isar_feature_aa32_debugv8p2(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, COPDBG) >= 8;
+    return FIELD_EX32_IDREG(id, ID_DFR0, COPDBG) >= 8;
 }
 
 static inline bool isar_feature_aa32_doublelock(const ARMISARegisters *id)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 30401926e11..c799105eeb2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1059,8 +1059,6 @@ struct ArchCPU {
         uint32_t mvfr0;
         uint32_t mvfr1;
         uint32_t mvfr2;
-        uint32_t id_dfr0;
-        uint32_t id_dfr1;
         uint32_t dbgdidr;
         uint32_t dbgdevid;
         uint32_t dbgdevid1;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 330205fa342..2566dd63431 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1274,7 +1274,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_dfr0;
+        return GET_IDREG(isar, ID_DFR0);
     case 0xd4c: /* AFR0.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 62c06c7269c..8e77414c2b9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2318,7 +2318,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * feature registers as well.
          */
         FIELD_DP32_IDREG(isar, ID_PFR1, SECURITY, 0);
-        cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, COPSDBG, 0);
+        FIELD_DP32_IDREG(isar, ID_DFR0, COPSDBG, 0);
         FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL3, 0);
 
         /* Disable the realm management extension, which requires EL3. */
@@ -2346,7 +2346,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
     } else {
         FIELD_DP64_IDREG(isar, ID_AA64DFR0, PMUVER, 0);
-        cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, PERFMON, 0);
+        FIELD_DP32_IDREG(isar, ID_DFR0, PERFMON, 0);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
     }
@@ -2409,15 +2409,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         FIELD_DP64_IDREG(isar, ID_AA64DFR0, TRACEBUFFER, 0);
         /* FEAT_TRF (Self-hosted Trace Extension) */
         FIELD_DP64_IDREG(isar, ID_AA64DFR0, TRACEFILT, 0);
-        cpu->isar.id_dfr0 =
-            FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, TRACEFILT, 0);
+        FIELD_DP32_IDREG(isar, ID_DFR0, TRACEFILT, 0);
         /* Trace Macrocell system register access */
         FIELD_DP64_IDREG(isar, ID_AA64DFR0, TRACEVER, 0);
-        cpu->isar.id_dfr0 =
-            FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, COPTRC, 0);
+        FIELD_DP32_IDREG(isar, ID_DFR0, COPTRC, 0);
         /* Memory mapped trace */
-        cpu->isar.id_dfr0 =
-            FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, MMAPTRC, 0);
+        FIELD_DP32_IDREG(isar, ID_DFR0, MMAPTRC, 0);
         /* FEAT_AMU (Activity Monitors Extension) */
         FIELD_DP64_IDREG(isar, ID_AA64PFR0, AMU, 0);
         FIELD_DP32_IDREG(isar, ID_PFR0, AMU, 0);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 5b628aa7ebf..47c2eed3c99 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -654,7 +654,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50838;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x03010066;
+    SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10101105;
     cpu->isar.id_mmfr1 = 0x40000000;
@@ -716,7 +716,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50838;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x03010066;
+    SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10101105;
     cpu->isar.id_mmfr1 = 0x40000000;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 03299238224..4d90ff7fd51 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7800,7 +7800,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_dfr0 },
+              .resetvalue = GET_IDREG(isar, ID_DFR0)},
             { .name = "ID_AFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -8135,7 +8135,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_dfr1 },
+              .resetvalue = GET_IDREG(isar, ID_DFR1)},
             { .name = "ID_MMFR5", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d945e652b3e..2a6a5329b43 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -334,8 +334,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          */
         err |= get_host_cpu_reg(fd, ahcf, ID_PFR0_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_PFR1_EL1_IDX);
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr0,
-                              ARM64_SYS_REG(3, 0, 0, 1, 2));
+        err |= get_host_cpu_reg(fd, ahcf, ID_DFR0_EL1_IDX);
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr0,
                               ARM64_SYS_REG(3, 0, 0, 1, 4));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr1,
@@ -361,8 +360,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr2,
                               ARM64_SYS_REG(3, 0, 0, 3, 2));
         err |= get_host_cpu_reg(fd, ahcf, ID_PFR2_EL1_IDX);
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr1,
-                              ARM64_SYS_REG(3, 0, 0, 3, 5));
+        err |= get_host_cpu_reg(fd, ahcf, ID_DFR1_EL1_IDX);
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr5,
                               ARM64_SYS_REG(3, 0, 0, 3, 6));
 
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 4a2c3bd01a3..9697c362c19 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -61,7 +61,7 @@ static void cortex_m0_initfn(Object *obj)
      */
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
-    cpu->isar.id_dfr0 = 0x00100000;
+    SET_IDREG(isar, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00000030;
     cpu->isar.id_mmfr1 = 0x00000000;
@@ -87,7 +87,7 @@ static void cortex_m3_initfn(Object *obj)
     cpu->pmsav7_dregion = 8;
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
-    cpu->isar.id_dfr0 = 0x00100000;
+    SET_IDREG(isar, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00000030;
     cpu->isar.id_mmfr1 = 0x00000000;
@@ -118,7 +118,7 @@ static void cortex_m4_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000000;
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
-    cpu->isar.id_dfr0 = 0x00100000;
+    SET_IDREG(isar, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00000030;
     cpu->isar.id_mmfr1 = 0x00000000;
@@ -149,7 +149,7 @@ static void cortex_m7_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000040;
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
-    cpu->isar.id_dfr0 = 0x00100000;
+    SET_IDREG(isar, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00100030;
     cpu->isar.id_mmfr1 = 0x00000000;
@@ -182,7 +182,7 @@ static void cortex_m33_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000040;
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000210);
-    cpu->isar.id_dfr0 = 0x00200000;
+    SET_IDREG(isar, ID_DFR0, 0x00200000);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00101F40;
     cpu->isar.id_mmfr1 = 0x00000000;
@@ -220,7 +220,7 @@ static void cortex_m55_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000040;
     SET_IDREG(isar, ID_PFR0, 0x20000030);
     SET_IDREG(isar, ID_PFR1, 0x00000230);
-    cpu->isar.id_dfr0 = 0x10200000;
+    SET_IDREG(isar, ID_DFR0, 0x10200000);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00111040;
     cpu->isar.id_mmfr1 = 0x00000000;
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 56374db2692..bec69fe52e4 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -82,11 +82,11 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, ID_PFR2, SSBS, 1);          /* FEAT_SSBS */
     SET_IDREG(isar, ID_PFR2, t);
 
-    t = cpu->isar.id_dfr0;
+    t = GET_IDREG(isar, ID_DFR0);
     t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
     t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
     t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
-    cpu->isar.id_dfr0 = t;
+    SET_IDREG(isar, ID_DFR0, t);
 
     /* Debug ID registers. */
 
@@ -116,9 +116,7 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
     cpu->isar.dbgdevid1 = t;
 
-    t = cpu->isar.id_dfr1;
-    t = FIELD_DP32(t, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
-    cpu->isar.id_dfr1 = t;
+    FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
 }
 
 /* CPU models. These are not needed for the AArch64 linux-user build. */
@@ -230,7 +228,7 @@ static void arm1136_r2_initfn(Object *obj)
     cpu->reset_sctlr = 0x00050078;
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
-    cpu->isar.id_dfr0 = 0x2;
+    SET_IDREG(isar, ID_DFR0, 0x2);
     cpu->id_afr0 = 0x3;
     cpu->isar.id_mmfr0 = 0x01130003;
     cpu->isar.id_mmfr1 = 0x10030302;
@@ -262,7 +260,7 @@ static void arm1136_initfn(Object *obj)
     cpu->reset_sctlr = 0x00050078;
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
-    cpu->isar.id_dfr0 = 0x2;
+    SET_IDREG(isar, ID_DFR0, 0x2);
     cpu->id_afr0 = 0x3;
     cpu->isar.id_mmfr0 = 0x01130003;
     cpu->isar.id_mmfr1 = 0x10030302;
@@ -295,7 +293,7 @@ static void arm1176_initfn(Object *obj)
     cpu->reset_sctlr = 0x00050078;
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x11);
-    cpu->isar.id_dfr0 = 0x33;
+    SET_IDREG(isar, ID_DFR0, 0x33);
     cpu->id_afr0 = 0;
     cpu->isar.id_mmfr0 = 0x01130003;
     cpu->isar.id_mmfr1 = 0x10030302;
@@ -325,7 +323,7 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->ctr = 0x1d192992; /* 32K icache 32K dcache */
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
-    cpu->isar.id_dfr0 = 0;
+    SET_IDREG(isar, ID_DFR0, 0);
     cpu->id_afr0 = 0x2;
     cpu->isar.id_mmfr0 = 0x01100103;
     cpu->isar.id_mmfr1 = 0x10020302;
@@ -365,7 +363,7 @@ static void cortex_a8_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     SET_IDREG(isar, ID_PFR0, 0x1031);
     SET_IDREG(isar, ID_PFR1, 0x11);
-    cpu->isar.id_dfr0 = 0x400;
+    SET_IDREG(isar, ID_DFR0, 0x400);
     cpu->id_afr0 = 0;
     cpu->isar.id_mmfr0 = 0x31100003;
     cpu->isar.id_mmfr1 = 0x20000000;
@@ -441,7 +439,7 @@ static void cortex_a9_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     SET_IDREG(isar, ID_PFR0, 0x1031);
     SET_IDREG(isar, ID_PFR1, 0x11);
-    cpu->isar.id_dfr0 = 0x000;
+    SET_IDREG(isar, ID_DFR0, 0x000);
     cpu->id_afr0 = 0;
     cpu->isar.id_mmfr0 = 0x00100103;
     cpu->isar.id_mmfr1 = 0x20000000;
@@ -507,7 +505,7 @@ static void cortex_a7_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     SET_IDREG(isar, ID_PFR0, 0x00001131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x02010555;
+    SET_IDREG(isar, ID_DFR0, 0x02010555);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10101105;
     cpu->isar.id_mmfr1 = 0x40000000;
@@ -559,7 +557,7 @@ static void cortex_a15_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     SET_IDREG(isar, ID_PFR0, 0x00001131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x02010555;
+    SET_IDREG(isar, ID_DFR0, 0x02010555);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x20000000;
@@ -603,7 +601,7 @@ static void cortex_r5_initfn(Object *obj)
     cpu->midr = 0x411fc153; /* r1p3 */
     SET_IDREG(isar, ID_PFR0, 0x0131);
     SET_IDREG(isar, ID_PFR1, 0x001);
-    cpu->isar.id_dfr0 = 0x010400;
+    SET_IDREG(isar, ID_DFR0, 0x010400);
     cpu->id_afr0 = 0x0;
     cpu->isar.id_mmfr0 = 0x0210030;
     cpu->isar.id_mmfr1 = 0x00000000;
@@ -750,7 +748,7 @@ static void cortex_r52_initfn(Object *obj)
     cpu->reset_sctlr = 0x30c50838;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x10111001);
-    cpu->isar.id_dfr0 = 0x03010006;
+    SET_IDREG(isar, ID_DFR0, 0x03010006);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00211040;
     cpu->isar.id_mmfr1 = 0x40000000;
@@ -982,7 +980,7 @@ static void arm_max_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50838;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x03010066;
+    SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10101105;
     cpu->isar.id_mmfr1 = 0x40000000;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index c3f90e9d135..aeaade488fe 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -51,7 +51,7 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->ctr = 0x84448004;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x03010066;
+    SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0;
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x40000000;
@@ -228,7 +228,7 @@ static void aarch64_a55_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x0000000010112222ull);
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
-    cpu->isar.id_dfr0  = 0x04010088;
+    SET_IDREG(isar, ID_DFR0, 0x04010088);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
@@ -297,7 +297,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50838;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x03010066;
+    SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x40000000;
@@ -361,7 +361,7 @@ static void aarch64_a76_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
-    cpu->isar.id_dfr0  = 0x04010088;
+    SET_IDREG(isar, ID_DFR0, 0x04010088);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
@@ -609,7 +609,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
-    cpu->isar.id_dfr0  = 0x04010088;
+    SET_IDREG(isar, ID_DFR0, 0x04010088);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
@@ -688,7 +688,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x1101110120111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
-    cpu->isar.id_dfr0  = 0x15011099;
+    SET_IDREG(isar, ID_DFR0, 0x15011099);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
@@ -904,7 +904,7 @@ static void aarch64_a710_initfn(Object *obj)
     cpu->revidr        = 0;
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
-    cpu->isar.id_dfr0  = 0x16011099;
+    SET_IDREG(isar, ID_DFR0, 0x16011099);
     cpu->id_afr0       = 0;
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x40000000;
@@ -1006,7 +1006,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     cpu->revidr        = 0;
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
-    cpu->isar.id_dfr0  = 0x16011099;
+    SET_IDREG(isar, ID_DFR0, 0x16011099);
     cpu->id_afr0       = 0;
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x40000000;
-- 
2.43.0


