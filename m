Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B686E77183
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2jZ-0000vP-Tr; Tue, 10 Dec 2024 11:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jW-0000px-MR
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:11 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jU-0004YW-Di
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:10 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43618283d48so4340415e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733846707; x=1734451507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0nCDf9bLy33xYBPxi8KGaRSeSMxt2veFOBL2bu7e354=;
 b=HIXt2X9xLBYWKFAkbLTiV5Vl11tdRK9731iDu9pS+EcBd22JSRIx8sCH8uoQrSjmIE
 WsT7o790X2NaJFjZ0wCUxvutlcQcQdU1kB6WOxlLZzfH/RwdEk6XBWY7Z2HsMMSkWdxI
 NIyjQ1nNkm+4XZsL5oPX2i+ST4u08wnBbfMnZo3YDroQWs1WLgh9zV5oQNISC9cA3nwN
 xcNU1pz+8Owcn2/9YJc8sgPC96YfznAtFzSfTTLlh8uwMiFpKWYexWCtWfacUOa/lNc8
 HDzzEeAe1+D/0BTO570iA+793RF6Ze7Y2ypN8rE4bRijcDCC4jFug+NTe1sHUHYuEPmQ
 agiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733846707; x=1734451507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0nCDf9bLy33xYBPxi8KGaRSeSMxt2veFOBL2bu7e354=;
 b=DbbL/HFyd/hNW7tt9bGcU5DqlMBBFrdbmBEkHXeoRw4XNdIMgEINK+A1iomR/XyqEX
 bf1kLQqG296zDZjP4fNGfNIewwBpPhJRrwyy+T+VJVVf+3rWsghShrvf9gxCz30hYrsG
 p2Myh41BHQS7JYwhigZmf7IGLeL423x+tIPxls1zE5bRAR9M4iMVlZMClqsdv4sjXKN+
 IQeW2cYnAbw1OZbhzU+HU7ELv8tQ5K49W6tWb9wP4gLcLGGfqSjy7A3DcPdBhUEpQhGl
 LozKJAVg2WBQfD+n3kz/KwsWOjSJmIc4nQdhMAgvMuY94j9LEdBVvrLHkntyeL/GQqDm
 jbHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEuK/TiCSsLlB3+h9OclJgL/BbZBE4lRbttEsgDQnmYJNq6NnhJTjxfSdfCYexCgaGeu5rG/su0Xqe@nongnu.org
X-Gm-Message-State: AOJu0YzTwv2TuWUjJOKMRpaFFrs6kFubnIFZbw/BhqTJPSpH0hr3hxiw
 s5T5vbj7XupNC5mBRdtNzGAMXAA36nNYw3Z1YNL9f0jk6GA+0efYuDKSg3K8HO2X7FHPBJVo6Vf
 1
X-Gm-Gg: ASbGncux5Z5NnE6cVVg/20wLl98ZzIu2CkFzKIHh997OL6wKBQM33tEWYSju0WsN/zi
 g+rDGQVO8Oibe3mdN7SWoEqvERgEHyIL5XZz7s7QlX9rtodU6qdtek0BoE+zxYA/TKV42Xqf12h
 NsjckqMfkcpXS39ypEjtN87XuMWZSBICwxbY35cGMSG1LbPBrvNZBoiGR0kx06V9pt5CMZEO5Dc
 HI8MZlU5GuVrVU4zPboOKey5XQOnH4phL+npAYViLWG7ul+UKX358MdGarS
X-Google-Smtp-Source: AGHT+IGCdQ/RAXYNtdhX4tEpZJjD4gV8b5CwP2G1DWDLM5ngf15Yu8+ePoOv4WRzyt5qhMRj6+HMJg==
X-Received: by 2002:a05:600c:5756:b0:434:a350:207c with SMTP id
 5b1f17b1804b1-434dded76fdmr122830565e9.23.1733846699623; 
 Tue, 10 Dec 2024 08:04:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8ec8072sm124671605e9.18.2024.12.10.08.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:04:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/10] target/arm: Move TLBI insns for AArch32 EL2 to
 tlbi_insn_helper.c
Date: Tue, 10 Dec 2024 16:04:44 +0000
Message-Id: <20241210160452.2427965-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210160452.2427965-1-peter.maydell@linaro.org>
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
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

Move the AArch32 TLBI insns for AArch32 EL2 to tlbi_insn_helper.c.
To keep this as an obviously pure code-movement, we retain the
same condition for registering tlbi_el2_cp_reginfo that we use for
el2_cp_reginfo. We'll be able to simplify this condition later,
since the need to define the reginfo for EL3-without-EL2 doesn't
apply for the TLBI ops specifically.

This move brings all the uses of tlbimva_hyp_write() and
tlbimva_hyp_is_write() back into a single file, so we can move those
also, and make them file-local again.

The helper alle1_tlbmask() is an exception to the pattern that we
only need to make these functions global temporarily, because once
this refactoring is complete it will be called by both code in
helper.c (vttbr_write()) and by code in tlb-insns.c.  We therefore
put its prototype in a permanent home in internals.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h        |  4 --
 target/arm/internals.h     |  6 +++
 target/arm/helper.c        | 74 +--------------------------------
 target/arm/tcg/tlb-insns.c | 85 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 77 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 26c27dc5cb6..851cd045b2c 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1143,9 +1143,5 @@ CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
 CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
                              bool isread);
 bool tlb_force_broadcast(CPUARMState *env);
-void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                       uint64_t value);
-void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                          uint64_t value);
 
 #endif /* TARGET_ARM_CPREGS_H */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2adedb94777..c3a5b1385f1 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1820,4 +1820,10 @@ uint64_t gt_get_countervalue(CPUARMState *env);
  * and CNTVCT_EL0 (this will be either 0 or the value of CNTVOFF_EL2).
  */
 uint64_t gt_virt_cnt_offset(CPUARMState *env);
+
+/*
+ * Return mask of ARMMMUIdxBit values corresponding to an "invalidate
+ * all EL1" scope; this covers stage 1 and stage 2.
+ */
+int alle1_tlbmask(CPUARMState *env);
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6a9bf70f185..3c69225e1d9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -438,7 +438,7 @@ static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
-static int alle1_tlbmask(CPUARMState *env)
+int alle1_tlbmask(CPUARMState *env)
 {
     /*
      * Note that the 'ALL' scope must invalidate both stage 1 and
@@ -465,58 +465,6 @@ bool tlb_force_broadcast(CPUARMState *env)
     return arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_FB);
 }
 
-static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                               uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_by_mmuidx(cs, alle1_tlbmask(env));
-}
-
-static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                  uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, alle1_tlbmask(env));
-}
-
-
-static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                              uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
-}
-
-static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                 uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
-}
-
-void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                       uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
-
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
-}
-
-void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                          uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
-
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_E2);
-}
-
 static const ARMCPRegInfo cp_reginfo[] = {
     /*
      * Define the secure and non-secure FCSE identifier CP registers
@@ -6248,26 +6196,6 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "HTTBR", .cp = 15, .opc1 = 4, .crm = 2,
       .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
-    { .name = "TLBIALLNSNH",
-      .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 4,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiall_nsnh_write },
-    { .name = "TLBIALLNSNHIS",
-      .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 4,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiall_nsnh_is_write },
-    { .name = "TLBIALLH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiall_hyp_write },
-    { .name = "TLBIALLHIS", .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiall_hyp_is_write },
-    { .name = "TLBIMVAH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbimva_hyp_write },
-    { .name = "TLBIMVAHIS", .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbimva_hyp_is_write },
     { .name = "TLBI_ALLE2", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 0,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index cdf23352d7a..66096093dcc 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -99,6 +99,25 @@ static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
+
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
+}
+
+static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
+
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
+                                             ARMMMUIdxBit_E2);
+}
+
 static void tlbiipas2_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                 uint64_t value)
 {
@@ -117,6 +136,39 @@ static void tlbiipas2is_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUIdxBit_Stage2);
 }
 
+static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                               uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_by_mmuidx(cs, alle1_tlbmask(env));
+}
+
+static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, alle1_tlbmask(env));
+}
+
+
+static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
+}
+
+static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
+}
+
 static const ARMCPRegInfo tlbi_not_v7_cp_reginfo[] = {
     /*
      * MMU TLB control. Note that the wildcarding means we cover not just
@@ -227,6 +279,29 @@ static const ARMCPRegInfo tlbi_v8_cp_reginfo[] = {
       .writefn = tlbiipas2is_hyp_write },
 };
 
+static const ARMCPRegInfo tlbi_el2_cp_reginfo[] = {
+    { .name = "TLBIALLNSNH",
+      .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 4,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbiall_nsnh_write },
+    { .name = "TLBIALLNSNHIS",
+      .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 4,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbiall_nsnh_is_write },
+    { .name = "TLBIALLH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 0,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbiall_hyp_write },
+    { .name = "TLBIALLHIS", .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 0,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbiall_hyp_is_write },
+    { .name = "TLBIMVAH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 1,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbimva_hyp_write },
+    { .name = "TLBIMVAHIS", .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 1,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbimva_hyp_is_write },
+};
+
 void define_tlb_insn_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -243,4 +318,14 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_V8)) {
         define_arm_cp_regs(cpu, tlbi_v8_cp_reginfo);
     }
+    /*
+     * We retain the existing logic for when to register these TLBI
+     * ops (i.e. matching the condition for el2_cp_reginfo[] in
+     * helper.c), but we will be able to simplify this later.
+     */
+    if (arm_feature(env, ARM_FEATURE_EL2)
+        || (arm_feature(env, ARM_FEATURE_EL3)
+            && arm_feature(env, ARM_FEATURE_V8))) {
+        define_arm_cp_regs(cpu, tlbi_el2_cp_reginfo);
+    }
 }
-- 
2.34.1


