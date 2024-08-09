Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986EDC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 16:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scS7C-0004Zb-4W; Fri, 09 Aug 2024 12:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scS6r-0004Jo-TQ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 12:05:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scS6i-0005we-FM
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 12:04:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4280bca3960so16591535e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723219479; x=1723824279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6uNVlQO8K4An76Q4uuZ4Ztx+HR9WdxxqMrewM/bpUk=;
 b=D3aRni4IRkhJJezfJ9B6I/Jeib4yZ861QnCwMyk5BmMmpUjoA70yI7TAAtWd0PYZpD
 +ZwmJLTRIcuu2OuBmiPr9IR/Bq9D9RmZOft2pnkO3UUbEIqSeiMcV4TaN7kJPOZnfyub
 8vYfXLW5MUWfOhEtwAzwEW+iG0xLk80RSVRjNMCT1FCQ61HwdbsEX9JW7r80SSWJBOTd
 1Mjk9H+ygbvaFQtZwwIKAZ4BmhOEgqceQOUKg+yqJiCDFgmBOo9Wq7yifGBCXJ/DT5UI
 SUwonlcRtWTYS94Yq96xJEPSp5wm1OqBSgzwlPUpaWyQBou7wtWCCefYuiV2JPjOYsbG
 +wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723219479; x=1723824279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6uNVlQO8K4An76Q4uuZ4Ztx+HR9WdxxqMrewM/bpUk=;
 b=UyoJ90j1zQHhPH0/pg3ZmN0ghn8FCAVF4JLFIifoHHRF/NZnaPUhGt0LzjnFK4eW+V
 TzOmfqFCaHfrOJw79Ag8wuhCQuFPyNJ45bg0kDFiZ5EYKl8+BzOq0FiG7Y5FDtuYjP3C
 GoYt3LlxiPO/KZJcEixswaikc15STA5lE/fyGzJ5VtpeQ0tsU7LgDj4AZxCou1wMvdif
 1xM6av26tDbdOqFLk5jfQbU9xX9gtyGPw1mSkZdyAqhv8lQpEryC9CJcy/Hz7Lx7uFAD
 Gke0BTiulBDgW+TmkhhmVJKfjgH/7IOP3fybHoHBxeLeswnEhp351+ftb3/iX55hl0eZ
 i3iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSY0G5XXpcFWSnWFbyECRbaMr42apYoTnyuBSjcZcSiqYzzWb3ax+suuz7L/hILdfeqpaviHub6u1J/myEGGKMXwR6GU4=
X-Gm-Message-State: AOJu0Yw/HLEm0wKK4PX2kicjKVeQsscniiFG4KfqrtAq0WFOLdaOo0Iz
 5sxmUFxveycQcauVIFp/+SZ1iojaebL3O6DTtSdx1Tn1IeUBFh95U02TwB/eTAhAl1H+HCLUlKg
 t
X-Google-Smtp-Source: AGHT+IE54B5HI1u9ohfsQwbhZVY6XiCzHO9m6MkZLzN91PpnSKM5o/X9BsUGF/lmokOzArx+Xed9eQ==
X-Received: by 2002:a05:600c:4ed0:b0:427:985b:178b with SMTP id
 5b1f17b1804b1-429c3a22f59mr11733015e9.16.1723219478962; 
 Fri, 09 Aug 2024 09:04:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429059714d5sm135171295e9.13.2024.08.09.09.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 09:04:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/2] target/arm: Fix usage of MMU indexes when EL3 is AArch32
Date: Fri,  9 Aug 2024 17:04:30 +0100
Message-Id: <20240809160430.1144805-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809160430.1144805-1-peter.maydell@linaro.org>
References: <20240809160430.1144805-1-peter.maydell@linaro.org>
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

Our current usage of MMU indexes when EL3 is AArch32 is confused.
Architecturally, when EL3 is AArch32, all Secure code runs under the
Secure PL1&0 translation regime:
 * code at EL3, which might be Mon, or SVC, or any of the
   other privileged modes (PL1)
 * code at EL0 (Secure PL0)

This is different from when EL3 is AArch64, in which case EL3 is its
own translation regime, and EL1 and EL0 (whether AArch32 or AArch64)
have their own regime.

We claimed to be mapping Secure PL1 to our ARMMMUIdx_EL3, but didn't
do anything special about Secure PL0, which meant it used the same
ARMMMUIdx_EL10_0 that NonSecure PL0 does.  This resulted in a bug
where arm_sctlr() incorrectly picked the NonSecure SCTLR as the
controlling register when in Secure PL0, which meant we were
spuriously generating alignment faults because we were looking at the
wrong SCTLR control bits.

The use of ARMMMUIdx_EL3 for Secure PL1 also resulted in the bug that
we wouldn't honour the PAN bit for Secure PL1, because there's no
equivalent _PAN mmu index for it.

We could fix this in one of two ways:
 * The most straightforward is to add new MMU indexes EL30_0,
   EL30_3, EL30_3_PAN to correspond to "Secure PL1&0 at PL0",
   "Secure PL1&0 at PL1", and "Secure PL1&0 at PL1 with PAN".
   This matches how we use indexes for the AArch64 regimes, and
   preserves propirties like being able to determine the privilege
   level from an MMU index without any other information. However
   it would add two MMU indexes (we can share one with ARMMMUIdx_EL3),
   and we are already using 14 of the 16 the core TLB code permits.

 * The more complicated approach is the one we take here. We use
   the same MMU indexes (E10_0, E10_1, E10_1_PAN) for Secure PL1&0
   than we do for NonSecure PL1&0. This saves on MMU indexes, but
   means we need to check in some places whether we're in the
   Secure PL1&0 regime or not before we interpret an MMU index.

The changes in this commit were created by auditing all the places
where we use specific ARMMMUIdx_ values, and checking whether they
needed to be changed to handle the new index value usage.

Note for potential stable backports: taking also the previous
(comment-change-only) commit might make the backport easier.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2326
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This fixes the bug with the repro case in the bug report, and it
also passes "make check", but I don't have a huge range of
Secure AArch32 test images to test with. I guess it ought to go
into 9.1 as a bugfix, but the nature of the patch means it's
not very easy to be confident it doesn't introduce any new bugs...
---
 target/arm/cpu.h               | 31 ++++++++++++++++++-------------
 target/arm/internals.h         | 27 +++++++++++++++++++++++----
 target/arm/tcg/translate.h     |  2 ++
 target/arm/helper.c            | 34 +++++++++++++++++++++++-----------
 target/arm/ptw.c               |  6 +++++-
 target/arm/tcg/hflags.c        |  4 ++++
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  9 +++++----
 8 files changed, 81 insertions(+), 34 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 216774f5d3a..9a3fd595621 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2784,8 +2784,7 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *  + NonSecure PL1 & 0 stage 1
  *  + NonSecure PL1 & 0 stage 2
  *  + NonSecure PL2
- *  + Secure PL0
- *  + Secure PL1
+ *  + Secure PL1 & 0
  * (reminder: for 32 bit EL3, Secure PL1 is *EL3*, not EL1.)
  *
  * For QEMU, an mmu_idx is not quite the same as a translation regime because:
@@ -2803,37 +2802,39 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *     The only use of stage 2 translations is either as part of an s1+2
  *     lookup or when loading the descriptors during a stage 1 page table walk,
  *     and in both those cases we don't use the TLB.
- *  4. we can also safely fold together the "32 bit EL3" and "64 bit EL3"
- *     translation regimes, because they map reasonably well to each other
- *     and they can't both be active at the same time.
- *  5. we want to be able to use the TLB for accesses done as part of a
+ *  4. we want to be able to use the TLB for accesses done as part of a
  *     stage1 page table walk, rather than having to walk the stage2 page
  *     table over and over.
- *  6. we need separate EL1/EL2 mmu_idx for handling the Privileged Access
+ *  5. we need separate EL1/EL2 mmu_idx for handling the Privileged Access
  *     Never (PAN) bit within PSTATE.
- *  7. we fold together most secure and non-secure regimes for A-profile,
+ *  6. we fold together most secure and non-secure regimes for A-profile,
  *     because there are no banked system registers for aarch64, so the
  *     process of switching between secure and non-secure is
  *     already heavyweight.
- *  8. we cannot fold together Stage 2 Secure and Stage 2 NonSecure,
+ *  7. we cannot fold together Stage 2 Secure and Stage 2 NonSecure,
  *     because both are in use simultaneously for Secure EL2.
  *
  * This gives us the following list of cases:
  *
- * EL0 EL1&0 stage 1+2 (aka NS PL0)
- * EL1 EL1&0 stage 1+2 (aka NS PL1)
- * EL1 EL1&0 stage 1+2 +PAN
+ * EL0 EL1&0 stage 1+2 (or AArch32 PL0 PL1&0 stage 1+2)
+ * EL1 EL1&0 stage 1+2 (or AArch32 PL1 PL1&0 stage 1+2)
+ * EL1 EL1&0 stage 1+2 +PAN (or AArch32 PL1 PL1&0 stage 1+2 +PAN)
  * EL0 EL2&0
  * EL2 EL2&0
  * EL2 EL2&0 +PAN
  * EL2 (aka NS PL2)
- * EL3 (aka S PL1)
+ * EL3 (not used when EL3 is AArch32)
  * Stage2 Secure
  * Stage2 NonSecure
  * plus one TLB per Physical address space: S, NS, Realm, Root
  *
  * for a total of 14 different mmu_idx.
  *
+ * Note that when EL3 is AArch32, the usage is potentially confusing
+ * because the MMU indexes are named for their AArch64 use, so code
+ * using the ARMMMUIdx_E10_1 might be at EL3, not EL1. This is because
+ * Secure PL1 is always at EL3.
+ *
  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish EL0 and EL1 (and
  * EL2 for cores like the Cortex-R52).
@@ -3126,6 +3127,10 @@ FIELD(TBFLAG_A32, NS, 10, 1)
  * This requires an SME trap from AArch32 mode when using NEON.
  */
 FIELD(TBFLAG_A32, SME_TRAP_NONSTREAMING, 11, 1)
+/*
+ * Indicates whether we are in the Secure PL1&0 translation regime
+ */
+FIELD(TBFLAG_A32, S_PL1_0, 12, 1)
 
 /*
  * Bit usage when in AArch32 state, for M-profile only.
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 757b1fae925..203a2dae148 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -275,6 +275,20 @@ FIELD(CNTHCTL, CNTPMASK, 19, 1)
 #define M_FAKE_FSR_NSC_EXEC 0xf /* NS executing in S&NSC memory */
 #define M_FAKE_FSR_SFAULT 0xe /* SecureFault INVTRAN, INVEP or AUVIOL */
 
+/**
+ * arm_aa32_secure_pl1_0(): Return true if in Secure PL1&0 regime
+ *
+ * Return true if the CPU is in the Secure PL1&0 translation regime.
+ * This requires that EL3 exists and is AArch32 and we are currently
+ * Secure. If this is the case then the ARMMMUIdx_E10* apply and
+ * mean we are in EL3, not EL1.
+ */
+static inline bool arm_aa32_secure_pl1_0(CPUARMState *env)
+{
+    return arm_feature(env, ARM_FEATURE_EL3) &&
+        !arm_el_is_aa64(env, 3) && arm_is_secure(env);
+}
+
 /**
  * raise_exception: Raise the specified exception.
  * Raise a guest exception with the specified value, syndrome register
@@ -808,7 +822,12 @@ static inline ARMMMUIdx core_to_aa64_mmu_idx(int mmu_idx)
     return mmu_idx | ARM_MMU_IDX_A;
 }
 
-int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx);
+/**
+ * Return the exception level we're running at if our current MMU index
+ * is @mmu_idx. @s_pl1_0 should be true if this is the AArch32
+ * Secure PL1&0 translation regime.
+ */
+int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx, bool s_pl1_0);
 
 /* Return the MMU index for a v7M CPU in the specified security state */
 ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
@@ -903,11 +922,11 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
         return 3;
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_Stage1_E0:
-        return arm_el_is_aa64(env, 3) || !arm_is_secure_below_el3(env) ? 1 : 3;
-    case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
+    case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
+        return arm_el_is_aa64(env, 3) || !arm_is_secure_below_el3(env) ? 1 : 3;
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a8672c857c1..927f534fa4b 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -167,6 +167,8 @@ typedef struct DisasContext {
     bool guarded_page;
     /* True if the current insn_start has been updated. */
     bool insn_start_updated;
+    /* True if this is the AArch32 Secure PL1&0 translation regime */
+    bool s_pl1_0;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
     int c15_cpar;
     /* Offset from VNCR_EL2 when FEAT_NV2 redirects this reg to memory */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8fb4b474e83..0a582c1cd3b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3700,7 +3700,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
          */
         format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
 
-        if (arm_feature(env, ARM_FEATURE_EL2)) {
+        if (arm_feature(env, ARM_FEATURE_EL2) && !arm_aa32_secure_pl1_0(env)) {
             if (mmu_idx == ARMMMUIdx_E10_0 ||
                 mmu_idx == ARMMMUIdx_E10_1 ||
                 mmu_idx == ARMMMUIdx_E10_1_PAN) {
@@ -3774,13 +3774,11 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     case 0:
         /* stage 1 current state PL1: ATS1CPR, ATS1CPW, ATS1CPRP, ATS1CPWP */
         switch (el) {
-        case 3:
-            mmu_idx = ARMMMUIdx_E3;
-            break;
         case 2:
             g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
             /* fall through */
         case 1:
+        case 3:
             if (ri->crm == 9 && arm_pan_enabled(env)) {
                 mmu_idx = ARMMMUIdx_Stage1_E1_PAN;
             } else {
@@ -11861,8 +11859,11 @@ void arm_cpu_do_interrupt(CPUState *cs)
 
 uint64_t arm_sctlr(CPUARMState *env, int el)
 {
-    /* Only EL0 needs to be adjusted for EL1&0 or EL2&0. */
-    if (el == 0) {
+    if (arm_aa32_secure_pl1_0(env)) {
+        /* In Secure PL1&0 SCTLR_S is always controlling */
+        el = 3;
+    } else if (el == 0) {
+        /* Only EL0 needs to be adjusted for EL1&0 or EL2&0. */
         ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, 0);
         el = mmu_idx == ARMMMUIdx_E20_0 ? 2 : 1;
     }
@@ -12522,8 +12523,12 @@ int fp_exception_el(CPUARMState *env, int cur_el)
     return 0;
 }
 
-/* Return the exception level we're running at if this is our mmu_idx */
-int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
+/*
+ * Return the exception level we're running at if this is our mmu_idx.
+ * s_pl1_0 should be true if this is the AArch32 Secure PL1&0 translation
+ * regime.
+ */
+int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx, bool s_pl1_0)
 {
     if (mmu_idx & ARM_MMU_IDX_M) {
         return mmu_idx & ARM_MMU_IDX_M_PRIV;
@@ -12535,7 +12540,7 @@ int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
         return 0;
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
-        return 1;
+        return s_pl1_0 ? 3 : 1;
     case ARMMMUIdx_E2:
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
@@ -12573,6 +12578,15 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
             idx = ARMMMUIdx_E10_0;
         }
         break;
+    case 3:
+        /*
+         * AArch64 EL3 has its own translation regime; AArch32 EL3
+         * uses the Secure PL1&0 translation regime.
+         */
+        if (arm_el_is_aa64(env, 3)) {
+            return ARMMMUIdx_E3;
+        }
+        /* fall through */
     case 1:
         if (arm_pan_enabled(env)) {
             idx = ARMMMUIdx_E10_1_PAN;
@@ -12592,8 +12606,6 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
             idx = ARMMMUIdx_E2;
         }
         break;
-    case 3:
-        return ARMMMUIdx_E3;
     default:
         g_assert_not_reached();
     }
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 4476b32ff50..278004661bf 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3576,7 +3576,11 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E2:
-        ss = arm_security_space_below_el3(env);
+        if (arm_aa32_secure_pl1_0(env)) {
+            ss = ARMSS_Secure;
+        } else {
+            ss = arm_security_space_below_el3(env);
+        }
         break;
     case ARMMMUIdx_Stage2:
         /*
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index f03977b4b00..bab7822ef66 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -198,6 +198,10 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
         DP_TBFLAG_A32(flags, SME_TRAP_NONSTREAMING, 1);
     }
 
+    if (arm_aa32_secure_pl1_0(env)) {
+        DP_TBFLAG_A32(flags, S_PL1_0, 1);
+    }
+
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 148be2826ec..bffc2c45adf 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -12002,7 +12002,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->tbii = EX_TBFLAG_A64(tb_flags, TBII);
     dc->tbid = EX_TBFLAG_A64(tb_flags, TBID);
     dc->tcma = EX_TBFLAG_A64(tb_flags, TCMA);
-    dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
+    dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx, false);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
 #endif
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c5bc691d92b..e2748ff2bb8 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7546,10 +7546,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     core_mmu_idx = EX_TBFLAG_ANY(tb_flags, MMUIDX);
     dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
-    dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
-#if !defined(CONFIG_USER_ONLY)
-    dc->user = (dc->current_el == 0);
-#endif
     dc->fp_excp_el = EX_TBFLAG_ANY(tb_flags, FPEXC_EL);
     dc->align_mem = EX_TBFLAG_ANY(tb_flags, ALIGN_MEM);
     dc->pstate_il = EX_TBFLAG_ANY(tb_flags, PSTATE__IL);
@@ -7580,7 +7576,12 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         }
         dc->sme_trap_nonstreaming =
             EX_TBFLAG_A32(tb_flags, SME_TRAP_NONSTREAMING);
+        dc->s_pl1_0 = EX_TBFLAG_A32(tb_flags, S_PL1_0);
     }
+    dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx, dc->s_pl1_0);
+#if !defined(CONFIG_USER_ONLY)
+    dc->user = (dc->current_el == 0);
+#endif
     dc->lse2 = false; /* applies only to aarch64 */
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
-- 
2.34.1


