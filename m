Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96622EC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZM2-00040G-LS; Mon, 23 Feb 2026 12:04:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL8-0002lh-9P
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:25 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL0-0000Ok-V9
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48370174e18so24815575e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866192; x=1772470992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LsWZT0xdosvafwLgM597XKJG/8r1Q60yrGNVHaliPSM=;
 b=Fn8guHR19VRYYlO4Y+MoLw6RY5yx4U+o0urK4WZVHSZQljEhZaOL8iqcA/MfY7tiN4
 y/eCnoEDIDX3WDAx7i37p3qCGqLxTolENKIIMlsNYWFF7YZrQfZJAcW68iCifP1Dp3Xs
 VlQ9VcVAj8zXB2Xv6KkTl+lx9ec/9+JlMw2ILezlOfrFM3b6aOME47da/7PxPAkJqTOW
 FBwTDjNsicBphKl2stvsTeTUzaXrBIluoajaZval1trBW3YdbiZh7WaOjzAsevuJVaWh
 X61orN2mviSOCPdN6qs1PA9XBPG0+AgPKehryM3to1IPQHS+zQkUY1+sL1Rgzzr/xK02
 apYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866192; x=1772470992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LsWZT0xdosvafwLgM597XKJG/8r1Q60yrGNVHaliPSM=;
 b=EeLc0ggxh0fDzs1wrpj9Bo/v1OBNzjzcnyttcMTfsus/m/DkcSb2B8FaUZy3Wh90eK
 TAso3OCGE2Vng+ro/vRaH5FcdJ8IWUP/nPaz+S1IjslBC4epZxmharEw3EQxjU5OytlP
 ZOu8SDBdA755rQVSCLH0R7CW5Jfl0C9gYFUqcedco3DBt20bDlBrbBBJ/SVZDA0So984
 vt9Eix+MlhSOWWPUnUd80wWH3QIUOS7mem0tHsNEkGYNG5P7pvvyjVj6WMl7lM3mvaKx
 hhXvya9bizmAmpqNueFrWh1WUq6oq5jWYGsbLcpQpXMJdYFhclSh5ljBaqR2yJhsKTA+
 5Owg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5nUPV+v9EU9nFYgS5ve8kf6zN1q/T6hGQ4JKCo31igt8Yro7w/aZO5CxR5jtH6PtQXTXwZ3Y0ODx2@nongnu.org
X-Gm-Message-State: AOJu0YyW+oVSPAZcFSKzJVBMBdvbWXnO7851dmpvGsiBGBT/5iiUKbdp
 w9MGUX6enIfryeky1Y7XXHWO3hk/riOBRRm4rH3Nup6jyhAPXga8CXZe1T11FGNiu7g=
X-Gm-Gg: AZuq6aLjQiq5djWo/FayDtj+CtaOrbpSipu439L2+HIL9UjNfy0ocJYlrGrWQBWu0Qu
 u1JDjyfO/OcSMCDihXzpjl+zROalhO5EcdQvygQi6Iqa70gQMO9ieaweG7mGtSLGdSKuJSYN5nG
 Fv0t/4hTUUYj9qugGsQxd861M0ZNsQjR9i1dZfdvEccgHubvPKX4bALInzhiUvg/OPWCSTWaRwp
 McewrCtgEkjWluXg2lRfIu70UYooDbhMIYWuJXjTKx0l8UhhUEklR0LvzCw6OJ7KarEDkeiVqNK
 59pfzqiaGfiWWi2Ld+9122uRSDvvwQqIiUt+vFKHaUtOK97VmWNzgVxnJOAegiR6maF/NvWepMw
 2JkgeAXQIIYIinwr90Kww+P4c1oUFC3yzX6CpheEt7/QGN9W9UcvagAcP6C+Uw7KRJQS+8qFvu9
 Ug7XdZGYvJTuM1lF43QDnuytLuezV9wgiq0ZBvqPhqr3wZiGBOvfLv7Zw6CNmtL1Zj2jU0/wkem
 6DHLudAF89CJdPETLPtvDlCGgezOeo=
X-Received: by 2002:a05:600c:8b01:b0:483:7f4e:fef4 with SMTP id
 5b1f17b1804b1-483a95fb1e5mr166585915e9.25.1771866191807; 
 Mon, 23 Feb 2026 09:03:11 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 51/65] target/arm: GICv5 cpuif: Signal IRQ or FIQ
Date: Mon, 23 Feb 2026 17:01:58 +0000
Message-ID: <20260223170212.441276-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The CPU interface must signal IRQ or FIQ (possibly with
superpriority) when there is a pending interrupt of sufficient
priority available.  Implement this logic.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 91 ++++++++++++++++++++++++++++++++++--
 target/arm/tcg/trace-events  |  1 +
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 02129d5936..79203a3478 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -171,6 +171,88 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
     return best;
 }
 
+static void cpu_interrupt_update(CPUARMState *env, int irqtype, bool new_state)
+{
+    CPUState *cs = env_cpu(env);
+
+    /*
+     * OPT: calling cpu_interrupt() and cpu_reset_interrupt()
+     * has the correct behaviour, but is not optimal for the
+     * case where we're setting the interrupt line to the same
+     * level it already has.
+     *
+     * Clearing an already clear interrupt is free (it's just
+     * doing an atomic AND operation). Signalling an already set
+     * interrupt is a bit less ideal (it might unnecessarily kick
+     * the CPU).
+     *
+     * We could potentially use cpu_test_interrupt(), like
+     * arm_cpu_update_{virq,vfiq,vinmi,vserr}, since we always
+     * hold the BQL here; or perhaps there is an abstraction
+     * we could provide in the core code that all these places
+     * could call.
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
+     * Update whether we are signalling IRQ or FIQ based
+     * on the current state of the CPU interface (and in
+     * particular on the HPPI information from the IRS and
+     * for the PPIs for each interrupt domain);
+     *
+     * The logic here for IRQ and FIQ is defined by rules R_QLGBG
+     * and R_ZGHMN; whether to signal with superpriority is
+     * defined by rule R_CSBDX.
+     *
+     * For the moment, we do not consider preemptive interrupts,
+     * because these only occur when there is a HPPI of
+     * sufficient priority for another interrupt domain, and
+     * we only support EL1 and the NonSecure interrupt domain
+     * currently.
+     *
+     * NB: when we handle more than just EL1 we will need to
+     * arrange to call this function to re-evaluate the IRQ
+     * and FIQ state when we change EL.
+     */
+    GICv5PendingIrq current_hppi;
+    bool irq, fiq, superpriority;
+
+    /*
+     * We will never signal FIQ because FIQ is for
+     * preemptive interrupts or for EL3 HPPIs.
+     */
+    fiq = false;
+
+    /*
+     * We signal IRQ when we are not signalling FIQ and there is a
+     * HPPI of sufficient priority for the current domain. It
+     * has Superpriority if its priority is 0 (in which case it
+     * is CPU_INTERRUPT_NMI rather than CPU_INTERRUPT_HARD).
+     */
+    current_hppi = gic_hppi(env, gicv5_current_phys_domain(env));
+    superpriority = current_hppi.prio == 0;
+    irq = current_hppi.prio != PRIO_IDLE && !superpriority;
+
+    /*
+     * Unlike a GICv3 or GICv2, there is no external IRQ or FIQ
+     * line to the CPU. Instead we directly signal the interrupt
+     * via cpu_interrupt()/cpu_reset_interrupt().
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
@@ -220,15 +302,16 @@ static void gic_recalc_ppi_hppi(CPUARMState *env)
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
@@ -431,6 +514,7 @@ static void gic_icc_cr0_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     value |= R_ICC_CR0_LINK_MASK | R_ICC_CR0_LINK_IDLE_MASK;
 
     env->gicv5_cpuif.icc_cr0[domain] = value;
+    gicv5_update_irq_fiq(env);
 }
 
 static void gic_icc_cr0_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -573,6 +657,7 @@ static void gic_cdeoi_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
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


