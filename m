Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12449FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIOt3-0008K7-Ih; Thu, 30 Apr 2026 06:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIOsw-0008GY-RK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:44:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIOst-0005Jp-HZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:44:46 -0400
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-43d73422431so685375f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777545877; x=1778150677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXkCjDNNed+tdCztqK2sYupZhfXPPqZLJxXlVw3UrqI=;
 b=a16HYuUZ3/Y0hcc30+I65qrgP/ti5Wb72t4SOWwu2hsCJAbZi0eFP/wBSyQ8s7hqB0
 FEPXCL5jN0fvRHM4G5BTrjTbi1Xe7t3BpDlPEsgHOJng5Dho6Uwjm31kGgpg1YXmM/d/
 OcPNv2hGtySdTXaODrfypTNngFnZxvHBiJ+oc+eoJo9Z9hW3poeplIjOWxB2dP/Ur0/P
 ERZTx2IzcPULXJVj2dgmUz9UEYNN1SklwZenEpOanNWvxvH6P9CGKllI4qZjy9VAbrJ5
 LF+rOTdRAjU6IrO/0WSbiTp5Pkx0OfzFmdVdmkwfTbt7bS61PvrXEsjePFAQBIEItJBm
 As9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545877; x=1778150677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oXkCjDNNed+tdCztqK2sYupZhfXPPqZLJxXlVw3UrqI=;
 b=SvIjIHdkavmHNNRYxifIp+E5+jw2BV9ThbtdDWr2YpIcVi7ROWrTLXFx4LBYFC++5P
 7hGbnWokAgXPgv4WmC/gd4k7CitWlo9JonmiFcmpz2N9P9V2aPPKOOrZywSibkCIC+KY
 pTpcqY3x4L6fIEs6BTt77nkDYRnFJ0/0EJDP42tnJxtYUiWnG6CXj+XF17RbRnH+xuuL
 9geEaIreQmpme9MLJswIVExbQyMNwnT9OXA6UVYl4bSeRZGXt07W94ENieBbq/vVt/kv
 +RL4j88xKfmEMdwSCwGx3sZkwVWzaCwMWpfLK26XlmkQjpIpdOILCO0K7oZZyij2S9v8
 liBA==
X-Gm-Message-State: AOJu0YxBjp6grn2AEcZzLLMXPFY37hz6kJivNaPM8fF3RmDXn4Qj2+YK
 MmXND1RAPmEke2/D456KoDNTpjvxmgCVq5hYpk0YSJmF8ecH7FF0inp77hLcT4CiRP0=
X-Gm-Gg: AeBDievhlcEzpoGOo4NRuUjW7WAFkO5Gwh1Cvm/xDLXQMqI/M0L3Myje3iZwYDWC8WS
 Icgo0+9NLURJDD48qcTXf+tlOgMkZYYILYnNuqwkYGry/DBU2dMmJshnkPv3Tk1Jr7IpUL0NtJW
 06KcaB4pN6PkZ9J7iDVLP98Lzux1t48A0Zfz/IkFJ6o3/wRe8Z+IeMeSNdPQmQAsoBGVKbPEW8L
 hmZVlNC8LTKiJedOGYHeGSeWjVeDT2BB/elDLm9dQP3uhnfZfbbPQdNQNlRMiCCGyd1Md8tG4tj
 cYU/vKsfqb4imb4xrutvq8zyGKzBHcDMYh2RZ3LPlPtkH5HZTUlyowMUo/EkXszsR0ZgXBwGplu
 KVB28ASlCRUfYzPDEd1fmhDGGtp0tc3l7nnacHa2l8XJ1V7PUVqtz9IiSr/Fhi9M3nKhh3FI7Ds
 +T2Ig8/4qd82zz8eNicQN8NDDSj4CCwGBG+Q==
X-Received: by 2002:a05:6000:24c5:b0:43f:e452:f391 with SMTP id
 ffacd0b85a97d-4493cb42f83mr4018286f8f.6.1777545876542; 
 Thu, 30 Apr 2026 03:44:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-448af0fa81esm7222907f8f.19.2026.04.30.03.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:44:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DD4785F92A;
 Thu, 30 Apr 2026 11:44:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 1/7] target/arm: teach arm_cpu_has_work about halting
 reasons
Date: Thu, 30 Apr 2026 11:44:28 +0100
Message-ID: <20260430104434.1482407-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430104434.1482407-1-alex.bennee@linaro.org>
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
v3
  - move arm_set_cpu_power_state to internals.h
  - drop excess brackets
---
 target/arm/cpu.h           | 16 +++++++++++++++
 target/arm/internals.h     | 11 +++++++++++
 target/arm/arm-powerctl.c  |  4 +++-
 target/arm/cpu.c           | 40 +++++++++++++++++++++++++++-----------
 target/arm/kvm.c           |  5 +++--
 target/arm/machine.c       |  2 +-
 target/arm/tcg/op_helper.c |  3 +++
 7 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index be14a47c357..357359011cb 100644
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
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a632584a4e0..4a1ea5465d7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1997,4 +1997,15 @@ bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
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
index 10feb639c4d..fb79981338c 100644
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
 
@@ -326,7 +344,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
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
index 8dc766d3225..dbd39e7ba76 100644
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
index e8f0996ed39..504526153a6 100644
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
2.47.3


