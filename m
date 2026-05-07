Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1D8CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11M-0003VC-1P; Thu, 07 May 2026 11:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11I-0003Ta-Ha
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11G-0003ou-8E
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso11496695e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169129; x=1778773929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1B+boeG3J/p68+ah+q4V8HG+OjMDuLmWiyWVg0ncbkM=;
 b=BlvFHV0jSZzsAS9Vh+W+TGLwz7KH4RhjMM1A6/h0Sb1rm/MiPMEehTTBSUBAicYod5
 60rLp88t5gYVN4iOSIoNTAYOZj+Ou8tRuDrNUOxlx1CwNarImW53zq/Z1va836rL2xfs
 JusJAdiK+6Sg4C+/GkvAOxLniJBbI7wbBA5EAlpHLVgbejBhIGNeR6BYop0gLUQySob1
 i/L0XsKksZRZH/3/kzWTJOxtj2QvhkbDutANP8p+zcjJq3rpkDI7lGvsANMBzwDj57+k
 YjoHjJuZs09V7a7nM455OGLE6BF5lsPYYua7CWvxjS5lHVzCAotsbxtpYWhqvJpJ+L+3
 lWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169129; x=1778773929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1B+boeG3J/p68+ah+q4V8HG+OjMDuLmWiyWVg0ncbkM=;
 b=YUL3jT1RGk9E/38pGiWum0ajOOQyFBU0B+L3QafFCjC/GWXI4ATJkQxZX5M2By97jP
 EYVqYl8FPGrCyKSqZTETrTnOXNfrsmDVbE0bt56kUqW0hE+jfurhI2bLSSvtGJPDw5Pu
 06cyD/dHMiY5AFBxVqm/pwVkoaXbqwlLvcV/RXOITU/HXqqqhtEPomoeLV1C6554Egee
 YHwNkSrHvoUvVt36ZkV7YPgL0WHEuPWMf95cDzf4p3vjm6ePZUfyyRLFB/+iCJ69qWTh
 lXf7DVM8uDV9+9ZMrAgexxIk5Pl/8zifBeFNJJGGX4E0ULcKuOrBLMOnHmKnOWeyem6I
 McHw==
X-Gm-Message-State: AOJu0YzbdTIGSASY6RpQn8mfIsB+OzzmQ33jKePvo58N2+LkLOBUYXGA
 /mMHXjlbkXjVlQgDwKKYvcG3iQsVYtIXcciMzQhgbf3+ycT/JBG+S+gOIG2ZJMdsuhwAaQrfnMZ
 W+1HB
X-Gm-Gg: AeBDies/Zx4thlasoNVsb+DltKgqT4YM4GT5ER7zg5pUJ45TjVK3K7PZfGJUM7Hr99s
 y/ogoTf9xpR28VadUojngzFnqF0Tpzo1ooKSKnSwMGCyTX/VJ0e1ACyulXdC1wVaoPv6WEInmIs
 OiiZ6Mo/fj2zP4nQ0zEM4AxBUQ7B7NMNynB7HWtmvfB4qYY5rCGEzORaHGAcIlFROoO0UxIP/Ks
 H8h/ejt8zMitKqBSD162V2VgWLvohAytdpNP9A1AZbyb2e/sGCyyI8oHUGMtteK+/4k8XVfBbaq
 tiw9wCu6BR/chnDm+63iiksd+RZ0qDm3SmSAvYKMmpHG9s3F0fBJiqlkMyOLHv7UACC3iC/WPpd
 yGv3DZYCECnoCLYDtl0RSFBtSf0OhO5i3op/Dfy6QY36JdMyt07CmuJwIl81Iq0e0lxSrEs2pG5
 1aMZT4dQpXFlE/835y1CIvr+SageqGdSdVaekZ2SpFLON4sqqe7xMHt4/H2aBwJLnFIK7F1ZhOc
 rnBF8o5MfrrIsoK4gM9syOtyjVq9zvkKqeFQV703A==
X-Received: by 2002:a05:600c:811a:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-48e51f35d0emr142049895e9.20.1778169128368; 
 Thu, 07 May 2026 08:52:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/67] target/arm: GICv5 cpuif: Initial skeleton and GSB
 barrier insns
Date: Thu,  7 May 2026 16:51:01 +0100
Message-ID: <20260507155154.1886557-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

In the GICv5 architecture, part of the GIC is implemented inside the
CPU: this is the CPU interface, which presents software with system
instructions and system registers, and communicates with the external
part of the GIC (the Interrupt Routing Service, IRS) via an
architected stream interface where both sides can send commands and
receive responses.

Add the initial source files for the GICv5 CPU interface, with
initial content implementing just the two GSB GIC barrier
instructions, which are no-ops for QEMU.

Since we will not initially implement virtualization or the "legacy
GICv3" interface that can be provided to a VM guest, we don't have
the ICH_VCTLR_EL2 register and do not need to implement an accessfn
for the "trap if at EL1 and EL2 enabled and legacy GICv3 is enabled"
handling.  We will come back and add this later as part of the
legacy-GICv3 code.

(The GICv3 has a similar architecture with part of the GIC being in
the CPU and part external; for QEMU we implemented the CPU interface
in hw/intc/, but in retrospect I think this was something of a design
mistake, and for GICv5 I am going to stick a bit closer to how the
hardware architecture splits things up; hence this code is in
target/arm.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-15-peter.maydell@linaro.org
---
 target/arm/cpu-features.h    |  6 +++++
 target/arm/helper.c          |  1 +
 target/arm/internals.h       |  3 +++
 target/arm/tcg/gicv5-cpuif.c | 43 ++++++++++++++++++++++++++++++++++++
 target/arm/tcg/meson.build   |  1 +
 5 files changed, 54 insertions(+)
 create mode 100644 target/arm/tcg/gicv5-cpuif.c

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 88fe3ed287..4e44245a8b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -280,6 +280,7 @@ FIELD(ID_AA64PFR1, PFAR, 60, 4)
 FIELD(ID_AA64PFR2, MTEPERM, 0, 4)
 FIELD(ID_AA64PFR2, MTESTOREONLY, 4, 4)
 FIELD(ID_AA64PFR2, MTEFAR, 8, 4)
+FIELD(ID_AA64PFR2, GCIE, 12, 4)
 FIELD(ID_AA64PFR2, FPMR, 32, 4)
 
 FIELD(ID_AA64MMFR0, PARANGE, 0, 4)
@@ -1172,6 +1173,11 @@ static inline bool isar_feature_aa64_gcs(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, GCS) != 0;
 }
 
+static inline bool isar_feature_aa64_gcie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, GCIE) != 0;
+}
+
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
 {
     return FIELD_SEX64_IDREG(id, ID_AA64MMFR0, TGRAN4) >= 1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7e7677a584..d9751cf202 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6233,6 +6233,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (tcg_enabled()) {
         define_tlb_insn_regs(cpu);
         define_at_insn_regs(cpu);
+        define_gicv5_cpuif_regs(cpu);
     }
 #endif
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a632584a4e..6431029db8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1810,6 +1810,9 @@ void define_gcs_cpregs(ARMCPU *cpu);
 /* Add the cpreg definitions for OMAP CP15 regs */
 void define_omap_cp_regs(ARMCPU *cpu);
 
+/* Add the cpreg definitions for the GICv5 CPU interface */
+void define_gicv5_cpuif_regs(ARMCPU *cpu);
+
 /* Effective value of MDCR_EL2 */
 static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
 {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
new file mode 100644
index 0000000000..7392a98c49
--- /dev/null
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -0,0 +1,43 @@
+/*
+ * GICv5 CPU interface
+ *
+ * Copyright (c) 2025 Linaro Limited
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+#include "cpregs.h"
+
+static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
+    /*
+     * Barrier: wait until the effects of a cpuif system register
+     * write have definitely made it to the IRS (and will thus show up
+     * in cpuif reads from the IRS by this or other CPUs and in the
+     * status of IRQ, FIQ etc). For QEMU we do all interaction with
+     * the IRS synchronously, so we can make this a nop.
+     */
+    {   .name = "GSB_SYS", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 0, .opc2 = 0,
+        .access = PL1_W, .type = ARM_CP_NOP,
+    },
+    /*
+     * Barrier: wait until the effects of acknowledging an interrupt
+     * (via GICR CDIA or GICR CDNMIA) are visible, including the
+     * effect on the {IRQ,FIQ,vIRQ,vFIQ} pending state. This is a
+     * weaker version of GSB SYS. Again, for QEMU this is a nop.
+     */
+    {   .name = "GSB_ACK", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 0, .opc2 = 1,
+        .access = PL1_W, .type = ARM_CP_NOP,
+    },
+};
+
+void define_gicv5_cpuif_regs(ARMCPU *cpu)
+{
+    if (cpu_isar_feature(aa64_gcie, cpu)) {
+        define_arm_cp_regs(cpu, gicv5_cpuif_reginfo);
+    }
+}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index d2364aa39c..4fb2c15f7e 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -67,6 +67,7 @@ arm_common_system_ss.add(
   files(
   'cpregs-at.c',
   'debug.c',
+  'gicv5-cpuif.c',
   'hflags.c',
   'gengvec.c',
   'm_helper.c',
-- 
2.43.0


