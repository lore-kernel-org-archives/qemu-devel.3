Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40BBF9EDC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX5h-0006qE-9X; Wed, 22 Apr 2026 08:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4r-00065u-0Y
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4m-0005XI-J9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so4297287f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862387; x=1777467187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/Ygp/F48dZ3RysrI6Uw/aAqnHQSpp+gk0lyGlg/T44=;
 b=tZ1SOs5fql6qYW9oVAMguO9mp1voI/L98/BSdUuDe7nQYoWEtGI+zAD8ubaIvVh0Im
 zymKEJPaEtDz0TFDiZo4dhhMxXmL6KXxz2eQsyassROscpOp4e5anrSsDMJWm8CYD9Yd
 JeRFM3IaHMn1HgQstZAOlGQiTkqLIoAdnH6GGrZ1YJPlSFHtrO6w5ewtAJ23ZG/fzt/L
 oXcTemZ/+n0lJyH6Az31N217MMwgIVKlS+Fy+Oshk53UTAgkmPnI1lKunqoc91AC2C8H
 feUJ49PM6Krz+CeUs8eANSsWGRaspSeccdaK2popS7o4vUkF8ErCLRYkHJLlr/jM6TB2
 /dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862387; x=1777467187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4/Ygp/F48dZ3RysrI6Uw/aAqnHQSpp+gk0lyGlg/T44=;
 b=A7ZXl7g63MXEkXMOvV9OHijF+R/9rxwXkdoKlHNYFP64/qOm4l+2xtSboo0eyJ7CbX
 M5EYt9v3E3Qpz+B0l7j3dmKjelbMdZi+7ao6jouVxppvS/ggoemhLIOp+3Kf+OvGpqLc
 HPZ9bugnjhuV4XoFLDz1n7tWjC7D5S/gQt6jj98WZddf7FjHJ2Ixnz7/Aqs7HxgDCA3z
 J2/JZ1OQ9WKKH+UwCGwRgvbZHxKNBDcDombLo8yGEavfoM+Wh7d8EMew4hSBPR/oOk/4
 0+DFmbbKm22scClt3LN2mYtbuzEF1H4xqpCXuqw5SkMJB3B/yBRiysliN9Hqpgs6G9Si
 tARg==
X-Gm-Message-State: AOJu0Yyyy1gX3BUxPOJS91epC2wqGxMcYgY3JaK0T1fgbdcmtxG74MGX
 fjbQgzd41KBIdqARrNPY5WotdROtTfSOHSVVSYKp6ITb2Vi5iMuqNV3llC1jckzCvRc=
X-Gm-Gg: AeBDievpv0QXnl2U/R4HtJEaBX7E2O7X1ysPdOJ8/8jMBeBwpBurcQ8PKi5K0UKsmKo
 GOoxDWrmltt2LlnUaonxRwAMKEbtwHVJzQTWe3lxxY1CV9A8izDg59dWLQy9XybsgA7QJ/5lo5x
 DkKKHsJKulfXNZ2Yqyhz7vG1I1QFt5FQbhX4ZekWFnZ4cC1ru1hUyKWc9A11no9tIXBk1mNAriX
 mDmIo4T2+9UJqupuaRgRLVV0gbruYcfxhJknhrX5h1QSvQetGDfaNSIU/1liAS2K1Rd7GmVstLx
 1azpsuLS/YUI23W4htbM/pHuLe5pz3o8ToWViOSrs7O0ifr/GnaWKMbbo4LBcKZvIDKwdcEzLaj
 8N1Y4SYOphRxkzim/4wuolvbJ8/y7qrqLmpbHqHeQ0T6HsV/goEbP8ihuvVpDYpT6slyoPREnTA
 b93yPFH68b88ADj9/xxPqAfkvSo/e+veW00w==
X-Received: by 2002:adf:fcc9:0:b0:43f:e4f1:bd9b with SMTP id
 ffacd0b85a97d-43fe4f1bdf7mr22720056f8f.30.1776862386869; 
 Wed, 22 Apr 2026 05:53:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4dc24cfsm45215207f8f.16.2026.04.22.05.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E34FB614FF;
 Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 24/32] target/arm: teach arm_cpu_has_work about halting
 reasons
Date: Wed, 22 Apr 2026 13:52:41 +0100
Message-ID: <20260422125250.1303100-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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

With the advent of WFE and WFI we need to pay closer attention to the
reason why the vCPU may be sleeping to figure out if we should wake
it up.

Create env->halt_reason to track this and then re-order the tests so
we:

  - ignore everything is the vCPU is powered off
  - wake up if the event_register is set and we were in a WFE
  - otherwise any IRQ event does wake the vCPU up.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h           | 27 +++++++++++++++++++++++++
 target/arm/arm-powerctl.c  |  4 +++-
 target/arm/cpu.c           | 40 +++++++++++++++++++++++++++-----------
 target/arm/kvm.c           |  5 +++--
 target/arm/machine.c       |  2 +-
 target/arm/tcg/op_helper.c |  3 +++
 6 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20b..98cdfa6f130 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -257,6 +257,19 @@ typedef enum ARMFPStatusFlavour {
 } ARMFPStatusFlavour;
 #define FPST_COUNT  10
 
+/**
+ * ARMHaltReason - the reason we have entered halt state
+ *
+ * To be able to correctly wake up via arm_cpu_has_work() we need to
+ * track the reason we went to sleep.
+ */
+typedef enum {
+    NOT_HALTED = 0,
+    HALT_PSCI,
+    HALT_WFI,
+    HALT_WFE
+} ARMHaltReason;
+
 typedef struct CPUArchState {
     /* Regs for current mode.  */
     uint32_t regs[16];
@@ -760,6 +773,9 @@ typedef struct CPUArchState {
     /* Optional fault info across tlb lookup. */
     ARMMMUFaultInfo *tlb_fi;
 
+    /* Reason the CPU is halted */
+    ARMHaltReason halt_reason;
+
     /*
      * The event register is shared by all ARM profiles (A/R/M),
      * so it is stored in the top-level CPU state.
@@ -1691,6 +1707,17 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #endif
 }
 
+/**
+ * arm_set_cpu_power_state() - set power state synced with halt_reason
+ */
+static inline void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
+{
+    CPUARMState *env = &cpu->env;
+
+    cpu->power_state = state;
+    env->halt_reason = (state == PSCI_OFF) ? HALT_PSCI : NOT_HALTED;
+}
+
 #define HCR_VM        (1ULL << 0)
 #define HCR_SWIO      (1ULL << 1)
 #define HCR_PTW       (1ULL << 2)
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index a788376d1d3..4ca63a54443 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -78,6 +78,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
 
     /* Finally set the power status */
     assert(bql_locked());
+    target_cpu->env.halt_reason = NOT_HALTED;
     target_cpu->power_state = PSCI_ON;
 }
 
@@ -186,6 +187,7 @@ static void arm_set_cpu_on_and_reset_async_work(CPUState *target_cpu_state,
 
     /* Finally set the power status */
     assert(bql_locked());
+    target_cpu->env.halt_reason = NOT_HALTED;
     target_cpu->power_state = PSCI_ON;
 }
 
@@ -239,7 +241,7 @@ static void arm_set_cpu_off_async_work(CPUState *target_cpu_state,
     ARMCPU *target_cpu = ARM_CPU(target_cpu_state);
 
     assert(bql_locked());
-    target_cpu->power_state = PSCI_OFF;
+    arm_set_cpu_power_state(target_cpu, PSCI_OFF);
     target_cpu_state->halted = 1;
     target_cpu_state->exception_index = EXCP_HLT;
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ccc47c8a9ad..124be8c401e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -144,18 +144,36 @@ static bool arm_cpu_has_work(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
 
-    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
-        if (cpu->env.event_register) {
-            return true;
-        }
+    /*
+     * Only another PSCI call can wake the CPU up in which case the
+     * power_state would be set by arm_set_cpu_on_and_reset_async_work()
+     */
+    if (cpu->power_state == PSCI_OFF) {
+        g_assert(cpu->env.halt_reason == HALT_PSCI);
+        return false;
+    }
+
+    /*
+     * A wake-up event should only wake us if we are halted on a WFE
+     */
+    if (cpu->env.halt_reason == HALT_WFE && cpu->env.event_register) {
+        cpu->env.halt_reason = NOT_HALTED;
+        return true;
+    }
+
+    /*
+     * Otherwise pretty much any IRQ would wake us up
+     */
+    if (cpu_test_interrupt(cs,
+                           CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
+                           | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
+                           | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
+                           | CPU_INTERRUPT_EXITTB)) {
+        cpu->env.halt_reason = NOT_HALTED;
+        return true;
     }
 
-    return (cpu->power_state != PSCI_OFF)
-        && cpu_test_interrupt(cs,
-               CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
-               | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
-               | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
-               | CPU_INTERRUPT_EXITTB);
+    return false;
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -250,7 +268,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     env->vfp.xregs[ARM_VFP_MVFR1] = cpu->isar.mvfr1;
     env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.mvfr2;
 
-    cpu->power_state = cs->start_powered_off ? PSCI_OFF : PSCI_ON;
+    arm_set_cpu_power_state(cpu, cs->start_powered_off ? PSCI_OFF : PSCI_ON);
 
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
         /* 64 bit CPUs always start in 64 bit mode */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d4a68874b88..c08e4797b32 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1143,11 +1143,12 @@ static int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
     if (cap_has_mp_state) {
         struct kvm_mp_state mp_state;
         int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &mp_state);
+        ARMPSCIState state;
         if (ret) {
             return ret;
         }
-        cpu->power_state = (mp_state.mp_state == KVM_MP_STATE_STOPPED) ?
-            PSCI_OFF : PSCI_ON;
+        state = (mp_state.mp_state == KVM_MP_STATE_STOPPED) ? PSCI_OFF : PSCI_ON;
+        arm_set_cpu_power_state(cpu, state);
     }
     return 0;
 }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index b0e499515cf..62401c5a3ea 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -916,7 +916,7 @@ static int get_power(QEMUFile *f, void *opaque, size_t size,
 {
     ARMCPU *cpu = opaque;
     bool powered_off = qemu_get_byte(f);
-    cpu->power_state = powered_off ? PSCI_OFF : PSCI_ON;
+    arm_set_cpu_power_state(cpu, powered_off ? PSCI_OFF : PSCI_ON);
     return 0;
 }
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 652611b4313..46c745077d5 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -403,6 +403,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
                         target_el);
     }
 
+    env->halt_reason = HALT_WFI;
     cs->exception_index = EXCP_HLT;
     cs->halted = 1;
     cpu_loop_exit(cs);
@@ -464,6 +465,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
     } else {
         timer_mod(cpu->wfxt_timer, nexttick);
     }
+    env->halt_reason = HALT_WFI;
     cs->exception_index = EXCP_HLT;
     cs->halted = 1;
     cpu_loop_exit(cs);
@@ -508,6 +510,7 @@ void HELPER(wfe)(CPUARMState *env)
             return;
         }
 
+        env->halt_reason = HALT_WFE;
         cs->exception_index = EXCP_HLT;
         cs->halted = 1;
         cpu_loop_exit(cs);
-- 
2.47.3


