Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AECD606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=N7NvfbV/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsES-0006Rh-5p; Mon, 02 Nov 2026 08:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDH-0003Wf-Ax
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:40 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDE-0002LE-PM
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:39 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so2596935f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626595; x=1794231395; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MnwTUYj9KZuaJOlvQU/ohahBenkk1bltTHhNW/HtvbQ=;
 b=N7NvfbV/MxGHTZklsmoD3PExf2t2qKS6vkoHE3FgX5z0s2DCaKIyLLruxumz/yChCZ
 1GU7EUU3V1MEoEQDSfd9avwmtMbPy6+kVJJ7VFkTmdFxPxDIGnQNMjVkpYhtHbkITHgZ
 mjKKvm3JRCXbqCoTcAKq5/4qgQLU49Q4j3Nwpdij0HVdbosXxKLCUbUyGrZ1iB+S9fgd
 bJZWqBTTDhyntsdSoI57+eXUJkGomc13IfPaB09MiSHdqmz/6yDXQ7xZKGTShrwGkN8t
 uiYxXkyKYoWNlMKvVHHwc5nP4ftyGqPoQMorpDYR6pFvK1iO8ejE33IiJ2fFm48USFw8
 g7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626595; x=1794231395;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MnwTUYj9KZuaJOlvQU/ohahBenkk1bltTHhNW/HtvbQ=;
 b=YiA9Qb2+BRqtutfNZnThRJcU0ss1R1t/jkXYLfjW1kOH1ugxaV4mtHThnpx7bcDWC5
 /u3+YCoRyzzrUIRr8K8lOeHN37oeD8j3El0d6Dl6SKP0tLxChm//p5LrR/upidQWrw/U
 +dsO2DL07hGiBUvpg8Egn2fJOG7gS/kP+siFZ8c3O9+oRz1aMvOjKYQ74UKo7RiBXmkM
 Y5W0Tqb+WQ9L1+0FeCv1+7NtyJYASPJT2iD0IeHqkKCVjw0ok25rckXoDB4lXSPysXPo
 gGokFroCZZZm8qvAd7XpOYCdjdXnmdiu1xL8nKih1Ee7zuAX3e5Bze9fO3YgSTrLSzHG
 ArqA==
X-Gm-Message-State: APuU4Z8VWzS0Atary1ntZ5SZQPxFQqoj/AX4pehpFONJrGquekkECCjI
 gx4prMRkyKFvOsNrvwtO05DFmli4GTfCeY92hyML5Ny8Cm1WyLcVNk81zAK+WjXnhqDCAe1p0ZZ
 wcwhoU+w=
X-Gm-Gg: AYBFou0tsStSlcIw7xa6vy4dF0Uwf5QyYnubA/iAaJgLtVgvVIAyfhzgFl0QQ1ZDmjW
 iptf8THkM5JULMXrmbgrlBFSWLwN0MLqRdtiXsMj8Q/jwFQ1obUEuu3urZYLHvm9aq8M41OXOZP
 772Pm0BbWd4vuzqOx5rEsWWI33SRou+2TO7N+J6SefkgJl/wzzA/Ceo27dHPQWrE+xZ4injBcta
 lxRPgefdiHlGNLMHaHGqZ6QRXYyyeFjm57mw9WKI+E7ctyz9WPy6ZzpzaRyoSPk7eZKxnFIe/hG
 f/62pu5yJk+rqkgbotBZi9FC1STw4maxAD+mlkvmpfeXS6aGgNFuh1nEUSSXSCdN1ro22jIEYej
 j6ROz0Ej/ZnxYIyFLN7fAyMLCpgRWp3VGvZDB2Eu5bMLcRhw0VjRwHvrCvuMn8g2buJpJAKu95w
 CguHBd2Q6okXGbyaPE1IZmQxLyWMkcLawaLG+Z5fV6wyiQliuJ8mvsL4J2JGuw7yh1e7v30p+a+
 9UgCH77xBNR21Ake+0u4Gzkulc6gIgqXBYcStFeRxDE9ikEz4z4htxKl5m/dMLMkCZA/0GS721v
 rZ7szb9TCF5r2I85RDVQAMf9wvoF7pkxRnOQAnBv55l/zHDXbwB8U77LVOZk2AvB1uFcn6N96+q
 yCyz0JH8oNxAYF79bcz4xMaZ56wvZIYZXdQ==
X-Received: by 2002:a05:6000:2603:b0:48e:6852:aea0 with SMTP id
 ffacd0b85a97d-48e6e526830mr21910341f8f.48.1793626595356; 
 Mon, 02 Nov 2026 05:36:35 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/47] target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to set
 IRQ/FIQ status
Date: Mon,  2 Nov 2026 13:35:41 +0000
Message-ID: <20261102133547.1375701-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently the GICv5 cpu interface directly calls cpu_interrupt() and
cpu_reset_interrupt() to raise and lower IRQ and FIQ.  This is almost
but not exactly what we do for GICv2/GICv3 external GPIO IRQ/FIQ line
changes.  Those are handled by arm_cpu_set_irq(), and as well as
calling cpu_interrupt() or cpu_reset_interrupt() they also update
env->irq_line_state.

For IRQ and FIQ it doesn't matter whether we set and clear the bits
in irq_line_state, because nothing looks at them.  But for VIRQ and
VFIQ it will matter, because VIRQ and VFIQ are the logical OR of the
line state and some bits in HCR_EL2.  We're going to need to call
arm_cpu_set_irq() for VIRQ and VFIQ; for consistency, handle IRQ and
FIQ that way too.

Since arm_cpu_set_irq() is now a function called from other parts of
the CPU code, we make its first argument a properly typed one, with a
wrapper taking void* for when we need to use it as a
qemu_irq_handler.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h       | 14 ++++++++++++++
 target/arm/cpu.c             | 14 +++++++++++---
 target/arm/tcg/gicv5-cpuif.c | 35 ++++-------------------------------
 3 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 509ed236a1a..033d6d66da3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1889,6 +1889,20 @@ void define_gcs_cpregs(ARMCPU *cpu);
 /* Add the cpreg definitions for OMAP CP15 regs */
 void define_omap_cp_regs(ARMCPU *cpu);
 
+#ifndef CONFIG_USER_ONLY
+/**
+ * arm_cpu_set_irq: Assert or clear an IRQ/FIQ/etc interrupt line
+ * @cpu: CPU to set interrupt on
+ * @irq: one of the ARM_CPU_IRQ/ARM_CPU_FIQ/ARM_CPU_VIRQ/etc values
+ * @level: 0 to deassert, non-zero to assert
+ *
+ * This function is called by the qemu_irq_handler function
+ * when IRQ etc are real inbound GPIO lines; it is also called
+ * directly by the GICv5 CPU interface.
+ */
+void arm_cpu_set_irq(ARMCPU *cpu, int irq, int level);
+#endif
+
 /* Add the cpreg definitions for the GICv5 CPU interface */
 void define_gicv5_cpuif_regs(ARMCPU *cpu);
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c484c40a7e5..0ae0d581be6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -812,9 +812,8 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
 
 
 #ifndef CONFIG_USER_ONLY
-static void arm_cpu_set_irq(void *opaque, int irq, int level)
+void arm_cpu_set_irq(ARMCPU *cpu, int irq, int level)
 {
-    ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
     static const int mask[] = {
@@ -866,6 +865,15 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
     }
 }
 
+/*
+ * Wrapper of arm_cpu_set_irq with the right argument types to be a
+ * qemu_irq_handler function for our inbound GPIO lines.
+ */
+static void arm_cpu_gpio_set_irq(void *opaque, int irq, int level)
+{
+    arm_cpu_set_irq(opaque, irq, level);
+}
+
 static bool arm_cpu_internal_is_big_endian(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1265,7 +1273,7 @@ static void arm_cpu_initfn(Object *obj)
          */
         qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 6);
     } else {
-        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 6);
+        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_gpio_set_irq, 6);
     }
 
     qdev_init_gpio_out(DEVICE(cpu), cpu->gt_timer_outputs,
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index e847fc722b9..e7b80b83754 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -173,33 +173,6 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
     return best;
 }
 
-static void cpu_interrupt_update(CPUARMState *env, int irqtype, bool new_state)
-{
-    CPUState *cs = env_cpu(env);
-
-    /*
-     * OPT: calling cpu_interrupt() and cpu_reset_interrupt() has the
-     * correct behaviour, but is not optimal for the case where we're
-     * setting the interrupt line to the same level it already has.
-     *
-     * Clearing an already clear interrupt is free (it's just doing an
-     * atomic AND operation). Signalling an already set interrupt is a
-     * bit less ideal (it might unnecessarily kick the CPU).
-     *
-     * We could potentially use cpu_test_interrupt(), like
-     * arm_cpu_update_{virq,vfiq,vinmi,vserr}, since we always hold
-     * the BQL here; or perhaps there is an abstraction we could
-     * provide in the core code that all these places could call.
-     *
-     * For now, this is simple and definitely correct.
-     */
-    if (new_state) {
-        cpu_interrupt(cs, irqtype);
-    } else {
-        cpu_reset_interrupt(cs, irqtype);
-    }
-}
-
 static void gicv5_update_irq_fiq(CPUARMState *env)
 {
     /*
@@ -243,12 +216,12 @@ static void gicv5_update_irq_fiq(CPUARMState *env)
     /*
      * Unlike a GICv3 or GICv2, there is no external IRQ or FIQ line
      * to the CPU. Instead we directly signal the interrupt via
-     * cpu_interrupt()/cpu_reset_interrupt().
+     * arm_cpu_set_irq().
      */
     trace_gicv5_update_irq_fiq(irq, fiq, superpriority);
-    cpu_interrupt_update(env, CPU_INTERRUPT_HARD, irq);
-    cpu_interrupt_update(env, CPU_INTERRUPT_FIQ, fiq);
-    cpu_interrupt_update(env, CPU_INTERRUPT_NMI, superpriority);
+    arm_cpu_set_irq(env_archcpu(env), ARM_CPU_IRQ, irq);
+    arm_cpu_set_irq(env_archcpu(env), ARM_CPU_FIQ, fiq);
+    arm_cpu_set_irq(env_archcpu(env), ARM_CPU_NMI, superpriority);
 }
 
 static void gic_recalc_ppi_hppi(CPUARMState *env)
-- 
2.43.0


