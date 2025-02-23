Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C402CC021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASW-0000A8-5X; Sun, 23 Feb 2025 06:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmAST-00008b-JA; Sun, 23 Feb 2025 06:47:41 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASR-0005xn-Mr; Sun, 23 Feb 2025 06:47:41 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-abb7a6ee2deso543631466b.0; 
 Sun, 23 Feb 2025 03:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311257; x=1740916057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCd6Vfq4K6pQrWMZVaEsXURSZIMwzducUrhIpJ+Eno0=;
 b=dIBXhiS25gTzEcQT1Ulmmhtd/p8RgVe/0cMQ6RzkdtD6oRBS4LpWFfSmPt0JvyGy4U
 N8QrYy+EryvRhD7aG0fN62+q8dNCna4GGmlMcBtG3RXkLl98jgU+RELoST2SYKD3uplD
 lsP2f0D9KGvthDiI7T40lY7T8SUfsGY4tPgimNfdVqtqOXRIammBTrUSft9QdpFsQC4J
 CMVrlXOF8O8vLBtvxyttgQzhYZpOJ//yqBxgnwSBTkWIs73Z00+vqMf52SYNxxxLHZjQ
 ghSD+PsAIeLseaobsCgYbHdze9wrAAaYfF8xs62exsoS6A4w8vL90zcgJMZDkq02OcuR
 hhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311257; x=1740916057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCd6Vfq4K6pQrWMZVaEsXURSZIMwzducUrhIpJ+Eno0=;
 b=Rmhm5JNbmOvu35+fuXUDMWeHkElhpppcR50hFcmy/njWJxfMECpoB2hXzofq1M10Iu
 8iW1/EiCqXHAn2105gzyR0YvHR1la7ocY/8mEfuNoUlZd+Nvuq35F2yX76hok8gCrXup
 bd/AX6M54b+d8LgeNWf7S1iVvZgaZlWH8zkq4mpfguOqI3hYVinUW6wtxBYiGsc0R4+2
 lUlXFBogi6P7+Wd5DQ7zZW4XkqODDxYc6ulI57Ko41pJEsdtbK+mk6bDW7P0/A4NHDmy
 GR318Tgvo5mk5SCmxNDGLOkzlwN+K2gyCfBgLlZpMkVR811jO0K78xRMxxLGhHXCF48H
 e5/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHnTxdabQtM5CIBxBqwLuYJ1gPaW8NEdP1oBKkBd6Z6UjF9YmbvV1HSn7GYymJt5ejO+zDAmSgQQ==@nongnu.org
X-Gm-Message-State: AOJu0YwkP2Bj7kwbVBPLhXFfHhMNN+8UiPtGyhXZyVCUcX4aB5jt2H0y
 ZEjNYdudfA2HK7WAL93ZxiLVQcIG1I5+YmM2xERl/zK4VVBE3CHFainRoQ==
X-Gm-Gg: ASbGncsxaEx8Ju89JDqaJX38pKSA8G9Ol4BVSyL8Y7jHS1Af07qh9JGgqe86n3+DHmG
 uaboftTXjXPh9EYU8CGnwiT39w2RtsIUVv/2FepWOmcnRALn7azKeClbKrWbiixAIVG4t5I6Id8
 J0b0Ddz0YXDDpwQJtyM8rvSiBvDy8C0bb+SezF9kdZ2GK82AuRqi+N5FArczs3SGrs3MYXMm/WH
 elm6Rpg3OFmRRlTg3czwQHZv/HY1Y7nyT3Le3Qpyb62fA/Fe36OxaLPUtODCoUWWspcd126nBPh
 IWxkxS00BOt/vwZSi0HpharX51pTy8hEzmW8dLlqEeDiQK6Xs0A9BGjcj2fgZlQfe0OXozZr2LL
 fq8nZTh+JmgI4
X-Google-Smtp-Source: AGHT+IEsgVLhSOlNwCVqaOfWlhZV4jAZF4d3XKvGp2Uju9dkqJnTzz7DC3vkA6LdIBcddOj1id+eFg==
X-Received: by 2002:a17:907:9724:b0:ab7:851d:4718 with SMTP id
 a640c23a62f3a-abc09c27044mr1066573066b.36.1740311256935; 
 Sun, 23 Feb 2025 03:47:36 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:36 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/18] hw/arm/fsl-imx8mp: Add SPI controllers
Date: Sun, 23 Feb 2025 12:47:01 +0100
Message-ID: <20250223114708.1780-12-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    |  8 ++++++++
 hw/arm/fsl-imx8mp.c            | 26 ++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index ef0d997250..66e5865107 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -16,6 +16,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 1 Designware PCI Express Controller
  * 5 GPIO Controllers
  * 6 I2C Controllers
+ * 3 SPI Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 2590056627..296a87eb50 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -20,6 +20,7 @@
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
+#include "hw/ssi/imx_spi.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -31,6 +32,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 
 enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
+    FSL_IMX8MP_NUM_ECSPIS       = 3,
     FSL_IMX8MP_NUM_GPIOS        = 5,
     FSL_IMX8MP_NUM_I2CS         = 6,
     FSL_IMX8MP_NUM_IRQS         = 160,
@@ -47,6 +49,7 @@ struct FslImx8mpState {
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
+    IMXSPIState        spi[FSL_IMX8MP_NUM_ECSPIS];
     IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
@@ -208,6 +211,11 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_UART5_IRQ    = 30,
     FSL_IMX8MP_UART6_IRQ    = 16,
 
+    FSL_IMX8MP_ECSPI1_IRQ   = 31,
+    FSL_IMX8MP_ECSPI2_IRQ   = 32,
+    FSL_IMX8MP_ECSPI3_IRQ   = 33,
+    FSL_IMX8MP_ECSPI4_IRQ   = 34,
+
     FSL_IMX8MP_I2C1_IRQ     = 35,
     FSL_IMX8MP_I2C2_IRQ     = 36,
     FSL_IMX8MP_I2C3_IRQ     = 37,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 3da81e28ca..14f317be70 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -223,6 +223,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_ECSPIS; i++) {
+        g_autofree char *name = g_strdup_printf("spi%d", i + 1);
+        object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
+    }
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -459,6 +464,26 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
     }
 
+    /* ECSPIs */
+    for (i = 0; i < FSL_IMX8MP_NUM_ECSPIS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } spi_table[FSL_IMX8MP_NUM_ECSPIS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_ECSPI1].addr, FSL_IMX8MP_ECSPI1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_ECSPI2].addr, FSL_IMX8MP_ECSPI2_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_ECSPI3].addr, FSL_IMX8MP_ECSPI3_IRQ },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           qdev_get_gpio_in(gicdev, spi_table[i].irq));
+    }
+
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
         return;
@@ -498,6 +523,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
+        case FSL_IMX8MP_ECSPI1 ... FSL_IMX8MP_ECSPI3:
         case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
-- 
2.48.1


