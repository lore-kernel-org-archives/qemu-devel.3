Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF57CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuI6-0000tv-95; Tue, 12 May 2026 17:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuHF-0005uo-Qh; Tue, 12 May 2026 17:04:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuHD-0000HW-VQ; Tue, 12 May 2026 17:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619279; bh=nhWXsxNrPYLu3VKB1DCONPNIdY0rFdWqzYGRO6zAFTM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OVYU2hBFHpYzeGkzPEoa+B3VTT1uirwr7TsmXni3jdJ7j+G9SpdTWBvgp3m0WZadx
 ebLTW2WPFsbb0j5URQqy+i3I34oqEri89vHSHsYuAiolJSl9zCL6MN2/7ggE5IZbxo
 ZMJslPSg/t9+FLqi4gEVkzliDa85Xq/V0ymNtjbJFMfYX9wv6jY+2E++zkM7mtHYwJ
 GUYjcyjfb+YhihI1LpdN0U+VGTJbXm1maL6/k6SQB5zmeCP8phuKozTJxny00M53MC
 tL+jhPh3BtTdIu05B5pEC84NGgonHpdzPP0QtdS4u8Rrmp/efdpC7fNnqnP/GRXAfp
 UOCFPGGYfVOZQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AD8461AA32C;
 Tue, 12 May 2026 23:54:39 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B99853ABC9D;
 Tue, 12 May 2026 23:54:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vivien LEGER <vivien.leger@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 096/107] hw/ppc/e500: fix bus-frequency property
 hardcoded to zero in CPU FDT node
Date: Tue, 12 May 2026 23:54:23 +0300
Message-ID: <20260512205437.360850-96-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Vivien LEGER <vivien.leger@gmail.com>

The bus-frequency property in the CPU FDT node was hardcoded to 0.
This is incorrect - it should reflect the actual platform bus clock
frequency, as firmware and RTOSes use it to derive peripheral clock
rates.

Notably, the RTEMS QorIQ BSP uses bus-frequency to program the MPIC
global timer interval. With bus-frequency=0, the timer interval
overflows to ~85 seconds, preventing any clock interrupts from firing.

Fix by adding a bus_freq field to PPCE500MachineClass and using it in
the FDT generator. Set bus_freq = PLATFORM_CLK_FREQ_HZ (400MHz) for
existing machines, matching the existing clock_freq value.

Signed-off-by: Vivien LEGER <vivien.leger@gmail.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20260411154535.1451361-1-vivien.leger@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 774e6f5c1533aba9e04f95cb8cfba64d8329fcb0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index de99c9381f..7fb0bbebee 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -516,7 +516,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
                               env->icache_line_size);
         qemu_fdt_setprop_cell(fdt, cpu_name, "d-cache-size", 0x8000);
         qemu_fdt_setprop_cell(fdt, cpu_name, "i-cache-size", 0x8000);
-        qemu_fdt_setprop_cell(fdt, cpu_name, "bus-frequency", 0);
+        qemu_fdt_setprop_cell(fdt, cpu_name, "bus-frequency", pmc->bus_freq);
         if (cpu->cpu_index) {
             qemu_fdt_setprop_string(fdt, cpu_name, "status", "disabled");
             qemu_fdt_setprop_string(fdt, cpu_name, "enable-method",
diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 00f490519c..858684d569 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -40,6 +40,7 @@ struct PPCE500MachineClass {
     hwaddr pci_mmio_bus_base;
     hwaddr spin_base;
     uint32_t clock_freq;
+    uint32_t bus_freq;
     uint32_t tb_freq;
 };
 
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index a68a54db9e..1fff5b55d0 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -94,6 +94,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     pmc->pci_mmio_bus_base = 0xE0000000ULL;
     pmc->spin_base = 0xFEF000000ULL;
     pmc->clock_freq = PLATFORM_CLK_FREQ_HZ;
+    pmc->bus_freq = PLATFORM_CLK_FREQ_HZ;
     pmc->tb_freq = PLATFORM_CLK_FREQ_HZ;
 
     mc->desc = "generic paravirt e500 platform";
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index fa891d5c6c..c0a1075625 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -56,6 +56,7 @@ static void mpc8544ds_machine_class_init(ObjectClass *oc, void *data)
     pmc->pci_pio_base = 0xE1000000ULL;
     pmc->spin_base = 0xEF000000ULL;
     pmc->clock_freq = PLATFORM_CLK_FREQ_HZ;
+    pmc->bus_freq = PLATFORM_CLK_FREQ_HZ;
     pmc->tb_freq = PLATFORM_CLK_FREQ_HZ;
 
     mc->desc = "mpc8544ds";
-- 
2.47.3


