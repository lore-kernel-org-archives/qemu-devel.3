Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1A5C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSS-0005Yx-QO; Tue, 01 Jul 2025 13:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSL-0005Tn-Ui
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSG-0003OU-N0
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45377776935so42129065e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389651; x=1751994451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QK8RvFe2IhjZDCNc+St0RMz6uYb453veI+5VnX+9k4s=;
 b=RJlo4zxp9CavJ8gq9j8CdQduGb+Fh8xEQGF6FQ0bIM8pOvwRJYWzrrK11bCR/53s4l
 KDXBsFgZbkR3LsbVPBQZl0yQ6du3Pi8E+KfzyfwLPQd92F9+/JZp8o6XyN24WDsI2Xnp
 4H9NSbJdfrQWcY6vS+z1LugJPAqjA4S/en97mxIqXf9hAMDg6BRb3/r9I0RR7NUgk2hu
 sYOU1pcRs0NoRmCfwLPr6Ud/d6RNQW/1xPP+8YpZIKKIPre/db91WSDy3++UmVSCsx8Q
 gkerXHNfmRAvJdY+r1ZMtkSdVMO8M65fsTLpPqCzR6gKkOFUY5xulnfSRff4RL2upDlG
 i1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389651; x=1751994451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QK8RvFe2IhjZDCNc+St0RMz6uYb453veI+5VnX+9k4s=;
 b=trqD6+B1oVu2Sjt1M1GJ7aixCrt6aqHuBs5xVASlvluOK5oFjE+hm2TIjXBpJqePHp
 qa2LiABb0919aXsYzVaob6cspfxoxaJjGQuyMW/P8/UlbpCp6Fotdrvdp9/6p5Fpw7i2
 68muNyfgic5GLi8MmF6Rbv68GTmzwVMlzZSZvSLZwYAFsbgk5pZQPFsOSodnR8aoXVdY
 /Xd+FH0xLtTbXQLHrihOHfPIp1yn+vf4cddCp8mcTHzDf/R/vRD/wfvZ+OTsunbILv4d
 BJoin/kJFfyIBzYbIqqJfyUWVsSs38DGgNVnIVTn51vzkeM/RlvQsRsA5CN7K+bGuJcF
 jb3A==
X-Gm-Message-State: AOJu0Ywd2hMyUr+QFrqaLo9AVcEkS2WqRUubhIxRLoGXC/qtBjDaG2KL
 w5wAbsr21MZyqsFgK4EdoTsw7Y9VNrLSjRKnaUY1TRsjnk61gktL2B8lRzxwqYGSnkaWBTnBtCu
 EHZoI
X-Gm-Gg: ASbGnctIfj9tKWzTYo1GEkfKVc65kzSDc3VM3J+eC/WQzSzGShINc6adZPmTHo7s1Ad
 uaZnxEeQ94gf78dp4UOnpyvom3xPOUhDCGUhQg55nh/7pS6fmGafDD6Zoj7QN2U25q9AbTOgRoi
 cZcsMyBXNEM5o1xVEcwDi35vMTGcTF9+t0o7Sbij6iyaLk80mlDMNlWTBrGh5Kf++98gagkKycq
 oNtGTwA7BWYw2r/rhU8D1eSOdz94pujAwrpPPKwm0l5SbGoAJ9v03cfU3dxul9UbXRDg3TTY08i
 Ge+Wt7pU2mHZrjV6bV/NmkOp5z2Ho5I7gYdS9hbYMFlB5MezVuneRk2DYr4B88MdyEWF
X-Google-Smtp-Source: AGHT+IEpG0Jlt+f7ApUPln4FV3Gz/721qll4U3PDdPHrj576lAlBaRP0pq6UTaY1uHCauNSKV3eBqA==
X-Received: by 2002:a05:600c:c163:b0:443:48:66d2 with SMTP id
 5b1f17b1804b1-4538ee7db55mr209661445e9.16.1751389651066; 
 Tue, 01 Jul 2025 10:07:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/43] arm/cpu: Store aa64dfr0/1 into the idregs array
Date: Tue,  1 Jul 2025 18:06:44 +0100
Message-ID: <20250701170720.4072660-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Message-id: 20250617153931.1330449-7-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 16 ++++++++--------
 target/arm/cpu.h          |  2 --
 target/arm/internals.h    |  6 +++---
 target/arm/cpu.c          | 15 +++++----------
 target/arm/cpu64.c        |  4 ++--
 target/arm/helper.c       |  4 ++--
 target/arm/hvf/hvf.c      |  4 ++--
 target/arm/kvm.c          | 12 +++++-------
 target/arm/tcg/cpu64.c    | 32 ++++++++++++++++----------------
 9 files changed, 43 insertions(+), 52 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 89c9278639b..9517e8a74c8 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -901,30 +901,30 @@ static inline bool isar_feature_aa64_nv2(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
-        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+    return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 4 &&
+        FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
 static inline bool isar_feature_aa64_pmuv3p4(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 5 &&
-        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+    return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 5 &&
+        FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
 static inline bool isar_feature_aa64_pmuv3p5(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 6 &&
-        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+    return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 6 &&
+        FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
 static inline bool isar_feature_aa64_debugv8p2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, DEBUGVER) >= 8;
+    return FIELD_EX64_IDREG(id, ID_AA64DFR0, DEBUGVER) >= 8;
 }
 
 static inline bool isar_feature_aa64_doublelock(const ARMISARegisters *id)
 {
-    return FIELD_SEX64(id->id_aa64dfr0, ID_AA64DFR0, DOUBLELOCK) >= 0;
+    return FIELD_SEX64_IDREG(id, ID_AA64DFR0, DOUBLELOCK) >= 0;
 }
 
 static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index df9b7cc8c84..c7935377c6f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1074,8 +1074,6 @@ struct ArchCPU {
         uint32_t dbgdidr;
         uint32_t dbgdevid;
         uint32_t dbgdevid1;
-        uint64_t id_aa64dfr0;
-        uint64_t id_aa64dfr1;
         uint64_t id_aa64smfr0;
         uint64_t reset_pmcr_el0;
         uint64_t idregs[NUM_ID_IDX];
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 3360de9150f..6216f68c94f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1175,7 +1175,7 @@ static inline bool regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline int arm_num_brps(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS) + 1;
+        return FIELD_EX64_IDREG(&cpu->isar, ID_AA64DFR0, BRPS) + 1;
     } else {
         return FIELD_EX32(cpu->isar.dbgdidr, DBGDIDR, BRPS) + 1;
     }
@@ -1189,7 +1189,7 @@ static inline int arm_num_brps(ARMCPU *cpu)
 static inline int arm_num_wrps(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS) + 1;
+        return FIELD_EX64_IDREG(&cpu->isar, ID_AA64DFR0, WRPS) + 1;
     } else {
         return FIELD_EX32(cpu->isar.dbgdidr, DBGDIDR, WRPS) + 1;
     }
@@ -1203,7 +1203,7 @@ static inline int arm_num_wrps(ARMCPU *cpu)
 static inline int arm_num_ctx_cmps(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS) + 1;
+        return FIELD_EX64_IDREG(&cpu->isar, ID_AA64DFR0, CTX_CMPS) + 1;
     } else {
         return FIELD_EX32(cpu->isar.dbgdidr, DBGDIDR, CTX_CMPS) + 1;
     }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d39e8dc9560..400bee84943 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2347,8 +2347,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                 cpu);
 #endif
     } else {
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
+        FIELD_DP64_IDREG(isar, ID_AA64DFR0, PMUVER, 0);
         cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, PERFMON, 0);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
@@ -2408,19 +2407,15 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * try to access the non-existent system registers for them.
          */
         /* FEAT_SPE (Statistical Profiling Extension) */
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, PMSVER, 0);
+        FIELD_DP64_IDREG(isar, ID_AA64DFR0, PMSVER, 0);
         /* FEAT_TRBE (Trace Buffer Extension) */
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEBUFFER, 0);
+        FIELD_DP64_IDREG(isar, ID_AA64DFR0, TRACEBUFFER, 0);
         /* FEAT_TRF (Self-hosted Trace Extension) */
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEFILT, 0);
+        FIELD_DP64_IDREG(isar, ID_AA64DFR0, TRACEFILT, 0);
         cpu->isar.id_dfr0 =
             FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, TRACEFILT, 0);
         /* Trace Macrocell system register access */
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEVER, 0);
+        FIELD_DP64_IDREG(isar, ID_AA64DFR0, TRACEVER, 0);
         cpu->isar.id_dfr0 =
             FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, COPTRC, 0);
         /* Memory mapped trace */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 500f3646bfa..a215ba8b479 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -671,7 +671,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
     SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
-    cpu->isar.id_aa64dfr0 = 0x10305106;
+    SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
     SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
     cpu->isar.dbgdidr = 0x3516d000;
@@ -733,7 +733,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
     SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
-    cpu->isar.id_aa64dfr0 = 0x10305106;
+    SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
     SET_IDREG(isar, ID_AA64MMFR0, 0x00001122); /* 40 bit physical addr */
     cpu->isar.dbgdidr = 0x3516d000;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fe0bda749f4..2ac132c1db8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7963,12 +7963,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64dfr0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64DFR0) },
             { .name = "ID_AA64DFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64dfr1 },
+              .resetvalue = GET_IDREG(isar, ID_AA64DFR1) },
             { .name = "ID_AA64DFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 37a6303ec2a..5c95ccc5b8d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -868,8 +868,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     } regs[] = {
         { HV_SYS_REG_ID_AA64PFR0_EL1, &host_isar.idregs[ID_AA64PFR0_EL1_IDX] },
         { HV_SYS_REG_ID_AA64PFR1_EL1, &host_isar.idregs[ID_AA64PFR1_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64DFR0_EL1, &host_isar.id_aa64dfr0 },
-        { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
+        { HV_SYS_REG_ID_AA64DFR0_EL1, &host_isar.idregs[ID_AA64DFR0_EL1_IDX] },
+        { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.idregs[ID_AA64DFR1_EL1_IDX] },
         { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
         { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.idregs[ID_AA64ISAR1_EL1_IDX] },
         /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1dde96fbbda..479e5860e02 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -316,10 +316,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64PFR1_EL1_IDX);
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64smfr0,
                               ARM64_SYS_REG(3, 0, 0, 4, 5));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr0,
-                              ARM64_SYS_REG(3, 0, 0, 5, 0));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr1,
-                              ARM64_SYS_REG(3, 0, 0, 5, 1));
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64DFR0_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64DFR1_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR0_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR1_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR2_EL1_IDX);
@@ -390,10 +388,10 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          * We only do this if the CPU supports AArch32 at EL1.
          */
         if (FIELD_EX32_IDREG(&ahcf->isar, ID_AA64PFR0, EL1) >= 2) {
-            int wrps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, WRPS);
-            int brps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, BRPS);
+            int wrps = FIELD_EX64_IDREG(&ahcf->isar, ID_AA64DFR0, WRPS);
+            int brps = FIELD_EX64_IDREG(&ahcf->isar, ID_AA64DFR0, BRPS);
             int ctx_cmps =
-                FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS);
+                FIELD_EX64_IDREG(&ahcf->isar, ID_AA64DFR0, CTX_CMPS);
             int version = 6; /* ARMv8 debug architecture */
             bool has_el3 =
                 !!FIELD_EX32_IDREG(&ahcf->isar, ID_AA64PFR0, EL3);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 9efb7f0ce80..7e18d31a253 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -65,8 +65,8 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->isar.id_isar5 = 0x00011121;
     SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
     SET_IDREG(isar, ID_AA64PFR1, 0);
-    cpu->isar.id_aa64dfr0 = 0x10305106;
-    cpu->isar.id_aa64dfr1 = 0;
+    SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
+    SET_IDREG(isar, ID_AA64DFR1, 0);
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
     SET_IDREG(isar, ID_AA64ISAR1, 0);
     SET_IDREG(isar, ID_AA64MMFR0, 0x00101122);
@@ -219,7 +219,7 @@ static void aarch64_a55_initfn(Object *obj)
     cpu->clidr = 0x82000023;
     cpu->ctr = 0x84448004; /* L1Ip = VIPT */
     cpu->dcz_blocksize = 4; /* 64 bytes */
-    cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
+    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101122ull);
@@ -310,7 +310,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
     SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
-    cpu->isar.id_aa64dfr0 = 0x10305106;
+    SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
     SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
     cpu->isar.dbgdidr = 0x3516d000;
@@ -352,7 +352,7 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->clidr = 0x82000023;
     cpu->ctr = 0x8444C004;
     cpu->dcz_blocksize = 4;
-    cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
+    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull),
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101122ull);
@@ -426,8 +426,8 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->reset_sctlr = 0x30000180;
     SET_IDREG(isar, ID_AA64PFR0, 0x0000000101111111); /* No RAS Extensions */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000000);
-    cpu->isar.id_aa64dfr0 = 0x0000000010305408;
-    cpu->isar.id_aa64dfr1 = 0x0000000000000000;
+    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408),
+    SET_IDREG(isar, ID_AA64DFR1, 0x0000000000000000),
     cpu->id_aa64afr0 = 0x0000000000000000;
     cpu->id_aa64afr1 = 0x0000000000000000;
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000001122);
@@ -600,7 +600,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     cpu->clidr = 0x82000023;
     cpu->ctr = 0x8444c004;
     cpu->dcz_blocksize = 4;
-    cpu->isar.id_aa64dfr0  = 0x0000000110305408ull;
+    SET_IDREG(isar, ID_AA64DFR0, 0x0000000110305408ull);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101125ull);
@@ -678,8 +678,8 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->dcz_blocksize = 4;
     cpu->id_aa64afr0 = 0x00000000;
     cpu->id_aa64afr1 = 0x00000000;
-    cpu->isar.id_aa64dfr0  = 0x000001f210305519ull;
-    cpu->isar.id_aa64dfr1 = 0x00000000;
+    SET_IDREG(isar, ID_AA64DFR0, 0x000001f210305519ull),
+    SET_IDREG(isar, ID_AA64DFR1, 0x00000000),
     SET_IDREG(isar, ID_AA64ISAR0, 0x1011111110212120ull); /* with FEAT_RNG */
     SET_IDREG(isar, ID_AA64ISAR1, 0x0011000001211032ull);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101125ull);
@@ -925,8 +925,8 @@ static void aarch64_a710_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x1201111120111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000221ull);
     SET_IDREG(isar, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
-    cpu->isar.id_aa64dfr0  = 0x000011f010305619ull;
-    cpu->isar.id_aa64dfr1  = 0;
+    SET_IDREG(isar, ID_AA64DFR0, 0x000011f010305619ull);
+    SET_IDREG(isar, ID_AA64DFR1, 0);
     cpu->id_aa64afr0       = 0;
     cpu->id_aa64afr1       = 0;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0221111110212120ull); /* with Crypto */
@@ -1027,8 +1027,8 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x1201111120111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000221ull);
     SET_IDREG(isar, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
-    cpu->isar.id_aa64dfr0  = 0x000011f210305619ull;
-    cpu->isar.id_aa64dfr1  = 0;
+    SET_IDREG(isar, ID_AA64DFR0, 0x000011f210305619ull);
+    SET_IDREG(isar, ID_AA64DFR1, 0);
     cpu->id_aa64afr0       = 0;
     cpu->id_aa64afr1       = 0;
     SET_IDREG(isar, ID_AA64ISAR0, 0x1221111110212120ull); /* with Crypto and FEAT_RNG */
@@ -1261,11 +1261,11 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 1);     /* FEAT_F64MM */
     SET_IDREG(isar, ID_AA64ZFR0, t);
 
-    t = cpu->isar.id_aa64dfr0;
+    t = GET_IDREG(isar, ID_AA64DFR0);
     t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 10); /* FEAT_Debugv8p8 */
     t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* FEAT_PMUv3p5 */
     t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* FEAT_HPMN0 */
-    cpu->isar.id_aa64dfr0 = t;
+    SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = cpu->isar.id_aa64smfr0;
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
-- 
2.43.0


