Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B0BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8JD-0007z8-4X; Thu, 25 Jul 2024 19:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8J5-0007KW-OK; Thu, 25 Jul 2024 19:55:38 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8J2-0000xI-3R; Thu, 25 Jul 2024 19:55:34 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2cb55418470so291378a91.1; 
 Thu, 25 Jul 2024 16:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951730; x=1722556530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/yX63KTDQl//4HUcSi0eiTmjyFrfp+jQwa5dnnwjd9o=;
 b=UBBMLFEM4Gu2EscK0EXNgMBA9vwp/6hZW4JdGrHNKJzPVLnj3o0WRnk6Eth3jBnEx4
 MsvHPGzJ06/KWC6UDNo5qzPN5CvkNbxXaVg+BYiTzuqpHgCGKeNgWFWICgFcUrYDVUtx
 XvZZzKBBhAl0Wm/pAJt6uJ1fInGLU0uoY2bAlZhfrnoB7PWTt9+2ndomPRs9jcoGgRr8
 LEIq3qi4BkpwgW3shMFld9Cxsz2TuKCUGn3GbWQi/QgEnhUTVi1DEQL2x41tYLkZwxtd
 h/WFoAauHP6E8cGhbrupPkDTOAU7d2vITJEptX3RvsVhvVA6UXvxfayOtb36bZDHGPPt
 hpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951730; x=1722556530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/yX63KTDQl//4HUcSi0eiTmjyFrfp+jQwa5dnnwjd9o=;
 b=KdNzrpobWnq/D/gRNQ4rVmwbdgKcKmmKC4q17EMicGCdJ4ZsRtCGCWoYh4Nqq9WuD0
 /Ze2wUUOhlP4GJYC2TMztpwGsvKc/JPJK5yD8INUaRcUC4l+MoSDH3PLTD+GVfXJoKF2
 0KzjpukuJhebZH6DNZ1La1Dn5KCv3yjGOZxkwZLeLkqBFWMxLBqxW0T+fy8rwJRDsxnD
 xeSx4hgolz7BvomvIioWaUjwmeKgOd0NbkJ+bvfhCDY1Fizevltly8E3skzxCVLIwb4a
 fjBiR0k5fSqg9EvgW3dI3vJQNGHGxXveiZ9yLldU3wPlDOWfXAE2YyHR8UTyu2H33dpd
 Ca2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR6Ogr7C9cvRc0himqGdhcQo8/3nH98My+YCPP82OqgqQKjl/pb7WgGqAyt4JIX3JVpiPck9ogBBXgzg4pdktvt6EJ
X-Gm-Message-State: AOJu0YxEUe/Y6/JQGUx2qwJPXLnE2i91sbRkV7IpqtXCJceQ08ONCVub
 msE13NoZZB8A7bWIml5bWDsXG4J+ErZEg51Ih6lpITAkUmfP3a1AXs/X/w==
X-Google-Smtp-Source: AGHT+IGrdoIp2QihDlIishWs/Zlz+xj6vk4nvLx+qZ6Wkd1xLHRMQmu85NkBVKGAl3UICh15wPubAg==
X-Received: by 2002:a17:90b:1b51:b0:2c8:da73:af7d with SMTP id
 98e67ed59e1d1-2cf2e9ab11cmr4045173a91.3.1721951730127; 
 Thu, 25 Jul 2024 16:55:30 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 17/96] ppc/pnv: Implement ADU access to LPC space
Date: Fri, 26 Jul 2024 09:52:50 +1000
Message-ID: <20240725235410.451624-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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

One of the functions of the ADU is indirect memory access engines that
send and receive data via ADU registers.

This implements the ADU LPC memory access functionality sufficiently
for IBM proprietary firmware to access the UART and print characters
to the serial port as it does on real hardware.

This requires a linkage between adu and lpc, which allows adu to
perform memory access in the lpc space.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c             |  4 ++
 hw/ppc/pnv_adu.c         | 95 ++++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_lpc.c         | 12 ++---
 include/hw/ppc/pnv_adu.h |  7 +++
 include/hw/ppc/pnv_lpc.h |  5 +++
 5 files changed, 117 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 689197cbb7..91ff1be21f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1663,6 +1663,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     }
 
     /* ADU */
+    object_property_set_link(OBJECT(&chip9->adu), "lpc", OBJECT(&chip9->lpc),
+                             &error_abort);
     if (!qdev_realize(DEVICE(&chip9->adu), NULL, errp)) {
         return;
     }
@@ -1929,6 +1931,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     }
 
     /* ADU */
+    object_property_set_link(OBJECT(&chip10->adu), "lpc", OBJECT(&chip10->lpc),
+                             &error_abort);
     if (!qdev_realize(DEVICE(&chip10->adu), NULL, errp)) {
         return;
     }
diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
index 8279bc8b26..81b7d6e526 100644
--- a/hw/ppc/pnv_adu.c
+++ b/hw/ppc/pnv_adu.c
@@ -21,11 +21,18 @@
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_adu.h"
 #include "hw/ppc/pnv_chip.h"
+#include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "trace.h"
 
+#define ADU_LPC_BASE_REG     0x40
+#define ADU_LPC_CMD_REG      0x41
+#define ADU_LPC_DATA_REG     0x42
+#define ADU_LPC_STATUS_REG   0x43
+
 static uint64_t pnv_adu_xscom_read(void *opaque, hwaddr addr, unsigned width)
 {
+    PnvADU *adu = PNV_ADU(opaque);
     uint32_t offset = addr >> 3;
     uint64_t val = 0;
 
@@ -34,6 +41,24 @@ static uint64_t pnv_adu_xscom_read(void *opaque, hwaddr addr, unsigned width)
     case 0x12:     /* log register */
     case 0x13:     /* error register */
         break;
+    case ADU_LPC_BASE_REG:
+        /*
+         * LPC Address Map in Pervasive ADU Workbook
+         *
+         * return PNV10_LPCM_BASE(chip) & PPC_BITMASK(8, 31);
+         * XXX: implement as class property, or get from LPC?
+         */
+        qemu_log_mask(LOG_UNIMP, "ADU: LPC_BASE_REG is not implemented\n");
+        break;
+    case ADU_LPC_CMD_REG:
+        val = adu->lpc_cmd_reg;
+        break;
+    case ADU_LPC_DATA_REG:
+        val = adu->lpc_data_reg;
+        break;
+    case ADU_LPC_STATUS_REG:
+        val = PPC_BIT(0); /* ack / done */
+        break;
 
     default:
         qemu_log_mask(LOG_UNIMP, "ADU Unimplemented read register: Ox%08x\n",
@@ -45,9 +70,30 @@ static uint64_t pnv_adu_xscom_read(void *opaque, hwaddr addr, unsigned width)
     return val;
 }
 
+static bool lpc_cmd_read(PnvADU *adu)
+{
+    return !!(adu->lpc_cmd_reg & PPC_BIT(0));
+}
+
+static bool lpc_cmd_write(PnvADU *adu)
+{
+    return !lpc_cmd_read(adu);
+}
+
+static uint32_t lpc_cmd_addr(PnvADU *adu)
+{
+    return (adu->lpc_cmd_reg & PPC_BITMASK(32, 63)) >> PPC_BIT_NR(63);
+}
+
+static uint32_t lpc_cmd_size(PnvADU *adu)
+{
+    return (adu->lpc_cmd_reg & PPC_BITMASK(5, 11)) >> PPC_BIT_NR(11);
+}
+
 static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
                                 unsigned width)
 {
+    PnvADU *adu = PNV_ADU(opaque);
     uint32_t offset = addr >> 3;
 
     trace_pnv_adu_xscom_write(addr, val);
@@ -58,6 +104,47 @@ static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
     case 0x13:     /* error register */
         break;
 
+    case ADU_LPC_BASE_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "ADU: Changing LPC_BASE_REG is not implemented\n");
+        break;
+
+    case ADU_LPC_CMD_REG:
+        adu->lpc_cmd_reg = val;
+        if (lpc_cmd_read(adu)) {
+            uint32_t lpc_addr = lpc_cmd_addr(adu);
+            uint32_t lpc_size = lpc_cmd_size(adu);
+            uint64_t data = 0;
+
+            pnv_lpc_opb_read(adu->lpc, lpc_addr, (void *)&data, lpc_size);
+
+            /*
+             * ADU access is performed within 8-byte aligned sectors. Smaller
+             * access sizes don't get formatted to the least significant byte,
+             * but rather appear in the data reg at the same offset as the
+             * address in memory. This shifts them into that position.
+             */
+            adu->lpc_data_reg = be64_to_cpu(data) >> ((lpc_addr & 7) * 8);
+        }
+        break;
+
+    case ADU_LPC_DATA_REG:
+        adu->lpc_data_reg = val;
+        if (lpc_cmd_write(adu)) {
+            uint32_t lpc_addr = lpc_cmd_addr(adu);
+            uint32_t lpc_size = lpc_cmd_size(adu);
+            uint64_t data;
+
+            data = cpu_to_be64(val) >> ((lpc_addr & 7) * 8); /* See above */
+            pnv_lpc_opb_write(adu->lpc, lpc_addr, (void *)&data, lpc_size);
+        }
+        break;
+
+    case ADU_LPC_STATUS_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "ADU: Changing LPC_STATUS_REG is not implemented\n");
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP, "ADU Unimplemented write register: Ox%08x\n",
                                                                      offset);
@@ -78,18 +165,26 @@ static void pnv_adu_realize(DeviceState *dev, Error **errp)
 {
     PnvADU *adu = PNV_ADU(dev);
 
+    assert(adu->lpc);
+
     /* XScom regions for ADU registers */
     pnv_xscom_region_init(&adu->xscom_regs, OBJECT(dev),
                           &pnv_adu_xscom_ops, adu, "xscom-adu",
                           PNV9_XSCOM_ADU_SIZE);
 }
 
+static Property pnv_adu_properties[] = {
+    DEFINE_PROP_LINK("lpc", PnvADU, lpc, TYPE_PNV_LPC, PnvLpcController *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pnv_adu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pnv_adu_realize;
     dc->desc = "PowerNV ADU";
+    device_class_set_props(dc, pnv_adu_properties);
     dc->user_creatable = false;
 }
 
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 0f14e180af..f8aad955b5 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -236,16 +236,16 @@ int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset, uint64_t lpcm_addr,
  * TODO: rework to use address_space_stq() and address_space_ldq()
  * instead.
  */
-static bool opb_read(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
-                     int sz)
+bool pnv_lpc_opb_read(PnvLpcController *lpc, uint32_t addr,
+                      uint8_t *data, int sz)
 {
     /* XXX Handle access size limits and FW read caching here */
     return !address_space_read(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
                                data, sz);
 }
 
-static bool opb_write(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
-                      int sz)
+bool pnv_lpc_opb_write(PnvLpcController *lpc, uint32_t addr,
+                       uint8_t *data, int sz)
 {
     /* XXX Handle access size limits here */
     return !address_space_write(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
@@ -277,7 +277,7 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
     }
 
     if (cmd & ECCB_CTL_READ) {
-        success = opb_read(lpc, opb_addr, data, sz);
+        success = pnv_lpc_opb_read(lpc, opb_addr, data, sz);
         if (success) {
             lpc->eccb_stat_reg = ECCB_STAT_OP_DONE |
                     (((uint64_t)data[0]) << 24 |
@@ -294,7 +294,7 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
         data[2] = lpc->eccb_data_reg >>  8;
         data[3] = lpc->eccb_data_reg;
 
-        success = opb_write(lpc, opb_addr, data, sz);
+        success = pnv_lpc_opb_write(lpc, opb_addr, data, sz);
         lpc->eccb_stat_reg = ECCB_STAT_OP_DONE;
     }
     /* XXX Which error bit (if any) to signal OPB error ? */
diff --git a/include/hw/ppc/pnv_adu.h b/include/hw/ppc/pnv_adu.h
index b5f308627b..f9dbd8c8b3 100644
--- a/include/hw/ppc/pnv_adu.h
+++ b/include/hw/ppc/pnv_adu.h
@@ -10,6 +10,7 @@
 #define PPC_PNV_ADU_H
 
 #include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_lpc.h"
 #include "hw/qdev-core.h"
 
 #define TYPE_PNV_ADU "pnv-adu"
@@ -19,6 +20,12 @@ OBJECT_DECLARE_TYPE(PnvADU, PnvADUClass, PNV_ADU)
 struct PnvADU {
     DeviceState xd;
 
+    /* LPCMC (LPC Master Controller) access engine */
+    PnvLpcController *lpc;
+    uint64_t     lpc_base_reg;
+    uint64_t     lpc_cmd_reg;
+    uint64_t     lpc_data_reg;
+
     MemoryRegion xscom_regs;
 };
 
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index e0fd5e4130..174add4c53 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -109,6 +109,11 @@ struct PnvLpcClass {
     DeviceRealize parent_realize;
 };
 
+bool pnv_lpc_opb_read(PnvLpcController *lpc, uint32_t addr,
+                      uint8_t *data, int sz);
+bool pnv_lpc_opb_write(PnvLpcController *lpc, uint32_t addr,
+                       uint8_t *data, int sz);
+
 ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error **errp);
 int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset,
                uint64_t lpcm_addr, uint64_t lpcm_size);
-- 
2.45.2


