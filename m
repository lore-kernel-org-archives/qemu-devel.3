Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20637C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgA6n-0005hX-Lf; Thu, 06 Feb 2025 17:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vDOlZwgKCvszxkdrwvkjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6a-0005ab-8Y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:16 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vDOlZwgKCvszxkdrwvkjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6Y-0001Pj-Cy
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:15 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-21f37eaef03so17805305ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738879932; x=1739484732; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=2548+wS4SpVlfIQMzodXs7r5TmvHPEN3hvBGgeEdGms=;
 b=nJzgoWzcyplLjfw2mxcOWJB0S7B0gBl7Ezq2gSvKNYJlsFLaB8hqT/yaC+tp+rJd04
 yTojR/VJts/q0VkFcR4ABmzG9yyUQZvsNh/BxvuQryh+0BkTm5W/CtBdOIzgprtu/sVu
 4P6yJCyyebywmaozeLUx31kRv9UhEesMu/5hxDxIEKdnCQR/DRZaDEMO1V79wcrQfJAq
 KL/kgAJzbVWyaORGWaaHElImZWBuZH1H8ox5K9JaLqOH52B0icKML4h7uLkyt4fnb4CB
 137Zg4TRT4f1Focwlf+5nq010mfMupB5NUCeb+3Z7XfLX8KmdafexEczrNSp1PmERBwC
 Nx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879932; x=1739484732;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2548+wS4SpVlfIQMzodXs7r5TmvHPEN3hvBGgeEdGms=;
 b=uNJ8pCdzXwX9dwXHTEf62aNogRTMt2+7uPlxAiw/23+e14dePcJvTA6j4k3d4i5H0W
 wvcVW2MRyY0W4otbhZEFLxEWf7510raRpZyDOq0jCFse5WygZyfcLoe9OAMJXa0ukR35
 NE/fE212x2p60n2YtR7MAI15dil00M5onfjS3Z+zk7V1ObDCDY15MKVxqmH9zb45V/6+
 C+upFAHEHCo5vpTXXE3lm25ba3Hgna23oeCM4xS9Qso6kQznOyq0yDQjd9+p10gqSbF7
 hocs2wyyDWwwC8bfZWsobYn1rTRwShNCys9ZumD2kqbamQiXaHPGvCiG35hKI1PKzsZx
 5+MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvtNx1/NWGjgrnJVir4xS3xZ2Zj3ohW0Anh7Jpcre4YwFt8S0W7khFVwV3ZpQ90Tr04pbwM+feVXz5@nongnu.org
X-Gm-Message-State: AOJu0YzRcQg8IpSbry37mrgSSt4kfa6pKkmOUEjW5pFXTOdjwGBC3UOk
 htKms8oS7e7hGkTN5i879DrgBt+j5qQd7L/9AxjdW2SooXKSjZi0T+mlbUx3bz9Byb7kR7yGHZE
 c7TInuoziTA==
X-Google-Smtp-Source: AGHT+IG2MhjukvGlwSTbKZh8yQxGQsgfezRxZbn66p+NhuUcTxqtJ3M5g35ThHhGqPXGgKYCF7sQb2tNunCg3w==
X-Received: from pgbcx10.prod.google.com
 ([2002:a05:6a02:220a:b0:86c:1a7f:d25c])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9f4a:b0:1e8:bd15:6819 with SMTP id
 adf61e73a8af0-1ee03a5f141mr1877001637.22.1738879932414; 
 Thu, 06 Feb 2025 14:12:12 -0800 (PST)
Date: Thu,  6 Feb 2025 14:11:49 -0800
In-Reply-To: <20250206221203.4187217-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206221203.4187217-4-wuhaotsh@google.com>
Subject: [PATCH v4 03/17] hw/ssi: Make flash size a property in NPCM7XX FIU
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3vDOlZwgKCvszxkdrwvkjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
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
2.48.1.502.g6dc24dfdaf-goog


