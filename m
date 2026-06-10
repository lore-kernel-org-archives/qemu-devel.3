Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D447CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLY7-0001Vl-RV; Wed, 10 Jun 2026 12:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXe-0007xa-SV
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:38 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXc-0005XI-L2
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:34 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-45eec22fab7so3608269f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107951; x=1781712751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VvM8xCSlh7vjTts6V3IXM9KRwLBfPW5iUjLSNHCo+yU=;
 b=i6ZuNjF7rgHwq0riQLFCEwsCAqLYm2MPTQNghDn0c/Hr0gVv4uLihGdIMmU7LMW/ec
 /mQKdDJ7dvYFKvJEns+Y+J1jJsKTkIdyDrMBYsSQpTAQtqMT48oT7Zx+gtMdZT1daXHK
 vTLVtg3VjU1AUcbDc5DEiwY0nc+tUbW++weoZ8uRaD13EemEtjSKmjqq7dJ2vm7UZ5qe
 14lAtWoISgjgnhbYrTSodv5Gcbz5UVm7KyMRi3P/UPSkHqpBg7N/haCfTf9GKhJ95XQ+
 fGfhF5XPV3ExHrnpxeI83pGIjHwli5LBivD6LcNs8mPsA80Q6Cf3RA4VE4CfeHnZ2PhL
 9qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107951; x=1781712751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VvM8xCSlh7vjTts6V3IXM9KRwLBfPW5iUjLSNHCo+yU=;
 b=IuoYOOho9ddfVXrPO3Ov7uwuhte8W7g+K9aBNb23DTRfbquTpPt0l6v45k0aua9iDM
 p7ZyDfL2H6aRJnTaOjKbMKJoOYLw5qSijMHw91l+LSBlR0TOrKxOx1QzKocEOrL842NR
 lyCFKFqJeKDO2VezdCn8yNMy/0OeqR8aWsqRwSwPUVVR5f1uo3NN5eYUn5zmjSvHMCjc
 OSs/rw0F9VKQFLtV7Odzttl1CIup9EcQmAmas538xRAt1VgtSBEhBsOWKJbzO3q/7ELf
 Dzxgjy2SQxI9U3vY5qOAiGOSvlgNOzsA5iF1MlxQVONWb2eLlXx17ULf53+p7ZXF3v57
 470Q==
X-Gm-Message-State: AOJu0Yw3EJ+O6jxW6u0VafbcdclUlbhyhvK8zy7khgyCmEwCXBLGHiFA
 nFpvp/P5hipv1DEzBjYMh5aakUCLEgcZDIU7+QXGu+uFn9mQjH4Xn2ibXRTNAzpCT2FQaowbzZX
 0cgFG
X-Gm-Gg: Acq92OEUYX4kKAU608PFUlY9KnsC7xx8QA/5ejCEBZDZ0ETPzEsxUN84Uwo+WMck5p8
 W6wnp9BoX0MIZOi4xC9x+7PYlacoSUsmfSAcLt3+1XkgnKMxjmFabW+iXfpMOnduSkJ1Y0OM5X9
 b3D5wba/VvLcAMWXNan6RsZSyYExyXjWJfcfp1HU32B/wQnDyaNz0iG54vb/blD1bGOOPgjrLpF
 NLdlTKLQmIiiTWBn7+MQCCUM48Brv97l1mwLqDq5474c4iv9mo4IchqwmKiINJ8dZFhXW/wTNKX
 3V6bBYPpR87up2iv78sXxPQzWTBAbYqATOeD6oSTm8MIl4MfdOKkE803Jh2wGD5T+FwDwWgsD9o
 DU04dfVR/N5k/XLj9bw8+7u9FZUEPDhzBk4aEFyGHI1FIMqwZ/tcHg7/leTU+l9/aNoN0CPbQUL
 esfmrNamCxe3tebK/MFJxK6GLHScEPLgTdoAsUF+5PQiiujx5raH9rWqmXD5hYo8pyXOy5ka8lf
 E8BsHasDJu8fxcgCuj2SuzdUz3jzHAMa2MeAN0xyE8=
X-Received: by 2002:a05:6000:4609:b0:460:3234:4472 with SMTP id
 ffacd0b85a97d-460323444d8mr35916551f8f.40.1781107950917; 
 Wed, 10 Jun 2026 09:12:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/71] target/arm: teach arm_cpu_has_work about halting reasons
Date: Wed, 10 Jun 2026 17:11:11 +0100
Message-ID: <20260610161202.2235298-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

With the advent of WFE and WFI we need to pay closer attention to the
reason why the vCPU may be sleeping to figure out if we should wake
it up.

Create env->halt_reason to track this and then re-order the tests so
we:

  - ignore everything is the vCPU is powered off
  - wake up if the event_register is set and we were in a WFE
  - otherwise any IRQ event does wake the vCPU up.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260529082948.363931-3-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-powerctl.c  |  6 +++---
 target/arm/cpu.c           | 40 +++++++++++++++++++++++++++-----------
 target/arm/cpu.h           | 16 +++++++++++++++
 target/arm/internals.h     | 11 +++++++++++
 target/arm/kvm.c           |  5 +++--
 target/arm/machine.c       |  2 +-
 target/arm/tcg/op_helper.c |  3 +++
 7 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index a788376d1d..a06be5cc99 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -78,7 +78,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
 
     /* Finally set the power status */
     assert(bql_locked());
-    target_cpu->power_state = PSCI_ON;
+    arm_set_cpu_power_state(target_cpu, PSCI_ON);
 }
 
 int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
@@ -186,7 +186,7 @@ static void arm_set_cpu_on_and_reset_async_work(CPUState *target_cpu_state,
 
     /* Finally set the power status */
     assert(bql_locked());
-    target_cpu->power_state = PSCI_ON;
+    arm_set_cpu_power_state(target_cpu, PSCI_ON);
 }
 
 int arm_set_cpu_on_and_reset(uint64_t cpuid)
@@ -239,7 +239,7 @@ static void arm_set_cpu_off_async_work(CPUState *target_cpu_state,
     ARMCPU *target_cpu = ARM_CPU(target_cpu_state);
 
     assert(bql_locked());
-    target_cpu->power_state = PSCI_OFF;
+    arm_set_cpu_power_state(target_cpu, PSCI_OFF);
     target_cpu_state->halted = 1;
     target_cpu_state->exception_index = EXCP_HLT;
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a13e6dae2a..8771b695d9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -145,18 +145,36 @@ static bool arm_cpu_has_work(CPUState *cs)
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
     }
 
-    return (cpu->power_state != PSCI_OFF)
-        && cpu_test_interrupt(cs,
-               CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
-               | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
-               | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
-               | CPU_INTERRUPT_EXITTB);
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
+    }
+
+    return false;
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -327,7 +345,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     env->vfp.xregs[ARM_VFP_MVFR1] = cpu->isar.mvfr1;
     env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.mvfr2;
 
-    cpu->power_state = cs->start_powered_off ? PSCI_OFF : PSCI_ON;
+    arm_set_cpu_power_state(cpu, cs->start_powered_off ? PSCI_OFF : PSCI_ON);
 
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
         /* 64 bit CPUs always start in 64 bit mode */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dd939ab22b..31a5567c95 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -224,6 +224,19 @@ typedef enum ARMFPStatusFlavour {
 /* Architecturally there are 128 PPIs in a GICv5 */
 #define GICV5_NUM_PPIS 128
 
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
@@ -746,6 +759,9 @@ typedef struct CPUArchState {
     /* Optional fault info across tlb lookup. */
     ARMMMUFaultInfo *tlb_fi;
 
+    /* Reason the CPU is halted */
+    ARMHaltReason halt_reason;
+
     /*
      * The event register is shared by all ARM profiles (A/R/M),
      * so it is stored in the top-level CPU state.
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 21cbd2b1db..b2035b9417 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -2063,4 +2063,15 @@ bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
                                        ARMCPRegMigToleranceType type);
 
 
+/**
+ * arm_set_cpu_power_state() - set power state synced with halt_reason
+ */
+static inline void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
+{
+    CPUARMState *env = &cpu->env;
+
+    cpu->power_state = state;
+    env->halt_reason = state == PSCI_OFF ? HALT_PSCI : NOT_HALTED;
+}
+
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7d194ea112..a54ef51ec2 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1149,11 +1149,12 @@ static int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
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
index 58f8dfd53c..fde3b3e8d7 100644
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
index e8f0996ed3..504526153a 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -402,6 +402,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
                         target_el);
     }
 
+    env->halt_reason = HALT_WFI;
     cs->exception_index = EXCP_HLT;
     cs->halted = 1;
     cpu_loop_exit(cs);
@@ -463,6 +464,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
     } else {
         timer_mod(cpu->wfxt_timer, nexttick);
     }
+    env->halt_reason = HALT_WFI;
     cs->exception_index = EXCP_HLT;
     cs->halted = 1;
     cpu_loop_exit(cs);
@@ -507,6 +509,7 @@ void HELPER(wfe)(CPUARMState *env)
             return;
         }
 
+        env->halt_reason = HALT_WFE;
         cs->exception_index = EXCP_HLT;
         cs->halted = 1;
         cpu_loop_exit(cs);
-- 
2.43.0


