Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3A9EC1116
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZM4-0004DU-Ig; Mon, 23 Feb 2026 12:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL5-0002l7-3V
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:25 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL0-0000PL-PV
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:16 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-483a233819aso44127035e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866193; x=1772470993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XMQWuPhIDut2O0s+aFZoLKQHJbGUaVGr5s2jDaUa4BU=;
 b=LKJO2Xt8hZi3G4xEAUQfWfD5rdN1ZIDhlmIyEokYPLr08IDkJWxqqR9pt2tYw4Ig2f
 7/Nx0PxLbwuhybt/6TaSEcUTUIHqnvde10p/SpwQ7aYLo94xF2UOVjIK9FIpemDO/saH
 PuIpBSX6paY+f52w4Fagu18blxkobnVXDqa4K8fBBQPZgJNuz7Wqez+ZaYzIvsuOdhU1
 onCNGV3/AVKAE2469ble6Zuc02UuqBF9WWfwMDz/0y+IrBhUt1F9DXgjBusDhg+pMGG8
 7arwar5qcTnS9DXmBvfK67+L0+twVXsODnacjTQPHt40KHO+9Q5yci+mWRiwZwt0OlxC
 jExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866193; x=1772470993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XMQWuPhIDut2O0s+aFZoLKQHJbGUaVGr5s2jDaUa4BU=;
 b=BfU8wYaht8mylzYyNeyX542B5PlAJEJKx6rwA4AW4mh6LOV3PqDc1grg9/jnGFVIT0
 TpaUeoguZVI4hyMupQedIpjoyAkJ288zwJNUvBcMXN8eSVxfq94+f++p6yxhi4ZRSGM3
 YXkO4gv8c6WnXSg6TW3HM4oZ5pCda0/aboQclsPbd/pRVdQphDkL8jWQbJuIHQO9diDP
 NNkWI7PV8AXzw8ffLf0+Wh5b0p7czXcuc13+QknVuSuibS0shf2n/mAqWC1YKiS1G0dO
 4ysNogFWpf7L1+ZhVv4wr2KuLBjkC433poZ2PAsj9ydAtLBCoJg2yAwOQyss5OwgzD3G
 5zOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1qhz9xF42Lpqh8xfV7dHBDMXrzhC66u5BYhzEd35Ihz2mQT0zzhy7vPhCpPy3OpjQuqexlBn4OLsU@nongnu.org
X-Gm-Message-State: AOJu0YyIucpf53P0fUYpd3jor53Ao62mdd+ByIOG3yBgHhRwu8KNeLCP
 J2PtG9UA9KNpMxjUnLLt5fEJwX7k8KjEsin5P/TTSiuqWdJfvQLixbcWia6oyThuXL4=
X-Gm-Gg: AZuq6aJ9CddRfscjQp1KgOpR6qRRvw+7tdKDuTzcd7R6mCKcxKXz9Yx7lo5WHEdKfJh
 pZ73xIJ9YNis3EPhZkblmrxbe0vfqXRFUOyTWRPeA/P1hyxBPGA07IDPeSd4uQ/c69xtsn96+mg
 PiYmtPR8NPS4lJeK1rjqn3A1WLW7Sx9/lzd0Bu+l0P3aU/SMEARAhV7Sogea8AEVSGBJi/ikDC8
 aY9+rZTd97RTeBmfvuyQKm5bpkrjojokIVlNfJQTlX7kNOt2pA2HaPkG4GpZtby0r7O6VqncJW+
 AP/sCs+0Onnpir47g6h9XGbkjF8otF/73H6JIv+3eUBq+EHmkxTMwOfPHeP59ExIVPtXPuToMG6
 0CvT92EnRdJnir0aVlx4uIGDJq6zh9CygpHWTrq8HfiCnu9X7+xFmLmaoZKmNOMUJi7QtP8ABfm
 n/X8UkNzymS8jgWLZWBnuJzGmt9q967ySWYOeCuh3K6FcOaunMcP6SCs9dHYr+aUCqTp9jDuwTc
 FbQT3Iqzxx6A5T7q+Sfn/K5oSAZgbBpAoHm8KfVtw==
X-Received: by 2002:a05:600c:6298:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-483a95fb23amr149700365e9.10.1771866192729; 
 Mon, 23 Feb 2026 09:03:12 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 52/65] target/arm: Connect internal interrupt sources up as
 GICv5 PPIs
Date: Mon, 23 Feb 2026 17:01:59 +0000
Message-ID: <20260223170212.441276-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The CPU has several interrupt sources which are exposed as GICv5
PPIs.  For QEMU, this means the generic timers and the PMU.

In GICv3, we implemented these as qemu_irq lines which connect up to
the external interrupt controller device.  In a GICv5, the PPIs are
handled entirely inside the CPU interface, so there are no external
signals.  Instead we provide a gicv5_update_ppi_state() function
which the emulated timer and PMU code uses to tell the CPU interface
about the new state of the PPI source.

We make the GICv5 function a no-op if there is no GICv5 present, so
that calling code can do both "update the old irq lines" and "update
the GICv5 PPI" without having to add conditionals.  (In a GICv5
system the old irq lines won't be connected to anything, so the
qemu_set_irq() will be a no-op.)

Updating PPIs via either mechanism is unnecessary in user-only mode;
we got away with not ifdeffing this away before because
qemu_set_irq() is built for user-only mode, but since the GICv5 cpuif
code is system-emulation only, we do need an ifdef now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs-pmu.c      |  9 +++++++--
 target/arm/helper.c          | 20 ++++++++++++++++++++
 target/arm/internals.h       |  6 ++++++
 target/arm/tcg/gicv5-cpuif.c | 28 ++++++++++++++++++++++++++++
 target/arm/tcg/trace-events  |  1 +
 5 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
index 47e1e4652b..46df6597b1 100644
--- a/target/arm/cpregs-pmu.c
+++ b/target/arm/cpregs-pmu.c
@@ -428,9 +428,14 @@ static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
 
 static void pmu_update_irq(CPUARMState *env)
 {
+#ifndef CONFIG_USER_ONLY
     ARMCPU *cpu = env_archcpu(env);
-    qemu_set_irq(cpu->pmu_interrupt, (env->cp15.c9_pmcr & PMCRE) &&
-            (env->cp15.c9_pminten & env->cp15.c9_pmovsr));
+    bool level = (env->cp15.c9_pmcr & PMCRE) &&
+        (env->cp15.c9_pminten & env->cp15.c9_pmovsr);
+
+    gicv5_update_ppi_state(env, GICV5_PPI_PMUIRQ, level);
+    qemu_set_irq(cpu->pmu_interrupt, level);
+#endif
 }
 
 static bool pmccntr_clockdiv_enabled(CPUARMState *env)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5e7cc039aa..a6bad8eba3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1348,6 +1348,21 @@ uint64_t gt_get_countervalue(CPUARMState *env)
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / gt_cntfrq_period_ns(cpu);
 }
 
+static void gt_update_gicv5_ppi(CPUARMState *env, int timeridx, bool level)
+{
+    static int timeridx_to_ppi[] = {
+        [GTIMER_PHYS] = GICV5_PPI_CNTP,
+        [GTIMER_VIRT] = GICV5_PPI_CNTV,
+        [GTIMER_HYP] = GICV5_PPI_CNTHP,
+        [GTIMER_SEC] = GICV5_PPI_CNTPS,
+        [GTIMER_HYPVIRT] = GICV5_PPI_CNTHV,
+        [GTIMER_S_EL2_PHYS] = GICV5_PPI_CNTHPS,
+        [GTIMER_S_EL2_VIRT] = GICV5_PPI_CNTHVS,
+    };
+
+    gicv5_update_ppi_state(env, timeridx_to_ppi[timeridx], level);
+}
+
 static void gt_update_irq(ARMCPU *cpu, int timeridx)
 {
     CPUARMState *env = &cpu->env;
@@ -1366,6 +1381,11 @@ static void gt_update_irq(ARMCPU *cpu, int timeridx)
         irqstate = 0;
     }
 
+    /*
+     * We update both the GICv5 PPI and the external-GIC irq line
+     * (whichever of the two mechanisms is unused will do nothing)
+     */
+    gt_update_gicv5_ppi(env, timeridx, irqstate);
     qemu_set_irq(cpu->gt_timer_outputs[timeridx], irqstate);
     trace_arm_gt_update_irq(timeridx, irqstate);
 }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9bde58cf00..afe893f49d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1800,6 +1800,12 @@ void define_gcs_cpregs(ARMCPU *cpu);
 /* Add the cpreg definitions for the GICv5 CPU interface */
 void define_gicv5_cpuif_regs(ARMCPU *cpu);
 
+/*
+ * Update the state of the given GICv5 PPI for this CPU. Does nothing
+ * if the GICv5 is not present.
+ */
+void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level);
+
 /* Effective value of MDCR_EL2 */
 static inline uint64_t arm_mdcr_el2_eff(CPUARMState *env)
 {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 79203a3478..d30617d143 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -314,6 +314,34 @@ void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain)
     gicv5_update_irq_fiq(&cpu->env);
 }
 
+void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level)
+{
+    /*
+     * Update the state of the given PPI (which is connected to some
+     * CPU-internal source of interrupts, like the timers).
+     * We can assume that the PPI is fixed as level-triggered,
+     * which means that its pending state exactly tracks the input
+     * (and the guest cannot separately change the pending state,
+     * because the pending bits are RO).
+     */
+    int oldlevel;
+
+    if (!cpu_isar_feature(aa64_gcie, env_archcpu(env))) {
+        return;
+    }
+
+    /* The architected PPIs are 0..63, so in the first PPI register. */
+    assert(ppi >= 0 && ppi < 64);
+    oldlevel = extract64(env->gicv5_cpuif.ppi_pend[0], ppi, 1);
+    if (oldlevel != level) {
+        trace_gicv5_update_ppi_state(ppi, level);
+
+        env->gicv5_cpuif.ppi_pend[0] =
+            deposit64(env->gicv5_cpuif.ppi_pend[0], ppi, 1, level);
+        gic_recalc_ppi_hppi(env);
+    }
+}
+
 static void gic_cddis_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index 2bfa8fc552..bf1803c872 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -8,3 +8,4 @@ gicv5_gicr_cdia(int domain, uint32_t id) "domain %d CDIA acknowledge of interrup
 gicv5_cdeoi(int domain) "domain %d CDEOI performing priority drop"
 gicv5_cddi(int domain, uint32_t id) "domain %d CDDI deactivating interrupt ID 0x%x"
 gicv5_update_irq_fiq(bool irq, bool fiq, bool nmi) "now IRQ %d FIQ %d NMI %d"
+gicv5_update_ppi_state(int ppi, bool level) "PPI %d source level now %d"
-- 
2.43.0


