Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21880C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLp6-0004qn-Ma; Fri, 25 Jul 2025 13:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3e7iDaA4KCkYitm5zqkpizl0wvowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--alexrichardson.bounces.google.com>)
 id 1ufLnr-0002nu-So
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:01:52 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3e7iDaA4KCkYitm5zqkpizl0wvowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--alexrichardson.bounces.google.com>)
 id 1ufLnq-0002xh-1a
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:01:51 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-748e1e474f8so3778843b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1753462907; x=1754067707; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ev4Mo5hPC03skGFlEQroGFdqhlWLKbqp5bRMUSJzt1I=;
 b=1motN1A3PEviEHQQNvjD7JTohS3RTkqGCIYT/SPW+IkOTmeCalvkr+qdvRmV0tVN6X
 a2t8Y+ynaU0QCTq0am055wTobs5WuR9msm2+H8UW1c3+RSXn2WBrytHROBRr+5tytTTa
 h9Fn8493oDqxKvntXBiCQM/TIh4gK5YYZRbglYkLZWrrKyTCKfvFqqQ5+bAKAa0z404M
 mv8mYknMaR8RVTBnmZd5PiPueLwn4d9KzjIHxMNFb7qA03MvviP6wZIBOnSYbGwvbjF4
 2DhA9Cx9Jhy8VUC+4AxBV8UuGwngRV4oSOUUE3Y95js+3WYqLvnKprGs7mU+3mUaMA2P
 lk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753462907; x=1754067707;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ev4Mo5hPC03skGFlEQroGFdqhlWLKbqp5bRMUSJzt1I=;
 b=vWK76ZG7hJRe1kGPLOxWK2AUluYrlJIaKRXp/xysLSQ2xafpef1Mx51nykKF3UIvZ2
 Wop8visZRGyM/ekusod4SgidFt3qG/FDimZb18BsisTMKudo6vA6cSdRIqQUGrBiAdGl
 UBrJs8Kz4mNo0PauRwWCuQt4FfU6l/lvUAJ8pN66Lk/HHvRtbQ/QNUCrmPt62jXcmHpS
 liUrCMkIkiYA20RWE5RgA+9sfZXHR2QdXNaZIoAfH7LUmcbcN4r4JtRGju0frw2JZQNV
 L4nOW6VmU/tuvtxksGnpuuI3NrRl1Z5eZEccUDd3CV7NosUkejTcOPYcqJQXHNkgAGER
 p1sA==
X-Gm-Message-State: AOJu0YwLyd71eD96jhn2HE+MORkwiOz6kMJkO/OOgia5nvr+Y/DdYXLF
 P0Md98zAgjEyXfrvRkJHkYchwilC3fVssJaj8ukMHKOdj9b92pGgYAn3gTf2ibGCL5IaY//Bi/l
 S5/wLJu1sngIFweRskdJUsEfbT+bVdtjysBO/kFNqd0NWFmWAI+i9LxaA0K+2zhdR0j4ThPnWc5
 Yb7uSO/ZscTM9zq/J8HHn0GFgRPgVyqJWgRmKsulYEzRYXGkpO/SXmor5Hw0MunfFY25Reah3aY
 SrxqQ==
X-Google-Smtp-Source: AGHT+IFTkG77MgtxnoWE9eqBEOdJ+e8DRQgjDtXJ3MVG50PRmCT9qeYZqjuk02bheFy0Gjx1b7BnuOBZU9QEXzzSCY/gzA==
X-Received: from pfra5.prod.google.com ([2002:aa7:8e85:0:b0:746:2e5d:3e6a])
 (user=alexrichardson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1a8c:b0:746:24c9:c92e with SMTP id
 d2e1a72fcca58-76332b4ffe8mr5066814b3a.8.1753462907077; 
 Fri, 25 Jul 2025 10:01:47 -0700 (PDT)
Date: Fri, 25 Jul 2025 10:01:36 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725170136.145116-1-alexrichardson@google.com>
Subject: [PATCH v3] target/arm: add support for 64-bit PMCCNTR in AArch32 mode
From: Alex Richardson <alexrichardson@google.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Alex Richardson <alexrichardson@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3e7iDaA4KCkYitm5zqkpizl0wvowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--alexrichardson.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

In the PMUv3, a new AArch32 64-bit (MCRR/MRRC) accessor for the
PMCCNTR was added. In QEMU we forgot to implement this, so only
provide the 32-bit accessor. Since we have a 64-bit PMCCNTR
sysreg for AArch64, adding the 64-bit AArch32 version is easy.

We add the PMCCNTR to the v8_cp_reginfo because PMUv3 was added
in the ARMv8 architecture. This is consistent with how we
handle the existing PMCCNTR support, where we always implement
it for all v7 CPUs. This is arguably something we should
clean up so it is gated on ARM_FEATURE_PMU and/or an ID
register check for the relevant PMU version, but we should
do that as its own tidyup rather than being inconsistent between
this PMCCNTR accessor and the others.

Since the register name is the same as the 32-bit PMCCNTR, we set
ARM_CP_NO_GDB on the 32-bit one to avoid generating an invalid GDB XML.

See https://developer.arm.com/documentation/ddi0601/2024-06/AArch32-Registers/PMCCNTR--Performance-Monitors-Cycle-Count-Register?lang=en

Change v2->v3:
- Moved ARM_CP_NO_GDB to the 32-bit register if Armv8 is supported

Changes v1->v2:
- Moved to new file
- Updated commit message
- Added ARM_CP_NO_GDB

Signed-off-by: Alex Richardson <alexrichardson@google.com>
---
 target/arm/cpregs-pmu.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
index 0f295b1376..144e339c76 100644
--- a/target/arm/cpregs-pmu.c
+++ b/target/arm/cpregs-pmu.c
@@ -1067,11 +1067,6 @@ static const ARMCPRegInfo v7_pm_reginfo[] = {
       .fgt = FGT_PMSELR_EL0,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmselr),
       .writefn = pmselr_write, .raw_writefn = raw_write, },
-    { .name = "PMCCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 0,
-      .access = PL0_RW, .resetvalue = 0, .type = ARM_CP_ALIAS | ARM_CP_IO,
-      .fgt = FGT_PMCCNTR_EL0,
-      .readfn = pmccntr_read, .writefn = pmccntr_write32,
-      .accessfn = pmreg_access_ccntr },
     { .name = "PMCCNTR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 0,
       .access = PL0_RW, .accessfn = pmreg_access_ccntr,
@@ -1211,6 +1206,19 @@ void define_pm_cpregs(ARMCPU *cpu)
         define_one_arm_cp_reg(cpu, &pmcr);
         define_one_arm_cp_reg(cpu, &pmcr64);
         define_arm_cp_regs(cpu, v7_pm_reginfo);
+        /* When Armv8 is supported, PMCCNTR aliases the new 64-bit version */
+        ARMCPRegInfo pmccntr = {
+            .name = "PMCCNTR",
+            .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 0,
+            .access = PL0_RW, .accessfn = pmreg_access_ccntr,
+            .resetvalue = 0, .type = ARM_CP_ALIAS | ARM_CP_IO,
+            .fgt = FGT_PMCCNTR_EL0,
+            .readfn = pmccntr_read, .writefn = pmccntr_write32,
+        };
+        if (arm_feature(env, ARM_FEATURE_V8)) {
+            pmccntr.type |= ARM_CP_NO_GDB;
+        }
+        define_one_arm_cp_reg(cpu, &pmccntr);
 
         for (unsigned i = 0, pmcrn = pmu_num_counters(env); i < pmcrn; i++) {
             g_autofree char *pmevcntr_name = g_strdup_printf("PMEVCNTR%d", i);
@@ -1276,6 +1284,12 @@ void define_pm_cpregs(ARMCPU *cpu)
               .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
               .fgt = FGT_PMCEIDN_EL0,
               .resetvalue = cpu->pmceid1 },
+            { .name = "PMCCNTR", .state = ARM_CP_STATE_AA32,
+              .cp = 15, .crm = 9, .opc1 = 0,
+              .access = PL0_RW, .accessfn = pmreg_access_ccntr, .resetvalue = 0,
+              .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
+              .fgt = FGT_PMCCNTR_EL0, .readfn = pmccntr_read,
+              .writefn = pmccntr_write,  },
         };
         define_arm_cp_regs(cpu, v8_pm_reginfo);
     }
-- 
2.50.1.470.g6ba607880d-goog


