Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7DDC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 19:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT5cq-00026I-Qe; Thu, 25 Jan 2024 14:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vbmyZQwKCjAZMNUTQefQRMZSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--nabihestefan.bounces.google.com>)
 id 1rT5cn-00024v-Mx
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:42:57 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vbmyZQwKCjAZMNUTQefQRMZSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--nabihestefan.bounces.google.com>)
 id 1rT5ck-0005Bu-Vv
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:42:57 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc3645c083aso7387426276.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 11:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706211773; x=1706816573; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=KoiWmLUy9Z2jBMpt3vIL/wDyZVSYZMg7YR9ZIbTZHJE=;
 b=YEmQyVkBkMegIZz1/DRw5h0Nuh/8Sw8pSfRb71ZmqKOHdEHS0orP1vx0VGgrqXY3eW
 q6qjtGhvhm0PQ7U/Ee07t3EMum9oyO4k/FRhIBwLhkdDy6J810p6f2UG5gkjO8C3s5Bg
 1CClBaStTV61AdYjol9LGFwyHQvoK8KPXpWUWnMenDGSpgZJNmr6heqeZbdUBMzqyA2c
 hOOSmGyApA1cacS6sT/9y7sGJcWp14wDdSnagEFyed0RnWIbcJ3qBlTsKqssAidPhie0
 KVlAkDrYuNBNPCm4ziM8PXbNATBKBGEehsL6nOfkKUg4706TImXMTB8qiC1MGHQt9iaQ
 aYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706211773; x=1706816573;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KoiWmLUy9Z2jBMpt3vIL/wDyZVSYZMg7YR9ZIbTZHJE=;
 b=Ov5vgrOQkT4FFtljQMGtF0iiqsbni6sSsvtjx2m1yoPBd8aiReAa/CdCzhBj+p+GX2
 nCJZOEl+3hYprHmyhJkez7dq+4sw9Cnb3CDLUGOQ1ydRfYDlBhqDGbJZ6j+/+BQDtmMv
 r+JwsKTS6hAY4mtOB+Tt9k1OuQ1TDcl6swunR13hei7fgkncre4SUTbDBQ2qnEMX8F+d
 TA1w+Ibf5gx7m2OhtknybCdxsF8EN6b90osH++/VhsUFdZk3bm3iUfcHil4w6wyQH14X
 5f0VCouAWKQAh1OEQ8RGppQOrgHvOB6TSe5EGanmhRTeE5G6vkyP+4KH5S/nYDhqQBCO
 E+Ww==
X-Gm-Message-State: AOJu0YwuVmabfrKnFC2rSUw4nZbOKtCP8WcFdfduC8q6Zzm5Uvkdsnza
 YyaB54tXKu+7q4+4dWZ0U+2aRlByPp3iv0THHKhOBinobsQqvgpmVgVf6WKCxHX4exEu+VzD5AO
 LrUB2/kRP5xTi6FKkbdARhEE9Cw==
X-Google-Smtp-Source: AGHT+IGWv7UeSoPb34fpHagBwCHmqdB/aCVhxIZLw1ZExfBFzjuGbq0uZsWnxmVJH9F24HdRQIFOKjFH57eqJC/3kpI=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:2291:b0:dc2:4d91:fb4b with
 SMTP id dn17-20020a056902229100b00dc24d91fb4bmr143458ybb.9.1706211773518;
 Thu, 25 Jan 2024 11:42:53 -0800 (PST)
Date: Thu, 25 Jan 2024 19:42:40 +0000
In-Reply-To: <20240125194247.1589037-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240125194247.1589037-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125194247.1589037-3-nabihestefan@google.com>
Subject: [PATCH v15 2/9] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3vbmyZQwKCjAZMNUTQefQRMZSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Hao Wu <wuhaotsh@google.com>

This patch wires the PCI mailbox module to Nuvoton SoC.

Change-Id: I14c42c628258804030f0583889882842bde0d972
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 docs/system/arm/nuvoton.rst |  2 ++
 hw/arm/npcm7xx.c            | 17 ++++++++++++++++-
 include/hw/arm/npcm7xx.h    |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 0424cae4b0..e611099545 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -50,6 +50,8 @@ Supported devices
  * Ethernet controller (EMC)
  * Tachometer
  * Peripheral SPI controller (PSPI)
+ * BIOS POST code FIFO
+ * PCI Mailbox
 
 Missing devices
 ---------------
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 15ff21d047..c9e87162cb 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -53,6 +53,9 @@
 /* ADC Module */
 #define NPCM7XX_ADC_BA          (0xf000c000)
 
+/* PCI Mailbox Module */
+#define NPCM7XX_PCI_MBOX_BA     (0xf0848000)
+
 /* Internal AHB SRAM */
 #define NPCM7XX_RAM3_BA         (0xc0008000)
 #define NPCM7XX_RAM3_SZ         (4 * KiB)
@@ -83,6 +86,9 @@ enum NPCM7xxInterrupt {
     NPCM7XX_UART1_IRQ,
     NPCM7XX_UART2_IRQ,
     NPCM7XX_UART3_IRQ,
+    NPCM7XX_PCI_MBOX_IRQ        = 8,
+    NPCM7XX_KCS_HIB_IRQ         = 9,
+    NPCM7XX_GMAC1_IRQ           = 14,
     NPCM7XX_EMC1RX_IRQ          = 15,
     NPCM7XX_EMC1TX_IRQ,
     NPCM7XX_MMC_IRQ             = 26,
@@ -456,6 +462,8 @@ static void npcm7xx_init(Object *obj)
         object_initialize_child(obj, "pspi[*]", &s->pspi[i], TYPE_NPCM_PSPI);
     }
 
+    object_initialize_child(obj, "pci-mbox", &s->pci_mbox,
+                            TYPE_NPCM7XX_PCI_MBOX);
     object_initialize_child(obj, "mmc", &s->mmc, TYPE_NPCM7XX_SDHCI);
 }
 
@@ -706,6 +714,14 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* PCI Mailbox. Cannot fail */
+    sysbus_realize(SYS_BUS_DEVICE(&s->pci_mbox), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pci_mbox), 0, NPCM7XX_PCI_MBOX_BA);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pci_mbox), 1,
+        NPCM7XX_PCI_MBOX_BA + NPCM7XX_PCI_MBOX_RAM_SIZE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pci_mbox), 0,
+                       npcm7xx_irq(s, NPCM7XX_PCI_MBOX_IRQ));
+
     /* RAM2 (SRAM) */
     memory_region_init_ram(&s->sram, OBJECT(dev), "ram2",
                            NPCM7XX_RAM2_SZ, &error_abort);
@@ -765,7 +781,6 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("npcm7xx.usbd[8]",      0xf0838000,   4 * KiB);
     create_unimplemented_device("npcm7xx.usbd[9]",      0xf0839000,   4 * KiB);
     create_unimplemented_device("npcm7xx.sd",           0xf0840000,   8 * KiB);
-    create_unimplemented_device("npcm7xx.pcimbx",       0xf0848000, 512 * KiB);
     create_unimplemented_device("npcm7xx.aes",          0xf0858000,   4 * KiB);
     create_unimplemented_device("npcm7xx.des",          0xf0859000,   4 * KiB);
     create_unimplemented_device("npcm7xx.sha",          0xf085a000,   4 * KiB);
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 72c7722096..cec3792a2e 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -26,6 +26,7 @@
 #include "hw/misc/npcm7xx_clk.h"
 #include "hw/misc/npcm7xx_gcr.h"
 #include "hw/misc/npcm7xx_mft.h"
+#include "hw/misc/npcm7xx_pci_mbox.h"
 #include "hw/misc/npcm7xx_pwm.h"
 #include "hw/misc/npcm7xx_rng.h"
 #include "hw/net/npcm7xx_emc.h"
@@ -104,6 +105,7 @@ struct NPCM7xxState {
     OHCISysBusState     ohci;
     NPCM7xxFIUState     fiu[2];
     NPCM7xxEMCState     emc[2];
+    NPCM7xxPCIMBoxState pci_mbox;
     NPCM7xxSDHCIState   mmc;
     NPCMPSPIState       pspi[2];
 };
-- 
2.43.0.429.g432eaa2c6b-goog


