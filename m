Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2DE606A334
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gj/KUG91
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG39-0003Gz-Hc; Fri, 23 Oct 2026 10:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG37-0003GL-AQ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG35-0006YU-FE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:12 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so321346f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764910; x=1793369710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LuEpIyT2R96JtdAwyVI+9GBej4TOi8f0BX9qqxsJV/Y=;
 b=gj/KUG911zWkQ//HmoUFAwid5O6CGeTV+6yoOXvbMlnC6Bkw7r6UYNoe1b4WfG/+gl
 Z2OU+Oh+pUWPF24+3Hq/sSS+8ZxjV+9/9/RUlYmNxVSSR5l6zB/Eh4k2xZCNN1S7IKNC
 BZI7BBcfDWTJGhXfFDLTEmcIuo/YD1e6j3gY+FzCjFBUaDR3by3fX1QAyDAowGE0TeX7
 /sn56eq0eK3rq3+Hsjwad7ZiFqGx7CBCZBSG/YGgrNcdgVoy6jgU1aDWHbbh3daWZTp2
 ZZNwElrhKwtgIIKtFGcmiisMuT+zWsOHPGKjwdXyowhiycy0FH5Bh/QDbsUsRw4KGrH+
 GwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764910; x=1793369710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LuEpIyT2R96JtdAwyVI+9GBej4TOi8f0BX9qqxsJV/Y=;
 b=FhCSJbZwePwAkK4B+WXzlWYD/SYVBoVVsyF6korsGavy485XkVrFaPzJ/kpGRHDHBw
 4W8hQp6FhoyhqUch21FkME5TjfcuXQ/OJq5zdWnLrzHRKEcYYPE56QP8cPjnRXKCSTel
 0R2HHBuHasPlPxzDNejt8bZ2S67SkO04GQLQWzfNcbe7sPP58Vo9+i0MRyjebFKvBkTZ
 P5ZwDfMy4XYdyNfSCMnOf8Bx6KhpdkvGCKa7430zrEQvZ4LfAXbDUa/p4PwpI0FZ/mV3
 6kUANH8DC2ZFI64IjRhR5WtzLJwmoHA71sh9G2R/TndftOg9CF48hO8dVlfc5StIkE0b
 Mx8Q==
X-Gm-Message-State: AFq9FYLBXueoD/V/bjIuv0flAqN66Snvk1FzO2vtT9pENlvxlmXk/EVr
 OHsh/6gkHUlcDDx5ERdoObW/IIxem2eukvtuI/DacK/dv3P+agg/BHDViJ9NPX1NpG/PSX7rjiu
 YEMR0Ltg=
X-Gm-Gg: AYBFou0NF+HWJJnM6K7Vbh+hS5K2TEra0cDGdjbbOU6nFlDkqy/TVHND1i5FQcRoK99
 TKojLMopjIkxMVN4/k3M6gis96IYja65ORejRBMjDbRhKiDXA0jFslnO0SUcddttgAqVaufn+f6
 v4yZkG+u367vjmuwX8v+6/0uw1yvHAB4zay1oFR4DFtUqsNTPfZiQuTjDw4IxQVSYQt4rFnztMJ
 MBz+CN54WP3mB9BPOFF0FFInIpU6ip+rbYbyH67Q73SYoCQ32YvyZv3Bls9W3lVSWlHo+2WSoDL
 gk8irg5zjq8Chilok8MXIkDHvKrAh4Ke9gPuz/dbD1+NLuRHSZ45BOKTpQIU5UBvz/NXuceHwPB
 xnnBFOl2q9+TWoIjv6YQ2IJj/+prtoDCm2hmbK/Ia+3aTNGu5Rn0G5NAUXKHYp8cKomtG9B3ekd
 Otgc07PNfFsO2sSKfNQgMRxi4wdIchl6VPILaQgPCzBd6iW2K9aROZxmzmpdgLxG5oKtR8XkJep
 fPtPClzGLZ9bke5v+vORyVQO2WmucBogiYfAksSAV6XPfrUyos4Xoxb41GUPQ/rqMMibkygM9E3
 CqxdWnemjFp44BidpuyTkrTq3Srzroj1PPJaI+0l94NymN90y71gJvsnPoEK
X-Received: by 2002:a05:600c:468e:b0:4a1:e11f:b2d5 with SMTP id
 5b1f17b1804b1-4a312e8cce8mr625685e9.2.1792764909752; 
 Fri, 23 Oct 2026 07:15:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] hw/arm/bcm2838: enable BCM2838 RNG200
Date: Fri, 23 Oct 2026 15:14:49 +0100
Message-ID: <20261023141503.1397009-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Wire the BCM2838 RNG200 device (added in the previous patch) into
the SoC: instantiate it in the peripherals block, map its register
region at the real BCM2711 physical address, and connect its
interrupt through both the GIC and the legacy GPU interrupt
controller path (matching how the device's own realize() wires it,
mirroring the pattern used for the older BCM2835 RNG on raspi0-3).
Also stop raspi4b from masking out the "brcm,bcm2711-rng200"
device-tree node, now that the controller it describes is actually
implemented.

Adapted from patch 16/41 of Sergey Kambalin's Raspberry Pi 4B series
(patchwork series 829638) against current QEMU master.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261015181111.60491-3-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 hw/arm/bcm2838.c                     |  4 ++++
 hw/arm/bcm2838_peripherals.c         | 17 +++++++++++++++++
 hw/arm/raspi4b.c                     |  1 -
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 0be97e67c73..15423527e80 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,7 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/misc/bcm2838_rng200.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -64,6 +65,7 @@ struct BCM2838PeripheralState {
     MemoryRegion peri_low_mr_alias;
     MemoryRegion mphi_mr_alias;
 
+    BCM2838Rng200State rng200;
     SDHCIState emmc2;
     BCM2838GpioState gpio;
 
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 089af412a30..218bebc0e85 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -209,6 +209,10 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dwc2), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DWC2));
 
+    /* Connect RNG200 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->rng200), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_RNG200));
+
     /* Connect DMA 0-6 to the interrupt controller */
     for (int n = GIC_SPI_INTERRUPT_DMA_0; n <= GIC_SPI_INTERRUPT_DMA_6; n++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dma),
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 812b5b8480c..35e2fc005ca 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -35,6 +35,9 @@ static void bcm2838_peripherals_init(Object *obj)
     /* Extended Mass Media Controller 2 */
     object_initialize_child(obj, "emmc2", &s->emmc2, TYPE_SYSBUS_SDHCI);
 
+    /* Random Number Generator */
+    object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
+
     /* GPIO */
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2838_GPIO);
 
@@ -67,6 +70,8 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     MemoryRegion *mphi_mr;
     BCM2838PeripheralState *s = BCM2838_PERIPHERALS(dev);
     BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
+    MemoryRegion *rng200_mr;
+    qemu_irq rng_200_irq;
     int n;
 
     bcm_soc_peripherals_common_realize(dev, errp);
@@ -79,6 +84,18 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
                                         BCM2838_VC_PERI_LOW_BASE,
                                         &s->peri_low_mr_alias, 1);
 
+    /* Random Number Generator */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng200), errp)) {
+        return;
+    }
+
+    rng200_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng200), 0);
+    memory_region_add_subregion(&s_base->peri_mr, RNG_OFFSET, rng200_mr);
+
+    rng_200_irq = qdev_get_gpio_in_named(DEVICE(&s_base->ic),
+                                         BCM2835_IC_GPU_IRQ, INTERRUPT_RNG);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0, rng_200_irq);
+
     /* Extended Mass Media Controller 2 */
     object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
                              &error_abort);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 566d64572db..87fcba036d8 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -64,7 +64,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
     /* Temporarily disable following devices until they are implemented */
     const char *nodes_to_remove[] = {
         "brcm,bcm2711-pcie",
-        "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
     };
-- 
2.43.0


