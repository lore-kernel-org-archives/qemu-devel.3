Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE8AEC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZM9-0004ZT-4l; Mon, 23 Feb 2026 12:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZLD-0002uS-Jw
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:30 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL9-0000RO-BX
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:26 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so43136025e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866198; x=1772470998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KnSBbwNAJz8jvmrJ0U5ORYLe/Et4GkGyZ62fZOOX4tE=;
 b=myLcHvwpthYK/PxRjyWYj2RHt9EYCuIKvkdaLUoqboey1pvRsClSJT/HdEPsbyQ0eh
 R+2iMl1eWyHnRopwnuG18vBSr1TBLiRRfc4ehxBCz8Korst6ukkLbeMf0YIjqbH69xdX
 jdACsGf1ziu/yPAkyP2sWnzifFoQ0kzDUiMY37XgCniPfHETx76/FCDlofqdV9iLQvGx
 kVm/suvGj/NjxRq86oA/DaSVILiIl0jg7MayrsVTzb/MN076W5pDTBL/Gq9BzQuijxDP
 Nvno5bIrjeQIsk3ogFHd4+h6Aj9XbOVoEzUA34BW/ctj0OK0lbbf7+2PPUewTRHWtDSE
 NrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866198; x=1772470998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KnSBbwNAJz8jvmrJ0U5ORYLe/Et4GkGyZ62fZOOX4tE=;
 b=NEGUtUM1fAsVcR22JMY4K3VaI6L3c12TikZUsHE2SUkm4raZWW6hEJ4/bcGjOTb3ah
 XjcIohGRgBwoCwK7arnvnlp6820lt6IruRdU3onJ1KMzlUDlSnW06eF53GrbXS3vAPR/
 SFlCDse4kIMa8AUc8tbK1AdeGVTPCHfs/rpwU9NtuM8vTYerL5csl34/czmAOX9eKzQ9
 7kWE+ekiHMhdHVgr47gmL9rCoDVyJNP1onuxQp19K+A3EoCenNM5voemh5mBUTG08+zU
 MhH1a+fa5UwJHUOoBaSmwCBZ0iSe9oPLNSrWOVHcOLth9CM/iINTpadT48c0YdCTnoD+
 m/8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfob+KLcGWjVLsmZuwHbIJVj0kseKYduZbUXsG3qXmNx4Q2Hwrr67CmqpCDSzGNR/V+1/srUgj1fgq@nongnu.org
X-Gm-Message-State: AOJu0YxFY1dHpkuHBZMgz2KvRIW4w5Gu2ebizQwW2VX7Z0dqTxwTjbJG
 nBSVcxS9z40LLli2fxohGRSZa+r0bi2nLYwmcKzvrnJaWJinzJkZpgHxSJwl+BRz/FB31xgB103
 Y4Hnv
X-Gm-Gg: AZuq6aJ21MGkatkA0Fi0TIr04N+f3TUWcsUGBs35B3zDAfwIALRz5nORI/vSEnECvD8
 4PHCLk9AhsSCq6m3jHuP95YsZCcLuxzbct3gKwkWgjyG0v+40Rll0JkFgmIjBeB9IaSgAc/EWaD
 IPsWw/K88MizfdDFBJPpVL97NrQweiXZUy0/utTzwYmAJ7nQncFwgQWLEzF9ru/R9HdFYdQdH8T
 FIg9W2LnDAaZr/cSP2Qn/zmvzYChbyYjXwDDRnO4jmDs3pKvVcDSaNUAdbM45zGq5eXS9jCoocU
 HdOPjn/uaVu6CXa2XYMGAfgE8BtFsKHb3BcpS0DpqS58j44Aasx5PL5YG35uP/f1xxWDgMhqpd9
 raK/pD0PS/Du5VUPlrgJpHfFj5TX5dYH3b2cidj02rz/8NeuCnvpW1tQuxyr51hcdaj/2Ir9U0Y
 mbNy4wlQD0b8oWVdYjOJ5qfkiH4/y1QKUSYo1goSPbzgwm0mNMXiW1qX0Ga9VtqIb91KiotOf9O
 A4zFj8FaayK+QZZQA5AM4owBpZncJI=
X-Received: by 2002:a05:600c:34cb:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-483a95bef2amr140499275e9.10.1771866197972; 
 Mon, 23 Feb 2026 09:03:17 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 58/65] hw/arm/virt: Pull "wire CPU interrupts" out of
 create_gic()
Date: Mon, 23 Feb 2026 17:02:05 +0000
Message-ID: <20260223170212.441276-59-peter.maydell@linaro.org>
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

create_gic() is quite long and mixes GICv2 and GICv3 even though
they're mostly different in their creation.  As a preliminary to
splitting it up, pull out the "wire the CPU interrupts to the GIC PPI
inputs" code out into its own function.  This is a long and
self-contained piece of code that is the main thing that we need to
do basically the same way for GICv2 and GICv3.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 127 +++++++++++++++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 58 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3c318680f8..ec6e49099a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -795,13 +795,80 @@ static bool gicv3_nmi_present(VirtMachineState *vms)
            (vms->gic_version != VIRT_GIC_VERSION_2);
 }
 
+static void gic_connect_ppis(VirtMachineState *vms)
+{
+    /*
+     * Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs,
+     * and the GIC's IRQ/FIQ/VIRQ/VFIQ/NMI/VINMI interrupt outputs to the
+     * CPU's inputs.
+     */
+    MachineState *ms = MACHINE(vms);
+    int i;
+    unsigned int smp_cpus = ms->smp.cpus;
+    SysBusDevice *gicbusdev = SYS_BUS_DEVICE(vms->gic);
+
+    for (i = 0; i < smp_cpus; i++) {
+        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
+        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
+        /*
+         * Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs we use for the virt board.
+         */
+        const int timer_irq[] = {
+            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+            [GTIMER_S_EL2_PHYS] = ARCH_TIMER_S_EL2_IRQ,
+            [GTIMER_S_EL2_VIRT] = ARCH_TIMER_S_EL2_VIRT_IRQ,
+        };
+
+        for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+            qdev_connect_gpio_out(cpudev, irq,
+                                  qdev_get_gpio_in(vms->gic,
+                                                   intidbase + timer_irq[irq]));
+        }
+
+        if (vms->gic_version != VIRT_GIC_VERSION_2) {
+            qemu_irq irq = qdev_get_gpio_in(vms->gic,
+                                            intidbase + ARCH_GIC_MAINT_IRQ);
+            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+                                        0, irq);
+        } else if (vms->virt) {
+            qemu_irq irq = qdev_get_gpio_in(vms->gic,
+                                            intidbase + ARCH_GIC_MAINT_IRQ);
+            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
+        }
+
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                                    qdev_get_gpio_in(vms->gic, intidbase
+                                                     + VIRTUAL_PMU_IRQ));
+
+        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gicbusdev, i + smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+        if (vms->gic_version != VIRT_GIC_VERSION_2) {
+            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
+            sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
+        }
+    }
+}
+
 static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 {
     MachineState *ms = MACHINE(vms);
     /* We create a standalone GIC */
     SysBusDevice *gicbusdev;
     const char *gictype;
-    int i;
     unsigned int smp_cpus = ms->smp.cpus;
     uint32_t nb_redist_regions = 0;
     int revision;
@@ -900,63 +967,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         }
     }
 
-    /* Wire the outputs from each CPU's generic timer and the GICv3
-     * maintenance interrupt signal to the appropriate GIC PPI inputs,
-     * and the GIC's IRQ/FIQ/VIRQ/VFIQ/NMI/VINMI interrupt outputs to the
-     * CPU's inputs.
-     */
-    for (i = 0; i < smp_cpus; i++) {
-        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
-        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
-        /* Mapping from the output timer irq lines from the CPU to the
-         * GIC PPI inputs we use for the virt board.
-         */
-        const int timer_irq[] = {
-            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
-            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
-            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
-            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
-            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
-            [GTIMER_S_EL2_PHYS] = ARCH_TIMER_S_EL2_IRQ,
-            [GTIMER_S_EL2_VIRT] = ARCH_TIMER_S_EL2_VIRT_IRQ,
-        };
-
-        for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
-            qdev_connect_gpio_out(cpudev, irq,
-                                  qdev_get_gpio_in(vms->gic,
-                                                   intidbase + timer_irq[irq]));
-        }
-
-        if (vms->gic_version != VIRT_GIC_VERSION_2) {
-            qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            intidbase + ARCH_GIC_MAINT_IRQ);
-            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
-                                        0, irq);
-        } else if (vms->virt) {
-            qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            intidbase + ARCH_GIC_MAINT_IRQ);
-            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
-        }
-
-        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(vms->gic, intidbase
-                                                     + VIRTUAL_PMU_IRQ));
-
-        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(gicbusdev, i + smp_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
-
-        if (vms->gic_version != VIRT_GIC_VERSION_2) {
-            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
-                               qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
-            sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus,
-                               qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
-        }
-    }
+    gic_connect_ppis(vms);
 
     fdt_add_gic_node(vms);
 }
-- 
2.43.0


