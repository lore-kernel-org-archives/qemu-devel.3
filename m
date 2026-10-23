Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D6606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kIy/PHrr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKFo5-0000qN-5C; Fri, 23 Oct 2026 09:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xKFnx-0000hh-VL
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:59:34 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xKFnu-0004oM-Vt
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:59:33 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-93f3c8958d5so91007985a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792763970; x=1793368770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=csf0U0RhbxwQQltmr3Lieh/UYJFGGnzp3gtbjXPkc6Y=;
 b=kIy/PHrrdmwijgZU6oQuO9YRPxpI0B2eiuRGITBep7jDRjQWJPHq/OoMNdr7Pdt3s/
 bhRQ1FE1TcCDvOIOFiuELt82wfDV1za2M8pqEG6/wMH/KvuGcFNRCm2hf28xIkelqL45
 6E5aFyY0wa1phaZHTn0fZlMFwDXDM8rIlkvreW//s3y0p03+isZu/1AUQH4J9c5PLrRm
 gO+ViZV+T/7amd6F680bTw+Tksi+AFj6vvbEbyEOoeOk1v+Vt+eYIydeN/hd28+BrHMe
 U+pWW507jM6I+ashXs4AtPWO84LAorFWCyGssOUz1VcOjPnguW+EGMe5BshpIHvUJu+Z
 8NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792763970; x=1793368770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=csf0U0RhbxwQQltmr3Lieh/UYJFGGnzp3gtbjXPkc6Y=;
 b=Sb9PtwYjLCTAlkhii4dLOkzfN6i0/1PmBCwLXmvO4wfZlgsDSDlItZ87tAsP27SB1v
 /J1NS1JTB9XtWzAI2Ev2UUDCKFhckg8+J1yk56ik6/JlDx2x3j0nl6Ea6hvoWrrgSPhJ
 M2ooXZ8G4CdZ4+UEF15VLrs0QLw+X2VvrwVQG+8s7OuWs2KxI1aX8GokXZW+E6jzCoNG
 PcOZKV6+mZzommCgc7/KfIvvYdm97BlwIK1J4jetLummdn4NCWPa4D+uBXyGPHxaxYID
 S91RGky3QsFU9vr2aVLOCOH3nDt0+/o0fo3Y8a8MZp6/6KLVf1zpBDFzNJisffvhCvlp
 RjyA==
X-Gm-Message-State: AFq9FYK2UWIqX3Cxq1vRqjIeSu1OR3/+Y8fAnnzYDbtFRv28NY9N9XOP
 nCSKctgfDb6mXQn6cWZL4dI0L5AXstsVRs2x1sMDDmzmu39l6Rjkr/1dD6d6mPOj
X-Gm-Gg: AYBFou3/i+5zJD6F7KMZDQEtlS0ZSxtXlE7j/YDEeVhap/eb3LYoS39pZ5dvkv8onQw
 TRfRJrCKY/9y26ptrt2OaGjz93rpzW1WX9x+9ogHIXGHwgS/0ie7Se7GNDA6IzqKHoih5291j/G
 e0wiZ7/7Gd9r3wmOXQW0OsYbj20K6A8OlFLXQBMA28BNKvnt0gAt3Uzi4KrkxGQ2kFUbPBJWEcE
 bEeHjn4tDzjTH7J0t/Sd/Md7yPEsRY2ZFSRU1Wp8UPcv5cx4k81ksU8lXLVCsZVvsb56dX+cL4D
 8MxMR5eljgKchq+AFsWj9RHLXZE0cjESQLkplIPCAiVs+xrVpZdoQcVO6j+nv65Ev+IS9EYc60P
 Oeb9KC9zE76cA5LmsOMgWltBbGJzx0Clg3InASROWeZhhSlNy3Yoi9tTBtJw+zHyqCJfvq2b/Zm
 LCwKTlmSf/JsUvzL8CKXn//DECB+JEO7cm06ggiAqAG5kKagqwwWXe7DciNkPa+2Ajp0xSTqyvr
 uIGnNNXtvl9g11tN+7Zv1/0FldBtAu0kbFBoLgB5f9HItXCbJaiNvvTP3juLz+EzBv1JJ92qz4j
 OuRbVlqg4JWQym2upF7O+osfwSWNYifVxLMrsMgd+z89nyb5SUy0
X-Received: by 2002:a05:620a:4511:b0:93e:767f:345c with SMTP id
 af79cd13be357-93f6f96437emr402634485a.39.1792763969655; 
 Fri, 23 Oct 2026 06:59:29 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:450e:e72b:156b:33d1])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94047811552sm23741285a.18.2026.10.23.06.59.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 06:59:29 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v5 03/16] hw/arm/bcm2838: enable BCM2838 PCIe host bridge
Date: Fri, 23 Oct 2026 09:59:11 -0400
Message-ID: <20261023135924.64990-5-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023135924.64990-1-marcelomanzo@gmail.com>
References: <20261023135924.64990-1-marcelomanzo@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
 hw/arm/bcm2838.c                     |  7 ++++++
 hw/arm/bcm2838_peripherals.c         | 35 ++++++++++++++++++++++++++++
 hw/arm/raspi4b.c                     |  1 -
 include/hw/arm/bcm2838_peripherals.h |  3 +++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 089af412a3..8f8e107c56 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -230,6 +230,13 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
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
index 812b5b8480..d923ba968a 100644
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
 
@@ -35,6 +40,10 @@ static void bcm2838_peripherals_init(Object *obj)
     /* Extended Mass Media Controller 2 */
     object_initialize_child(obj, "emmc2", &s->emmc2, TYPE_SYSBUS_SDHCI);
 
+    /* PCIe Host Bridge */
+    object_initialize_child(obj, "pcie-host", &s->pcie_host,
+                            TYPE_BCM2838_PCIE_HOST);
+
     /* GPIO */
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2838_GPIO);
 
@@ -67,6 +76,8 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     MemoryRegion *mphi_mr;
     BCM2838PeripheralState *s = BCM2838_PERIPHERALS(dev);
     BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
+    MemoryRegion *regs_mr;
+    MemoryRegion *mmio_mr;
     int n;
 
     bcm_soc_peripherals_common_realize(dev, errp);
@@ -182,6 +193,30 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
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
index 566d64572d..931f2cca67 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -63,7 +63,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     /* Temporarily disable following devices until they are implemented */
     const char *nodes_to_remove[] = {
-        "brcm,bcm2711-pcie",
         "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 0be97e67c7..7fe92789e8 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,7 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/arm/bcm2838_pcie.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -65,6 +66,8 @@ struct BCM2838PeripheralState {
     MemoryRegion mphi_mr_alias;
 
     SDHCIState emmc2;
+    MemoryRegion pcie_mmio_alias;
+    BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
 
     OrIRQState mmc_irq_orgate;
-- 
2.55.0


