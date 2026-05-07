Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814B9CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OK-0000Fy-QB; Thu, 07 May 2026 19:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OI-0000Cd-39
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:26 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OG-00010o-Ar
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:25 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7de46b8e432so1308061a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197463; x=1778802263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1VZFehutszRylMZ00j2dss6V52WWHugec2ZAPoOXzw=;
 b=SJtK7+3+WS+DJum3wWwxHRb8cuFeINXeeob09Y2O/rHagTeD9jIAyYzVTleWMQbzzJ
 DxfaoWQSfiq/zFQf+8KWItUE4hcnEv1qAjJiE/dADMpSl9nr1OxVFLeqOz6cCT80c2ev
 9YHJmLXif1U/7LWO++KApqm5OL7d8MYWcQ1s5wd+t7snSKyJYifQSk36/V7IhEeXao4c
 EaVh2XyqbGJWwuCJDwvZ/Nw2p8yP1+XebksE/bbCiYHPD8TIbiTX8Ju5/r2HdljUROHy
 aHcMOrcxz9MxZa7iFACKTMws9d2ZAxkFvdDE0EA4EpscxzpYCidYYHq8eUA3U+w2mDwy
 GJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197463; x=1778802263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z1VZFehutszRylMZ00j2dss6V52WWHugec2ZAPoOXzw=;
 b=g3U9kWRJVaU3+iX1Zd0u1LtxagJesJYTn4GOmwE+K5WNndenTx6v43cXeRAKOvmIUq
 nc5MZt90j0o8CkXsPWrg6IOIaxguDjC/9oImV/ixNfggJy5uAqIH0cI1ySkaiOiaADP8
 3Iz8eP3YYC1JPulJWmR5oP0gtLh44EdidqpcmkUAJJBXZtgulaWlFMXpQBEAPR66P19B
 h4gYozG0ay9BAYqdcN/pjbXHLy9usRUtW1yoHoHc8e8BXd4QoRIvDHULTfc8bitn7dhZ
 PLz2bKgmzdWM88EKuBw1vShgaVeNqvWUk+DWVUPPuXWCAmU97bYbqU5dZ6VT4Iln8e4h
 8w8A==
X-Gm-Message-State: AOJu0Yxq0Sq211eTUsuUtwV9wgyw2Rf/WrXtzH4pSUpstpFCoC53tB6J
 jFqGOqEeq+LkiVkyvYqA9Eye/lRnBPeABIeFpOGNsvJBRi8C6x2jE4JSvmxZP8m0AL4wqPAT1ME
 7e4BA
X-Gm-Gg: AeBDietZbn7XQnaU0OrQvK3ryp9WHwVZsXiUZ3WZAGW6j2eWr1bedEsogWgzfZZRYTH
 lf0Rl+jSaeg/1BgY8FQojbV01JaOlRWPc2cG+zPXcXWvEcCeDTnvy+M3nHkYHXHBRqwM1Vju43V
 c5CeDcSejh4bmd25VXXiuBmpzKhiL9oBx6jZod5MXuqjJB9lvzt/ICUWTPsrHMUQmaI+/pvY00U
 RRk3ObNTAApBB8N2Nqq958Q12wAihWlhaJAZzQC/2T7AGGb8uJ+m/b5oAOI7YbiBJga4T2U2Xmu
 PJWjxV4nYM2aTGNnvdI2jjjbuAdw5cYbqIyh+PQLYx5Da5tyuSCmJKW57Oy7ETc/7Iregauo1wR
 vVsjnZQqYgC3SK/WVxz0g4UX67JW6UVgQ0g8lMV4hSBV3nOmI3DFEc2vW4SlmVZe0VvCnlfQfZX
 Xi29sPWTv0cy7MNKv+vJtx8c0R+YI/srxtNyAqiY2Qud3GtQ==
X-Received: by 2002:a05:6830:608c:b0:7df:5fc:3fd8 with SMTP id
 46e09a7af769-7e1dee91018mr6345297a34.1.1778197463081; 
 Thu, 07 May 2026 16:44:23 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 08/60] target/arm: Introduce FPMR
Date: Thu,  7 May 2026 18:43:21 -0500
Message-ID: <20260507234413.643512-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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
 target/arm/internals.h    |  9 +++++++++
 target/arm/helper.c       | 12 +++++++++++-
 target/arm/machine.c      | 20 ++++++++++++++++++++
 6 files changed, 51 insertions(+), 1 deletion(-)

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
index 4ce661d7fe..4ab2a51c99 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1186,6 +1186,11 @@ static inline bool isar_feature_aa64_gcs(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, GCS) != 0;
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
index aeba70e6fc..c6f1f1a688 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -691,6 +691,7 @@ typedef struct CPUArchState {
          */
         uint64_t fpsr;
         uint64_t fpcr;
+        uint64_t fpmr;
 
         uint32_t xregs[16];
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6376ae1ca3..08024943c3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -292,6 +292,15 @@ FIELD(CNTHCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
+FIELD(FPMR, F8S1, 0, 3)
+FIELD(FPMR, F8S2, 3, 3)
+FIELD(FPMR, F8D, 6, 3)
+FIELD(FPMR, OSM, 14, 1)
+FIELD(FPMR, OSC, 15, 1)
+FIELD(FPMR, LSCALE, 16, 7)
+FIELD(FPMR, NSCALE, 24, 8)
+FIELD(FPMR, LSCALE2, 32, 6)
+
 /* We use a few fake FSR values for internal purposes in M profile.
  * M profile cores don't have A/R format FSRs, but currently our
  * get_phys_addr() code assumes A/R profile and reports failures via
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 66813bb298..304db1a479 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6209,6 +6209,14 @@ static const ARMCPRegInfo aie_reginfo[] = {
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
@@ -7481,10 +7489,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


