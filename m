Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089D9C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjaI4-0002Wi-PV; Tue, 14 Jul 2026 06:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wjaI3-0002W9-DS
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:23:03 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wjaI1-0007gs-To
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:23:03 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso10253025ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784024580; x=1784629380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4rWo6iZravHIAZKxvFkcliAzYoxIQUvzR1jEbYqWXYY=;
 b=NAzoqUr0C8HWwA9tEBB8fyXLoAoxszfrOtH/MsQj9raDS4eHqtM09nWlccp5cNx0Xd
 waCj+v34EDDRquDsvKuD1SOhuwwGZaPkt6xY88nZ/Eip0Y4Sa+W7L6kg8bc4MFil7D1i
 ofKMCF2CatJ/QpApVEdIJmVzMfpyuLIfGl5HeBSkR28IROn0OSvEE7+/OfF0x+YkIRE/
 ZQaKynaIp2MdGsjQp1dT3fdIuWD+6KwitCjUbTd1qVYlowhth5C3pB7V+f7kd1o7ZEgU
 BhVNUE8V3CbzIxXm9vys36uEpyrapR4ZSu35QaRvjBNHJFxRC6bk49gJB+NCz2eV46Rr
 nnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784024580; x=1784629380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4rWo6iZravHIAZKxvFkcliAzYoxIQUvzR1jEbYqWXYY=;
 b=W5N/EWNbG5nSBZOTtq4SP7AQqt4KLFE9SqEyqxLAxXEya0UA0sJJSXx1AICAwAUxlZ
 HDNhTeO3eAYosejJLKq2sWoWGMQKqw3jhYVyePxvKET83yLIlTYmxq0ZdTrBYKqS1OtD
 5w8hCGJx15GNH3Vudh2qYP1XqKRXth8+t4tJuFgD2pY+njS/tyXkXcreQ9h/jFIR/XIp
 SfSrsswgDMo9Pzon0zMZ9BhZ+GYqfLDrm4lBjXfGI6Oo+eHf/h1qwYw+iZX0CoCkbqq1
 K8P2FjG225U1ahiRIUji0nLmCbHjsbCngmMupCmdmFGwIdv3AJjgs14qsHjStds9ZVJ/
 9WyA==
X-Gm-Message-State: AOJu0Yz781p3Ouxmgs0wK/JLZ0/KxjsIyZT/b/gYhw31RraMpE2qEAcb
 sGw4VIOoW209m+MptZm3emd2WU/fYILtWK+w5heJUq8URZOZ+1UnVyLjfwN9vxDJism7yg==
X-Gm-Gg: AfdE7cn0S6wHvCMx2OpndlI0dwc+wEMuDPIC7zgVsdj1mc/fniDxr7qmsJvMI6gkOhJ
 apREkjHZvReDr76KVd3Gm2y2CuN9pagXapcDFc3/9dyvugGM9HqiriTvczxPtLNZCWFzG8U/5YK
 IbBUvHwFPMG/5PCiDBf6vG+5FU2S2rd/fI95lPdyCnNTJgm40JAxZC5zAd0BwXO7MVWvarHLIIB
 qUZmXtqRsRhMWpW3ONqT3PNNT6O5iGmFAXH5nhTElY3QRCJ5gLtqWYWCHB+dBLrgApOK8iTpxfT
 p2pVDrFn7SOwISXGZD8SuvBFXMGM9J7dKde8lN0D5p/mLCtMVDXPRegaAZ2PVPVjlFF5LpRa+pY
 wJKdz8ZSje/ztSTOsoiJ5VzbPB/LE97iZ9jlUpGuVAoJQ2GkA5q4n+5gRPTiUdOpRKoi+EP2x/D
 6KHps0gE+jqdD9XleeKWAqAg3KTSuWWFsGa1OgDZeCJw==
X-Received: by 2002:a17:903:3b88:b0:2cc:80d6:b72 with SMTP id
 d9443c01a7336-2cea1852ee9mr102268375ad.20.1784024580625; 
 Tue, 14 Jul 2026 03:23:00 -0700 (PDT)
Received: from LAPTOP-CS7CB8K1.localdomain
 ([2409:8900:9fe:241d:8c09:365b:5b34:d891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc1fsm113824285ad.55.2026.07.14.03.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:23:00 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v2 2/3] hw/riscv/k230: wire up the IOMUX device
Date: Tue, 14 Jul 2026 18:22:01 +0800
Message-ID: <43e4eb64d1c29419d5803e42ad692324bde2b6c7.1784022244.git.flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784022244.git.flamboyant.h.01@gmail.com>
References: <cover.1784022244.git.flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Instantiate the K230 IOMUX device and map its MMIO region at
0x91105000, replacing the unimplemented device covering the same SoC
address window.

Select the model from the K230 machine configuration and document the
newly modeled device.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 docs/system/riscv/k230.rst |  1 +
 hw/riscv/Kconfig           |  1 +
 hw/riscv/k230.c            | 11 ++++++++---
 include/hw/riscv/k230.h    |  2 ++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202e55..b160c401fd 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -20,6 +20,7 @@ The ``k230`` machine supports the following devices:
 * Platform-Level Interrupt Controller (PLIC)
 * 2 K230 Watchdog Timer
 * 5 UART
+* K230 IOMUX register block
 
 Boot options
 ------------
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..4c9fc3e7ad 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -162,3 +162,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select K230_IOMUX
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..430c1646b5 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-iomux", &s->iomux, TYPE_K230_IOMUX);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -198,6 +199,11 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* IOMUX */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->iomux), errp)) {
+        return;
+    }
+
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[0]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT0_IRQ));
@@ -206,6 +212,8 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
 
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->iomux), 0, memmap[K230_DEV_IOMUX].base);
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -280,9 +288,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("ipcm", memmap[K230_DEV_MAILBOX].base,
                                 memmap[K230_DEV_MAILBOX].size);
 
-    create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
-                                memmap[K230_DEV_IOMUX].size);
-
     create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
                                 memmap[K230_DEV_TIMER].size);
 
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..223e76b420 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,6 +18,7 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/misc/k230_iomux.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -33,6 +34,7 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
+    K230IomuxState iomux;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
-- 
2.43.0


