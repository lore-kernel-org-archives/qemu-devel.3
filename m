Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE72BD42BB0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuC6-00038B-LM; Tue, 12 Nov 2024 11:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuC2-000371-Bn; Tue, 12 Nov 2024 11:56:43 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuC0-0000gQ-O5; Tue, 12 Nov 2024 11:56:42 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20ce65c8e13so65519045ad.1; 
 Tue, 12 Nov 2024 08:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731430599; x=1732035399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2Mkn+a1ArVn/Zal2kb6KrZbuO2GIdq8fyFe0czvqzo=;
 b=GoscKPQZJ30j18nPQzZg0HVeZmXvQiS16qkDfAdeqwlSiQ2WkJwel/QLzRfVsIIadq
 AUEANp4JOS1c2UrKwyZmKoHBwWrqxA60wZB/SrsTgpAQmv552HXcO98Bh+LVHsytudxH
 EQhhEoTyUerxEUrQUiUfaFwU8wGhpJc6wEgNEO+07+RRWJmUZQGN5DW+0h7DeL++MyrI
 x4/OOXvOI8WjknAycTJ2L6xig8E/sXeK638U7uy4gH1eJpdUXj7aSiDLKAaeAyrzZbTB
 1xRnt7blKmOOQTmWT4Gt0N1E3NsRZEizn1pYUvCTv6dc6sAneNpkXsHtIyNeQjpv2I6q
 Hcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731430599; x=1732035399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f2Mkn+a1ArVn/Zal2kb6KrZbuO2GIdq8fyFe0czvqzo=;
 b=DjIjMdNc1g0b2ixZES5uMN8MWS/ZAcAVx5rYVUM/SAyxR8al1jQt4Z3mfOPoqo7Cvb
 1XcdYKtS9exGDl/V2DEiyLoVQ6cWuwRrBIG6kDh0Maye4vRIHx/UMw9bRBIgeE+CrcRy
 CU/7CKZ50GiiM1d7BU4ykLuI0PT0ZfyZ2/koxb22xkgQ9P6SNylDKHPY8moBMgm1Lf3T
 IXnGb7CsmD7CpUQWo+Lnn2oMpbic+ZL8EIcVr0+eirW35ZOpFsEWY5ziIZ747McIJ48K
 613l3TLw/VZw+o1ttxYDlfr8JTKo/9pFYlalFng4WQG0p3IV38QmJP5x3ONync1nmGal
 1T7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc6hXqFvj5z6lt5Hn76kjUikjoqqNXgSpdpYxGo4Pz4gbPpKfzeMQ+yT1I/TW3OpyStALNbgabzg==@nongnu.org
X-Gm-Message-State: AOJu0YyZEuQkAlszPRofS0CrpxWKubFwgE6sWn4CaTPVC9fGP+xubnwO
 AE5aU6fQA5R3tE1qrst4d+BglxFTg7JEMw4B0dRV+CEq+3BvGYmnI9ZPzg==
X-Google-Smtp-Source: AGHT+IE9H5jlNDTGu/zo3XDWwX/1R09yLq2xbf+bHVoQq90ytq3bkCKnZQRw1JbyJWkZ5CI7eM91yQ==
X-Received: by 2002:a17:902:f545:b0:20c:a175:b720 with SMTP id
 d9443c01a7336-211834dffc9mr204000695ad.1.1731430598667; 
 Tue, 12 Nov 2024 08:56:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f643be3sm10791960a12.62.2024.11.12.08.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 08:56:37 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 07/10] aspeed: Add uhci support for ast2600
Date: Tue, 12 Nov 2024 08:56:16 -0800
Message-ID: <20241112165618.217454-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112165618.217454-1-linux@roeck-us.net>
References: <20241112165618.217454-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add UHCI support for the ast2600 SoC. With this patch, UHCI support
is successfully enabled on the rainier-bmc and ast2600-evb machines.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since RFC:
- Rebased to v9.1.0-1673-g134b443512
- Use EHCI companion mode

 hw/arm/aspeed_ast2600.c     | 20 ++++++++++++++++++++
 include/hw/arm/aspeed_soc.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index be3eb70cdd..0592bfb2bf 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -33,6 +33,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_DEV_SPI2]      = 0x1E631000,
     [ASPEED_DEV_EHCI1]     = 0x1E6A1000,
     [ASPEED_DEV_EHCI2]     = 0x1E6A3000,
+    [ASPEED_DEV_UHCI]      = 0x1E6B0000,
     [ASPEED_DEV_MII1]      = 0x1E650000,
     [ASPEED_DEV_MII2]      = 0x1E650008,
     [ASPEED_DEV_MII3]      = 0x1E650010,
@@ -110,6 +111,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_DEV_SDHCI]     = 43,
     [ASPEED_DEV_EHCI1]     = 5,
     [ASPEED_DEV_EHCI2]     = 9,
+    [ASPEED_DEV_UHCI]      = 10,
     [ASPEED_DEV_EMMC]      = 15,
     [ASPEED_DEV_GPIO]      = 40,
     [ASPEED_DEV_GPIO_1_8V] = 11,
@@ -206,6 +208,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
                                 TYPE_PLATFORM_EHCI);
     }
 
+    object_initialize_child(obj, "uhci", &s->uhci, TYPE_ASPEED_UHCI);
+
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
     object_initialize_child(obj, "sdmc", &s->sdmc, typename);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
@@ -294,6 +298,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     qemu_irq irq;
     g_autofree char *sram_name = NULL;
+    g_autofree char *usb_bus = g_strdup_printf("usb-bus.%u", sc->ehcis_num - 1);
 
     /* Default boot region (SPI memory or ROMs) */
     memory_region_init(&s->spi_boot_container, OBJECT(s),
@@ -472,6 +477,10 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* EHCI */
     for (i = 0; i < sc->ehcis_num; i++) {
+        if (i == sc->ehcis_num - 1) {
+            object_property_set_bool(OBJECT(&s->ehci[i]), "companion-enable",
+                                     true, &error_fatal);
+        }
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
             return;
         }
@@ -481,6 +490,17 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                            aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
     }
 
+    /* UHCI */
+    object_property_set_str(OBJECT(&s->uhci), "masterbus", usb_bus,
+                            &error_fatal);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uhci), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->uhci), 0,
+                    sc->memmap[ASPEED_DEV_UHCI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uhci), 0,
+                       aspeed_soc_get_irq(s, ASPEED_DEV_UHCI));
+
     /* SDMC - SDRAM Memory Controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 689f52dae8..e579911ced 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -34,6 +34,7 @@
 #include "hw/gpio/aspeed_gpio.h"
 #include "hw/sd/aspeed_sdhci.h"
 #include "hw/usb/hcd-ehci.h"
+#include "hw/usb/hcd-uhci-sysbus.h"
 #include "qom/object.h"
 #include "hw/misc/aspeed_lpc.h"
 #include "hw/misc/unimp.h"
@@ -72,6 +73,7 @@ struct AspeedSoCState {
     AspeedSMCState fmc;
     AspeedSMCState spi[ASPEED_SPIS_NUM];
     EHCISysBusState ehci[ASPEED_EHCIS_NUM];
+    ASPEEDUHCIState uhci;
     AspeedSBCState sbc;
     AspeedSLIState sli;
     AspeedSLIState sliio;
@@ -193,6 +195,7 @@ enum {
     ASPEED_DEV_SPI2,
     ASPEED_DEV_EHCI1,
     ASPEED_DEV_EHCI2,
+    ASPEED_DEV_UHCI,
     ASPEED_DEV_VIC,
     ASPEED_DEV_INTC,
     ASPEED_DEV_SDMC,
-- 
2.45.2


