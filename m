Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17ECF99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtY-0006MJ-Dv; Thu, 23 Apr 2026 06:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtQ-0006Jq-Mg
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtO-000201-Gg
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:44 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso59717235e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938561; x=1777543361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GE5heDTE24qeg7bs1UHIGmavXNoRi4sL8/ptSkR7ee0=;
 b=RZV/iMPR9TFjwRPnAfIFwe50fHcNM7UafybEXBQZtQDXa+TfoggmV4opUKzTAMPSje
 UeFtUOtsNc1IOW784sIsSsrch4MHXpM49hZIBrry9rrmCvSp5mbXmgFexqs6V53tpYqz
 J6rC6417uhokEQHSYqnEkDJaBHFhTcC7CIihJqHHoO4zWUXoPN4rmaCxx4ZDfxMsNDIp
 638mtY2cANPBzA0eP6SCtkBvvOi/nSla6F3w8H73mGgvEuFaPK70RAODeiQQtTeudVLe
 ytgtSdTqoGcqy6vdoRJv8lIOQlIfn9eQ6vpcp/M3tD3OcrwGAd+zpXr9xo5qNlXLydao
 E6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938561; x=1777543361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GE5heDTE24qeg7bs1UHIGmavXNoRi4sL8/ptSkR7ee0=;
 b=GJTMnwQ5AG4SHQ4N8s4kER6qjPiS52aNxruuCplAL6TEB0CJ8DinaCXdP8TCLwOPpE
 IYhqqCfJoIwcROIC5xFki5Dq1yndYwKkMu7S+Jf5VujG5wt9VQExI+3/1noWyq/6Bz8m
 J29WUtZuntJY/WTmyZ4CK8lN6QVQHfGJJmXQl2UT6Eb9IFdTEGqvPCwYpduDlQniSgP1
 oJGyNM/j+gcjSq50evP3WWjU+e8waiH7Idi8X14Jv57nCx9ss3EMtCdrHXg/NVTlonsE
 3ngp3ACUR7pjycr9/aFLwnc15ATxPSrsvpq+xZ5BiGDip8/8Grk5JZPKnA4ibYGHSyRL
 z2iA==
X-Gm-Message-State: AOJu0YzMwjsD+bxTarNeRvZfLRay2vlyLy/wvj9yW4U96OD44s1rNfMQ
 H/KwoJ+6WCVdR2wQSBXu1VQCbs3bkg5JDOW/5eqW6PsY8PEtv9sgh6aHh6SwKlxmZCQtTIVMW5S
 o+6jo
X-Gm-Gg: AeBDiesZ5gyogi9naR95c2OJbQdBsYuwMXeFOYx9JSV5Lnq/qRrqn9CczhBIP9uJl8A
 LGP7YWi0BVqYouGKyj2dYmYMO4E9ol2EufwGVCrLA9PXYJlHhyQ3UXbO9Zw6L/iHDm5JOa1MmB6
 wSQrLeR8En01YmR1erxQCkYa0611AurdmJqOZVeYTfZkaFkdF0dEhVJV824wZZeajBpPmROOco4
 JoQ6N2U3GirtoFTr4RdI/QDUF/aLAUJo1K0wJTtGVe5UfeYfCQSCLC6CDHtQrLUm/F7eINvH3jV
 049d0DGxcf5P8dwJJ4XrLPZ6vC2OjE1e0i/0RDbp54yAQDGBhfFWCI4THgQqXmHrSNlB3rf1Zyo
 1RFJilnp671Bzgt1tUWE+E5tLddIAoqrzF2PJKdfdL6aaYSoyWQC+rITVYVlMdsbuINWRHsfWrN
 8L2FhU7HbYO3euZegmtY7ClHvILoHkQJYguOQ9b0EATF02LCZvvz2uSn5NJjeDnUwKtmQj+uZr3
 SB148x/tIWk6nkfz++m6DyzHmbRFnW/afgOlqlH4eNHfk1F0zRS
X-Received: by 2002:a05:6000:2909:b0:43f:e22d:e624 with SMTP id
 ffacd0b85a97d-43fe3db3cb2mr38391922f8f.1.1776938560794; 
 Thu, 23 Apr 2026 03:02:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/59] target/arm: Move OMAP CP15 register definitions to
 cpregs-omap.c
Date: Thu, 23 Apr 2026 11:01:39 +0100
Message-ID: <20260423100229.2941820-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alessandro Ratti <alessandro@0x65c.net>

The OMAP CP15 registers are only relevant to system-mode emulation
of OMAP SoCs. Move them out of the monolithic helper.c into a
dedicated file, following the pattern of cpregs-pmu.c and
cpregs-gcs.c. This reduces the size of helper.c and compiles
the OMAP-specific code out of CONFIG_USER_ONLY builds.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
Message-id: 20260405180826.729652-1-alessandro@0x65c.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs-omap-stub.c | 10 ++++
 target/arm/cpregs-omap.c      | 88 +++++++++++++++++++++++++++++++++++
 target/arm/helper.c           | 79 +------------------------------
 target/arm/internals.h        |  2 +
 target/arm/meson.build        |  2 +
 5 files changed, 103 insertions(+), 78 deletions(-)
 create mode 100644 target/arm/cpregs-omap-stub.c
 create mode 100644 target/arm/cpregs-omap.c

diff --git a/target/arm/cpregs-omap-stub.c b/target/arm/cpregs-omap-stub.c
new file mode 100644
index 0000000000..39c511205c
--- /dev/null
+++ b/target/arm/cpregs-omap-stub.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "target/arm/cpu-qom.h"
+#include "internals.h"
+
+void define_omap_cp_regs(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/cpregs-omap.c b/target/arm/cpregs-omap.c
new file mode 100644
index 0000000000..ac855baada
--- /dev/null
+++ b/target/arm/cpregs-omap.c
@@ -0,0 +1,88 @@
+/*
+ * QEMU ARM OMAP CP15 register definitions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "target/arm/cpu.h"
+#include "target/arm/cpregs.h"
+#include "target/arm/internals.h"
+
+static void omap_ticonfig_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                uint64_t value)
+{
+    env->cp15.c15_ticonfig = value & 0xe7;
+    /* The OS_TYPE bit in this register changes the reported CPUID! */
+    env->cp15.c0_cpuid = (value & (1 << 5)) ?
+        ARM_CPUID_TI915T : ARM_CPUID_TI925T;
+}
+
+static void omap_threadid_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                uint64_t value)
+{
+    env->cp15.c15_threadid = value & 0xffff;
+}
+
+static void omap_wfi_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    /* Wait-for-interrupt (deprecated) */
+    cpu_interrupt(env_cpu(env), CPU_INTERRUPT_HALT);
+}
+
+static void omap_cachemaint_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    /*
+     * On OMAP there are registers indicating the max/min index of dcache lines
+     * containing a dirty line; cache flush operations have to reset these.
+     */
+    env->cp15.c15_i_max = 0x000;
+    env->cp15.c15_i_min = 0xff0;
+}
+
+static const ARMCPRegInfo omap_cp_reginfo[] = {
+    { .name = "DFSR", .cp = 15, .crn = 5, .crm = CP_ANY,
+      .opc1 = CP_ANY, .opc2 = CP_ANY, .access = PL1_RW, .type = ARM_CP_OVERRIDE,
+      .fieldoffset = offsetoflow32(CPUARMState, cp15.esr_el[1]),
+      .resetvalue = 0, },
+    { .name = "", .cp = 15, .crn = 15, .crm = 0, .opc1 = 0, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_NOP },
+    { .name = "TICONFIG", .cp = 15, .crn = 15, .crm = 1, .opc1 = 0, .opc2 = 0,
+      .access = PL1_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.c15_ticonfig), .resetvalue = 0,
+      .writefn = omap_ticonfig_write },
+    { .name = "IMAX", .cp = 15, .crn = 15, .crm = 2, .opc1 = 0, .opc2 = 0,
+      .access = PL1_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.c15_i_max), .resetvalue = 0, },
+    { .name = "IMIN", .cp = 15, .crn = 15, .crm = 3, .opc1 = 0, .opc2 = 0,
+      .access = PL1_RW, .resetvalue = 0xff0,
+      .fieldoffset = offsetof(CPUARMState, cp15.c15_i_min) },
+    { .name = "THREADID", .cp = 15, .crn = 15, .crm = 4, .opc1 = 0, .opc2 = 0,
+      .access = PL1_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.c15_threadid), .resetvalue = 0,
+      .writefn = omap_threadid_write },
+    { .name = "TI925T_STATUS", .cp = 15, .crn = 15,
+      .crm = 8, .opc1 = 0, .opc2 = 0, .access = PL1_RW,
+      .type = ARM_CP_NO_RAW,
+      .readfn = arm_cp_read_zero, .writefn = omap_wfi_write, },
+    /*
+     * TODO: Peripheral port remap register:
+     * On OMAP2 mcr p15, 0, rn, c15, c2, 4 sets up the interrupt controller
+     * base address at $rn & ~0xfff and map size of 0x200 << ($rn & 0xfff),
+     * when MMU is off.
+     */
+    { .name = "OMAP_CACHEMAINT", .cp = 15, .crn = 7, .crm = CP_ANY,
+      .opc1 = 0, .opc2 = CP_ANY, .access = PL1_W,
+      .type = ARM_CP_OVERRIDE | ARM_CP_NO_RAW,
+      .writefn = omap_cachemaint_write },
+    { .name = "C9", .cp = 15, .crn = 9,
+      .crm = CP_ANY, .opc1 = CP_ANY, .opc2 = CP_ANY, .access = PL1_RW,
+      .type = ARM_CP_CONST | ARM_CP_OVERRIDE, .resetvalue = 0 },
+};
+
+void define_omap_cp_regs(ARMCPU *cpu)
+{
+    define_arm_cp_regs(cpu, omap_cp_reginfo);
+}
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7389f2988c..3ac88078aa 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2900,83 +2900,6 @@ static const ARMCPRegInfo ttbcr2_reginfo = {
     },
 };
 
-static void omap_ticonfig_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                uint64_t value)
-{
-    env->cp15.c15_ticonfig = value & 0xe7;
-    /* The OS_TYPE bit in this register changes the reported CPUID! */
-    env->cp15.c0_cpuid = (value & (1 << 5)) ?
-        ARM_CPUID_TI915T : ARM_CPUID_TI925T;
-}
-
-static void omap_threadid_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                uint64_t value)
-{
-    env->cp15.c15_threadid = value & 0xffff;
-}
-
-static void omap_wfi_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                           uint64_t value)
-{
-#ifdef CONFIG_USER_ONLY
-    g_assert_not_reached();
-#else
-    /* Wait-for-interrupt (deprecated) */
-    cpu_interrupt(env_cpu(env), CPU_INTERRUPT_HALT);
-#endif
-}
-
-static void omap_cachemaint_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                  uint64_t value)
-{
-    /*
-     * On OMAP there are registers indicating the max/min index of dcache lines
-     * containing a dirty line; cache flush operations have to reset these.
-     */
-    env->cp15.c15_i_max = 0x000;
-    env->cp15.c15_i_min = 0xff0;
-}
-
-static const ARMCPRegInfo omap_cp_reginfo[] = {
-    { .name = "DFSR", .cp = 15, .crn = 5, .crm = CP_ANY,
-      .opc1 = CP_ANY, .opc2 = CP_ANY, .access = PL1_RW, .type = ARM_CP_OVERRIDE,
-      .fieldoffset = offsetoflow32(CPUARMState, cp15.esr_el[1]),
-      .resetvalue = 0, },
-    { .name = "", .cp = 15, .crn = 15, .crm = 0, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW, .type = ARM_CP_NOP },
-    { .name = "TICONFIG", .cp = 15, .crn = 15, .crm = 1, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW,
-      .fieldoffset = offsetof(CPUARMState, cp15.c15_ticonfig), .resetvalue = 0,
-      .writefn = omap_ticonfig_write },
-    { .name = "IMAX", .cp = 15, .crn = 15, .crm = 2, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW,
-      .fieldoffset = offsetof(CPUARMState, cp15.c15_i_max), .resetvalue = 0, },
-    { .name = "IMIN", .cp = 15, .crn = 15, .crm = 3, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW, .resetvalue = 0xff0,
-      .fieldoffset = offsetof(CPUARMState, cp15.c15_i_min) },
-    { .name = "THREADID", .cp = 15, .crn = 15, .crm = 4, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW,
-      .fieldoffset = offsetof(CPUARMState, cp15.c15_threadid), .resetvalue = 0,
-      .writefn = omap_threadid_write },
-    { .name = "TI925T_STATUS", .cp = 15, .crn = 15,
-      .crm = 8, .opc1 = 0, .opc2 = 0, .access = PL1_RW,
-      .type = ARM_CP_NO_RAW,
-      .readfn = arm_cp_read_zero, .writefn = omap_wfi_write, },
-    /*
-     * TODO: Peripheral port remap register:
-     * On OMAP2 mcr p15, 0, rn, c15, c2, 4 sets up the interrupt controller
-     * base address at $rn & ~0xfff and map size of 0x200 << ($rn & 0xfff),
-     * when MMU is off.
-     */
-    { .name = "OMAP_CACHEMAINT", .cp = 15, .crn = 7, .crm = CP_ANY,
-      .opc1 = 0, .opc2 = CP_ANY, .access = PL1_W,
-      .type = ARM_CP_OVERRIDE | ARM_CP_NO_RAW,
-      .writefn = omap_cachemaint_write },
-    { .name = "C9", .cp = 15, .crn = 9,
-      .crm = CP_ANY, .opc1 = CP_ANY, .opc2 = CP_ANY, .access = PL1_RW,
-      .type = ARM_CP_CONST | ARM_CP_OVERRIDE, .resetvalue = 0 },
-};
-
 static const ARMCPRegInfo dummy_c15_cp_reginfo[] = {
     /*
      * RAZ/WI the whole crn=15 space, when we don't have a more specific
@@ -7043,7 +6966,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, cache_block_ops_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_OMAPCP)) {
-        define_arm_cp_regs(cpu, omap_cp_reginfo);
+        define_omap_cp_regs(cpu);
     }
     if (arm_feature(env, ARM_FEATURE_STRONGARM)) {
         define_arm_cp_regs(cpu, strongarm_cp_reginfo);
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 85980f0e69..6b16f1a560 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1799,6 +1799,8 @@ void define_at_insn_regs(ARMCPU *cpu);
 void define_pm_cpregs(ARMCPU *cpu);
 /* Add the cpreg definitions for GCS cpregs */
 void define_gcs_cpregs(ARMCPU *cpu);
+/* Add the cpreg definitions for OMAP CP15 regs */
+void define_omap_cp_regs(ARMCPU *cpu);
 
 /* Effective value of MDCR_EL2 */
 static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0e504a40..192ac7c31e 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -33,6 +33,7 @@ arm_user_ss.add(files(
   'helper.c',
   'vfp_fpscr.c',
   'el2-stubs.c',
+  'cpregs-omap-stub.c',
 ))
 arm_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		        if_true: files('common-semi-target.c'))
@@ -48,6 +49,7 @@ arm_common_system_ss.add(files(
   'arm-powerctl.c',
   'cortex-regs.c',
   'cpregs-gcs.c',
+  'cpregs-omap.c',
   'cpregs-pmu.c',
   'cpu-irq.c',
   'debug_helper.c',
-- 
2.43.0


