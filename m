Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFFEC54E55
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg7gS-0006Sw-5x; Fri, 01 Mar 2024 13:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gM-0006Pm-2p
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:31 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gH-0008L1-4t
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:29 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51323dfce59so2189137e87.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709317943; x=1709922743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNDEo4dAsr/AT3VVoZZKQQgUvPjllXjX2BLfBSLR17k=;
 b=aXdzVT++PLr+PjxLQx3c1QKVP1/m1hmvhh4JPTQremNfKvBZVLg0pRY0riAZhG2AUM
 6wnFlsmlsPb8seOSO5uvlELAey+XTWWfSFrn8DwG/9Z+5hKQ4NVN35ohZbwUmjcOWoSw
 LgeOXJ1rOkGmHimRD7v7SFntFyfPKZUkhonwUJ18HT5yMU6W12q7hPXFzs4UmdJIv6Z1
 WFEALF/fiOC/OWq6YgGJzS9H04vRM4qS5/Bdtg/ML2SM0wYwa6MDP4ZTMUJccpMZNmd1
 D1B0JdjoHm0bEBaiY07hXWRDGH6WKTmuILutwM9X3IVEFADl+5LBpVFIl2Wb6LwnoxC8
 3VYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709317943; x=1709922743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNDEo4dAsr/AT3VVoZZKQQgUvPjllXjX2BLfBSLR17k=;
 b=AwV6Vsr42qiA/8CMyKXdcDexs30FK9AhBOhZLc7EnAszdtjI04u9xb/gEQ/LHJS67I
 AcDQkNjAZMBLyIHEopiswrIkr47cptj56gKzAPrf5uz+OgPmwZwIYEK/CYw2Z5rU1w57
 jwwDAPO89czyRmuyv7h+RwUaAitd09Gyg2CLC71iq32XbdomkjazXoILHlp4q1v7qvX0
 Dk9A2Pp3xYOEs0hS2onuv4rUuVsU2JlgwBiiQsrZd/9sF3DkRfLdBuGJF77B8U1zxiKA
 vzNUNgANWt/Z6VR++G3Wh9lcqVTzLeKFjNnfjZHsvxKfL2d7ZLxjYGKWiCZjb0pbDHOv
 MATQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMDY4xdQNxsN1sdGzgd/7acTZiWLJBNLTGMS7/+l0YjR92yOKxQq3tyDxsJNwbN7Zh4T6CEpkyJBCduVKdtlPGgNgDa9A=
X-Gm-Message-State: AOJu0YzO5J5ebCAi+8rSTSBm0yT+yRQdadWp91TpwSg7RXva5Iiotl2A
 0Lql2u7c5SkXnyw9O/srrojqS5wW2McrAeDmyrKBiHoZuPCIS2OExudT+jjzRaI=
X-Google-Smtp-Source: AGHT+IGhu5yb6FSHuzKNlz1MdLMO+WnScCHuxsWgSuZ7kk8Cs1B/fV7uDE8/NA0aTqzNj++E/m4tnA==
X-Received: by 2002:a05:6512:3a85:b0:513:360d:fe7b with SMTP id
 q5-20020a0565123a8500b00513360dfe7bmr1154114lfu.51.1709317943463; 
 Fri, 01 Mar 2024 10:32:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u2-20020adfeb42000000b0033b483d1abcsm5158934wrn.53.2024.03.01.10.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:32:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 5/8] target/arm: Implement new FEAT_ECV trap bits
Date: Fri,  1 Mar 2024 18:32:16 +0000
Message-Id: <20240301183219.2424889-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301183219.2424889-1-peter.maydell@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The functionality defined by ID_AA64MMFR0_EL1.ECV == 1 is:
 * four new trap bits for various counter and timer registers
 * the CNTHCTL_EL2.EVNTIS and CNTKCTL_EL1.EVNTIS bits which control
   scaling of the event stream. This is a no-op for us, because we don't
   implement the event stream (our WFE is a NOP): all we need to do is
   allow CNTHCTL_EL2.ENVTIS to be read and written.
 * extensions to PMSCR_EL1.PCT, PMSCR_EL2.PCT, TRFCR_EL1.TS and
   TRFCR_EL2.TS: these are all no-ops for us, because we don't implement
   FEAT_SPE or FEAT_TRF.
 * new registers CNTPCTSS_EL0 and NCTVCTSS_EL0 which are
   "self-sychronizing" views of the CNTPCT_EL0 and CNTVCT_EL0, meaning
   that no barriers are needed around their accesses. For us these
   are just the same as the normal views, because all our sysregs are
   inherently self-sychronizing.

In this commit we implement the trap handling and permit the new
CNTHCTL_EL2 bits to be written.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h |  5 ++++
 target/arm/helper.c       | 51 +++++++++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 7567854db63..b447ec5c0e6 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -741,6 +741,11 @@ static inline bool isar_feature_aa64_fgt(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, FGT) != 0;
 }
 
+static inline bool isar_feature_aa64_ecv_traps(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, ECV) > 0;
+}
+
 static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8ec61c12440..6c528903a9a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2530,6 +2530,11 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
              : !extract32(env->cp15.cnthctl_el2, 0, 1))) {
             return CP_ACCESS_TRAP_EL2;
         }
+        if (has_el2 && timeridx == GTIMER_VIRT) {
+            if (FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, EL1TVCT)) {
+                return CP_ACCESS_TRAP_EL2;
+            }
+        }
         break;
     }
     return CP_ACCESS_OK;
@@ -2573,6 +2578,11 @@ static CPAccessResult gt_timer_access(CPUARMState *env, int timeridx,
                 }
             }
         }
+        if (has_el2 && timeridx == GTIMER_VIRT) {
+            if (FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, EL1TVT)) {
+                return CP_ACCESS_TRAP_EL2;
+            }
+        }
         break;
     }
     return CP_ACCESS_OK;
@@ -2982,6 +2992,14 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_rme, cpu)) {
         valid_mask |= R_CNTHCTL_CNTVMASK_MASK | R_CNTHCTL_CNTPMASK_MASK;
     }
+    if (cpu_isar_feature(aa64_ecv_traps, cpu)) {
+        valid_mask |=
+            R_CNTHCTL_EL1TVT_MASK |
+            R_CNTHCTL_EL1TVCT_MASK |
+            R_CNTHCTL_EL1NVPCT_MASK |
+            R_CNTHCTL_EL1NVVCT_MASK |
+            R_CNTHCTL_EVNTIS_MASK;
+    }
 
     /* Clear RES0 bits */
     value &= valid_mask;
@@ -6564,7 +6582,6 @@ static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     if (arm_current_el(env) == 1) {
         /* This must be a FEAT_NV access */
-        /* TODO: FEAT_ECV will need to check CNTHCTL_EL2 here */
         return CP_ACCESS_OK;
     }
     if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
@@ -6573,6 +6590,30 @@ static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_el1nvpct(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    if (arm_current_el(env) == 1) {
+        /* This must be a FEAT_NV access with NVx == 101 */
+        if (FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, EL1NVPCT)) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+    return e2h_access(env, ri, isread);
+}
+
+static CPAccessResult access_el1nvvct(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    if (arm_current_el(env) == 1) {
+        /* This must be a FEAT_NV access with NVx == 101 */
+        if (FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, EL1NVVCT)) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+    return e2h_access(env, ri, isread);
+}
+
 /* Test if system register redirection is to occur in the current state.  */
 static bool redirect_for_e2h(CPUARMState *env)
 {
@@ -8398,14 +8439,14 @@ static const ARMCPRegInfo vhe_reginfo[] = {
     { .name = "CNTP_CTL_EL02", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 2, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_ALIAS,
-      .access = PL2_RW, .accessfn = e2h_access,
+      .access = PL2_RW, .accessfn = access_el1nvpct,
       .nv2_redirect_offset = 0x180 | NV2_REDIR_NO_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].ctl),
       .writefn = gt_phys_ctl_write, .raw_writefn = raw_write },
     { .name = "CNTV_CTL_EL02", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 3, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_ALIAS,
-      .access = PL2_RW, .accessfn = e2h_access,
+      .access = PL2_RW, .accessfn = access_el1nvvct,
       .nv2_redirect_offset = 0x170 | NV2_REDIR_NO_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].ctl),
       .writefn = gt_virt_ctl_write, .raw_writefn = raw_write },
@@ -8424,14 +8465,14 @@ static const ARMCPRegInfo vhe_reginfo[] = {
       .type = ARM_CP_IO | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
       .nv2_redirect_offset = 0x178 | NV2_REDIR_NO_NV1,
-      .access = PL2_RW, .accessfn = e2h_access,
+      .access = PL2_RW, .accessfn = access_el1nvpct,
       .writefn = gt_phys_cval_write, .raw_writefn = raw_write },
     { .name = "CNTV_CVAL_EL02", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 3, .opc2 = 2,
       .type = ARM_CP_IO | ARM_CP_ALIAS,
       .nv2_redirect_offset = 0x168 | NV2_REDIR_NO_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
-      .access = PL2_RW, .accessfn = e2h_access,
+      .access = PL2_RW, .accessfn = access_el1nvvct,
       .writefn = gt_virt_cval_write, .raw_writefn = raw_write },
 #endif
 };
-- 
2.34.1


