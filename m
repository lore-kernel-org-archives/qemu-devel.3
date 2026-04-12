Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9580FFB518A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 11:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBsaj-00082r-OX; Sun, 12 Apr 2026 07:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyanglan718@gmail.com>)
 id 1wBsaf-00081d-23
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 07:03:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yangyanglan718@gmail.com>)
 id 1wBsab-0005i8-E7
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 07:02:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82f07e5ad92so1590254b3a.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775991772; x=1776596572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4j53ezDZT7BYP6kTXkpRzKUmnkIoXcUGSbPBONRCBDY=;
 b=fMxopNM4GuvszMDajmHeNheCQuRK63cc5ibSS0GQd5cAbzzHSWDcMil16TiEEO3wfO
 2mhmvXIU9zdcX1LfWubtF8k9Aox4l1Roaf/VcAOgvqTn5bR90mPfN1Q57BSOnaw2rYrK
 bIEnYEGgL5VHQoTakuuhnQlTcMj+48yfFI5oiBFEwum6wIyCdxkdAZRu+qilc+aoR9HA
 /nwWGki9LaW/kzMYlk+AxLAF+TIFNj2HsbylHljOj7/v+8Vxe70NoQA8+c+c8qUE73lM
 vJhivTObu2KQIKXczd5E8UT+TOOFD8cQiOVPZwKnDOYOu3CUUozB1Ed/6WqeTnyf6fuK
 E5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775991772; x=1776596572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4j53ezDZT7BYP6kTXkpRzKUmnkIoXcUGSbPBONRCBDY=;
 b=d55d3cldEMXJFnB/CVWdnwfAJIwL7YHOYVlwB07MXYuooadzCqS6OxKaxVKLOYueoP
 A9B+TEM3bqYOXPGF4sQ0sFXinqvW1lIWG4l/NmW80JScx7QdB1dauUVj85NmC1sJ+63P
 JHQsZqfPstrLAHxyhC4NYEjQip/8r3PCmcGfU+DVsVtIIY1pC46dqg0ceaX7UmAQ4zK0
 4RPk8vTxgnTzH/tgZAqEPI4UZBuaz6opgwY7dqg0KjFnAF4gEmahyGbMHtfa6pj1F7nV
 iQxPnHuqQzi7QxNZoO4El5tZBEdILRC2Svm6dwZe0MN1uvUkhWOoBLjeQBPBhPcRozil
 hKtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Ru3Z2mLU1yq0MNaFuz6cax1xJ9hmCoKD2uRk6aUSDNW0RwGkxu6+hZGUw8PNrFzRV/jOmPdCZrNW2@nongnu.org
X-Gm-Message-State: AOJu0YztsKhQnMhq1rYuR+bOmJrI4C/3DJW9yG5qhBzkSrgpwW1GvlvH
 0ohYCk8IoB2QvBMpME+Jj7eNBm2judMEQhCDrZhvy1ZeZ1eSCiG/2NB6
X-Gm-Gg: AeBDiesodp1JZjZk0idRWf2oO7QBXXo4tr0dQYp7NmOOXZK/NrGQyN2Aw65HggqVMde
 B2maDlsuSHwmafJYRYO17BPXwLvNszVy8Lbkqh++VnRPKut/m+1SX7EeKdK3tlt7rdDkhRJhxmG
 7nld9YFvqSM6Cyth1q7uKADgiUihvRiQPmbxp1+gvs+IOsqyigymyMypbyfr9rheWYSDgQ6U8+m
 nksW8PTRNrK5pOhrrfrF0+AaD+1shhajqqRuMWA9bFurnCxOuFidQRxI94zu+foJ78qfdLHh9BL
 0Pz3vqX0cBF/qfmJe7DfwgJOB/pvxG69de8WJoD8G4NwK5sqa2Qam9HBN7Ul4V4uAGVXEBp+o2x
 ZlJb0Shsx0sHeywrDV9vk2e5RqvdL63KFRhay9keACcVVJL9X29AEq0Kz+V+Yo0u2I3m+EQMOaU
 5DGrdbYIb1jExLO8PgOgtB9LJ9
X-Received: by 2002:a05:6a00:3924:b0:82c:77cd:50e8 with SMTP id
 d2e1a72fcca58-82f0c30f593mr9553975b3a.27.1775991771693; 
 Sun, 12 Apr 2026 04:02:51 -0700 (PDT)
Received: from archlinux ([58.38.119.35]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c20aed6sm7996263b3a.0.2026.04.12.04.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:02:51 -0700 (PDT)
From: Yucai Liu <yangyanglan718@gmail.com>
To: pbonzini@redhat.com,
	peter.maydell@linaro.org
Cc: jcd@tribudubois.net,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v3 2/2] hw/arm/fsl-imx6ul: Wire in the LCDIF device model
Date: Sun, 12 Apr 2026 19:02:40 +0800
Message-ID: <20260412110240.93116-3-yangyanglan718@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412110240.93116-1-yangyanglan718@gmail.com>
References: <20260412110240.93116-1-yangyanglan718@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=yangyanglan718@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Yucai Liu <1486344514@qq.com>

Instantiate LCDIF as a child object of the i.MX6UL SoC in init and
realize it in the SoC realize path before MMIO/IRQ hookup.

Also make FSL_IMX6UL select CONFIG_IMX6UL_LCDIF and map the LCDIF
region with a 16 KiB size to match the SoC memory map.

Signed-off-by: Yucai Liu <1486344514@qq.com>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx6ul.c         | 12 ++++++++++--
 include/hw/arm/fsl-imx6ul.h |  4 +++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c66c452737..6655f6c34e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -641,6 +641,7 @@ config FSL_IMX6UL
     imply I2C_DEVICES
     select A15MPCORE
     select IMX
+    select IMX6UL_LCDIF
     select IMX_FEC
     select IMX_I2C
     select IMX_USBPHY
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 225e179126..1863558a0d 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
+#include "hw/display/imx6ul_lcdif.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/core/boards.h"
@@ -136,6 +137,11 @@ static void fsl_imx6ul_init(Object *obj)
         object_initialize_child(obj, name, &s->usb[i], TYPE_CHIPIDEA);
     }
 
+    /*
+     * LCDIF
+     */
+    object_initialize_child(obj, "lcdif", &s->lcdif, TYPE_IMX6UL_LCDIF);
+
     /*
      * SDHCIs
      */
@@ -656,8 +662,10 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * LCD
      */
-    create_unimplemented_device("lcdif", FSL_IMX6UL_LCDIF_ADDR,
-                                FSL_IMX6UL_LCDIF_SIZE);
+    sysbus_realize(SYS_BUS_DEVICE(&s->lcdif), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->lcdif), 0, FSL_IMX6UL_LCDIF_ADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lcdif), 0,
+                       qdev_get_gpio_in(gic, FSL_IMX6UL_LCDIF_IRQ));
 
     /*
      * CSU
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 4e3209b25b..733553883f 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -33,6 +33,7 @@
 #include "hw/net/imx_fec.h"
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
+#include "hw/display/imx6ul_lcdif.h"
 #include "system/memory.h"
 #include "cpu.h"
 #include "qom/object.h"
@@ -84,6 +85,7 @@ struct FslIMX6ULState {
     IMX2WdtState       wdt[FSL_IMX6UL_NUM_WDTS];
     IMXUSBPHYState     usbphy[FSL_IMX6UL_NUM_USB_PHYS];
     ChipideaState      usb[FSL_IMX6UL_NUM_USBS];
+    IMX6ULLCDIFState   lcdif;
     MemoryRegion       rom;
     MemoryRegion       caam;
     MemoryRegion       ocram;
@@ -143,7 +145,7 @@ enum FslIMX6ULMemoryMap {
     FSL_IMX6UL_PXP_SIZE             = (16 * KiB),
 
     FSL_IMX6UL_LCDIF_ADDR           = 0x021C8000,
-    FSL_IMX6UL_LCDIF_SIZE           = 0x100,
+    FSL_IMX6UL_LCDIF_SIZE           = (16 * KiB),
 
     FSL_IMX6UL_CSI_ADDR             = 0x021C4000,
     FSL_IMX6UL_CSI_SIZE             = 0x100,
-- 
2.53.0


