Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414E3C021B6
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASQ-00005Y-DO; Sun, 23 Feb 2025 06:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASN-0008VR-Nm; Sun, 23 Feb 2025 06:47:35 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASL-0005wg-N8; Sun, 23 Feb 2025 06:47:35 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abb9709b5b5so656644266b.2; 
 Sun, 23 Feb 2025 03:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311251; x=1740916051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmClN36esJRhXXDtLBPJ+4kUyD04jFmwOC3ERK+r3K8=;
 b=E+sDIx2gbZOx3fk8qesyjAFQMGdElFqkHtJFy15OhsUc3RuAc5Ql0NT4C73SF0OHn1
 iCk+mmZTN4TkSsKs2peZVWZr8CCBrXeyVNfavCodtPATscGqWLiycmscyNRw2N0TSJ5o
 9Q2M1TAIK2RGoS6l4CIHJXhbLErtr27zAzuKLPqj3U4/MN5tVaa2L554S/17ZZ4Vspms
 78/vt3suT1t41VWCQVcgMfkEDgPOgicTUvURMhbxYXEK8cHjdXLCfKmrOAiNPbqDvKti
 I6XRsMzFbBRfSXedWqV5yj42w/p3TuGmgPdZXBbgnrTqjXHacpvJfgiAZsR7Q2l4yoTV
 DXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311251; x=1740916051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmClN36esJRhXXDtLBPJ+4kUyD04jFmwOC3ERK+r3K8=;
 b=YxSMnZct3I4SM5xRjuYAX8TVmGzlCPNJLrpHdTv9eo68CqUu823MM7s74T+D6XkBvg
 obYR71113AM5WGunuc09mDJxGLzYzG6ZbmOsfmnkCgdoOi04kDSVnvG/Hi6lt68JEnHc
 TV8TCGxVdOX3I/wHdMd22042W5GYQez70RVGbcX8htmDpBCN95r4/JtQppvy5NbbKy5Z
 JdFMZyr7IzZfyNOjgf252mmKGmStz4+NugKQXX7j74fQ1/G4fOXMg1dw8GY4IqqoaJ5I
 qbVeIXz97hiYIxk+s1svF3gQiFFcIcNLaj+pnmLpvV0XBb+83fovQx2+XXt5ShEgg8kx
 0HNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXomS/3KKbGO5wWl2/JkHsZviqLuwpmnOXRe3m8Tf1XaWMO6idx+aboNobE1RqxpAqbQQqathD6nw==@nongnu.org
X-Gm-Message-State: AOJu0Yw9T97dkiGxGr20js2mbrDUe+Bx34+BxrPUAGnX7CqKWzgVHpfl
 x1idekTBryKHDW/3KmEPtQGd7C3BzYtMaZBVTN1hwiMbmrGbSpGeqTTlag==
X-Gm-Gg: ASbGncvedyW6O0IBNZgnO2lgwITUjL4910dTyBwVX1OhFVM1Iubou8sjd0lrAZtagx/
 MQvw4f4uhgSHvyzXOVOL/dM5l0OGpilhYWz5DbguPmzir+GuDpgeEfhXW/hkUtEaYTJ6MC3q9K6
 2hzn/3yOu+aTOp/ZHwQP5IAS0YDO+JGmHy5W5ulQOgB2QIkIiZmDhmbXaacJWKfWul44Ths+z71
 Y66Lc9AlQ2H2E3Zt8UvLiwP+yGqKe/Wa8N4R6aKcaK/2BKUtij+m76YXgG2mUVgEbkR2d7IQQyK
 fhjleeMEyXWaW7LDCGZGfzpWace1t5xAsQOoiC+9RpLmyZFtDyt0GpeQJiHEBsT9yeN4OGkA/iY
 FKhaAML69H0Vw
X-Google-Smtp-Source: AGHT+IHmHH4T6CZfXY8EILnKIdNt88u3WJarEC/hWaVpf38O5xOJXl9Hra3udgwTXHm/HCjwHfOa8A==
X-Received: by 2002:a17:906:31cc:b0:ab7:bcc0:906a with SMTP id
 a640c23a62f3a-abc09a808c3mr660610366b.20.1740311250731; 
 Sun, 23 Feb 2025 03:47:30 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:29 -0800 (PST)
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
Subject: [PATCH v2 07/18] hw/arm/fsl-imx8mp: Add USDHC storage controllers
Date: Sun, 23 Feb 2025 12:46:57 +0100
Message-ID: <20250223114708.1780-8-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
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

The USDHC emulation allows for running real-world images such as those generated
by Buildroot. Convert the board documentation accordingly instead of running a
Linux kernel with ephemeral storage.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst | 18 ++++++++++++------
 include/hw/arm/fsl-imx8mp.h    |  7 +++++++
 hw/arm/fsl-imx8mp.c            | 28 ++++++++++++++++++++++++++++
 hw/arm/imx8mp-evk.c            | 18 ++++++++++++++++++
 hw/arm/Kconfig                 |  1 +
 5 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 22541c5442..879c822356 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -12,6 +12,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * Up to 4 Cortex-A53 cores
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
+ * 3 USDHC Storage Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
@@ -26,18 +27,23 @@ Direct Linux Kernel Boot
 
 Probably the easiest way to get started with a whole Linux system on the machine
 is to generate an image with Buildroot. Version 2024.11.1 is tested at the time
-of writing and involves two steps. First run the following commands in the
+of writing and involves three steps. First run the following commands in the
 toplevel directory of the Buildroot source tree:
 
 .. code-block:: bash
 
-  $ echo "BR2_TARGET_ROOTFS_CPIO=y" >> configs/freescale_imx8mpevk_defconfig
   $ make freescale_imx8mpevk_defconfig
   $ make
 
 Once finished successfully there is an ``output/image`` subfolder. Navigate into
-it and patch the device tree with the following commands which will remove the
-``cpu-idle-states`` properties from CPU nodes:
+it and resize the SD card image to a power of two:
+
+.. code-block:: bash
+
+  $ qemu-img resize sdcard.img 256M
+
+Finally, the device tree needs to be patched with the following commands which
+will remove the ``cpu-idle-states`` properties from CPU nodes:
 
 .. code-block:: bash
 
@@ -52,5 +58,5 @@ Now that everything is prepared the machine can be started as follows:
       -display none -serial null -serial stdio \
       -kernel Image \
       -dtb imx8mp-evk-patched.dtb \
-      -initrd rootfs.cpio \
-      -append "root=/dev/ram"
+      -append "root=/dev/mmcblk2p2" \
+      -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 26e24e99a1..349d55ca88 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -15,6 +15,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/sd/sdhci.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -28,6 +29,7 @@ enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
+    FSL_IMX8MP_NUM_USDHCS       = 3,
 };
 
 struct FslImx8mpState {
@@ -39,6 +41,7 @@ struct FslImx8mpState {
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
+    SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
 };
 
 enum FslImx8mpMemoryRegions {
@@ -184,6 +187,10 @@ enum FslImx8mpMemoryRegions {
 };
 
 enum FslImx8mpIrqs {
+    FSL_IMX8MP_USDHC1_IRQ   = 22,
+    FSL_IMX8MP_USDHC2_IRQ   = 23,
+    FSL_IMX8MP_USDHC3_IRQ   = 24,
+
     FSL_IMX8MP_UART1_IRQ    = 26,
     FSL_IMX8MP_UART2_IRQ    = 27,
     FSL_IMX8MP_UART3_IRQ    = 28,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index de47ac1804..ad26c1e2f0 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -207,6 +207,11 @@ static void fsl_imx8mp_init(Object *obj)
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
+
+    for (i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
+        g_autofree char *name = g_strdup_printf("usdhc%d", i + 1);
+        object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
+    }
 }
 
 static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
@@ -346,6 +351,28 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* USDHCs */
+    for (i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } usdhc_table[FSL_IMX8MP_NUM_USDHCS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC1].addr, FSL_IMX8MP_USDHC1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC2].addr, FSL_IMX8MP_USDHC2_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC3].addr, FSL_IMX8MP_USDHC3_IRQ },
+        };
+
+        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
+                                 SDHCI_VENDOR_IMX, &error_abort);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0, usdhc_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
+                           qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
+    }
+
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
         return;
@@ -363,6 +390,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_RAM:
         case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
+        case FSL_IMX8MP_USDHC1 ... FSL_IMX8MP_USDHC3:
             /* device implemented and treated above */
             break;
 
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 2756d4c21c..27d9e9e8ee 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -11,6 +11,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/fsl-imx8mp.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "system/qtest.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -40,6 +41,23 @@ static void imx8mp_evk_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
                                 machine->ram);
 
+    for (int i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
+        BusState *bus;
+        DeviceState *carddev;
+        BlockBackend *blk;
+        DriveInfo *di = drive_get(IF_SD, i, 0);
+
+        if (!di) {
+            continue;
+        }
+
+        blk = blk_by_legacy_dinfo(di);
+        bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
+        carddev = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
+        qdev_realize_and_unref(carddev, bus, &error_fatal);
+    }
+
     if (!qtest_enabled()) {
         arm_load_kernel(&s->cpu[0], machine, &boot_info);
     }
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f77c451ba3..d2dda3213d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -599,6 +599,7 @@ config FSL_IMX8MP
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
+    select SDHCI
     select UNIMP
 
 config FSL_IMX8MP_EVK
-- 
2.48.1


