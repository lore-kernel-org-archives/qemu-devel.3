Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0147C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkp5l-00030A-2r; Wed, 19 Feb 2025 13:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3BCe2ZwgKCm8jhUNbgfUTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5d-0002wb-Ty
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:35 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3BCe2ZwgKCm8jhUNbgfUTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5c-0004hP-1T
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:33 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2fc1cb0c2cbso341590a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 10:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739990789; x=1740595589; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=z8xVoS50d7e+ciafSSflJFcc3kwT94nPrc7QEj/k7Ig=;
 b=qj27K2MouanphIYUuHBeYNF2VZf/wpKDKEE/DsgsKXzelhnmG+LiG6bldEi5Q/2Ybd
 NLlQhR0yg/uVh1dqrdKp7GObV9hYsZbcIFfrHHlAw86RhXEbpgTkVmLZfE4dYQfUC7Hd
 LIVExTpwwGjh5L2z0N0dU+QoXXBz599h5rpixaEki8DpqgRRcT6PlaL7Fg1UK/azBnkS
 3L/puJSGSTqr+gJ8xYEKqV1h/3k/93LWDi5i1NUa6M/EuQ7sTXz+Nc2pe52APD/7yBG4
 iomgNdiXE6PvPwEDQf3uYce7NJowm9ZtvRPUcWN67szcLqaY/CzASQ+7C61FQmzuyL4t
 4uSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990789; x=1740595589;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z8xVoS50d7e+ciafSSflJFcc3kwT94nPrc7QEj/k7Ig=;
 b=OgC4O1zaSr886GE0OD1mfww1ys+EVD3ohdtAMNbaoT5E2Cm9i3jTchnfr3UuEF8xXn
 jgyioIPGCb6tDyB3vUNOzWwRDmO9u51FMnlo8lcBQOiEVtYb9/lcTp6VukfJwucTupH1
 XWpy9ckjCA6UH6Zmw9Usce3GgR6xpnkFVWeXLMiKwd+5AdrjUTFjje9mvZvUh9bAJW47
 m7Bzvd9LTqfcu8t4uwH1knPbsD3CU8GeQi+fqK2MJCqRNx+oq65cYLuptxkGJ1g9aN3W
 5EfEmvz2Pin5sGnh44mlbvbTI+s9FeJAfpGf8xNQ0yHYocwopd7ZnhFBOowwR4RvFzoJ
 3i9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlfx+UrnS46pR5P2n1IMCqcCSuzPLrHeJRzqceI6zo1pPzuz72NyYnS57wJR7Z/b+38vcLRcLziVr6@nongnu.org
X-Gm-Message-State: AOJu0YyIl18t4T89pp9W/ubrQk31AR2TyyrPZRYIu3JgnwjfJPm7U7zS
 7X6jGtkxCaBueqcXnHoZRESaZdPvKr5hNB78m4oZeyMWYAdPgO15tEv5C4oXUI+hLeWEzgg6voa
 kfGXRUeekNQ==
X-Google-Smtp-Source: AGHT+IEhnVD/C6y1czfHbEvLB1OrW26ZZEbL7drDRZUQMJJFXfCy+ANO+o44qHmtJkmzPoLd3xM0FlIh4YceYQ==
X-Received: from pjbsg13.prod.google.com ([2002:a17:90b:520d:b0:2fa:1b0c:4150])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c50:b0:2f5:88bb:12f with SMTP id
 98e67ed59e1d1-2fc40f22a40mr26221701a91.21.1739990788827; 
 Wed, 19 Feb 2025 10:46:28 -0800 (PST)
Date: Wed, 19 Feb 2025 10:45:54 -0800
In-Reply-To: <20250219184609.1839281-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250219184609.1839281-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219184609.1839281-4-wuhaotsh@google.com>
Subject: [PATCH v5 03/17] hw/ssi: Make flash size a property in NPCM7XX FIU
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3BCe2ZwgKCm8jhUNbgfUTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Philippe Mathieu-Daude <philmd@linaro.org>
---
 hw/arm/npcm7xx.c             |  6 ++++++
 hw/ssi/npcm7xx_fiu.c         | 16 ++++++++++++++--
 include/hw/ssi/npcm7xx_fiu.h |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

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
index 21fc489038..8df4bec3f1 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -29,7 +29,7 @@
 #include "trace.h"
 
 /* Up to 128 MiB of flash may be accessed directly as memory. */
-#define NPCM7XX_FIU_FLASH_WINDOW_SIZE (128 * MiB)
+#define NPCM7XX_FIU_MAX_FLASH_WINDOW_SIZE (128 * MiB)
 
 /* Each module has 4 KiB of register space. Only a fraction of it is used. */
 #define NPCM7XX_FIU_CTRL_REGS_SIZE (4 * KiB)
@@ -507,6 +507,17 @@ static void npcm7xx_fiu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->flash_size == 0) {
+        error_setg(errp, "%s: flash size must be set", dev->canonical_path);
+        return;
+    }
+
+    if (s->flash_size > NPCM7XX_FIU_MAX_FLASH_WINDOW_SIZE) {
+        error_setg(errp, "%s: flash size should not exceed 128 MiB",
+                   dev->canonical_path);
+        return;
+    }
+
     s->spi = ssi_create_bus(dev, "spi");
     s->cs_lines = g_new0(qemu_irq, s->cs_count);
     qdev_init_gpio_out_named(DEVICE(s), s->cs_lines, "cs", s->cs_count);
@@ -525,7 +536,7 @@ static void npcm7xx_fiu_realize(DeviceState *dev, Error **errp)
         flash->fiu = s;
         memory_region_init_io(&flash->direct_access, OBJECT(s),
                               &npcm7xx_fiu_flash_ops, &s->flash[i], "flash",
-                              NPCM7XX_FIU_FLASH_WINDOW_SIZE);
+                              s->flash_size);
         sysbus_init_mmio(sbd, &flash->direct_access);
     }
 }
@@ -543,6 +554,7 @@ static const VMStateDescription vmstate_npcm7xx_fiu = {
 
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
2.48.1.601.g30ceb7b040-goog


