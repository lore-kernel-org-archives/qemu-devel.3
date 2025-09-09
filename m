Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5994CCAC58C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 22:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw6a5-0007Uj-2c; Tue, 09 Sep 2025 18:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DqbAaAYKCqkhdKRWiPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--yubinz.bounces.google.com>)
 id 1uw6Yv-0007EF-DT
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:41 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DqbAaAYKCqkhdKRWiPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--yubinz.bounces.google.com>)
 id 1uw6Ym-0004zP-9x
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:41 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b471757d82fso4499911a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 15:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757455887; x=1758060687; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=F588uJdwSe2S0/Nu/dwsYpfKG+8PROTNmuEZYc2VPvY=;
 b=dTLWe1hB0YRVu/z0tT8K2GqD2iO+qbswco3AB2tB2mPmZTrHMaN68b0wcbxcH46PE8
 yvEIggYxxWQyz21EKGrFZ2jexG5XAzpGOj2vZNmINN+fJ5S9KS8SRXMxNSrwy+V8U8l4
 zZkeNJMMtErNeTzGYR7cYLm0gYO5Tk7tLIDzn2bkWAlxWe4HkwG9oalEuFKVXKRrhHOE
 C1klmWNGLIIgqhxTUllo05TF6M23LyiT3ttJjV/7MHh8BZjjq3Ql/WFK8D2iu46Ou4jf
 mGDE5+GkjVM0YlbBF0Tp3cMMAx4094PoVILuS73A0fBAupCgBoOhuqq4rQHkbkUxU5Ip
 GIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757455887; x=1758060687;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F588uJdwSe2S0/Nu/dwsYpfKG+8PROTNmuEZYc2VPvY=;
 b=uC7xQC+ehT1vwXx/5iEN/okHc54osDoc54ov4kqvRHDQCNBWNk3A3o2+K9aFckkMIi
 EHcsmXiBqwNGue1zJP5KIligwhmy2JyFrUPP+YV7gU2JfAm7680T8ODDkKNCMcCzkyB9
 C0lRNj7uee7g5avxFK1rYyPjPKTdBqfeGEiSxO+UlA5hNJFhsAtsJGz8fVsrK4fpwffB
 otzFYQdWCJ6G/OIKXTtWrKt7nXNeS05rQibidtBs2eWO+MVfedmqpi1Ed6gA+Ud4jUIN
 as6y8MaHnZYdSDDo6JmOSX2J1ch+GhR3331kV1yYats562FlwidsS1O9A2rF6kimGqEh
 J0Iw==
X-Gm-Message-State: AOJu0Yx8wsqPuUgxrJfm/lONGCZuP9x/baBjln0eeY7K5R8W1QKd17yD
 RBA+7WqGEOGsjIMtfEZwD68jh82Uqih9qC3kvuKNVgy2m0NLz1fqorHPPHucy9tL1DPBWP5unZT
 nqK7hYGaLz9LkEhqVSDpqnd4y396s0xjtyVoEpIee0DwFT3CkSGBgYgSD6E3/u69oV8RKDZSEKE
 yj/WAWL4+UEUD3oBtWtYlwQtiBsQUUeyeRjzE=
X-Google-Smtp-Source: AGHT+IHWyIQ8xdsKBk1uekp/zKYMnccXNUd3+n+Or0j1WXiyU/i+YaprjU3gejfPGzA6Goz7imBny06ya0I=
X-Received: from pjbee8.prod.google.com ([2002:a17:90a:fc48:b0:329:7dfc:f4e1])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7781:b0:254:b352:64af
 with SMTP id adf61e73a8af0-254b38066a0mr14376672637.41.1757455886725; Tue, 09
 Sep 2025 15:11:26 -0700 (PDT)
Date: Tue, 09 Sep 2025 22:10:58 +0000
In-Reply-To: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
Mime-Version: 1.0
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250909-pcie-root-upstream-v1-3-d85883b2688d@google.com>
Subject: [PATCH 3/7] hw/arm: attach PCIe root complex to npmcm8xx
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Yubin Zou <yubinz@google.com>, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3DqbAaAYKCqkhdKRWiPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Sep 2025 18:12:49 -0400
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

From: Titus Rwantare <titusr@google.com>

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/arm/Kconfig           |  3 ++-
 hw/arm/npcm8xx.c         | 10 +++++++++-
 include/hw/arm/npcm8xx.h |  2 ++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2aa4b5d77864ff01e69650711e7d914f351e9966..6ac38d083e4a01e09fc00e63df66046c7c17b356 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -499,7 +499,8 @@ config NPCM8XX
     select SERIAL
     select SSI
     select UNIMP
-
+    select CMIS
+    select NPCM_PCIERC
 
 config FSL_IMX25
     bool
diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index a276fea6985715cf82ea0ac7bb5aae78d2003ccf..9b3e648e3fc3ca4352d5c8d310a19ea462e62cc7 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -50,6 +50,7 @@
 #define NPCM8XX_CLK_BA          0xf0801000
 #define NPCM8XX_MC_BA           0xf0824000
 #define NPCM8XX_RNG_BA          0xf000b000
+#define NPCM8XX_PCIERC_BA       0xe1000000
 
 /* ADC Module */
 #define NPCM8XX_ADC_BA          0xf000c000
@@ -136,6 +137,7 @@ enum NPCM8xxInterrupt {
     NPCM8XX_GPIO5_IRQ,
     NPCM8XX_GPIO6_IRQ,
     NPCM8XX_GPIO7_IRQ,
+    NPCM8XX_PCIE_RC_IRQ         = 127,
     NPCM8XX_SMBUS0_IRQ          = 128,
     NPCM8XX_SMBUS1_IRQ,
     NPCM8XX_SMBUS2_IRQ,
@@ -467,6 +469,7 @@ static void npcm8xx_init(Object *obj)
 
     object_initialize_child(obj, "mmc", &s->mmc, TYPE_NPCM7XX_SDHCI);
     object_initialize_child(obj, "pspi", &s->pspi, TYPE_NPCM_PSPI);
+    object_initialize_child(obj, "pcierc", &s->pcierc, TYPE_NPCM_PCIERC);
 }
 
 static void npcm8xx_realize(DeviceState *dev, Error **errp)
@@ -766,10 +769,15 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pspi), 0,
             npcm8xx_irq(s, NPCM8XX_PSPI_IRQ));
 
+    /* PCIe RC */
+    sysbus_realize(SYS_BUS_DEVICE(&s->pcierc), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcierc), 0, NPCM8XX_PCIERC_BA);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcierc), 0,
+                       npcm8xx_irq(s, NPCM8XX_PCIE_RC_IRQ));
+
     create_unimplemented_device("npcm8xx.shm",          0xc0001000,   4 * KiB);
     create_unimplemented_device("npcm8xx.gicextra",     0xdfffa000,  24 * KiB);
     create_unimplemented_device("npcm8xx.vdmx",         0xe0800000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.pcierc",       0xe1000000,  64 * KiB);
     create_unimplemented_device("npcm8xx.rootc",        0xe8000000, 128 * MiB);
     create_unimplemented_device("npcm8xx.kcs",          0xf0007000,   4 * KiB);
     create_unimplemented_device("npcm8xx.gfxi",         0xf000e000,   4 * KiB);
diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
index a8377db490586636ca4c2e491c91f40de0f17d87..fa968e9c0881adac6a27fb5f2117e2fce163be47 100644
--- a/include/hw/arm/npcm8xx.h
+++ b/include/hw/arm/npcm8xx.h
@@ -31,6 +31,7 @@
 #include "hw/net/npcm_gmac.h"
 #include "hw/net/npcm_pcs.h"
 #include "hw/nvram/npcm7xx_otp.h"
+#include "hw/pci-host/npcm_pcierc.h"
 #include "hw/sd/npcm7xx_sdhci.h"
 #include "hw/timer/npcm7xx_timer.h"
 #include "hw/ssi/npcm7xx_fiu.h"
@@ -104,6 +105,7 @@ struct NPCM8xxState {
     NPCMPCSState        pcs;
     NPCM7xxSDHCIState   mmc;
     NPCMPSPIState       pspi;
+    NPCMPCIERCState     pcierc;
 };
 
 struct NPCM8xxClass {

-- 
2.51.0.384.g4c02a37b29-goog


