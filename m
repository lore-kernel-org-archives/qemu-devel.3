Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D65C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxTYv-0003Ip-De; Thu, 18 Apr 2024 11:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxTYi-0003F1-Ma
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxTYg-0004X1-CL
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41882c16824so8358995e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713453607; x=1714058407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EgUWdXzTtkS0pYgFkeqEh/AXA2JNP+NIqv08IWtEXT8=;
 b=zzFOP1lAK/qVEBRihCojfoC6eWJqVsJlLMz/lbxVMYE7F7FueAarAfGSUXTegjZVXZ
 j+9JHqNy2mTz+sX8igdDHTqZ8PNFs1GWANedlrh88Rt3LlBDntabLW5jhYsIntRwV64n
 A+kaNJcuWdf4AyYT5dakC3rXdpb0ZQVpldbvYOsnTlLYJV0Wt9SaYSCT24py0n0pqH7L
 epfv4TAHhesbKdsYueyZ9O69GayLLrR/SFR6EpvYjpluGvni1cQfy2A8wZGit3jdAHha
 Ygk8AuBIlkf/Q/14NhXUSeo4EVVqdNaBIYgwjqiZeVDspuIMM4X6vPhT3/T8wjtQZJvy
 hB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713453607; x=1714058407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgUWdXzTtkS0pYgFkeqEh/AXA2JNP+NIqv08IWtEXT8=;
 b=RVCb/Sh3VWHubgxOUG0so3dRbV3lqhmPtN3frudQw8kGEmB/txpiWXCoBtWaQSMoQf
 3L/BexA99i5l1qNsCrjRh+iPmitLW03qYeTgROD6V+gIEFN0j+tSrqgGtNd55riEb7bS
 PiOyOjJFMM+XI3u2fKAvnGhFpT3mJ0ioVjF9DF2UHQoR2TzsONq9ZLmRoqS+CW5bzBvL
 rpRvLRyu5SRQhuoDgNyUoCnpf3X0T3rVYa6AZM3CQluyNJ6WorQsFxxKeAaMewVub9L0
 W+UeAJAN15SVqmB3kGwHkTjx1HCQTFRNB+FFO6e/tTLyx0yij6JuZap7eH9m98eVyUW4
 5vOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW//66qiZDehEv/2zquKFbmHa3Ca/tJ7ILpcgSsAM7KyBByrbJkDiMjrBcXDxcSqPxLwHT2qcHRLwXSHQ/G5BLD767grI=
X-Gm-Message-State: AOJu0YwLpAty7Z0u4z+gTCacg57mnLUgh4Cx4ptYRgBJNeSmDwhWHLRd
 jMXe4feanVg71IGdyaA/lTG3RAfV9oavudLKYsamXYZKGLNv+aDu9MvUS5QR+sQ=
X-Google-Smtp-Source: AGHT+IHpPkqO5rpWo1Isvw01TvJCqmGqKOrGgxBmYDH2v2A6p3Q8Aaz0qhdM3Gc7A+Ajd+WwTLMn1w==
X-Received: by 2002:a05:600c:4510:b0:418:2636:ab4c with SMTP id
 t16-20020a05600c451000b004182636ab4cmr2327729wmo.6.1713453607633; 
 Thu, 18 Apr 2024 08:20:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a05600c475100b004162d06768bsm6886839wmo.21.2024.04.18.08.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 08:20:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/5] target/arm: Implement ID_AA64MMFR3_EL1
Date: Thu, 18 Apr 2024 16:20:03 +0100
Message-Id: <20240418152004.2106516-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418152004.2106516-1-peter.maydell@linaro.org>
References: <20240418152004.2106516-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Newer versions of the Arm ARM (e.g.  rev K.a) now define fields for
ID_AA64MMFR3_EL1.  Implement this register, so that we can set the
fields if we need to.  There's no behaviour change here since we
don't currently set the register value to non-zero.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     | 17 +++++++++++++++++
 target/arm/helper.c  |  6 ++++--
 target/arm/hvf/hvf.c |  2 ++
 target/arm/kvm.c     |  2 ++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bc0c84873ff..20d8257c853 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1008,6 +1008,7 @@ struct ArchCPU {
         uint64_t id_aa64mmfr0;
         uint64_t id_aa64mmfr1;
         uint64_t id_aa64mmfr2;
+        uint64_t id_aa64mmfr3;
         uint64_t id_aa64dfr0;
         uint64_t id_aa64dfr1;
         uint64_t id_aa64zfr0;
@@ -2200,6 +2201,22 @@ FIELD(ID_AA64MMFR2, BBM, 52, 4)
 FIELD(ID_AA64MMFR2, EVT, 56, 4)
 FIELD(ID_AA64MMFR2, E0PD, 60, 4)
 
+FIELD(ID_AA64MMFR3, TCRX, 0, 4)
+FIELD(ID_AA64MMFR3, SCTLRX, 4, 4)
+FIELD(ID_AA64MMFR3, S1PIE, 8, 4)
+FIELD(ID_AA64MMFR3, S2PIE, 12, 4)
+FIELD(ID_AA64MMFR3, S1POE, 16, 4)
+FIELD(ID_AA64MMFR3, S2POE, 20, 4)
+FIELD(ID_AA64MMFR3, AIE, 24, 4)
+FIELD(ID_AA64MMFR3, MEC, 28, 4)
+FIELD(ID_AA64MMFR3, D128, 32, 4)
+FIELD(ID_AA64MMFR3, D128_2, 36, 4)
+FIELD(ID_AA64MMFR3, SNERR, 40, 4)
+FIELD(ID_AA64MMFR3, ANERR, 44, 4)
+FIELD(ID_AA64MMFR3, SDERR, 52, 4)
+FIELD(ID_AA64MMFR3, ADERR, 56, 4)
+FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
+
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
 FIELD(ID_AA64DFR0, PMUVER, 8, 4)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a620481d7cf..8bdbb404195 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8932,11 +8932,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.id_aa64mmfr2 },
-            { .name = "ID_AA64MMFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64MMFR3_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = cpu->isar.id_aa64mmfr3 },
             { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -9093,6 +9093,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .exported_bits = R_ID_AA64MMFR1_AFP_MASK },
             { .name = "ID_AA64MMFR2_EL1",
               .exported_bits = R_ID_AA64MMFR2_AT_MASK },
+            { .name = "ID_AA64MMFR3_EL1",
+              .exported_bits = 0 },
             { .name = "ID_AA64MMFR*_EL1_RESERVED",
               .is_glob = true },
             { .name = "ID_AA64DFR0_EL1",
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 65a56018041..2cbc66dc791 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -498,6 +498,7 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
 #endif
     { HV_SYS_REG_ID_AA64MMFR1_EL1, HVF_SYSREG(0, 7, 3, 0, 1) },
     { HV_SYS_REG_ID_AA64MMFR2_EL1, HVF_SYSREG(0, 7, 3, 0, 2) },
+    /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
 
     { HV_SYS_REG_MDSCR_EL1, HVF_SYSREG(0, 2, 2, 0, 2) },
     { HV_SYS_REG_SCTLR_EL1, HVF_SYSREG(1, 0, 3, 0, 0) },
@@ -856,6 +857,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { HV_SYS_REG_ID_AA64MMFR0_EL1, &host_isar.id_aa64mmfr0 },
         { HV_SYS_REG_ID_AA64MMFR1_EL1, &host_isar.id_aa64mmfr1 },
         { HV_SYS_REG_ID_AA64MMFR2_EL1, &host_isar.id_aa64mmfr2 },
+        /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
     };
     hv_vcpu_t fd;
     hv_return_t r = HV_SUCCESS;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ab85d628a8b..cfb87f8cba5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -331,6 +331,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 7, 1));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
                               ARM64_SYS_REG(3, 0, 0, 7, 2));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr3,
+                              ARM64_SYS_REG(3, 0, 0, 7, 3));
 
         /*
          * Note that if AArch32 support is not present in the host,
-- 
2.34.1


