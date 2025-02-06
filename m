Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A01CC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 01:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfqkW-0005Nx-WE; Wed, 05 Feb 2025 20:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <35BCkZwgKCtkRPC5JONCBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--wuhaotsh.bounces.google.com>)
 id 1tfqjw-0005Ct-Af
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:40 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <35BCkZwgKCtkRPC5JONCBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--wuhaotsh.bounces.google.com>)
 id 1tfqjk-0006tG-4t
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:29 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-21f075a828bso7242865ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 17:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738805476; x=1739410276; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=bdp9jkK1dsukYpE9ksX5x/NIWESjBYrWaYraAo5agjc=;
 b=GQyrJdzPJdR2mxGW4PvevnJHsx/Y73aEWgAkyrmGnqr+ExNPP27JY/G7aru1tqd7T+
 fCiGv4Xrv3VXQVkg0//cBB/IpMo6TaJ1yHerq/RQzXw2xfvWgNOk2z1Aaw2ExVUwQ9jT
 2yNdrav0Khow6ty9BQZNcU5A0jEJ0Llv0pUva6aaJMh0vzPdbC9hy9ogpFaXEZXeQnLI
 kWFkFeRcwAjr2Mt98c6dxZRZAQA7XrNANRwihvvMzjcKdKBNBO7Q0lfurXbfKdWgTTcK
 xTzPP/HPuP7I0l1UtqSNRk1D7jzoTQ8xthLf7kC0Qp2zyQWiBThmrUtfAQdEpdsCgAc0
 i+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738805476; x=1739410276;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bdp9jkK1dsukYpE9ksX5x/NIWESjBYrWaYraAo5agjc=;
 b=RrjoIOox/q9W/e89n3yCTqcEJ/zCx6R+wg0o/uh96KpL9/r4q15lw05Y2vBFuHi/5b
 OqWS3Xvs2blrLmsZH4OvOKT8fBqV7YChzVodwM9w5HZo728mKXruuXrBbXZ+3pAsDKJ9
 mKOs59HEVOfw1s7fGRf/ltpjcMttaUFxFppQ32v+Imt1l89/WAKaJ0mxem8k0sdN/uwn
 hLRw4oMyt/U+PIK1IN5RmT6131O2vONijaP2ZP3WFP14CWmhJyYqYHWZx65fr9wbhY0k
 LchDr0D9oMS0rDCMOk8rNTlTdINFODxg9MGpA9d4cyvGZtsg2i6BfJ659gKwXGCBV3D6
 LXKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViz3EW4Z2w5muMLOrDi+V3x5ZCCZfqG3n8QDo/8kS0GweziH00jAkEbzUP6bFCoCgxJVPHB9MWu/et@nongnu.org
X-Gm-Message-State: AOJu0YwE6pt/D6Qf5e9cqwYrIUBKLlokBEZf7CoV7omXTuGuSIZk007G
 1EyHBttV49Nse0O/O20/oyJ6xzw4rKz3gsN0QDS0foHeqYiPVxWs4Df9IAR9FDw1UVorXdYQGLp
 F/336LHKdhg==
X-Google-Smtp-Source: AGHT+IHL3VaBgKKlng8wAvdxBo51J7WR9PXfHzYt13lYTJ/QvrBn4qqR+Txgqlri8pqxSG3ljpv8H8Hn/uqU0Q==
X-Received: from plce20.prod.google.com ([2002:a17:902:f1d4:b0:216:21cb:2dfe])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf12:b0:216:48f4:4f1a with SMTP id
 d9443c01a7336-21f17e4ca85mr88457245ad.16.1738805476161; 
 Wed, 05 Feb 2025 17:31:16 -0800 (PST)
Date: Wed,  5 Feb 2025 17:30:51 -0800
In-Reply-To: <20250206013105.3228344-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206013105.3228344-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250206013105.3228344-4-wuhaotsh@google.com>
Subject: [PATCH v3 03/17] hw/ssi: Make flash size a property in NPCM7XX FIU
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=35BCkZwgKCtkRPC5JONCBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
2.48.1.362.g079036d154-goog


