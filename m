Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32466C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVwi-0002ys-4j; Thu, 13 Aug 2026 09:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuVwf-0002y7-Ly
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:58:09 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuVwe-00020u-0o
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:58:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2d004f135b1so31841715ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786629487; x=1787234287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k5Phay0AGTCvZKUkw7glNgeUzFefh4pDgge7EAdtJaM=;
 b=UYpKeTsml3LGnE1Vx/FzWBlsgceINJ7tnZDsj5hQECYyQQLFNKPMqnnX1ufBmTuv/6
 1O+LoG8geft4nl7FOTciDqMdKOaBLFir++fPL4fGFw4iSH3cRRnNo8OrPtz/LyB3BASS
 bpYke3dDJJX12j/Rvq4xBCku/KLUkxfFELFMdP31TMi1GMTj+5SQdRr+Mk9Lkoiyy8dD
 gLIn4599cATpHD9uIrn3yhKx6TWPaKscx8L+oek6++0MGuwgtCxeovR0t7IWGevEnNGw
 pJHSzPF5sDcjVoHVxNsYklMc7aGL0kuZ0oqy4nLvRthXZRwBs9R8TaWzS7gdi5WEOR1K
 HZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786629487; x=1787234287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k5Phay0AGTCvZKUkw7glNgeUzFefh4pDgge7EAdtJaM=;
 b=e4KqNakzTVPFln4IN/pMT88EtQZnZ5p0Z/jl1WT6hqyZ2PYqzUrT8CdM1Rzblu5OHM
 fu82HNwsxKi/VS7qYqWPYtf7F2qaULXagx/DLuLghSPLPubZeQyEV+J5ETBZsHP+Q78Q
 PkVy1sxd8QCobfjwoA1cgW9W5qQyNQ7Od3pn8uSTk6dpJy4/FTLWBxiVEnkQb/RwUXN2
 tS9oZOagcBjmfPRnG1cKHxyy3XV51tOHyN27nbixdyWosUZbfSTqDlbxrReT6Cq8rQXC
 X1kO4DasRuI+ScpEgNrZCAdbZb1vOK0nfp3K9IpBTwzTj54zaj8d4EFPRMgQ2iAcQnck
 UIwA==
X-Gm-Message-State: AOJu0YzruoDUaztWABNS4m6Q5JClsqaT7rrGKEN5rLhGzSV5rpSPAvkk
 3fhp0///tV1Njhlpc2EdbJV+pFbovDkZz5GwL8EXvBs2q8Dn14bqe0vDBXhdoOL0+Q4=
X-Gm-Gg: AR+sD12OtomffrMby3ne+LACL0DtfHBM27WdOe6oKSz+5vkInY/taaWEV0E/ySr0Jas
 sT5ySXKhpHUiQITOgiIKTIyur66Dy58uoWGDjlklkZNXDdQ0lKV90wQt3ADuTxgqm/8wtofQdCd
 fMnMpvZVL384YUrbJwmNGoDtV6rE3SjpOWXWAYWZcBOvemi4XRWSjidXU4HjtwTPi2+GyLpGyTn
 QxCj3nG4hxzEVe6x1Fgx/Ttvn2lGJpTBOvNa3roLA6eh9CSFIqBcJROhU2oVueSR0eUFMt5QwPP
 /6B76nVv2HoyHr9d/wGdt3cI5L0AGOGBrk7J8Iw4FA1KugyLhHIM7dmKB8eqbQzfJcpE+fZuWld
 b2K5Rj6DBrIvWhPL2UqcgB+wsWFVa1oiKLlBALDAjHDcBa205MfCJcBhXWpnPITx0MuSHig12qa
 pnc3dPNdkMxDqsBCJrRs/LUJNwsvvQuGLUbzU5i8bpn12iu+Gt45STRrZN8T+C1hyExr4b0EVD1
 W3MCpI3jg==
X-Received: by 2002:a17:903:1b04:b0:2d0:cc92:f7a3 with SMTP id
 d9443c01a7336-2d37d5417fdmr75868095ad.2.1786629486648; 
 Thu, 13 Aug 2026 06:58:06 -0700 (PDT)
Received: from localhost.localdomain ([111.198.227.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d37c486531sm10024395ad.57.2026.08.13.06.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 06:58:06 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Junze Cao <caojunze424@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v3 2/3] hw/riscv/k230: wire up the IOMUX device
Date: Thu, 13 Aug 2026 21:57:16 +0800
Message-ID: <20260813135717.2758-3-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813135717.2758-1-flamboyant.h.01@gmail.com>
References: <20260813135717.2758-1-flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pl1-x62d.google.com
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

Suggested-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
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


