Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DC5C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 22:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXoxw-0001ko-4o; Fri, 04 Jul 2025 18:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxi-0001gG-Ko
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:58 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxa-000795-Q2
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:51 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4a58ba6c945so19389761cf.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751668364; x=1752273164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPqOpy/um3xbd4V0oVsFu1fuPCvLz9RIDN3YgW20xPg=;
 b=mk7wdaJMIOecJMReAnAqDeqqqYUmeR9v3xAJuQMxij8KzTxiFoKRMLv6rXKSsvDdVK
 DtpOekR3mzACtavRu9DEYUJxQhRg5UCaLpQS3OA+3zKZfc1ETDzhK4ZVENrrkYh875JP
 wjElrvVHK6XsPx2L00riVybadCExcKvfVzvtCC+/eTEEZCwiUaRpBcSM4X23L1VqnwRi
 V07U/25cxzmtWMLly2W0fYmSuCjfm98FKsiatYguVQo8lJRISN9P6q9dJtS0qCw6BcJ7
 os+7iad4Er6qsaMSDN6Zj3VkShs95E0D7r0ZxNdepBMwto0bPgC7OnqFBDLGU/lRsK4/
 hETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751668364; x=1752273164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rPqOpy/um3xbd4V0oVsFu1fuPCvLz9RIDN3YgW20xPg=;
 b=s+ciBZVcmbhSyTYQ8aIMZHhLFEC2Ddg/NB8MK0c2uGwQAVlCoGMv2ZiY0Ww6vMGmtt
 A+Nc5BgOzxEANiOAx/2djOqbXXFtpYrbl9szbPDjSjTbl5pASior8VkouQ+iRScgBrYU
 2rISBc8zsOjU1VALL/52xl08jrmigt2mrCycZk8zaKQLDXFtUe7baDgo0hlPJWaf1k87
 fLG2L88QvOjsypUT0jqJ+0nOmA/3zaIS/Ki3zjufQM9UbopglTCwsu3NVQhB5JVVpOuP
 w97Dvpo0oyi7yy7QAbB7LFG4jrKMbz7tmAR3icRY6SES3wvsWJVMs1QaLPJIXEGkJkOC
 VOLQ==
X-Gm-Message-State: AOJu0YyP60axuxJnlN8o9gvuXG3heLPHe5jjo36Z6seYM5TFF2Q1EBeA
 +D/kojPsHeF2jJoPo4LAMViwwGm8431C03POj5qUugdkXIq8B2S8LoiwvuFqlQ==
X-Gm-Gg: ASbGncuE3oIcKLy7LzVTacXw/zkxXSKGYDCfBlt5KR9H5LEQMtffQ14BglQLGzG7j7y
 jr/tlp8XlbuY3VS1PJUpT0YV3rnd+hX3rlg/x8Eg8LMam6yijc7Dok3L5hve3BJuZE8REY+9i3m
 7AGF7YGoBE6yhVg7fAuX41iBvuTLVyB8tFQi7ZgPKiHZ87OHWvyY0IM3ph6j0tpsdC1T1llUxr+
 PxZsgpl06yseXq6uUR6nsbRGNlFS40zmMss/Y/oGOrD7TyWIvVd9LrvAaSLwUMo0Dl6qINQddHw
 uOlHROZdqqX/P6GlETaOlB5oWWGTgmwrPKtG4FVf9X0uqgDdhFucOZI7q31NFJw5UWqPvurfmCb
 RiqxRB3Z0AbqfcZIc
X-Google-Smtp-Source: AGHT+IHkXR3vXeHEt5sQJwv4vDxPe9DfFOSaxRmrOyPaXhNPtZ+62mZBTk1iscYhh6NbcQH7kDmu5Q==
X-Received: by 2002:ac8:5914:0:b0:477:e2d:2ec7 with SMTP id
 d75a77b69052e-4a99685767bmr63583831cf.33.1751668364280; 
 Fri, 04 Jul 2025 15:32:44 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:7cf4:c69f:10f5:f5b9])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a3093asm21528851cf.36.2025.07.04.15.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 15:32:43 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Peter Maydell <petermaydell@linaro.org>
Subject: [PATCH v4 05/11] MAX78000: Add UART to SOC
Date: Fri,  4 Jul 2025 18:32:33 -0400
Message-Id: <20250704223239.248781-6-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704223239.248781-1-jcksn@duck.com>
References: <20250704223239.248781-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x82d.google.com
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

This commit adds UART to max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <petermaydell@linaro.org>
---
 hw/arm/max78000_soc.c         | 28 ++++++++++++++++++++++++----
 include/hw/arm/max78000_soc.h |  3 +++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 0c83b08eca..2f93ab882d 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -18,6 +18,10 @@
 #include "hw/misc/unimp.h"
 
 static const uint32_t max78000_icc_addr[] = {0x4002a000, 0x4002a800};
+static const uint32_t max78000_uart_addr[] = {0x40042000, 0x40043000,
+                                              0x40044000};
+
+static const int max78000_uart_irq[] = {14, 15, 34};
 
 static void max78000_soc_initfn(Object *obj)
 {
@@ -31,6 +35,12 @@ static void max78000_soc_initfn(Object *obj)
         object_initialize_child(obj, name, &s->icc[i], TYPE_MAX78000_ICC);
     }
 
+    for (i = 0; i < MAX78000_NUM_UART; i++) {
+        g_autofree char *name = g_strdup_printf("uart%d", i);
+        object_initialize_child(obj, name, &s->uart[i],
+                                TYPE_MAX78000_UART);
+    }
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -39,6 +49,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *dev, *armv7m;
+    SysBusDevice *busdev;
     Error *err = NULL;
     int i;
 
@@ -89,6 +100,19 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
     }
 
+    for (i = 0; i < MAX78000_NUM_UART; i++) {
+        dev = DEVICE(&(s->uart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
+            return;
+        }
+
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
+                                                       max78000_uart_irq[i]));
+    }
+
     create_unimplemented_device("globalControl",        0x40000000, 0x400);
     create_unimplemented_device("systemInterface",      0x40000400, 0x400);
     create_unimplemented_device("functionControl",      0x40000800, 0x400);
@@ -127,10 +151,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("oneWireMaster",        0x4003d000, 0x1000);
     create_unimplemented_device("semaphore",            0x4003e000, 0x1000);
 
-    create_unimplemented_device("uart0",                0x40042000, 0x1000);
-    create_unimplemented_device("uart1",                0x40043000, 0x1000);
-    create_unimplemented_device("uart2",                0x40044000, 0x1000);
-
     create_unimplemented_device("spi1",                 0x40046000, 0x2000);
     create_unimplemented_device("trng",                 0x4004d000, 0x1000);
     create_unimplemented_device("i2s",                  0x40060000, 0x1000);
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 27b506d6ee..57894f0035 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -12,6 +12,7 @@
 #include "hw/or-irq.h"
 #include "hw/arm/armv7m.h"
 #include "hw/misc/max78000_icc.h"
+#include "hw/char/max78000_uart.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_SOC "max78000-soc"
@@ -24,6 +25,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(MAX78000State, MAX78000_SOC)
 
 /* The MAX78k has 2 instruction caches; only icc0 matters, icc1 is for RISC */
 #define MAX78000_NUM_ICC 2
+#define MAX78000_NUM_UART 3
 
 struct MAX78000State {
     SysBusDevice parent_obj;
@@ -34,6 +36,7 @@ struct MAX78000State {
     MemoryRegion flash;
 
     Max78000IccState icc[MAX78000_NUM_ICC];
+    Max78000UartState uart[MAX78000_NUM_UART];
 
     Clock *sysclk;
 };
-- 
2.34.1


