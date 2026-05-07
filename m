Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DB8CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11x-0005Pk-Og; Thu, 07 May 2026 11:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11v-0005I6-IE
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:52 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11t-00041A-HV
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891f625344so12054795e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169168; x=1778773968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XsFeWKZW9AodnzAAvDj5JSQ1dtOxWY1ouaFHOvVYjBc=;
 b=hvpHeqzmWJKDhK4g1e5xYMEuFJo2uiJrZbuMjsGZSESqrJed9T4JDQxGQbOR5ULmMG
 2RdA+sOuitN2ID5Cv06QZqw769ZmbvqrOaEo2g3WC1ZzmiYCQxOwC8f7pLbfD3zXw35x
 IGZJDczY4H9CsSr4kEnuat64ym+0qquUtxbpDx+2OCvYeyVPi7HY465lxSwxHSgmgX92
 M2vFeWnp3wJR4v6jU49/6G7Ymi/wLCcbQSevTBHQd4lqfp4qn5cBXyiPVaLAMqUsXQK6
 q6SZNf90WCDyV90E5zaEvgTcJ8cdvUx8/Uk1jrTSdE4/fY3LeMFm5biAE0YuhdZnpPWf
 nusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169168; x=1778773968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XsFeWKZW9AodnzAAvDj5JSQ1dtOxWY1ouaFHOvVYjBc=;
 b=i/JEWTDOYNLwXlW2dH7HXUT7Xr7GDScF2fZ6V3LPJ/u4SQbLplFw861D37h8QEKQCp
 sTiT4x1NNm0S0LTj6WQoaqApHbRQcggoe+pGzGXn4Vdlp4Hge0OHXcswUiB0fhBwg9tY
 CHh0kPoAIKm5WtZolxLYjyEgH8ySOEh7qITBDBxWW+29vJ73ju41BNLZdJJx1atnk5in
 PWPyh9Kf554qBt49a6Pl8hKKJnpw6p41yhSdPk0bjtZ+VZXwdCar/Z/msUJfuCfdvTkZ
 IsIoHaOISz/RH7Gz8nerIEle2rfVVXC/KAYfvN35+4lgVtJGdJVfosnaGUC+c4FAVJNd
 HknA==
X-Gm-Message-State: AOJu0YwokOWVlydCDSrjlNFvO1itIAuAPExYcHvX3mYCc4bQy6hoIqZE
 RH29o1LBb12B8peEWEFVEr6+6XOSgs5P1zVAodQ8IuHS3Xp9A0VA4NSAee91/w1LSQ0oJjj3itu
 yl/Y+
X-Gm-Gg: AeBDieuPjJYI+jGoGbQuyzFr8wuRAZA/fCb2XEvqmWYblFU8V3rmAR/vlAUYea8KFkf
 s8cxjVY2Ud+/7Kq9GIWyaDzjVBY8vOBJ0Tww4LUOToo75SWX/rt066qDK7xseyrGuHUNU+f1q+z
 7ZVJTvAZkHkDBCwJy1mwirFO4Dhz5t9b2/mDkY0/QcBrg0N7+Mt0iZCR6CrFDkxpdb5IFlmRVkR
 nxIii9o6P6+gx/eO0SRcP6e/FW6DkFDs4UL5rkjJ7/tVLO7nZyGIOXsI0r7zQo5o2yp6c5pXmyF
 AS6PLGaRURJbR6enLqvdfzbVesn1k0TwH/onMZWYf/IZiyU0fo6zGCogybEN4TC6ryqGIBzs3JK
 PPh17FGu/iE1lKmeLmRFAohP0AV06RucVCoveYx/CUBGuS2ula8rpvd/TvvOwVAqZ6PctNPDI3B
 3mXLOjgpIgkqn2L0CG005dSgwI072JKEIq7xNas/R9Qn+rKk3XCXpxSXXGaSllCv/rAf+K52FW0
 nccfncATa7ryOumCFjZ5d38CEXmt24=
X-Received: by 2002:a05:600c:630f:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-48e5dffab3dmr54373965e9.10.1778169167916; 
 Thu, 07 May 2026 08:52:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/67] target/arm: Connect internal interrupt sources up as
 GICv5 PPIs
Date: Thu,  7 May 2026 16:51:40 +0100
Message-ID: <20260507155154.1886557-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-54-peter.maydell@linaro.org
---
 target/arm/cpregs-pmu.c      |  9 +++++++--
 target/arm/helper.c          | 20 ++++++++++++++++++++
 target/arm/internals.h       |  6 ++++++
 target/arm/tcg-stubs.c       |  4 ++++
 target/arm/tcg/gicv5-cpuif.c | 28 ++++++++++++++++++++++++++++
 target/arm/tcg/trace-events  |  1 +
 6 files changed, 66 insertions(+), 2 deletions(-)

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
index d9751cf202..8240f1b384 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1343,6 +1343,21 @@ uint64_t gt_get_countervalue(CPUARMState *env)
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
@@ -1361,6 +1376,11 @@ static void gt_update_irq(ARMCPU *cpu, int timeridx)
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
index 6431029db8..86b41b4724 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1813,6 +1813,12 @@ void define_omap_cp_regs(ARMCPU *cpu);
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
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index aeeede8066..8d97449cfc 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -43,3 +43,7 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env)
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
 {
 }
+
+void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level)
+{
+}
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 27ad98769c..bc44a7fc11 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -309,6 +309,34 @@ void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain)
     gicv5_update_irq_fiq(&cpu->env);
 }
 
+void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level)
+{
+    /*
+     * Update the state of the given PPI (which is connected to some
+     * CPU-internal source of interrupts, like the timers).  We can
+     * assume that the PPI is fixed as level-triggered, which means
+     * that its pending state exactly tracks the input (and the guest
+     * cannot separately change the pending state, because the pending
+     * bits are RO).
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


