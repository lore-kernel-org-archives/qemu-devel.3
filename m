Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F402CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPI-0007Wv-Vu; Sat, 16 May 2026 20:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOb-00079f-9a
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:17 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOX-0004sP-95
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:16 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso420973a12.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977811; x=1779582611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WK1q3UP9P6NsmMV4Mdmwr5OMlQgZn6qbug7f6ieaup4=;
 b=k+rJ2Py7tvrqT3RPZ+A/WQ/nqwj6aPEE5Sc3/A8SEct8TQNTa9XV0Ojaj8eYPvtwbt
 tvRLS2OehDTfKv1BIHMXlQs7aF1KFeLrEV6ZudJXBuCaaPezaJmGyOdbecaAtE6ezQhy
 Wm2Ot86+t6aaC78Jaw/Ojwjjv9wk2i2PIrAITxyHEdV7LsZSicWQLK9hDCi553cRpLCE
 l0RAfnjClpi32bBJPaptUv0BK6ame8OBWc90bLMowdGvCk+yN4xVk/zNa9t+nBIThbEO
 TiSSsFGv+Km4MIxxMGhuCPdjgFesXNyBGGHupYdgp6YqjN72AhjUeg7ZE+ohH1afIKWc
 jN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977811; x=1779582611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WK1q3UP9P6NsmMV4Mdmwr5OMlQgZn6qbug7f6ieaup4=;
 b=JEcGjihOanI9w6N1oVMiGYLB4S9WbFGQ2cqQWE/xAkM0YFM3pLTpisGT06JGxfpO0P
 6ICrRt8j48E5Ft2g0BXFCSqURZSM04fCZsudGOpEuYBWzvHL7DCRE78xNyx0Jk6juDBF
 CnerUErX0JiBRIvik+PulwOOvacYf7zv9a4ZHK0v36FqAtpq4JlitxIdr7ZBaFst8nK8
 JEjTsKm48aVG2vLPez6LT40/R530Xw3QRGglLVikjJSwJtORFMJ1pNHvRoEaadc5T3H9
 5nKwFz2bZ96tokImPjT6p4Kx6jwnpFXjUpeI/B3ZDy1D4IEpN6/hHJwClbxz68SWfX9b
 g4kA==
X-Gm-Message-State: AOJu0YyCaTxN1MOiTsk3oJmJuv6ez8nxwqNjZ1uUMsgY4OwxKY4xIOB5
 LDlOn6c9ViCEakEJbac1w/wVipKSQ64TDt8oIjp4oofHaopAfrKa99nMq0eOBfpjNILIvUAhh3i
 jNn9I
X-Gm-Gg: Acq92OE2dU+MIkZIOj5CxZ32FREHo2UYDy45n2e87mJALgQn0wbue4mBMsekw4muhPU
 K6M3/e6tdNpilRGaAbMYtWf+jxL58q48LcjiY+H0X2etXS2Vf3MzP6eKFqy3kRBDIMHOfWa73Lv
 g/hgPmYVrzdb/2qmAT/r1De9rK9crzn/so2pOlJQdu+ZfzDw8gf5EUsTR1ONeRCL4EYvy6SQTt5
 hrpKTedzNitXKaAIrf5jSwxuu2xrtwfNrvi5Wpg5JjuqM1ofoUz7GYniaXcdY4teDQUc9fPieqk
 /ogDr3D5Ei2PlEg3eZXEDcQffY66W62yYsGVXYawKbJGJ5Qyrjj4I3aLKMLh/CzV+wPyZrmmwS4
 4LFR/wKMp6rKBPNHA7RAuJPQy6dmEm8K4hmlxsBj8EcviFdD7sYRz/zkB+69hIDE29w1IgVUN4w
 X0x5QCb2Q2/w0z9FxbXwJHwfYRkkUUPNCxHLVaNC0=
X-Received: by 2002:a05:6a00:8d1:b0:824:9bc5:e946 with SMTP id
 d2e1a72fcca58-83f33f2ba2bmr9594570b3a.46.1778977811331; 
 Sat, 16 May 2026 17:30:11 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 09/63] target/arm: Introduce FPMR
Date: Sat, 16 May 2026 17:29:08 -0700
Message-ID: <20260517003002.321430-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce the special register FPMR and its fields.
Migrate it when present.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h       |  5 +++++
 target/arm/cpu-features.h |  5 +++++
 target/arm/cpu.h          |  1 +
 target/arm/internals.h    | 10 ++++++++++
 target/arm/helper.c       | 12 +++++++++++-
 target/arm/machine.c      | 20 ++++++++++++++++++++
 6 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index f5ec7484c1..391c0e322b 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -149,6 +149,11 @@ enum {
      * should not trap to EL2 when HCR_EL2.NV is set.
      */
     ARM_CP_NV_NO_TRAP            = 1 << 22,
+    /*
+     * Flag: Access check for this sysreg is constrained by the
+     * ARM pseudocode function CheckFPMREnabled().
+     */
+    ARM_CP_FPMR                  = 1 << 23,
 };
 
 /*
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a7ab7e2a31..e13c1c1331 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1192,6 +1192,11 @@ static inline bool isar_feature_aa64_gcie(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, GCIE) != 0;
 }
 
+static inline bool isar_feature_aa64_fpmr(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, FPMR) != 0;
+}
+
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
 {
     return FIELD_SEX64_IDREG(id, ID_AA64MMFR0, TGRAN4) >= 1;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0a11dd9002..498af7db08 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -713,6 +713,7 @@ typedef struct CPUArchState {
          */
         uint64_t fpsr;
         uint64_t fpcr;
+        uint64_t fpmr;
 
         uint32_t xregs[16];
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4414be85d9..ff30381fa5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -292,6 +292,16 @@ FIELD(CNTHCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
+FIELD(FPMR, F8S1, 0, 3)
+FIELD(FPMR, F8S2, 3, 3)
+FIELD(FPMR, F8D, 6, 3)
+FIELD(FPMR, OSM, 14, 1)
+FIELD(FPMR, OSC, 15, 1)
+FIELD(FPMR, LSCALE, 16, 7)
+FIELD(FPMR, NSCALE, 24, 8)
+FIELD(FPMR, NSCALE_F16, 24, 5)
+FIELD(FPMR, LSCALE2, 32, 6)
+
 /* We use a few fake FSR values for internal purposes in M profile.
  * M profile cores don't have A/R format FSRs, but currently our
  * get_phys_addr() code assumes A/R profile and reports failures via
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6ad01b345f..ae1dd42dc4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6229,6 +6229,14 @@ static const ARMCPRegInfo aie_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
+static const ARMCPRegInfo fpmr_reginfo[] = {
+    { .name = "FPMR", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 4, .crm = 4, .opc2 = 2,
+      .access = PL0_RW, .type = ARM_CP_FPU | ARM_CP_FPMR,
+      .fieldoffset = offsetof(CPUARMState, vfp.fpmr),
+    }
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7502,10 +7510,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             define_arm_cp_regs(cpu, mec_mte_reginfo);
         }
     }
-
     if (cpu_isar_feature(aa64_aie, cpu)) {
         define_arm_cp_regs(cpu, aie_reginfo);
     }
+    if (cpu_isar_feature(aa64_fpmr, cpu)) {
+        define_arm_cp_regs(cpu, fpmr_reginfo);
+    }
 
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 8dc766d322..58f8dfd53c 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -960,6 +960,25 @@ static const VMStateDescription vmstate_syndrome64 = {
     },
 };
 
+static bool fpmr_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    return arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
+           && cpu_isar_feature(aa64_fpmr, cpu);
+}
+
+static const VMStateDescription vmstate_fpmr = {
+    .name = "cpu/fpmr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = fpmr_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.vfp.fpmr, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -1323,6 +1342,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_syndrome64,
         &vmstate_pstate64,
         &vmstate_event,
+        &vmstate_fpmr,
         NULL
     }
 };
-- 
2.43.0


