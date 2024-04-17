Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DFEC04FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 11:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx34A-0002tx-Q5; Wed, 17 Apr 2024 07:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rx33n-0002sl-01; Wed, 17 Apr 2024 07:02:39 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rx33h-0002aF-Ui; Wed, 17 Apr 2024 07:02:38 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ed11782727so4639289b3a.1; 
 Wed, 17 Apr 2024 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713351752; x=1713956552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xak3WtbGiqg+jcikj2ECEMwXQ4l+HkP9xSnNpIPJJXU=;
 b=geTH9DGHxrU23eo5Ebk5apmu1Hex6DdtMghU7ec1Le7TE2NzGbQ8cc9f2kYmMzzNS2
 ZIa+2cpKmBGgjNYGlul8SPGBvel9spqydd6NmeIlLH1eyDCKuu1Uk173b1tyToWJq2e8
 cQx26NADyOV1kMnXUm38vteteQVjx0aX351ImbmVqC5XutIPMqvqXSFRLpiDJCf1SO1c
 2VsF2Ye4MdjWaloT3uDiO5KdY1NegInRHZ0SW5kTbnmrxP9DFixqZwwCU/LPHbvXNsb3
 aCORHz1HlvUY7elOpNHflN8mKxT+o2FZIIsSF+UpGrCf+++D1gtCY/0fiBRbojVB51cA
 IhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713351752; x=1713956552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xak3WtbGiqg+jcikj2ECEMwXQ4l+HkP9xSnNpIPJJXU=;
 b=PZpOHL345WkDDe7oUqpdApsRPJCAc7xBxVoXvfaevHSJwmGqxczi2SH4Ew99/8frK9
 nLzOg0bb2O3RJLnUy/+iK4sddDCAtBpFO1q+zpSsqyXDOuKwdlWu/ho2o+lfGY0J4GtL
 GmB/5si8ELBAL5nTa1grt/Dfvv2BM5XW1sPMi3pspdSBpO+zF2M0yKvjkfWIa31V9ngR
 kuRyr7etnA4kuIcRtNEO3tlTK7xTI0bU5fguLcj8LiVlAutlsaxW7wzi4SH8KIwNMt1d
 JdukUnjJ4VQZdZ+V5uP9ofRjN2oKp5CGBmcgptq1W2/vOhbixW+CRR776Vo13FCOtWbn
 IWwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfzG0BeNJpmKsD9CVsr7Z36AwfS63MhajijJln6b7EqrgffdRnrwVw1yO+tM9rLZRd2vBDwZTp3TEn4S9+qesJDdnolGw=
X-Gm-Message-State: AOJu0Yw1eKylrpKVsBEGAJjnmAzLvbzU1w0Qvg/5MbWNd/3zGFc7jurw
 Se4BUgOHuyvajA7m+c7VIpbOjGqQUXInYt0qwD9lUfn5f86ESlbFHGb9lQ==
X-Google-Smtp-Source: AGHT+IFFo4qDxLt+Un5L54acCHo1wTCDre1jIk9N+qBlz2LAGg7rT3C4VkIH7Lp7kbQqKfCquXZRAA==
X-Received: by 2002:a05:6a00:1a93:b0:6ec:ffb7:7dc7 with SMTP id
 e19-20020a056a001a9300b006ecffb77dc7mr17160004pfv.26.1713351751633; 
 Wed, 17 Apr 2024 04:02:31 -0700 (PDT)
Received: from wheely.local0.net ([1.146.62.55])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a056a0023c500b006e6be006637sm10407787pfc.135.2024.04.17.04.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 04:02:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Subject: [PATCH 2/2] ppc/pnv: Implement ADU access to LPC space
Date: Wed, 17 Apr 2024 21:02:13 +1000
Message-ID: <20240417110215.808926-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417110215.808926-1-npiggin@gmail.com>
References: <20240417110215.808926-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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
 include/hw/ppc/pnv_adu.h |  7 ++++
 include/hw/ppc/pnv_lpc.h |  5 +++
 hw/ppc/pnv.c             |  4 ++
 hw/ppc/pnv_adu.c         | 91 ++++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_lpc.c         | 12 +++---
 5 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/pnv_adu.h b/include/hw/ppc/pnv_adu.h
index 9dc91857a9..b7b5d1bb21 100644
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
index 5d22c45570..016e2998a8 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -94,6 +94,11 @@ struct PnvLpcClass {
     DeviceRealize parent_realize;
 };
 
+bool pnv_opb_lpc_read(PnvLpcController *lpc, uint32_t addr,
+                      uint8_t *data, int sz);
+bool pnv_opb_lpc_write(PnvLpcController *lpc, uint32_t addr,
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
index 5bd33a3841..d5570c23e2 100644
--- a/hw/ppc/pnv_adu.c
+++ b/hw/ppc/pnv_adu.c
@@ -21,9 +21,15 @@
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
     PnvADU *adu = PNV_ADU(opaque);
@@ -35,6 +41,24 @@ static uint64_t pnv_adu_xscom_read(void *opaque, hwaddr addr, unsigned width)
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
@@ -46,6 +70,26 @@ static uint64_t pnv_adu_xscom_read(void *opaque, hwaddr addr, unsigned width)
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
@@ -60,6 +104,47 @@ static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
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
+            pnv_opb_lpc_read(adu->lpc, lpc_addr, (void *)&data, lpc_size);
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
+            pnv_opb_lpc_write(adu->lpc, lpc_addr, (void *)&data, lpc_size);
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
@@ -86,12 +171,18 @@ static void pnv_adu_realize(DeviceState *dev, Error **errp)
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
index d692858bee..743bd66fc0 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -235,16 +235,16 @@ int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset, uint64_t lpcm_addr,
  * TODO: rework to use address_space_stq() and address_space_ldq()
  * instead.
  */
-static bool opb_read(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
-                     int sz)
+bool pnv_opb_lpc_read(PnvLpcController *lpc, uint32_t addr,
+                      uint8_t *data, int sz)
 {
     /* XXX Handle access size limits and FW read caching here */
     return !address_space_read(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
                                data, sz);
 }
 
-static bool opb_write(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
-                      int sz)
+bool pnv_opb_lpc_write(PnvLpcController *lpc, uint32_t addr,
+                       uint8_t *data, int sz)
 {
     /* XXX Handle access size limits here */
     return !address_space_write(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
@@ -276,7 +276,7 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
     }
 
     if (cmd & ECCB_CTL_READ) {
-        success = opb_read(lpc, opb_addr, data, sz);
+        success = pnv_opb_lpc_read(lpc, opb_addr, data, sz);
         if (success) {
             lpc->eccb_stat_reg = ECCB_STAT_OP_DONE |
                     (((uint64_t)data[0]) << 24 |
@@ -293,7 +293,7 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
         data[2] = lpc->eccb_data_reg >>  8;
         data[3] = lpc->eccb_data_reg;
 
-        success = opb_write(lpc, opb_addr, data, sz);
+        success = pnv_opb_lpc_write(lpc, opb_addr, data, sz);
         lpc->eccb_stat_reg = ECCB_STAT_OP_DONE;
     }
     /* XXX Which error bit (if any) to signal OPB error ? */
-- 
2.43.0


