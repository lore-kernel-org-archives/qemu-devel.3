Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C55E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQj9A-0007Gv-80; Thu, 26 Dec 2024 03:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ZxJtZwgKCoI20nguzynmuumrk.iuswks0-jk1krtutmt0.uxm@flex--wuhaotsh.bounces.google.com>)
 id 1tQj98-0007GT-Sp
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:06 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ZxJtZwgKCoI20nguzynmuumrk.iuswks0-jk1krtutmt0.uxm@flex--wuhaotsh.bounces.google.com>)
 id 1tQj97-0000Wn-0m
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:06 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2eeeb5b7022so7695700a91.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201383; x=1735806183; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=mII2KQCbUJ3mJ7sYUww2aSfqMfq2RPMoT2IXlGafl+I=;
 b=1unBu+Ito0b32CwZv2wj9dmM60ifG9u03l9HuXyBbc/4sZwGh9wHGZLTJO9cwIqBQA
 q128kz8F0DfG9hPnWFE321xAgh3GCrbEbxhFKydzp7PhF4c+164zVmnm5dqlx/WkYTzP
 n6bGx5kZg3ChtWr832NI132iatsFTKVHOy76U87TCZNtOvgvHso5QOLrtcBrIPYBChHs
 H/XP3SRJXlQHNvQ8V7IALRo0JTH6WQGvesCtYWlPLUuTbLIxG4jcQJ6SNWHOTLfM7AQe
 M4v+LCb0Okm3INcQRM5zRsMWueA6KgSNODTCZPxtqzeYhonD27WOXwT4xIRdIUpbeHNd
 zu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201383; x=1735806183;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mII2KQCbUJ3mJ7sYUww2aSfqMfq2RPMoT2IXlGafl+I=;
 b=mxB/487E6ssHfkdLWCEqJAIzS0vdA/fXCKLwSz1t80gad/cLkQcBkMyYUaUlmNDckE
 364ZQ66sWopab8rA5Sni7owHZ9OB2OnK8jJuhiwec0V/5xUO0iaudIimgD/CeNDLyLX9
 AYQrSygw6BEVyzyq9rkX1o5zKdHWb/oXJsY06I8sGYlpM6Gnt9mxt9hmuq+gHpbYqIwn
 l3vPK2TkTOcByb2Ee3aazRAzy9fyByeMxxAzIC+tm/8qxcR+NkkOtDVFrk40Sy8dYGGn
 ULmfARXNa0OhQzZexk420OgSkPYdtLvzDvW1XJqJCBrc1O0pIYPoSAkgcqEKNo3tHWps
 M+1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoHSUhLSXYR1hyU0l1/v7qIXbDgN3yu2oxCEH3SFfCIxw1Aso2JE43TzE+zPp1xxxotNmjdutHZpUx@nongnu.org
X-Gm-Message-State: AOJu0Ywiu4KCGiwQon4gLu94SH0xPJRYX6gQ/dGmtnczUF2O8H0m3GNS
 T9EPyqnXDoAOPjKqpqmBm8CL1/KqsyKvlN5ZUs3nvJV0fxaRmcLaEYPb9gKnf8QXgvNK+tSr6wA
 dpW3DUh5bLw==
X-Google-Smtp-Source: AGHT+IE/XilUT7y7z+GOMoyVu0jgmMZx0KsGJrUC1yBQzeffUEtGblHe5bxaUaU3/C6gVySn+TP2rRi+ve4KhA==
X-Received: from pjbsl16.prod.google.com ([2002:a17:90b:2e10:b0:2ef:82a8:7171])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:dfcd:b0:2ee:964e:67ce with SMTP id
 98e67ed59e1d1-2f452dee953mr30345248a91.3.1735201383355; 
 Thu, 26 Dec 2024 00:23:03 -0800 (PST)
Date: Thu, 26 Dec 2024 08:22:23 +0000
In-Reply-To: <20241226082236.2884287-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082236.2884287-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082236.2884287-5-wuhaotsh@google.com>
Subject: [PATCH 04/17] hw/ssi: Make flash size a property in NPCM7XX FIU
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3ZxJtZwgKCoI20nguzynmuumrk.iuswks0-jk1krtutmt0.uxm@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This allows different FIUs to have different flash sizes, useful
in NPCM8XX which has multiple different sized FIU modules.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/arm/npcm7xx.c             |  6 ++++++
 hw/ssi/npcm7xx_fiu.c         | 11 +++++++----
 include/hw/ssi/npcm7xx_fiu.h |  1 +
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 386b2c35e9..2d6e08b72b 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -292,17 +292,21 @@ static const struct {
     hwaddr regs_addr;
     int cs_count;
     const hwaddr *flash_addr;
+    size_t flash_size;
 } npcm7xx_fiu[] = {
     {
         .name = "fiu0",
         .regs_addr = 0xfb000000,
         .cs_count = ARRAY_SIZE(npcm7xx_fiu0_flash_addr),
         .flash_addr = npcm7xx_fiu0_flash_addr,
+        .flash_size = 128 * MiB,
+
     }, {
         .name = "fiu3",
         .regs_addr = 0xc0000000,
         .cs_count = ARRAY_SIZE(npcm7xx_fiu3_flash_addr),
         .flash_addr = npcm7xx_fiu3_flash_addr,
+        .flash_size = 128 * MiB,
     },
 };
 
@@ -735,6 +739,8 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
 
         object_property_set_int(OBJECT(sbd), "cs-count",
                                 npcm7xx_fiu[i].cs_count, &error_abort);
+        object_property_set_int(OBJECT(sbd), "flash-size",
+                                npcm7xx_fiu[i].flash_size, &error_abort);
         sysbus_realize(sbd, &error_abort);
 
         sysbus_mmio_map(sbd, 0, npcm7xx_fiu[i].regs_addr);
diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 21fc489038..ccdce67fa9 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -28,9 +28,6 @@
 
 #include "trace.h"
 
-/* Up to 128 MiB of flash may be accessed directly as memory. */
-#define NPCM7XX_FIU_FLASH_WINDOW_SIZE (128 * MiB)
-
 /* Each module has 4 KiB of register space. Only a fraction of it is used. */
 #define NPCM7XX_FIU_CTRL_REGS_SIZE (4 * KiB)
 
@@ -507,6 +504,11 @@ static void npcm7xx_fiu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->flash_size == 0) {
+        error_setg(errp, "%s: flash size must be set", dev->canonical_path);
+        return;
+    }
+
     s->spi = ssi_create_bus(dev, "spi");
     s->cs_lines = g_new0(qemu_irq, s->cs_count);
     qdev_init_gpio_out_named(DEVICE(s), s->cs_lines, "cs", s->cs_count);
@@ -525,7 +527,7 @@ static void npcm7xx_fiu_realize(DeviceState *dev, Error **errp)
         flash->fiu = s;
         memory_region_init_io(&flash->direct_access, OBJECT(s),
                               &npcm7xx_fiu_flash_ops, &s->flash[i], "flash",
-                              NPCM7XX_FIU_FLASH_WINDOW_SIZE);
+                              s->flash_size);
         sysbus_init_mmio(sbd, &flash->direct_access);
     }
 }
@@ -543,6 +545,7 @@ static const VMStateDescription vmstate_npcm7xx_fiu = {
 
 static const Property npcm7xx_fiu_properties[] = {
     DEFINE_PROP_INT32("cs-count", NPCM7xxFIUState, cs_count, 0),
+    DEFINE_PROP_SIZE("flash-size", NPCM7xxFIUState, flash_size, 0),
 };
 
 static void npcm7xx_fiu_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/ssi/npcm7xx_fiu.h b/include/hw/ssi/npcm7xx_fiu.h
index a3a1704289..1785ea16f4 100644
--- a/include/hw/ssi/npcm7xx_fiu.h
+++ b/include/hw/ssi/npcm7xx_fiu.h
@@ -60,6 +60,7 @@ struct NPCM7xxFIUState {
     int32_t cs_count;
     int32_t active_cs;
     qemu_irq *cs_lines;
+    size_t flash_size;
     NPCM7xxFIUFlash *flash;
 
     SSIBus *spi;
-- 
2.47.1.613.gc27f4b7a9f-goog


