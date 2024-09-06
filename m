Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B148ECE7AA3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 12:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smY2j-0002OM-NJ; Fri, 06 Sep 2024 08:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2N-00010h-3T; Fri, 06 Sep 2024 08:26:04 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2L-00024H-E2; Fri, 06 Sep 2024 08:26:02 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5da686531d3so1200958eaf.3; 
 Fri, 06 Sep 2024 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725625559; x=1726230359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fnh3WDG7ZUvlAU0hUupxEFA8UEaS9uiMX+X65G2mxKk=;
 b=SP/7Ltwp+U3zkZjLJVT23PTRI1uffmmM+UNHhhHrcAFtfrHzPzKS+XqX8gBC4Xu83Y
 eVFFzE81WrSujjT/tUxT6+9OdHZNc+Wm8/o0wVU1ujXtAUTZHz9/R861/kFMAhejPAdI
 qNprRyfkHy0T98VgmPiuQa5pXEsara8/UUJ8ovFbjimg38rMmA05UiY2qp1y/gj6f1wi
 wLBRM4KFNjahpJm/O+N4tj1I9zaIWtNxL++KPw6QMZFnKOozgqDHUklyrR4sxaTRyzHD
 UmuCfQeRJFLJYfrxiYlHLohmNVxnnN49c0yWsQ14ZAKJbyQV3BrjJVUdv9GVudrnGFWE
 VCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725625559; x=1726230359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fnh3WDG7ZUvlAU0hUupxEFA8UEaS9uiMX+X65G2mxKk=;
 b=FqVQXhYEU/Pyii6bNVQ2HqiItI+EU+9miyJElxSVfUhm3AMbCS/k0B/o3qLi8e6WTl
 SY5EVQoRLEbL26L5SHN6dkGy0NDoqqSDnc5yH4vfgDCEm3X2ExVNHHAFsJe8Dl0KfgYZ
 0ebV0AnX6XfPtAsCK5iCdlFgpvO4duHdSo20Zc1ccCG5RH8fESHnlomt5twxIEJ/A5pL
 KnFabIU8XJl49lDjozbFIn7uk5An5dCF3rM/sc8glxq9S2YVLjUIONx11d23Bm2z3IJB
 p0+ODFtbDGEPCFdrfRfEHQAN64JSEcV0fUc4+hezTcgm57fDGqh9Nw+49QUCc9opW3RF
 CE3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV80Lvj98B1WlZ8oX9i0WWPKy69jkVC5UhHM5whlVg2CV8iXJ5x7TIx5aHMPp8gFAKddFfFlBaXRA==@nongnu.org
X-Gm-Message-State: AOJu0YyjJYRSMjPfzLkGuedDCkrhiJMPKsNUMysE2xLc589lI6jKfMIq
 Paxx0uOO5RJp9DRetUQ3XOQ4qq6pR+4SRo0YFhpAL5PWjmVFzFDU0EJRRg==
X-Google-Smtp-Source: AGHT+IGh/QJINDQuzDetuHOdH8g/t0O7XwNtbaUn0KnJSHbHCSup+fEa5a0rwutYolcTNWZfbnZ5gg==
X-Received: by 2002:a05:6870:1615:b0:254:affe:5a05 with SMTP id
 586e51a60fabf-27b82ed40b9mr2876276fac.21.1725625558890; 
 Fri, 06 Sep 2024 05:25:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d4fbdaeb9csm4931194a12.81.2024.09.06.05.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:25:58 -0700 (PDT)
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
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 7/8] aspeed: Add uhci support for ast2600
Date: Fri,  6 Sep 2024 05:25:41 -0700
Message-ID: <20240906122542.3808997-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906122542.3808997-1-linux@roeck-us.net>
References: <20240906122542.3808997-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=groeck7@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Enable UHCO support for the ast2600 SoC. With this patch, the UHCI port
is successfully instantiated on the rainier-bmc and ast2600-evb machines.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/aspeed_ast2600.c     | 13 +++++++++++++
 include/hw/arm/aspeed_soc.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index be3eb70cdd..cd7e4ae6c9 100644
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
@@ -481,6 +485,15 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                            aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
     }
 
+    /* UHCI */
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
index 624d489e0d..b54849db72 100644
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


