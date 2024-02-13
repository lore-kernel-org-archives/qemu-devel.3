Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8264C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZnuf-0001It-IA; Tue, 13 Feb 2024 03:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnud-00016g-Tg
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:13:07 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnua-0000w6-Up
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:13:07 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5114fa38434so4465292e87.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 00:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707811983; x=1708416783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2VfWU0EmMkx2mEhciES4OHFukm6OT4OfeAh7mCbOtI=;
 b=jzuHWtsNdy3fx8Einpv94oVLqTRAbAK2TTJCeByRROFBNr586DkjL9mxcdrh86k+xH
 zQ4NPYvyaunwPK27wUg1TnNpkejk/vyOWHV5t0M5clOHmebBH6V6UJsu5ejCr+RbDI5C
 A31DQDCSjolLgVz8afViRQEvBgs9AYTHIAVqFwWkz9LjL1gCXvcJVcHrphEMeWQNiScn
 yVQTWE77pv1XKkqyXwMjA6pnDLHFA0yHZ4VrBESVFV/K191MypKOncZutLTWhNxPVZkX
 wn2OiCqBbL6YaU0mk3a0IUCB5ji7HlnjVnoyeAwz8BmzFIz/HmbYZmcTcEnFA/kACQXc
 MGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707811983; x=1708416783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2VfWU0EmMkx2mEhciES4OHFukm6OT4OfeAh7mCbOtI=;
 b=T6dEwDdzYS+ZZhuP8qmgiU6NSTbvPTf5ks5HD78T4zyhZQGxo7LXmAZYTPW9UBBnkV
 e7si0qhzqSFPIzdr/44doNxLynYm0+tyRwiUXyGBlkQ9Wo0gA4jCLXvnFiYK3OmsnfHQ
 JxLngRn+Fa75pSJa3CXFgkfzwg5PfHYal56LeZNGb7cKDbg5q8BwHPZpHTI2G1ZzNHf+
 qWkU6w7q0gHQDGXvQuFa2oXBpZMahdwwBVEBuC2Ve5SZIGxjBkjpF60lrdq1yCjGxUwh
 2SXMjv6d173wKbxNxDvOjTcj3p3QqHCG9vBXLMU3TEsBfGPzpOELCLpE0cY6UcFGLuCy
 73+A==
X-Gm-Message-State: AOJu0Yz78mMGiwyQyG268roXItpMr4tVqImZWHD8D8gceA+dx691uAfH
 lkCsRvl8ed5Hc/LHsfRFRCQwlsmUi/D3OiqdvnsEonGOPrG4rOLj+yRf+ZNtRTz3gasvbyGlhq7
 1
X-Google-Smtp-Source: AGHT+IFQSnqMpGGj/2FlHuC3GG129Suyu36ht4RTcUj2oVsjzdoFOGSs07Lkk28croNXqXjZCvvXQw==
X-Received: by 2002:a05:6512:3c8d:b0:511:9d22:f4bd with SMTP id
 h13-20020a0565123c8d00b005119d22f4bdmr413061lfv.63.1707811983187; 
 Tue, 13 Feb 2024 00:13:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWi577CshayfwLtIFjxE46jsqtR5FDaYjIGDsT58tJdyJz8QGWPlEWRwWCHoqPKZvRe6y+95Ro2LZwOiIdS6olDsJ9NOuuT9uPkWoxdpPq/i3wmj3mvs1g4m8fMCYNIMefak0V3rRCZBGJr5ty2QJHPBQviC885EHcNSTgty6C5E1mXLuJas0f6F5JGz6nEVhoT+WFTHaHMZGA4APuwJlxRjW9Mj0dc/d/Rs27tBw+Pw7zg+Tv8izJngNTeoZUMIa+tcQN7xnXQjzuLMvnKhfHc0Ywm4olFb6C1n5/uKKmBgS8LUYSt5stoEDLjtjEgb4cH3cCBvsDFLIdr8gsK2Bf8Y0abj+ZDwd59KoWIk1DAxr8ng19hNm+VGzVlYjX7QdqehHWl/pl3egnAgHNmUhymOh66EYxijO7EKW+Gmj/8fYnEhwQhyyZwdxmyj/0qS/aY+WeeGNEH+8R+2ZFPjjy38H/SqO7G28ej0LnKjIej++KbP36XekC5BwZRwGRbH2Vm/Yth7idREEwB4r85tf8pAKCC8PzxcPDgTEU3Dd4EMBtjG9e/hdfuDfxOs3sIp9uXCFw=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a05600c154d00b0040fb783ad93sm10792039wmg.48.2024.02.13.00.13.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 00:13:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 9/9] hw/ide/ahci: Move SysBus definitions to 'ahci-sysbus.h'
Date: Tue, 13 Feb 2024 09:12:00 +0100
Message-ID: <20240213081201.78951-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213081201.78951-1-philmd@linaro.org>
References: <20240213081201.78951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Keep "hw/ide/ahci.h" AHCI-generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/allwinner-a10.h |  2 +-
 include/hw/arm/allwinner-r40.h |  2 +-
 include/hw/arm/xlnx-zynqmp.h   |  2 +-
 include/hw/ide/ahci-sysbus.h   | 35 ++++++++++++++++++++++++++++++++++
 include/hw/ide/ahci.h          | 29 +---------------------------
 hw/arm/highbank.c              |  2 +-
 hw/arm/sbsa-ref.c              |  1 +
 hw/ide/ahci-allwinner.c        |  3 +--
 hw/ide/ahci.c                  |  1 +
 9 files changed, 43 insertions(+), 34 deletions(-)
 create mode 100644 include/hw/ide/ahci-sysbus.h

diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 2eb83a17ea..67a9a17b86 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -5,7 +5,7 @@
 #include "hw/intc/allwinner-a10-pic.h"
 #include "hw/net/allwinner_emac.h"
 #include "hw/sd/allwinner-sdhost.h"
-#include "hw/ide/ahci.h"
+#include "hw/ide/ahci-sysbus.h"
 #include "hw/usb/hcd-ohci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/rtc/allwinner-rtc.h"
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 66c38e7d90..614e74b7ed 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -22,7 +22,7 @@
 
 #include "qom/object.h"
 #include "hw/timer/allwinner-a10-pit.h"
-#include "hw/ide/ahci.h"
+#include "hw/ide/ahci-sysbus.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/sd/allwinner-sdhost.h"
 #include "hw/misc/allwinner-r40-ccu.h"
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 96358d51eb..48f7948092 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -22,7 +22,7 @@
 #include "hw/net/cadence_gem.h"
 #include "hw/char/cadence_uart.h"
 #include "hw/net/xlnx-zynqmp-can.h"
-#include "hw/ide/ahci.h"
+#include "hw/ide/ahci-sysbus.h"
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/xilinx_spips.h"
 #include "hw/dma/xlnx_dpdma.h"
diff --git a/include/hw/ide/ahci-sysbus.h b/include/hw/ide/ahci-sysbus.h
new file mode 100644
index 0000000000..7ed6cad496
--- /dev/null
+++ b/include/hw/ide/ahci-sysbus.h
@@ -0,0 +1,35 @@
+/*
+ * QEMU AHCI Emulation (MMIO-mapped devices)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_IDE_AHCI_SYSBUS_H
+#define HW_IDE_AHCI_SYSBUS_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+#include "hw/ide/ahci.h"
+
+#define TYPE_SYSBUS_AHCI "sysbus-ahci"
+OBJECT_DECLARE_SIMPLE_TYPE(SysbusAHCIState, SYSBUS_AHCI)
+
+struct SysbusAHCIState {
+    SysBusDevice parent_obj;
+
+    AHCIState ahci;
+};
+
+#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
+OBJECT_DECLARE_SIMPLE_TYPE(AllwinnerAHCIState, ALLWINNER_AHCI)
+
+#define ALLWINNER_AHCI_MMIO_OFF  0x80
+#define ALLWINNER_AHCI_MMIO_SIZE 0x80
+
+struct AllwinnerAHCIState {
+    SysbusAHCIState parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
+};
+
+#endif
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index c0b10c2bb4..ba31e75ff9 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -24,8 +24,7 @@
 #ifndef HW_IDE_AHCI_H
 #define HW_IDE_AHCI_H
 
-#include "hw/sysbus.h"
-#include "qom/object.h"
+#include "exec/memory.h"
 
 typedef struct AHCIDevice AHCIDevice;
 
@@ -54,30 +53,4 @@ typedef struct AHCIState {
 
 void ahci_ide_create_devs(AHCIState *ahci, DriveInfo **hd);
 
-#define TYPE_SYSBUS_AHCI "sysbus-ahci"
-OBJECT_DECLARE_SIMPLE_TYPE(SysbusAHCIState, SYSBUS_AHCI)
-
-struct SysbusAHCIState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    AHCIState ahci;
-};
-
-#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
-OBJECT_DECLARE_SIMPLE_TYPE(AllwinnerAHCIState, ALLWINNER_AHCI)
-
-#define ALLWINNER_AHCI_MMIO_OFF  0x80
-#define ALLWINNER_AHCI_MMIO_SIZE 0x80
-
-struct AllwinnerAHCIState {
-    /*< private >*/
-    SysbusAHCIState parent_obj;
-    /*< public >*/
-
-    MemoryRegion mmio;
-    uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
-};
-
 #endif /* HW_IDE_AHCI_H */
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 9fdac1cc81..c71b1a8db3 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -30,7 +30,7 @@
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
-#include "hw/ide/ahci.h"
+#include "hw/ide/ahci-sysbus.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/cpu/a15mpcore.h"
 #include "qemu/log.h"
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f2adf30337..5d3a574664 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -38,6 +38,7 @@
 #include "hw/boards.h"
 #include "hw/ide/internal.h"
 #include "hw/ide/ahci_internal.h"
+#include "hw/ide/ahci-sysbus.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/loader.h"
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index b173121006..9620de8ce8 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -19,9 +19,8 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
-#include "hw/ide/internal.h"
 #include "migration/vmstate.h"
-#include "ahci_internal.h"
+#include "hw/ide/ahci-sysbus.h"
 
 #include "trace.h"
 
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 041cc87c11..54c9685495 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -37,6 +37,7 @@
 #include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
+#include "hw/ide/ahci-sysbus.h"
 #include "ahci_internal.h"
 
 #include "trace.h"
-- 
2.41.0


