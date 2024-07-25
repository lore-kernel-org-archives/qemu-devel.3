Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408BCC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Kd-0000ZX-KL; Thu, 25 Jul 2024 19:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8KI-0007xt-UX; Thu, 25 Jul 2024 19:56:51 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8KH-0001C1-4N; Thu, 25 Jul 2024 19:56:50 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2cb4c584029so313449a91.3; 
 Thu, 25 Jul 2024 16:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951807; x=1722556607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHytyYpHltvdiANf66nUebY3WyMwQaE5bfBMAngpnes=;
 b=iCmEzaa6aq1v6/sT1ocWVEnXx8vs/bmjeF1NFsHfNgVG/VCKCX2jAwi4uuZrnt6tgF
 T0UeTd4UAMAbNzr0Gw5FWLvE5He7L8uRVTC92/ceztL5Frtpye9C8os5q16GkSZ9w7Fk
 +/+ukzZ1A29oy9YJtJmIUB45LFhrUOW0H0g6zm1ooBLNgAEAXHkfqNm4nXhS2vCZO0wN
 Lq7HWKrkIvo0ZnZf5BWFKBoCSXON2LCrdc1EnO8PJQn93kNS4i6pUcDJ56ewzUYgyTNv
 yfV1C4yBgwh0G5smUID7i1G3lM41gaIvcgQ3mAlwweG50/F8UAYOsfdNqssEn4EYGmwB
 CKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951807; x=1722556607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHytyYpHltvdiANf66nUebY3WyMwQaE5bfBMAngpnes=;
 b=gRBtM5rTC3cU2fgjCpOnCO0iWGWt8haUnTktSXhBbhKymqKAW/MuXmCFlI+m+NZxjK
 1Zg5R8JdRx92SXRN9yDfxw2XdzsgkRtO4MCFtIinowIrHyes2IwEvHbP2iydBCOpXUM8
 U6qfQ0v2dtnuqZ0X7h13aeo4PX3QxXo1XF/qVNbXmpn0rWqn+T8UNZ7KDIrjtrjTHj0g
 xV7FD+UKi7mcY4bsKv0GP2lLgMVecRLaKhFyvglXXLjVgKTQb6U+1ylQJlvLVYiXBcnb
 kWnKzql5hrOINwhFZbR/90DQOLkCAlBNk171Dp6hucnkHoDgru87vaUY2EVxi+qIk8bT
 ZePw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNKNVGRuoTQy2Nyg+WblT4WVrwQlZ05LxSceQpSUExmaX0vHNV+FF4nfvNROvjNZOW+P9gRZH9+/gWtBsUbdbC6I6X
X-Gm-Message-State: AOJu0Ywll1fcKiGtorNTqnTq6JpkYvQ9BUUjHQsv3JaC51nr76xYpfOI
 z0ncQdKeD9FRNsvdZKKJI+HXM5+A5SI5tLWiOD8NJMPxc/X3uyMfVcYSVQ==
X-Google-Smtp-Source: AGHT+IEPfFHXRx/lsVKJo29gsFJ60Z69efqjrJp+JCzpaX9w+FpRiQecgy029Exam7qZm38ZBm8Abw==
X-Received: by 2002:a17:90a:f00f:b0:2cc:f2c1:88fb with SMTP id
 98e67ed59e1d1-2cf2379b39cmr4752725a91.16.1721951807121; 
 Thu, 25 Jul 2024 16:56:47 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 40/96] hw/ppc: SPI controller wiring to P10 chip
Date: Fri, 26 Jul 2024 09:53:13 +1000
Message-ID: <20240725235410.451624-41-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

In this commit, create SPI controller on p10 chip and connect cs irq.

The QOM tree of pnv-spi and seeprom are.
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /pib_spic[2] (pnv-spi)
      /pnv-spi-bus.2 (SSI)
      /xscom-spi[0] (memory-region)

/machine (powernv10-machine)
  /peripheral-anon (container)
    /device[0] (25csm04)
      /WP#[0] (irq)
      /ssi-gpio-cs[0] (irq)

(qemu) qom-get /machine/peripheral-anon /device[76] "parent_bus"
"/machine/chip[0]/pib_spic[2]/pnv-spi-bus.2"

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c              | 21 ++++++++++++++++++++-
 hw/ssi/pnv_spi.c          |  8 ++++++++
 include/hw/ppc/pnv_chip.h |  3 +++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a3560d25b7..3526852685 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1962,6 +1962,11 @@ static void pnv_chip_power10_instance_init(Object *obj)
     for (i = 0; i < pcc->i2c_num_engines; i++) {
         object_initialize_child(obj, "i2c[*]", &chip10->i2c[i], TYPE_PNV_I2C);
     }
+
+    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC; i++) {
+        object_initialize_child(obj, "pib_spic[*]", &chip10->pib_spic[i],
+                                TYPE_PNV_SPI);
+    }
 }
 
 static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
@@ -2185,7 +2190,21 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
                               qdev_get_gpio_in(DEVICE(&chip10->psi),
                                                PSIHB9_IRQ_SBE_I2C));
     }
-
+    /* PIB SPI Controller */
+    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC; i++) {
+        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "spic_num",
+                                i, &error_fatal);
+        /* pib_spic[2] connected to 25csm04 which implements 1 byte transfer */
+        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "transfer_len",
+                                (i == 2) ? 1 : 4, &error_fatal);
+        if (!sysbus_realize(SYS_BUS_DEVICE(OBJECT
+                                        (&chip10->pib_spic[i])), errp)) {
+            return;
+        }
+        pnv_xscom_add_subregion(chip, PNV10_XSCOM_PIB_SPIC_BASE +
+                                i * PNV10_XSCOM_PIB_SPIC_SIZE,
+                                &chip10->pib_spic[i].xscom_spic_regs);
+    }
 }
 
 static void pnv_rainier_i2c_init(PnvMachineState *pnv)
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index cdff3f9621..c1297ab733 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -1051,9 +1051,17 @@ static void operation_sequencer(PnvSpi *s)
 static void do_reset(DeviceState *dev)
 {
     PnvSpi *s = PNV_SPI(dev);
+    DeviceState *ssi_dev;
 
     trace_pnv_spi_reset();
 
+    /* Connect cs irq */
+    ssi_dev = ssi_get_cs(s->ssi_bus, 0);
+    if (ssi_dev) {
+        qemu_irq cs_line = qdev_get_gpio_in_named(ssi_dev, SSI_GPIO_CS, 0);
+        qdev_connect_gpio_out_named(DEVICE(s), "cs", 0, cs_line);
+    }
+
     /* Reset all N1 and N2 counters, and other constants */
     s->N2_bits = 0;
     s->N2_bytes = 0;
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index ee1649babc..de34cbdc96 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -7,6 +7,7 @@
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_n1_chiplet.h"
+#include "hw/ssi/pnv_spi.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_occ.h"
 #include "hw/ppc/pnv_psi.h"
@@ -123,6 +124,8 @@ struct Pnv10Chip {
     PnvSBE       sbe;
     PnvHomer     homer;
     PnvN1Chiplet     n1_chiplet;
+#define PNV10_CHIP_MAX_PIB_SPIC 6
+    PnvSpi pib_spic[PNV10_CHIP_MAX_PIB_SPIC];
 
     uint32_t     nr_quads;
     PnvQuad      *quads;
-- 
2.45.2


