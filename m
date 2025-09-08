Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317E4CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYs9-0001d2-H3; Mon, 08 Sep 2025 06:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYs6-0001c9-L1
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYrv-0000uR-AM
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFAxEBE2vTBq9sN8WpMlUM9AjgGajtnYOUlEqhXuNQY=;
 b=eAfVoypl10oKd1m54bIWArpSQ0aLi6EV2+REBY65qS2C5Qlp0mP7daKqdJR6+Y9tyNEobI
 qOQG+LDoESdZlBtcz1rGku3mSZp27iFHNzl9JsD2/qxdH8svz2PeU952zLf6K73rwuPeQ0
 JmaWIgYHf/amUx0bd33RtFT/RP7JBZA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-Bo9fsHFgPUGNy-7_3UbdbA-1; Mon, 08 Sep 2025 06:12:56 -0400
X-MC-Unique: Bo9fsHFgPUGNy-7_3UbdbA-1
X-Mimecast-MFC-AGG-ID: Bo9fsHFgPUGNy-7_3UbdbA_1757326375
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45d6c770066so21685865e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326374; x=1757931174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFAxEBE2vTBq9sN8WpMlUM9AjgGajtnYOUlEqhXuNQY=;
 b=VVG3w40kXRycM7IsJxUHq6RClGi9FEwlKQOFOfPRGiRJAuP3a777/m6q63X4MiG4ap
 I/ocu3fmWuHPy5qvrreYnFC8DQo4oGd/0Zb6AqO1QLJzp0uFMr6pV2qpCTqXH1k/ZJWY
 uBiNd4Kqa4K68fOuX58Y34F6y7gH8Ccd/BUhPZqVHMyMrOd/c9vdlM4sM6WUDlyLA1/s
 +UcIXnausBXxhd5+rFJqtHJxbJ/d/xtbgutUbRwYVCHA9p4dYM7He+U535ZpG/sX8dWw
 59paUR/1fLe6e3386yjzSq5hjzRjENv2pwiYvNZgCVmqmky4coffs2KWv90iBJuILIZf
 oJFQ==
X-Gm-Message-State: AOJu0Yze0Qer+2St+09HrffEIJzn0WS0gL5yw7T/Fc1NUvq06+VIRuwg
 px0YXpc7mLl7QIb9wwaAoghk4uU30TFFChULHCyJJJW5AsRguH5e7CKsLC/fN8Pq7+77TMe6Oit
 mVZiddODbF/3tMvFWalIePJElOsX2j7adg00qkbo4mJVNcnYIxIUXjduz2yRyWJT4OTRqy3V5Sg
 r8ngQdg//wpInYcko2IvBBeqjXK1rRiW1BBD4BKnMO
X-Gm-Gg: ASbGnctZaUepPvCzzONFRUWEqpkqTzkQ1XPnDMnZqTcEMZ/gJrj3sBn45Ut3RMMbQZ/
 wzS/Km3SWCozgBIjkM3Ao/FJVOturnPR8teDEQmRP22mDiO5QxMDjDjTva/EdtyOdG0dRLRbLHB
 aOcVHd/HZvR4+lXAMQs3xypHfonWb+iWzI3eqIFQjCw/mr5J4w7SGs27X8hi5Z2UznbgOCOqt6E
 awvHblFBP6hw2D5fGNbLYSFhg9BZwPT6quTjvMRkP3owO4GlTBr7MPlPO+sdaHOcFAcWgdR7bq9
 pvHlbL7kBnN28MfRE/D3sZXoEOjeqhAZVrxrmIvJEW6NSk0xmK9fd6QlgCZZkAT7i4bhMFp4nPy
 pUys+DLvHwcrYulJY3Zg901i6b1fwRFYkju9q5MOgcA8=
X-Received: by 2002:a05:600c:1993:b0:45c:b5eb:b0c6 with SMTP id
 5b1f17b1804b1-45ddde80fd3mr64703075e9.5.1757326374136; 
 Mon, 08 Sep 2025 03:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/hbU9C9bwvGH+d1L3BSVfhHGWtFFlfeyDcmI+L4VfO0Ja+rylKh9RCbxakSRCb9sap/nU/Q==
X-Received: by 2002:a05:600c:1993:b0:45c:b5eb:b0c6 with SMTP id
 5b1f17b1804b1-45ddde80fd3mr64702415e9.5.1757326373292; 
 Mon, 08 Sep 2025 03:12:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf275d2717sm40935771f8f.15.2025.09.08.03.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:12:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 04/19] target-arm: remove uses of cpu_interrupt() for
 user-mode emulation
Date: Mon,  8 Sep 2025 12:12:26 +0200
Message-ID: <20250908101241.2110068-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Arm leaves around some functions that use cpu_interrupt(), even for
user-mode emulation when the code is unreachable.  Pull out the
system-mode implementation to a separate file, and add stubs for
CONFIG_USER_ONLY.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/internals.h |   5 +
 target/arm/cpu-irq.c   | 381 +++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c       | 370 ---------------------------------------
 target/arm/el2-stubs.c |  37 ++++
 target/arm/helper.c    |   4 +
 target/arm/meson.build |   2 +
 6 files changed, 429 insertions(+), 370 deletions(-)
 create mode 100644 target/arm/cpu-irq.c
 create mode 100644 target/arm/el2-stubs.c

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f5a1e75db37..f0aa26c5117 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1292,6 +1292,11 @@ static inline const char *aarch32_mode_name(uint32_t psr)
     return cpu_mode_names[psr & 0xf];
 }
 
+/**
+ * arm_cpu_exec_interrupt(): Implementation of the cpu_exec_inrerrupt hook.
+ */
+bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
+
 /**
  * arm_cpu_update_virq: Update CPU_INTERRUPT_VIRQ bit in cs->interrupt_request
  *
diff --git a/target/arm/cpu-irq.c b/target/arm/cpu-irq.c
new file mode 100644
index 00000000000..fe514cc93af
--- /dev/null
+++ b/target/arm/cpu-irq.c
@@ -0,0 +1,381 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * QEMU ARM CPU - interrupt_request handling
+ *
+ * Copyright (c) 2003-2025 QEMU contributors
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "accel/tcg/cpu-ops.h"
+#include "internals.h"
+
+#ifdef CONFIG_TCG
+static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
+                                     unsigned int target_el,
+                                     unsigned int cur_el, bool secure,
+                                     uint64_t hcr_el2)
+{
+    CPUARMState *env = cpu_env(cs);
+    bool pstate_unmasked;
+    bool unmasked = false;
+    bool allIntMask = false;
+
+    /*
+     * Don't take exceptions if they target a lower EL.
+     * This check should catch any exceptions that would not be taken
+     * but left pending.
+     */
+    if (cur_el > target_el) {
+        return false;
+    }
+
+    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
+        env->cp15.sctlr_el[target_el] & SCTLR_NMI && cur_el == target_el) {
+        allIntMask = env->pstate & PSTATE_ALLINT ||
+                     ((env->cp15.sctlr_el[target_el] & SCTLR_SPINTMASK) &&
+                      (env->pstate & PSTATE_SP));
+    }
+
+    switch (excp_idx) {
+    case EXCP_NMI:
+        pstate_unmasked = !allIntMask;
+        break;
+
+    case EXCP_VINMI:
+        if (!(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
+            /* VINMIs are only taken when hypervized.  */
+            return false;
+        }
+        return !allIntMask;
+    case EXCP_VFNMI:
+        if (!(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
+            /* VFNMIs are only taken when hypervized.  */
+            return false;
+        }
+        return !allIntMask;
+    case EXCP_FIQ:
+        pstate_unmasked = (!(env->daif & PSTATE_F)) && (!allIntMask);
+        break;
+
+    case EXCP_IRQ:
+        pstate_unmasked = (!(env->daif & PSTATE_I)) && (!allIntMask);
+        break;
+
+    case EXCP_VFIQ:
+        if (!(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
+            /* VFIQs are only taken when hypervized.  */
+            return false;
+        }
+        return !(env->daif & PSTATE_F) && (!allIntMask);
+    case EXCP_VIRQ:
+        if (!(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
+            /* VIRQs are only taken when hypervized.  */
+            return false;
+        }
+        return !(env->daif & PSTATE_I) && (!allIntMask);
+    case EXCP_VSERR:
+        if (!(hcr_el2 & HCR_AMO) || (hcr_el2 & HCR_TGE)) {
+            /* VIRQs are only taken when hypervized.  */
+            return false;
+        }
+        return !(env->daif & PSTATE_A);
+    default:
+        g_assert_not_reached();
+    }
+
+    /*
+     * Use the target EL, current execution state and SCR/HCR settings to
+     * determine whether the corresponding CPSR bit is used to mask the
+     * interrupt.
+     */
+    if ((target_el > cur_el) && (target_el != 1)) {
+        /* Exceptions targeting a higher EL may not be maskable */
+        if (arm_feature(env, ARM_FEATURE_AARCH64)) {
+            switch (target_el) {
+            case 2:
+                /*
+                 * According to ARM DDI 0487H.a, an interrupt can be masked
+                 * when HCR_E2H and HCR_TGE are both set regardless of the
+                 * current Security state. Note that we need to revisit this
+                 * part again once we need to support NMI.
+                 */
+                if ((hcr_el2 & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+                        unmasked = true;
+                }
+                break;
+            case 3:
+                /* Interrupt cannot be masked when the target EL is 3 */
+                unmasked = true;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        } else {
+            /*
+             * The old 32-bit-only environment has a more complicated
+             * masking setup. HCR and SCR bits not only affect interrupt
+             * routing but also change the behaviour of masking.
+             */
+            bool hcr, scr;
+
+            switch (excp_idx) {
+            case EXCP_FIQ:
+                /*
+                 * If FIQs are routed to EL3 or EL2 then there are cases where
+                 * we override the CPSR.F in determining if the exception is
+                 * masked or not. If neither of these are set then we fall back
+                 * to the CPSR.F setting otherwise we further assess the state
+                 * below.
+                 */
+                hcr = hcr_el2 & HCR_FMO;
+                scr = (env->cp15.scr_el3 & SCR_FIQ);
+
+                /*
+                 * When EL3 is 32-bit, the SCR.FW bit controls whether the
+                 * CPSR.F bit masks FIQ interrupts when taken in non-secure
+                 * state. If SCR.FW is set then FIQs can be masked by CPSR.F
+                 * when non-secure but only when FIQs are only routed to EL3.
+                 */
+                scr = scr && !((env->cp15.scr_el3 & SCR_FW) && !hcr);
+                break;
+            case EXCP_IRQ:
+                /*
+                 * When EL3 execution state is 32-bit, if HCR.IMO is set then
+                 * we may override the CPSR.I masking when in non-secure state.
+                 * The SCR.IRQ setting has already been taken into consideration
+                 * when setting the target EL, so it does not have a further
+                 * affect here.
+                 */
+                hcr = hcr_el2 & HCR_IMO;
+                scr = false;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            if ((scr || hcr) && !secure) {
+                unmasked = true;
+            }
+        }
+    }
+
+    /*
+     * The PSTATE bits only mask the interrupt if we have not overridden the
+     * ability above.
+     */
+    return unmasked || pstate_unmasked;
+}
+
+bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    CPUARMState *env = cpu_env(cs);
+    uint32_t cur_el = arm_current_el(env);
+    bool secure = arm_is_secure(env);
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+    uint32_t target_el;
+    uint32_t excp_idx;
+
+    /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
+
+    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
+        (arm_sctlr(env, cur_el) & SCTLR_NMI)) {
+        if (interrupt_request & CPU_INTERRUPT_NMI) {
+            excp_idx = EXCP_NMI;
+            target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
+            if (arm_excp_unmasked(cs, excp_idx, target_el,
+                                  cur_el, secure, hcr_el2)) {
+                goto found;
+            }
+        }
+        if (interrupt_request & CPU_INTERRUPT_VINMI) {
+            excp_idx = EXCP_VINMI;
+            target_el = 1;
+            if (arm_excp_unmasked(cs, excp_idx, target_el,
+                                  cur_el, secure, hcr_el2)) {
+                goto found;
+            }
+        }
+        if (interrupt_request & CPU_INTERRUPT_VFNMI) {
+            excp_idx = EXCP_VFNMI;
+            target_el = 1;
+            if (arm_excp_unmasked(cs, excp_idx, target_el,
+                                  cur_el, secure, hcr_el2)) {
+                goto found;
+            }
+        }
+    } else {
+        /*
+         * NMI disabled: interrupts with superpriority are handled
+         * as if they didn't have it
+         */
+        if (interrupt_request & CPU_INTERRUPT_NMI) {
+            interrupt_request |= CPU_INTERRUPT_HARD;
+        }
+        if (interrupt_request & CPU_INTERRUPT_VINMI) {
+            interrupt_request |= CPU_INTERRUPT_VIRQ;
+        }
+        if (interrupt_request & CPU_INTERRUPT_VFNMI) {
+            interrupt_request |= CPU_INTERRUPT_VFIQ;
+        }
+    }
+
+    if (interrupt_request & CPU_INTERRUPT_FIQ) {
+        excp_idx = EXCP_FIQ;
+        target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
+            goto found;
+        }
+    }
+    if (interrupt_request & CPU_INTERRUPT_HARD) {
+        excp_idx = EXCP_IRQ;
+        target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
+            goto found;
+        }
+    }
+    if (interrupt_request & CPU_INTERRUPT_VIRQ) {
+        excp_idx = EXCP_VIRQ;
+        target_el = 1;
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
+            goto found;
+        }
+    }
+    if (interrupt_request & CPU_INTERRUPT_VFIQ) {
+        excp_idx = EXCP_VFIQ;
+        target_el = 1;
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
+            goto found;
+        }
+    }
+    if (interrupt_request & CPU_INTERRUPT_VSERR) {
+        excp_idx = EXCP_VSERR;
+        target_el = 1;
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
+            /* Taking a virtual abort clears HCR_EL2.VSE */
+            env->cp15.hcr_el2 &= ~HCR_VSE;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_VSERR);
+            goto found;
+        }
+    }
+    return false;
+
+ found:
+    cs->exception_index = excp_idx;
+    env->exception.target_el = target_el;
+    cs->cc->tcg_ops->do_interrupt(cs);
+    return true;
+}
+#endif /* CONFIG_TCG */
+
+void arm_cpu_update_virq(ARMCPU *cpu)
+{
+    /*
+     * Update the interrupt level for VIRQ, which is the logical OR of
+     * the HCR_EL2.VI bit and the input line level from the GIC.
+     */
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VI) &&
+        !(arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
+        (env->irq_line_state & CPU_INTERRUPT_VIRQ);
+
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VIRQ)) {
+        if (new_state) {
+            cpu_interrupt(cs, CPU_INTERRUPT_VIRQ);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_VIRQ);
+        }
+    }
+}
+
+void arm_cpu_update_vfiq(ARMCPU *cpu)
+{
+    /*
+     * Update the interrupt level for VFIQ, which is the logical OR of
+     * the HCR_EL2.VF bit and the input line level from the GIC.
+     */
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VF) &&
+        !(arm_hcrx_el2_eff(env) & HCRX_VFNMI)) ||
+        (env->irq_line_state & CPU_INTERRUPT_VFIQ);
+
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VFIQ)) {
+        if (new_state) {
+            cpu_interrupt(cs, CPU_INTERRUPT_VFIQ);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_VFIQ);
+        }
+    }
+}
+
+void arm_cpu_update_vinmi(ARMCPU *cpu)
+{
+    /*
+     * Update the interrupt level for VINMI, which is the logical OR of
+     * the HCRX_EL2.VINMI bit and the input line level from the GIC.
+     */
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VI) &&
+                      (arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
+        (env->irq_line_state & CPU_INTERRUPT_VINMI);
+
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VINMI)) {
+        if (new_state) {
+            cpu_interrupt(cs, CPU_INTERRUPT_VINMI);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_VINMI);
+        }
+    }
+}
+
+void arm_cpu_update_vfnmi(ARMCPU *cpu)
+{
+    /*
+     * Update the interrupt level for VFNMI, which is the HCRX_EL2.VFNMI bit.
+     */
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    bool new_state = (arm_hcr_el2_eff(env) & HCR_VF) &&
+                      (arm_hcrx_el2_eff(env) & HCRX_VFNMI);
+
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VFNMI)) {
+        if (new_state) {
+            cpu_interrupt(cs, CPU_INTERRUPT_VFNMI);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_VFNMI);
+        }
+    }
+}
+
+void arm_cpu_update_vserr(ARMCPU *cpu)
+{
+    /*
+     * Update the interrupt level for VSERR, which is the HCR_EL2.VSE bit.
+     */
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    bool new_state = env->cp15.hcr_el2 & HCR_VSE;
+
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VSERR)) {
+        if (new_state) {
+            cpu_interrupt(cs, CPU_INTERRUPT_VSERR);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_VSERR);
+        }
+    }
+}
+
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d0f6fcdfcea..633ec55a57c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -686,376 +686,6 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
 }
 
 
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-
-static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
-                                     unsigned int target_el,
-                                     unsigned int cur_el, bool secure,
-                                     uint64_t hcr_el2)
-{
-    CPUARMState *env = cpu_env(cs);
-    bool pstate_unmasked;
-    bool unmasked = false;
-    bool allIntMask = false;
-
-    /*
-     * Don't take exceptions if they target a lower EL.
-     * This check should catch any exceptions that would not be taken
-     * but left pending.
-     */
-    if (cur_el > target_el) {
-        return false;
-    }
-
-    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
-        env->cp15.sctlr_el[target_el] & SCTLR_NMI && cur_el == target_el) {
-        allIntMask = env->pstate & PSTATE_ALLINT ||
-                     ((env->cp15.sctlr_el[target_el] & SCTLR_SPINTMASK) &&
-                      (env->pstate & PSTATE_SP));
-    }
-
-    switch (excp_idx) {
-    case EXCP_NMI:
-        pstate_unmasked = !allIntMask;
-        break;
-
-    case EXCP_VINMI:
-        if (!(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
-            /* VINMIs are only taken when hypervized.  */
-            return false;
-        }
-        return !allIntMask;
-    case EXCP_VFNMI:
-        if (!(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
-            /* VFNMIs are only taken when hypervized.  */
-            return false;
-        }
-        return !allIntMask;
-    case EXCP_FIQ:
-        pstate_unmasked = (!(env->daif & PSTATE_F)) && (!allIntMask);
-        break;
-
-    case EXCP_IRQ:
-        pstate_unmasked = (!(env->daif & PSTATE_I)) && (!allIntMask);
-        break;
-
-    case EXCP_VFIQ:
-        if (!(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
-            /* VFIQs are only taken when hypervized.  */
-            return false;
-        }
-        return !(env->daif & PSTATE_F) && (!allIntMask);
-    case EXCP_VIRQ:
-        if (!(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
-            /* VIRQs are only taken when hypervized.  */
-            return false;
-        }
-        return !(env->daif & PSTATE_I) && (!allIntMask);
-    case EXCP_VSERR:
-        if (!(hcr_el2 & HCR_AMO) || (hcr_el2 & HCR_TGE)) {
-            /* VIRQs are only taken when hypervized.  */
-            return false;
-        }
-        return !(env->daif & PSTATE_A);
-    default:
-        g_assert_not_reached();
-    }
-
-    /*
-     * Use the target EL, current execution state and SCR/HCR settings to
-     * determine whether the corresponding CPSR bit is used to mask the
-     * interrupt.
-     */
-    if ((target_el > cur_el) && (target_el != 1)) {
-        /* Exceptions targeting a higher EL may not be maskable */
-        if (arm_feature(env, ARM_FEATURE_AARCH64)) {
-            switch (target_el) {
-            case 2:
-                /*
-                 * According to ARM DDI 0487H.a, an interrupt can be masked
-                 * when HCR_E2H and HCR_TGE are both set regardless of the
-                 * current Security state. Note that we need to revisit this
-                 * part again once we need to support NMI.
-                 */
-                if ((hcr_el2 & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
-                        unmasked = true;
-                }
-                break;
-            case 3:
-                /* Interrupt cannot be masked when the target EL is 3 */
-                unmasked = true;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-        } else {
-            /*
-             * The old 32-bit-only environment has a more complicated
-             * masking setup. HCR and SCR bits not only affect interrupt
-             * routing but also change the behaviour of masking.
-             */
-            bool hcr, scr;
-
-            switch (excp_idx) {
-            case EXCP_FIQ:
-                /*
-                 * If FIQs are routed to EL3 or EL2 then there are cases where
-                 * we override the CPSR.F in determining if the exception is
-                 * masked or not. If neither of these are set then we fall back
-                 * to the CPSR.F setting otherwise we further assess the state
-                 * below.
-                 */
-                hcr = hcr_el2 & HCR_FMO;
-                scr = (env->cp15.scr_el3 & SCR_FIQ);
-
-                /*
-                 * When EL3 is 32-bit, the SCR.FW bit controls whether the
-                 * CPSR.F bit masks FIQ interrupts when taken in non-secure
-                 * state. If SCR.FW is set then FIQs can be masked by CPSR.F
-                 * when non-secure but only when FIQs are only routed to EL3.
-                 */
-                scr = scr && !((env->cp15.scr_el3 & SCR_FW) && !hcr);
-                break;
-            case EXCP_IRQ:
-                /*
-                 * When EL3 execution state is 32-bit, if HCR.IMO is set then
-                 * we may override the CPSR.I masking when in non-secure state.
-                 * The SCR.IRQ setting has already been taken into consideration
-                 * when setting the target EL, so it does not have a further
-                 * affect here.
-                 */
-                hcr = hcr_el2 & HCR_IMO;
-                scr = false;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-
-            if ((scr || hcr) && !secure) {
-                unmasked = true;
-            }
-        }
-    }
-
-    /*
-     * The PSTATE bits only mask the interrupt if we have not overridden the
-     * ability above.
-     */
-    return unmasked || pstate_unmasked;
-}
-
-static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-{
-    CPUARMState *env = cpu_env(cs);
-    uint32_t cur_el = arm_current_el(env);
-    bool secure = arm_is_secure(env);
-    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
-    uint32_t target_el;
-    uint32_t excp_idx;
-
-    /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
-
-    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
-        (arm_sctlr(env, cur_el) & SCTLR_NMI)) {
-        if (interrupt_request & CPU_INTERRUPT_NMI) {
-            excp_idx = EXCP_NMI;
-            target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
-            if (arm_excp_unmasked(cs, excp_idx, target_el,
-                                  cur_el, secure, hcr_el2)) {
-                goto found;
-            }
-        }
-        if (interrupt_request & CPU_INTERRUPT_VINMI) {
-            excp_idx = EXCP_VINMI;
-            target_el = 1;
-            if (arm_excp_unmasked(cs, excp_idx, target_el,
-                                  cur_el, secure, hcr_el2)) {
-                goto found;
-            }
-        }
-        if (interrupt_request & CPU_INTERRUPT_VFNMI) {
-            excp_idx = EXCP_VFNMI;
-            target_el = 1;
-            if (arm_excp_unmasked(cs, excp_idx, target_el,
-                                  cur_el, secure, hcr_el2)) {
-                goto found;
-            }
-        }
-    } else {
-        /*
-         * NMI disabled: interrupts with superpriority are handled
-         * as if they didn't have it
-         */
-        if (interrupt_request & CPU_INTERRUPT_NMI) {
-            interrupt_request |= CPU_INTERRUPT_HARD;
-        }
-        if (interrupt_request & CPU_INTERRUPT_VINMI) {
-            interrupt_request |= CPU_INTERRUPT_VIRQ;
-        }
-        if (interrupt_request & CPU_INTERRUPT_VFNMI) {
-            interrupt_request |= CPU_INTERRUPT_VFIQ;
-        }
-    }
-
-    if (interrupt_request & CPU_INTERRUPT_FIQ) {
-        excp_idx = EXCP_FIQ;
-        target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
-        if (arm_excp_unmasked(cs, excp_idx, target_el,
-                              cur_el, secure, hcr_el2)) {
-            goto found;
-        }
-    }
-    if (interrupt_request & CPU_INTERRUPT_HARD) {
-        excp_idx = EXCP_IRQ;
-        target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
-        if (arm_excp_unmasked(cs, excp_idx, target_el,
-                              cur_el, secure, hcr_el2)) {
-            goto found;
-        }
-    }
-    if (interrupt_request & CPU_INTERRUPT_VIRQ) {
-        excp_idx = EXCP_VIRQ;
-        target_el = 1;
-        if (arm_excp_unmasked(cs, excp_idx, target_el,
-                              cur_el, secure, hcr_el2)) {
-            goto found;
-        }
-    }
-    if (interrupt_request & CPU_INTERRUPT_VFIQ) {
-        excp_idx = EXCP_VFIQ;
-        target_el = 1;
-        if (arm_excp_unmasked(cs, excp_idx, target_el,
-                              cur_el, secure, hcr_el2)) {
-            goto found;
-        }
-    }
-    if (interrupt_request & CPU_INTERRUPT_VSERR) {
-        excp_idx = EXCP_VSERR;
-        target_el = 1;
-        if (arm_excp_unmasked(cs, excp_idx, target_el,
-                              cur_el, secure, hcr_el2)) {
-            /* Taking a virtual abort clears HCR_EL2.VSE */
-            env->cp15.hcr_el2 &= ~HCR_VSE;
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_VSERR);
-            goto found;
-        }
-    }
-    return false;
-
- found:
-    cs->exception_index = excp_idx;
-    env->exception.target_el = target_el;
-    cs->cc->tcg_ops->do_interrupt(cs);
-    return true;
-}
-
-#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
-
-void arm_cpu_update_virq(ARMCPU *cpu)
-{
-    /*
-     * Update the interrupt level for VIRQ, which is the logical OR of
-     * the HCR_EL2.VI bit and the input line level from the GIC.
-     */
-    CPUARMState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
-
-    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VI) &&
-        !(arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
-        (env->irq_line_state & CPU_INTERRUPT_VIRQ);
-
-    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VIRQ)) {
-        if (new_state) {
-            cpu_interrupt(cs, CPU_INTERRUPT_VIRQ);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_VIRQ);
-        }
-    }
-}
-
-void arm_cpu_update_vfiq(ARMCPU *cpu)
-{
-    /*
-     * Update the interrupt level for VFIQ, which is the logical OR of
-     * the HCR_EL2.VF bit and the input line level from the GIC.
-     */
-    CPUARMState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
-
-    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VF) &&
-        !(arm_hcrx_el2_eff(env) & HCRX_VFNMI)) ||
-        (env->irq_line_state & CPU_INTERRUPT_VFIQ);
-
-    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VFIQ)) {
-        if (new_state) {
-            cpu_interrupt(cs, CPU_INTERRUPT_VFIQ);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_VFIQ);
-        }
-    }
-}
-
-void arm_cpu_update_vinmi(ARMCPU *cpu)
-{
-    /*
-     * Update the interrupt level for VINMI, which is the logical OR of
-     * the HCRX_EL2.VINMI bit and the input line level from the GIC.
-     */
-    CPUARMState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
-
-    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VI) &&
-                      (arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
-        (env->irq_line_state & CPU_INTERRUPT_VINMI);
-
-    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VINMI)) {
-        if (new_state) {
-            cpu_interrupt(cs, CPU_INTERRUPT_VINMI);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_VINMI);
-        }
-    }
-}
-
-void arm_cpu_update_vfnmi(ARMCPU *cpu)
-{
-    /*
-     * Update the interrupt level for VFNMI, which is the HCRX_EL2.VFNMI bit.
-     */
-    CPUARMState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
-
-    bool new_state = (arm_hcr_el2_eff(env) & HCR_VF) &&
-                      (arm_hcrx_el2_eff(env) & HCRX_VFNMI);
-
-    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VFNMI)) {
-        if (new_state) {
-            cpu_interrupt(cs, CPU_INTERRUPT_VFNMI);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_VFNMI);
-        }
-    }
-}
-
-void arm_cpu_update_vserr(ARMCPU *cpu)
-{
-    /*
-     * Update the interrupt level for VSERR, which is the HCR_EL2.VSE bit.
-     */
-    CPUARMState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
-
-    bool new_state = env->cp15.hcr_el2 & HCR_VSE;
-
-    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VSERR)) {
-        if (new_state) {
-            cpu_interrupt(cs, CPU_INTERRUPT_VSERR);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_VSERR);
-        }
-    }
-}
-
 #ifndef CONFIG_USER_ONLY
 static void arm_cpu_set_irq(void *opaque, int irq, int level)
 {
diff --git a/target/arm/el2-stubs.c b/target/arm/el2-stubs.c
new file mode 100644
index 00000000000..972023c337f
--- /dev/null
+++ b/target/arm/el2-stubs.c
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* QEMU ARM CPU - user-mode emulation stubs for EL2 interrupts
+ *
+ * These should not really be needed, but CP registers for EL2
+ * are not elided by user-mode emulation and they call these
+ * functions.  Leave them as stubs until it's cleaned up.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+
+void arm_cpu_update_virq(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_update_vfiq(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_update_vinmi(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_update_vfnmi(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_update_vserr(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19637e7301b..fb62742d983 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2868,8 +2868,12 @@ static void omap_threadid_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void omap_wfi_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
+#ifdef CONFIG_USER_ONLY
+    g_assert_not_reached();
+#else
     /* Wait-for-interrupt (deprecated) */
     cpu_interrupt(env_cpu(env), CPU_INTERRUPT_HALT);
+#endif
 }
 
 static void omap_cachemaint_write(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 07d9271aa4d..914f1498fc5 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -26,6 +26,7 @@ arm_user_ss.add(files(
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
+  'el2-stubs.c',
 ))
 
 arm_common_system_ss.add(files('cpu.c'))
@@ -38,6 +39,7 @@ arm_common_system_ss.add(files(
   'arm-powerctl.c',
   'cortex-regs.c',
   'cpregs-pmu.c',
+  'cpu-irq.c',
   'debug_helper.c',
   'helper.c',
   'machine.c',
-- 
2.51.0


