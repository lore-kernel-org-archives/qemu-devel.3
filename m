Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF45CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11z-0005Xd-Ai; Thu, 07 May 2026 11:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11u-0005E3-Hf
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11s-00040s-K1
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:50 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so9829715e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169167; x=1778773967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H55FNyA92XWr1Xn6E9kb+2RAwZYK6j7XqkAEz4Sr6o4=;
 b=ecRWCHMi3l7eK/uQRowu6YI7k4q1OKWWnJsVTbAzzJqlNxicG2h2G9W3wbziR5TZmk
 Qa9qhoeG0s+2egTA8a2AZPzKjoQbHkTCBEoyDP1+z3LrGi/QLOeOty2UGL8v07ceFFJh
 xPCxpnq8aLDrrk9Bo7QbFLRRIaoeTTrTleGaocg8ewLbH/fhJ9raH+T9qETo2PI6nVk5
 zUQQ5IpuJnqSrsUxHaAWlLNcvQtlf8ouUjORC1ACVsgEI1Ef+tWIaBR7EoanTT1P9/b3
 wi4UUJLBfTrCARuu62pDQfEYvCjR2QK6QtDI/s9v16iuX39ONcO0w3Qg9YAYxRBuGXqZ
 OxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169167; x=1778773967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H55FNyA92XWr1Xn6E9kb+2RAwZYK6j7XqkAEz4Sr6o4=;
 b=MW8jv5D99clpoSzuOfACPbPGi4jJ1bVlQ+Wj1j9zi+V0U7bl8ofVuOhf9+usL+lT8a
 Q7NhrRHaNer9Bo5I9pmYlXH+4tAzgRNSiU7N/Eb3XwFcECwCmpHixgNrB0QtQQehRsJL
 yLYl7K/lzMd0vlaQQ+J/EIu1ROwNWWUb+Xz4lILyzGk6cQDLvQjRrH+PGJ1vH+smhBLG
 FUapkRcEglnE2AJrVJ56uqvoR/eewQaxuIpcoWmrclRrd/PF7IIdki8US0V7UfS+KBb3
 iEakfZdGlBfc1i0my4HOqVhGk4iiar1L94/GFio04mZ1vVc4RIeM2wy02dRV7HH2dAXI
 nnww==
X-Gm-Message-State: AOJu0YyoD+jCI166KG1poble64VMwIgQ90OJFq1SkFSD06QqATuTzvFz
 ucRfcrUyFre4pntZNsaTNHeM+I/+gxKgwYEMGkdJz45PoqHnpVgnjJqe6+LbjLKgzKGxMAX1ZAq
 zg76Z
X-Gm-Gg: AeBDiesNNYCCzJoW3acPBHmXVsBh1OMsnLmXx4Wps6bq/E4FR1CeoMiHiE03AGDjnhc
 l3AUB4pA22HUuP3e+u0scSC1QXEPqAfHJSl/Sxan9dU5XeECky6+TlF1EIeG1pEnAybxTk3xbVQ
 ku3ZSdaOVbtMG+W/90OjVvvVyN2iwyoIZtpZwHYJxbf/okFi8ZL5xUc3/ceZfl431cih7iBnuaz
 ad5b+iNMNQdzZ6PPctxPaGCI05UeKzUEbwBQXMsgoYCS7hcIjRo+TpY7zcxjo481kelAlOvW9rI
 3MmtGB8ctXkwrAwuG6laZFBkM3DEjW3w7BydQdtNCSWRQI4i/R+7ORQYaJrpcrsDZVAeNTSMgZS
 rTZV83ILNAUeAezogpnx9a/LMQbg+PPZXnnxo08bbsy6oonRYaOj+D292TcCMX24YIMXS2B2LOi
 82avqsaxCl/TYCsV18KF/OTMWxpSYR5iurgghnMuNOU40b2SexUoZal6YgLH7HUl8v6IVugi5wx
 3tkuhDN+Ns15MnitpQs1e10Ih0PDZY=
X-Received: by 2002:a05:600c:c0c1:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-48e51e1ee16mr105000935e9.10.1778169167037; 
 Thu, 07 May 2026 08:52:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/67] target/arm: GICv5 cpuif: Signal IRQ or FIQ
Date: Thu,  7 May 2026 16:51:39 +0100
Message-ID: <20260507155154.1886557-53-peter.maydell@linaro.org>
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

The CPU interface must signal IRQ or FIQ (possibly with
superpriority) when there is a pending interrupt of sufficient
priority available.  Implement this logic.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-53-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 87 ++++++++++++++++++++++++++++++++++--
 target/arm/tcg/trace-events  |  1 +
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 9dc754ff3a..27ad98769c 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -170,6 +170,84 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
     return best;
 }
 
+static void cpu_interrupt_update(CPUARMState *env, int irqtype, bool new_state)
+{
+    CPUState *cs = env_cpu(env);
+
+    /*
+     * OPT: calling cpu_interrupt() and cpu_reset_interrupt() has the
+     * correct behaviour, but is not optimal for the case where we're
+     * setting the interrupt line to the same level it already has.
+     *
+     * Clearing an already clear interrupt is free (it's just doing an
+     * atomic AND operation). Signalling an already set interrupt is a
+     * bit less ideal (it might unnecessarily kick the CPU).
+     *
+     * We could potentially use cpu_test_interrupt(), like
+     * arm_cpu_update_{virq,vfiq,vinmi,vserr}, since we always hold
+     * the BQL here; or perhaps there is an abstraction we could
+     * provide in the core code that all these places could call.
+     *
+     * For now, this is simple and definitely correct.
+     */
+    if (new_state) {
+        cpu_interrupt(cs, irqtype);
+    } else {
+        cpu_reset_interrupt(cs, irqtype);
+    }
+}
+
+static void gicv5_update_irq_fiq(CPUARMState *env)
+{
+    /*
+     * Update whether we are signalling IRQ or FIQ based on the
+     * current state of the CPU interface (and in particular on the
+     * HPPI information from the IRS and for the PPIs for each
+     * interrupt domain);
+     *
+     * The logic here for IRQ and FIQ is defined by rules R_QLGBG and
+     * R_ZGHMN; whether to signal with superpriority is defined by
+     * rule R_CSBDX.
+     *
+     * For the moment, we do not consider preemptive interrupts,
+     * because these only occur when there is a HPPI of sufficient
+     * priority for another interrupt domain, and we only support EL1
+     * and the NonSecure interrupt domain currently.
+     *
+     * NB: when we handle more than just EL1 we will need to arrange
+     * to call this function to re-evaluate the IRQ and FIQ state when
+     * we change EL.
+     */
+    GICv5PendingIrq current_hppi;
+    bool irq, fiq, superpriority;
+
+    /*
+     * We will never signal FIQ because FIQ is for preemptive
+     * interrupts or for EL3 HPPIs.
+     */
+    fiq = false;
+
+    /*
+     * We signal IRQ when we are not signalling FIQ and there is a
+     * HPPI of sufficient priority for the current domain. It has
+     * Superpriority if its priority is 0 (in which case it is
+     * CPU_INTERRUPT_NMI rather than CPU_INTERRUPT_HARD).
+     */
+    current_hppi = gic_hppi(env, gicv5_current_phys_domain(env));
+    superpriority = current_hppi.prio == 0;
+    irq = current_hppi.prio != PRIO_IDLE && !superpriority;
+
+    /*
+     * Unlike a GICv3 or GICv2, there is no external IRQ or FIQ line
+     * to the CPU. Instead we directly signal the interrupt via
+     * cpu_interrupt()/cpu_reset_interrupt().
+     */
+    trace_gicv5_update_irq_fiq(irq, fiq, superpriority);
+    cpu_interrupt_update(env, CPU_INTERRUPT_HARD, irq);
+    cpu_interrupt_update(env, CPU_INTERRUPT_FIQ, fiq);
+    cpu_interrupt_update(env, CPU_INTERRUPT_NMI, superpriority);
+}
+
 static void gic_recalc_ppi_hppi(CPUARMState *env)
 {
     /*
@@ -219,15 +297,16 @@ static void gic_recalc_ppi_hppi(CPUARMState *env)
                                     env->gicv5_cpuif.ppi_hppi[i].intid,
                                     env->gicv5_cpuif.ppi_hppi[i].prio);
     }
+    gicv5_update_irq_fiq(env);
 }
 
 void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain)
 {
     /*
-     * For now, we do nothing. Later we will recalculate the overall
-     * HPPI by combining the IRS HPPI with the PPI HPPI, and possibly
-     * signal IRQ/FIQ.
+     * IRS HPPI has changed: recalculate the IRQ/FIQ levels by
+     * combining the IRS HPPI with the PPI HPPI.
      */
+    gicv5_update_irq_fiq(&cpu->env);
 }
 
 static void gic_cddis_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -430,6 +509,7 @@ static void gic_icc_cr0_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     value |= R_ICC_CR0_LINK_MASK | R_ICC_CR0_LINK_IDLE_MASK;
 
     env->gicv5_cpuif.icc_cr0[domain] = value;
+    gicv5_update_irq_fiq(env);
 }
 
 static void gic_icc_cr0_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -571,6 +651,7 @@ static void gic_cdeoi_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     /* clear lowest bit, doing nothing if already zero */
     *apr &= *apr - 1;
+    gicv5_update_irq_fiq(env);
 }
 
 static void gic_cddi_write(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index c60ce6834e..2bfa8fc552 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -7,3 +7,4 @@ gicv5_gicr_cdia_fail(int domain, const char *reason) "domain %d CDIA attempt fai
 gicv5_gicr_cdia(int domain, uint32_t id) "domain %d CDIA acknowledge of interrupt 0x%x"
 gicv5_cdeoi(int domain) "domain %d CDEOI performing priority drop"
 gicv5_cddi(int domain, uint32_t id) "domain %d CDDI deactivating interrupt ID 0x%x"
+gicv5_update_irq_fiq(bool irq, bool fiq, bool nmi) "now IRQ %d FIQ %d NMI %d"
-- 
2.43.0


