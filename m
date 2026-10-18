Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EACBCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIR3s-0002Vr-8X; Sun, 18 Oct 2026 09:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3p-0002RP-Er
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:25 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3m-0002Js-4n
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:25 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-93f269e335eso193951685a.3
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792330581; x=1792935381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BJsB6fS6z4gzM4CvmbXU27cB5kn+bKI9xPT6Y+2F2Zk=;
 b=MLU1EH7IWx5JGPxYrYiWm8V+4B1cgxnsY4q0sn+wWDtTZ7keT2a6ntTgaSwDDSVz4p
 +b92FMuNgLePTk8Yx0FPvmnw3S+Rd0C8H5zcEKL6HuLkp9lVoFckJoAOwnWNpIJFHjpz
 H6y7LOdqSCo3/+7oJ2j6U99Sy+a7kXlTR32Qdoj/AnVD0DmeAnujj4yKxmq6Mx6zaZI1
 taeAudqdycJ/aLBZPxdtHI+UDBvO6wp2lHYwOd40SPxFjG28M5yCFfeBZSwYwjqpWwEa
 62w/3riTZiiikuNhOF3wu2ahTftt2trhfI/NPU1WBN9hsHJTpAN/pdIFOYOkfv6IYqls
 YZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792330581; x=1792935381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BJsB6fS6z4gzM4CvmbXU27cB5kn+bKI9xPT6Y+2F2Zk=;
 b=ndZwx4EmR109p+rgWFuPVJzWMjUnlsxKTtGYElUD9zHdLLEPiq5W3lmfgkDBW9BVge
 MMZx+CdQQu5LXLeXVAc3jINfe3oEw/tXsn64XiOLf+pgMMoGU9BTvbZa72kmomyhzlmZ
 kcW2176pQZu7h2Uj9w+T37ACsZT7PhZOcH9dFPX0KW/Xvf4VMnh0B9rGYqPIX03IZ4vc
 bTVyZreSqAnlPxjPY6s+EX1oI6ZZRSEp5bJ4H/07YDD4Eu2n3YgFDF3JcVKR+wnFr7Eu
 SZf6+PgWg2E5a44REsC/SKYRyKObEvBRnMarM5BvzDw6rYPCP3AYSOnCdwrdDrwS8qGo
 qWQA==
X-Gm-Message-State: AFq9FYJ3SN7O5MsLipKIck+tGiJzQSbkk4Vx5j2iKRliU9LPPjLFZrxt
 2YTzych5XloCm4rucBv5hNyjLfLor1pd61WNdDn0ES5rCw32czv2l4HvPV0xDvEX
X-Gm-Gg: AYBFou1l74+kPfDW3sqNpDwA8Y7LiTN7U+Uj4t3Y6xld8Wi0wVKzoR5UjP8NghPr5+y
 DAHRV46gel9cT/Ub5yaQBiQ8nfRCiZ3qQKBD+XGblPXgWZSLm7oItPYdVlis2SMmARkQ1Naqcco
 aWm4OuAOaKFXOpAB+mhR5jSHbKFqu2/KnkGOMQSxVTpPCbGSCrnG2bDs4d7YsdEAOKA0CGkXou/
 +WI1qPxiAk67cUSOTQ5d2d6cnSExdduDhMxgIDXIUp4xF59txZ3mPDLXQe3PlQVKX5zn75gUMDa
 7IhGAWZe94Geo7sN0GV7jRj6HKRhmnpMjCgfDwoFfzwvKLV8FyWW/av0/KCj9ToHYoeS732+1sH
 U4U5CV5IuyqtIRRJq9gNvDthYbB+NBoWQ1Y6L+m07B14i7HoHtZ1wA7G+PfqjtUuHYkPAfuA+sC
 IF/DjY3RmXK3pRmy1vTlFdCXsrSgX75/GNzxGbVQSiFD8VBnYxP0qf4GtWJwhmS9tnjJcfHQZQt
 kNE+p+PChr3m3OfXd8wFUNKpPKrJlRpmUPU5OFbMkcCWH+fzIYUVP+ssK301xWzUx5T2ZE=
X-Received: by 2002:a05:620a:6844:b0:93e:53fd:4139 with SMTP id
 af79cd13be357-93f29ba2472mr708869485a.9.1792330580965; 
 Sun, 18 Oct 2026 06:36:20 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:ecfc:9d0d:b95b:11bf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f2a854bb7sm459056485a.23.2026.10.18.06.36.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 06:36:20 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v4 15/17] hw/arm/bcm2838: enable BCM2838 GENET controller
Date: Sun, 18 Oct 2026 09:36:01 -0400
Message-ID: <20261018133603.64323-16-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018133603.64323-1-marcelomanzo@gmail.com>
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
---
 hw/arm/bcm2838.c                     |  6 ++++++
 hw/arm/bcm2838_peripherals.c         | 11 +++++++++++
 hw/arm/raspi4b.c                     |  1 -
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 8f8e107c56..f0076a08ce 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -237,6 +237,12 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
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
index d923ba968a..012a4567e7 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -44,6 +44,10 @@ static void bcm2838_peripherals_init(Object *obj)
     object_initialize_child(obj, "pcie-host", &s->pcie_host,
                             TYPE_BCM2838_PCIE_HOST);
 
+    /* Gigabit Ethernet */
+    object_initialize_child(obj, "genet", &s->genet, TYPE_BCM2838_GENET);
+    qemu_configure_nic_device(DEVICE(&s->genet), true, NULL);
+
     /* GPIO */
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2838_GPIO);
 
@@ -217,6 +221,13 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
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
index 931f2cca67..6076b43922 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -65,7 +65,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
     const char *nodes_to_remove[] = {
         "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
-        "brcm,bcm2711-genet-v5",
     };
 
     for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 2a4307bed7..deddab50d2 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -11,6 +11,7 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/arm/bcm2838_pcie.h"
+#include "hw/net/bcm2838_genet.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -70,6 +71,7 @@ struct BCM2838PeripheralState {
     SDHCIState emmc2;
     MemoryRegion pcie_mmio_alias;
     BCM2838PcieHostState pcie_host;
+    BCM2838GenetState genet;
     BCM2838GpioState gpio;
 
     OrIRQState mmc_irq_orgate;
-- 
2.55.0


