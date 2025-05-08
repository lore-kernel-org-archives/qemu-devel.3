Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B17C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD9Ot-0007Rv-Iz; Thu, 08 May 2025 18:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HCsdaAwKCi8YLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1uD9Or-0007LU-M2
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:07:29 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HCsdaAwKCi8YLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1uD9Op-0001gq-EW
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:07:29 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-736c7df9b6cso1912175b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1746742044; x=1747346844; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=y8fZ2oazQrEG5s1AS0nB/dvBEbv4XtnmcMMlYNe4V5k=;
 b=eiy50BvVW45y/oE5CNt2L3nlf0/qzCPIkyGidnIdk2dku1CI/uXnI39y1PDYYPewuX
 GsEqUCWdCKZrPW9d37jVFWPWSKRX4e04iikA4IuAiJNZYsMwOd5NmRnxrHTl6DpoHHKD
 eWe2ucHXpIh7yvBkyw0N/fzCwRSsprkrlO4bjno9xbhc3y3VHewq/C4mq6FWlmnlDd1m
 lyvJnTzWedn21CNsmKjITadFDd1WheFkr0mhfNAiUF2DZWBQcGnW6M0c9j/PrGa/BPwP
 bYucxevk5okdPCfXZNMGoGtLSHPir5afAvbGB5pqnC9VMm1dNzIDjOnYNdzCCw21zEhY
 oodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746742044; x=1747346844;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y8fZ2oazQrEG5s1AS0nB/dvBEbv4XtnmcMMlYNe4V5k=;
 b=Pr560psBXT8sY8YU4Qt5Tz6bdu5CT4xwMj4ZVYfA/B9eT1TMBM5pu06yHOJYQ+QoZD
 wsfU07mFcsDlfQ88UQ7qzMH1kvMXtjZ6hGPljVulWlbIHDek6wS9MrKfhRAtKz25VzSX
 hfFLt0Ynbcj9y5a+yP+VUp60qs2d5PgST/j2bdi2F2wJlcYfIWypgyfXb4eYtLR/gH4O
 L+09tjrAFer9Ny4XBbpH0cgZogv2I5N9RSXpVEEQUdzXO8uigqeT5Nr0qCqJrYfPlB6R
 htd+/4qg1A9slAMZpTMizumDzwy989crADmCHu3srnfY70RdUy6Jo1wvZomk8FZWz9vj
 Lojg==
X-Gm-Message-State: AOJu0YyrXKGJYvghbvzuIFA5Jk2sD7k+vnNbfRF0md8vS+vGsDKPcg1J
 DwkWy9qzPVyIQYW2UBLPmKpZVYFF08cGB5i5/91lR4z9E+P7qQRTQ9n8eYD+yfxwfies/f8ej0R
 I8UjEjHy8xkbczmFakYHqTIMCIOezBgwSVjv8oVZxzy6ZSrkvSlnO81CQORXUSJhwe3Q/iSWwen
 FMgI6+I8EsmS3xiW4eUobCfWz27Iwdvc4YV/WiVtK7A06e7OLags+YX27O10aNghA=
X-Google-Smtp-Source: AGHT+IFYC2QSX1HCxtDZ+yoNhI45RIsfiH0cFCs++OpgTR/wyiF6cJWwai1ZHeegr/Eukpf++WyLGye4hGOfuWzEcLQ=
X-Received: from pgut4.prod.google.com ([2002:a65:6084:0:b0:b1f:f3f1:9e07])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d81:b0:1f5:7df9:f13c with SMTP id
 adf61e73a8af0-215abc734c6mr1249250637.41.1746742044337; 
 Thu, 08 May 2025 15:07:24 -0700 (PDT)
Date: Thu,  8 May 2025 22:07:17 +0000
In-Reply-To: <20250508220718.735415-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20250508220718.735415-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508220718.735415-2-nabihestefan@google.com>
Subject: [PATCH 1/2] hw/arm: Add GMAC devices to NPCM8XX SoC
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: kfting@nuvoton.com, wuhaotsh@google.com, peter.maydell@linaro.org, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, qemu-arm@nongnu.org, 
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3HCsdaAwKCi8YLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The GMAC was originally created for the 8xx machine. During upstreaming
both the GMAC and the 8XX we removed it so they would not depend on each
other for the process, that connection should be added back in.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/arm/npcm8xx.c         | 54 ++++++++++++++++++++++++++++++++++++----
 include/hw/arm/npcm8xx.h |  5 +++-
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index d7ee306de7..d14bf55cd7 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -67,6 +67,9 @@
 /* SDHCI Modules */
 #define NPCM8XX_MMC_BA          0xf0842000
 
+/* PCS Module */
+#define NPCM8XX_PCS_BA          0xf0780000
+
 /* PSPI Modules */
 #define NPCM8XX_PSPI_BA         0xf0201000
 
@@ -85,6 +88,10 @@ enum NPCM8xxInterrupt {
     NPCM8XX_ADC_IRQ             = 0,
     NPCM8XX_PECI_IRQ            = 6,
     NPCM8XX_KCS_HIB_IRQ         = 9,
+    NPCM8XX_GMAC1_IRQ           = 14,
+    NPCM8XX_GMAC2_IRQ,
+    NPCM8XX_GMAC3_IRQ,
+    NPCM8XX_GMAC4_IRQ,
     NPCM8XX_MMC_IRQ             = 26,
     NPCM8XX_PSPI_IRQ            = 28,
     NPCM8XX_TIMER0_IRQ          = 32,   /* Timer Module 0 */
@@ -260,6 +267,14 @@ static const hwaddr npcm8xx_smbus_addr[] = {
     0xfff0a000,
 };
 
+/* Register base address for each GMAC Module */
+static const hwaddr npcm8xx_gmac_addr[] = {
+    0xf0802000,
+    0xf0804000,
+    0xf0806000,
+    0xf0808000,
+};
+
 /* Register base address for each USB host EHCI registers */
 static const hwaddr npcm8xx_ehci_addr[] = {
     0xf0828100,
@@ -444,6 +459,11 @@ static void npcm8xx_init(Object *obj)
         object_initialize_child(obj, "mft[*]", &s->mft[i], TYPE_NPCM7XX_MFT);
     }
 
+    for (i = 0; i < ARRAY_SIZE(s->gmac); i++) {
+        object_initialize_child(obj, "gmac[*]", &s->gmac[i], TYPE_NPCM_GMAC);
+    }
+    object_initialize_child(obj, "pcs", &s->pcs, TYPE_NPCM_PCS);
+
     object_initialize_child(obj, "mmc", &s->mmc, TYPE_NPCM7XX_SDHCI);
     object_initialize_child(obj, "pspi", &s->pspi, TYPE_NPCM_PSPI);
 }
@@ -668,6 +688,35 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(sbd, 0, npcm8xx_irq(s, NPCM8XX_MFT0_IRQ + i));
     }
 
+    /*
+     * GMAC Modules. Cannot fail.
+     */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_gmac_addr) != ARRAY_SIZE(s->gmac));
+    for (i = 0; i < ARRAY_SIZE(s->gmac); i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->gmac[i]);
+
+        /* This is used to make sure that the NIC can create the device */
+        qemu_configure_nic_device(DEVICE(sbd), false, NULL);
+
+        /*
+         * The device exists regardless of whether it's connected to a QEMU
+         * netdev backend. So always instantiate it even if there is no
+         * backend.
+         */
+        sysbus_realize(sbd, &error_abort);
+        sysbus_mmio_map(sbd, 0, npcm8xx_gmac_addr[i]);
+        /*
+         * N.B. The values for the second argument sysbus_connect_irq are
+         * chosen to match the registration order in npcm7xx_emc_realize.
+         */
+        sysbus_connect_irq(sbd, 0, npcm8xx_irq(s, NPCM8XX_GMAC1_IRQ + i));
+    }
+    /*
+     * GMAC Physical Coding Sublayer(PCS) Module. Cannot fail.
+     */
+    sysbus_realize(SYS_BUS_DEVICE(&s->pcs), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcs), 0, NPCM8XX_PCS_BA);
+
     /*
      * Flash Interface Unit (FIU). Can fail if incorrect number of chip selects
      * specified, but this is a programming error.
@@ -741,12 +790,7 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("npcm8xx.ahbpci",       0xf0400000,   1 * MiB);
     create_unimplemented_device("npcm8xx.dap",          0xf0500000, 960 * KiB);
     create_unimplemented_device("npcm8xx.mcphy",        0xf05f0000,  64 * KiB);
-    create_unimplemented_device("npcm8xx.pcs",          0xf0780000, 256 * KiB);
     create_unimplemented_device("npcm8xx.tsgen",        0xf07fc000,   8 * KiB);
-    create_unimplemented_device("npcm8xx.gmac1",        0xf0802000,   8 * KiB);
-    create_unimplemented_device("npcm8xx.gmac2",        0xf0804000,   8 * KiB);
-    create_unimplemented_device("npcm8xx.gmac3",        0xf0806000,   8 * KiB);
-    create_unimplemented_device("npcm8xx.gmac4",        0xf0808000,   8 * KiB);
     create_unimplemented_device("npcm8xx.copctl",       0xf080c000,   4 * KiB);
     create_unimplemented_device("npcm8xx.tipctl",       0xf080d000,   4 * KiB);
     create_unimplemented_device("npcm8xx.rst",          0xf080e000,   4 * KiB);
diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
index 3436abff99..a8377db490 100644
--- a/include/hw/arm/npcm8xx.h
+++ b/include/hw/arm/npcm8xx.h
@@ -28,7 +28,8 @@
 #include "hw/misc/npcm7xx_mft.h"
 #include "hw/misc/npcm7xx_pwm.h"
 #include "hw/misc/npcm7xx_rng.h"
-#include "hw/net/npcm7xx_emc.h"
+#include "hw/net/npcm_gmac.h"
+#include "hw/net/npcm_pcs.h"
 #include "hw/nvram/npcm7xx_otp.h"
 #include "hw/sd/npcm7xx_sdhci.h"
 #include "hw/timer/npcm7xx_timer.h"
@@ -99,6 +100,8 @@ struct NPCM8xxState {
     EHCISysBusState     ehci[2];
     OHCISysBusState     ohci[2];
     NPCM7xxFIUState     fiu[3];
+    NPCMGMACState       gmac[4];
+    NPCMPCSState        pcs;
     NPCM7xxSDHCIState   mmc;
     NPCMPSPIState       pspi;
 };
-- 
2.49.0.1015.ga840276032-goog


