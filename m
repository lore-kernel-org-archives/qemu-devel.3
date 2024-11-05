Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C754D3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SNL-0001Dy-Jd; Tue, 05 Nov 2024 17:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMo-0000pG-Ou
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:43 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMm-0004Rs-Uj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:42 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso50977385e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846978; x=1731451778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POH9GGPh8eEOywwiqXrYQY7PtUqeDBAiKsSZ852ign4=;
 b=mgeeHISbJftcn3a5xULqlnrGKJ9MaaWBKY4x6iSfskmIfuwh8MjTVXiq6d0zNDCA4m
 B3Gr2Jb6cSJ06t+pM93JteSEQEDwIxq2J9v6wAoM+TL1rLE3KlY0QV2bMW8WgvVi8OUp
 qIU398kgd+71RIK68Opc7OVI0ZWaSnMY/EMIUOdNuSFImfQgVopjDY+74e1TSpTzAD1H
 OGQDz8PF5NsZuI+HWUR54AaHhC1OAdmXhvvkjPr2YL4oBis8wsEPD3xOPWjUBRO0lnaq
 Npld8ZNItksaUYbdz09v7UHZPXr7VJ0zRObBL/jRva8lswjp4ZYPIWNhAnDrwTAbP/1J
 fRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846978; x=1731451778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=POH9GGPh8eEOywwiqXrYQY7PtUqeDBAiKsSZ852ign4=;
 b=CadkVaSAwKOFqfGo3s3p1TltQXQ5L8uI4rFn/mCDkFo8uND4v9gmpGXp+9/VPvvVPW
 AifzDnxdVdm9ZK4w1RT17oXPh/Qg+n3oD1BvUb2X04OnHopxdwSupzXxrJe8uRf/NPU7
 NOPu0Of2VPd0raZq8u34A/mHRyXBgxy1lzF9LK3vObx5vjM6nCA0aVZotex9RbkkTpcl
 O6XtU0FmYCPCnUqsX7MKifD/6gRWE/wu5qzR7fNsHwXPWHVblvY45pzJl7Uy7yEWCxKE
 m3o58+Xzu9GMoqx4kUSgNAP6wsFM1VBK4CiulpZtYxxNhxVzdoUJJ75dg2s/1/2lcgdI
 jSNw==
X-Gm-Message-State: AOJu0Ywxhl2BWc1WPlZrWWAW00QR8tPSw/6oZQjcyornOmVV/Gu+ws7V
 rbtdKOBt6IS7yxweASSITZGsnexNKLCq9agMBLkY2d1vz16fc1MiYSEp8A/4dkTYWEQmppfStBH
 w/rq3hQ==
X-Google-Smtp-Source: AGHT+IFARDWuIlrD14VldL+JbiDkVHK27OWqNFtXwUVp/JfdO5Zgkq36a+dmvvR09GHJNS3aB2CJpA==
X-Received: by 2002:adf:e198:0:b0:37d:51bc:3229 with SMTP id
 ffacd0b85a97d-381c7ac7d79mr14398421f8f.51.1730846978069; 
 Tue, 05 Nov 2024 14:49:38 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d40d5sm17255398f8f.25.2024.11.05.14.49.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:49:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/29] hw/sd/sdhci: Prefer DEFINE_TYPES() macro
Date: Tue,  5 Nov 2024 22:47:22 +0000
Message-ID: <20241105224727.53059-25-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-21-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 62 +++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ed014993910..dbe5c2340c6 100644
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
+static const TypeInfo sdhci_types[] = {
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
+DEFINE_TYPES(sdhci_types)
-- 
2.45.2


