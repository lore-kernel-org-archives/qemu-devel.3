Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF7DF36BAD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 05:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB4lh-0003qb-5b; Fri, 10 Apr 2026 01:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wB4lf-0003q6-C8
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:50:59 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wB4lc-0006Kv-8g
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:50:59 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-1271195d2a7so1414263c88.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 22:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775800254; x=1776405054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKYjpnBzm9b6R7ZTmGA7hRa20prfMvO0wbO3fSp1aeo=;
 b=P4gojteKrCybMWzpD5NdYyfEeIsEpZd3GPY4hctXQOt1HnLp50EQbp69TQfhei4vLf
 wwU+eGJb+B8zup9KsK5Hvw0h/Hq4kV9+d62fCNx5hbhoaaMmXVQVTPzL06PtAhF3HZjR
 yzmACTnwW0AtA7LtfF1vRTGQPHHSZIbDNkVZRovW79uAK/KrHEgFC6HueaVzg1nKbQuj
 JRBel5E3Ud8O3liUPuh5ZlK4zlgZPxtAHGLmCb/Kh0D45s8j77NOaJ8hypoGR9+6pBqf
 wbPCSgUD65X+gpzQ6HGstQBWx+Fl70/Co8Re+oT37tJQB/u0TnC04LX3AYhpUU483Elq
 9VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775800254; x=1776405054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TKYjpnBzm9b6R7ZTmGA7hRa20prfMvO0wbO3fSp1aeo=;
 b=NRhPHDfnaMpiJWG6+c/cnsgIyoPMjOojF2o55QMvqj3ks66ZPdOn4lEPh5MzltJK2w
 ZXZrF8o4xJ/4NsmzxkNXk2XOv3JEZhQCRKhImvqGw0dOntZmb4gvDfxhJrmn/10Wd9nH
 uKswYZNhqmqmVVjj8zC2wMyqce4sLgHilQzqPrLxkGmhtxwBDYvUgKBa4hxcHEVqxs8Z
 f9+sueCxtis7Xa2CpoX5gE1qsbRtvXpIf+hpHhCIJBbC/FHMEzXcMfpzpJfyaWHm5u/N
 tHE9EHTCKYmJSY2PKNEVY1hy9yCSNeORZ0kXRfpSyT7LGP7jbJBEfcfBw6twJrcTIvYW
 R4ag==
X-Gm-Message-State: AOJu0Yyrdo60o5whihnBATKRoJNkdMUAj11lUh7hxxr8M3HXFeBh2Zo3
 GaOG7SSif0YjTYr1sT/j3KSJ3UXD/Au2A/uRBh15ZC4pxs5JTYssIjxxJIhA1XAQYwk=
X-Gm-Gg: AeBDieuy9wX/qs6cJ1D28fBDD3goxtH2kyerASeNwF6wO7TEZdXguIgATn6WWDokbxv
 OSSOQqZmDH6vVnyD/qLdKr2nBCcUMHf5+X1EqU3mgKYYmQmcFrZNymS1oXQahilZSRAtj0XenJ8
 U3Hr58aFPxH/Fk4RybdwwiK3WIJRPpW3UwqgzrWhlCbqeal3YyA4op/TEyIUhF8X6SKgz0ia2Qu
 SBNh/Ux6LLeHNJbjFY40yq63nKJ+p9GTw8DFSePd+lfLGO1rbQNAnJzN6plhQaYRnu7sVfd1gv7
 YVKtpswfIpYdGVFyGIMmE0GakJ5Gm7JZcU8rNwakv4n0+Nv41mRA6aTLwpmeY0DeUA2YiL4DeqA
 hzcVffEnqi+M3Qm6ObTQS5n/safTjcnApExRIUsuvn2DkR96FoTFD+m3WQ6+U91X1yiwt+Lej6V
 k23qw42Yh8me3KkouEuH8SVuR97WkXg7eKADG6LoT9p6ZRZ/A+F7MBT6UdFY+td5hRQoDu+pUNJ
 NIPevK8sFzWKPC10CB5JjUsE7I=
X-Received: by 2002:a05:7022:6a9:b0:128:cf86:d1cb with SMTP id
 a92af1059eb24-12c34f16faamr1215214c88.31.1775800254186; 
 Thu, 09 Apr 2026 22:50:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:ade2:73a1:54c5:e0fe])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c346fb031sm2132117c88.13.2026.04.09.22.50.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 22:50:53 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, rbolshakov@ddn.com, phil@philjordan.eu,
 agraf@csgraf.de, peter.maydell@linaro.org,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [PATCH v2] target/arm/hvf: Fix WFI halting to stop idle vCPU spinning
Date: Thu,  9 Apr 2026 22:50:26 -0700
Message-ID: <20260410055045.63001-1-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260410044726.61853-1-scottjgo@gmail.com>
References: <20260410044726.61853-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=scottjgo@gmail.com; helo=mail-dl1-x1231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
changed hvf_wfi() from blocking the vCPU thread with pselect() to
returning EXCP_HLT, intending QEMU's main event loop to handle the
idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
always returns false and the vCPU thread spins at 100% CPU per core
while the guest is idle.

Fix this by:

1. Setting cpu->halted = 1 in hvf_wfi() so the vCPU thread sleeps on
   halt_cond in qemu_process_cpu_events().

2. Arming a host-side QEMU_CLOCK_HOST timer to fire when the guest's
   virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
   because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
   hv_vcpu_run(), which is not called while the CPU is halted. The
   timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
   vtimer IRQ through the GIC and marks vtimer_masked, causing the
   interrupt delivery chain to wake the vCPU via qemu_cpu_kick().

3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
   indicates a pending interrupt, and cancelling the WFI timer.

Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
 include/system/hvf_int.h |  1 +
 target/arm/hvf/hvf.c     | 65 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 2621164cb2..58fb865eba 100644
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
index 5fc8f6bbbd..f5d7221845 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -28,6 +28,7 @@
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
 #include "qemu/main-loop.h"
+#include "qemu/timer.h"
 #include "system/cpus.h"
 #include "arm-powerctl.h"
 #include "target/arm/cpu.h"
@@ -301,6 +302,8 @@ void hvf_arm_init_debug(void)
 #define TMR_CTL_IMASK   (1 << 1)
 #define TMR_CTL_ISTATUS (1 << 2)
 
+static void hvf_wfi_timer_cb(void *opaque);
+
 static uint32_t chosen_ipa_bit_size;
 
 typedef struct HVFVTimer {
@@ -1214,6 +1217,9 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
     hv_return_t ret;
 
+    timer_free(cpu->accel->wfi_timer);
+    cpu->accel->wfi_timer = NULL;
+
     ret = hv_vcpu_destroy(cpu->accel->fd);
     assert_hvf_ok(ret);
 }
@@ -1352,6 +1358,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
+    cpu->accel->wfi_timer = timer_new_ns(QEMU_CLOCK_HOST,
+                                          hvf_wfi_timer_cb, cpu);
+
     aarch64_add_sme_properties(OBJECT(cpu));
     return 0;
 }
@@ -2027,8 +2036,30 @@ static uint64_t hvf_vtimer_val_raw(void)
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
 static int hvf_wfi(CPUState *cpu)
 {
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    uint64_t ctl, cval;
+    hv_return_t r;
+
     if (cpu_has_work(cpu)) {
         /*
          * Don't bother to go into our "low power state" if
@@ -2037,6 +2068,34 @@ static int hvf_wfi(CPUState *cpu)
         return 0;
     }
 
+    /*
+     * Set up a host-side timer to wake us when the vtimer expires.
+     * HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
+     * hv_vcpu_run(), which we won't call while halted.
+     */
+    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &ctl);
+    assert_hvf_ok(r);
+
+    if ((ctl & TMR_CTL_ENABLE) && !(ctl & TMR_CTL_IMASK)) {
+        r = hv_vcpu_get_sys_reg(cpu->accel->fd,
+                                HV_SYS_REG_CNTV_CVAL_EL0, &cval);
+        assert_hvf_ok(r);
+
+        uint64_t now = hvf_vtimer_val_raw();
+        if (cval <= now) {
+            /* Timer already expired, don't halt */
+            return 0;
+        }
+
+        uint64_t delta_ticks = cval - now;
+        int64_t delta_ns = delta_ticks * NANOSECONDS_PER_SECOND
+                           / arm_cpu->gt_cntfrq_hz;
+        int64_t deadline = qemu_clock_get_ns(QEMU_CLOCK_HOST) + delta_ns;
+
+        timer_mod(cpu->accel->wfi_timer, deadline);
+    }
+
+    cpu->halted = 1;
     return EXCP_HLT;
 }
 
@@ -2332,7 +2391,11 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     hv_return_t r;
 
     if (cpu->halted) {
-        return EXCP_HLT;
+        if (!cpu_has_work(cpu)) {
+            return EXCP_HLT;
+        }
+        cpu->halted = 0;
+        timer_del(cpu->accel->wfi_timer);
     }
 
     flush_cpu_state(cpu);
-- 
2.50.1 (Apple Git-155)


