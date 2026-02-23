Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DDEEC1113
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZMq-0005g0-9g; Mon, 23 Feb 2026 12:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZLH-0002wu-4U
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZLB-0000TK-Dt
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48375f10628so29382615e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866203; x=1772471003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ki1+Cj7hzmWIdImuSXSQEFK5DhzyzVZGm0uIPL+3K2k=;
 b=oBQ1oAk7piCgStWUwtZLdLor84a6JCispFPajxKruT0+jTMTb5ueHdiJ3QT7Lvb5Vc
 PzhYl2T2lJtersU5SS3D6iDGaDxAmiFToJ5qscMad0kUNH366F0LC18bNuWmmeF/bW9C
 Fcy6TNiqrDpqD5JrAIwb/sEqY0qFItbJs2h4TUm8cd7BZiaywYtRSevJQgA09AzvM8FJ
 yY2wUV12k1QurZl1t0VjclETJOLEs7wwoUxfKW+2DPz91YAj7aT4k2nsqtikl+T6axkD
 qxDYwc/uSHjCdomZMj2HphQrtRv5y/tiYrerDWsBNDi9hGqLDWmKeOk95U23nIg4oIv1
 wCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866203; x=1772471003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ki1+Cj7hzmWIdImuSXSQEFK5DhzyzVZGm0uIPL+3K2k=;
 b=M1gOCkYBzFqtcdUPcBSG5YZVtSfGblrpYs0nZyhmAA0AO2qNPWlpPJjxWf0h3f+p0J
 eqkuXqQeZuZeH9RR0tb0F6vz2mG0m/5ivtOjfF2wT2V4xSAb28WhmLI4EbmKZverQehT
 7CT3HqAjeG1/3InUgUmh4xdgus0no186/cipMTpeaBitbLXPT1GgUnfl4Crnah0WS0de
 jVxf8/q+OiinHg7qkHMTKsfYgv+LjpdXyO/4w7RL0J5U6yc4/14JRB89iW/uuHLjswor
 rsHQ8ERJt1wWF+Lgk+Yb0ez34hvgCNi1+82QEAg+z938sAO2BrWN3v3D5O4fS3xUKsmQ
 7+BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhfrVucq/JBaSUdke7GJ6Ib4Vl9dF1/1etYZKm/jspjE1USeFc8XEmTFV3MGRggqIUX5gtT969SvEi@nongnu.org
X-Gm-Message-State: AOJu0YwkvnAa3JUsDXp7UpxFnRfj19q2inDGgksgJFL6ww1pdVefAZeq
 bO73juwNs1Wwf/oG4/HbPAg4eAcs4l0Zp7nVkXOFfA0ksg/3H8sfJxzbs9gXdnSmj1o=
X-Gm-Gg: AZuq6aIxZ/sTRNMxX8dDuTmTBDwSNz7QMJ6kzx44rFuKDs+KxkPF66+l+6TAgpDmB2X
 NRNM2RGSXKbCN+rYYklOPnWqRfKmMkOLqipCuvGlTOMpz59vd2MMSBpdMb23/yXH16JUy9YYvgs
 OIlmpLswX7aoMaDLi9EUk7RDNmznV1DmjrWf6WAPJHJZZ81+Isw/eTvWSbxJxx6nmufYikzsx/z
 PdbQICmNfT67pw25uP6p3l0YSH0+5AgnHRWBXjcyGZ8qQ0VMRyEOP/LpdnDv6oZjqfKnUGcT7ry
 BhumXWC6aRSGtFg5fO6a4tknI5KQziK4JUgZqcyy/5ZHP9p6QVwk7CWTdpmMRAuv46gPQDMWNeP
 8WCwUsx8HG1TcSS9yQJcQqeZhIVpiw0A5ARfs5cEj145cUIMG99VCHQWtzr/KLIwS9Gm2b+GHQm
 fdzKm5lH23bJI9kZLAtUFdvGULvYEIk1Mo3iUxlMU6v6Jnt0HcAA8GEWBY5xpr62uqipgeZvZp0
 PxOPaN9KxeoOWcb0LsWHr7MOARJHe0=
X-Received: by 2002:a05:600d:644d:20b0:47e:e7e5:ff32 with SMTP id
 5b1f17b1804b1-483a9605b19mr105039875e9.34.1771866203286; 
 Mon, 23 Feb 2026 09:03:23 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 63/65] hw/arm/virt: Use correct interrupt type for GICv5 SPIs
 in the DTB
Date: Mon, 23 Feb 2026 17:02:10 +0000
Message-ID: <20260223170212.441276-64-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The GICv5 devicetree binding specifies that the "interrupts" property
for devices connected to it should use the architectural INTID.TYPE
values to specify whether the interrupt is an SPI, LPI or PPI.  This
is different to the GICv2 and GICv3, so instead of hardcoding the
GIC_FDT_IRQ_TYPE_SPI constant when we create "interrupts" bindings,
create a new function gic_fdt_irq_type_spi() that returns the right
value for the interrupt controller in use.

For SPIs, the INTID.ID and the trigger-mode fields of the
"interrupts" property remain the same for GICv5 and the older GIC
versions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 05c92e8482..1b63338196 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -296,6 +296,16 @@ static bool ns_el2_virt_timer_present(void)
         arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
 }
 
+/*
+ * The correct value to use in a DTB "interrupts" property for an SPI
+ * depends on the GIC version.
+ */
+static int gic_fdt_irq_type_spi(const VirtMachineState *vms)
+{
+    return vms->gic_version == VIRT_GIC_VERSION_5 ?
+        GICV5_SPI : GIC_FDT_IRQ_TYPE_SPI;
+}
+
 static void create_fdt(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -1185,7 +1195,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                      2, base, 2, size);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               gic_fdt_irq_type_spi(vms), irq,
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "clocks",
                                vms->clock_phandle, vms->clock_phandle);
@@ -1227,7 +1237,7 @@ static void create_rtc(const VirtMachineState *vms)
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, base, 2, size);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                           GIC_FDT_IRQ_TYPE_SPI, irq,
+                           gic_fdt_irq_type_spi(vms), irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
     qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
@@ -1346,7 +1356,7 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
     qemu_fdt_setprop_cell(ms->fdt, nodename, "#gpio-cells", 2);
     qemu_fdt_setprop(ms->fdt, nodename, "gpio-controller", NULL, 0);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                           GIC_FDT_IRQ_TYPE_SPI, irq,
+                           gic_fdt_irq_type_spi(vms), irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
     qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
@@ -1427,7 +1437,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
         qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                      2, base, 2, size);
         qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               gic_fdt_irq_type_spi(vms), irq,
                                GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
         qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
         g_free(nodename);
@@ -1627,10 +1637,11 @@ static void create_pcie_irq_map(const MachineState *ms,
     int devfn, pin;
     uint32_t full_irq_map[4 * 4 * 10] = { 0 };
     uint32_t *irq_map = full_irq_map;
+    const VirtMachineState *vms = VIRT_MACHINE(ms);
 
     for (devfn = 0; devfn <= 0x18; devfn += 0x8) {
         for (pin = 0; pin < 4; pin++) {
-            int irq_type = GIC_FDT_IRQ_TYPE_SPI;
+            int irq_type = gic_fdt_irq_type_spi(vms);
             int irq_nr = first_irq + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
             int irq_level = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
             int i;
@@ -1671,10 +1682,10 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
     qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg", 2, base, 2, size);
 
     qemu_fdt_setprop_cells(ms->fdt, node, "interrupts",
-            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+            gic_fdt_irq_type_spi(vms), irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            gic_fdt_irq_type_spi(vms), irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            gic_fdt_irq_type_spi(vms), irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            gic_fdt_irq_type_spi(vms), irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
 
     qemu_fdt_setprop(ms->fdt, node, "interrupt-names", irq_names,
                      sizeof(irq_names));
-- 
2.43.0


