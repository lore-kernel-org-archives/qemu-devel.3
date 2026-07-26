Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9FAC5321C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 14:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo0DB-0005yj-F6; Sun, 26 Jul 2026 10:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wo0Cr-0005v0-Vm
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:51:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wo0Cq-000616-6J
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:51:57 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ca64c3ce5fso22786685ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785077514; x=1785682314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IjwguSNnxaa5a5wI2q+FKJUSG7PlKND5S7DmrRXF5ds=;
 b=g2r/mpo+SbAutMyp/LnCUBxAqXIwMkjeaFFUhL+OMUJOAs+HQ1nF54SpP0CP3gagdN
 m2XbzJ3DLd6NAw3QxnGoCA8S2OavFSEqUIbG+x4NjucoUXwBsNgdJbpZ06gQbjS3hsCU
 lwO9sINGntRSAzbXJlMPN87FHzP/y+TEqGprAqHdoJtFDNReegyd+IndDLUSABr2XtwN
 0EUHlExvsDUh6SVx8uiqzSFYR+fuhDiXXV73G99jloUo/4vco3wkcbxhNetH4m3zogys
 QgxCNUGzW9cI+SzNN32u5IYpt/dwqCz1rHahzcjh3tJ6c7POI7WNr/wZcvcCEfVXHIrH
 pCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785077514; x=1785682314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IjwguSNnxaa5a5wI2q+FKJUSG7PlKND5S7DmrRXF5ds=;
 b=OoySREznCJMlyUCidVVDJyxkueVpSn7McivjKb974CFioE8TF8FopCAN06BwE0tGv8
 odtF+JIAuV23FI36NKQS3mx82g97K12XQ+va0VNMu/2ArtFhLzZ0qitxAKGRQrhIbrOw
 frsYEnov9kdJ7dqOr2R3oKpT9lApc1KCWbHvjYvMtrCXlHLWwkcgbj6MKNxBpm9s83Cf
 rAX6+Rdla0Z+FFL9Uf4TncHmQhM0xxZUq5HDT96Il7KFEfoCH7+c2wQcrO5lGhAAaTjw
 jUVtxwu6xrCv5Q1Fz/IVwcg9FfTCW4XIoRwAzSv63cDVHauR3ET/VTfMZjGEgr5Hu98G
 Hbjw==
X-Gm-Message-State: AOJu0YyPszeF3qrPLWEV++DdEaq0TyZ+Or0MhvIlABbM8/EDhixq7r/f
 ughigY7QF4Jht0b8kYJdvH57ryUzZHHnG23Gto/4/Yr4OprlRWcSMdXolzlZOw==
X-Gm-Gg: AR+sD12ZbX8hrNN4MIBd9wjJRqAwTkGF/M404Hpz+al2TyeUt3vT8kLv3tfLtQXv2sL
 /0FhBbfsVw1q1h29aV4O3GrbjNf5Y1FHIuFaLvyWXvAXLxohS1L5cW0ZScVQFiqgZPvg/zql+AS
 vHL0lr4R4O8pB0O6A3J+ab9l3qdzP4kTdeEH2QtPlcsQcGgXgkiVWujypCnTNBfrc/I4SqEq/FY
 p61Cg87qfrZh4wQNUTeX/SeoMR9jsjegMgXO0VeGBLK9TroqLOLjbZs8eobaor0gthGUPLem44u
 9AwmGvbIx1hLrkoVFVuMMLeB97t813qw979MK/VI/Fbgt/sg/SU3NETerKqLe6R24PeCzTMwMav
 KaNWDC/1ghxps/KVuGQFUUsvOaOc6l2TyuWDLxGghdeGzt9Q5Ysm52xJPcKx4s4vmcu+E9UBF8d
 yVWwc5L4FRyQdc3A==
X-Received: by 2002:a17:903:2c0e:b0:2ca:ef16:8e8 with SMTP id
 d9443c01a7336-2cfde825055mr53974475ad.29.1785077514288; 
 Sun, 26 Jul 2026 07:51:54 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81d7f5sm20934195ad.83.2026.07.26.07.51.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 26 Jul 2026 07:51:53 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 qemu-rust@nongnu.org, caojunze424@gmail.com,
 Jack Wang <163wangjack@gmail.com>
Subject: [RFC PATCH v1 3/5] hw/arm/stm32f103: instantiate and map GPIO ports
Date: Sun, 26 Jul 2026 22:51:17 +0800
Message-ID: <20260726145119.19881-4-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726145119.19881-1-163wangjack@gmail.com>
References: <20260726145119.19881-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Create the seven GPIO ports GPIOA..GPIOG by name via qdev_new() and map
them at their APB2 base addresses, removing the corresponding
unimplemented-device stubs so the real devices back that range.

The Rust GPIO type is only present in a Rust-enabled build, so the ports
are created behind an object_class_by_name() check; with --disable-rust
the type is absent and the range is simply left unbacked.

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
 hw/arm/Kconfig                 |  1 +
 hw/arm/stm32f103_board.c       |  2 +-
 hw/arm/stm32f103_soc.c         | 54 +++++++++++++++++++++++++++++-----
 include/hw/arm/stm32f103_soc.h |  9 ++++++
 4 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 66aed6edd7..7aa194c64a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -410,6 +410,7 @@ config STM32F103_SOC
     select STM32F2XX_USART
     select STM32F2XX_SPI
     select STM32F1XX_ADC
+    select STM32F1XX_GPIO if HAVE_RUST
 
 config B_L475E_IOT01A
     bool
diff --git a/hw/arm/stm32f103_board.c b/hw/arm/stm32f103_board.c
index a740483575..fb5041e484 100644
--- a/hw/arm/stm32f103_board.c
+++ b/hw/arm/stm32f103_board.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/boards.h"
+#include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/stm32f103_soc.c b/hw/arm/stm32f103_soc.c
index e76640ec03..75fc99a554 100644
--- a/hw/arm/stm32f103_soc.c
+++ b/hw/arm/stm32f103_soc.c
@@ -24,12 +24,16 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qom/object.h"
 #include "system/address-spaces.h"
 #include "system/system.h"
 #include "hw/arm/stm32f103_soc.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 
+/* QOM type name of the Rust GPIO device (rust/hw/gpio/src/gpio.rs) */
+#define TYPE_STM32F1XX_GPIO_RUST "stm32f1xx-gpio-rust"
+
 #define RCC_ADDR 0x40021000
 
 /* USART addresses: USART1, USART2, USART3, UART4, UART5 */
@@ -47,6 +51,12 @@ static const uint32_t adc_addr[] = {
     0x40012400, 0x40012800, 0x40013C00
 };
 
+/* GPIO addresses: GPIOA, GPIOB, GPIOC, GPIOD, GPIOE, GPIOF, GPIOG */
+static const uint32_t gpio_addr[] = {
+    0x40010800, 0x40010C00, 0x40011000, 0x40011400, 0x40011800, 0x40011C00,
+    0x40012000
+};
+
 static const int usart_irq[] = { 37, 38, 39, 52, 53 };
 static const int spi_irq[]   = { 35, 36, 51 };
 #define ADC_IRQ 18
@@ -199,6 +209,37 @@ static void stm32f103_soc_realize(DeviceState *dev_soc, Error **errp)
                            qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
     }
 
+    /*
+     * GPIO ports GPIOA..GPIOG.
+     *
+     * These are implemented by the Rust device "stm32f1xx-gpio-rust", created
+     * by name with qdev_new() and mapped at its APB2 base address.  On STM32F1
+     * a GPIO port has no dedicated NVIC line of its own: pin-change interrupts
+     * are delivered through the EXTI controller (not yet modelled), so no
+     * sysbus_connect_irq() to the NVIC is done here.
+     *
+     * The GPIO port is only provided by the Rust build; when QEMU is built
+     * with --disable-rust the type is not registered, so skip creating the
+     * ports and leave the address range unbacked.
+     */
+    if (object_class_by_name(TYPE_STM32F1XX_GPIO_RUST)) {
+        for (i = 0; i < STM32F103_NUM_GPIOS; i++) {
+            g_autofree char *name = g_strdup_printf("gpio%c", 'a' + i);
+            s->gpio[i] = qdev_new(TYPE_STM32F1XX_GPIO_RUST);
+            /*
+             * Give each port a stable QOM name ("/machine/soc/gpioa"..) so
+             * tests and the monitor can reach it and its gpio-out lines by
+             * path.
+             */
+            object_property_add_child(OBJECT(s), name, OBJECT(s->gpio[i]));
+            busdev = SYS_BUS_DEVICE(s->gpio[i]);
+            if (!sysbus_realize_and_unref(busdev, errp)) {
+                return;
+            }
+            sysbus_mmio_map(busdev, 0, gpio_addr[i]);
+        }
+    }
+
     /*
      * Unimplemented peripherals -- STM32F103 devices that do not yet
      * have QEMU models.
@@ -231,13 +272,12 @@ static void stm32f103_soc_realize(DeviceState *dev_soc, Error **errp)
     /* APB2 peripherals */
     create_unimplemented_device("AFIO",        0x40010000, 0x400);
     create_unimplemented_device("EXTI",        0x40010400, 0x400);
-    create_unimplemented_device("GPIOA",       0x40010800, 0x400);
-    create_unimplemented_device("GPIOB",       0x40010C00, 0x400);
-    create_unimplemented_device("GPIOC",       0x40011000, 0x400);
-    create_unimplemented_device("GPIOD",       0x40011400, 0x400);
-    create_unimplemented_device("GPIOE",       0x40011800, 0x400);
-    create_unimplemented_device("GPIOF",       0x40011C00, 0x400);
-    create_unimplemented_device("GPIOG",       0x40012000, 0x400);
+    /*
+     * GPIOA..GPIOG (0x40010800..0x40012000) are real devices mapped in the
+     * GPIO loop above when the Rust build is used, so they must NOT be
+     * registered as unimplemented devices here: overlapping MemoryRegions at
+     * the same address abort at runtime.
+     */
     create_unimplemented_device("timer[1]",    0x40012C00, 0x400);
     create_unimplemented_device("timer[8]",    0x40013400, 0x400);
     create_unimplemented_device("timer[9]",    0x40014C00, 0x400);
diff --git a/include/hw/arm/stm32f103_soc.h b/include/hw/arm/stm32f103_soc.h
index 260f3695c0..8d78360ce0 100644
--- a/include/hw/arm/stm32f103_soc.h
+++ b/include/hw/arm/stm32f103_soc.h
@@ -40,6 +40,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(STM32F103State, STM32F103_SOC)
 #define STM32F103_NUM_USARTS 5
 #define STM32F103_NUM_SPIS 3
 #define STM32F103_NUM_ADCS 3
+#define STM32F103_NUM_GPIOS 7
 
 /* High-density STM32F103: 512 KB Flash, 64 KB SRAM */
 #define STM32F103_FLASH_BASE_ADDRESS 0x08000000
@@ -58,6 +59,14 @@ struct STM32F103State {
     OrIRQState adc_irqs;
     STM32F1XXADCState adc[STM32F103_NUM_ADCS];
 
+    /*
+     * GPIOA..GPIOG are implemented by the Rust device "stm32f1xx-gpio-rust".
+     * That device is created by name via qdev_new() (pointer-based mounting)
+     * rather than embedded by value, so no C struct definition is required
+     * here and no struct-size coupling with the Rust side is needed.
+     */
+    DeviceState *gpio[STM32F103_NUM_GPIOS];
+
     MemoryRegion sram;
     MemoryRegion flash;
     MemoryRegion flash_alias;
-- 
2.53.0


