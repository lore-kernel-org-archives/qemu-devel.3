Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B1FC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret3L-0006V4-8b; Tue, 27 Feb 2024 03:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret3K-0006Qu-As
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:43:06 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret3G-00007N-Ii
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:43:06 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412a14299a4so19382665e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023380; x=1709628180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OlS5g1x3kQBWH0+dTr65wKR69P3qOgR0yhMaMPUG6A=;
 b=vtYHII0vZ8Y/egEBftW9wpg4NX7mRbXNrSL0Iwxu2hu796Z0zkB7Vnx8lLtn2dSXGt
 njR0IuseAD47myn2aA+d/w4/cifZfCdsqVxY5p3qroHUkkt+bVdwspuLoJk51uOG72Bf
 GcBmWB0ukoUNg5SHr9yEPMTGEB91CV9npCzZ0WeXjI57ZkS0kAUx3/UVglMl8p5NAV72
 3klNWWpuNWNZDK4TcCOtMiTI6/L7SluJ+FF4FK3fS62rFz0rEGbnUinvKL623Iu7m5z6
 fdsNtT3QzOVv7QcOjThksHqVdVu1mrjYT1gUvul6zPLVSOG7R9mk06WvCf8kPZdjR6Ik
 TrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023380; x=1709628180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1OlS5g1x3kQBWH0+dTr65wKR69P3qOgR0yhMaMPUG6A=;
 b=PWtJT/MEAi9/x9xCqIgHXCtlmIbVa4Hwj5zjghEenl67c/1lvTQ4zfNleGa9QR9eJS
 aavLGf7fJTo3EuE3yiFK51ZctSTXP0T5SIz4Lvul9zrO2hN+85jDMxfVVGudvQ710Zym
 XZHcEnXzqQzHS1hwcXNN34hkeVV5HAyW3CUBGwIxl94V49pf5+7+9XmJxWwM0+nF/IKN
 rok4FGFeeQgAq57BVt9vl43TltD7J3mcQbutxo9tq8MEn4dnK2wCdjgqQFpkMx6J9FJb
 hNBCJO6tPxId3g1uo0oiVEpaaB0ouUZBb+zbsdIRgu8GT0Do1R8rALfRjlrrKLVlWJvF
 UCmA==
X-Gm-Message-State: AOJu0Yw00l6ayIAP3H2FGnrUPRrJ5CSg/EqG/DnZh5i/cmV5VvOfa+Kd
 kwwPhf19y+b+dEz9ZEwda5FJNE8oRyAVtl716BthMe3+wtPp2U2jH3YpqQ0tIw/SYGfhPHHFEOz
 F
X-Google-Smtp-Source: AGHT+IHF+FF2aPEI92LYwYdejDLzaW+tO2bYPYChMLn3MlLa8xQoS1PtNrl0+eWni1Sxzxsfq/jlTw==
X-Received: by 2002:a05:600c:3582:b0:412:94be:a169 with SMTP id
 p2-20020a05600c358200b0041294bea169mr6078523wmq.26.1709023380349; 
 Tue, 27 Feb 2024 00:43:00 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c510500b00412157dc70bsm10788193wms.30.2024.02.27.00.42.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:42:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 30/30] hw/ide: Include 'ide-internal.h' from current path
Date: Tue, 27 Feb 2024 09:39:46 +0100
Message-ID: <20240227083948.5427-31-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Rename "internal.h" as "ide-internal.h", and include
it via its relative local path, instead of absolute
to the project root path.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240226080632.9596-4-philmd@linaro.org>
---
 hw/ide/ahci_internal.h                | 2 +-
 hw/ide/{internal.h => ide-internal.h} | 0
 hw/ide/ahci.c                         | 2 +-
 hw/ide/atapi.c                        | 2 +-
 hw/ide/cmd646.c                       | 2 +-
 hw/ide/core.c                         | 2 +-
 hw/ide/ide-bus.c                      | 2 +-
 hw/ide/ide-dev.c                      | 2 +-
 hw/ide/ioport.c                       | 2 +-
 hw/ide/isa.c                          | 2 +-
 hw/ide/macio.c                        | 2 +-
 hw/ide/microdrive.c                   | 2 +-
 hw/ide/mmio.c                         | 2 +-
 hw/ide/pci.c                          | 2 +-
 hw/ide/piix.c                         | 2 +-
 hw/ide/sii3112.c                      | 2 +-
 hw/ide/via.c                          | 2 +-
 17 files changed, 16 insertions(+), 16 deletions(-)
 rename hw/ide/{internal.h => ide-internal.h} (100%)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 4e13329bb2..7e63ea2310 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -25,8 +25,8 @@
 #define HW_IDE_AHCI_INTERNAL_H
 
 #include "hw/ide/ahci.h"
-#include "hw/ide/internal.h"
 #include "hw/pci/pci_device.h"
+#include "ide-internal.h"
 
 #define AHCI_MEM_BAR_SIZE         0x1000
 #define AHCI_MAX_PORTS            32
diff --git a/hw/ide/internal.h b/hw/ide/ide-internal.h
similarity index 100%
rename from hw/ide/internal.h
rename to hw/ide/ide-internal.h
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 54c9685495..b8123bc73d 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -34,11 +34,11 @@
 #include "qemu/module.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
-#include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
 #include "hw/ide/ahci-sysbus.h"
 #include "ahci_internal.h"
+#include "ide-internal.h"
 
 #include "trace.h"
 
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index dcc39df9a4..73ec373184 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -24,10 +24,10 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/ide/internal.h"
 #include "hw/scsi/scsi.h"
 #include "sysemu/block-backend.h"
 #include "scsi/constants.h"
+#include "ide-internal.h"
 #include "trace.h"
 
 #define ATAPI_SECTOR_BITS (2 + BDRV_SECTOR_BITS)
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 23d213ff01..8cebd1b63d 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -33,7 +33,7 @@
 #include "sysemu/reset.h"
 
 #include "hw/ide/pci.h"
-#include "hw/ide/internal.h"
+#include "ide-internal.h"
 #include "trace.h"
 
 /* CMD646 specific */
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 9c4a812902..130c4d8865 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -41,7 +41,7 @@
 #include "qemu/cutils.h"
 #include "sysemu/replay.h"
 #include "sysemu/runstate.h"
-#include "hw/ide/internal.h"
+#include "ide-internal.h"
 #include "trace.h"
 
 /* These values were based on a Seagate ST3500418AS but have been modified
diff --git a/hw/ide/ide-bus.c b/hw/ide/ide-bus.c
index 57fe67b29c..37d003dd9a 100644
--- a/hw/ide/ide-bus.c
+++ b/hw/ide/ide-bus.c
@@ -21,10 +21,10 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "hw/ide/internal.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/runstate.h"
+#include "ide-internal.h"
 
 static char *idebus_get_fw_dev_path(DeviceState *dev);
 static void idebus_unrealize(BusState *qdev);
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index c8e2033469..799bd4b6ec 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -23,11 +23,11 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/ide/ide-dev.h"
-#include "hw/ide/internal.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "qapi/visitor.h"
+#include "ide-internal.h"
 
 static Property ide_props[] = {
     DEFINE_PROP_UINT32("unit", IDEDevice, unit, -1),
diff --git a/hw/ide/ioport.c b/hw/ide/ioport.c
index 0b283ac783..a2f457f0bd 100644
--- a/hw/ide/ioport.c
+++ b/hw/ide/ioport.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
-#include "hw/ide/internal.h"
+#include "ide-internal.h"
 #include "trace.h"
 
 int ide_init_ioport(IDEBus *bus, ISADevice *dev, int iobase, int iobase2)
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index cc865c83dc..934c45887c 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -32,8 +32,8 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/isa.h"
-#include "hw/ide/internal.h"
 #include "qom/object.h"
+#include "ide-internal.h"
 
 /***********************************************************/
 /* ISA IDE definitions */
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 0d2c6ba910..aca90d04f0 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -33,7 +33,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
 
-#include "hw/ide/internal.h"
+#include "ide-internal.h"
 
 /* debug MACIO */
 // #define DEBUG_MACIO
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index a7f415f0fc..3bb152b5d3 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -31,8 +31,8 @@
 #include "sysemu/dma.h"
 #include "hw/irq.h"
 
-#include "hw/ide/internal.h"
 #include "qom/object.h"
+#include "ide-internal.h"
 
 #define TYPE_MICRODRIVE "microdrive"
 OBJECT_DECLARE_SIMPLE_TYPE(MicroDriveState, MICRODRIVE)
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index e8f41c0610..8736281305 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -30,8 +30,8 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/mmio.h"
-#include "hw/ide/internal.h"
 #include "hw/qdev-properties.h"
+#include "ide-internal.h"
 
 /***********************************************************/
 /* MMIO based ide port
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 73efeec7f4..4675d079a1 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -30,8 +30,8 @@
 #include "sysemu/dma.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
+#include "ide-internal.h"
 #include "trace.h"
 
 #define BMDMA_PAGE_SIZE 4096
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 1773a068c3..80efc633d3 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -30,9 +30,9 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
-#include "hw/ide/internal.h"
 #include "hw/ide/piix.h"
 #include "hw/ide/pci.h"
+#include "ide-internal.h"
 #include "trace.h"
 
 static uint64_t bmdma_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 321b9e46a1..af17384ff2 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -13,11 +13,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
 #include "qemu/module.h"
 #include "trace.h"
 #include "qom/object.h"
+#include "ide-internal.h"
 
 #define TYPE_SII3112_PCI "sii3112"
 OBJECT_DECLARE_SIMPLE_TYPE(SiI3112PCIState, SII3112_PCI)
diff --git a/hw/ide/via.c b/hw/ide/via.c
index cf151e70ec..a32f56b0e7 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -25,7 +25,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/ide/internal.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
@@ -34,6 +33,7 @@
 #include "hw/isa/vt82c686.h"
 #include "hw/ide/pci.h"
 #include "hw/irq.h"
+#include "ide-internal.h"
 #include "trace.h"
 
 static uint64_t bmdma_read(void *opaque, hwaddr addr,
-- 
2.41.0


