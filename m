Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334A606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sn0xcyaS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQNgO-0005gl-Lt; Mon, 09 Nov 2026 06:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xQNfn-0005PX-Iy
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:36:31 -0500
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xQNfl-0000IO-Tu
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:36:27 -0500
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-36a315ed211so863650eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 03:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794224184; x=1794828984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3hJeYcWc43VllDfAturIQbOq+KQbmMRGhF0LWAnkeXw=;
 b=sn0xcyaS60Sw1qN6vsb6Cl4/YYDK8SE/ihjpICwu6bPzbzfIgm/MqnEHrnvPVbb55z
 v1zUIoNf67sWkguJC80YFl8KCDxP6LKqKu4QmWDgf97b9SrF3sJ8GQf3YR2yXY/YRklD
 gu+yK+xwvRNFm63SNO99baTX+gJXYnPBHTDFEWuj/5QHjw1WGCa4gKLAU0zVIbSBs7wx
 Yw3Ifd4elhXQzNrmU6EK2v0puWVs7snA+BUWz7Lqm0l2vsG9+YD1w1HDJuyQBf+eifRy
 bfGzuA3MEdqbV9f8RABbnBYJ/B+ILkSZ5ocxgG3OQHkPR9aCseMvVAkmxzH8NcWAl0XM
 Iwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794224184; x=1794828984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3hJeYcWc43VllDfAturIQbOq+KQbmMRGhF0LWAnkeXw=;
 b=xgTmAwSoto5R1pNqfSKU7t7UfGD2dVLFxC2VAIezbc9kAQCkvVL8b8yvKfIvoedAO4
 K+OAZ3LKRqexanDD0+A0AA7KwlTuS1e8if9ifcaRgjCRJhJYGpMc/bveajUwfGV8FiIh
 ZNbKbEK5flT78EUhH3VjWuMZj2KVauxKUdPEaUDfTaxVMeCpztW1Ab7LR5h2Ay7wtLn0
 Stj2dWu6ZThmIN4lBrQ+P4enqe60GnT+h7vkwU4ZS2l9uUbxz52Gs8hQPhbJY30/Z0Vh
 6kJhVxwqjd/t9ChuBVca9Sk/5GOxNNMT7JhVL6OJK1Uc1zqLuK5EcqmIcAHc5DCzkqMC
 Kc1A==
X-Gm-Message-State: APuU4Z/kJ2xOukL1CaWW5gDNZfuBxwmrkDX3SfabOOALOa1Eidmwma80
 67SnQD3iuSBP5BnckUf2p2CuliFdUeDxhFwA5woK6S2hman6Bbr1tDopqDQlsny8DzQ=
X-Gm-Gg: AYBFou2zeg1BBbI1lx8yVdgY7VltD7FmtkevwU+2HCnoCS9kdEJ9gKNqor3uqpN674n
 xVxiymh/dLZvkB5LtfBZT5ks23QM7EpFt+JubGP1DNHRXJqRppXjv/Gba6hTgkEtq8l5wfY17uh
 0YU9Yxnk6CP7vgLuAyOS78mvpHmmmeVusbZVcMINtbRKu/+17zpovFSzfMB4k2FuYfb8J3ZHe7W
 1mg3V/GQdjCO8ltKwJqJ3qzeEFHPGQu9mQfzhArSV3wom7smhATdO6877aAkDbcN77zfYmktenG
 yO9Jspjy1HYHluv1KMfJ86u799uC2+Rkw/Zrg2ixqPS4PvGDQZxFABgGERl7/YKz/6bQepcUNTw
 lQJ1gtOxxYJI9hpiNULORBB7raeciT2FmmhxFO2DUxTdg1KQPZwlJugWXe1V1djgnIUyP1mRClw
 VlJovvOU+N/PspHMA0dQHiBSZELcjekJoV7+tXSzK2HKKIKNOTxcml23cSXabe3GXghgcfRelvl
 xqbzC94+SEP6CBoO3+Nw1CWMv/87R44u+/aP85giYEzMkiOC2Kvy1hb2xe8OhWPw1zsBQx52QBZ
 40jqcA6Ma8RFNymnl6CHeq/d0pWi8Hf/AmNonGHGQTPGg6h3Tt1/4w==
X-Received: by 2002:a05:7301:1630:b0:36c:a1bc:6102 with SMTP id
 5a478bee46e88-37250ee43c8mr6047306eec.0.1794224184105; 
 Mon, 09 Nov 2026 03:36:24 -0800 (PST)
Received: from ubuntu.lan ([2405:4802:913e:86f0:35c7:7294:a0c3:69b2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372660f444csm19762941eec.19.2026.11.09.03.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 03:36:23 -0800 (PST)
From: Khai Do <dovankhai97@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com,
 strahinja.p.jankovic@gmail.com, Khai Do <dovankhai97@gmail.com>
Subject: [PATCH v2 7/8] hw/arm/allwinner-h618: Connect Allwinner SD/MMC host
 controller 0
Date: Mon,  9 Nov 2026 18:35:35 +0700
Message-ID: <20261109113545.18561-8-dovankhai97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109113545.18561-1-dovankhai97@gmail.com>
References: <20261109113545.18561-1-dovankhai97@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=dovankhai97@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Wire up the Allwinner SD/MMC host controller 0 (SMHC0) into the
Allwinner H618 SoC model:
- Map MMC0 MMIO registers at 0x04020000
- Connect GIC interrupt SPI 35 (AW_H618_GIC_SPI_MMC0)
- Remove mmc0 from unimplemented peripheral list
- Alias "sd-bus" property from mmc0
- Select ALLWINNER_SDHOST in ALLWINNER_H618 Kconfig

Signed-off-by: Khai Do <dovankhai97@gmail.com>
---
 hw/arm/Kconfig                  |  1 +
 hw/arm/allwinner-h618.c         | 16 +++++++++++++++-
 include/hw/arm/allwinner-h618.h |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 18c45bc9e4..655047fc47 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -341,6 +341,7 @@ config ALLWINNER_H618
     select SERIAL_MM
     select ARM_GIC
     select ALLWINNER_SID
+    select ALLWINNER_SDHOST
     select UNIMP
 
 config MAX78000_SOC
diff --git a/hw/arm/allwinner-h618.c b/hw/arm/allwinner-h618.c
index 19e9c3f0a3..9083e478d5 100644
--- a/hw/arm/allwinner-h618.c
+++ b/hw/arm/allwinner-h618.c
@@ -29,6 +29,7 @@ const hwaddr allwinner_h618_memmap[] = {
     [AW_H618_DEV_GIC_CPU]  = 0x03022000,
     [AW_H618_DEV_GIC_HYP]  = 0x03024000,
     [AW_H618_DEV_GIC_VCPU] = 0x03026000,
+    [AW_H618_DEV_MMC0]     = 0x04020000,
     [AW_H618_DEV_SID]      = 0x03006000,
     [AW_H618_DEV_UART0]    = 0x05000000,
     [AW_H618_DEV_UART1]    = 0x05000400,
@@ -49,7 +50,6 @@ static const struct AwH618Unimplemented {
     { "timer",     0x03009000, 4 * KiB },
     { "pwm",       0x0300a000, 4 * KiB },
     { "pio",       0x0300b000, 4 * KiB },
-    { "mmc0",      0x04020000, 4 * KiB },
     { "mmc1",      0x04021000, 4 * KiB },
     { "mmc2",      0x04022000, 4 * KiB },
     { "rtc",       0x07000000, 4 * KiB },
@@ -72,6 +72,7 @@ enum {
     AW_H618_GIC_SPI_UART1 = 1,
     AW_H618_GIC_SPI_UART2 = 2,
     AW_H618_GIC_SPI_UART3 = 3,
+    AW_H618_GIC_SPI_MMC0  = 35,
 };
 
 enum {
@@ -95,6 +96,8 @@ static void allwinner_h618_init(Object *obj)
     object_initialize_child(obj, "sid", &s->sid, TYPE_AW_SID);
     object_property_add_alias(obj, "identifier", OBJECT(&s->sid),
                               "identifier");
+
+    object_initialize_child(obj, "mmc0", &s->mmc0, TYPE_AW_SDHOST_SUN50I_A64);
 }
 
 static void allwinner_h618_realize(DeviceState *dev, Error **errp)
@@ -181,6 +184,17 @@ static void allwinner_h618_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->sid), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H618_DEV_SID]);
 
+    /* SD/MMC 0 */
+    object_property_set_link(OBJECT(&s->mmc0), "dma-memory",
+                             OBJECT(get_system_memory()), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->mmc0), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, s->memmap[AW_H618_DEV_MMC0]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0,
+                       qdev_get_gpio_in(DEVICE(&s->gic), AW_H618_GIC_SPI_MMC0));
+
+    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
+                              "sd-bus");
+
     /* SRAM */
     memory_region_init_ram(&s->sram_a1, OBJECT(dev), "sram A1",
                            64 * KiB, &error_abort);
diff --git a/include/hw/arm/allwinner-h618.h b/include/hw/arm/allwinner-h618.h
index d4c3d19725..ea2ec205c8 100644
--- a/include/hw/arm/allwinner-h618.h
+++ b/include/hw/arm/allwinner-h618.h
@@ -12,6 +12,7 @@
 #include "qom/object.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/misc/allwinner-sid.h"
+#include "hw/sd/allwinner-sdhost.h"
 #include "target/arm/cpu.h"
 
 /**
@@ -24,6 +25,7 @@ enum {
     AW_H618_DEV_GIC_CPU,
     AW_H618_DEV_GIC_HYP,
     AW_H618_DEV_GIC_VCPU,
+    AW_H618_DEV_MMC0,
     AW_H618_DEV_SID,
     AW_H618_DEV_UART0,
     AW_H618_DEV_UART1,
@@ -53,6 +55,7 @@ struct AwH618State {
     const hwaddr *memmap;
     GICState gic;
     AwSidState sid;
+    AwSdHostState mmc0;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
 };
-- 
2.43.0


