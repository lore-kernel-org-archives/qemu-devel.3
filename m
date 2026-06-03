Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADF7CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpTp-0003nM-PS; Wed, 03 Jun 2026 13:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTo-0003mw-JM
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:12 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTm-0003H6-TS
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:12 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-304e83724bfso7874437eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780508049; x=1781112849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2U2yBLgiE+5Vi7+fx1bfrmrTfGn8TlKVRJiOQP/25kM=;
 b=T36XUHkwj8D9cEdOiAdJt00sTgMoT56StCHcpPlfcmoacHnev4fURCVNO3wQTEJchz
 u8UOOGxHsJ3Bu4+V4g1rRfKe1tgUUEXUgiLh+SJvKGOgBL3yu1ZseMX4Kn6LPkKOnelb
 OfvEfNO6bryRHx91AjjHpVmG265NaTEJK5ZiFDoUxNLH3+zoSU/AdymnGJmIg/uinWMI
 FJCOKZcCLNiYTCe9EPKRIhaFUtIJLgSRIcjwD6ZjBKJqC9CCyRMedIksAlqV9N577e3V
 OP4/+6ESX86jJQSU5N+701mcUadlvB5cr7j4tjDPwltNX9IW6YhlA0fCwi10Eq875A/L
 TdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508049; x=1781112849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2U2yBLgiE+5Vi7+fx1bfrmrTfGn8TlKVRJiOQP/25kM=;
 b=irNkwF3aTbnCVFd/cArXqeYiN1Tkb8Yl2F6lcisOXuP/e13MiXT2VoLpU3j0FwiJjw
 kzEg2CT8J87SQxwz+OFntV4kunnG5Izvi23JN1KMGwg+JPHi0gy3g5rXZlxM/LTErZhC
 2cL/k/3/cPLyVrJYeiErFOMDzAs0KFIbr622xehSUVKl7/1l+JmiMbYkOV26SpUYqtjw
 R6O5u0AaJ9ZY4cN5qMsW/dZB/L+oOeAfMcC3/g3pmzkrBAqZ22xkeuPGOAfcxBWfNDS5
 kSm0xT30nSxPJZfSYhcFFmTZPihGC5Lq9sz6TFSmLqUaIXYrCaGSp+eTWrYWYnrZbWvV
 bUwQ==
X-Gm-Message-State: AOJu0YzAacc7WRWoC7SiEHRUH35hRe90k9JS/JfbvOkBmokhurQHqn+y
 lOOmtrymoBVEPiNsazRAj0kzOkbgaGrl7uVw1+1icTOvFSJd1tY9uZi9rP955jlH/Q==
X-Gm-Gg: Acq92OFTs9TdkREQLZm+uW0ROGY4vNw+pSsvBuaI/8sTrMAcwbprnQ3Am5RZS73+wqT
 +EAY4+O97l/MpkZbTgPkg1Qj2EofUw1wq1CTTEw6NO+V9T6mRlwV0Qg8w2ixK0jMc9/4aAzLWSF
 Ykz1rOknWF880gNpNEa5QczYsrtac0zPi1hxrTks9tTzo4TlcleICRLEuFFR/6AhkBKXzUlRN43
 Z/KpBPltyInmqYM+Bk+inK0oehycF8BwLIibotXAVJcTIu4As5hOlTKSH6YF/4Sue8bXqrBpsMl
 WrS/shSFY1SWlOfFOz1pvv4D0JwTEU63YMxghg7xii2PIQHLHD2+lvMiNS3RvHDiEiMqKALL9Vz
 sKx8F1pDR2Z23BG3CWjvpmuuq9h7eB3xcNDPdclbzhDFw5zJszlSxfh71dexIoUSePMnXofJfdo
 sF3qTB6Tc6tEJmrhK63kCxAYde85ZVUTjo3pX+drCajg==
X-Received: by 2002:a05:7300:2393:b0:304:cefc:5fd7 with SMTP id
 5a478bee46e88-3074fc910bbmr2360716eec.32.1780508049269; 
 Wed, 03 Jun 2026 10:34:09 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffa:7da0:c45e:b5c8:d6e8:bd7e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074d9fde90sm4354810eec.0.2026.06.03.10.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:34:09 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH 2/6] hw/pci: Introduce rom_need_patch_id flag in PCIDevice
Date: Thu,  4 Jun 2026 01:33:50 +0800
Message-ID: <20260603173355.36121-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603173355.36121-1-tomitamoeko@gmail.com>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy1-x1344.google.com
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

Allow external code (e.g., VFIO IGD passthrough) to request PCI ID
patching for a custom romfile, replacing the existing is_default_rom
flag for this purpose.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Tested-by: K S Maan <kirandeepmaan45@gmail.com>
---
 hw/pci/pci.c                | 14 ++++++--------
 include/hw/pci/pci_device.h |  1 +
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 043fef1954..17ce7d8394 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -345,7 +345,7 @@ static const TypeInfo cxl_bus_info = {
 
 static void pci_update_mappings(PCIDevice *d);
 static void pci_irq_handler(void *opaque, int irq_num, int level);
-static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom, Error **);
+static void pci_add_option_rom(PCIDevice *pdev, Error **);
 static void pci_del_option_rom(PCIDevice *pdev);
 
 static uint16_t pci_default_sub_vendor_id = PCI_SUBVENDOR_ID_REDHAT_QUMRANET;
@@ -2250,7 +2250,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
     ObjectClass *klass = OBJECT_CLASS(pc);
     Error *local_err = NULL;
-    bool is_default_rom;
     uint16_t class_id;
 
     /*
@@ -2363,13 +2362,13 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     }
 
     /* rom loading */
-    is_default_rom = false;
     if (pci_dev->romfile == NULL && pc->romfile != NULL) {
+        /* using a built-in default rom */
         pci_dev->romfile = g_strdup(pc->romfile);
-        is_default_rom = true;
+        pci_dev->rom_need_patch_id = true;
     }
 
-    pci_add_option_rom(pci_dev, is_default_rom, &local_err);
+    pci_add_option_rom(pci_dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         pci_qdev_unrealize(DEVICE(pci_dev));
@@ -2549,8 +2548,7 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
 }
 
 /* Add an option rom for the device */
-static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
-                               Error **errp)
+static void pci_add_option_rom(PCIDevice *pdev, Error **errp)
 {
     int64_t size = 0;
     g_autofree char *path = NULL;
@@ -2648,7 +2646,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
             return;
         }
 
-        if (is_default_rom) {
+        if (pdev->rom_need_patch_id) {
             /* Only the default rom images will be patched (if needed). */
             pci_patch_ids(pdev, ptr, size);
         }
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 5cac6e1688..daa679b3f5 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -159,6 +159,7 @@ struct PCIDevice {
     bool has_rom;
     MemoryRegion rom;
     int32_t rom_bar;
+    bool rom_need_patch_id;
 
     /* INTx routing notifier */
     PCIINTxRoutingNotifier intx_routing_notifier;
-- 
2.53.0


