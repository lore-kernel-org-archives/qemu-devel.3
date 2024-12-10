Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399ABE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2jU-0000ob-8q; Tue, 10 Dec 2024 11:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jR-0000nx-96
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:05 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jM-0004MI-Rr
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:04 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434e3953b65so24408375e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733846699; x=1734451499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=odafVhH/JoVnp12TJxSFjpOTt6X3LL2PULkfOXYpqIs=;
 b=nQq/lGaJAYH5PWP6t3gaaGAw0mTN/slVwJOzXIKT7WSMGlDLtNMe3i8VAfCSUqjtct
 /XNh6rwjBuugjDsKYiuWNMkE+FwUSBFWdDBlFc+ijeyqGL51QnHvh38urwqfCM3Ekif/
 LBgsK4B1Zp8vCosAXBOKYeno3S30qrjreNEopgW/RUkVMYPsGeKx0SOsa525+i684Btq
 RvBOkki0wF0K0DZ71u3JGHapMi5zhXl4RdEjkIYCitkiLEpPWAoTItcE/doBy09ikZ0m
 DkHUR+I7jH5Vx+oftUzulXcU7sQ0MCJXZp7tNEN2WO/hxr78xyOU74FyaqS4+EEz/Aeu
 c9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733846699; x=1734451499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=odafVhH/JoVnp12TJxSFjpOTt6X3LL2PULkfOXYpqIs=;
 b=qO1w+XWP8V9sH1HIZrETQW7xAcnBvjnAeSrsqUyDdsopMsqO4fsj5blNVAUD02xRCg
 GaGXXzrwWHzeR2rX+A8XD3GR/fQS1pTUsKy4+ue+LIjCHkyVATMRgU6Qjhj+y21rCmsC
 h1+XPJfT6k513EvtazHo0ygZKQyZDCQuefTe52ZXCTVqVrVBLUs4IPVUiev4sgW12xc9
 I1s9Mj1OwtcNbEDeHqC7GYcHbD1/Kmawh89PgTKXz+FtEc9S1oexnOODcdHu4uwAj8L9
 UAyqvs9ntQEHXJ/whpU/BdAxFLYJ0COemLghhvZ+atAA7HdebiNlb8Sw2wiQhvIq4QFv
 N1nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX5a4ocvfSP+qUMmocfbRvazhazyF+4U6LNkHswy7CS7ucxWT+LTpIc403bKz/qLWmvVVCPTniLMo4@nongnu.org
X-Gm-Message-State: AOJu0YwtQlGpwRWm3RePBE7blU5YZAI2kmnldtTYd08dXeRK3Awe+rh3
 KqpymPSLEB/zu2ZhSJeW4vEZnPMLABoXXwaV0Oci2JuICm/pb67lMPpAJ4eXoqY=
X-Gm-Gg: ASbGncvVCzSHtXWfk8dCUaZVAj6lvYqGyIf7Uw8FoyFD/TVU16OpMwz4AFYqaD29DJ4
 ZIwEQuV4O+RzrOmFN/9ddDmBOOV8rGvH09MNQ8gn2sLz6G0CVLVS/i0JgLvJakf6J7XmVI+CEYa
 B0r5d2ueVFtbRHyEJNPP14XsysqSTmPTSDb+I+y4epdDM+8CFO4f49M2OapAAZK5TTJ+h4hnBW4
 DL7ZJe6b2o1y8fT2VyTDeYoersDi66cAye4eCLpgSTpHvLklzFdp/ApWgu8
X-Google-Smtp-Source: AGHT+IHrS4TDNkD9bhHCbpUP9xMae7MPAvUSTvOp1JaWDELItoIWQt1yEYeOsbOuUOz1ZyvHnJrDNg==
X-Received: by 2002:a05:600c:458c:b0:434:edcf:7464 with SMTP id
 5b1f17b1804b1-434fffc0b2bmr49963745e9.30.1733846696153; 
 Tue, 10 Dec 2024 08:04:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8ec8072sm124671605e9.18.2024.12.10.08.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:04:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/10] target/arm: Move some TLBI insns to their own source
 file
Date: Tue, 10 Dec 2024 16:04:43 +0000
Message-Id: <20241210160452.2427965-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210160452.2427965-1-peter.maydell@linaro.org>
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

target/arm/helper.c is very large and unwieldy.  One subset of code
that we can pull out into its own file is the cpreg arrays and
corresponding functions for the TLBI instructions.

Because these are instructions they are only relevant for TCG and we
can make the new file only be built for CONFIG_TCG.

In this commit we move the AArch32 instructions from:
 not_v7_cp_reginfo[]
 v7_cp_reginfo[]
 v7mp_cp_reginfo[]
 v8_cp_reginfo[]
into a new file target/arm/tcg/tlb-insns.c.

A few small functions are used both by functions we haven't yet moved
across and by functions we have already moved.  We temporarily make
these global with a prototype in cpregs.h; when the move of all TLBI
insns is complete these will return to being file-local.

For CONFIG_TCG, this is just moving code around.  For a KVM only
build, these cpregs will no longer be added to the cpregs hashtable
for the CPU.  However this should not be a behaviour change, because:
 * we never try to migration sync or otherwise include
   ARM_CP_NO_RAW cpregs
 * for migration we treat the kernel's list of system registers
   as the authoritative one, so these TLBI insns were never
   in it anyway
The no-tcg stub of define_tlb_insn_regs() therefore does nothing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h        |  14 +++
 target/arm/internals.h     |   3 +
 target/arm/helper.c        | 231 ++--------------------------------
 target/arm/tcg-stubs.c     |   5 +
 target/arm/tcg/tlb-insns.c | 246 +++++++++++++++++++++++++++++++++++++
 target/arm/tcg/meson.build |   1 +
 6 files changed, 280 insertions(+), 220 deletions(-)
 create mode 100644 target/arm/tcg/tlb-insns.c

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index cc7c54378f4..26c27dc5cb6 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1134,4 +1134,18 @@ static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
     return ri->opc1 == 4 || ri->opc1 == 5;
 }
 
+/*
+ * Temporary declarations of functions until the move to tlb_insn_helper.c
+ * is complete and we can make the functions static again
+ */
+CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
+                           bool isread);
+CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
+                             bool isread);
+bool tlb_force_broadcast(CPUARMState *env);
+void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                       uint64_t value);
+void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value);
+
 #endif /* TARGET_ARM_CPREGS_H */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index e37f459af35..2adedb94777 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1727,6 +1727,9 @@ static inline uint64_t pauth_ptr_mask(ARMVAParameters param)
 /* Add the cpreg definitions for debug related system registers */
 void define_debug_regs(ARMCPU *cpu);
 
+/* Add the cpreg definitions for TLBI instructions */
+void define_tlb_insn_regs(ARMCPU *cpu);
+
 /* Effective value of MDCR_EL2 */
 static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f38eb054c06..6a9bf70f185 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -366,8 +366,8 @@ static CPAccessResult access_tacr(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 
 /* Check for traps from EL1 due to HCR_EL2.TTLB. */
-static CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
-                                  bool isread)
+CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
+                           bool isread)
 {
     if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TTLB)) {
         return CP_ACCESS_TRAP_EL2;
@@ -376,8 +376,8 @@ static CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 
 /* Check for traps from EL1 due to HCR_EL2.TTLB or TTLBIS. */
-static CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
-                                    bool isread)
+CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
+                             bool isread)
 {
     if (arm_current_el(env) == 1 &&
         (arm_hcr_el2_eff(env) & (HCR_TTLB | HCR_TTLBIS))) {
@@ -455,104 +455,16 @@ static int alle1_tlbmask(CPUARMState *env)
             ARMMMUIdxBit_Stage2_S);
 }
 
-
-/* IS variants of TLB operations must affect all cores */
-static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_all_cpus_synced(cs);
-}
-
-static void tlbiasid_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_all_cpus_synced(cs);
-}
-
-static void tlbimva_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_page_all_cpus_synced(cs, value & TARGET_PAGE_MASK);
-}
-
-static void tlbimvaa_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_page_all_cpus_synced(cs, value & TARGET_PAGE_MASK);
-}
-
 /*
  * Non-IS variants of TLB operations are upgraded to
  * IS versions if we are at EL1 and HCR_EL2.FB is effectively set to
  * force broadcast of these operations.
  */
-static bool tlb_force_broadcast(CPUARMState *env)
+bool tlb_force_broadcast(CPUARMState *env)
 {
     return arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_FB);
 }
 
-static void tlbiall_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                          uint64_t value)
-{
-    /* Invalidate all (TLBIALL) */
-    CPUState *cs = env_cpu(env);
-
-    if (tlb_force_broadcast(env)) {
-        tlb_flush_all_cpus_synced(cs);
-    } else {
-        tlb_flush(cs);
-    }
-}
-
-static void tlbimva_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                          uint64_t value)
-{
-    /* Invalidate single TLB entry by MVA and ASID (TLBIMVA) */
-    CPUState *cs = env_cpu(env);
-
-    value &= TARGET_PAGE_MASK;
-    if (tlb_force_broadcast(env)) {
-        tlb_flush_page_all_cpus_synced(cs, value);
-    } else {
-        tlb_flush_page(cs, value);
-    }
-}
-
-static void tlbiasid_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                           uint64_t value)
-{
-    /* Invalidate by ASID (TLBIASID) */
-    CPUState *cs = env_cpu(env);
-
-    if (tlb_force_broadcast(env)) {
-        tlb_flush_all_cpus_synced(cs);
-    } else {
-        tlb_flush(cs);
-    }
-}
-
-static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                           uint64_t value)
-{
-    /* Invalidate single entry by MVA, all ASIDs (TLBIMVAA) */
-    CPUState *cs = env_cpu(env);
-
-    value &= TARGET_PAGE_MASK;
-    if (tlb_force_broadcast(env)) {
-        tlb_flush_page_all_cpus_synced(cs, value);
-    } else {
-        tlb_flush_page(cs, value);
-    }
-}
-
 static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
@@ -586,8 +498,8 @@ static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
 }
 
-static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                              uint64_t value)
+void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                       uint64_t value)
 {
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
@@ -595,8 +507,8 @@ static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
 }
 
-static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                 uint64_t value)
+void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
 {
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
@@ -605,24 +517,6 @@ static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                              ARMMMUIdxBit_E2);
 }
 
-static void tlbiipas2_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    uint64_t pageaddr = (value & MAKE_64BIT_MASK(0, 28)) << 12;
-
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
-}
-
-static void tlbiipas2is_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    uint64_t pageaddr = (value & MAKE_64BIT_MASK(0, 28)) << 12;
-
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUIdxBit_Stage2);
-}
-
 static const ARMCPRegInfo cp_reginfo[] = {
     /*
      * Define the secure and non-secure FCSE identifier CP registers
@@ -732,22 +626,6 @@ static const ARMCPRegInfo not_v7_cp_reginfo[] = {
      */
     { .name = "DBGDIDR", .cp = 14, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 0,
       .access = PL0_R, .type = ARM_CP_CONST, .resetvalue = 0 },
-    /*
-     * MMU TLB control. Note that the wildcarding means we cover not just
-     * the unified TLB ops but also the dside/iside/inner-shareable variants.
-     */
-    { .name = "TLBIALL", .cp = 15, .crn = 8, .crm = CP_ANY,
-      .opc1 = CP_ANY, .opc2 = 0, .access = PL1_W, .writefn = tlbiall_write,
-      .type = ARM_CP_NO_RAW },
-    { .name = "TLBIMVA", .cp = 15, .crn = 8, .crm = CP_ANY,
-      .opc1 = CP_ANY, .opc2 = 1, .access = PL1_W, .writefn = tlbimva_write,
-      .type = ARM_CP_NO_RAW },
-    { .name = "TLBIASID", .cp = 15, .crn = 8, .crm = CP_ANY,
-      .opc1 = CP_ANY, .opc2 = 2, .access = PL1_W, .writefn = tlbiasid_write,
-      .type = ARM_CP_NO_RAW },
-    { .name = "TLBIMVAA", .cp = 15, .crn = 8, .crm = CP_ANY,
-      .opc1 = CP_ANY, .opc2 = 3, .access = PL1_W, .writefn = tlbimvaa_write,
-      .type = ARM_CP_NO_RAW },
     { .name = "PRRR", .cp = 15, .crn = 10, .crm = 2,
       .opc1 = 0, .opc2 = 0, .access = PL1_RW, .type = ARM_CP_NOP },
     { .name = "NMRR", .cp = 15, .crn = 10, .crm = 2,
@@ -2331,55 +2209,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 0,
       .fgt = FGT_ISR_EL1,
       .type = ARM_CP_NO_RAW, .access = PL1_R, .readfn = isr_read },
-    /* 32 bit ITLB invalidates */
-    { .name = "ITLBIALL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbiall_write },
-    { .name = "ITLBIMVA", .cp = 15, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbimva_write },
-    { .name = "ITLBIASID", .cp = 15, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 2,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbiasid_write },
-    /* 32 bit DTLB invalidates */
-    { .name = "DTLBIALL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbiall_write },
-    { .name = "DTLBIMVA", .cp = 15, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbimva_write },
-    { .name = "DTLBIASID", .cp = 15, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 2,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbiasid_write },
-    /* 32 bit TLB invalidates */
-    { .name = "TLBIALL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbiall_write },
-    { .name = "TLBIMVA", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbimva_write },
-    { .name = "TLBIASID", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 2,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbiasid_write },
-    { .name = "TLBIMVAA", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 3,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbimvaa_write },
-};
-
-static const ARMCPRegInfo v7mp_cp_reginfo[] = {
-    /* 32 bit TLB invalidates, Inner Shareable */
-    { .name = "TLBIALLIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
-      .writefn = tlbiall_is_write },
-    { .name = "TLBIMVAIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
-      .writefn = tlbimva_is_write },
-    { .name = "TLBIASIDIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 2,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
-      .writefn = tlbiasid_is_write },
-    { .name = "TLBIMVAAIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 3,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
-      .writefn = tlbimvaa_is_write },
 };
 
 static const ARMCPRegInfo pmovsset_cp_reginfo[] = {
@@ -5833,42 +5662,6 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.par_el[1]),
       .writefn = par_write },
 #endif
-    /* TLB invalidate last level of translation table walk */
-    { .name = "TLBIMVALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
-      .writefn = tlbimva_is_write },
-    { .name = "TLBIMVAALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 7,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
-      .writefn = tlbimvaa_is_write },
-    { .name = "TLBIMVAL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 5,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbimva_write },
-    { .name = "TLBIMVAAL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 7,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbimvaa_write },
-    { .name = "TLBIMVALH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 5,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbimva_hyp_write },
-    { .name = "TLBIMVALHIS",
-      .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 5,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbimva_hyp_is_write },
-    { .name = "TLBIIPAS2",
-      .cp = 15, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiipas2_hyp_write },
-    { .name = "TLBIIPAS2IS",
-      .cp = 15, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiipas2is_hyp_write },
-    { .name = "TLBIIPAS2L",
-      .cp = 15, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 5,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiipas2_hyp_write },
-    { .name = "TLBIIPAS2LIS",
-      .cp = 15, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiipas2is_hyp_write },
     /* 32 bit cache operations */
     { .name = "ICIALLUIS", .cp = 15, .opc1 = 0, .crn = 7, .crm = 1, .opc2 = 0,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_ticab },
@@ -8734,6 +8527,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, not_v8_cp_reginfo);
     }
 
+    define_tlb_insn_regs(cpu);
+
     if (arm_feature(env, ARM_FEATURE_V6)) {
         /* The ID registers all have impdef reset values */
         ARMCPRegInfo v6_idregs[] = {
@@ -8839,10 +8634,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_V6K)) {
         define_arm_cp_regs(cpu, v6k_cp_reginfo);
     }
-    if (arm_feature(env, ARM_FEATURE_V7MP) &&
-        !arm_feature(env, ARM_FEATURE_PMSA)) {
-        define_arm_cp_regs(cpu, v7mp_cp_reginfo);
-    }
     if (arm_feature(env, ARM_FEATURE_V7VE)) {
         define_arm_cp_regs(cpu, pmovsset_cp_reginfo);
     }
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index 152b172e243..f3f45d54f28 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -25,3 +25,8 @@ void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
 void assert_hflags_rebuild_correctly(CPUARMState *env)
 {
 }
+
+/* TLBI insns are only used by TCG, so we don't need to do anything for KVM */
+void define_tlb_insn_regs(ARMCPU *cpu)
+{
+}
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
new file mode 100644
index 00000000000..cdf23352d7a
--- /dev/null
+++ b/target/arm/tcg/tlb-insns.c
@@ -0,0 +1,246 @@
+/*
+ * Helpers for TLBI insns
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "exec/exec-all.h"
+#include "cpu.h"
+#include "internals.h"
+#include "cpu-features.h"
+#include "cpregs.h"
+
+/* IS variants of TLB operations must affect all cores */
+static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_all_cpus_synced(cs);
+}
+
+static void tlbiasid_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_all_cpus_synced(cs);
+}
+
+static void tlbimva_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_page_all_cpus_synced(cs, value & TARGET_PAGE_MASK);
+}
+
+static void tlbimvaa_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_page_all_cpus_synced(cs, value & TARGET_PAGE_MASK);
+}
+
+static void tlbiall_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    /* Invalidate all (TLBIALL) */
+    CPUState *cs = env_cpu(env);
+
+    if (tlb_force_broadcast(env)) {
+        tlb_flush_all_cpus_synced(cs);
+    } else {
+        tlb_flush(cs);
+    }
+}
+
+static void tlbimva_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    /* Invalidate single TLB entry by MVA and ASID (TLBIMVA) */
+    CPUState *cs = env_cpu(env);
+
+    value &= TARGET_PAGE_MASK;
+    if (tlb_force_broadcast(env)) {
+        tlb_flush_page_all_cpus_synced(cs, value);
+    } else {
+        tlb_flush_page(cs, value);
+    }
+}
+
+static void tlbiasid_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    /* Invalidate by ASID (TLBIASID) */
+    CPUState *cs = env_cpu(env);
+
+    if (tlb_force_broadcast(env)) {
+        tlb_flush_all_cpus_synced(cs);
+    } else {
+        tlb_flush(cs);
+    }
+}
+
+static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    /* Invalidate single entry by MVA, all ASIDs (TLBIMVAA) */
+    CPUState *cs = env_cpu(env);
+
+    value &= TARGET_PAGE_MASK;
+    if (tlb_force_broadcast(env)) {
+        tlb_flush_page_all_cpus_synced(cs, value);
+    } else {
+        tlb_flush_page(cs, value);
+    }
+}
+
+static void tlbiipas2_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    uint64_t pageaddr = (value & MAKE_64BIT_MASK(0, 28)) << 12;
+
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
+}
+
+static void tlbiipas2is_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    uint64_t pageaddr = (value & MAKE_64BIT_MASK(0, 28)) << 12;
+
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUIdxBit_Stage2);
+}
+
+static const ARMCPRegInfo tlbi_not_v7_cp_reginfo[] = {
+    /*
+     * MMU TLB control. Note that the wildcarding means we cover not just
+     * the unified TLB ops but also the dside/iside/inner-shareable variants.
+     */
+    { .name = "TLBIALL", .cp = 15, .crn = 8, .crm = CP_ANY,
+      .opc1 = CP_ANY, .opc2 = 0, .access = PL1_W, .writefn = tlbiall_write,
+      .type = ARM_CP_NO_RAW },
+    { .name = "TLBIMVA", .cp = 15, .crn = 8, .crm = CP_ANY,
+      .opc1 = CP_ANY, .opc2 = 1, .access = PL1_W, .writefn = tlbimva_write,
+      .type = ARM_CP_NO_RAW },
+    { .name = "TLBIASID", .cp = 15, .crn = 8, .crm = CP_ANY,
+      .opc1 = CP_ANY, .opc2 = 2, .access = PL1_W, .writefn = tlbiasid_write,
+      .type = ARM_CP_NO_RAW },
+    { .name = "TLBIMVAA", .cp = 15, .crn = 8, .crm = CP_ANY,
+      .opc1 = CP_ANY, .opc2 = 3, .access = PL1_W, .writefn = tlbimvaa_write,
+      .type = ARM_CP_NO_RAW },
+};
+
+static const ARMCPRegInfo tlbi_v7_cp_reginfo[] = {
+    /* 32 bit ITLB invalidates */
+    { .name = "ITLBIALL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 0,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiall_write },
+    { .name = "ITLBIMVA", .cp = 15, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 1,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimva_write },
+    { .name = "ITLBIASID", .cp = 15, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 2,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiasid_write },
+    /* 32 bit DTLB invalidates */
+    { .name = "DTLBIALL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 0,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiall_write },
+    { .name = "DTLBIMVA", .cp = 15, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 1,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimva_write },
+    { .name = "DTLBIASID", .cp = 15, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 2,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiasid_write },
+    /* 32 bit TLB invalidates */
+    { .name = "TLBIALL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 0,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiall_write },
+    { .name = "TLBIMVA", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 1,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimva_write },
+    { .name = "TLBIASID", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 2,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiasid_write },
+    { .name = "TLBIMVAA", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 3,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimvaa_write },
+};
+
+static const ARMCPRegInfo tlbi_v7mp_cp_reginfo[] = {
+    /* 32 bit TLB invalidates, Inner Shareable */
+    { .name = "TLBIALLIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 0,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
+      .writefn = tlbiall_is_write },
+    { .name = "TLBIMVAIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 1,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
+      .writefn = tlbimva_is_write },
+    { .name = "TLBIASIDIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 2,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
+      .writefn = tlbiasid_is_write },
+    { .name = "TLBIMVAAIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 3,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
+      .writefn = tlbimvaa_is_write },
+};
+
+static const ARMCPRegInfo tlbi_v8_cp_reginfo[] = {
+    /* AArch32 TLB invalidate last level of translation table walk */
+    { .name = "TLBIMVALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
+      .writefn = tlbimva_is_write },
+    { .name = "TLBIMVAALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 7,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
+      .writefn = tlbimvaa_is_write },
+    { .name = "TLBIMVAL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 5,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimva_write },
+    { .name = "TLBIMVAAL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 7,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimvaa_write },
+    { .name = "TLBIMVALH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 5,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbimva_hyp_write },
+    { .name = "TLBIMVALHIS",
+      .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 5,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbimva_hyp_is_write },
+    { .name = "TLBIIPAS2",
+      .cp = 15, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 1,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbiipas2_hyp_write },
+    { .name = "TLBIIPAS2IS",
+      .cp = 15, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbiipas2is_hyp_write },
+    { .name = "TLBIIPAS2L",
+      .cp = 15, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 5,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbiipas2_hyp_write },
+    { .name = "TLBIIPAS2LIS",
+      .cp = 15, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbiipas2is_hyp_write },
+};
+
+void define_tlb_insn_regs(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+
+    if (!arm_feature(env, ARM_FEATURE_V7)) {
+        define_arm_cp_regs(cpu, tlbi_not_v7_cp_reginfo);
+    } else {
+        define_arm_cp_regs(cpu, tlbi_v7_cp_reginfo);
+    }
+    if (arm_feature(env, ARM_FEATURE_V7MP) &&
+        !arm_feature(env, ARM_FEATURE_PMSA)) {
+        define_arm_cp_regs(cpu, tlbi_v7mp_cp_reginfo);
+    }
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        define_arm_cp_regs(cpu, tlbi_v8_cp_reginfo);
+    }
+}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 508932a249f..09238989c5a 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -39,6 +39,7 @@ arm_ss.add(files(
   'op_helper.c',
   'tlb_helper.c',
   'vec_helper.c',
+  'tlb-insns.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-- 
2.34.1


