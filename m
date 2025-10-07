Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297D7CCD185
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68QB-0005ha-5e; Tue, 07 Oct 2025 10:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q7-0005h7-Rp
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pr-00029V-62
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e5b7dfeb0so26503885e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846302; x=1760451102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uxx9llzrYAXu4PL3iBc8DDk4Zz01Rox6Q/tm+iOvDsM=;
 b=eOIM+udxHxpmtvfh+jAVsCygiFW1iolzmzuVyd63Fl3h0M4lRzwCQDr4H3GWXZtD30
 H+pju1IfmM/mJv0IXBvWovaJJU1NsNCZxrokkdr+s6N0EfPNDWQbAYR73MtemvcVXsk3
 bITbWOVjVUAUX6g5Wq5XfSeSbo2ZHYeieqpmRgcSvVIHSUX8dcMcQsUuH2q9noF+/yuQ
 mT0i/vKc8RCPC3Qqjgj7JsVI9o5Ht/BuOkfq5N7h/cF4CjWbTg6RRzxInhrPaCjJRgok
 EUjLon5+QOlR0IqkPKzylpKS9SOOzTK83ZeQXlBMNmUQbb4FxLKhHC6ZHjUTuBXkiu4b
 YyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846302; x=1760451102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uxx9llzrYAXu4PL3iBc8DDk4Zz01Rox6Q/tm+iOvDsM=;
 b=qldNLmT07lFvheh6zNuJl+UqFeP8rqQt9KK3tVp1Y0ckYwZCAq2b5LsEPF/pQr6zVT
 1y/5a84xF26E+vUwn/4JvsNQ1fixFejN90XHlvNNIj1vIM3jQ42O94uxwI4CRuE94tHh
 JqbKR4X1Ko2srDOWjb1H8jzWaZi1v1m1IF++TcbtSZRF+b/NJATS9maLlPs2t8xvK+3u
 o0jYm3wX33L7XbsFCuQYlLuKjtFf4x2Dkt1OBvJN5JrVNSEWSr1M3lR+sk1x5VfoR4u6
 N7PpVO92seOfXHj+acPul0zkqoJxphBb0xqup+a4qpLZ+A5F/RHBl8MEtZ6++0aTJbb0
 Wp+A==
X-Gm-Message-State: AOJu0Yz/XJ/OUwuCCA4l9/w9QYj0JdLGYOudNb47Y3BT61IfzTt5xR/f
 AiIcLIPubXt64qDJm4sTDx+khiuuHT0OsHzyIEMRm60FhAYeeeyL0TzGgjRd6vpJkIHkRHXmU3e
 4Diuf
X-Gm-Gg: ASbGncsu/nY8LvWQZ214RCDX9x3ZRINxAjfYoLxK5757wpTBP58RsE4x8XHuaImcrnz
 CKiTWYpLP9IciNLZv5PwNv8j4KPEsltgE4e0CdiuIyY1f3n2HRaLYNHBS1fJrsc1c58dynSD6tp
 Odr8Ns3vbkRoM0MFpm5emSrvo1B3OBMLsPxXi88z/IBbw+NtgclZKXLSpPOyq6FJ5paixHg3gNL
 9718XWF47DlLLoaa12jovDdyJWBQ2HJ6XKVV8RPAbjRQws9BDV7bVmQAf1e1CWmj5dz4F0aJdBE
 3d18PlhFcuWb/qSdcVUeNIkuZxD9Eh2pg/zG8qkMnGdnHu4fQa46B/IUZitoGIwzx2dha5nxkyh
 wdehCiZHEzeHYdcK4qw+qyQAvkxBvYHh30dCxTym6/c0XT95c+SuUJ15y
X-Google-Smtp-Source: AGHT+IHewImlb+C9ghtDCZkfvd9EQn7ck6AM7PDm8zQGlHbn3Th14I3/g6IIIAbGzy4rmKXbqHmJsQ==
X-Received: by 2002:a05:600c:8b22:b0:45b:4a98:91cf with SMTP id
 5b1f17b1804b1-46e71102657mr124266585e9.15.1759846301909; 
 Tue, 07 Oct 2025 07:11:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/62] hw/arm/xlnx-versal: bbram: refactor creation
Date: Tue,  7 Oct 2025 15:10:35 +0100
Message-ID: <20251007141123.3239867-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Luc Michel <luc.michel@amd.com>

Refactor the BBRAM device creation using the VersalMap structure.

Note that the corresponding FDT node is removed. It does not correspond
to any real node in standard Versal DTBs. No matching drivers exist for
it.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-15-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  3 +--
 hw/arm/xlnx-versal-virt.c    | 27 +++---------------------
 hw/arm/xlnx-versal.c         | 41 +++++++++++++++++++++++++-----------
 3 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 78442e6c2c5..9adce02f8a9 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -19,7 +19,6 @@
 #include "hw/intc/arm_gicv3.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
-#include "hw/nvram/xlnx-bbram.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-trng.h"
 #include "net/can_emu.h"
@@ -85,7 +84,6 @@ struct Versal {
     struct {
         XlnxZynqMPRTC rtc;
         XlnxVersalTRng trng;
-        XlnxBBRam bbram;
         XlnxVersalCFUAPB cfu_apb;
         XlnxVersalCFUFDRO cfu_fdro;
         XlnxVersalCFUSFR cfu_sfr;
@@ -121,6 +119,7 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
 
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
 void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
+void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
 void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                               BlockBackend *blk);
 
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index a948e24aea0..f766a3e1027 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -172,26 +172,6 @@ static void fdt_add_rtc_node(VersalVirt *s)
     g_free(name);
 }
 
-static void fdt_add_bbram_node(VersalVirt *s)
-{
-    const char compat[] = TYPE_XLNX_BBRAM;
-    const char interrupt_names[] = "bbram-error";
-    char *name = g_strdup_printf("/bbram@%x", MM_PMC_BBRAM_CTRL);
-
-    qemu_fdt_add_subnode(s->fdt, name);
-
-    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_PMC_APB_IRQ,
-                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
-                     interrupt_names, sizeof(interrupt_names));
-    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                 2, MM_PMC_BBRAM_CTRL,
-                                 2, MM_PMC_BBRAM_CTRL_SIZE);
-    qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
-    g_free(name);
-}
-
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
@@ -346,7 +326,7 @@ static void create_virtio_regions(VersalVirt *s)
     }
 }
 
-static void bbram_attach_drive(XlnxBBRam *dev)
+static void bbram_attach_drive(VersalVirt *s)
 {
     DriveInfo *dinfo;
     BlockBackend *blk;
@@ -354,7 +334,7 @@ static void bbram_attach_drive(XlnxBBRam *dev)
     dinfo = drive_get_by_index(IF_PFLASH, 0);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     if (blk) {
-        qdev_prop_set_drive(DEVICE(dev), "drive", blk);
+        versal_bbram_attach_drive(&s->soc, blk);
     }
 }
 
@@ -447,7 +427,6 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_rtc_node(s);
-    fdt_add_bbram_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
@@ -458,7 +437,7 @@ static void versal_virt_init(MachineState *machine)
                                         0, &s->soc.fpd.apu.mr, 0);
 
     /* Attach bbram backend, if given */
-    bbram_attach_drive(&s->soc.pmc.bbram);
+    bbram_attach_drive(s);
 
     /* Attach efuse backend, if given */
     efuse_attach_drive(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index e71c774e72e..31ceaf61bed 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -36,6 +36,7 @@
 #include "hw/nvram/xlnx-versal-efuse.h"
 #include "hw/ssi/xlnx-versal-ospi.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
+#include "hw/nvram/xlnx-bbram.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -119,6 +120,7 @@ typedef struct VersalMap {
     } ospi;
 
     VersalSimplePeriphMap pmc_iou_slcr;
+    VersalSimplePeriphMap bbram;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
@@ -161,6 +163,7 @@ static const VersalMap VERSAL_MAP = {
     },
 
     .pmc_iou_slcr = { 0xf1060000, OR_IRQ(121, 0) },
+    .bbram = { 0xf11f0000, OR_IRQ(121, 1) },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
@@ -820,22 +823,21 @@ static void versal_create_xrams(Versal *s, const struct VersalXramMap *map)
     }
 }
 
-static void versal_create_bbram(Versal *s, qemu_irq *pic)
+static void versal_create_bbram(Versal *s,
+                                const VersalSimplePeriphMap *map)
 {
+    DeviceState *dev;
     SysBusDevice *sbd;
 
-    object_initialize_child_with_props(OBJECT(s), "bbram", &s->pmc.bbram,
-                                       sizeof(s->pmc.bbram), TYPE_XLNX_BBRAM,
-                                       &error_fatal,
-                                       "crc-zpads", "0",
-                                       NULL);
-    sbd = SYS_BUS_DEVICE(&s->pmc.bbram);
+    dev = qdev_new(TYPE_XLNX_BBRAM);
+    sbd = SYS_BUS_DEVICE(dev);
 
-    sysbus_realize(sbd, &error_fatal);
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_BBRAM_CTRL,
+    object_property_add_child(OBJECT(s), "bbram", OBJECT(dev));
+    qdev_prop_set_uint32(dev, "crc-zpads", 0);
+    sysbus_realize_and_unref(sbd, &error_abort);
+    memory_region_add_subregion(&s->mr_ps, map->addr,
                                 sysbus_mmio_get_region(sbd, 0));
-    sysbus_connect_irq(sbd, 0,
-                       qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 1));
+    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
 }
 
 static void versal_create_efuse(Versal *s,
@@ -1334,10 +1336,12 @@ static void versal_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out_named(slcr, "ospi-mux-sel", 0,
                                 qdev_get_gpio_in_named(ospi,
                                                        "ospi-mux-sel", 0));
+
+    versal_create_bbram(s, &map->bbram);
+
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
-    versal_create_bbram(s, pic);
     versal_create_crl(s, pic);
     versal_create_cfu(s, pic);
     versal_map_ddr(s);
@@ -1383,6 +1387,19 @@ void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
     qdev_prop_set_drive(efuse, "drive", blk);
 }
 
+void versal_bbram_attach_drive(Versal *s, BlockBackend *blk)
+{
+    DeviceState *bbram;
+
+    bbram = DEVICE(versal_get_child(s, "bbram"));
+
+    if (bbram == NULL) {
+        return;
+    }
+
+    qdev_prop_set_drive(bbram, "drive", blk);
+}
+
 void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                               BlockBackend *blk)
 {
-- 
2.43.0


