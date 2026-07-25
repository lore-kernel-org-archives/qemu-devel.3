Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD5DC531F9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 12:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnbiB-0001i2-Co; Sat, 25 Jul 2026 08:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnbi9-0001gv-Op
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:42:37 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnbi7-0003g6-8e
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:42:37 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-5bf959b820cso816940e0c.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784983354; x=1785588154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xzTrwt+CYtUDeTugoSkgG6+9Bi2XZhlh3ec515Ut764=;
 b=MSAhZU4EOpGg6VWybptKoJu0BamkQEUjUUFzexQN71B2Lalhib10CZw7hwA1PxKcLK
 2UTXoQHalz5FjZ9E/ANUFeRRpyIT+wfBjEKljthAS8KCmdwS90cA8D+avKzBDqDR8MML
 HrAFWjjWjLn97RId77bHwGUMsW5gDsvoh+UCj4pnErZ+cggL7FMCoia6zNgLMZgwzA6P
 JrT2zPegMyDEZ7eG/IHcxH6umc63QKySY7snrXH30rZ7u0oJBv0n1JbiUHTwGtJkbSs+
 1ZXNM+fmPMNskeJrxvsPGaVeYunw6VAtTKOCP/JBgGIhitfZfDO3itsvf+mMY39uEKs/
 r8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784983354; x=1785588154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xzTrwt+CYtUDeTugoSkgG6+9Bi2XZhlh3ec515Ut764=;
 b=OhYX6QEEsq00vrJSEisiLRxeMhdLEl6g9aqrONXKMR+t+nCqXu74kZuVFcOK7986gZ
 oi+XarltjiNtljFMxxl4LHi7qNxZ2Kom2zY8Z28nFQPCMAiIJG5CsiU2hHS5xWI4L3Nv
 Gu08qqERGYkZZkRlCJ+viAbjQysgp6cOt+a81KQqrjyzgdb8ztUbkzUD1/pL758TG1xo
 hHzZkkUiE/HWptvgB9bgb8MpK0qsnaFmQPs+y+BJR7ZTg4hYMFtoozs47AdOuhy2bidT
 7hp9BNKW8xgWrQTaHyXPTbu2v1y1KQUYwExEreJl5BOUBFcWrS0NBVEHBJFhDqFg6JgF
 7Zwg==
X-Gm-Message-State: AOJu0YyVi6iw1aPvRR0CRBcGklKrJShHnSv1a29n3kQ683QVr5tQBzm1
 mrgCZeq1KrsFyNjrlN+9uyJM35HMbsPSFm8yNrT35Sf7WeZSI0xcCeX/GCEEoj1S
X-Gm-Gg: AR+sD1201PQnIq4BRpdA+7PBW0xIvQH7x/3ZxD4s4WMx/dzQU7/HYSRwrB+5J7UdY++
 YlXHul7Uqz+lySjLslIiYa9CjifnlzmdgF1nqbEy7/cmHGc8WSqafn7oV4ms48uXSHKtbVJkaHE
 dUlGaRoLmU7Cu7UteaH2RcCL8T+oFQ4bMrxm5ipC0yFyhyk7oSc/AXupLXEhRKp9eG/pyFakkNj
 2AiFcWCIKFcYaEsu73fc+sR74qNQk4E5GkEcCNgXxkjVwjEYGFNSo/tYfnRWcvUmtnlHKQzy22Z
 fNt0syNRkYUfI3EJb4EW3dIOrozjseaI+72c/LHc9gQIaHM3T/KayKBzI6IxQjwYCruCl014lZp
 +LuAmhWL0fQYUORQ+OclF6AfmofExyeYJu9bp0KeVCiuiBdLaapQ6CztZKf+7Gz4crOK7ubh7OW
 5K7MKegzPEGWlJfqMUEfABG+Tb16BobbVfP0GsGcieIH4=
X-Received: by 2002:a05:6122:4889:b0:59b:396b:cea7 with SMTP id
 71dfb90a1353d-5c306d21176mr1170596e0c.9.1784983353880; 
 Sat, 25 Jul 2026 05:42:33 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c305734410sm1457106e0c.16.2026.07.25.05.42.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jul 2026 05:42:33 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/2] hw/arm/bcm2838_pcie: make PCI device enumeration actually
 work
Date: Sat, 25 Jul 2026 08:42:30 -0400
Message-ID: <20260725124231.86233-2-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725124231.86233-1-marcelomanzo@gmail.com>
References: <20260725124231.86233-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

raspi4b's PCIe root complex brought the link up but no device was ever
enumerated: "lspci" was empty and /sys/bus/pci/devices/ had no entries.
Nothing exercised this before, since GENET is a sysbus device rather
than a PCI one.

Four separate defects, all on the same path:

1. bcm2838_pcie_host_read/write computed
   "offset - PCIE_CONFIG_SPACE_SIZE" on an unsigned hwaddr, which
   underflows for every offset below 4KB. The root port's own config
   space -- including vendor/device ID at offset 0 -- therefore always
   fell into the out-of-range branch and read back as all-ones, i.e.
   "no device present", so the guest stopped scanning immediately.

2. pcie_host_mmcfg_init() was never called, yet both accessors
   dereference pcie_hb->mmio.ops to service EXT_CFG_DATA. Once (1) was
   fixed and the guest actually reached that path, it touched an
   uninitialised MemoryRegion.

3. The root port overrode PCIDeviceClass::config_read/config_write with
   plain pci_default_*_config(). That bypasses rp_write_config() ->
   pci_bridge_write_config(), so programming the bridge's memory window
   never updated the bridge's address space and BARs behind the root
   port stayed unreachable. Drop the overrides and dispatch through
   pci_host_config_{read,write}_common() so the device's real handlers
   run.

4. The PCI MMIO window was mapped at the ARM base address with no
   address translation, even though PCIE_MMIO_OFFSET was defined for
   exactly that purpose (and otherwise unused). The DTB declares CPU
   0x600000000 as mapping to PCI 0xc0000000, so the guest was reading
   PCI address 0 where it expected a device BAR. Map an alias at the
   correct PCI offset instead.

With these, a PCIe device is enumerated and its driver binds:

  xhci_hcd 0000:01:00.0: xHCI Host Controller
  xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
  xhci_hcd 0000:01:00.0: Host supports USB 3.0 SuperSpeed

Note this is not yet complete: devices attached behind the xHCI are
still not enumerated by the guest, which looks like a separate
interrupt-delivery problem rather than an enumeration one.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 docs/system/arm/raspi.rst            |  2 ++
 hw/arm/bcm2838_pcie.c                | 45 +++++++++++++++++-----------
 hw/arm/bcm2838_peripherals.c         | 16 ++++++++--
 include/hw/arm/bcm2838_peripherals.h |  1 +
 4 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index a4f83d0a..a8fc37e9 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -43,3 +43,5 @@ Missing devices
 ---------------
 
  * Pulse Width Modulation (PWM)
+ * PCIe MSI/MSI-X interrupt delivery (raspi4b) -- INTx works; a PCIe
+   device that only signals via MSI/MSI-X needs ``msi=off,msix=off``
diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
index 1596145b..88166d1f 100644
--- a/hw/arm/bcm2838_pcie.c
+++ b/hw/arm/bcm2838_pcie.c
@@ -11,24 +11,13 @@
 #include "qapi/error.h"
 #include "hw/core/irq.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/pci/pci_host.h"
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/arm/bcm2838_pcie.h"
 #include "trace.h"
 
-static uint32_t bcm2838_pcie_config_read(PCIDevice *d,
-                                         uint32_t address, int len)
-{
-    return pci_default_read_config(d, address, len);
-}
-
-static void bcm2838_pcie_config_write(PCIDevice *d, uint32_t addr, uint32_t val,
-                                      int len)
-{
-    return pci_default_write_config(d, addr, val, len);
-}
-
 static uint64_t bcm2838_pcie_host_read(void *opaque, hwaddr offset,
                                        unsigned size) {
     hwaddr mmcfg_addr;
@@ -39,7 +28,18 @@ static uint64_t bcm2838_pcie_host_read(void *opaque, hwaddr offset,
     uint32_t *cfg_idx = (uint32_t *)(root_regs + BCM2838_PCIE_EXT_CFG_INDEX
                                      - PCIE_CONFIG_SPACE_SIZE);
 
-    if (offset - PCIE_CONFIG_SPACE_SIZE + size <= sizeof(s->root_port.regs)) {
+    if (offset < PCIE_CONFIG_SPACE_SIZE) {
+        /*
+         * The first 4KB of the window is the root port's own PCI config
+         * space (vendor/device ID, BARs, capabilities). Serve it from the
+         * real PCIDevice, not from the raw regs[] shadow buffer, which is
+         * only backing store for the controller registers above 4KB.
+         */
+        value = pci_host_config_read_common(PCI_DEVICE(&s->root_port),
+                                            offset, PCIE_CONFIG_SPACE_SIZE,
+                                            size);
+    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
+               <= sizeof(s->root_port.regs)) {
         switch (offset) {
         case BCM2838_PCIE_EXT_CFG_DATA
             ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
@@ -72,7 +72,12 @@ static void bcm2838_pcie_host_write(void *opaque, hwaddr offset,
 
     trace_bcm2838_pcie_host_write(size, offset, value);
 
-    if (offset - PCIE_CONFIG_SPACE_SIZE + size <= sizeof(s->root_port.regs)) {
+    if (offset < PCIE_CONFIG_SPACE_SIZE) {
+        /* Root port's own PCI config space -- see read path above */
+        pci_host_config_write_common(PCI_DEVICE(&s->root_port), offset,
+                                     PCIE_CONFIG_SPACE_SIZE, value, size);
+    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
+               <= sizeof(s->root_port.regs)) {
         switch (offset) {
         case BCM2838_PCIE_EXT_CFG_DATA
             ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
@@ -137,9 +142,18 @@ static void bcm2838_pcie_host_realize(DeviceState *dev, Error **errp)
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
     BCM2838PcieHostState *s = BCM2838_PCIE_HOST(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
 
     int i;
 
+    /*
+     * Initialise the ECAM config-space window. The BCM2838 does not expose
+     * it to the guest directly; config accesses are made indirectly through
+     * the EXT_CFG_INDEX/EXT_CFG_DATA register pair, which dispatch into
+     * pex->mmio. Without this the ops pointer is never set up.
+     */
+    pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
+
     memory_region_init_io(&s->cfg_regs, OBJECT(s), &bcm2838_pcie_host_ops, s,
                           "bcm2838_pcie_cfg_regs", BCM2838_PCIE_REGS_SIZE);
     sysbus_init_mmio(sbd, &s->cfg_regs);
@@ -273,9 +287,6 @@ static void bcm2838_pcie_root_class_init(ObjectClass *class, const void *data)
     k->device_id = BCM2838_PCIE_DEVICE_ID;
     k->revision = BCM2838_PCIE_REVISION;
 
-    k->config_read = bcm2838_pcie_config_read;
-    k->config_write = bcm2838_pcie_config_write;
-
     rpc->exp_offset = BCM2838_PCIE_EXP_CAP_OFFSET;
     rpc->aer_offset = BCM2838_PCIE_AER_CAP_OFFSET;
 }
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index de49f48b..012a4567 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -204,10 +204,22 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     /* RC registers region */
     regs_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie_host), 0);
     memory_region_add_subregion(&s->peri_low_mr, PCIE_RC_OFFSET, regs_mr);
-    /* MMIO region */
+    /*
+     * MMIO region.
+     *
+     * The BCM2711 PCIe controller translates addresses between the ARM and
+     * PCI address spaces: the DTB declares CPU 0x600000000 as mapping to PCI
+     * 0xc0000000. Map an alias of the PCI window starting at that PCI offset
+     * so accesses land on the right addresses; mapping the window directly
+     * would expose PCI address 0 at the ARM base instead, and every BAR
+     * behind the root port would be read at the wrong address.
+     */
     mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie_host), 1);
+    memory_region_init_alias(&s->pcie_mmio_alias, OBJECT(s),
+                             "bcm2838_pcie_mmio_alias", mmio_mr,
+                             PCIE_MMIO_OFFSET, PCIE_MMIO_SIZE);
     memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
-                                mmio_mr);
+                                &s->pcie_mmio_alias);
 
     /* Gigabit Ethernet */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->genet), errp)) {
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 5da340f2..c05709f4 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -70,6 +70,7 @@ struct BCM2838PeripheralState {
 
     SDHCIState emmc2;
     BCM2838PcieHostState pcie_host;
+    MemoryRegion pcie_mmio_alias;
     BCM2838GenetState genet;
     BCM2838GpioState gpio;
 
-- 
2.47.1


