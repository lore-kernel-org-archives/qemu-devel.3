Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5310ACDD1BA
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 15:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suCaY-0003FU-Bv; Fri, 27 Sep 2024 11:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rcardenas.rod@gmail.com>)
 id 1suCaS-0003A2-NS; Fri, 27 Sep 2024 11:08:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rcardenas.rod@gmail.com>)
 id 1suCaR-0002I3-4J; Fri, 27 Sep 2024 11:08:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cbb08a1a5so20869905e9.3; 
 Fri, 27 Sep 2024 08:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727449727; x=1728054527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ccNtZSWjjIgsAxbHzglO7ffZlva62giUMBlB4A4fpY=;
 b=WMmsTQc5UvGOOdX9qnKShvWDfXRpfzD/znoOBNMyAnUaJRPys0IPIDMXw+0Lzg9Slx
 CRNT8T4Q+TKc7uF3z+rRj9PnohMd+1ZSFps9g3wxuiKzGN6917AsifeVMxU5d4mBD2/l
 A/Jhrom2fAfQLIsysPKYgu6olit6Qp8EWItC/AhNCL8qisLS36sMl56Ai+Pllr3iMvAg
 cPnZZvns+tjQJbwi3sdmhuVnTwNpj+J96KftwPWI6pU34U/7PlyyU3oAR86YSdex+soO
 3+KqAEJkCrc5ZT8CDpc7t79dkRnXd+8zgkTsWRE1cNFQKwte5/ZM/QHcAB8xXP8oGHit
 LTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727449727; x=1728054527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ccNtZSWjjIgsAxbHzglO7ffZlva62giUMBlB4A4fpY=;
 b=VyKRcl+pvWFBmJcwn6CPZg1PwCG03zvq3CU7opM2r1O5tmlczPO6Bio6Ztqem84YK9
 AhDluNIxwKBTg5N/TNwTt0z9L87u0qrnfDFO3x+vLzNqto7fGjJEXzQ3eJD6UG2hriCL
 TfGUh0enExSIY+sG7DRVJSRPsboihze2kSzDe4dHiR3XQBtpmr1p3SNrU3sBBUlB0Pd/
 YZHguvMYrYRgjx1dscb4Zj3inQ8diFwCBfsuHXn6KIUblYQyXQq15KOtltudqy7VHujd
 zMmcNRAEutfZu52JlE0xpaVTnktA/goyg+i4L8AidLKNIbUoSWtwvIIo21eLnR3cKEyd
 aRtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFivuChzxZBJQAOu+YvPPP5XQpT/Jabbq23RDUmRrgblRl6l7IqqOs7zCVNfl5MEiOsJ2z+18KPsx3@nongnu.org
X-Gm-Message-State: AOJu0YwdIMcPJfkD+UAPDp/PTA3RdTzj69mFwRc/IR1z4C6wICoW7oYc
 LFncv8S6vGPJEvB/Uc9npH2YARGluQRYCTyiSG8wv13/W6BY8REWfmO8XmZ5
X-Google-Smtp-Source: AGHT+IFP3kbJLN7W0oBlqjYt2ILePm+xj5Yf1XW0iiNlHT9ce472gbWhE5Y41KUYmobmhqdPgfCiZQ==
X-Received: by 2002:a05:600c:1da6:b0:42c:b187:bde9 with SMTP id
 5b1f17b1804b1-42f584a2dd7mr28625115e9.30.1727449726913; 
 Fri, 27 Sep 2024 08:08:46 -0700 (PDT)
Received: from localhost.localdomain (cm-93-156-192-199.telecable.es.
 [93.156.192.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57dd2e97sm29525905e9.4.2024.09.27.08.08.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 08:08:46 -0700 (PDT)
From: =?UTF-8?q?Rom=C3=A1n=20C=C3=A1rdenas=20Rodr=C3=ADguez?=
 <rcardenas.rod@gmail.com>
To: qemu-arm@nongnu.org
Cc: alistair@alistair23.me, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Rom=C3=A1n=20C=C3=A1rdenas=20Rodr=C3=ADguez?=
 <rcardenas.rod@gmail.com>
Subject: [PATCH 2/4] Add RCC device to stm32f405 SoC
Date: Fri, 27 Sep 2024 17:07:37 +0200
Message-Id: <20240927150738.57786-2-rcardenas.rod@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240927150738.57786-1-rcardenas.rod@gmail.com>
References: <20240927150738.57786-1-rcardenas.rod@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=rcardenas.rod@gmail.com; helo=mail-wm1-x32b.google.com
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
 docs/system/arm/stm32.rst      |  3 ++-
 hw/arm/Kconfig                 |  1 +
 hw/arm/stm32f405_soc.c         | 12 +++++++++++-
 include/hw/arm/stm32f405_soc.h |  2 ++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index 3b640f3ee0..ca7a55841b 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -36,6 +36,7 @@ Supported devices
  * SPI controller
  * System configuration (SYSCFG)
  * Timer controller (TIMER)
+ * Reset and Clock Controller (RCC) (STM32F4 only, reset and enable only)
 
 Missing devices
 ---------------
@@ -53,7 +54,7 @@ Missing devices
  * Power supply configuration (PWR)
  * Random Number Generator (RNG)
  * Real-Time Clock (RTC) controller
- * Reset and Clock Controller (RCC)
+ * Reset and Clock Controller (RCC) (other features than reset and enable)
  * Secure Digital Input/Output (SDIO) interface
  * USB OTG
  * Watchdog controller (IWDG, WWDG)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa..0629f47cb3 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -466,6 +466,7 @@ config STM32F405_SOC
     bool
     select ARM_V7M
     select OR_IRQ
+    select STM32_RCC
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
 
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 2ad5b79a06..72ae62156f 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -30,6 +30,7 @@
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
 
+#define RCC_ADDR                       0x40023800
 #define SYSCFG_ADD                     0x40013800
 static const uint32_t usart_addr[] = { 0x40011000, 0x40004400, 0x40004800,
                                        0x40004C00, 0x40005000, 0x40011400,
@@ -59,6 +60,8 @@ static void stm32f405_soc_initfn(Object *obj)
 
     object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
 
+    object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32_RCC);
+
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32F4XX_SYSCFG);
 
     for (i = 0; i < STM_NUM_USARTS; i++) {
@@ -160,6 +163,14 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    /* Reset and clock controller */
+    dev = DEVICE(&s->rcc);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rcc), errp)) {
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, RCC_ADDR);
+
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
@@ -276,7 +287,6 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("GPIOH",       0x40021C00, 0x400);
     create_unimplemented_device("GPIOI",       0x40022000, 0x400);
     create_unimplemented_device("CRC",         0x40023000, 0x400);
-    create_unimplemented_device("RCC",         0x40023800, 0x400);
     create_unimplemented_device("Flash Int",   0x40023C00, 0x400);
     create_unimplemented_device("BKPSRAM",     0x40024000, 0x400);
     create_unimplemented_device("DMA1",        0x40026000, 0x400);
diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_soc.h
index d15c03c4b5..2eeada64de 100644
--- a/include/hw/arm/stm32f405_soc.h
+++ b/include/hw/arm/stm32f405_soc.h
@@ -25,6 +25,7 @@
 #ifndef HW_ARM_STM32F405_SOC_H
 #define HW_ARM_STM32F405_SOC_H
 
+#include "hw/misc/stm32_rcc.h"
 #include "hw/misc/stm32f4xx_syscfg.h"
 #include "hw/timer/stm32f2xx_timer.h"
 #include "hw/char/stm32f2xx_usart.h"
@@ -55,6 +56,7 @@ struct STM32F405State {
 
     ARMv7MState armv7m;
 
+    STM32RccState rcc;
     STM32F4xxSyscfgState syscfg;
     STM32F4xxExtiState exti;
     STM32F2XXUsartState usart[STM_NUM_USARTS];
-- 
2.39.3 (Apple Git-146)


