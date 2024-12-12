Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00A9E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfN-0007S1-Ox; Thu, 12 Dec 2024 06:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfH-0007D9-G1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:34 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfE-0007Gl-Bw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=JVqULoL6sKLNorCDppEPnSOYBnknpza7Wcrxutoludg=; b=bylk7pzh3+h4x4lt+xwLmRbUW0
 g0Z6zlS+nRIeVH2tq4W3r5VaadrrIvo5KBH4qtgoSqFXCCIcTnHUpX6Srj9KcceMQnOw6FIwJYG7I
 KMqKv0DE1o44vqJtPdrVfxr7GuW9WQkiEN+9KZsMtWtloLn1ibfmN/QwGMZxCDehiLQRhOc6MtjM9
 jkvECiM88DwAIk4T3C+JN/oyuGo+71EYXiFftHZhQJXPN9hmkRKSbCTy2+i92XmWruCgNS3W64q+M
 bzKsdTL+E6uBEsmLOQj/Gd5a3Ti+Wi3+LMWcEJ3oH4k/ilnG+Vt+iZJdDsWJavBG6Kzu9DYNmK9uf
 +nNVMcXpsJ4YjuJK7As1ZpgM5BktetQJBNjWgh74MmaVSJ/ZReb8QkqIfWR4uzuHplDofUG2ztjpu
 C8YGVecGmjSqcva+a7JG4G6ZRTu9sLpEhJCCw0ivE8WIK2lb8MLGRct5fC6eEF1UcY+uo7Mtu4msS
 vsQrdbphk4aoAxVFytHt2rWBU7H4ADW36spfHSNLGwnr3gpnPqxhyYrNxGz7sWmE7fvg5/CyUVmiD
 0fA7PavUGAIA5C/hOUJb7/9rcTrJ9yCeWhqRjGjgzkQUjoJ+ll+utk1VznUJEmWi65StZHsns7xQg
 9Ev0oCIP5rJvC0wiDqbdseu43FB9ip5pPU5Md85WQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheU-00070a-Cn; Thu, 12 Dec 2024 11:46:46 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:01 +0000
Message-Id: <20241212114620.549285-16-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 15/34] next-cube: remove unused next.scr memory region
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Now that the next.scr memory region is unused it can be removed and the next-pc
devices mapped directly within the machine init function. This is the last
remaining overlapping memory region within the NeXTCube machine.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 73 +++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 52 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 95d01030cd..86a0aaa511 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -369,38 +369,6 @@ static const MemoryRegionOps next_mmio_ops = {
 #define SCSICSR_CPUDMA  0x10  /* if set, dma enabled */
 #define SCSICSR_INTMASK 0x20  /* if set, interrupt enabled */
 
-static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
-{
-    uint64_t val;
-
-    switch (addr) {
-    default:
-        DPRINTF("BMAP Read @ 0x%x size %u\n", (unsigned int)addr, size);
-        val = 0;
-        break;
-    }
-
-    return val;
-}
-
-static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
-                             unsigned size)
-{
-    switch (addr) {
-    default:
-        DPRINTF("BMAP Write @ 0x%x with 0x%"PRIx64 " size %u\n",
-                (unsigned int)addr, val, size);
-    }
-}
-
-static const MemoryRegionOps next_scr_ops = {
-    .read = next_scr_readfn,
-    .write = next_scr_writefn,
-    .valid.min_access_size = 1,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
 #define NEXTDMA_SCSI(x)      (0x10 + x)
 #define NEXTDMA_FD(x)        (0x10 + x)
 #define NEXTDMA_ENTX(x)      (0x110 + x)
@@ -1063,17 +1031,11 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd;
     DeviceState *d;
 
-    /* en network (dummy) */
-    memory_region_add_subregion(&s->scrmem, 0x6000,
-                                &s->dummyen_mem);
-
     /* SCSI */
     sbd = SYS_BUS_DEVICE(&s->next_scsi);
     if (!sysbus_realize(sbd, errp)) {
         return;
     }
-    memory_region_add_subregion(&s->scrmem, 0x14000,
-                                sysbus_mmio_get_region(sbd, 0));
 
     d = DEVICE(object_resolve_path_component(OBJECT(&s->next_scsi), "esp"));
     sysbus_connect_irq(SYS_BUS_DEVICE(d), 0,
@@ -1082,10 +1044,6 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     s->scsi_reset = qdev_get_gpio_in(d, 0);
     s->scsi_dma = qdev_get_gpio_in(d, 1);
 
-    /* Floppy */
-    memory_region_add_subregion(&s->scrmem, 0x14108,
-                                &s->floppy_mem);
-
     /* ESCC */
     d = DEVICE(object_resolve_path_component(OBJECT(dev), "escc"));
     qdev_prop_set_uint32(d, "disabled", 0);
@@ -1103,12 +1061,6 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(dev, NEXT_SCC_I));
     sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(dev, NEXT_SCC_DMA_I));
-
-    memory_region_add_subregion(&s->scrmem, 0x18000,
-                                sysbus_mmio_get_region(sbd, 0));
-
-    /* Timer */
-    memory_region_add_subregion(&s->scrmem, 0x1a000, &s->timer_mem);
 }
 
 static void next_pc_init(Object *obj)
@@ -1120,24 +1072,27 @@ static void next_pc_init(Object *obj)
 
     memory_region_init_io(&s->mmiomem, OBJECT(s), &next_mmio_ops, s,
                           "next.mmio", 0x9000);
-    memory_region_init_io(&s->scrmem, OBJECT(s), &next_scr_ops, s,
-                          "next.scr", 0x20000);
-
     sysbus_init_mmio(sbd, &s->mmiomem);
-    sysbus_init_mmio(sbd, &s->scrmem);
 
     memory_region_init_io(&s->dummyen_mem, OBJECT(s), &next_dummy_en_ops, s,
                           "next.en", 0x20);
+    sysbus_init_mmio(sbd, &s->dummyen_mem);
 
     object_initialize_child(obj, "next-scsi", &s->next_scsi, TYPE_NEXT_SCSI);
+    sysbus_init_mmio(sbd,
+                     sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->next_scsi), 0));
 
     memory_region_init_io(&s->floppy_mem, OBJECT(s), &next_floppy_ops, s,
                           "next.floppy", 4);
+    sysbus_init_mmio(sbd, &s->floppy_mem);
 
     object_initialize_child(obj, "escc", &s->escc, TYPE_ESCC);
+    sysbus_init_mmio(sbd,
+                     sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->escc), 0));
 
     memory_region_init_io(&s->timer_mem, OBJECT(s), &next_timer_ops, s,
                           "next.timer", 4);
+    sysbus_init_mmio(sbd, &s->timer_mem);
 }
 
 /*
@@ -1240,13 +1195,27 @@ static void next_cube_init(MachineState *machine)
     /* BMAP IO - acts as a catch-all for now */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
 
+    /* en network (dummy) */
+    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02106000);
+
     /* unknown: Brightness control register? */
     empty_slot_init("next.unknown", 0x02110000, 0x10);
     /* unknown: Magneto-Optical drive controller? */
     empty_slot_init("next.unknown", 0x02112000, 0x10);
+
+    /* SCSI */
+    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 2, 0x02114000);
+    /* Floppy */
+    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 3, 0x02114108);
+    /* ESCC */
+    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 4, 0x02118000);
+
     /* unknown: Serial clock configuration register? */
     empty_slot_init("next.unknown", 0x02118004, 0x10);
 
+    /* Timer */
+    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 5, 0x0211a000);
+
     /* BMAP memory */
     memory_region_init_ram_flags_nomigrate(&m->bmapm1, NULL, "next.bmapmem",
                                            64, RAM_SHARED, &error_fatal);
-- 
2.39.5


