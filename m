Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00F3C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 00:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubT6R-00027q-ED; Mon, 14 Jul 2025 20:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6P-0001zb-An
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:57 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6N-00086p-NE
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:57 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6facacf521eso41914786d6.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752537654; x=1753142454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2NjSCv/D8nQj3W7MaWmKI3+JaIJyj9xNLbEBg6C4/k=;
 b=gt6t6Z2t7JO/8mHP1aSbMnGQB6z+VH7+sYXz1sgZGdtA8vri3joKGwpV/0wrGJedqS
 Uohg5n1SmovfkoXqAYTvCuQLmIw92NZT93AzJmn0XX6VYeCMZ8yHyq8+I5qo1z1myvKR
 JKo2+OIYonu1moEnr3zzPJ+yVHoSbZ9l5c5KlwWjQVaBZqcGSO57dfxwAc5vJOPJprLP
 +pdfdqIT1COqpMWJzP+pgTtID4wIPZ1rpvkD2oCDJnef3UpzhLwKs+XLGoVViVBspFV9
 2wFvupFL4e0L0N2tZqth8PsxtoDCPQ2MbWvn5J43u4eHxyXMMqIeegnJJVa1ynusEGP8
 y7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752537654; x=1753142454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2NjSCv/D8nQj3W7MaWmKI3+JaIJyj9xNLbEBg6C4/k=;
 b=GcSeWfAEFN6b8I0UpynoUri7etn7Igj9XkPiPE3uGicpzNGCtUOPiBYSTrXbbUl/+F
 K7soVvkF74ILbOUia0omRmCHDm7itf/maoBh6p2+qkmfLBn3lFGIZBuIk4KWuYGkEvGA
 +s4lkm3xFqJihCM9wzOR2+Al9mhS3yM+ArBB4NzmP+OywGQsyljm3wP4oYR9vI9a9dDO
 cTjVm73QRkjE4YVXMzvXdOvySXgOjIcggGiZQJgy8FSyeDnbAiDNb2+Gb+69eGW8HrLU
 DhDojaVM2OwQnORHlDO4ZA82JYZjIPyuq3VKJh7T9IxYoQL1qiHZt14qzaKHnKovX3Bz
 ZzkQ==
X-Gm-Message-State: AOJu0YwCWH5XjuHXjd3Qq4xqcjFvInE+8ReF61ye1HXgrLRCqPQMLZLg
 /RsAO20e0Fv18TaFDrwoGYbZ8BKzvYCLS2Z1KDtBnppT6DNeSYamYf9d97Hs4w==
X-Gm-Gg: ASbGncveAj8x/vpZFCb+tMmMDjvvMt5aG0DK0WdnVeMtf9cJTNYGvYe0taaUoM+Z5P0
 xrXp0URAWFkKmtT02mXxbu2qyp3IX0Vktiby9D99xCuqMTRu0/jTBHBBjsIGjYC5BVfVmIP0mi9
 zFt1w2/es8s51qGeUSvC/5JuhPf4D8PiYyX+4PIZ6NZg3CAcjMQ+2ygVOrRDlZ1f4GE0Hl6ElhU
 LLAu0R2V+Qm4Va4saKdTAIyxRDyCIx4bvxZgwK5dvzCT/NHpSSGq70MMw3YWbuKgMsESjYBNS50
 WPWnQOirUslYPGRZumUW6kHrPwXWBHfWD57egRYNIUUCPmOnId8wxDKHMJtXDVaxOxJLlXD2nST
 HnD3Y4Kz4gH4trpWBT1oLpxK3hNOcO/9DgTP9zzkywp0ZmPs=
X-Google-Smtp-Source: AGHT+IExNj9tpYd2LvMt7nK2YHsP5UWHOnlk/1EzSJFovJkG4GcB3m/ssG8GYToUPnOsI3kMiAw+OA==
X-Received: by 2002:ad4:576c:0:b0:700:c46f:3bd with SMTP id
 6a1803df08f44-704a38c8131mr290116816d6.25.1752537654075; 
 Mon, 14 Jul 2025 17:00:54 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51a:4200:2f17:e99b:e0cd:fdf7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d8eee2sm52296276d6.97.2025.07.14.17.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 17:00:53 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v5 09/11] MAX78000: Add TRNG to SOC
Date: Mon, 14 Jul 2025 20:00:43 -0400
Message-Id: <20250715000045.57332-10-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715000045.57332-1-jcksn@duck.com>
References: <20250715000045.57332-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf29.google.com
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

This commit adds TRNG to max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/max78000_soc.c         | 10 +++++++++-
 include/hw/arm/max78000_soc.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 45c6088312..3f2069fb03 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -43,6 +43,8 @@ static void max78000_soc_initfn(Object *obj)
                                 TYPE_MAX78000_UART);
     }
 
+    object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -124,6 +126,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
                                                        max78000_uart_irq[i]));
     }
 
+    dev = DEVICE(&s->trng);
+    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x4004d000);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 4));
+
+    object_property_set_link(OBJECT(gcrdev), "trng", OBJECT(dev), &err);
+
     dev = DEVICE(&s->gcr);
     sysbus_realize(SYS_BUS_DEVICE(dev), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
@@ -166,7 +175,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("semaphore",            0x4003e000, 0x1000);
 
     create_unimplemented_device("spi1",                 0x40046000, 0x2000);
-    create_unimplemented_device("trng",                 0x4004d000, 0x1000);
     create_unimplemented_device("i2s",                  0x40060000, 0x1000);
     create_unimplemented_device("lowPowerControl",      0x40080000, 0x400);
     create_unimplemented_device("gpio2",                0x40080400, 0x200);
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 919aca0855..528598cfcb 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -14,6 +14,7 @@
 #include "hw/misc/max78000_gcr.h"
 #include "hw/misc/max78000_icc.h"
 #include "hw/char/max78000_uart.h"
+#include "hw/misc/max78000_trng.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_SOC "max78000-soc"
@@ -39,6 +40,7 @@ struct MAX78000State {
     Max78000GcrState gcr;
     Max78000IccState icc[MAX78000_NUM_ICC];
     Max78000UartState uart[MAX78000_NUM_UART];
+    Max78000TrngState trng;
 
     Clock *sysclk;
 };
-- 
2.34.1


