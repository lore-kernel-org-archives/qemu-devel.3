Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8417C9EC98
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJKA-0008CC-Qy; Mon, 12 Jan 2026 09:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJn-0007op-4W
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:55 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJi-0001at-7X
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:54 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8706ce18c0so240525466b.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768229688; x=1768834488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7oIuXS4LVRn8XUCBjKf1n6RhnUu4CtgkIdX5fQX0Q0=;
 b=DH3WAl9HkejOKFyX4/LEaGBICAskq7ozlLf81fwCIxtJJI2aG5c0Dz2cP3Ch/hOX/5
 Az56Nk58zaHVzxIwwDXBj4UDqFxWYOYLW8J4YN/A/lbLUaji3vfC0LV/x05K25hXuTNo
 Vw15FkA3ieLzUn0YHGX/svTSlNIu/1jLlvVQjYOcVPKX1y8go/VzPXZur2NQEA6j5fM0
 G+epVNRwQHP7wHa3//nENctmi6SzeFr3xYbz3eVPAFsPZdJtarM6v17zuRyzR6iJV/EB
 VZLMufMNd3oONM8stvePdmMxSIvzLNRjMnI0unuNbu4lTfTvPRMRLlGiC4QvSED/x00v
 cikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229688; x=1768834488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u7oIuXS4LVRn8XUCBjKf1n6RhnUu4CtgkIdX5fQX0Q0=;
 b=ajtALq07gkog5xZgzSIha+1fwYV5CijCYUlV9BhZ0UJer4SIlhNGjefU2nOl5o1AEX
 t3gLUqykT/RNaPeXSWa7Um2hiTAOEBA4irBmcSeTX/f8oGPUE+4Jt77+i53MlUji/rZg
 leFiGdtl1iVqRdsX3IODq2BfdUufJKAGQVvCBfZRLUFyJzOkNaPheLqFF4SDbzH4n87V
 Fw+DWvrS3Aa9IR1t9JNJtM8zuwszeSKlriLz5tafgw38NMwoT1X8jKgT7K7kOCdlcfVj
 4pri+UFzepans4XgGCLOJXj+tCv5s/zIg8T4PuuvXq2dPJqd6AEvHPkt8t3T3e2IL6mF
 5Czg==
X-Gm-Message-State: AOJu0Yy437uEeOaB/FwSjXnky73MVuOG3QesbSBhJsVj0EdXX7RkO4o3
 9xhjNgTSx/icoLsMMwGXJ1RMSoXyU8DzSy/palI7iu6lxRothflPgUqmpPCKtKIq
X-Gm-Gg: AY/fxX4DtPQLCiqwxQx2AK0gfP2Wt0v3v8aVdU2zAREn19qIUaCKXBEKioc8Srr+pRM
 4qHyzunivTiXMV7ZOydBJvgZKHeQ7oxnvtVsWcEcS1mqlpmDWpN5sbWY/oT2kQV2JzZdBAvDfRS
 pJxon1OX9CCwpKwI9qLJuV64eLm04tx81hBryx74rDOjP6sMFlq4yyKAhFcKeKNEs0KwfhXLPxK
 7NWV2yYaSFl+KAF3+sRIXvDKyXuqQ3ICvGyq9bRQ+ErSI5xfeF+5Qps/OJ1F7TTxAIj7D0DcHCi
 TeNYpviZh+nK2oSwNg3C+tSyMtt/gM7ynBmoQ22DxTYublbz7Zi0N5SFlCHQha2ATqc2ivGCcja
 2Ovcr9yh3CtN9oSNXckJEKdbI8QxIIHX+ivR9ZtFYNP6MQpISL8BjGSlky6oNFeZLtuijw8j6Vf
 LJcZLY2CjbLT71H5LiMrMMVNQ3GDssQa+ujx3AHhWRU4TmnKdWdGgeRF6OHKmRujvji8r836dB
X-Google-Smtp-Source: AGHT+IFOIJDr5Eb3sa5kxgWEv8nmZXnfhSC9ttRBIEnYs5YB6D2mH8Ba87XF6LE7ImxjgtgJpfdpWQ==
X-Received: by 2002:a17:907:26c7:b0:b73:a2ce:540f with SMTP id
 a640c23a62f3a-b8444c80f04mr1758154366b.17.1768229688025; 
 Mon, 12 Jan 2026 06:54:48 -0800 (PST)
Received: from archlinux (dynamic-077-188-226-222.77.188.pool.telefonica.de.
 [77.188.226.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8731f0718asm37387966b.67.2026.01.12.06.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 06:54:47 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH 10/14] hw/arm/fsl-imx25: Extract TYPE_FSL_ESDHC_LE
Date: Mon, 12 Jan 2026 15:54:14 +0100
Message-ID: <20260112145418.220506-11-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112145418.220506-1-shentey@gmail.com>
References: <20260112145418.220506-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Extract an eSDHC (little endian) device model since the uSDHC device model
will get an uSDHC-specific MMIO quirk.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/sd/sdhci.h |  1 +
 hw/arm/fsl-imx25.c    |  7 ++-----
 hw/sd/sdhci.c         | 31 +++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 3eb0684a89..32c52c7d0b 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -129,6 +129,7 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
                          TYPE_SYSBUS_SDHCI)
 
 #define TYPE_FSL_ESDHC_BE "fsl-esdhc-be"
+#define TYPE_FSL_ESDHC_LE "fsl-esdhc-le"
 
 #define TYPE_IMX_USDHC "imx-usdhc"
 
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 9e02063533..7f65f4ca4b 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -68,7 +68,8 @@ static void fsl_imx25_init(Object *obj)
     }
 
     for (i = 0; i < FSL_IMX25_NUM_ESDHCS; i++) {
-        object_initialize_child(obj, "sdhc[*]", &s->esdhc[i], TYPE_IMX_USDHC);
+        object_initialize_child(obj, "sdhc[*]", &s->esdhc[i],
+                                TYPE_FSL_ESDHC_LE);
     }
 
     for (i = 0; i < FSL_IMX25_NUM_USBS; i++) {
@@ -239,12 +240,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_ESDHC2_ADDR, FSL_IMX25_ESDHC2_IRQ },
         };
 
-        object_property_set_uint(OBJECT(&s->esdhc[i]), "sd-spec-version", 2,
-                                 &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
                                  IMX25_ESDHC_CAPABILITIES, &error_abort);
-        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
-                                 SDHCI_VENDOR_FSL, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
             return;
         }
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6277abe870..6001b71c61 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1897,6 +1897,32 @@ static void fsl_esdhc_be_init(Object *obj)
     qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
 }
 
+static const MemoryRegionOps esdhc_mmio_le_ops = {
+    .read = esdhc_read,
+    .write = esdhc_write,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void fsl_esdhc_le_init(Object *obj)
+{
+    SDHCIState *s = SYSBUS_SDHCI(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->io_ops = &esdhc_mmio_le_ops;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    qdev_prop_set_uint8(dev, "sd-spec-version", 2);
+    qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
+}
+
 static const MemoryRegionOps usdhc_mmio_ops = {
     .read = esdhc_read,
     .write = esdhc_write,
@@ -1996,6 +2022,11 @@ static const TypeInfo sdhci_types[] = {
         .parent = TYPE_SYSBUS_SDHCI,
         .instance_init = fsl_esdhc_be_init,
     },
+    {
+        .name = TYPE_FSL_ESDHC_LE,
+        .parent = TYPE_SYSBUS_SDHCI,
+        .instance_init = fsl_esdhc_le_init,
+    },
     {
         .name = TYPE_IMX_USDHC,
         .parent = TYPE_SYSBUS_SDHCI,
-- 
2.52.0


