Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDA1C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDto-0004Of-54; Fri, 11 Jul 2025 09:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtg-0004N3-F5
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:41 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDte-0002xm-Hm
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so1361126f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240877; x=1752845677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rpu6tGMLacwKLQnq2DPWdLYq4LlbwJy217T8KX+yI1s=;
 b=Rq4jrFklx7mVxnamH4bmXEz1g8UCHqEYJC2pyC3oSfDNQ57O/GEmv+4ySDeG4jUQ/S
 HrqmQiOrVehIi+sEHZfkLjRjJjUGtB5nK0YsFg7yqBnMRkSIcbmrPYK3clyAWT6yUvXJ
 Eu0wFrL/QPI9KcMx9xE3Hq2zHD2mPsRgcWjX3ZkDJaWyy1whSjk3ZOacITshsblyBjjU
 nWG3YglhezKxSumFGZwJMvMdQFxct/+iJ7CHCG9b5bTGzqerJzDDHZSN2SKBHsRlV5lE
 XEh828MzBVsfZ4pFHo2kfjUz2IuqmjRB1jcwGqBzWl4dCiWo6jBiCfgspqqielx7/iBz
 5u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240877; x=1752845677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rpu6tGMLacwKLQnq2DPWdLYq4LlbwJy217T8KX+yI1s=;
 b=e5M3lMWKkXShsgg030InC94JtpyABQI5uJmVyqB83zRBN8QpEm5j3qttjdLv2ZfvvC
 fWj2ORTLhahA355qWjuWYDUxJYCoHLI8qT3teyNBw44nOQCSyRk+S9HGCYvWOw4baF/n
 j2FDBiRO5UOyLaY7Z3e2+rt6jqqflqbESM7SiplJFq8mDU+UL/79zqlUFQBgIRsILXWF
 bft3Tf0zTPKAnAsW1lfOczCkCNPSJsgItDtKGmohz3yS6+KpRdvurYilXxpjthSQwFQ4
 0QwX9ATpBE3Lts2qtEpaxsxzlgShbVYxvXVWYxY3QbsUEdUoLx7gsH5cbdv02w0KSYid
 OnAA==
X-Gm-Message-State: AOJu0Yy3+Z1/0noTBfAsp3V/aE7LLZ9Pu99TVRSEpY1sZ8S1/0IN4QnJ
 rCPVjQ1H6Q/zNDpyzd7Ynf55KjMDfYaijIcplG938HRCtq8IbvTJT5VK7RsTQje02rCbMRwFV9R
 Kqj4T
X-Gm-Gg: ASbGncs25g1RX6dI0f6QHZydcmywL26ACrSRGoviIEwuSPw7mYk0KQ9jDrVX5GenNNF
 s/KKFo3oDwBv9YgVBcBO8917kGdyjkLyy+oLso3avcdi6UeqJGV3TUMML/zbEHXX7H2zUSEhnhh
 pvYpyyZ1BeQcblVDoZISEo0rdajJxL5RZdy/LzuN0E5NA59Bjn3ZscMEX9F0o0hUCIuPHdR0PZo
 Pj/8xSBpDx6rZJHOz8e3TT3nVqeuTLddDxzklkayQFnAF9/nRAD6n1hMfgc+SLMX2LIEjmdtE5w
 x7a5rtohhcW2aqnZ6pXQ84YcenCejjHtf35E6QVmSI16ZODHKu/UyQvOlTfO18u9genyCiRCFP3
 Og1m2G/jncJugghTgvKjyH0pOTJss
X-Google-Smtp-Source: AGHT+IGYnFDECpBpJFxq7J5dltHJi/iphKjN6GrGF0v0p0DbduoiL1f8MMpk88qDMhPMPdVZIZlkzg==
X-Received: by 2002:adf:a347:0:b0:3a4:ec32:e4da with SMTP id
 ffacd0b85a97d-3b5f18806eemr2433669f8f.15.1752240876823; 
 Fri, 11 Jul 2025 06:34:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/36] MAX78000: Add UART to SOC
Date: Fri, 11 Jul 2025 14:33:58 +0100
Message-ID: <20250711133429.1423030-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Jackson Donaldson <jackson88044@gmail.com>

This commit adds UART to max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <petermaydell@linaro.org>
Message-id: 20250704223239.248781-6-jcksn@duck.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/max78000_soc.h |  3 +++
 hw/arm/max78000_soc.c         | 28 ++++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 27b506d6eeb..57894f00359 100644
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
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 0c83b08eca0..2f93ab882d4 100644
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
-- 
2.43.0


