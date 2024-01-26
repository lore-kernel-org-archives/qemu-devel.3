Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54DEC47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHE-0002Gl-OF; Fri, 26 Jan 2024 09:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHB-0002EX-QH
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:49 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHA-0007sL-12
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:49 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-337d58942c9so555746f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279626; x=1706884426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Udpnn055t0nLxzR8Pti1GosKKa+Y1FeGstBsF+O1OxU=;
 b=ydvtwDbDaaCGkIjSQwpDYN2+5T9grVPZB0PoTH7XxMaMEVdsAqQuTFE5aV70X94kb1
 dcsJfWjyqE7fPchVAVHEYL4It6MvGT0ASNuP4y5tcCrheUdDYI5zzEYHawQVZ2AjBbom
 bA8SDDu7WD4fusfUPA130Aa0m9ZsGJQalT01U96K4qfm45doblR1WFDv16ElDqIOn0Z2
 8kf9gsl2gzXE2XU+KBwhbNZYYhK9Mg9/o4Zp0QM2NiDVBQjvIZzzCnfineK3vqX2zEk7
 hf5eoVuDTDvGrrE18Tqbl9Au26QBxfPvXFFlJWDW9JZErKlxZmW3v33jqD5DmZaj05Jo
 2nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279626; x=1706884426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Udpnn055t0nLxzR8Pti1GosKKa+Y1FeGstBsF+O1OxU=;
 b=fMhPkDo3tiYZisUnrOUBtzQGiD+Hfg6Oig9HCp4QJ+esvI5JkXaQNYwN5D4zY1nPis
 sSs3DdJAmX5LdILA3cMm5OzQssk/uCYy6JgH0Zy+qyoMbLYT7swrqIbrlntGKO8XJz96
 Nv42AqJaEI32ehUCDKCL/oxdevnR1OEbAw+Y5fPOz+Lnu+EBE/pkmsf2p1b+6xshIw6v
 ws8UJxlqimvSzuZsFmmp6Jihidz9e4x5bIanbqxgoDsguO/7+5vw2mKCXWZFIfa2yeIa
 CpW8d9I86Jsr0v2PhTUc9BO5zTkxo5Fhb2EwzFGSkE3FlAiFQQojJhkygDgQzPOjd4vm
 XARQ==
X-Gm-Message-State: AOJu0YxgJoYx/q6eAvth5ec79zJ6thJEA3SQgIClsQBFVEOc69m+/YtV
 HTrA6U2nM2rY6nJTufluGKjGbCxvH4d/uQwd0hj3HJjpAiFXD96syrkY9pH6fEAykPBad0N68/O
 R
X-Google-Smtp-Source: AGHT+IHd8H7A+VKO0VcP2llvADpxZw7CkJSdtwA8kyZ0GyZSwSc2uNnHeMfInQY6i1KFQlYwTzFb7g==
X-Received: by 2002:a5d:5302:0:b0:339:3edd:1435 with SMTP id
 e2-20020a5d5302000000b003393edd1435mr1085643wrv.56.1706279626461; 
 Fri, 26 Jan 2024 06:33:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/36] hw/arm: Add watchdog timer to Allwinner H40 and Bananapi
 board
Date: Fri, 26 Jan 2024 14:33:14 +0000
Message-Id: <20240126143341.2101237-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Guenter Roeck <linux@roeck-us.net>

Add watchdog timer support to Allwinner-H40 and Bananapi.
The watchdog timer is added as an overlay to the Timer
module memory map.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Message-id: 20240115182757.1095012-4-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/bananapi_m2u.rst | 2 +-
 include/hw/arm/allwinner-r40.h   | 3 +++
 hw/arm/allwinner-r40.c           | 8 ++++++++
 hw/arm/Kconfig                   | 1 +
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
index 542310591d6..587b4886553 100644
--- a/docs/system/arm/bananapi_m2u.rst
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -25,6 +25,7 @@ The Banana Pi M2U machine supports the following devices:
  * SATA
  * TWI (I2C)
  * USB 2.0
+ * Hardware Watchdog
 
 Limitations
 """""""""""
@@ -33,7 +34,6 @@ Currently, Banana Pi M2U does *not* support the following features:
 
 - Graphical output via HDMI, GPU and/or the Display Engine
 - Audio output
-- Hardware Watchdog
 - Real Time Clock
 
 Also see the 'unimplemented' array in the Allwinner R40 SoC module
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index c589fcc1c15..66c38e7d907 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -33,6 +33,7 @@
 #include "hw/net/allwinner-sun8i-emac.h"
 #include "hw/usb/hcd-ohci.h"
 #include "hw/usb/hcd-ehci.h"
+#include "hw/watchdog/allwinner-wdt.h"
 #include "target/arm/cpu.h"
 #include "sysemu/block-backend.h"
 
@@ -54,6 +55,7 @@ enum {
     AW_R40_DEV_OHCI2,
     AW_R40_DEV_CCU,
     AW_R40_DEV_PIT,
+    AW_R40_DEV_WDT,
     AW_R40_DEV_UART0,
     AW_R40_DEV_UART1,
     AW_R40_DEV_UART2,
@@ -114,6 +116,7 @@ struct AwR40State {
     const hwaddr *memmap;
     AwSRAMCState sramc;
     AwA10PITState timer;
+    AwWdtState wdt;
     AllwinnerAHCIState sata;
     AwSdHostState mmc[AW_R40_NUM_MMCS];
     EHCISysBusState ehci[AW_R40_NUM_USB];
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 534be4a735d..a28e5b3886a 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -53,6 +53,7 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_OHCI2]      = 0x01c1c400,
     [AW_R40_DEV_CCU]        = 0x01c20000,
     [AW_R40_DEV_PIT]        = 0x01c20c00,
+    [AW_R40_DEV_WDT]        = 0x01c20c90,
     [AW_R40_DEV_UART0]      = 0x01c28000,
     [AW_R40_DEV_UART1]      = 0x01c28400,
     [AW_R40_DEV_UART2]      = 0x01c28800,
@@ -279,6 +280,8 @@ static void allwinner_r40_init(Object *obj)
     object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
                               "clk1-freq");
 
+    object_initialize_child(obj, "wdt", &s->wdt, TYPE_AW_WDT_SUN4I);
+
     object_initialize_child(obj, "ccu", &s->ccu, TYPE_AW_R40_CCU);
 
     for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
@@ -545,6 +548,11 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_EMAC));
 
+    /* WDT */
+    sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_fatal);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->wdt), 0,
+                            allwinner_r40_memmap[AW_R40_DEV_WDT], 1);
+
     /* Unimplemented devices */
     for (unsigned i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
         create_unimplemented_device(r40_unimplemented[i].device_name,
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 704517edd4f..2bc3ea3425e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -411,6 +411,7 @@ config ALLWINNER_R40
     select AHCI
     select ALLWINNER_SRAMC
     select ALLWINNER_A10_PIT
+    select ALLWINNER_WDT
     select AXP2XX_PMU
     select SERIAL
     select ARM_TIMER
-- 
2.34.1


