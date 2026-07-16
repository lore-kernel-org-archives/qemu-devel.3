Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09414C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkM72-0006hx-48; Thu, 16 Jul 2026 09:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wkM70-0006hV-H7
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:26:50 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wkM6y-0005HG-OK
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:26:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cf1777c25aso2788025ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784208407; x=1784813207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WKXtH3awKz4URpq1FYzgqqqMJUq1Aobj2mw3LYY6nwA=;
 b=j3XRFiYSTnWvD6FjMPgotJiJtdXPm0NSr/7OOZkAGCnyYeI9Q2s9eG6Z+1BChjWzFo
 aqOJc4uuJS0iBuJ8UgTA9C2N5yc1fgyzJyYHfTlGwa3l1r8E8e5YKbV4YEzRe7tc2WIt
 3bC3oHhBe43/qwqJGgNc7H0diZlIwmXsUAX1KPaMwBrrRzFqJEFNqs/IvP0Uq8iYTdRP
 IFx+the7bAXJXfXxCR/lFacVVOlu+oYdp95/uemnI/VPHGt0rUmJ7Kw3dH07n1VWlFrT
 LMaKVBYvyNzXdvXCUfeemoaCBW3agYId07a/89NSx9PSAhaHTf7Pss5tmDYwdOg0FgJp
 qkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208407; x=1784813207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WKXtH3awKz4URpq1FYzgqqqMJUq1Aobj2mw3LYY6nwA=;
 b=OfuZ5IUcAj2tidzvT3B8aVTS5M1k8VxE3zWO7raJKZb/DJPIVpnpSmmKmvlYitINJv
 tQcCs9DsM/JUbv1+G/lvUY1cAIuY0JhVpRqK9etZBz0tEVah/ocKTAyCEDh/vCxlWnfO
 TwAn2EpHmjS+4f5me27ZVg49hBI9jOuwM1dlWFWk/j+uo06vu3y07AOM/XjACOq0Vcht
 qLHcucjC9/o48SLA/nysF9OZU4Q2Qk7kloor/myHk4rCeu32JshrQHjeCrYgR38xewhK
 sAdBwiqzO7ZCdeTBtqoe7qCb1f0e/jZBP80JwwoDvfYbaEqY71SO74BDl6ZaxOEsxkvR
 CZhQ==
X-Gm-Message-State: AOJu0YzrtM0MDUSj+hxU1kGpUvhZSHcN31khD85SzYh78QobnbS8vBus
 4PhDaBr35yhJdPc2Nz8rokrz2uAdo+nSf+nwc1KcGH/tO6tdKWmV0HSSnbdf/YT0IITVPQ==
X-Gm-Gg: AfdE7clDW82r176C71qSFtdeoNAYJz56+vTwlmMBdaBdj/bAZ3DNGZ0lvH1DPgKrRNM
 Vloqhbm785hzw2vwBpoLEX9wn/ZDefmzhN3c+drwjRo2npFvr2GBea0lOhbIQI9ZlVMSMRr9YeO
 L6JEDz5Iz+QJ9P8NsNJBpKJPV1vgi8FtYuqbHcH7kbBdXeX/Xh3mc5vL+ER5MEaj5w1MC4R1MmY
 /xzP+wqi42jHOM3X7QcIT3vovDsWCBWfAVky2SZZ6igfMqN3k757VnqyU+t5y1KLj1c7C5TJISD
 73QwwVIgjiZChy3kyIp/RcqSU/tPL9FuSzZLvgds/vE+mAAV7+PZdzULK/mjotvbVAdj2tWGosS
 mmNArnhB4XvDNUQfrCPp28BwG5NUaptfz+AVW47f6TxJu1c+e3h72vzS573CrJmUVlQw4jbCdpe
 8xaG8T/P1m+lg8VlOYTjr8QxkewWCv
X-Received: by 2002:a17:903:2bcc:b0:2c9:99be:f011 with SMTP id
 d9443c01a7336-2ce9f28e423mr166320265ad.6.1784208407119; 
 Thu, 16 Jul 2026 06:26:47 -0700 (PDT)
Received: from DESKTOP-JUS09M1.tail12b54b.ts.net ([38.34.7.236])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd4344b8bsm11336706c88.13.2026.07.16.06.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:26:46 -0700 (PDT)
From: Junze Cao <caojunze424@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 Junze Cao <caojunze424@gmail.com>
Subject: [PATCH 2/3] hw/riscv: Connect K230 DDR controller and PHY models
Date: Thu, 16 Jul 2026 21:24:22 +0800
Message-ID: <20260716132423.931427-3-caojunze424@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716132423.931427-1-caojunze424@gmail.com>
References: <20260716132423.931427-1-caojunze424@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=caojunze424@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace the unimplemented K230 DDR configuration region with the DDRC
model and map the PHY model at 0x9a000000.

Connect the controller to the PHY so DFI status reflects PHY training and
initialization state.

Signed-off-by: Junze Cao <caojunze424@gmail.com>
---
 docs/system/riscv/k230.rst |  4 ++++
 hw/riscv/k230.c            | 19 ++++++++++++++++---
 include/hw/riscv/k230.h    |  4 ++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202e55..06a819fbdb 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -20,12 +20,16 @@ The ``k230`` machine supports the following devices:
 * Platform-Level Interrupt Controller (PLIC)
 * 2 K230 Watchdog Timer
 * 5 UART
+* K230 DDRC CFG and DDR PHY
 
 Boot options
 ------------
 The ``k230`` machine supports K230 SDK boot through M-mode U-Boot, which then
 starts OpenSBI/Linux with ``bootm``. It also supports direct Linux boot.
 
+The DDRC CFG and DDR PHY models allow the K230 SDK U-Boot SPL to complete DDR
+initialization before loading the next boot stage.
+
 K230 SDK Linux kernels use T-HEAD C9xx private MAEE page table attributes. QEMU
 does not implement MAEE in the generic RISC-V MMU, so such kernels need to be
 built with standard RISC-V PTE bits before they can boot under QEMU.
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..627150b463 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -97,6 +97,7 @@ static const MemMapEntry memmap[] = {
     [K230_DEV_SPI] =          { 0x91584000,  0x00001000 },
     [K230_DEV_HI_SYS_CFG] =   { 0x91585000,  0x00000400 },
     [K230_DEV_DDRC_CFG] =     { 0x98000000,  0x02000000 },
+    [K230_DEV_DDR_PHY] =      { 0x9A000000,  0x00400000 },
     [K230_DEV_FLASH] =        { 0xC0000000,  0x08000000 },
     [K230_DEV_PLIC] =         { 0xF00000000, 0x00400000 },
     [K230_DEV_CLINT] =        { 0xF04000000, 0x00400000 },
@@ -108,6 +109,11 @@ static void k230_soc_init(Object *obj)
     RISCVHartArrayState *cpu0 = &s->c908_cpu;
 
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
+                            TYPE_K230_DDR_CFG);
+    object_initialize_child(obj, "ddr-phy", &s->ddr_phy,
+                            TYPE_K230_DDR_PHY);
+    s->ddr_cfg.phy = &s->ddr_phy;
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
 
@@ -158,6 +164,16 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     int c908_cpus;
 
     sysbus_realize(SYS_BUS_DEVICE(&s->c908_cpu), &error_fatal);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ddr_cfg), errp)) {
+        return;
+    }
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ddr_phy), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ddr_cfg), 0,
+                    memmap[K230_DEV_DDRC_CFG].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ddr_phy), 0,
+                    memmap[K230_DEV_DDR_PHY].base);
 
     c908_cpus = s->c908_cpu.num_harts;
 
@@ -361,9 +377,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("hi_sys_cfg", memmap[K230_DEV_HI_SYS_CFG].base,
                                 memmap[K230_DEV_HI_SYS_CFG].size);
 
-    create_unimplemented_device("ddrc_cfg", memmap[K230_DEV_DDRC_CFG].base,
-                                memmap[K230_DEV_DDRC_CFG].size);
-
     create_unimplemented_device("flash", memmap[K230_DEV_FLASH].base,
                                 memmap[K230_DEV_FLASH].size);
 }
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..80ca16338c 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -16,6 +16,7 @@
 #define HW_K230_H
 
 #include "hw/core/boards.h"
+#include "hw/misc/k230_ddr.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
 
@@ -32,6 +33,8 @@ typedef struct K230SoCState {
     /*< public >*/
     RISCVHartArrayState c908_cpu; /* Small core */
 
+    K230DDRCfgState ddr_cfg;
+    K230DDRPhyState ddr_phy;
     K230WdtState wdt[2];
     MemoryRegion sram;
     MemoryRegion bootrom;
@@ -112,6 +115,7 @@ enum {
     K230_DEV_SPI,
     K230_DEV_HI_SYS_CFG,
     K230_DEV_DDRC_CFG,
+    K230_DEV_DDR_PHY,
     K230_DEV_FLASH,
     K230_DEV_PLIC,
     K230_DEV_CLINT,
-- 
2.53.0


