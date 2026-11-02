Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ECD606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OMCQM8NZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsCx-0003BX-Vd; Mon, 02 Nov 2026 08:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCo-00036l-Nh
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:10 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCm-0002GD-ON
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:10 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso1553228f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626567; x=1794231367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IjIIVjmQdgv0RBXDhFdl1LOaXZ6+lazj1cMlfnCFwHk=;
 b=OMCQM8NZ9NgIjsrMQjgi6ELfKqbvfGiCCfdmB65TaTmWqETaeX+4Z6Uu22L1Unveif
 CHPN9iwWV58ikWqMziuir/MBB3IMHWaVecdF1V0qCn0PWCKtJ0EhO7wvees9Rr6aC+KT
 aW79kfwve2g7aKLFTIMaJ4+7g1f+RVAhFo56wW7ZfJjPZvABDJEwYh9yIPAwpOkiySmm
 DmNEYEDG5BCxL4EOkdJzEJRaio3s0nLtZR3Q5+Ftumb0daPx+HJ2aDTlhoMo6r3LpMQ8
 GvU4OyPgkU419AgGqDDQ2DJqcSnZd5YdSUnTUl+HJ0RRc0zLZArJYRks5ucXyneslGpz
 vZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626567; x=1794231367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IjIIVjmQdgv0RBXDhFdl1LOaXZ6+lazj1cMlfnCFwHk=;
 b=L1o0XBXqI/ACBzYENIdd8yl3sg7VhQklZr3uQKRtCr8OB2DNIoZAFWHznvYSxqeYGy
 1R9Z1psiu8RGpdlgb4po6Bn8TQWA4ngHFIBML4D7rjGh0Uy9FN9xSXuh7oWN7tY0XFuI
 /9Ljj5ZVLCB1JLzD6rMfrw1MR+oTqGF+LByJF8gEKi1wMmgaePmYxcBPY8x/S05qWxmE
 rOiZjuvTz9dPkK99iHI4ImVYJNs/X6QxEKH08vZgTvt3RaBR4H3UVXU7dY3FVgVYGZZm
 TCW9yS2FGEUnlLLJWPeMXIHRZMReZIJ6Cp6JZyNf9aeQjh0H+cO2dYJxD0HcAAnKxkSL
 rI9g==
X-Gm-Message-State: APuU4Z+nnUV7Cgc1UHv4pSQ6LEs4fNcPalZebtKPeJID18EMH3qvEGBn
 jdS9YBBN545r1fpeu2CMIFekzSVJsF5YnSMMHVWcxZBigfsxNF53/3yp3Q9kfxrFPCPJoT73F/K
 I9PpF2sI=
X-Gm-Gg: AYBFou08V7ZzBPDTfL7ELqkx8eX9PcxEpZrDL9/x4WMouDJsOjdfwipn/Kx5QG+U+p3
 F9ss+FUaeeaHEDykMll++e8JgWiPjRgGuJBX+YpjpjGozu0mpQQWArPM26Rt3+nhR9fM5ytb/gZ
 YfCcpyXq2kze9wn8YzQ4XrU9fJx3dtG0l4jUJmFrSbEAXB5PvcNlrXbJdp4hXF5zEcznc/IScVt
 UY664fMx5fVhzIPkOsN9F6B3u20rSke36NRF/W31PuMI9WgSJ7otFx2xuHuMNn/00mglIOFmz5T
 pQNeZvLxflr/4Toc+0SF8TI4uT06TfH7IqwhvR3s8zagSOBSxH3ObK+UACAI5q28IZr5JBk3mhC
 bdPHzfPhbZ1nfG5Lh3hO4hg/b3dEfJKBK7Hn+2bWKQVTVzaFLSka3s9QL1PfISBpHAnBLVV30c3
 QvPnOMVj8szmdRQVHS5W9m/b1IKPOAnJgg1j3GY34mP7/1V54u90qHz6mqtNQC+KrYmzIlboSAc
 /RoiqJ/eoGkDjHGRu85A1VBu+uV0Y5eTIfJDbqi9qq4PXqenkdIyEaymEak2DvqUb9CzL79Qdtw
 082M1vHwtNWLaDqNbLoGxD/5Q202EYyEE140biZrRHmR4hBpXUx9+gNILoucfnyWUWltYoOvbxL
 Q+aJCecYVmqomVmWDnufTm1TphJS85d4USg==
X-Received: by 2002:a05:6000:10c9:b0:488:8931:b1b2 with SMTP id
 ffacd0b85a97d-48e6e4fdb8fmr16896000f8f.28.1793626567107; 
 Mon, 02 Nov 2026 05:36:07 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/47] hw/arm/bcm2838: enable BCM2838 GENET controller
Date: Mon,  2 Nov 2026 13:35:15 +0000
Message-ID: <20261102133547.1375701-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Wire the BCM2838 GENET device (added in the previous patches) into
the SoC: instantiate it in the peripherals block with
qemu_configure_nic_device() so it picks up a -nic/-netdev from the
command line, map its register region at the real BCM2711 physical
offset, and route its two interrupt lines through the GIC. Also stop
raspi4b from masking out the "brcm,bcm2711-genet-v5" device-tree
node, now that the controller it describes is actually implemented.

Adapted from patches 19-29/41 of Sergey Kambalin's Raspberry Pi 4B
series (patchwork series 829638) against current QEMU master.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027143036.44973-16-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 hw/arm/bcm2838.c                     |  6 ++++++
 hw/arm/bcm2838_peripherals.c         | 11 +++++++++++
 hw/arm/raspi4b.c                     | 18 ------------------
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index c6a8850cfe6..60bfacdce49 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -13,6 +13,7 @@
 #include "hw/misc/bcm2838_rng200.h"
 #include "hw/misc/bcm2838_thermal.h"
 #include "hw/arm/bcm2838_pcie.h"
+#include "hw/net/bcm2838_genet.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -74,6 +75,7 @@ struct BCM2838PeripheralState {
     SDHCIState emmc2;
     MemoryRegion pcie_mmio_alias;
     BCM2838PcieHostState pcie_host;
+    BCM2838GenetState genet;
     BCM2838GpioState gpio;
 
     OrIRQState mmc_irq_orgate;
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index cb52f0bd1a9..650b1fe8f44 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -241,6 +241,12 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, int_n));
     }
 
+    /* Connect Gigabit Ethernet controller to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->genet), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_GENET_A));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->genet), 1,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_GENET_B));
+
     /* Pass through inbound GPIO lines to the GIC */
     qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
 
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index e7d2e3155aa..e512a8ac2c4 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -50,6 +50,10 @@ static void bcm2838_peripherals_init(Object *obj)
     object_initialize_child(obj, "pcie-host", &s->pcie_host,
                             TYPE_BCM2838_PCIE_HOST);
 
+    /* Gigabit Ethernet */
+    object_initialize_child(obj, "genet", &s->genet, TYPE_BCM2838_GENET);
+    qemu_configure_nic_device(DEVICE(&s->genet), true, NULL);
+
     /* GPIO */
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2838_GPIO);
 
@@ -245,6 +249,13 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
                                 &s->pcie_mmio_alias);
 
+    /* Gigabit Ethernet */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->genet), errp)) {
+        return;
+    }
+    regs_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->genet), 0);
+    memory_region_add_subregion(&s->peri_low_mr, GENET_OFFSET, regs_mr);
+
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 3613b8b0db1..600dfe686f2 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -61,24 +61,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 {
     uint64_t ram_size;
 
-    /* Temporarily disable following devices until they are implemented */
-    const char *nodes_to_remove[] = {
-        "brcm,bcm2711-genet-v5",
-    };
-
-    for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
-        const char *dev_str = nodes_to_remove[i];
-        int offset;
-
-        offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
-        while (offset >= 0) {
-            if (fdt_nop_node(fdt, offset) == 0) {
-                warn_report("bcm2711 dtb: %s has been disabled!", dev_str);
-            }
-            offset = fdt_node_offset_by_compatible(fdt, offset, dev_str);
-        }
-    }
-
     ram_size = board_ram_size(info->board_id);
 
     if (ram_size > UPPER_RAM_BASE) {
-- 
2.43.0


