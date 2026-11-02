Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C26606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dPwrts1c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsCe-00031x-WE; Mon, 02 Nov 2026 08:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCb-00030X-4e
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:35:57 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCZ-0002Dd-7O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:35:56 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1385912f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626554; x=1794231354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NSqQsKxQJI/TFFLQ0ghB3IrYtY5zuBYXOaqK5qTFaCY=;
 b=dPwrts1ceLqXRXEhhYNE7H+UL/+zPyB0Jre3CM8PiJSQD+vhvK49r/LIO+SrGsy1n2
 r2epFOQIjB17lOo+2soLjdo93pdI8riVA/GG9TSOIvote+hLt9yIBoVyGf21W8aZFqsj
 x9SGPYi1lRqu0k7y+34CYQgkxWVHxHbgp/J4mMiEoHlLEIB3lbPUUmZSE0a7yG1p8yne
 aZD7cZ8FNfF71hn8uodwDB2jlMTRzZ2y5L6pos2IyEBStvDfWSQYxuqz5YiH4DW2QM9h
 7FLwdxnIsHSMNkFFtUx3ucNoViV1Ldp7+9jVQxE06/y3uLUu/JprlbFjQ23jpdwpR+RC
 KwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626554; x=1794231354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NSqQsKxQJI/TFFLQ0ghB3IrYtY5zuBYXOaqK5qTFaCY=;
 b=GlKGCVgqJ/FvVOQSe7170eJ+1kZM6dLR/sN1c6nMZ6yE7Br03GI3fI7t2MYUdjl9/P
 g1v4pbeJKkU0i9tcY3+yxBZZ0Y+j1D38TmvRnRpDq8LO9H6f+Y2ug5QhmdZXNxPXzk20
 UveKkKQ+txEb1lZkeWPAo8NAuTZW1EBx75Kt4LodPIRn+nqwLY5VRsi6BovewGMDY/PR
 GS9ZvymgUTd6ijUwH9vZQma5Ojh+TzH65eNl6inuaG2LI6MYNiIURTksB6Y7jBgH+xgc
 ox+IVR9FFpcTHIMtS1vKts78po+sPYd2afVuPDPAIs+ci9OZbiTAm91FXM8P/38Jy9QT
 ydaw==
X-Gm-Message-State: APuU4Z9hUc6lBPrPQM8OxQgRb6bXOIK8ai+estt37h/PVy7fNdJJij3j
 1zlV79/SuDn7ZPIXYkul85o8dx3MGzNWA6UEnPQHOWuxbLxxcVzAhgJLil21T+dXn7gD7ruOka9
 fvaIfEU0=
X-Gm-Gg: AYBFou0UIMB+YZhjaO/ekvBqwIpyD0i06Vf0C/RQhS7aLGQUBVTpvFkCgSf3i3SSzHB
 7IDVhki2XcSAaVGHf5nL6mNfLeq0BMV0H+DJuTBntlVcrhp4Sr/faV4PlZYeMQcHxf9JkORlqSg
 XqWyAaUr6z/q6yorIYNi9hILu+YIAU4d8PBYXW+p0AoQPWXFx08h5WHWgFMA8GnxOdLPKTk164F
 l+r4bLEfiSYW+sIfWipNzFEsCGV++2HGzBKfIXAVPUmP4tQSMOm5alE1UDfxMHqZrCs30uiqKnz
 IfrqJNKFhPMHk3fvQ1jp8l6hFIsdvM0BYCRXIH9dgafteQq2JHot5Md0IadR8btZPqf4uItOlcF
 kJ0PYDoK6Xz6GASUn9PYujsWOCXNNlKWEfuUYsaxkzr8InlQTCIuGLJFoPZIBqK3UL56HpYrhX3
 LEStRmU06cZ4ppCFyipOsAr6vSDb0rSdW8cJyFUhMmz4EcTG4lMBPO+qkUPrkzO5Rom8SuOQ+tp
 Kgx3YAgxUKm9wBF44lhLY4OBFXMp6iNhbCPMSOEB6xI0KKEYGfeDwpJQ/K/f2bfj6KaF9MKM12i
 gNMLlZUJ3RYGhduj1Z9Mnh73AEP7G8eiDC4YJ3qEVSGahP599DQKIfPQLwPeHRsMvPxvhau3QD/
 KiGrIZlokioXL1T8WE0mQD9e4sRaiiYNPVJGw1dAuoTz9a3xKMePZGd8=
X-Received: by 2002:a05:6000:1449:b0:48e:dee:52bc with SMTP id
 ffacd0b85a97d-48e6e261fdemr22825612f8f.0.1793626553686; 
 Mon, 02 Nov 2026 05:35:53 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.35.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:35:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/47] hw/arm/bcm2838: enable BCM2838 PCIe host bridge
Date: Mon,  2 Nov 2026 13:35:03 +0000
Message-ID: <20261102133547.1375701-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
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

From: Marcelo Manzo <marcelomanzo@gmail.com>

Wire the BCM2838 PCIe host bridge into the SoC's peripheral block:
instantiate it, map its RC registers and MMIO window.

Per Peter Maydell's review of a later follow-up series, fold in the
remaining defect from what was originally a separate bugfix here,
since this device isn't in upstream git yet: the PCI MMIO window was
mapped at the ARM base address with no address translation, even
though PCIE_MMIO_OFFSET was defined for exactly that purpose (and
otherwise unused). The DTB declares CPU 0x600000000 as mapping to PCI
0xc0000000, so a guest would read PCI address 0 where it expected a
device BAR. Map an alias at the correct PCI offset instead.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027143036.44973-4-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2838_peripherals.h |  3 +++
 hw/arm/bcm2838.c                     |  7 ++++++
 hw/arm/bcm2838_peripherals.c         | 35 ++++++++++++++++++++++++++++
 hw/arm/raspi4b.c                     |  1 -
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index a720eea8216..0afc2c7bd2e 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -12,6 +12,7 @@
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/misc/bcm2838_rng200.h"
 #include "hw/misc/bcm2838_thermal.h"
+#include "hw/arm/bcm2838_pcie.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -69,6 +70,8 @@ struct BCM2838PeripheralState {
     BCM2838Rng200State rng200;
     Bcm2838ThermalState thermal;
     SDHCIState emmc2;
+    MemoryRegion pcie_mmio_alias;
+    BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
 
     OrIRQState mmc_irq_orgate;
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 218bebc0e85..cb52f0bd1a9 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -234,6 +234,13 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(dma_9_10_irq_orgate, 0,
                           qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_9_10));
 
+    /* Connect PCIe host bridge to the interrupt controller */
+    for (int n = 0; n < BCM2838_PCIE_NUM_IRQS; n++) {
+        int int_n = GIC_SPI_INTERRUPT_PCI_INT_A + n;
+        sysbus_connect_irq(SYS_BUS_DEVICE(&ps->pcie_host), n,
+                           qdev_get_gpio_in(gicdev, int_n));
+    }
+
     /* Pass through inbound GPIO lines to the GIC */
     qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
 
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index f4e9cb88f1f..e7d2e3155aa 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -15,6 +15,11 @@
 #define CLOCK_ISP_OFFSET        0xc11000
 #define CLOCK_ISP_SIZE          0x100
 
+#define PCIE_RC_OFFSET          0x1500000
+#define PCIE_MMIO_OFFSET        0xc0000000
+#define PCIE_MMIO_ARM_OFFSET    0x600000000
+#define PCIE_MMIO_SIZE          0x40000000
+
 /* Lower peripheral base address on the VC (GPU) system bus */
 #define BCM2838_VC_PERI_LOW_BASE 0x7c000000
 
@@ -41,6 +46,10 @@ static void bcm2838_peripherals_init(Object *obj)
     /* Thermal */
     object_initialize_child(obj, "thermal", &s->thermal, TYPE_BCM2838_THERMAL);
 
+    /* PCIe Host Bridge */
+    object_initialize_child(obj, "pcie-host", &s->pcie_host,
+                            TYPE_BCM2838_PCIE_HOST);
+
     /* GPIO */
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2838_GPIO);
 
@@ -76,6 +85,8 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     MemoryRegion *rng200_mr;
     qemu_irq rng_200_irq;
     MemoryRegion *thermal_mr;
+    MemoryRegion *regs_mr;
+    MemoryRegion *mmio_mr;
     int n;
 
     bcm_soc_peripherals_common_realize(dev, errp);
@@ -210,6 +221,30 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     create_unimp(s_base, &s->clkisp, "bcm2835-clkisp", CLOCK_ISP_OFFSET,
                  CLOCK_ISP_SIZE);
 
+    /* PCIe Root Complex */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_host), errp)) {
+        return;
+    }
+    /* RC registers region */
+    regs_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie_host), 0);
+    memory_region_add_subregion(&s->peri_low_mr, PCIE_RC_OFFSET, regs_mr);
+    /*
+     * MMIO region.
+     *
+     * The BCM2711 PCIe controller translates addresses between the ARM and
+     * PCI address spaces: the DTB declares CPU 0x600000000 as mapping to PCI
+     * 0xc0000000. Map an alias of the PCI window starting at that PCI offset
+     * so accesses land on the right addresses; mapping the window directly
+     * would expose PCI address 0 at the ARM base instead, and every BAR
+     * behind the root port would be read at the wrong address.
+     */
+    mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie_host), 1);
+    memory_region_init_alias(&s->pcie_mmio_alias, OBJECT(s),
+                             "bcm2838_pcie_mmio_alias", mmio_mr,
+                             PCIE_MMIO_OFFSET, PCIE_MMIO_SIZE);
+    memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
+                                &s->pcie_mmio_alias);
+
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 61adccded97..3613b8b0db1 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -63,7 +63,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     /* Temporarily disable following devices until they are implemented */
     const char *nodes_to_remove[] = {
-        "brcm,bcm2711-pcie",
         "brcm,bcm2711-genet-v5",
     };
 
-- 
2.43.0


