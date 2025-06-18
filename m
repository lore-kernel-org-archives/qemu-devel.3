Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3ADC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 05:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS7im-0003Jy-VO; Thu, 19 Jun 2025 01:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1r6-0006sE-7F
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:06:08 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1r4-000664-6p
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:06:07 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3de252f75d7so2072535ab.3
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750287965; x=1750892765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCEw08LPA2qfRA5wAQpdHwuFYJV3Mv0L7c31+Gr3bog=;
 b=SvaGAK9R7P/J5DFT6llyORULsEco1a52+2ToV6FIKvxklw7HJpk1aspvr0G/Qure/t
 3Ti+2SC+hpY9CGDmeeD2RNheugWL4evafSy7URZdkepsD86vYBFxOHtRhAuxf0rDoLmb
 lj0dTzRb/24JSJR6GyznGk0Uq7y2JY8prdw4JqwmV4OkzMp6BSUNWCrARxBIIR25T2mj
 EDvNuchgoFKObCRhQeRqk43p/D+hn4A/+SHUR+36vAuaaQspbXC4xgwdTwcFZIbWwASG
 IwR4U9B34xFblm+cK5wqfbzRmKxxebtk6yYQdw2rgQso9p6bwey1n919jAvQVgNfQfR4
 /5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750287965; x=1750892765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JCEw08LPA2qfRA5wAQpdHwuFYJV3Mv0L7c31+Gr3bog=;
 b=MDxAXoWGEWXPYRhX++HSrszhevxUaHHsPQTQaipXWrFgWb7ton36/KhGk07595dCUD
 EBTp0v9DNZhZLLAb/eMGwCoFEp7Hc9l5j4Lm3QkwteIcIxyPR9QKH64DLOHiLDURzFsC
 bdw2vNnV8E5JJ9k/52LDaj10zWhQMJBVjEGBOHCUEt808cf+BjIF9g+fbohecIhF6vWI
 QB40ES6GMqSVfvTOD8T6g1bpF9kkR9hL7vyEge4fw1BrTYOMsWTtJZG5ObF2vtj6bIbr
 OXgN1SYU5Kw6ZWktnaDnEow6DVx/EevClIkzQxjUF009fE8W5gd6IfsbP7FqbgkPcaNd
 5xXw==
X-Gm-Message-State: AOJu0YzG3H7uLEWlJ7b29oFvrwH2MRCX7i6QlvQM1H6EQ4IaSI/eM/Ux
 lYXzg5IUfcYkgfwv9a1lTSFsWQXJb67/Hise1iew9khjSsRondF50u0Serw22UquY8M=
X-Gm-Gg: ASbGncvgJpmGK38D0bu/1GNLVZ46QJPIUoxvIszYI8U/7uVfgXIFTURoWvjH/Jb9ex7
 mTQye32TgAQXgIvJY7ZKsTuifoWuNTFXyNuYZ0mzn2Ae/37n+te5lbA22WKJC1/3EsMIYMbaXon
 sfNOhF15/IflPUfEf5Wygu1JhdNvHu3Be2EmQcol4qNzcFrIlj+LCb5W//dYvpVbL1W5nxxanXH
 BCCZi0/exA+VOb0NcTU5IAfjKxDaoEqGQFIhIf0bLlf+/H0kI3TGpKLKfkdBiQKbmNTQ2DMOTTA
 pyqlOm/Y4qYS3GTLQH7hgWG/dSg1TLGuqAiV3O2WAjjxLr5uyKwcrWbWtuLKqCgCYdoKb/Feagp
 MTIy6v7mW2UXRKJo=
X-Google-Smtp-Source: AGHT+IFW5oT5B9ZOUAp5xnzzzPy/OeVXpZTlxatbHxlYQpBZr3mHomPisNLDXqykwR6NN6FqjtNmLg==
X-Received: by 2002:a05:6e02:1541:b0:3dd:d6c2:51fb with SMTP id
 e9e14a558f8ab-3de07cc0d4fmr209163445ab.10.1750287964757; 
 Wed, 18 Jun 2025 16:06:04 -0700 (PDT)
Received: from user-jcksn.hsd1.mi.comcast.net
 ([2601:401:101:1070:b57:773f:14d7:807b])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50149b9df11sm3036915173.54.2025.06.18.16.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 16:06:04 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 07/11] MAX78000: Add GCR to SOC
Date: Wed, 18 Jun 2025 19:05:45 -0400
Message-Id: <20250618230549.3351152-8-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618230549.3351152-1-jcksn@duck.com>
References: <20250618230549.3351152-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=jackson88044@gmail.com; helo=mail-il1-x135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Jun 2025 01:21:41 -0400
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

This commit adds the Global Control Register to
max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/arm/max78000_soc.c         | 21 +++++++++++++++++++--
 include/hw/arm/max78000_soc.h |  2 ++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 7217924191..1a36bba2fc 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -30,6 +30,8 @@ static void max78000_soc_initfn(Object *obj)
 
     object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
 
+    object_initialize_child(obj, "gcr", &s->gcr, TYPE_MAX78000_GCR);
+
     for (i = 0; i < MAX78000_NUM_ICC; i++) {
         object_initialize_child(obj, "icc[*]", &s->icc[i], TYPE_MAX78000_ICC);
     }
@@ -46,7 +48,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
-    DeviceState *dev, *armv7m;
+    DeviceState *dev, *gcrdev, *armv7m;
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
@@ -67,6 +69,11 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 
     memory_region_init_ram(&s->sram, NULL, "MAX78000.sram", SRAM_SIZE,
                            &err);
+
+    gcrdev = DEVICE(&s->gcr);
+    object_property_set_link(OBJECT(gcrdev), "sram", OBJECT(&s->sram),
+                                 &err);
+
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -92,12 +99,14 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+
     for (i = 0; i < MAX78000_NUM_ICC; i++) {
         dev = DEVICE(&(s->icc[i]));
         sysbus_realize(SYS_BUS_DEVICE(dev), errp);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
     }
 
+
     for (i = 0; i < MAX78000_NUM_UART; i++) {
         dev = DEVICE(&(s->uart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
@@ -106,13 +115,21 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
         }
         dev->id = g_strdup_printf("uart%d", i);
 
+        object_property_set_link(OBJECT(gcrdev), dev->id, OBJECT(dev),
+                                 &err);
+
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
                                                        max78000_uart_irq[i]));
     }
 
-    create_unimplemented_device("globalControl",        0x40000000, 0x400);
+    dev = DEVICE(&s->gcr);
+    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
+
+
+
     create_unimplemented_device("systemInterface",      0x40000400, 0x400);
     create_unimplemented_device("functionControl",      0x40000800, 0x400);
     create_unimplemented_device("watchdogTimer0",       0x40003000, 0x400);
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 57894f0035..919aca0855 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -11,6 +11,7 @@
 
 #include "hw/or-irq.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/max78000_gcr.h"
 #include "hw/misc/max78000_icc.h"
 #include "hw/char/max78000_uart.h"
 #include "qom/object.h"
@@ -35,6 +36,7 @@ struct MAX78000State {
     MemoryRegion sram;
     MemoryRegion flash;
 
+    Max78000GcrState gcr;
     Max78000IccState icc[MAX78000_NUM_ICC];
     Max78000UartState uart[MAX78000_NUM_UART];
 
-- 
2.34.1


