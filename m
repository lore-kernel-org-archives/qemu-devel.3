Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBF5CDD1B8
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 15:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suCaa-0003OC-HI; Fri, 27 Sep 2024 11:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rcardenas.rod@gmail.com>)
 id 1suCaV-0003Aw-4k; Fri, 27 Sep 2024 11:08:56 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rcardenas.rod@gmail.com>)
 id 1suCaT-0002IR-8X; Fri, 27 Sep 2024 11:08:54 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f754d4a6e4so25834271fa.3; 
 Fri, 27 Sep 2024 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727449731; x=1728054531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSytVYGlBURBd4nRtFARECJU49ORP9ri1RTMri8YdYg=;
 b=aMIRT7sdIQwPDj9BKZmj3qhtWSs+DEUFeUvDjwwozbR8yBsv1uQPuwOI/GCHDyzlGZ
 MEdN/+lqksVnityK4ejQ9h6KU1PjfSoGX5q1xSPd/9bm9r6O7IsITtmBPs5xAput4cXv
 pFzqXrIqFWOwRNfM8tv2scahaNE9tujWon5A+VTsIWDrIRLdsnU5EGLvAluok9f67w3b
 iCKdjgCGm0K8Xa2MLL/rEgJeaKOi9A6QjdVxblboQT7FEc6c78qzXkGuZcH5V1AzNTrt
 ut9NPPh6p1XWefoo6/2xaHl7uNrVbJsAgaWpJ3+pbFgDZipM6RgM+KYhT9hP0dpntMZM
 n91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727449731; x=1728054531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSytVYGlBURBd4nRtFARECJU49ORP9ri1RTMri8YdYg=;
 b=JIJPi5uBds3kpwemXK1ndFAud6HkAwautNRAlnCpQHEW4EALB3Xm+TpAZJYmVpdSLk
 NtI3daIB+5pM/rn75Vk3IwhBaWn0viuXMFVIsBj4U7k5j4w4nt9Q99OQgtfUTQjtpbyz
 Dogh3jY0BKxXBu/D9/Nz7ibj5j6oXjdE4YrSqBaCWXdxtu0KfbvyECk1Z1om/+A/EuHM
 GoL+ykSGXg+apekiPqK5zHhJdRRUwkg8Tv+8oZCuqXa9r4j/4p8UhsAwYRPBtJrcNgHp
 DFQ8U4j/e7asXmcZ5XUSgwnSCF6j/Ko17VBomPTCdsnT8njZl+K/X8bqdOa1Rz2Y5lu6
 N2QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqp6yLQNNvk8A4cN3YIXXd6SSMnaX9hulT8xhxisHPYenbgTZ0uSoeIehu9N+co0EACODHWfo7sb+Y@nongnu.org
X-Gm-Message-State: AOJu0Yy7C1eA/8uFh0uVfNYWWpjuyzPsNCJUIkKprgA9Y1oTLwGYf56f
 nhPaZ4MdLJqaYl2Piz0iXUTvjm+hme33/kqeP5g7l/X3q7CU1A+Y+Np7wdKr
X-Google-Smtp-Source: AGHT+IF1kyua5iczLj2pD8Xr6nMOzIF/2tZnIeFqNSZKmHcRlaNzHnW92uTPIa+QfrZTcCMyMvDLGw==
X-Received: by 2002:a05:651c:515:b0:2f7:7ef7:7434 with SMTP id
 38308e7fff4ca-2f9d4199f7bmr21356991fa.37.1727449730313; 
 Fri, 27 Sep 2024 08:08:50 -0700 (PDT)
Received: from localhost.localdomain (cm-93-156-192-199.telecable.es.
 [93.156.192.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57dd2e97sm29525905e9.4.2024.09.27.08.08.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 08:08:50 -0700 (PDT)
From: =?UTF-8?q?Rom=C3=A1n=20C=C3=A1rdenas=20Rodr=C3=ADguez?=
 <rcardenas.rod@gmail.com>
To: qemu-arm@nongnu.org
Cc: alistair@alistair23.me, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Rom=C3=A1n=20C=C3=A1rdenas=20Rodr=C3=ADguez?=
 <rcardenas.rod@gmail.com>
Subject: [PATCH 4/4] Add GPIO device to stm32f405 SoC
Date: Fri, 27 Sep 2024 17:07:39 +0200
Message-Id: <20240927150738.57786-4-rcardenas.rod@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240927150738.57786-1-rcardenas.rod@gmail.com>
References: <20240927150738.57786-1-rcardenas.rod@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=rcardenas.rod@gmail.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Roman Cardenas Rodriguez <rcardenas.rod@gmail.com>
---
 hw/arm/Kconfig                 |  1 +
 hw/arm/stm32f405_soc.c         | 40 ++++++++++++++++++++++++++--------
 hw/misc/stm32f4xx_syscfg.c     | 24 ++++++++++++--------
 include/hw/arm/stm32f405_soc.h |  3 +++
 4 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0629f47cb3..031fbe0934 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -467,6 +467,7 @@ config STM32F405_SOC
     select ARM_V7M
     select OR_IRQ
     select STM32_RCC
+    select STM32_GPIO
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
 
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 72ae62156f..1ea5c8314d 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
+#include "hw/arm/stm32.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
@@ -43,6 +44,7 @@ static const uint32_t adc_addr[] = { 0x40012000, 0x40012100, 0x40012200,
 static const uint32_t spi_addr[] =   { 0x40013000, 0x40003800, 0x40003C00,
                                        0x40013400, 0x40015000, 0x40015400 };
 #define EXTI_ADDR                      0x40013C00
+#define GPIO_ADDR                      0x40020000
 
 #define SYSCFG_IRQ               71
 static const int usart_irq[] = { 37, 38, 39, 52, 53, 71, 82, 83 };
@@ -82,6 +84,10 @@ static void stm32f405_soc_initfn(Object *obj)
         object_initialize_child(obj, "spi[*]", &s->spi[i], TYPE_STM32F2XX_SPI);
     }
 
+    for (i = STM32_GPIO_PORT_A; i <= STM32_GPIO_PORT_I; i++) {
+        object_initialize_child(obj, "gpio[*]", &s->gpio[i], TYPE_STM32_GPIO);
+    }
+
     object_initialize_child(obj, "exti", &s->exti, TYPE_STM32F4XX_EXTI);
 
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
@@ -240,6 +246,31 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, spi_irq[i]));
     }
 
+    /* GPIO devices */
+    for (i = STM32_GPIO_PORT_A; i <= STM32_GPIO_PORT_I; i++) {
+        dev = DEVICE(&(s->gpio[i]));
+        qdev_prop_set_uint32(dev, "family", STM32_F4);
+        qdev_prop_set_uint32(dev, "port", i);
+        qdev_prop_set_uint32(dev, "ngpio", STM32_GPIO_NPINS);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0,
+                        GPIO_ADDR + (i * STM32_GPIO_PERIPHERAL_SIZE));
+
+        qdev_connect_gpio_out(DEVICE(&s->rcc), STM32_RCC_GPIO_IRQ_OFFSET + i,
+                              qdev_get_gpio_in_named(dev, "reset-in", 0));
+        qdev_connect_gpio_out(DEVICE(&s->rcc),
+                              STM32_RCC_GPIO_IRQ_OFFSET + i + STM32_RCC_NIRQS,
+                              qdev_get_gpio_in_named(dev, "enable-in", 0));
+        for (int j = 0; j < STM32_GPIO_NPINS; j++) {
+            qdev_connect_gpio_out_named(dev, "input-out", j,
+                                        qdev_get_gpio_in(DEVICE(&s->syscfg),
+                                        i * STM32_GPIO_NPINS + j));
+        }
+    }
+
     /* EXTI device */
     dev = DEVICE(&s->exti);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), errp)) {
@@ -277,15 +308,6 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("timer[9]",    0x40014000, 0x400);
     create_unimplemented_device("timer[10]",   0x40014400, 0x400);
     create_unimplemented_device("timer[11]",   0x40014800, 0x400);
-    create_unimplemented_device("GPIOA",       0x40020000, 0x400);
-    create_unimplemented_device("GPIOB",       0x40020400, 0x400);
-    create_unimplemented_device("GPIOC",       0x40020800, 0x400);
-    create_unimplemented_device("GPIOD",       0x40020C00, 0x400);
-    create_unimplemented_device("GPIOE",       0x40021000, 0x400);
-    create_unimplemented_device("GPIOF",       0x40021400, 0x400);
-    create_unimplemented_device("GPIOG",       0x40021800, 0x400);
-    create_unimplemented_device("GPIOH",       0x40021C00, 0x400);
-    create_unimplemented_device("GPIOI",       0x40022000, 0x400);
     create_unimplemented_device("CRC",         0x40023000, 0x400);
     create_unimplemented_device("Flash Int",   0x40023C00, 0x400);
     create_unimplemented_device("BKPSRAM",     0x40024000, 0x400);
diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
index 7d0f3eb5f5..d42e6821db 100644
--- a/hw/misc/stm32f4xx_syscfg.c
+++ b/hw/misc/stm32f4xx_syscfg.c
@@ -27,6 +27,7 @@
 #include "trace.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
+#include "hw/gpio/stm32_gpio.h"
 #include "hw/misc/stm32f4xx_syscfg.h"
 
 static void stm32f4xx_syscfg_reset(DeviceState *dev)
@@ -45,17 +46,21 @@ static void stm32f4xx_syscfg_reset(DeviceState *dev)
 static void stm32f4xx_syscfg_set_irq(void *opaque, int irq, int level)
 {
     STM32F4xxSyscfgState *s = opaque;
-    int icrreg = irq / 4;
-    int startbit = (irq & 3) * 4;
-    uint8_t config = irq / 16;
+    uint8_t pin = irq & 0xF; /* first 4 bits encode the pin number */
+    uint8_t port = irq >> 4; /* the rest encode the port number */
 
-    trace_stm32f4xx_syscfg_set_irq(irq / 16, irq % 16, level);
+    g_assert(port <= STM32_GPIO_PORT_I); /* stm32f4 only has ports A-I */
+
+    int icrreg = pin / 4;
+    int startbit = (pin % 4) * 4;
+
+    trace_stm32f4xx_syscfg_set_irq(port, pin, level);
 
     g_assert(icrreg < SYSCFG_NUM_EXTICR);
 
-    if (extract32(s->syscfg_exticr[icrreg], startbit, 4) == config) {
-        qemu_set_irq(s->gpio_out[irq], level);
-        trace_stm32f4xx_pulse_exti(irq);
+    if (extract32(s->syscfg_exticr[icrreg], startbit, 4) == port) {
+        qemu_set_irq(s->gpio_out[pin], level);
+        trace_stm32f4xx_pulse_exti(pin);
    }
 }
 
@@ -129,8 +134,9 @@ static void stm32f4xx_syscfg_init(Object *obj)
                           TYPE_STM32F4XX_SYSCFG, 0x400);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
-    qdev_init_gpio_in(DEVICE(obj), stm32f4xx_syscfg_set_irq, 16 * 9);
-    qdev_init_gpio_out(DEVICE(obj), s->gpio_out, 16);
+    qdev_init_gpio_in(DEVICE(obj), stm32f4xx_syscfg_set_irq,
+                      STM32_GPIO_NPINS * (STM32_GPIO_PORT_I + 1));
+    qdev_init_gpio_out(DEVICE(obj), s->gpio_out, STM32_GPIO_NPINS);
 }
 
 static const VMStateDescription vmstate_stm32f4xx_syscfg = {
diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_soc.h
index 2eeada64de..62072815a7 100644
--- a/include/hw/arm/stm32f405_soc.h
+++ b/include/hw/arm/stm32f405_soc.h
@@ -26,6 +26,7 @@
 #define HW_ARM_STM32F405_SOC_H
 
 #include "hw/misc/stm32_rcc.h"
+#include "hw/gpio/stm32_gpio.h"
 #include "hw/misc/stm32f4xx_syscfg.h"
 #include "hw/timer/stm32f2xx_timer.h"
 #include "hw/char/stm32f2xx_usart.h"
@@ -43,6 +44,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(STM32F405State, STM32F405_SOC)
 #define STM_NUM_TIMERS 4
 #define STM_NUM_ADCS 6
 #define STM_NUM_SPIS 6
+#define STM_NUM_GPIOS (STM32_GPIO_PORT_I - STM32_GPIO_PORT_A + 1)
 
 #define FLASH_BASE_ADDRESS 0x08000000
 #define FLASH_SIZE (1024 * 1024)
@@ -64,6 +66,7 @@ struct STM32F405State {
     OrIRQState adc_irqs;
     STM32F2XXADCState adc[STM_NUM_ADCS];
     STM32F2XXSPIState spi[STM_NUM_SPIS];
+    STM32GPIOState gpio[STM_NUM_GPIOS];
 
     MemoryRegion ccm;
     MemoryRegion sram;
-- 
2.39.3 (Apple Git-146)


