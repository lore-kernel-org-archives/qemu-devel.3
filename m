Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4CCCD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL125-0005r6-Qt; Thu, 07 May 2026 11:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL120-0005aR-0N
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11y-00042W-0l
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so15308575e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169173; x=1778773973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mfq83WZ4PULn58rY5bmuikLWUST1RAMZv6NSXVPx6zs=;
 b=QTNhF8nRSoO4JPF7NXghN8IUSqMf+eICAlH/SrFfrK0zZKhf1aFHyhNQSm/FjiKk8K
 IVGsc1MvPNcI1SBF1rpklsqpYDQVOC1whHAQMffyRH4Catu+LW/SaKVeA1FI9lMG1Oez
 8sP30jDseSKyhO6vM46lJ6mYf0Sq+KEzE3k067MYV2X7weLFb2NmzxLrms4nkZu1pLXk
 oJG3L5YTm2UXX79M3swyTWcERU80CDo/kyuWMLOa4ZVx9SQlrrA9w4BFeYTCwZQnO/XD
 t+tzrk/LaT3IEKxEJgwoGTK02c+rmi6TmJLtvyHxjtbmgPPhEQAXxK8q150TcXqvQ5Fq
 AotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169173; x=1778773973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mfq83WZ4PULn58rY5bmuikLWUST1RAMZv6NSXVPx6zs=;
 b=YOTIxCj3Mqbri46E7MplBN0bG46jPx/JaBgM/dseyJNd5Zbw4uMIENgdOSOXlY4cQP
 +qKy37XPFI5UQ8Jt9pXIETH+psFgOC/bdZBzF4WhqK0u2POFr9q5WRKCD0fWOVHPgrpi
 AQ7DUqgRfD7nz/qrcVIKTxlT6wFuYUcVWtL7a2KRIvVnS91mPjLzikZko9PUDtn0GVHc
 0334Tv+DZA/uiDpPMX4rJzVLxNNaTEggSKvyQPMUDaPJ4UGjkynRtpDlPzlGHx2lB3ZN
 i5ynVdmq/60Zh0j+KZF8xxSLI+iOW/EDpZArdMzzAgWx3YFgpkvfinjhuG7EXHalnTs0
 TKPw==
X-Gm-Message-State: AOJu0YwIyIYXmivCisE+JBh+gTikyi5MIe4lt6Ya6bIqBn3zbVfNm06A
 mkCSOSnOQoxqCQ8lrrQOkP93Fed4BpIGXZOKpczQ1/6jYGL6tOsGqDs4zALMSFc1gm/reIMGrik
 GQxmo
X-Gm-Gg: AeBDievb5MUUt8nnm+vuRS5e5Vm1n4pp/ATMQd131/V/6sA3EBYtuHi1e4XgRr3vUDP
 0xwTd/nE9gBXBgG46IVVhiFV9Q013p/SSmcZYNVAPRdAqV7QsejhROK0gv08l50O6jxVqAVpQlC
 Ji8BFy9nH8lPolmrOJ+ORm/DGtEGvZ2y4H4nDYF7AOkYn8rfO3d41jcSDgn6/UD9/ETy4ppcMEA
 nTIe/dwiDW6au28n56tRZn9XvW+LtulvNM4aZY9CQWz3xI4RMM52Em1hwDUHnWt6T93DgzW3Vx7
 ZvX5jv4Qa64GRKsiBASDaUiDyYmqCOtlwZbb8bgK0EFQiAvIE/LVvBeJnFRIec+xIgCFngYzusP
 cDWmjtnkJKuXKeE3a9MhT48zt1yZQbo8UPdEczZso7x/xidwkMydjFaxAV4+BQuTGDMgr7j3mTt
 x+LlN4nnRDsEneVIfHTACW+fInIXgdaRnkFiDzreCyvGqzyVA/1hRjGPKKZZnMxWIwIAAClcEB4
 3XL8bzU77AT7gR6DksaZthKm8d84qI=
X-Received: by 2002:a05:600c:8115:b0:48a:9540:1a3a with SMTP id
 5b1f17b1804b1-48e51e196f9mr134765025e9.8.1778169172427; 
 Thu, 07 May 2026 08:52:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/67] hw/arm/virt: Pull "wire CPU interrupts" out of
 create_gic()
Date: Thu,  7 May 2026 16:51:45 +0100
Message-ID: <20260507155154.1886557-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

create_gic() is quite long and mixes GICv2 and GICv3 even though
they're mostly different in their creation.  As a preliminary to
splitting it up, pull out the "wire the CPU interrupts to the GIC PPI
inputs" code out into its own function.  This is a long and
self-contained piece of code that is the main thing that we need to
do basically the same way for GICv2 and GICv3.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-59-peter.maydell@linaro.org
---
 hw/arm/virt.c | 126 +++++++++++++++++++++++++++-----------------------
 1 file changed, 68 insertions(+), 58 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a8d7f47040..57f56a86c9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1120,13 +1120,79 @@ static bool gicv3_nmi_present(VirtMachineState *vms)
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
+    unsigned int smp_cpus = ms->smp.cpus;
+    SysBusDevice *gicbusdev = SYS_BUS_DEVICE(vms->gic);
+
+    for (int i = 0; i < smp_cpus; i++) {
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
@@ -1226,63 +1292,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
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


