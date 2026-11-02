Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FFF606A332
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U7nxF/5B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDN-0003l3-O1; Mon, 02 Nov 2026 08:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD1-0003DW-Vh
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:28 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCz-0002IM-QM
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso13465195e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626580; x=1794231380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3ieBA+rn7xR1x+9btUnKk8ZMMGf9TpdgJKCoDLWHcRc=;
 b=U7nxF/5Bbe5oMqJ65cwHmyMeXAzL+Y+s2tGxVVol7LIw1iDusoSKZGr53vArmGZpQe
 MvjhH3iGUY3KQ8UWCYmX0Yiiuo44gaua63kPFuqGFjIqyAliS5KAyRTLokGrl+smXj2f
 HPuNWuFnYG8vSTsybQprCpwu8R3y9t8ZNtwxTPunTITtsQBJPSo+sRB6GYwm09/05dnU
 rMJ7OOR2keRDfUZw15l3IG+SRWhoXvBXH2Y4V3M0S5w6MAXhLimNkc1HvMyyw5oLr753
 DY5StaeKgmMLkf6/VKwS6eHcpsQT09pxP1vy9R+lBzaQQT93gGp7jKYNH9lUo1SCUbTb
 jCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626580; x=1794231380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3ieBA+rn7xR1x+9btUnKk8ZMMGf9TpdgJKCoDLWHcRc=;
 b=Rw6DDfptOVwebkxL5R86aWkTjbJHiBG3J/tfLahCRgLc69xQUU4wxYx6MDTINaDCqa
 1gB+SSBDAAUIgSUDFVkDvbqqZv21OdM+wsqXFbPFxLlSkS0FiSeVxJKRA4KHRC2mPndB
 As7vioQAsju9WE27I95ZvZIpRTzd1CsLtSyNn3Yvf3Gox3CNCKfO0kO3OJ4p8tQpsTAQ
 F/+thLjZ5UKxpiTHIQahmO4C1y5OYcQpjX0W0tZN27QfQa4rUYahrAN9NxzCKe26FA77
 Pv3OgAhK+EtaNrYgbXtH1AkR+2bQRrnI4W0Xp+Hq8AKGDqUqO9ONwXWamB8A00D4oE34
 9iLw==
X-Gm-Message-State: AFq9FYIIzav+lXObLo4XdPTylLgQD6XLEhbiaHMOUchCUUNDOerQ18ve
 n3F5mk9hqi9Vjkb/Gm5N1WAu9UWjZd8lQiqGr2K66CpAcQRAjFx5cjzbUP9F7cAMkTJJqhTKuG2
 M+HLfvx4=
X-Gm-Gg: AYBFou17NTcSqhJr5LAA0Kw1aptlnQGoAOJuV02p64QpPnbLkwz9EvxKVTxThpRiujP
 bhIA9m2dfS2sSuj4UIylBVEIfSwtvtR9PG9SFcRLmCgkf2S59Vy0aMsvg5Cftgf+OrclKmG/vMX
 FHYy4h3Gh/INQnKKHCt5XlQT8OC5SC3Ee73xkfIVOvaJQKUitILPLIvTXRcL0RYuRHH85+d+PmO
 sxrYYDa8yS0sHkvQoSTAx4KJzIZZNk5i7x1nOYksMBGc1A4EUWOzWQQeIp88mBd3xbYVrDS4Adn
 WYNSUtUMFy/PQ7Kq2RYgrN/A8Bx31VoJQpVrXmcWjtsXlLD37g205vk0rPOVU3MMcAm5aqJZ06d
 vwWebE6IragntLlUA0lvn33YBEUNFG7O6vrSH/mgJvRsH/xnjP6L/2C6t1+p3IJjp6N4XQ2gTRg
 +SMW1vlBFs4lKfjFGwkKH5BKT3GVg34sEdkfi79rPnqO+Tz4NEOizl6fj06tjKLXIZQBBnWLknb
 tATjfbKPZYqdUdPU6AoVRvRgNT06M9vvvH55KJhJw7nP8veVHFKhhdLMWDlgVuu94nUS1kgZvXR
 jh9mxZJ6F1adl/4opk2AeDIS/qX1hx0niXtW1f8G0r6md6W7OYCXtN9rjgTuLCS97lY8VEA/oAk
 AGGLDQzgErJUjbMYBcsHSdLVWuC+dfPiTLB0=
X-Received: by 2002:a05:600c:4e02:b0:4a1:e6a9:4086 with SMTP id
 5b1f17b1804b1-4ac1228b10amr244106145e9.0.1793626580276; 
 Mon, 02 Nov 2026 05:36:20 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/47] target/arm: Move REVIDR into isar.idregs[] storage
Date: Mon,  2 Nov 2026 13:35:27 +0000
Message-ID: <20261102133547.1375701-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Auger <eric.auger@redhat.com>

Move REVIDR into the isar.idregs[] array as other ID registers.
This will allow to overwrite it as others.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
Message-id: 20261030131406.461599-3-eric.auger@redhat.com
Suggested-by: Khushit Shah <khushit.shah@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  1 -
 target/arm/cpu-sysregs.h.inc |  1 +
 hw/intc/armv7m_nvic.c        |  2 +-
 target/arm/cpu-max.c         |  2 +-
 target/arm/cpu64.c           |  2 +-
 target/arm/helper.c          |  2 +-
 target/arm/tcg/cpu-v7m.c     |  4 ++--
 target/arm/tcg/cpu32.c       |  4 ++--
 target/arm/tcg/cpu64.c       | 20 ++++++++++----------
 9 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index add993ef101..c811369e63e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1126,7 +1126,6 @@ struct ArchCPU {
         uint64_t idregs[NUM_ID_IDX];
     } isar;
     uint64_t midr;
-    uint32_t revidr;
     uint32_t reset_fpsid;
     uint64_t ctr;
     uint32_t reset_sctlr;
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index b5c79709719..580d88d1f46 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -44,3 +44,4 @@ DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
 DEF(MVFR0_EL1, 3, 0, 0, 3, 0)
 DEF(MVFR1_EL1, 3, 0, 0, 3, 1)
 DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
+DEF(REVIDR_EL1, 3, 0, 0, 0, 6)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 6bc392b0e33..1f56fff046d 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1051,7 +1051,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (!arm_feature(&cpu->env, ARM_FEATURE_V8_1M)) {
             goto bad_offset;
         }
-        return cpu->revidr;
+        return GET_IDREG(isar, REVIDR);
     case 0xd00: /* CPUID Base.  */
         return cpu->midr;
     case 0xd04: /* Interrupt Control State (ICSR) */
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 2ed1cfef9be..b4e57a167de 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -37,7 +37,7 @@ void aarch64_aa32_a57_init(ARMCPU *cpu, bool aarch64_enabled)
         cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
     }
     cpu->midr = 0x411fd070;
-    cpu->revidr = 0x00000000;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->reset_fpsid = 0x41034070;
     cpu->isar.mvfr0 = 0x10110222;
     cpu->isar.mvfr1 = 0x12111111;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dcd0d698b30..80c9c9e5b35 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -717,7 +717,7 @@ static void aarch64_a53_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A53;
     cpu->midr = 0x410fd034;
-    cpu->revidr = 0x00000100;
+    SET_IDREG(isar, REVIDR, 0x00000100);
     cpu->reset_fpsid = 0x41034070;
     cpu->isar.mvfr0 = 0x10110222;
     cpu->isar.mvfr1 = 0x12111111;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b540705e638..8c783706265 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7453,7 +7453,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R,
               .accessfn = access_tid1,
               .fgt = FGT_REVIDR_EL1,
-              .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
+              .type = ARM_CP_CONST, .resetvalue = GET_IDREG(&cpu->isar, REVIDR) },
         };
         ARMCPRegInfo id_v8_midr_alias_cp_reginfo = {
             .name = "MIDR", .type = ARM_CP_ALIAS | ARM_CP_CONST | ARM_CP_NO_GDB,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 1093c6cbf63..9a5512aa555 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -211,7 +211,7 @@ static void cortex_m55_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x410fd221; /* r0p1 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
     /* These are the MVFR* values for the FPU + full MVE configuration */
@@ -249,7 +249,7 @@ static void cortex_m85_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x411fd231; /* r1p1 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
     /* These are the MVFR* values for the FPU + full MVE configuration */
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index f95051458df..c02b737fc00 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -456,7 +456,7 @@ static void cortex_a15_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     /* r4p0 cpu, not requiring expensive tlb flush errata */
     cpu->midr = 0x414fc0f0;
-    cpu->revidr = 0x0;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->reset_fpsid = 0x410430f0;
     cpu->isar.mvfr0 = 0x10110222;
     cpu->isar.mvfr1 = 0x11111111;
@@ -647,7 +647,7 @@ static void cortex_r52_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_AUXCR);
     cpu->midr = 0x411fd133; /* r1p3 */
-    cpu->revidr = 0x00000000;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->reset_fpsid = 0x41034023;
     cpu->isar.mvfr0 = 0x10110222;
     cpu->isar.mvfr1 = 0x12111111;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index c92e331e731..7af29978c61 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -48,7 +48,7 @@ static void aarch64_a35_initfn(Object *obj)
 
     /* From B2.2 AArch64 identification registers. */
     cpu->midr = 0x411fd040;
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->ctr = 0x84448004;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
@@ -248,7 +248,7 @@ static void aarch64_a55_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_PFR2, 0x00000011);
     cpu->midr = 0x412FD050;          /* r2p0 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
 
     /* From B2.23 CCSIDR_EL1 */
     /* 32KB L1 dcache */
@@ -292,7 +292,7 @@ static void aarch64_a72_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->midr = 0x410fd083;
-    cpu->revidr = 0x00000000;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->reset_fpsid = 0x41034080;
     cpu->isar.mvfr0 = 0x10110222;
     cpu->isar.mvfr1 = 0x12111111;
@@ -383,7 +383,7 @@ static void aarch64_a76_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_PFR2, 0x00000011);
     cpu->midr = 0x414fd0b1;          /* r4p1 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
 
     /* From B2.18 CCSIDR_EL1 */
     /* 64KB L1 dcache */
@@ -456,7 +456,7 @@ static void aarch64_a78ae_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_PFR2, 0x00000011);
     cpu->midr = 0x410fd423;          /* r0p3 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
 
     /* From 3.2.33 CCSIDR_EL1 */
     /* 64KB L1 dcache */
@@ -501,7 +501,7 @@ static void aarch64_a64fx_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->midr = 0x461f0010;
-    cpu->revidr = 0x00000000;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->ctr = 0x86668006;
     cpu->reset_sctlr = 0x30000180;
     SET_IDREG(isar, ID_AA64PFR0, 0x0000000101111111); /* No RAS Extensions */
@@ -707,7 +707,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_PFR2, 0x00000011);
     cpu->midr = 0x414fd0c1;          /* r4p1 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
 
     /* From B2.23 CCSIDR_EL1 */
     /* 64KB L1 dcache */
@@ -787,7 +787,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_PFR2, 0x00000011);
     cpu->midr = 0x411FD402;          /* r1p2 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
 
     /*
      * The Neoverse-V1 r1p2 TRM lists 32-bit format CCSIDR_EL1 values,
@@ -984,7 +984,7 @@ static void aarch64_a710_initfn(Object *obj)
 
     /* Ordered by Section B.4: AArch64 registers */
     cpu->midr          = 0x412FD471; /* r2p1 */
-    cpu->revidr        = 0;
+    SET_IDREG(isar, REVIDR, 0);
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_DFR0, 0x16011099);
@@ -1087,7 +1087,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
 
     /* Ordered by Section B.5: AArch64 ID registers */
     cpu->midr          = 0x410FD493; /* r0p3 */
-    cpu->revidr        = 0;
+    SET_IDREG(isar, REVIDR, 0);
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_DFR0, 0x16011099);
-- 
2.43.0


