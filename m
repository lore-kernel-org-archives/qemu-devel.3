Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D5DC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 22:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXoxu-0001kD-BG; Fri, 04 Jul 2025 18:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxi-0001gI-Lk
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:58 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxc-00079Y-Qq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:51 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4a774209cf0so15771591cf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751668365; x=1752273165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49cgo57NmECVgjxbtN5bwRKsawdIzTQJeJdTf1yIFQ0=;
 b=Itk/TPh3J2CGjmIZuySvPOeJO+R8DhW+ZvOh4rcJadROa3az428BlXIrOx+3qvYm53
 r5vF92TzbpuaXdn8kBhME0mkjP483HuLE8qA2KsOxVTp1poj7ry37RjbcigNJL6VBWYR
 sKChk5+5Djqa+uoVne3ulYiOyPwCfZbxrlQGHXghS9w2wdkdcYjdkSsqSl6JAzSmh7bq
 qDhCpigjsE8oxGn83uP5NR0NOUMIBVfOlDlCSRYYp4LqM/bkqqiCdS83kCFC9+bMSzKj
 8hxD0oZmIWg4cC6PcrtRABkVGb7E9Czb6t6thU94MhGRQFTKSZTLnlQ0/MRvpRMGmF+i
 ns5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751668365; x=1752273165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49cgo57NmECVgjxbtN5bwRKsawdIzTQJeJdTf1yIFQ0=;
 b=TdAJKUtAiIa13tuz21c3Rc9HIqDcJBr83jUU0XHGmhDqXfN1vnf1OWlnSmi8QQAk9d
 oyoE2Zi7ZgO0ras73Hgj3mKrIP2ExEX0Xz5nHyO1tjP/6byzgDG1hA13obdofnYKSaRm
 JLs2BYXuifijIW3HP4Cu5u7vmSaU0zBhlj1VXrOAn21GooN85vawretEvI18GoVUN8zC
 24w0SMSD/TlYQEdpPfedvvWDd1KmtLyJvxohHoy5L7DmD24wHrvbdGocoqkn+qoZgc19
 HkomeNE3moU8jMHh/djUfP7OLx4wEoHpptjPCsfb8cgDxE33w2rWUnaosTsTC/avUxTA
 Dh0A==
X-Gm-Message-State: AOJu0YyDCjsiV3otVNAeCDYFsWWCyh0gPn17xmCsgzYzP471HgCCqF1u
 ZPJ+0BjTRMPEA3WXFNMrpuYaI2YJ8pvCtIA2WO9BkBkOJfoel9TDaMzrjtxKhQ==
X-Gm-Gg: ASbGncsuO+lIxAcFFLAgBxtJBhcV6/5m0lWmbYlGbi0NufiCHmn1OZnS9ZUyvZmEdxD
 etB4X0wuc4iwHnpzyO/yr3uoRl5sXEomC74NxpPhEhfhK/czfa/rGg7+K8fJyO2dp/toVPH0/bd
 0oToho36Af4dfhmAorqQuTSeqT0WzpaT09OSn7191gypnjx7MjBGoyFl2Z4Llq8CNJvFMxpXMcg
 8od67e7kqJBHPhbwGmsen8timeVb6LurCNR6v5ghCoD4I8kyH7vmq4CN5MBFFGGmUkHPVRR4c4A
 VaWD5lDlxBIRWGs5WK9RiDaVqpXAmndnNrYzcKOBjmyHVIudg5mPCjbFlE2MQiWweU3XyzzqtNv
 9hXpFTw==
X-Google-Smtp-Source: AGHT+IEYDwiVMyEvAY/Xwsnmtax5zFXKdSwo4esMKrG8MQldbBxRSRyMUcbC7cY4iu3CrJgXczOhsA==
X-Received: by 2002:a05:622a:4c1a:b0:476:6b20:2cf3 with SMTP id
 d75a77b69052e-4a9987b0580mr57311061cf.33.1751668365563; 
 Fri, 04 Jul 2025 15:32:45 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:7cf4:c69f:10f5:f5b9])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a3093asm21528851cf.36.2025.07.04.15.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 15:32:45 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v4 07/11] MAX78000: Add GCR to SOC
Date: Fri,  4 Jul 2025 18:32:35 -0400
Message-Id: <20250704223239.248781-8-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704223239.248781-1-jcksn@duck.com>
References: <20250704223239.248781-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x835.google.com
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

This commit adds the Global Control Register to
max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/max78000_soc.c         | 18 ++++++++++++++++--
 include/hw/arm/max78000_soc.h |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 2f93ab882d..45c6088312 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -30,6 +30,8 @@ static void max78000_soc_initfn(Object *obj)
 
     object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
 
+    object_initialize_child(obj, "gcr", &s->gcr, TYPE_MAX78000_GCR);
+
     for (i = 0; i < MAX78000_NUM_ICC; i++) {
         g_autofree char *name = g_strdup_printf("icc%d", i);
         object_initialize_child(obj, name, &s->icc[i], TYPE_MAX78000_ICC);
@@ -48,7 +50,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
-    DeviceState *dev, *armv7m;
+    DeviceState *dev, *gcrdev, *armv7m;
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
@@ -69,6 +71,11 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 
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
@@ -101,19 +108,26 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     for (i = 0; i < MAX78000_NUM_UART; i++) {
+        g_autofree char *link = g_strdup_printf("uart%d", i);
         dev = DEVICE(&(s->uart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
 
+        object_property_set_link(OBJECT(gcrdev), link, OBJECT(dev),
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


