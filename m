Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1131E85369
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 13:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8eMj-0002qj-Vd; Fri, 03 Apr 2026 09:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w8eMi-0002qC-9o
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 09:15:12 -0400
Received: from v54.v54282eed.euw1.send.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w8eMg-000397-69
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 09:15:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1775222106; x=1775229306; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Subject:
 Cc: To: To: From: From: Sender: Sender; 
 bh=TR3ZZO4BI/S5Hcl0BCH8ZcZmu5fK21upHyYovJkP0wc=;
 b=ZaDCH/a4t+APUA4HL54iMcqZ/qYAu2Lvi4af+Yide9Ng5avR64QQzQ7iMPW5NB0ASuqcxEpRPX5VT9I1tkQMRZ8Tg9aZAXJ5hcq+/GQRlGAO5EEbxtKtN2rWLQ5IMYUON8izzyYTIY/mNKkGY9IJfeeS9Mz23kSWoqQF72fYsQRu+CPXsIzUg3nQE29KEIPwQUZAWFreE0GLI16dX6otUZPEv1Stm8kNmKIcVKP/HrIRzW2BPo3bdkdFFJ2jE5l57WTUUhe7i+wmiijrGWm+7KaFw1SRbDYw+R7QqtUTT5638bNTsYa1TIY5xeEUoqleYy2aSuKePUuf1oRd2llR9g==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub158181109038.dh-hfc.datazug.ch [158.181.109.38]) by
 6b35d5fe85243893b0115df7e32ecf0b1954107ecd10c214f43efced52bb359e
 with SMTP id 69cfbd5ae1e94239b652e484; Fri, 03 Apr 2026 13:15:06 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com,
 Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH] target/arm: Move OMAP CP15 register definitions to
 cpregs-omap.c
Date: Fri,  3 Apr 2026 15:14:58 +0200
Message-ID: <20260403131458.446399-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.250.239.4;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=v54.v54282eed.euw1.send.eu.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The OMAP CP15 registers are only relevant to system-mode emulation
of OMAP SoCs. Move them out of the monolithic helper.c into a
dedicated file, following the pattern of cpregs-pmu.c and
cpregs-gcs.c. This reduces the size of helper.c and compiles
the OMAP-specific code out of CONFIG_USER_ONLY builds.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
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
index 0000000000..e0fe32632e
--- /dev/null
+++ b/target/arm/cpregs-omap-stub.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+
+void define_omap_cp_regs(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/cpregs-omap.c b/target/arm/cpregs-omap.c
new file mode 100644
index 0000000000..5fa6b70150
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
+#include "cpu.h"
+#include "cpregs.h"
+#include "internals.h"
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
index 8ec2750847..73fcb84a84 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1796,6 +1796,8 @@ void define_at_insn_regs(ARMCPU *cpu);
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
2.53.0


