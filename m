Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E353E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E1F-0003qE-EW; Sat, 02 Nov 2024 09:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0w-0003CX-Ca; Sat, 02 Nov 2024 09:18:03 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0t-00021Z-Jq; Sat, 02 Nov 2024 09:18:02 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a0c40849cso466753266b.3; 
 Sat, 02 Nov 2024 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553476; x=1731158276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=80K8OEm+6o8+JzT+l+kkS4hvMpMoaCr4IlAQyLMMIO0=;
 b=BFfG5T/rUvOzrgrN75/IYmqpYe3ifhGfePovRTpqu8n2C79AiVupW1slomcMSHuG7u
 gG0GmqLm11T64pBzOhF9xMgt/LN77tEhDq8q+1gxs4Fn8NMlxzjICLSReemShzkXsPew
 hyqPPnYvWhYors8T7ZlvUNoye3AZzWmD3c6zWKj2OvU9aYHdHfJnOrn6l+8fj2+cGZ/9
 sCPNpgA1Fw1szgRsCgySkg39wiOwPxofLQetc+TMYyd/Gb68EEMxsxZoj9r3EGcN0Iia
 H7VyO3lyimT8H253NKLs4nF+bA+1PQ1CHA3IL/oJmgrACrW7xJByQviJJGcRUFKvhKLi
 Z93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553476; x=1731158276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=80K8OEm+6o8+JzT+l+kkS4hvMpMoaCr4IlAQyLMMIO0=;
 b=rIRheHFJMT3kdoYlAb8JdtzmFxPXuYGi+P4N6ho1BmYrjIeO63vW6wDARBqMxvoosT
 eizTUUrgVz9tpzakts0pL+Rqb6wBdlHarqso+E0KSrSI8SG8E0zH6I9vnst7PpqpEkWf
 vUiH6NuTCBk5ZRAiZmkhThnbkaFicS+DwJMmfmzpkmRwyUJN9WVR1XqjtGsKkXF3X3mz
 P4+C/02lzpF3kyncjIEiiVqgbACbY0ae+nOvTiLCAtPCVBPcoR8Hwjj0IquzLGGPifv0
 vJmBA/INVtoMPRM629gbrratmSODgeOqH3JBzGqrDaXxzYpw3VPvCelQOs4ruKDvgrI9
 gsHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkiVJ0MtjiPAMLpN7xnJDB5RK7T8x7yErWHUfXkrto6NNqIvDJdPIEXHeRe6c0Hb3R3h4cvToEcO/B@nongnu.org,
 AJvYcCWOf02X0VJiCyuBqNO6RL0BnKbsndmwCSbkldV2BqnkEf+tvdRuP8T6uir4Nzf8JYuAtjhPL3DxReg=@nongnu.org
X-Gm-Message-State: AOJu0Yzz4ouA9n76g65+Rfy3whe7eStiZPMipftXywlgAakele8qR9WM
 HOVwMC2w+e86DHnM0LREjPKXyH9Yw5vRekym5YSnmn6TRV4PurujTzlJtg==
X-Google-Smtp-Source: AGHT+IF7MDxOK6ZyXd9DeicGn8UMo/EyghaXt22av+4QTbbaetScuZ5Elw8H4a1AJwqr9pLayDfjnw==
X-Received: by 2002:a17:907:9722:b0:a99:403e:2578 with SMTP id
 a640c23a62f3a-a9e3a57531amr1445849466b.5.1730553475978; 
 Sat, 02 Nov 2024 06:17:55 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:55 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 20/26] hw/sd/sdhci: Prefer DEFINE_TYPES() macro
Date: Sat,  2 Nov 2024 14:17:09 +0100
Message-ID: <20241102131715.548849-21-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sdhci.c | 62 +++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ed01499391..aa89513796 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -37,7 +37,6 @@
 #include "migration/vmstate.h"
 #include "sdhci-internal.h"
 #include "qemu/log.h"
-#include "qemu/module.h"
 #include "trace.h"
 #include "qom/object.h"
 
@@ -1598,15 +1597,6 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
     sdhci_common_class_init(klass, data);
 }
 
-static const TypeInfo sdhci_sysbus_info = {
-    .name = TYPE_SYSBUS_SDHCI,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SDHCIState),
-    .instance_init = sdhci_sysbus_init,
-    .instance_finalize = sdhci_sysbus_finalize,
-    .class_init = sdhci_sysbus_class_init,
-};
-
 /* --- qdev bus master --- */
 
 static void sdhci_bus_class_init(ObjectClass *klass, void *data)
@@ -1617,13 +1607,6 @@ static void sdhci_bus_class_init(ObjectClass *klass, void *data)
     sbc->set_readonly = sdhci_set_readonly;
 }
 
-static const TypeInfo sdhci_bus_info = {
-    .name = TYPE_SDHCI_BUS,
-    .parent = TYPE_SD_BUS,
-    .instance_size = sizeof(SDBus),
-    .class_init = sdhci_bus_class_init,
-};
-
 /* --- qdev i.MX eSDHC --- */
 
 #define USDHC_MIX_CTRL                  0x48
@@ -1882,12 +1865,6 @@ static void imx_usdhc_init(Object *obj)
     s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
 }
 
-static const TypeInfo imx_usdhc_info = {
-    .name = TYPE_IMX_USDHC,
-    .parent = TYPE_SYSBUS_SDHCI,
-    .instance_init = imx_usdhc_init,
-};
-
 /* --- qdev Samsung s3c --- */
 
 #define S3C_SDHCI_CONTROL2      0x80
@@ -1946,18 +1923,31 @@ static void sdhci_s3c_init(Object *obj)
     s->io_ops = &sdhci_s3c_mmio_ops;
 }
 
-static const TypeInfo sdhci_s3c_info = {
-    .name = TYPE_S3C_SDHCI  ,
-    .parent = TYPE_SYSBUS_SDHCI,
-    .instance_init = sdhci_s3c_init,
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_SDHCI_BUS,
+        .parent = TYPE_SD_BUS,
+        .instance_size = sizeof(SDBus),
+        .class_init = sdhci_bus_class_init,
+    },
+    {
+        .name = TYPE_SYSBUS_SDHCI,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(SDHCIState),
+        .instance_init = sdhci_sysbus_init,
+        .instance_finalize = sdhci_sysbus_finalize,
+        .class_init = sdhci_sysbus_class_init,
+    },
+    {
+        .name = TYPE_IMX_USDHC,
+        .parent = TYPE_SYSBUS_SDHCI,
+        .instance_init = imx_usdhc_init,
+    },
+    {
+        .name = TYPE_S3C_SDHCI,
+        .parent = TYPE_SYSBUS_SDHCI,
+        .instance_init = sdhci_s3c_init,
+    },
 };
 
-static void sdhci_register_types(void)
-{
-    type_register_static(&sdhci_sysbus_info);
-    type_register_static(&sdhci_bus_info);
-    type_register_static(&imx_usdhc_info);
-    type_register_static(&sdhci_s3c_info);
-}
-
-type_init(sdhci_register_types)
+DEFINE_TYPES(types)
-- 
2.47.0


