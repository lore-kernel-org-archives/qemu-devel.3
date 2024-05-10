Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A8FC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 14:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5R1p-0003s6-7H; Fri, 10 May 2024 10:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s5R1g-0003b8-0P; Fri, 10 May 2024 10:15:08 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s5R1c-0000h3-48; Fri, 10 May 2024 10:15:06 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-36c7ee71ebaso8886445ab.2; 
 Fri, 10 May 2024 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715350502; x=1715955302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTzB3Nu4NJmXxIc5C6AQnfnpgpXf5szLqDm+8G74C3g=;
 b=TM/x6J/NJ15oD2gdYCTGrfbBXQ8mOdLv8elagZnsKIxudVyHpxdJQ+LPuQrq8mKiXJ
 7j7E8ibTcZEMGGK3ojkeGJLVYLpKawUTxT3Cgi7GD4ZBJYXJUXh+ootkRuaXBopnAzOw
 G9WuFgTU/EEl0NgnPPnfIECVbSAdyXDwp8ws8Tf++p4cB7zZfx7BTDo+TG4tlBDTbbPh
 JPHARaEqPEkrmCgod8Z34OW9UPa2kN6/SYft/x/khjr0KtKFMxWKvrvq0OvK4hc1Y8+i
 hW8Hpbg5IC2c3qREhXpVOQTmE3wbE1ZX9hzHEeVx+GuikSmflHY4VfJnrrjEWL5fTdmt
 bBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715350502; x=1715955302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GTzB3Nu4NJmXxIc5C6AQnfnpgpXf5szLqDm+8G74C3g=;
 b=qTHVXBnTh3ePeHFJLraNL6VbXBjnMKDvYzoMZk3Us8xdR7WQlYue66iMegwZRYMh07
 AdR7Wse4QDrt1Xi1F3vgqXbdOW8SdtTuMGOQj5qnaMpPIvoMDJAJ/u0PdIMPvXVQFQ5z
 8o7CTa7/evKhwphHOcLlxuQZRjkeVvI1dfdtZdeo9chTY3BzACCJClFKp1BmdyYfS5tH
 b9Dq12aRrl7yAXjp2x8UsVYJmU4xW89GNKBZhz+QinEtXeEcSVkOlm5CNnI/GUIVP+f5
 yR7rCa5J2LBOnqtP91xaxvnlj3NRQc4yzJFXFydJOCYJUj/okk0RrbJBqZphgOpFef8B
 wg5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV73XdmpO+jRXURq64vFxrQ9UT9Mdy4Ehpv+HZCKAJd1Pr97NzBlnmhT1ZdNwI1LcKODNuDqLGmzbiMrxv3J5yKDB2lN0=
X-Gm-Message-State: AOJu0YzakrRUH18u/oc5RHdgWYfj5LXUlLRZIO9H5FoHt5A3IgfG9aLd
 GFKWGrWu86iCMeIDlb8Fmpy2vRQQ3b9lf1mFzsKtgd5SF5PxkxoOgfLcxw==
X-Google-Smtp-Source: AGHT+IGTjersqX+7QkEI+vDV5zYAOuFmZXkyh3sIGzLlleIssjSApLI0CoodGBfv5Vf5CFUKoTxzxg==
X-Received: by 2002:a05:6e02:160a:b0:36c:5882:511a with SMTP id
 e9e14a558f8ab-36cc14f8853mr33137275ab.22.1715350502071; 
 Fri, 10 May 2024 07:15:02 -0700 (PDT)
Received: from wheely.local0.net (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340a632725sm2691453a12.12.2024.05.10.07.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 07:15:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v2 2/2] ppc/pnv: Implement ADU access to LPC space
Date: Sat, 11 May 2024 00:14:45 +1000
Message-ID: <20240510141446.108360-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510141446.108360-1-npiggin@gmail.com>
References: <20240510141446.108360-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12b.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_adu.h |  7 +++
 include/hw/ppc/pnv_lpc.h |  5 +++
 hw/ppc/pnv.c             |  4 ++
 hw/ppc/pnv_adu.c         | 95 ++++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_lpc.c         | 12 ++---
 5 files changed, 117 insertions(+), 6 deletions(-)

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
index 5d22c45570..d99407f856 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -94,6 +94,11 @@ struct PnvLpcClass {
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5869aac89a..eb9dbc62dd 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1642,6 +1642,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     }
 
     /* ADU */
+    object_property_set_link(OBJECT(&chip9->adu), "lpc", OBJECT(&chip9->lpc),
+                             &error_abort);
     if (!qdev_realize(DEVICE(&chip9->adu), NULL, errp)) {
         return;
     }
@@ -1908,6 +1910,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
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
index d692858bee..e5e9727563 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -235,16 +235,16 @@ int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset, uint64_t lpcm_addr,
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
@@ -276,7 +276,7 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
     }
 
     if (cmd & ECCB_CTL_READ) {
-        success = opb_read(lpc, opb_addr, data, sz);
+        success = pnv_lpc_opb_read(lpc, opb_addr, data, sz);
         if (success) {
             lpc->eccb_stat_reg = ECCB_STAT_OP_DONE |
                     (((uint64_t)data[0]) << 24 |
@@ -293,7 +293,7 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
         data[2] = lpc->eccb_data_reg >>  8;
         data[3] = lpc->eccb_data_reg;
 
-        success = opb_write(lpc, opb_addr, data, sz);
+        success = pnv_lpc_opb_write(lpc, opb_addr, data, sz);
         lpc->eccb_stat_reg = ECCB_STAT_OP_DONE;
     }
     /* XXX Which error bit (if any) to signal OPB error ? */
-- 
2.43.0


