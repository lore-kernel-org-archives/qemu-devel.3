Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DA7CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7Z-0000pG-PM; Fri, 15 May 2026 06:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7V-0000mE-RD
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:17 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7S-0001oD-Us
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:17 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso5828631f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842213; x=1779447013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WFpFICzXfOiAHDh1V+lFO20/ZRtRiyXKxnbsJAd3MCU=;
 b=zPSkAZqoDeGR0fFovf9ujJO10BkDC3noFUIP397zzjNqk67ANk58PTo7eE09n5cIBx
 qzlr1yIK9SU1YfI/KCP9xtuvLFhym5OKiZX19glsCPaqndcg96jQKsX/5qWSH+xIV65h
 4NoC0i0xVbxOK/7POzg8dSYD7wpDiO1fX/QI2MXZ9rDaUvuxq0hP94+zVQEaMut7enPu
 SuNIluv0PdorRc3fozengRKylT08ae+0TKZuTDV5i7Kx2iNwtOGuHJS5KX0q3KI2HNX5
 aKjKO3/2nUwiSPXf3dF1CLArMadNCgrCaK/l6LL98P/F6/HS4KDRzW6MMpf6PtK34qw6
 yW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842213; x=1779447013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WFpFICzXfOiAHDh1V+lFO20/ZRtRiyXKxnbsJAd3MCU=;
 b=MUJOHyTPzH3R1KSQ2CMPXPPRxMOFyrs77DWK8YYUuJAW4qlOXjRVVzwILa48xDrbp/
 XIMZuT78Jt3kCnMttK6DuU/BF23Ks4HaFfamVg2Be1xF4ItijOsn2SZ92Z9q5WvTMxPM
 e/vsvs8WcGkhHjKOUB4V75vc5WVmTxhMSCqUeqRGyQtpVaCXshrJXJ2B11PPeiwJBCtl
 CbE870weVdAlTq/4VTuXwC3j+4qUrGFFF6tgTRAsyObQ55PTBWYrGgzH8XB5YnGbV3CH
 5/y0dPpC+Mn0SHmgZFpB7ss9DyhjK43SfjnqUz82eYFb17Q9DZClDnR8IoBwqXiRsVTF
 JeGQ==
X-Gm-Message-State: AOJu0YyT6zgqKKaSL1AQB5MMuZ7iL9C0sFszFgjYS8zKZZStrIm8RmOx
 sN6UGflowHN20FiMAwrJYjOxo0HBTNKTs+mPH3RjvHlcg0q+PV6iprOMHIsIh87RiikafYYzvot
 sqoPo
X-Gm-Gg: Acq92OEsQV/WLL9oWF51OSoE471R+HbOW2h6oL/phs4q9Ck8JKUNpdcuxAsUK+11Acr
 mFqKPPE5Yc87TvmNj7IeUtIFGwaTRlba9GS89arsQvR72qe6e6q6Z0Bas8Ie0rc/2k+2v8bOioS
 qnT2J9I1CsuwEhP2l/GlTXAoKZHucafzje23J1nC0NoSPe9nLn/AnKUAmvsh/r3VhlIm5YlKyd8
 ZIRS7p7/V/4NJF3PH4jv15TP5h5zGyE4jXNap8pE9EEop3VpcVXEoGFhQm37gI9Y7VFz4OpiX4t
 TyatsMKDjbTqZIQbjUPZTHsCmaHyRr+q95FahGZmywFxUsQHHGa/F8+17WK5sDTzylyv2606um+
 jCVf1AHI4I0SoZWaATNQuYpPYyFXoowDbf1JYHPdomx5hIXlREgXwz3GRVa+L4rCfVzM+vPsZGY
 0TBqDinVyB8ZFYJJXuCeFye2hN1o0cK5sbfcfB6jw+oQ65Hj47JZQVj9eCMvMhu8gEswO6U37p4
 5EgcfT50u0qxYfos0OtL//aVaqXmo8=
X-Received: by 2002:a05:600c:c096:b0:48f:d1b8:9aad with SMTP id
 5b1f17b1804b1-48fe5fd5357mr33395375e9.2.1778842213167; 
 Fri, 15 May 2026 03:50:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/23] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
Date: Fri, 15 May 2026 11:49:45 +0100
Message-ID: <20260515104945.4145203-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: "Scott J. Goldman" <scottjgo@gmail.com>

Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
changed hvf_wfi() from blocking the vCPU thread with pselect() to
returning EXCP_HLT, intending QEMU's main event loop to handle the
idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
always returns false and the vCPU thread spins at 100% CPU per core
while the guest is idle.

Fix this by:

1. Setting cpu->halted = 1 in hvf_wfi() so the vCPU thread sleeps on
   halt_cond in qemu_process_cpu_events().

2. Arming a per-vCPU QEMU_CLOCK_VIRTUAL timer to fire when the guest's
   virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
   because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
   hv_vcpu_run(), which is not called while the CPU is halted. The
   timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
   vtimer IRQ through the GIC and marks vtimer_masked, causing the
   interrupt delivery chain to wake the vCPU via qemu_cpu_kick().

3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
   indicates a pending interrupt, and cancelling the WFI timer.

4. Re-arming the WFI timer from hvf_vm_state_change() on the resume
   transition for any halted vCPU, since the QEMUTimer is per-instance
   state and is not migrated. After cpu_synchronize_all_states() the
   migrated vtimer state is mirrored in env, so we can read CNTV_CTL
   and CNTV_CVAL from there. If the vtimer has already expired by the
   time the destination resumes, hvf_wfi_timer_cb() is invoked
   directly so the halted vCPU is woken up.

All wfi_timer handling (allocation, arming, deletion, and the resume
re-arm) is gated on !hvf_irqchip_in_kernel(): with the Apple in-kernel
vGIC, HVF owns the vtimer and delivers wake-ups itself.

Note for stable backports: this commit won't apply to 11.0 as
it has changes to handle the hvf in-kernel irqchip support that
landed after the 11.0 release. The v3 version of this commit:
  https://patchew.org/QEMU/20260427195516.46256-1-scottjgo@gmail.com/
should be suitable for 11.0 backporting (it is essentially
identical except that it doesn't make the changes conditional
on !hvf_irqchip_in_kernel()).

Cc: qemu-stable@nongnu.org
Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
[PMM: added note about stable backports to commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/hvf_int.h |   1 +
 target/arm/hvf/hvf.c     | 140 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index ad7d375109..d5eaf26dda 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -48,6 +48,7 @@ struct AccelCPUState {
     hv_vcpu_exit_t *exit;
     bool vtimer_masked;
     bool guest_debug_enabled;
+    struct QEMUTimer *wfi_timer;
 #endif
 };
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 9312607001..d88cbe7c82 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -29,6 +29,7 @@
 #include "hw/core/irq.h"
 #include "hw/arm/virt.h"
 #include "qemu/main-loop.h"
+#include "qemu/timer.h"
 #include "system/cpus.h"
 #include "arm-powerctl.h"
 #include "target/arm/cpu.h"
@@ -308,6 +309,8 @@ void hvf_arm_init_debug(void)
 #define TMR_CTL_IMASK   (1 << 1)
 #define TMR_CTL_ISTATUS (1 << 2)
 
+static void hvf_wfi_timer_cb(void *opaque);
+
 static uint32_t chosen_ipa_bit_size;
 
 typedef struct HVFVTimer {
@@ -1296,6 +1299,11 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
     hv_return_t ret;
 
+    if (!hvf_irqchip_in_kernel()) {
+        timer_free(cpu->accel->wfi_timer);
+        cpu->accel->wfi_timer = NULL;
+    }
+
     ret = hv_vcpu_destroy(cpu->accel->fd);
     assert_hvf_ok(ret);
 }
@@ -1487,6 +1495,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
+    if (!hvf_irqchip_in_kernel()) {
+        cpu->accel->wfi_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                             hvf_wfi_timer_cb, cpu);
+    }
+
     aarch64_add_sme_properties(OBJECT(cpu));
     return 0;
 }
@@ -2194,6 +2207,62 @@ static uint64_t hvf_vtimer_val_raw(void)
     return mach_absolute_time() - hvf_state->vtimer_offset;
 }
 
+static void hvf_wfi_timer_cb(void *opaque)
+{
+    CPUState *cpu = opaque;
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+
+    /*
+     * vtimer expired while the CPU was halted for WFI.
+     * Mirror HV_EXIT_REASON_VTIMER_ACTIVATED: raise the vtimer
+     * interrupt and mark as masked so hvf_sync_vtimer() will
+     * check and unmask when the guest handles it.
+     *
+     * The interrupt delivery chain (GIC -> cpu_interrupt ->
+     * qemu_cpu_kick) wakes the vCPU thread from halt_cond.
+     */
+    qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
+    cpu->accel->vtimer_masked = true;
+}
+
+/*
+ * Arm a host-side QEMU_CLOCK_VIRTUAL timer to fire when the guest's
+ * vtimer (CNTV_CVAL_EL0) is scheduled to expire. HVF only delivers
+ * HV_EXIT_REASON_VTIMER_ACTIVATED during hv_vcpu_run(), which we won't
+ * call while the vCPU is halted, so we need this to wake the vCPU.
+ *
+ * QEMU_CLOCK_VIRTUAL pauses while the VM is stopped, which keeps the
+ * timer in lockstep with the guest's view of vtime across pause/resume.
+ *
+ * Caller must supply the current CNTV_CTL_EL0 and CNTV_CVAL_EL0 values,
+ * since the appropriate source (HVF vs. env) depends on context.
+ *
+ * Returns 0 if the timer was armed (or if the vtimer is disabled/masked
+ * and the vCPU should still halt waiting on another event), or -1 if
+ * the vtimer has already expired.
+ */
+static int hvf_arm_wfi_timer(CPUState *cpu, uint64_t ctl, uint64_t cval)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    uint64_t now;
+    int64_t delta_ns;
+
+    if (!(ctl & TMR_CTL_ENABLE) || (ctl & TMR_CTL_IMASK)) {
+        return 0;
+    }
+
+    now = hvf_vtimer_val_raw();
+    if (cval <= now) {
+        return -1;
+    }
+
+    delta_ns = muldiv64(cval - now, NANOSECONDS_PER_SECOND,
+                        arm_cpu->gt_cntfrq_hz);
+    timer_mod(cpu->accel->wfi_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delta_ns);
+    return 0;
+}
+
 static int hvf_wfi(CPUState *cpu)
 {
     if (cpu_has_work(cpu)) {
@@ -2204,6 +2273,29 @@ static int hvf_wfi(CPUState *cpu)
         return 0;
     }
 
+    if (!hvf_irqchip_in_kernel()) {
+        uint64_t ctl, cval;
+        hv_return_t r;
+
+        /*
+         * Read the vtimer state directly from HVF. We're on the vCPU
+         * thread, just exited from hv_vcpu_run(), so HVF holds the
+         * authoritative values and env may be stale.
+         */
+        r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0,
+                                &ctl);
+        assert_hvf_ok(r);
+        r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0,
+                                &cval);
+        assert_hvf_ok(r);
+
+        if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
+            /* vtimer already expired, don't halt */
+            return 0;
+        }
+    }
+
+    cpu->halted = 1;
     return EXCP_HLT;
 }
 
@@ -2502,7 +2594,13 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     hv_return_t r;
 
     if (cpu->halted) {
-        return EXCP_HLT;
+        if (!cpu_has_work(cpu)) {
+            return EXCP_HLT;
+        }
+        cpu->halted = 0;
+        if (!hvf_irqchip_in_kernel()) {
+            timer_del(cpu->accel->wfi_timer);
+        }
     }
 
     flush_cpu_state(cpu);
@@ -2551,6 +2649,46 @@ static void hvf_vm_state_change(void *opaque, bool running, RunState state)
         /* Update vtimer offset on all CPUs */
         hvf_state->vtimer_offset = mach_absolute_time() - s->vtimer_val;
         cpu_synchronize_all_states();
+
+        /*
+         * After migration restore (or any resume), the wfi_timer is not
+         * scheduled on this QEMU instance, so re-arm it for any halted
+         * vCPU with a pending vtimer. For a non-migration resume the
+         * QEMU_CLOCK_VIRTUAL timer was already scheduled; recomputing the
+         * deadline produces the same value and is a harmless no-op.
+         *
+         * cpu_synchronize_all_states() above ensures env mirrors the
+         * authoritative vtimer state (whether that came from HVF or from
+         * the migration stream), so we can safely read it here from the
+         * iothread.
+         *
+         * Only applies when we own the wfi_timer; with an in-kernel vGIC
+         * the timer is never allocated and HVF handles vtimer wake-ups.
+         */
+        if (!hvf_irqchip_in_kernel()) {
+            CPUState *cpu;
+
+            CPU_FOREACH(cpu) {
+                ARMCPU *arm_cpu;
+                uint64_t ctl, cval;
+
+                if (!cpu->accel || !cpu->halted) {
+                    continue;
+                }
+
+                arm_cpu = ARM_CPU(cpu);
+                ctl = arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].ctl;
+                cval = arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].cval;
+
+                if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
+                    /*
+                     * vtimer already expired while we were paused; raise
+                     * the IRQ now so the halted vCPU wakes up.
+                     */
+                    hvf_wfi_timer_cb(cpu);
+                }
+            }
+        }
     } else {
         /* Remember vtimer value on every pause */
         s->vtimer_val = hvf_vtimer_val_raw();
-- 
2.43.0


