Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D0CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jHa-0001tq-KQ; Fri, 03 Oct 2025 13:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHU-0001qu-To
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:21 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGY-0006Gl-Qi
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-781db5068b8so2153540b3a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511296; x=1760116096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zc8jXlA2PK89Xi/og9uN7d8mePx/VFSa/jXLJK7i0J4=;
 b=Nv1zd/DA9b+ddpgbEowebdrAKpWCNZipHCP8jFgzacoaiJW722nWp9EbsKUiAGClo+
 Mko3moiJCZcYJ2V/egYh5+8xhVWqZ66ffWkXNZdXUpEeviYgnnmOMGHQ5qb+/Ae42xug
 LnfVC5mtOcQF2IoGg0eRzRHJKOO3VfLNjtnVzlEH2s7CqqOQD4ZayDCEhp7/5pJygHiK
 51qr0ammqZmNtTN0xGCnqmQ+t8F6CcbiKaSGoqA8U1mc4AYfwAw76IRJw0etYHVkCi7h
 kNYSfoUAt0N0WgDAnZ+CumUOM4ssbKB2HG95HeKcgYXhcVOfNxT32+9Z6mX3u8ue8N6v
 ad5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511296; x=1760116096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zc8jXlA2PK89Xi/og9uN7d8mePx/VFSa/jXLJK7i0J4=;
 b=BZDeHrpxW4c8z0XywfiMD2QHJxXH+WyIqWxcmtgNulj1p8c3eikNywWUWlR1tfgfBB
 rDLuq3p8SLqrUxNcc5PFv/c69/04b5M8jESz5qTjh4xpd4xPPvrl/G44dtRRt2a8YMuz
 aRuLBxkX/NytFEMPHHW8nf7XJmIO1oOduPrY4sPXG9XOxvsouLGCzD8yI0dtCf+aqWUN
 mvGsAWKkmLdL5rYvvvEiJtjIHYXhA2l5ZlsYefClrgc8l+Bz94clqP8t7CU05YwhnYgF
 BFQotXeHLENRAI+g+Ua9DaB3+w9KfhxmYxdBQFQzM1vyg9WO3oXDVzM9gyxTj2Gya4k6
 bdwA==
X-Gm-Message-State: AOJu0YyYLnxxo8xzofECV5S6t+xrM+oFy9N3K8Z8IdZ6r3UEC1igoTMg
 +7Zlc1IL+klmby/3LruGL64DdoPODaZCeyC+KeihTJx3Hn0RL5AA2mmbb0KAIDpL25Q11qVvlEg
 R96m61hs=
X-Gm-Gg: ASbGnctebBZHSFKwIZDwqOJMNnY60XfIW397gA5AhKnieZv9lfJz8YF86XRw1ZVxjAc
 6UhPHmV2Yq6UE4F1YzCAexsV/3yicQz/g7KHwUKjl2EbbC/k5XpCOGf8a6RXNU71pjoevoxMWPy
 MxYOpSUc5vaW7TLrt72j0kK/ov0lzEawMYe6RjK7y5133/HOI+sjn2hN8vk/u1g4nf1wAWx97fa
 IY6MghTnUhbU5+y1sTEFPUoVR3xJmjx2eAWSzY61SWxhfJ/ZBmT3THdgFBqjsWH9C9TluLB43N6
 v8Dgvie9IGBlIZDwkdPnHmUuluARQYFgUEvzjdtEYbMfZOeCkOT1UC/fzH1/LJ3lHnMJx4qZNur
 ecQKWPh1eubr+61+6dJPwdVY3xIbgWVLDxSmxXQAtMz1PnQiku81pDibK
X-Google-Smtp-Source: AGHT+IH7GT4zqm+lTn/SQ1ZUyGTV6+6hSB2BdDyoVpQmH9dPfiDtmdsLuhFT6973CISjDTz9lE7Ujg==
X-Received: by 2002:a17:902:dad0:b0:261:1521:17a8 with SMTP id
 d9443c01a7336-28e9a565b4emr49223375ad.16.1759511296086; 
 Fri, 03 Oct 2025 10:08:16 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 16/73] target/arm: Split out mmuidx.h from cpu.h
Date: Fri,  3 Oct 2025 10:07:03 -0700
Message-ID: <20251003170800.997167-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 207 +-----------------------------------------
 target/arm/mmuidx.h | 216 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 217 insertions(+), 206 deletions(-)
 create mode 100644 target/arm/mmuidx.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index eef4ae62ac..5866d55ee4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -33,6 +33,7 @@
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 #include "target/arm/cpu-sysregs.h"
+#include "target/arm/mmuidx.h"
 
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
@@ -2295,212 +2296,6 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
 
 #define TYPE_ARM_HOST_CPU "host-" TYPE_ARM_CPU
 
-/* ARM has the following "translation regimes" (as the ARM ARM calls them):
- *
- * If EL3 is 64-bit:
- *  + NonSecure EL1 & 0 stage 1
- *  + NonSecure EL1 & 0 stage 2
- *  + NonSecure EL2
- *  + NonSecure EL2 & 0   (ARMv8.1-VHE)
- *  + Secure EL1 & 0 stage 1
- *  + Secure EL1 & 0 stage 2 (FEAT_SEL2)
- *  + Secure EL2 (FEAT_SEL2)
- *  + Secure EL2 & 0 (FEAT_SEL2)
- *  + Realm EL1 & 0 stage 1 (FEAT_RME)
- *  + Realm EL1 & 0 stage 2 (FEAT_RME)
- *  + Realm EL2 (FEAT_RME)
- *  + EL3
- * If EL3 is 32-bit:
- *  + NonSecure PL1 & 0 stage 1
- *  + NonSecure PL1 & 0 stage 2
- *  + NonSecure PL2
- *  + Secure PL1 & 0
- * (reminder: for 32 bit EL3, Secure PL1 is *EL3*, not EL1.)
- *
- * For QEMU, an mmu_idx is not quite the same as a translation regime because:
- *  1. we need to split the "EL1 & 0" and "EL2 & 0" regimes into two mmu_idxes,
- *     because they may differ in access permissions even if the VA->PA map is
- *     the same
- *  2. we want to cache in our TLB the full VA->IPA->PA lookup for a stage 1+2
- *     translation, which means that we have one mmu_idx that deals with two
- *     concatenated translation regimes [this sort of combined s1+2 TLB is
- *     architecturally permitted]
- *  3. we don't need to allocate an mmu_idx to translations that we won't be
- *     handling via the TLB. The only way to do a stage 1 translation without
- *     the immediate stage 2 translation is via the ATS or AT system insns,
- *     which can be slow-pathed and always do a page table walk.
- *     The only use of stage 2 translations is either as part of an s1+2
- *     lookup or when loading the descriptors during a stage 1 page table walk,
- *     and in both those cases we don't use the TLB.
- *  4. we can also safely fold together the "32 bit EL3" and "64 bit EL3"
- *     translation regimes, because they map reasonably well to each other
- *     and they can't both be active at the same time.
- *  5. we want to be able to use the TLB for accesses done as part of a
- *     stage1 page table walk, rather than having to walk the stage2 page
- *     table over and over.
- *  6. we need separate EL1/EL2 mmu_idx for handling the Privileged Access
- *     Never (PAN) bit within PSTATE.
- *  7. we fold together most secure and non-secure regimes for A-profile,
- *     because there are no banked system registers for aarch64, so the
- *     process of switching between secure and non-secure is
- *     already heavyweight.
- *  8. we cannot fold together Stage 2 Secure and Stage 2 NonSecure,
- *     because both are in use simultaneously for Secure EL2.
- *
- * This gives us the following list of cases:
- *
- * EL0 EL1&0 stage 1+2 (aka NS PL0 PL1&0 stage 1+2)
- * EL1 EL1&0 stage 1+2 (aka NS PL1 PL1&0 stage 1+2)
- * EL1 EL1&0 stage 1+2 +PAN (aka NS PL1 P1&0 stage 1+2 +PAN)
- * EL0 EL2&0
- * EL2 EL2&0
- * EL2 EL2&0 +PAN
- * EL2 (aka NS PL2)
- * EL3 (aka AArch32 S PL1 PL1&0)
- * AArch32 S PL0 PL1&0 (we call this EL30_0)
- * AArch32 S PL1 PL1&0 +PAN (we call this EL30_3_PAN)
- * Stage2 Secure
- * Stage2 NonSecure
- * plus one TLB per Physical address space: S, NS, Realm, Root
- *
- * for a total of 16 different mmu_idx.
- *
- * R profile CPUs have an MPU, but can use the same set of MMU indexes
- * as A profile. They only need to distinguish EL0 and EL1 (and
- * EL2 for cores like the Cortex-R52).
- *
- * M profile CPUs are rather different as they do not have a true MMU.
- * They have the following different MMU indexes:
- *  User
- *  Privileged
- *  User, execution priority negative (ie the MPU HFNMIENA bit may apply)
- *  Privileged, execution priority negative (ditto)
- * If the CPU supports the v8M Security Extension then there are also:
- *  Secure User
- *  Secure Privileged
- *  Secure User, execution priority negative
- *  Secure Privileged, execution priority negative
- *
- * The ARMMMUIdx and the mmu index value used by the core QEMU TLB code
- * are not quite the same -- different CPU types (most notably M profile
- * vs A/R profile) would like to use MMU indexes with different semantics,
- * but since we don't ever need to use all of those in a single CPU we
- * can avoid having to set NB_MMU_MODES to "total number of A profile MMU
- * modes + total number of M profile MMU modes". The lower bits of
- * ARMMMUIdx are the core TLB mmu index, and the higher bits are always
- * the same for any particular CPU.
- * Variables of type ARMMUIdx are always full values, and the core
- * index values are in variables of type 'int'.
- *
- * Our enumeration includes at the end some entries which are not "true"
- * mmu_idx values in that they don't have corresponding TLBs and are only
- * valid for doing slow path page table walks.
- *
- * The constant names here are patterned after the general style of the names
- * of the AT/ATS operations.
- * The values used are carefully arranged to make mmu_idx => EL lookup easy.
- * For M profile we arrange them to have a bit for priv, a bit for negpri
- * and a bit for secure.
- */
-#define ARM_MMU_IDX_A     0x10  /* A profile */
-#define ARM_MMU_IDX_NOTLB 0x20  /* does not have a TLB */
-#define ARM_MMU_IDX_M     0x40  /* M profile */
-
-/* Meanings of the bits for M profile mmu idx values */
-#define ARM_MMU_IDX_M_PRIV   0x1
-#define ARM_MMU_IDX_M_NEGPRI 0x2
-#define ARM_MMU_IDX_M_S      0x4  /* Secure */
-
-#define ARM_MMU_IDX_TYPE_MASK \
-    (ARM_MMU_IDX_A | ARM_MMU_IDX_M | ARM_MMU_IDX_NOTLB)
-#define ARM_MMU_IDX_COREIDX_MASK 0xf
-
-typedef enum ARMMMUIdx {
-    /*
-     * A-profile.
-     */
-    ARMMMUIdx_E10_0     = 0 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_0     = 1 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E10_1     = 2 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_2     = 3 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E10_1_PAN = 4 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_2_PAN = 5 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E2        = 6 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E3        = 7 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E30_0     = 8 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E30_3_PAN = 9 | ARM_MMU_IDX_A,
-
-    /*
-     * Used for second stage of an S12 page table walk, or for descriptor
-     * loads during first stage of an S1 page table walk.  Note that both
-     * are in use simultaneously for SecureEL2: the security state for
-     * the S2 ptw is selected by the NS bit from the S1 ptw.
-     */
-    ARMMMUIdx_Stage2_S  = 10 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Stage2    = 11 | ARM_MMU_IDX_A,
-
-    /* TLBs with 1-1 mapping to the physical address spaces. */
-    ARMMMUIdx_Phys_S     = 12 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Phys_NS    = 13 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Phys_Root  = 14 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Phys_Realm = 15 | ARM_MMU_IDX_A,
-
-    /*
-     * These are not allocated TLBs and are used only for AT system
-     * instructions or for the first stage of an S12 page table walk.
-     */
-    ARMMMUIdx_Stage1_E0 = 0 | ARM_MMU_IDX_NOTLB,
-    ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
-    ARMMMUIdx_Stage1_E1_PAN = 2 | ARM_MMU_IDX_NOTLB,
-
-    /*
-     * M-profile.
-     */
-    ARMMMUIdx_MUser = ARM_MMU_IDX_M,
-    ARMMMUIdx_MPriv = ARM_MMU_IDX_M | ARM_MMU_IDX_M_PRIV,
-    ARMMMUIdx_MUserNegPri = ARMMMUIdx_MUser | ARM_MMU_IDX_M_NEGPRI,
-    ARMMMUIdx_MPrivNegPri = ARMMMUIdx_MPriv | ARM_MMU_IDX_M_NEGPRI,
-    ARMMMUIdx_MSUser = ARMMMUIdx_MUser | ARM_MMU_IDX_M_S,
-    ARMMMUIdx_MSPriv = ARMMMUIdx_MPriv | ARM_MMU_IDX_M_S,
-    ARMMMUIdx_MSUserNegPri = ARMMMUIdx_MUserNegPri | ARM_MMU_IDX_M_S,
-    ARMMMUIdx_MSPrivNegPri = ARMMMUIdx_MPrivNegPri | ARM_MMU_IDX_M_S,
-} ARMMMUIdx;
-
-/*
- * Bit macros for the core-mmu-index values for each index,
- * for use when calling tlb_flush_by_mmuidx() and friends.
- */
-#define TO_CORE_BIT(NAME) \
-    ARMMMUIdxBit_##NAME = 1 << (ARMMMUIdx_##NAME & ARM_MMU_IDX_COREIDX_MASK)
-
-typedef enum ARMMMUIdxBit {
-    TO_CORE_BIT(E10_0),
-    TO_CORE_BIT(E20_0),
-    TO_CORE_BIT(E10_1),
-    TO_CORE_BIT(E10_1_PAN),
-    TO_CORE_BIT(E2),
-    TO_CORE_BIT(E20_2),
-    TO_CORE_BIT(E20_2_PAN),
-    TO_CORE_BIT(E3),
-    TO_CORE_BIT(E30_0),
-    TO_CORE_BIT(E30_3_PAN),
-    TO_CORE_BIT(Stage2),
-    TO_CORE_BIT(Stage2_S),
-
-    TO_CORE_BIT(MUser),
-    TO_CORE_BIT(MPriv),
-    TO_CORE_BIT(MUserNegPri),
-    TO_CORE_BIT(MPrivNegPri),
-    TO_CORE_BIT(MSUser),
-    TO_CORE_BIT(MSPriv),
-    TO_CORE_BIT(MSUserNegPri),
-    TO_CORE_BIT(MSPrivNegPri),
-} ARMMMUIdxBit;
-
-#undef TO_CORE_BIT
-
-#define MMU_USER_IDX 0
-
 /* Indexes used when registering address spaces with cpu_address_space_init */
 typedef enum ARMASIdx {
     ARMASIdx_NS = 0,
diff --git a/target/arm/mmuidx.h b/target/arm/mmuidx.h
new file mode 100644
index 0000000000..5b9b4bc84f
--- /dev/null
+++ b/target/arm/mmuidx.h
@@ -0,0 +1,216 @@
+/*
+ * QEMU Arm software mmu index definitions
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TARGET_ARM_MMUIDX_H
+#define TARGET_ARM_MMUIDX_H
+
+/*
+ * Arm has the following "translation regimes" (as the Arm ARM calls them):
+ *
+ * If EL3 is 64-bit:
+ *  + NonSecure EL1 & 0 stage 1
+ *  + NonSecure EL1 & 0 stage 2
+ *  + NonSecure EL2
+ *  + NonSecure EL2 & 0   (ARMv8.1-VHE)
+ *  + Secure EL1 & 0 stage 1
+ *  + Secure EL1 & 0 stage 2 (FEAT_SEL2)
+ *  + Secure EL2 (FEAT_SEL2)
+ *  + Secure EL2 & 0 (FEAT_SEL2)
+ *  + Realm EL1 & 0 stage 1 (FEAT_RME)
+ *  + Realm EL1 & 0 stage 2 (FEAT_RME)
+ *  + Realm EL2 (FEAT_RME)
+ *  + EL3
+ * If EL3 is 32-bit:
+ *  + NonSecure PL1 & 0 stage 1
+ *  + NonSecure PL1 & 0 stage 2
+ *  + NonSecure PL2
+ *  + Secure PL1 & 0
+ * (reminder: for 32 bit EL3, Secure PL1 is *EL3*, not EL1.)
+ *
+ * For QEMU, an mmu_idx is not quite the same as a translation regime because:
+ *  1. we need to split the "EL1 & 0" and "EL2 & 0" regimes into two mmu_idxes,
+ *     because they may differ in access permissions even if the VA->PA map is
+ *     the same
+ *  2. we want to cache in our TLB the full VA->IPA->PA lookup for a stage 1+2
+ *     translation, which means that we have one mmu_idx that deals with two
+ *     concatenated translation regimes [this sort of combined s1+2 TLB is
+ *     architecturally permitted]
+ *  3. we don't need to allocate an mmu_idx to translations that we won't be
+ *     handling via the TLB. The only way to do a stage 1 translation without
+ *     the immediate stage 2 translation is via the ATS or AT system insns,
+ *     which can be slow-pathed and always do a page table walk.
+ *     The only use of stage 2 translations is either as part of an s1+2
+ *     lookup or when loading the descriptors during a stage 1 page table walk,
+ *     and in both those cases we don't use the TLB.
+ *  4. we can also safely fold together the "32 bit EL3" and "64 bit EL3"
+ *     translation regimes, because they map reasonably well to each other
+ *     and they can't both be active at the same time.
+ *  5. we want to be able to use the TLB for accesses done as part of a
+ *     stage1 page table walk, rather than having to walk the stage2 page
+ *     table over and over.
+ *  6. we need separate EL1/EL2 mmu_idx for handling the Privileged Access
+ *     Never (PAN) bit within PSTATE.
+ *  7. we fold together most secure and non-secure regimes for A-profile,
+ *     because there are no banked system registers for aarch64, so the
+ *     process of switching between secure and non-secure is
+ *     already heavyweight.
+ *  8. we cannot fold together Stage 2 Secure and Stage 2 NonSecure,
+ *     because both are in use simultaneously for Secure EL2.
+ *
+ * This gives us the following list of cases:
+ *
+ * EL0 EL1&0 stage 1+2 (aka NS PL0 PL1&0 stage 1+2)
+ * EL1 EL1&0 stage 1+2 (aka NS PL1 PL1&0 stage 1+2)
+ * EL1 EL1&0 stage 1+2 +PAN (aka NS PL1 P1&0 stage 1+2 +PAN)
+ * EL0 EL2&0
+ * EL2 EL2&0
+ * EL2 EL2&0 +PAN
+ * EL2 (aka NS PL2)
+ * EL3 (aka AArch32 S PL1 PL1&0)
+ * AArch32 S PL0 PL1&0 (we call this EL30_0)
+ * AArch32 S PL1 PL1&0 +PAN (we call this EL30_3_PAN)
+ * Stage2 Secure
+ * Stage2 NonSecure
+ * plus one TLB per Physical address space: S, NS, Realm, Root
+ *
+ * for a total of 16 different mmu_idx.
+ *
+ * R profile CPUs have an MPU, but can use the same set of MMU indexes
+ * as A profile. They only need to distinguish EL0 and EL1 (and
+ * EL2 for cores like the Cortex-R52).
+ *
+ * M profile CPUs are rather different as they do not have a true MMU.
+ * They have the following different MMU indexes:
+ *  User
+ *  Privileged
+ *  User, execution priority negative (ie the MPU HFNMIENA bit may apply)
+ *  Privileged, execution priority negative (ditto)
+ * If the CPU supports the v8M Security Extension then there are also:
+ *  Secure User
+ *  Secure Privileged
+ *  Secure User, execution priority negative
+ *  Secure Privileged, execution priority negative
+ *
+ * The ARMMMUIdx and the mmu index value used by the core QEMU TLB code
+ * are not quite the same -- different CPU types (most notably M profile
+ * vs A/R profile) would like to use MMU indexes with different semantics,
+ * but since we don't ever need to use all of those in a single CPU we
+ * can avoid having to set NB_MMU_MODES to "total number of A profile MMU
+ * modes + total number of M profile MMU modes". The lower bits of
+ * ARMMMUIdx are the core TLB mmu index, and the higher bits are always
+ * the same for any particular CPU.
+ * Variables of type ARMMUIdx are always full values, and the core
+ * index values are in variables of type 'int'.
+ *
+ * Our enumeration includes at the end some entries which are not "true"
+ * mmu_idx values in that they don't have corresponding TLBs and are only
+ * valid for doing slow path page table walks.
+ *
+ * The constant names here are patterned after the general style of the names
+ * of the AT/ATS operations.
+ * The values used are carefully arranged to make mmu_idx => EL lookup easy.
+ * For M profile we arrange them to have a bit for priv, a bit for negpri
+ * and a bit for secure.
+ */
+#define ARM_MMU_IDX_A     0x10  /* A profile */
+#define ARM_MMU_IDX_NOTLB 0x20  /* does not have a TLB */
+#define ARM_MMU_IDX_M     0x40  /* M profile */
+
+/* Meanings of the bits for M profile mmu idx values */
+#define ARM_MMU_IDX_M_PRIV   0x1
+#define ARM_MMU_IDX_M_NEGPRI 0x2
+#define ARM_MMU_IDX_M_S      0x4  /* Secure */
+
+#define ARM_MMU_IDX_TYPE_MASK \
+    (ARM_MMU_IDX_A | ARM_MMU_IDX_M | ARM_MMU_IDX_NOTLB)
+#define ARM_MMU_IDX_COREIDX_MASK 0xf
+
+typedef enum ARMMMUIdx {
+    /*
+     * A-profile.
+     */
+    ARMMMUIdx_E10_0     = 0 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_0     = 1 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_1     = 2 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_2     = 3 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_1_PAN = 4 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_2_PAN = 5 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E2        = 6 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E3        = 7 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E30_0     = 8 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E30_3_PAN = 9 | ARM_MMU_IDX_A,
+
+    /*
+     * Used for second stage of an S12 page table walk, or for descriptor
+     * loads during first stage of an S1 page table walk.  Note that both
+     * are in use simultaneously for SecureEL2: the security state for
+     * the S2 ptw is selected by the NS bit from the S1 ptw.
+     */
+    ARMMMUIdx_Stage2_S  = 10 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2    = 11 | ARM_MMU_IDX_A,
+
+    /* TLBs with 1-1 mapping to the physical address spaces. */
+    ARMMMUIdx_Phys_S     = 12 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_NS    = 13 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_Root  = 14 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_Realm = 15 | ARM_MMU_IDX_A,
+
+    /*
+     * These are not allocated TLBs and are used only for AT system
+     * instructions or for the first stage of an S12 page table walk.
+     */
+    ARMMMUIdx_Stage1_E0 = 0 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E1_PAN = 2 | ARM_MMU_IDX_NOTLB,
+
+    /*
+     * M-profile.
+     */
+    ARMMMUIdx_MUser = ARM_MMU_IDX_M,
+    ARMMMUIdx_MPriv = ARM_MMU_IDX_M | ARM_MMU_IDX_M_PRIV,
+    ARMMMUIdx_MUserNegPri = ARMMMUIdx_MUser | ARM_MMU_IDX_M_NEGPRI,
+    ARMMMUIdx_MPrivNegPri = ARMMMUIdx_MPriv | ARM_MMU_IDX_M_NEGPRI,
+    ARMMMUIdx_MSUser = ARMMMUIdx_MUser | ARM_MMU_IDX_M_S,
+    ARMMMUIdx_MSPriv = ARMMMUIdx_MPriv | ARM_MMU_IDX_M_S,
+    ARMMMUIdx_MSUserNegPri = ARMMMUIdx_MUserNegPri | ARM_MMU_IDX_M_S,
+    ARMMMUIdx_MSPrivNegPri = ARMMMUIdx_MPrivNegPri | ARM_MMU_IDX_M_S,
+} ARMMMUIdx;
+
+/*
+ * Bit macros for the core-mmu-index values for each index,
+ * for use when calling tlb_flush_by_mmuidx() and friends.
+ */
+#define TO_CORE_BIT(NAME) \
+    ARMMMUIdxBit_##NAME = 1 << (ARMMMUIdx_##NAME & ARM_MMU_IDX_COREIDX_MASK)
+
+typedef enum ARMMMUIdxBit {
+    TO_CORE_BIT(E10_0),
+    TO_CORE_BIT(E20_0),
+    TO_CORE_BIT(E10_1),
+    TO_CORE_BIT(E10_1_PAN),
+    TO_CORE_BIT(E2),
+    TO_CORE_BIT(E20_2),
+    TO_CORE_BIT(E20_2_PAN),
+    TO_CORE_BIT(E3),
+    TO_CORE_BIT(E30_0),
+    TO_CORE_BIT(E30_3_PAN),
+    TO_CORE_BIT(Stage2),
+    TO_CORE_BIT(Stage2_S),
+
+    TO_CORE_BIT(MUser),
+    TO_CORE_BIT(MPriv),
+    TO_CORE_BIT(MUserNegPri),
+    TO_CORE_BIT(MPrivNegPri),
+    TO_CORE_BIT(MSUser),
+    TO_CORE_BIT(MSPriv),
+    TO_CORE_BIT(MSUserNegPri),
+    TO_CORE_BIT(MSPrivNegPri),
+} ARMMMUIdxBit;
+
+#undef TO_CORE_BIT
+
+#define MMU_USER_IDX 0
+
+#endif /* TARGET_ARM_MMUIDX_H */
-- 
2.43.0


